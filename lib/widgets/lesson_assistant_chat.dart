import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../services/ai_service.dart';
import 'math_markdown.dart';

enum MessageSender { user, assistant, system }

class ChatMessage {
  final MessageSender sender;
  String text;
  final Uint8List? audioBytes;
  bool isStreaming;

  ChatMessage({
    required this.sender,
    required this.text,
    this.audioBytes,
    this.isStreaming = false,
  });

  bool get isSystem => sender == MessageSender.system;
}

class LessonAssistantChat extends StatefulWidget {
  final Book book;
  final int modIdx;
  final int secIdx;
  final Slide currentSlide;
  final String sectionNotes;

  const LessonAssistantChat({
    super.key,
    required this.book,
    required this.modIdx,
    required this.secIdx,
    required this.currentSlide,
    required this.sectionNotes,
  });

  @override
  State<LessonAssistantChat> createState() => _LessonAssistantChatState();
}

class _LessonAssistantChatState extends State<LessonAssistantChat> with SingleTickerProviderStateMixin {
  WebSocket? _webSocket;
  bool _isConnected = false;
  bool _isConnecting = false;
  bool _isLiveMode = true;
  bool _isRecording = false;
  bool _voiceOutputEnabled = true;

  final List<ChatMessage> _messages = [];
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _currentLiveResponseText = "";
  List<int> _currentLiveResponseAudio = [];

  // Voice recording pulsing animation
  late AnimationController _pulsingController;

  String _customSystemPrompt = "";

  @override
  void initState() {
    super.initState();
    _pulsingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _initTts();
    _addSystemMessage("Connecting to Gemini Live...");
    _loadCustomPromptAndConnect();
  }

  Future<void> _loadCustomPromptAndConnect() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _customSystemPrompt = prefs.getString('custom_live_chat_prompt') ?? '';
    } catch (e) {
      print("Error loading custom prompt: $e");
    }
    _connectWebSocket();
  }

  @override
  void dispose() {
    _webSocket?.close();
    _recorder.dispose();
    _audioPlayer.dispose();
    if (kIsWeb || !Platform.isLinux) {
      _flutterTts.stop();
    }
    _textController.dispose();
    _scrollController.dispose();
    _pulsingController.dispose();
    super.dispose();
  }

  Future<void> _initTts() async {
    if (kIsWeb || Platform.isLinux) {
      print("TTS is not supported on Linux/Web by flutter_tts.");
      return;
    }
    try {
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setSpeechRate(0.55);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
    } catch (e) {
      print("TTS initialization error: $e");
    }
  }

  void _addSystemMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(sender: MessageSender.system, text: text));
    });
    _scrollToBottom();
  }

  Future<void> _connectWebSocket() async {
    if (_webSocket != null) return;
    setState(() {
      _isConnecting = true;
    });
    try {
      final apiKey = await AiService().getApiKey();
      final model = await AiService().getLiveModelName();
      if (apiKey.isEmpty) {
        throw Exception("Gemini API Key is missing. Please add one in Settings.");
      }
      
      final uri = Uri.parse(
        "wss://generativelanguage.googleapis.com/ws/google.ai.generativelanguage.v1alpha.GenerativeService.BidiGenerateContent?key=$apiKey",
      );
      
      _webSocket = await WebSocket.connect(uri.toString());
      
      setState(() {
        _isConnected = true;
        _isConnecting = false;
      });

      // Send setup config as first message
      final setupMsg = {
        "setup": {
          "model": "models/$model",
          "generation_config": {
            "response_modalities": _voiceOutputEnabled ? ["AUDIO"] : ["TEXT"],
            if (_voiceOutputEnabled) ...{
              "speech_config": {
                "voice_config": {
                  "prebuilt_voice_config": {
                    "voice_name": "Puck" 
                  }
                }
              }
            }
          },
          if (_voiceOutputEnabled) "output_audio_transcription": {},
          "system_instruction": {
            "parts": [
              {
                "text": "You are a helpful learning assistant for the course '${widget.book.title}'. "
                    "The student is currently viewing slide: '${widget.currentSlide.title}' with contents:\n${widget.currentSlide.content}\n\n"
                    "Below are the generated notes for the current section:\n\n${widget.sectionNotes}\n\n"
                    "Help the student understand the concepts. Answer their questions clearly, concisely, and format math/formulas using standard LaTeX (\$inline\$ and \$\$display\$\$). "
                    "CRITICAL: Keep your response short, direct, and conversational (at most 1-2 sentences by default). Do not write long explanations unless explicitly requested."
                    "${_customSystemPrompt.trim().isNotEmpty ? '\n\nADDITIONAL INSTRUCTIONS:\n$_customSystemPrompt' : ''}"
              }
            ]
          }
        }
      };
      
      _webSocket!.add(jsonEncode(setupMsg));
      _addSystemMessage("Connected to Gemini Live!");

      _webSocket!.listen(
        (data) {
          _handleWebSocketMessage(data);
        },
        onError: (err) {
          _handleWebSocketError(err);
        },
        onDone: () {
          _handleWebSocketClosed();
        },
      );
    } catch (e) {
      setState(() {
        _isConnecting = false;
        _isConnected = false;
        _webSocket = null;
      });
      _addSystemMessage("Live Connection failed: $e. Falling back to REST model.");
      setState(() {
        _isLiveMode = false;
      });
    }
  }

  void _handleWebSocketMessage(dynamic data) {
    try {
      print("WebSocket received data type: ${data.runtimeType}");
      String jsonStr;
      if (data is String) {
        jsonStr = data;
      } else if (data is List<int>) {
        jsonStr = utf8.decode(data);
      } else {
        throw Exception("Unknown websocket data type: ${data.runtimeType}");
      }
      print("WebSocket received JSON: $jsonStr");
      final json = jsonDecode(jsonStr);

      // Check for setup complete
      final setupComplete = json['setupComplete'] ?? json['setup_complete'];
      if (setupComplete != null) {
        print("WebSocket setup complete received: $setupComplete");
      }

      // 1. Extract transcript text if output_audio_transcription is at the top level
      final transcriptObj = json['outputTranscription'] ?? 
                          json['output_transcription'] ?? 
                          json['outputAudioTranscription'] ?? 
                          json['output_audio_transcription'];
      if (transcriptObj != null && transcriptObj['text'] != null) {
        final text = transcriptObj['text'].toString();
        setState(() {
          _currentLiveResponseText += text;
          if (_messages.isNotEmpty && _messages.last.sender == MessageSender.assistant && _messages.last.isStreaming) {
            _messages.last.text = _currentLiveResponseText;
          } else {
            _messages.add(ChatMessage(
              sender: MessageSender.assistant,
              text: _currentLiveResponseText,
              isStreaming: true,
            ));
          }
        });
        _scrollToBottom();
      }

      final serverContent = json['serverContent'] ?? json['server_content'];
      if (serverContent != null) {
        final content = serverContent;

        // 2. Extract transcript text if nested inside serverContent
        final nestedTranscriptObj = content['outputTranscription'] ?? 
                            content['output_transcription'] ?? 
                            content['outputAudioTranscription'] ?? 
                            content['output_audio_transcription'];
        if (nestedTranscriptObj != null && nestedTranscriptObj['text'] != null) {
          final text = nestedTranscriptObj['text'].toString();
          setState(() {
            _currentLiveResponseText += text;
            if (_messages.isNotEmpty && _messages.last.sender == MessageSender.assistant && _messages.last.isStreaming) {
              _messages.last.text = _currentLiveResponseText;
            } else {
              _messages.add(ChatMessage(
                sender: MessageSender.assistant,
                text: _currentLiveResponseText,
                isStreaming: true,
              ));
            }
          });
          _scrollToBottom();
        }

        final modelTurn = content['modelTurn'] ?? content['model_turn'];
        if (modelTurn != null && modelTurn['parts'] != null) {
          for (var part in modelTurn['parts']) {
            if (part['text'] != null) {
              final text = part['text'].toString();
              setState(() {
                _currentLiveResponseText += text;
                if (_messages.isNotEmpty && _messages.last.sender == MessageSender.assistant && _messages.last.isStreaming) {
                  _messages.last.text = _currentLiveResponseText;
                } else {
                  _messages.add(ChatMessage(
                    sender: MessageSender.assistant,
                    text: _currentLiveResponseText,
                    isStreaming: true,
                  ));
                }
              });
              _scrollToBottom();
            }
            final inlineData = part['inlineData'] ?? part['inline_data'];
            if (inlineData != null) {
              if (inlineData['data'] != null) {
                final audioBase64 = inlineData['data'].toString();
                final bytes = base64Decode(audioBase64);
                _currentLiveResponseAudio.addAll(bytes);
              }
            }
          }
        }
        final turnComplete = content['turnComplete'] ?? content['turn_complete'];
        if (turnComplete == true) {
          setState(() {
            if (_messages.isNotEmpty && _messages.last.isStreaming) {
              _messages.last.isStreaming = false;
            }
          });
          if (_currentLiveResponseAudio.isNotEmpty && _voiceOutputEnabled) {
            _playRawPcm(_currentLiveResponseAudio);
          }
          // Reset buffers
          _currentLiveResponseText = "";
          _currentLiveResponseAudio = [];
        }
      }
    } catch (e, stackTrace) {
      print("WebSocket parse error: $e");
      print("Stack trace:\n$stackTrace");
    }
  }

  void _handleWebSocketError(dynamic err) {
    _addSystemMessage("Live connection error: $err");
    _disconnectWebSocket();
  }

  void _handleWebSocketClosed() {
    final code = _webSocket?.closeCode;
    final reason = _webSocket?.closeReason;
    String details = "";
    if (code != null) details += " (Code: $code";
    if (reason != null && reason.isNotEmpty) details += ", Reason: $reason";
    if (details.isNotEmpty) details += ")";
    _addSystemMessage("Live connection closed$details.");
    _disconnectWebSocket();
  }

  void _disconnectWebSocket() {
    _webSocket?.close();
    _webSocket = null;
    setState(() {
      _isConnected = false;
      _isConnecting = false;
    });
  }

  Uint8List _addWavHeader(List<int> pcmBytes, int sampleRate) {
    final int totalDataLen = pcmBytes.length;
    final int totalAudioLen = totalDataLen + 36;
    final int byteRate = sampleRate * 2; // 16-bit mono = 2 bytes per sample

    final header = Uint8List(44);
    // RIFF
    header[0] = 0x52; // R
    header[1] = 0x49; // I
    header[2] = 0x46; // F
    header[3] = 0x46; // F
    header[4] = (totalAudioLen & 0xff);
    header[5] = ((totalAudioLen >> 8) & 0xff);
    header[6] = ((totalAudioLen >> 16) & 0xff);
    header[7] = ((totalAudioLen >> 24) & 0xff);
    
    // WAVE
    header[8] = 0x57; // W
    header[9] = 0x41; // A
    header[10] = 0x56; // V
    header[11] = 0x45; // E
    
    // fmt 
    header[12] = 0x66; // f
    header[13] = 0x6d; // m
    header[14] = 0x74; // t
    header[15] = 0x20; // 
    header[16] = 16;
    header[17] = 0;
    header[18] = 0;
    header[19] = 0;
    
    header[20] = 1; // PCM
    header[21] = 0;
    header[22] = 1; // Mono
    header[23] = 0;
    
    header[24] = (sampleRate & 0xff);
    header[25] = ((sampleRate >> 8) & 0xff);
    header[26] = ((sampleRate >> 16) & 0xff);
    header[27] = ((sampleRate >> 24) & 0xff);
    
    header[28] = (byteRate & 0xff);
    header[29] = ((byteRate >> 8) & 0xff);
    header[30] = ((byteRate >> 16) & 0xff);
    header[31] = ((byteRate >> 24) & 0xff);
    
    header[32] = 2; // Block align
    header[33] = 0;
    header[34] = 16; // Bits
    header[35] = 0;
    
    // data
    header[36] = 0x64; // d
    header[37] = 0x61; // a
    header[38] = 0x74; // t
    header[39] = 0x61; // a
    header[40] = (totalDataLen & 0xff);
    header[41] = ((totalDataLen >> 8) & 0xff);
    header[42] = ((totalDataLen >> 16) & 0xff);
    header[43] = ((totalDataLen >> 24) & 0xff);

    final completeWav = Uint8List(44 + totalDataLen);
    completeWav.setRange(0, 44, header);
    completeWav.setRange(44, 44 + totalDataLen, pcmBytes);
    return completeWav;
  }

  Future<void> _playRawPcm(List<int> pcmBytes) async {
    if (kIsWeb) {
      print("Raw PCM audio playback is not supported on web.");
      return;
    }
    try {
      final wavBytes = _addWavHeader(pcmBytes, 24000); // 24kHz output
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/assistant_reply.wav');
      await file.writeAsBytes(wavBytes);
      await _audioPlayer.play(DeviceFileSource(file.path));
    } catch (e) {
      print("Audio playback error: $e");
    }
  }

  Future<void> _startRecording() async {
    if (kIsWeb) {
      _addSystemMessage("Voice input is not supported on web.");
      return;
    }
    try {
      if (await _recorder.hasPermission()) {
        final dir = await getTemporaryDirectory();
        final path = '${dir.path}/user_speech.wav';
        await _recorder.start(
          const RecordConfig(
            encoder: AudioEncoder.wav,
            sampleRate: 16000,
            numChannels: 1,
          ),
          path: path,
        );
        setState(() {
          _isRecording = true;
        });
        _pulsingController.repeat(reverse: true);
      } else {
        _addSystemMessage("Microphone permission denied.");
      }
    } catch (e) {
      _addSystemMessage("Failed to start recording: $e");
    }
  }

  Future<void> _stopRecording() async {
    if (kIsWeb) return;
    try {
      final path = await _recorder.stop();
      setState(() {
        _isRecording = false;
      });
      _pulsingController.stop();
      if (path != null) {
        final file = File(path);
        final bytes = await file.readAsBytes();
        _sendVoiceMessage(bytes);
      }
    } catch (e) {
      _addSystemMessage("Failed to stop recording: $e");
    }
  }

  Future<void> _sendVoiceMessage(Uint8List voiceBytes) async {
    setState(() {
      _messages.add(ChatMessage(
        sender: MessageSender.user,
        text: "[Voice input]",
        audioBytes: voiceBytes,
      ));
    });
    _scrollToBottom();

    if (_isLiveMode && _webSocket != null) {
      // Send base64 audio over websocket turn
      final base64Audio = base64Encode(voiceBytes);
      final msg = {
        "client_content": {
          "turns": [
            {
              "role": "user",
              "parts": [
                {
                  "inline_data": {
                    "mime_type": "audio/wav",
                    "data": base64Audio
                  }
                }
              ]
            }
          ],
          "turn_complete": true
        }
      };
      _webSocket!.add(jsonEncode(msg));
    } else {
      // Fallback normal REST model
      await _sendNormalModelMessage("", voiceBytes);
    }
  }

  Future<void> _sendTextMessage(String text) async {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(
        sender: MessageSender.user,
        text: text,
      ));
    });
    _textController.clear();
    _scrollToBottom();

    if (_isLiveMode && _webSocket != null) {
      final msg = {
        "client_content": {
          "turns": [
            {
              "role": "user",
              "parts": [
                {
                  "text": text
                }
              ]
            }
          ],
          "turn_complete": true
        }
      };
      _webSocket!.add(jsonEncode(msg));
    } else {
      await _sendNormalModelMessage(text);
    }
  }

  Future<void> _sendNormalModelMessage(String text, [Uint8List? voiceBytes]) async {
    setState(() {
      _messages.add(ChatMessage(
        sender: MessageSender.assistant,
        text: "Thinking...",
        isStreaming: true,
      ));
    });
    _scrollToBottom();

    try {
      final apiKey = await AiService().getApiKey();
      final modelName = await AiService().getPrimaryTextModelName();
      if (apiKey.isEmpty) {
        throw Exception("Gemini API Key is missing. Please add one in Settings.");
      }

      final model = GenerativeModel(model: modelName, apiKey: apiKey);
      final List<Content> contents = [];

      // Add system prompt context as first user turn (REST does not have a setup socket, so we wrap it inside context)
      contents.add(Content.text(
        "You are a helpful learning assistant for the course '${widget.book.title}'. "
        "The student is currently viewing slide: '${widget.currentSlide.title}' with contents:\n${widget.currentSlide.content}\n\n"
        "Below are the generated notes for the current section:\n\n${widget.sectionNotes}\n\n"
        "Use this context to answer the student's questions. Always format math/formulas using standard LaTeX (\$inline\$ and \$\$display\$\$). "
        "CRITICAL: Keep your response short, direct, and conversational (at most 1-2 sentences by default). Do not write long explanations unless explicitly requested."
        "${_customSystemPrompt.trim().isNotEmpty ? '\n\nADDITIONAL INSTRUCTIONS:\n$_customSystemPrompt' : ''}"
      ));

      // Append recent chat history (last 8 messages)
      final historyStart = _messages.length > 8 ? _messages.length - 8 : 0;
      for (int i = historyStart; i < _messages.length - 1; i++) {
        final m = _messages[i];
        if (m.isSystem) continue;
        if (m.sender == MessageSender.user) {
          if (m.audioBytes != null) {
            contents.add(Content.multi([
              DataPart('audio/wav', m.audioBytes!),
              TextPart(m.text),
            ]));
          } else {
            contents.add(Content.text(m.text));
          }
        } else {
          contents.add(Content.model([TextPart(m.text)]));
        }
      }

      // Add current message
      if (voiceBytes != null) {
        contents.add(Content.multi([
          DataPart('audio/wav', voiceBytes),
          if (text.isNotEmpty) TextPart(text),
        ]));
      } else {
        contents.add(Content.text(text));
      }

      final response = await model.generateContent(contents);
      final reply = response.text ?? "No response was generated by the model.";

      setState(() {
        if (_messages.isNotEmpty && _messages.last.isStreaming) {
          _messages.removeLast();
        }
        _messages.add(ChatMessage(
          sender: MessageSender.assistant,
          text: reply,
        ));
      });
      _scrollToBottom();

      if (_voiceOutputEnabled && (kIsWeb || !Platform.isLinux)) {
        await _flutterTts.speak(reply);
      }
    } catch (e) {
      setState(() {
        if (_messages.isNotEmpty && _messages.last.isStreaming) {
          _messages.removeLast();
        }
      });
      _addSystemMessage("REST Model Error: $e");
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A), // Premium dark background
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar for Dragging
            const SizedBox(height: 12),
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),

            // Header Section with Switchers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isLiveMode
                                  ? (_isConnected
                                      ? AppTheme.duoGreen
                                      : (_isConnecting ? Colors.orange : AppTheme.duoRed))
                                  : AppTheme.duoBlue,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isLiveMode
                                ? (_isConnected
                                    ? "Live Chat Active"
                                    : (_isConnecting ? "Connecting Live..." : "Live Offline"))
                                : "Complex REST Model",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Study Helper (Slide: ${widget.currentSlide.title})",
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Model Switcher
                      IconButton(
                        icon: Icon(
                          _isLiveMode ? LucideIcons.radio : LucideIcons.bot,
                          color: _isLiveMode ? AppTheme.duoGreen : AppTheme.duoBlue,
                          size: 20,
                        ),
                        tooltip: _isLiveMode ? "Switch to REST Model" : "Switch to Live Model",
                        onPressed: () {
                          setState(() {
                            _isLiveMode = !_isLiveMode;
                          });
                          if (_isLiveMode) {
                            _addSystemMessage("Connecting to Live...");
                            _connectWebSocket();
                          } else {
                            _disconnectWebSocket();
                            _addSystemMessage("Switched to REST Model.");
                          }
                        },
                      ),
                      // Voice Output Toggle
                      IconButton(
                        icon: Icon(
                          _voiceOutputEnabled ? LucideIcons.volume2 : LucideIcons.volumeX,
                          color: _voiceOutputEnabled ? AppTheme.duoViolet : Colors.white38,
                          size: 20,
                        ),
                        tooltip: _voiceOutputEnabled ? "Mute Voice Output" : "Enable Voice Output",
                        onPressed: () {
                          setState(() {
                            _voiceOutputEnabled = !_voiceOutputEnabled;
                          });
                          if (_isLiveMode && _webSocket != null) {
                            // Reconnect to apply voice modality change
                            _disconnectWebSocket();
                            _connectWebSocket();
                          }
                          if (!_voiceOutputEnabled) {
                            if (kIsWeb || !Platform.isLinux) {
                              _flutterTts.stop();
                            }
                            _audioPlayer.stop();
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.x, color: Colors.white60, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white10, height: 24),

            // Message History Window
            Flexible(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 400),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _messages.isEmpty
                    ? const Center(
                        child: Text(
                          "Ask a question about this slide or lesson!",
                          style: TextStyle(color: Colors.white38, fontSize: 13),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _messages.length,
                        itemBuilder: (context, idx) {
                          final msg = _messages[idx];
                          if (msg.isSystem) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  msg.text,
                                  style: const TextStyle(
                                    color: Colors.white38,
                                    fontSize: 11,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            );
                          }

                          final isUser = msg.sender == MessageSender.user;
                          return Align(
                            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? AppTheme.duoBlue.withOpacity(0.15)
                                    : Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(16),
                                  topRight: const Radius.circular(16),
                                  bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(2),
                                  bottomRight: isUser ? const Radius.circular(2) : const Radius.circular(16),
                                ),
                                border: Border.all(
                                  color: isUser
                                      ? AppTheme.duoBlue.withOpacity(0.3)
                                      : Colors.white10,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MathMarkdown(
                                    data: msg.text,
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      height: 1.4,
                                    ),
                                  ),
                                  if (msg.audioBytes != null) ...[
                                    const SizedBox(height: 8),
                                    GestureDetector(
                                      onTap: () async {
                                        if (kIsWeb) {
                                          _addSystemMessage("Voice message playback not supported on web.");
                                          return;
                                        }
                                        final dir = await getTemporaryDirectory();
                                        final file = File('${dir.path}/temp_play.wav');
                                        await file.writeAsBytes(msg.audioBytes!);
                                        await _audioPlayer.play(DeviceFileSource(file.path));
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(LucideIcons.playCircle, size: 16, color: AppTheme.duoBlue),
                                          const SizedBox(width: 6),
                                          const Text(
                                            "Listen voice input",
                                            style: TextStyle(
                                              color: AppTheme.duoBlue,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            const Divider(color: Colors.white10, height: 24),

            // Input Panel
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Row(
                children: [
                  // Microphone/Recording Button
                  GestureDetector(
                    onLongPressStart: (_) => _startRecording(),
                    onLongPressEnd: (_) => _stopRecording(),
                    child: AnimatedBuilder(
                      animation: _pulsingController,
                      builder: (context, child) {
                        return Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isRecording
                                ? Colors.red.withOpacity(0.2 + 0.3 * _pulsingController.value)
                                : Colors.white.withOpacity(0.05),
                            border: Border.all(
                              color: _isRecording ? Colors.red : Colors.white12,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            _isRecording ? LucideIcons.mic : LucideIcons.micOff,
                            color: _isRecording ? Colors.red : Colors.white70,
                            size: 20,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Text input field
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _textController,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: "Type message or hold mic...",
                          hintStyle: TextStyle(color: Colors.white30, fontSize: 13),
                          border: InputBorder.none,
                        ),
                        onSubmitted: _sendTextMessage,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Send button
                  GestureDetector(
                    onTap: () => _sendTextMessage(_textController.text),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.duoBlue,
                      ),
                      child: const Icon(
                        LucideIcons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
