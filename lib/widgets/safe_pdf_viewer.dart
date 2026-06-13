import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../theme/app_theme.dart';

class SafePdfViewer extends StatefulWidget {
  final File file;
  final PdfViewerController? controller;
  final bool canShowScrollHead;
  final bool canShowScrollStatus;
  final void Function(PdfDocumentLoadedDetails)? onDocumentLoaded;
  final void Function(PdfPageChangedDetails)? onPageChanged;
  final void Function(PdfZoomDetails)? onZoomLevelChanged;
  final double maxZoomLevel;
  final bool enableDoubleTapZooming;

  const SafePdfViewer({
    super.key,
    required this.file,
    this.controller,
    this.canShowScrollHead = true,
    this.canShowScrollStatus = true,
    this.onDocumentLoaded,
    this.onPageChanged,
    this.onZoomLevelChanged,
    this.maxZoomLevel = 3.0,
    this.enableDoubleTapZooming = true,
  });

  @override
  State<SafePdfViewer> createState() => _SafePdfViewerState();
}

class _SafePdfViewerState extends State<SafePdfViewer> {
  bool _hasError = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.redAccent.withOpacity(0.3), width: 1.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                const SizedBox(height: 16),
                const Text(
                  'Failed to load PDF document',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.white60, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SfPdfViewerTheme(
      data: SfPdfViewerThemeData(
        backgroundColor: const Color(0xFF0B0F19),
      ),
      child: SfPdfViewer.file(
        widget.file,
        controller: widget.controller,
        canShowScrollHead: widget.canShowScrollHead,
        canShowScrollStatus: widget.canShowScrollStatus,
        maxZoomLevel: widget.maxZoomLevel,
        enableDoubleTapZooming: widget.enableDoubleTapZooming,
        onZoomLevelChanged: widget.onZoomLevelChanged,
        onDocumentLoaded: (details) {
          if (widget.onDocumentLoaded != null) {
            widget.onDocumentLoaded!(details);
          }
        },
        onDocumentLoadFailed: (details) {
          setState(() {
            _hasError = true;
            _errorMessage = details.description;
          });
        },
        onPageChanged: (details) {
          if (widget.onPageChanged != null) {
            widget.onPageChanged!(details);
          }
        },
      ),
    );
  }
}
