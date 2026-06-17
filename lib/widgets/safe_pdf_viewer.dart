import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/pdf_service.dart';
import '../theme/app_theme.dart';

class SafePdfViewerController extends PdfViewerController {
  PdfViewerController? _internalController;
  int _totalPageCount = 0;
  int _currentMaxLoadedPage = 50;
  int? _overridePageCount;

  Future<void> Function(int targetPage)? _onLoadPageRequested;

  void _setInternalController(PdfViewerController controller) {
    _internalController?.removeListener(notifyListeners);
    _internalController = controller;
    _internalController?.addListener(notifyListeners);
  }

  @override
  int get pageCount => _overridePageCount ?? _totalPageCount;

  @override
  int get pageNumber => _internalController?.pageNumber ?? 0;

  @override
  double get zoomLevel => _internalController?.zoomLevel ?? 1.0;

  @override
  set zoomLevel(double newValue) {
    _internalController?.zoomLevel = newValue;
  }

  @override
  Offset get scrollOffset => _internalController?.scrollOffset ?? Offset.zero;

  @override
  void jumpTo({double xOffset = 0.0, double yOffset = 0.0}) {
    _internalController?.jumpTo(xOffset: xOffset, yOffset: yOffset);
  }

  @override
  void jumpToPage(int pageNumber) {
    if (_onLoadPageRequested != null && pageNumber > _currentMaxLoadedPage && pageNumber <= _totalPageCount) {
      _onLoadPageRequested!(pageNumber).then((_) {
        Future.delayed(const Duration(milliseconds: 250), () {
          _internalController?.jumpToPage(pageNumber);
        });
      });
    } else {
      _internalController?.jumpToPage(pageNumber);
    }
  }

  @override
  void nextPage() {
    final curPage = pageNumber;
    if (_onLoadPageRequested != null && curPage == _currentMaxLoadedPage && _currentMaxLoadedPage < _totalPageCount) {
      _onLoadPageRequested!(curPage + 1).then((_) {
        Future.delayed(const Duration(milliseconds: 250), () {
          _internalController?.jumpToPage(curPage + 1);
        });
      });
    } else {
      _internalController?.nextPage();
    }
  }

  @override
  void previousPage() {
    _internalController?.previousPage();
  }

  @override
  void firstPage() {
    _internalController?.firstPage();
  }

  @override
  void lastPage() {
    if (_onLoadPageRequested != null && _totalPageCount > _currentMaxLoadedPage) {
      _onLoadPageRequested!(_totalPageCount).then((_) {
        Future.delayed(const Duration(milliseconds: 250), () {
          _internalController?.jumpToPage(_totalPageCount);
        });
      });
    } else {
      _internalController?.lastPage();
    }
  }

  @override
  PdfTextSearchResult searchText(String searchText, {TextSearchOption? searchOption}) {
    return _internalController?.searchText(searchText, searchOption: searchOption) ?? PdfTextSearchResult();
  }

  @override
  bool clearSelection() {
    return _internalController?.clearSelection() ?? false;
  }

  @override
  void importFormData(List<int> inputBytes, DataFormat dataFormat, [bool continueImportOnError = false]) {
    _internalController?.importFormData(inputBytes, dataFormat, continueImportOnError);
  }

  @override
  List<int> exportFormData({required DataFormat dataFormat}) {
    return _internalController?.exportFormData(dataFormat: dataFormat) ?? <int>[];
  }

  @override
  Future<List<int>> saveDocument({PdfFlattenOption flattenOption = PdfFlattenOption.none}) {
    return _internalController?.saveDocument(flattenOption: flattenOption) ?? Future.value(<int>[]);
  }

  @override
  void dispose() {
    _internalController?.removeListener(notifyListeners);
    super.dispose();
  }
}

class SafePdfViewer extends StatefulWidget {
  final File file;
  final SafePdfViewerController? controller;
  final bool canShowScrollHead;
  final bool canShowScrollStatus;
  final void Function(PdfDocumentLoadedDetails)? onDocumentLoaded;
  final void Function(PdfPageChangedDetails)? onPageChanged;
  final void Function(PdfZoomDetails)? onZoomLevelChanged;
  final void Function(PdfDocumentLoadFailedDetails)? onDocumentLoadFailed;
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
    this.onDocumentLoadFailed,
    this.maxZoomLevel = 3.0,
    this.enableDoubleTapZooming = true,
  });

  @override
  State<SafePdfViewer> createState() => _SafePdfViewerState();
}

class _SafePdfViewerState extends State<SafePdfViewer> {
  bool _hasError = false;
  String _errorMessage = '';

  File? _currentFile;
  int _currentPage = 1;
  int _currentMaxLoadedPage = 50;
  int _totalPageCount = 0;
  bool _isLoadingPages = false;

  bool _needsRestorePosition = false;
  double _savedZoomLevel = 1.0;
  Offset _savedScrollOffset = Offset.zero;
  int _savedPageNumber = 1;

  late PdfViewerController _internalPdfViewerController;
  late SafePdfViewerController _externalSafePdfViewerController;
  bool _createdInternalController = false;

  @override
  void initState() {
    super.initState();
    _initController();
    _initViewer();
  }

  void _initController() {
    _internalPdfViewerController = PdfViewerController();

    if (widget.controller != null) {
      _externalSafePdfViewerController = widget.controller!;
      _createdInternalController = false;
    } else {
      _externalSafePdfViewerController = SafePdfViewerController();
      _createdInternalController = true;
    }

    _externalSafePdfViewerController._setInternalController(_internalPdfViewerController);
    _externalSafePdfViewerController._onLoadPageRequested = _handleLoadPageRequested;
  }

  @override
  void didUpdateWidget(SafePdfViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null && _createdInternalController) {
        _externalSafePdfViewerController.dispose();
      }
      _initController();
    }
    if (widget.file.path != oldWidget.file.path) {
      _initViewer();
    }
  }

  @override
  void dispose() {
    if (_createdInternalController) {
      _externalSafePdfViewerController.dispose();
    }
    _internalPdfViewerController.dispose();

    // Clean up temp file
    final tempFile = _currentFile;
    if (tempFile != null && tempFile.path != widget.file.path) {
      _deleteFileSilently(tempFile);
    }
    super.dispose();
  }

  void _deleteFileSilently(File file) {
    Future.microtask(() async {
      try {
        if (await file.exists()) {
          await file.delete();
        }
      } catch (_) {
        // ignore
      }
    });
  }

  Future<void> _initViewer() async {
    final fileToLoad = widget.file;

    setState(() {
      _hasError = false;
      _errorMessage = '';
      _isLoadingPages = true;
      _needsRestorePosition = false;
      _currentFile = null;
    });

    try {
      final pdfService = PdfService();
      final count = await pdfService.getPageCount(fileToLoad);

      if (!mounted || widget.file.path != fileToLoad.path) return;

      _totalPageCount = count;
      _externalSafePdfViewerController._totalPageCount = count;
      _externalSafePdfViewerController._overridePageCount = count;

      if (count > 50) {
        // Initial window: pages 1 to 50
        final pageNumbers = List<int>.generate(50, (i) => i + 1);
        final fileName = 'first50_${fileToLoad.path.split(Platform.pathSeparator).last}';
        final tempFile = await pdfService.extractPages(
          fileToLoad,
          pageNumbers,
          outputName: fileName,
        );

        if (!mounted || widget.file.path != fileToLoad.path) return;

        setState(() {
          _currentFile = tempFile;
          _currentMaxLoadedPage = 50;
          _externalSafePdfViewerController._currentMaxLoadedPage = 50;
          _isLoadingPages = false;
        });
      } else {
        setState(() {
          _currentFile = fileToLoad;
          _currentMaxLoadedPage = count;
          _externalSafePdfViewerController._currentMaxLoadedPage = count;
          _isLoadingPages = false;
        });
      }
    } catch (e) {
      if (!mounted || widget.file.path != fileToLoad.path) return;
      // Fallback
      setState(() {
        _currentFile = fileToLoad;
        _currentMaxLoadedPage = 50;
        _externalSafePdfViewerController._currentMaxLoadedPage = 50;
        _isLoadingPages = false;
      });
    }
  }

  Future<void> _handleLoadPageRequested(int targetPage) async {
    if (!mounted || _isLoadingPages || _currentFile == null) return;
    if (targetPage <= _currentMaxLoadedPage || targetPage > _totalPageCount) return;

    final nextMax = ((targetPage + 49) ~/ 50) * 50;
    final targetMax = nextMax > _totalPageCount ? _totalPageCount : nextMax;

    _savedZoomLevel = _internalPdfViewerController.zoomLevel;
    _savedScrollOffset = _internalPdfViewerController.scrollOffset;
    _savedPageNumber = _internalPdfViewerController.pageNumber;
    _needsRestorePosition = true;

    setState(() {
      _isLoadingPages = true;
    });

    try {
      final pdfService = PdfService();
      final pageNumbers = List<int>.generate(targetMax, (i) => i + 1);
      final fileName = 'pages_1_to_${targetMax}_${widget.file.path.split(Platform.pathSeparator).last}';
      final tempFile = await pdfService.extractPages(
        widget.file,
        pageNumbers,
        outputName: fileName,
      );

      if (!mounted) return;

      final oldTempFile = _currentFile;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() {
          _currentFile = tempFile;
          _currentMaxLoadedPage = targetMax;
          _externalSafePdfViewerController._currentMaxLoadedPage = targetMax;
        });
        if (oldTempFile != null && oldTempFile.path != widget.file.path) {
          _deleteFileSilently(oldTempFile);
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingPages = false;
      });
    }
  }

  void _restorePosition() {
    _needsRestorePosition = false;
    if (_savedZoomLevel > 1.0) {
      _internalPdfViewerController.zoomLevel = _savedZoomLevel;
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        if (_savedScrollOffset != Offset.zero) {
          _internalPdfViewerController.jumpTo(
            xOffset: _savedScrollOffset.dx,
            yOffset: _savedScrollOffset.dy,
          );
        } else if (_savedPageNumber > 1) {
          _internalPdfViewerController.jumpToPage(_savedPageNumber);
        }
      }
    });
  }

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

    final pdfViewerWidget = _currentFile == null
        ? const SizedBox()
        : SfPdfViewerTheme(
            data: SfPdfViewerThemeData(
              backgroundColor: const Color(0xFF0B0F19),
            ),
            child: SfPdfViewer.file(
              _currentFile!,
              key: ValueKey(widget.file.path),
              controller: _internalPdfViewerController,
              canShowScrollHead: widget.canShowScrollHead,
              canShowScrollStatus: widget.canShowScrollStatus,
              maxZoomLevel: widget.maxZoomLevel,
              enableDoubleTapZooming: widget.enableDoubleTapZooming,
              onZoomLevelChanged: widget.onZoomLevelChanged,
              canShowPageLoadingIndicator: false,
              onDocumentLoaded: (details) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _isLoadingPages = false;
                    });
                    if (_needsRestorePosition) {
                      _restorePosition();
                    }
                  }
                });
                if (widget.onDocumentLoaded != null) {
                  widget.onDocumentLoaded!(details);
                }
              },
              onDocumentLoadFailed: (details) {
                setState(() {
                  _hasError = true;
                  _errorMessage = details.description;
                  _isLoadingPages = false;
                });
                if (widget.onDocumentLoadFailed != null) {
                  widget.onDocumentLoadFailed!(details);
                }
              },
              onPageChanged: (details) {
                setState(() {
                  _currentPage = details.newPageNumber;
                });
                if (widget.onPageChanged != null) {
                  widget.onPageChanged!(details);
                }
              },
            ),
          );

    final showLoadMoreButton = _currentFile != null &&
        !_isLoadingPages &&
        _currentMaxLoadedPage < _totalPageCount &&
        _currentPage == _currentMaxLoadedPage;

    final remainingPages = _totalPageCount - _currentMaxLoadedPage;
    final pagesToLoadNext = remainingPages > 50 ? 50 : remainingPages;

    return Stack(
      children: [
        pdfViewerWidget,
        if (showLoadMoreButton)
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Center(
              child: Card(
                elevation: 8,
                color: const Color(0xFF1E293B).withOpacity(0.95),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: AppTheme.duoBlue.withOpacity(0.4), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Showing $_currentMaxLoadedPage of $_totalPageCount pages',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.duoBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          _handleLoadPageRequested(_currentMaxLoadedPage + 1);
                        },
                        icon: const Icon(LucideIcons.download, size: 16),
                        label: Text(
                          'Load Next $pagesToLoadNext Pages',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        if (_isLoadingPages)
          Positioned.fill(
            child: Container(
              color: const Color(0xFF0B0F19).withOpacity(0.7),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppTheme.duoBlue,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
