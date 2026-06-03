import 'dart:io';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/auto_index_service.dart';
import '../widgets/responsive_center.dart';
import 'index_picker_screen.dart';

class AutoIndexScreen extends StatefulWidget {
  final File sourcePdf;
  final String filename;
  final List<File> syllabusFiles;
  final bool isCourse;

  // Chained parameters
  final List<File>? allSourcePdfs;
  final int currentPdfIndex;
  final List<List<int>>? collectedIndexPages;
  final List<int>? collectedChapter1StartPages;
  final bool isAutoMode;
  final bool isHandout;

  const AutoIndexScreen({
    super.key,
    required this.sourcePdf,
    required this.filename,
    this.syllabusFiles = const [],
    this.isCourse = false,
    this.allSourcePdfs,
    this.currentPdfIndex = 0,
    this.collectedIndexPages,
    this.collectedChapter1StartPages,
    this.isAutoMode = true,
    this.isHandout = false,
  });

  @override
  State<AutoIndexScreen> createState() => _AutoIndexScreenState();
}

class _AutoIndexScreenState extends State<AutoIndexScreen> {
  String _status = 'Starting...';
  double _progress = 0.0;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _startAutoIndex();
  }

  Future<void> _startAutoIndex() async {
    try {
      final service = AutoIndexService();
      final result = await service.findIndexAndChapter1(
        widget.sourcePdf,
        (status, progress) {
          if (mounted) {
            setState(() {
              _status = status;
              _progress = progress;
            });
          }
        },
      );

      if (mounted) {
        if (result.indexPages.isEmpty || result.chapter1StartPage == null) {
          setState(() {
            _hasError = true;
            _status = 'Could not automatically find the index or chapter 1. Please go back and use Manual mode.';
          });
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => IndexPickerScreen(
              sourcePdf: widget.sourcePdf,
              filename: widget.filename,
              syllabusFiles: widget.syllabusFiles,
              isCourse: widget.isCourse,
              initialIndexPages: result.indexPages,
              initialChapter1Page: result.chapter1StartPage,
              allSourcePdfs: widget.allSourcePdfs,
              currentPdfIndex: widget.currentPdfIndex,
              collectedIndexPages: widget.collectedIndexPages,
              collectedChapter1StartPages: widget.collectedChapter1StartPages,
              isAutoMode: widget.isAutoMode,
              isHandout: widget.isHandout,
            ),
          ));
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _status = 'Error: ${e.toString()}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('Analyzing Structure...')),
      body: ResponsiveCenter(
        maxWidth: ResponsiveMaxWidth.form,
        child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!_hasError) ...[
                const CircularProgressIndicator(color: AppTheme.duoGreen),
                const SizedBox(height: 24),
                Text(_status, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                const SizedBox(height: 12),
                LinearProgressIndicator(value: _progress, backgroundColor: Colors.white12, color: AppTheme.duoGreen),
                const SizedBox(height: 24),
                const Text('AI is scanning the textbook to locate the table of contents and chapter starts. This saves you from scrolling!', style: TextStyle(color: Colors.white54, fontSize: 13), textAlign: TextAlign.center),
              ] else ...[
                const Icon(Icons.error_outline, color: AppTheme.duoRed, size: 48),
                const SizedBox(height: 24),
                Text(_status, style: const TextStyle(color: AppTheme.duoRed, fontSize: 14), textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.surface),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Go Back', style: TextStyle(color: Colors.white)),
                ),
              ],
            ],
          ),
        ),
        ),
      ),
    );
  }
}
