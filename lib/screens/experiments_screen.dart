import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/duo_button.dart';
import '../widgets/math_markdown.dart';
import '../widgets/responsive_center.dart';
import '../widgets/slide_views/theory_view.dart';
import '../widgets/slide_views/concept_pieces_view.dart';
import '../widgets/slide_views/interactive_proof_view.dart';
import '../widgets/slide_views/fill_in_blank_view.dart';
import '../widgets/slide_views/one_word_view.dart';
import '../widgets/slide_views/numerical_view.dart';
import '../widgets/slide_views/quiz_view.dart';
import '../widgets/slide_views/descriptive_view.dart';
import '../widgets/slide_views/custom_html_view.dart';

class ExperimentsScreen extends StatefulWidget {
  const ExperimentsScreen({super.key});

  @override
  State<ExperimentsScreen> createState() => _ExperimentsScreenState();
}

class _ExperimentsScreenState extends State<ExperimentsScreen> {
  final TextEditingController _jsonController = TextEditingController();
  Slide? _currentSlide;
  String? _jsonError;
  bool _answered = false;
  bool _isCorrect = false;
  String? _selectedQuizOption;
  String _blankInput = '';
  String _wordInput = '';
  String _numericInput = '';

  final Map<String, Map<String, dynamic>> _presets = {
    'theory': {
      "id": "preset_theory",
      "type": "theory",
      "title": "Thermodynamics Concept",
      "content": "The **First Law of Thermodynamics** states that energy cannot be created or destroyed, only transformed from one form to another. Mathematically, it is expressed as:\n\n\$\$\\Delta U = Q - W\$\$\n\nwhere \$\\Delta U\$ is the change in internal energy, \$Q\$ is heat added, and \$W\$ is work done by the system."
    },
    'concept_pieces': {
      "id": "preset_concept_pieces",
      "type": "concept_pieces",
      "title": "Properties of Vector Spaces",
      "content": "A vector space consists of a set \$V\$ along with two operations: addition and scalar multiplication.\nAddition must be commutative: \$u + v = v + u\$ for all \$u, v \\in V\$.\nAddition must be associative: \$(u + v) + w = u + (v + w)\$.\nThere must exist a zero vector \$0\$ such that \$v + 0 = v\$.\nFor every vector, there is an additive inverse \$-v\$ such that \$v + (-v) = 0\$."
    },
    'quiz': {
      "id": "preset_quiz",
      "type": "quiz",
      "title": "Linear Algebra Quiz",
      "content": "Which of the following is the dimension of the vector space \$\\mathbb{R}^3\$?",
      "options": [
        { "id": "o1", "text": "1", "isCorrect": false, "explanation": "Incorrect. A single line is 1-dimensional." },
        { "id": "o2", "text": "2", "isCorrect": false, "explanation": "Incorrect. \$\\mathbb{R}^2\$ has dimension 2." },
        { "id": "o3", "text": "3", "isCorrect": true, "explanation": "Correct! \$\\mathbb{R}^3\$ has 3 basis vectors, so its dimension is 3." },
        { "id": "o4", "text": "Infinite", "isCorrect": false, "explanation": "Incorrect. \$\\mathbb{R}^3\$ is finite-dimensional." }
      ]
    },
    'fill_in_blank': {
      "id": "preset_blank",
      "type": "fill_in_blank",
      "title": "Calculus Definition",
      "content": "The derivative of a function measures the instantaneous ___ of change.",
      "blankAnswer": "rate",
      "blankDistractors": ["amount", "acceleration", "slope"]
    },
    'one_word': {
      "id": "preset_one_word",
      "type": "one_word",
      "title": "Physics Terminology",
      "content": "What is the SI unit of force?",
      "blankAnswer": "newton"
    },
    'numerical': {
      "id": "preset_numerical",
      "type": "numerical",
      "title": "Calculus Calculation",
      "content": "Evaluate the definite integral \$\\int_0^2 3x^2 \\, dx\$.",
      "numericAnswer": 8.0,
      "numericTolerance": 0.01
    },
    'proof': {
      "id": "preset_proof",
      "type": "proof",
      "title": "Proof of Identity",
      "content": "Prove that \$(a+b)^2 = a^2 + 2ab + b^2\$.",
      "interactiveSteps": [
        {
          "prompt": "We want to prove: \$(a+b)^2 = a^2 + 2ab + b^2\$. Click Next Step to begin the algebraic expansion.",
          "stepText": "Let's expand \$(a+b)^2\$ using the distributive property."
        },
        {
          "prompt": "What is the distributive expansion of \$(a+b)(a+b)\$?",
          "stepText": "Distributing \$(a+b)\$ gives: \$a(a+b) + b(a+b) = a^2 + ab + ba + b^2\$.",
          "options": [
            { "id": "po1", "text": "\$a^2 + b^2\$", "isCorrect": false, "explanation": "Incorrect. You missed the cross terms." },
            { "id": "po2", "text": "\$a(a+b) + b(a+b)\$", "isCorrect": true, "explanation": "Correct! This is applying the distributive property." },
            { "id": "po3", "text": "\$ab + ba\$", "isCorrect": false, "explanation": "Incorrect." }
          ]
        },
        {
          "prompt": "Combine the cross terms \$ab\$ and \$ba\$. Since multiplication is commutative (\$ab = ba\$), we get:",
          "stepText": "Combining terms: \$a^2 + ab + ab + b^2 = a^2 + 2ab + b^2\$. Thus, the identity is proven.",
          "options": [
            { "id": "po4", "text": "\$a^2 + 2ab + b^2\$", "isCorrect": true, "explanation": "Correct! \$ab + ba = 2ab\$." },
            { "id": "po5", "text": "\$a^2 + ab + b^2\$", "isCorrect": false, "explanation": "Incorrect. You need to sum the two cross terms." }
          ]
        }
      ]
    },
    'step_by_step': {
      "id": "preset_step",
      "type": "step_by_step",
      "title": "Solving Linear Equation",
      "content": "Solve for \$x\$ in the equation: \$3x + 5 = 17\$.",
      "interactiveSteps": [
        {
          "prompt": "What is the first step to isolate \$3x\$?",
          "stepText": "Subtract 5 from both sides: \$3x = 17 - 5 = 12\$.",
          "options": [
            { "id": "so1", "text": "Subtract 5 from both sides", "isCorrect": true, "explanation": "Correct! Subtracting 5 isolates the variable term." },
            { "id": "so2", "text": "Divide by 3", "isCorrect": false, "explanation": "Incorrect. Division should happen after subtraction." }
          ]
        },
        {
          "prompt": "Now solve for \$x\$ by dividing both sides by 3:",
          "stepText": "\$x = 12 / 3 = 4\$.",
          "options": [
            { "id": "so3", "text": "x = 4", "isCorrect": true, "explanation": "Correct! \$12 / 3 = 4\$." },
            { "id": "so4", "text": "x = 3", "isCorrect": false, "explanation": "Incorrect." }
          ]
        }
      ]
    },
    'descriptive': {
      "id": "preset_descriptive",
      "type": "descriptive",
      "title": "Physics Essay",
      "content": "Explain the concept of conservation of angular momentum and give one real-world example."
    },
    'custom_html': {
      "id": "preset_custom_html",
      "type": "custom_html",
      "title": "Interactive Light Switch",
      "content": "Toggle the switch to turn on the light bulb and complete the slide.",
      "interactiveCanvasHtml": "<div style='display:flex; flex-direction:column; align-items:center; justify-content:center; height:100%; color:white; font-family:sans-serif;'><div id='bulb' style='width:60px; height:60px; border-radius:50%; background-color:#333; margin-bottom:20px; box-shadow:none; transition: all 0.3s;'></div><button id='btn' style='padding:10px 20px; font-weight:bold; border-radius:8px; border:none; background:#3B82F6; color:white; cursor:pointer;'>Turn ON</button></div><script>var isOn=false; document.getElementById('btn').addEventListener('click', function() { isOn = !isOn; var bulb = document.getElementById('bulb'); if(isOn) { bulb.style.backgroundColor='#FBBF24'; bulb.style.boxShadow='0 0 20px #FBBF24'; this.textContent='Turn OFF'; window.parent.postMessage('complete', '*'); } else { bulb.style.backgroundColor='#333'; bulb.style.boxShadow='none'; this.textContent='Turn ON'; } });</script>"
    }
  };

  @override
  void initState() {
    super.initState();
    _loadPreset('theory');
  }

  void _loadPreset(String key) {
    final data = _presets[key];
    if (data != null) {
      final jsonStr = const JsonEncoder.withIndent('  ').convert(data);
      _jsonController.text = jsonStr;
      _parseAndSetSlide(jsonStr);
    }
  }

  void _parseAndSetSlide(String jsonStr) {
    try {
      final decoded = jsonDecode(jsonStr);
      if (decoded is! Map) {
        throw const FormatException('JSON must be a Map object');
      }
      final slide = Slide.fromJson(Map<String, dynamic>.from(decoded));
      setState(() {
        _currentSlide = slide;
        _jsonError = null;
        _resetSlideState();
      });
    } catch (e) {
      setState(() {
        _jsonError = e.toString();
      });
    }
  }

  void _resetSlideState() {
    _answered = false;
    _isCorrect = false;
    _selectedQuizOption = null;
    _blankInput = '';
    _wordInput = '';
    _numericInput = '';
  }

  void _checkAnswer() {
    if (_currentSlide == null) return;
    final slide = _currentSlide!;
    bool correct = false;

    if (slide.type == 'quiz') {
      final opt = slide.options?.firstWhere((o) => o.id == _selectedQuizOption, orElse: () => slide.options!.first);
      correct = opt?.isCorrect ?? false;
    } else if (slide.type == 'fill_in_blank') {
      final answers = (slide.blankAnswer ?? '').split(',').map((s) => s.trim().toLowerCase());
      final input = _blankInput.trim().toLowerCase();
      correct = answers.contains(input);
    } else if (slide.type == 'one_word') {
      correct = _wordInput.trim().toLowerCase() == (slide.blankAnswer ?? '').trim().toLowerCase().replaceAll(r'\', '');
    } else if (slide.type == 'numerical') {
      final val = double.tryParse(_numericInput);
      if (val != null && slide.numericAnswer != null) {
        correct = (val - slide.numericAnswer!).abs() <= (slide.numericTolerance ?? 0.01);
      }
    }

    if (correct) {
      HapticFeedback.heavyImpact();
    } else {
      HapticFeedback.vibrate();
    }

    setState(() {
      _answered = true;
      _isCorrect = correct;
    });
  }

  bool _canCheck() {
    if (_currentSlide == null) return false;
    final slide = _currentSlide!;
    if (slide.type == 'quiz') return _selectedQuizOption != null;
    if (slide.type == 'fill_in_blank') return _blankInput.trim().isNotEmpty;
    if (slide.type == 'one_word') return _wordInput.trim().isNotEmpty;
    if (slide.type == 'numerical') return _numericInput.trim().isNotEmpty;
    return true;
  }

  bool _isCustomBottomBar(Slide slide) {
    return slide.type == 'proof' || slide.type == 'step_by_step' || slide.type == 'descriptive' || slide.type == 'custom_html';
  }

  String _getCorrectAnswerText(Slide slide) {
    if (slide.type == 'quiz') {
      final opt = slide.options?.firstWhere((o) => o.isCorrect, orElse: () => slide.options!.first);
      return opt?.text ?? '';
    }
    if (slide.type == 'fill_in_blank') return slide.blankAnswer ?? '';
    if (slide.type == 'one_word') return slide.blankAnswer ?? '';
    if (slide.type == 'numerical') return slide.numericAnswer?.toString() ?? '';
    return '';
  }

  Widget _buildActionBottomBar(Slide slide) {
    final isInteractive = ['quiz', 'fill_in_blank', 'one_word', 'numerical'].contains(slide.type);
    final feedbackColor = _isCorrect ? AppTheme.duoGreen : AppTheme.duoRed;

    return Container(
      decoration: BoxDecoration(
        color: _answered
            ? feedbackColor.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(_answered ? 20 : 0),
        border: Border.all(
          color: _answered
              ? feedbackColor.withOpacity(0.3)
              : Colors.transparent,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: (_answered && !_isCorrect)
                ? Padding(
                    key: const ValueKey('incorrect_feedback'),
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.duoRed.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.duoRed.withOpacity(0.4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('CORRECT ANSWER:', style: TextStyle(color: AppTheme.duoRed, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.2)),
                          const SizedBox(height: 8),
                          MathMarkdown(
                            data: _getCorrectAnswerText(slide),
                            textStyle: const TextStyle(color: AppTheme.duoRed, fontSize: 18, fontWeight: FontWeight.bold)
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(key: ValueKey('empty_feedback')),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isInteractive && !_answered
                ? DuoButton(
                    key: const ValueKey('check_button'),
                    text: 'CHECK',
                    color: _canCheck() ? AppTheme.duoGreen : const Color(0xFF334155),
                    shadowColor: _canCheck() ? AppTheme.duoGreenDark : const Color(0xFF1E293B),
                    onPressed: () {
                      if (_canCheck()) _checkAnswer();
                    },
                  )
                : DuoButton(
                    key: const ValueKey('continue_button'),
                    text: _answered && !_isCorrect ? 'TRY AGAIN' : 'RESET PREVIEW',
                    color: _answered && !_isCorrect ? AppTheme.duoRed : AppTheme.duoGreen,
                    shadowColor: _answered && !_isCorrect ? AppTheme.duoRedDark : AppTheme.duoGreenDark,
                    onPressed: () {
                      setState(() {
                        _resetSlideState();
                      });
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlideContent(Slide slide, Widget? bottomBar) {
    switch (slide.type) {
      case 'descriptive':
        return DescriptiveView(
          slide: slide,
          onComplete: () {
            HapticFeedback.heavyImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Descriptive slide completed!')),
            );
          },
        );
      case 'custom_html':
        return CustomHtmlView(
          slide: slide,
          onComplete: () {
            HapticFeedback.heavyImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Custom HTML slide completed!')),
            );
          },
        );
      case 'step_by_step':
      case 'proof':
        return InteractiveProofView(
          slide: slide,
          onComplete: () {
            HapticFeedback.heavyImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Proof/Step slide completed!')),
            );
          },
        );
      case 'quiz':
        return QuizView(
          slide: slide,
          selectedOptionId: _selectedQuizOption,
          isAnswered: _answered,
          onSelect: (id) => setState(() => _selectedQuizOption = id),
          onUpdateSlide: (s) => setState(() => _currentSlide = s),
          bottomBar: bottomBar,
        );
      case 'fill_in_blank':
        return FillInBlankView(
          slide: slide,
          value: _blankInput,
          isAnswered: _answered,
          isCorrect: _isCorrect,
          onChanged: (val) => setState(() => _blankInput = val),
          bottomBar: bottomBar,
        );
      case 'numerical':
        return NumericalView(
          slide: slide,
          value: _numericInput,
          isAnswered: _answered,
          isCorrect: _isCorrect,
          onChanged: (val) => setState(() => _numericInput = val),
          bottomBar: bottomBar,
        );
      case 'one_word':
        return OneWordView(
          slide: slide,
          value: _wordInput,
          isAnswered: _answered,
          isCorrect: _isCorrect,
          onChanged: (val) => setState(() => _wordInput = val),
          bottomBar: bottomBar,
        );
      case 'concept_pieces':
        return ConceptPiecesView(
          slide: slide,
          bottomBar: bottomBar,
          hasCanvas: false,
          lessonTitle: 'Experiment Lesson',
        );
      case 'theory':
      default:
        return TheoryView(
          slide: slide,
          bottomBar: bottomBar,
          hasCanvas: false,
          lessonTitle: 'Experiment Lesson',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final slide = _currentSlide;
    final hasCustomBar = slide != null && _isCustomBottomBar(slide);
    final bottomBar = (slide != null && !hasCustomBar) ? _buildActionBottomBar(slide) : null;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      appBar: AppBar(
        title: const Text('Slide Testing Experiments', style: TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.form,
        child: Column(
          children: [
            // Preset selectors & Text editor in a header panel
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Select Built-in Preset:', style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _presets.keys.map((key) {
                      final isSelected = _currentSlide?.type == key;
                      return ChoiceChip(
                        label: Text(key, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontWeight: FontWeight.bold, fontSize: 11)),
                        selected: isSelected,
                        selectedColor: AppTheme.duoBlue,
                        backgroundColor: Colors.black26,
                        checkmarkColor: Colors.white,
                        onSelected: (val) {
                          if (val) _loadPreset(key);
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text('Slide JSON Template:', style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _jsonController,
                    maxLines: 8,
                    minLines: 4,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.white70),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black38,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppTheme.duoBlue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_jsonError != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text('Error: $_jsonError', style: const TextStyle(color: AppTheme.duoRed, fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  DuoButton(
                    text: 'Render Custom Slide',
                    onPressed: () => _parseAndSetSlide(_jsonController.text),
                    color: AppTheme.duoBlue,
                    shadowColor: AppTheme.duoBlueDark,
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white10, height: 24),
            // Live Preview of Slide
            Expanded(
              child: slide == null
                  ? const Center(child: Text('No slide loaded', style: TextStyle(color: Colors.white38)))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Text('LIVE PREVIEW:', style: TextStyle(color: AppTheme.duoGreen, fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 1.1)),
                          ),
                          Expanded(
                            child: _buildSlideContent(slide, bottomBar),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
