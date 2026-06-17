import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/safe_pdf_viewer.dart';

class ReferencePdfViewerScreen extends StatefulWidget {
  final Book book;
  final Section initialSection;

  const ReferencePdfViewerScreen({
    super.key,
    required this.book,
    required this.initialSection,
  });

  @override
  State<ReferencePdfViewerScreen> createState() => _ReferencePdfViewerScreenState();
}

class _ReferencePdfViewerScreenState extends State<ReferencePdfViewerScreen> {
  late SafePdfViewerController _pdfViewerController;
  late List<Section> _pdfSections;
  late int _currentIndex;
  
  double _zoomFactor = 1.0;
  bool _isDocumentLoaded = false;
  bool _scrollToBottomOnNextLoad = false;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = SafePdfViewerController();
    
    _pdfSections = [];
    for (var module in widget.book.modules) {
      for (var sec in module.sections) {
        if (sec.pdfPath != null && sec.pdfPath!.isNotEmpty && File(sec.pdfPath!).existsSync()) {
          _pdfSections.add(sec);
        }
      }
    }
    
    _currentIndex = _pdfSections.indexWhere((s) => s.id == widget.initialSection.id);
    if (_currentIndex == -1) {
      _pdfSections.insert(0, widget.initialSection);
      _currentIndex = 0;
    }
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  void _zoomIn() {
    if (!_isDocumentLoaded) return;
    setState(() {
      _zoomFactor = (_zoomFactor + 0.1).clamp(0.5, 3.0);
      if (_zoomFactor >= 1.0) {
        _pdfViewerController.zoomLevel = _zoomFactor;
      }
    });
  }

  void _zoomOut() {
    if (!_isDocumentLoaded) return;
    setState(() {
      _zoomFactor = (_zoomFactor - 0.1).clamp(0.5, 3.0);
      if (_zoomFactor >= 1.0) {
        _pdfViewerController.zoomLevel = _zoomFactor;
      } else {
        _pdfViewerController.zoomLevel = 1.0;
      }
    });
  }

  void _resetZoom() {
    if (!_isDocumentLoaded) return;
    setState(() {
      _zoomFactor = 1.0;
      _pdfViewerController.zoomLevel = 1.0;
    });
  }

  void _goToPreviousSection() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _isDocumentLoaded = false;
        _scrollToBottomOnNextLoad = true;
      });
    }
  }

  void _goToNextSection() {
    if (_currentIndex < _pdfSections.length - 1) {
      setState(() {
        _currentIndex++;
        _isDocumentLoaded = false;
        _scrollToBottomOnNextLoad = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSection = _pdfSections[_currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: const Color(0xFF0D1220),
        elevation: 1,
        shadowColor: Colors.black26,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.white70),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          currentSection.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            fontFamily: 'Nunito',
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        actions: [
          // Zoom Actions
          IconButton(
            icon: const Icon(LucideIcons.zoomOut, color: Colors.white70, size: 20),
            tooltip: 'Zoom Out',
            onPressed: _isDocumentLoaded ? _zoomOut : null,
          ),
          Center(
            child: InkWell(
              onTap: _isDocumentLoaded ? _resetZoom : null,
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Text(
                  '${(_zoomFactor * 100).round()}%',
                  style: TextStyle(
                    color: _isDocumentLoaded ? AppTheme.duoBlue : Colors.white38,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(LucideIcons.zoomIn, color: Colors.white70, size: 20),
            tooltip: 'Zoom In',
            onPressed: _isDocumentLoaded ? _zoomIn : null,
          ),
          const VerticalDivider(
            color: Colors.white12,
            thickness: 1,
            width: 16,
            indent: 12,
            endIndent: 12,
          ),
          // Navigation Actions
          IconButton(
            icon: const Icon(LucideIcons.chevronUp, size: 22),
            tooltip: 'Previous Reference PDF (Up)',
            onPressed: _currentIndex > 0 ? _goToPreviousSection : null,
            color: _currentIndex > 0 ? AppTheme.duoBlue : Colors.white30,
          ),
          IconButton(
            icon: const Icon(LucideIcons.chevronDown, size: 22),
            tooltip: 'Next Reference PDF (Down)',
            onPressed: _currentIndex < _pdfSections.length - 1 ? _goToNextSection : null,
            color: _currentIndex < _pdfSections.length - 1 ? AppTheme.duoBlue : Colors.white30,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Listener(
        onPointerSignal: (pointerSignal) {
          if (pointerSignal is PointerScrollEvent) {
            final isControlPressed = HardwareKeyboard.instance.isControlPressed;
            if (isControlPressed) {
              if (pointerSignal.scrollDelta.dy < 0) {
                _zoomIn();
              } else if (pointerSignal.scrollDelta.dy > 0) {
                _zoomOut();
              }
            }
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double actualWidth = constraints.maxWidth;
            final double actualHeight = constraints.maxHeight;
            
            final bool useLocalScale = _zoomFactor < 1.0;
            final double scale = useLocalScale ? _zoomFactor : 1.0;
            final double containerWidth = actualWidth * scale;
            final double containerHeight = actualHeight;

            return Center(
              child: SizedBox(
                width: containerWidth,
                height: containerHeight,
                child: SafePdfViewer(
                  file: File(currentSection.pdfPath!),
                  key: ValueKey('ref-pdf-${currentSection.id}'),
                  controller: _pdfViewerController,
                  onDocumentLoaded: (details) {
                    setState(() {
                      _isDocumentLoaded = true;
                    });
                    
                    if (_zoomFactor >= 1.0) {
                      _pdfViewerController.zoomLevel = _zoomFactor;
                    }
                    
                    if (_scrollToBottomOnNextLoad) {
                      _scrollToBottomOnNextLoad = false;
                      _pdfViewerController.lastPage();
                      Future.delayed(const Duration(milliseconds: 60), () {
                        if (mounted) {
                          _pdfViewerController.jumpTo(
                            yOffset: 999999,
                          );
                        }
                      });
                    }
                  },
                  onZoomLevelChanged: (details) {
                    if (details.newZoomLevel >= 1.0 && details.newZoomLevel != _zoomFactor) {
                      setState(() {
                        _zoomFactor = details.newZoomLevel;
                      });
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
