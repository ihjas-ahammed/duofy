import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../theme/app_theme.dart';
import 'platform_webview.dart';

class WebPdfTextSearchResult extends PdfTextSearchResult {
  bool _hasResult = false;
  int _currentInstanceIndex = 0;
  int _totalInstanceCount = 0;

  final void Function()? _onNext;
  final void Function()? _onPrev;
  final void Function()? _onClear;

  WebPdfTextSearchResult({
    void Function()? onNext,
    void Function()? onPrev,
    void Function()? onClear,
  }) : _onNext = onNext,
       _onPrev = onPrev,
       _onClear = onClear;

  void update({required bool hasResult, required int currentInstanceIndex, required int totalInstanceCount}) {
    _hasResult = hasResult;
    _currentInstanceIndex = currentInstanceIndex;
    _totalInstanceCount = totalInstanceCount;
    notifyListeners();
  }

  @override
  bool get hasResult => _hasResult;

  @override
  int get currentInstanceIndex => _currentInstanceIndex;

  @override
  int get totalInstanceCount => _totalInstanceCount;

  @override
  void nextInstance() {
    _onNext?.call();
  }

  @override
  void previousInstance() {
    _onPrev?.call();
  }

  @override
  void clear() {
    _hasResult = false;
    _currentInstanceIndex = 0;
    _totalInstanceCount = 0;
    _onClear?.call();
    notifyListeners();
  }
}

class SafePdfViewerController extends PdfViewerController {
  PlatformWebViewController? _webViewController;
  int _totalPageCount = 0;
  int _currentPageNumber = 1;
  double _currentZoomLevel = 1.0;

  WebPdfTextSearchResult? _activeSearchResult;
  void Function(String query)? _onSearchText;

  void _updatePageNumber(int pageNum) {
    if (_currentPageNumber != pageNum) {
      _currentPageNumber = pageNum;
      notifyListeners();
    }
  }

  void _updatePageCount(int count) {
    if (_totalPageCount != count) {
      _totalPageCount = count;
      notifyListeners();
    }
  }

  void _updateZoomLevel(double zoom) {
    if (_currentZoomLevel != zoom) {
      _currentZoomLevel = zoom;
      notifyListeners();
    }
  }

  @override
  int get pageCount => _totalPageCount;

  @override
  int get pageNumber => _currentPageNumber;

  @override
  double get zoomLevel => _currentZoomLevel;

  @override
  set zoomLevel(double newValue) {
    _updateZoomLevel(newValue);
    _webViewController?.runJavaScript?.call('setZoom($newValue);');
  }

  @override
  Offset get scrollOffset => Offset.zero;

  @override
  void jumpTo({double xOffset = 0.0, double yOffset = 0.0}) {
    _webViewController?.runJavaScript?.call('scrollToOffset($xOffset, $yOffset);');
  }

  @override
  void jumpToPage(int pageNumber) {
    _webViewController?.runJavaScript?.call('jumpToPage($pageNumber);');
  }

  @override
  void nextPage() {
    if (_currentPageNumber < _totalPageCount) {
      _webViewController?.runJavaScript?.call('jumpToPage(${_currentPageNumber + 1});');
    }
  }

  @override
  void previousPage() {
    if (_currentPageNumber > 1) {
      _webViewController?.runJavaScript?.call('jumpToPage(${_currentPageNumber - 1});');
    }
  }

  @override
  void firstPage() {
    _webViewController?.runJavaScript?.call('jumpToPage(1);');
  }

  @override
  void lastPage() {
    _webViewController?.runJavaScript?.call('jumpToPage($_totalPageCount);');
  }

  @override
  PdfTextSearchResult searchText(String searchText, {TextSearchOption? searchOption}) {
    _activeSearchResult?.clear();
    _activeSearchResult = WebPdfTextSearchResult(
      onNext: () {
        _webViewController?.runJavaScript?.call('nextSearchInstance();');
      },
      onPrev: () {
        _webViewController?.runJavaScript?.call('prevSearchInstance();');
      },
      onClear: () {
        _webViewController?.runJavaScript?.call('clearSearch();');
      },
    );
    _onSearchText?.call(searchText);
    return _activeSearchResult!;
  }

  @override
  bool clearSelection() {
    _activeSearchResult?.clear();
    _webViewController?.runJavaScript?.call('clearSearch();');
    return true;
  }

  @override
  void importFormData(List<int> inputBytes, DataFormat dataFormat, [bool continueImportOnError = false]) {}

  @override
  List<int> exportFormData({required DataFormat dataFormat}) {
    return <int>[];
  }

  @override
  Future<List<int>> saveDocument({PdfFlattenOption flattenOption = PdfFlattenOption.none}) {
    return Future.value(<int>[]);
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
  bool _isLoading = true;
  String? _base64Data;
  bool _isWebviewReady = false;

  late SafePdfViewerController _externalSafePdfViewerController;
  bool _createdInternalController = false;

  @override
  void initState() {
    super.initState();
    _initController();
    _loadPdfData();
  }

  void _initController() {
    if (widget.controller != null) {
      _externalSafePdfViewerController = widget.controller!;
      _createdInternalController = false;
    } else {
      _externalSafePdfViewerController = SafePdfViewerController();
      _createdInternalController = true;
    }
    _externalSafePdfViewerController._onSearchText = (query) {
      _externalSafePdfViewerController._webViewController?.runJavaScript
          ?.call('performSearch("$query");');
    };
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
      _loadPdfData();
    }
  }

  @override
  void dispose() {
    if (_createdInternalController) {
      _externalSafePdfViewerController.dispose();
    }
    super.dispose();
  }

  Future<void> _loadPdfData() async {
    debugPrint('[SafePdfViewer] _loadPdfData started for ${widget.file.path}');
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
      _isWebviewReady = false;
    });

    try {
      final bytes = await widget.file.readAsBytes();
      debugPrint('[SafePdfViewer] Read ${bytes.length} bytes from file.');
      final base64String = base64Encode(bytes);
      debugPrint('[SafePdfViewer] Base64 PDF size: ${base64String.length} chars.');
      if (!mounted) return;
      setState(() {
        _base64Data = base64String;
      });
      _trySendPdfToJs();
    } catch (e) {
      debugPrint('[SafePdfViewer] Error reading PDF: $e');
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
        _isLoading = false;
      });
      if (widget.onDocumentLoadFailed != null) {
        widget.onDocumentLoadFailed!(PdfDocumentLoadFailedDetails(
          e.toString(),
          'Failed to read local file bytes.',
        ));
      }
    }
  }

  void _trySendPdfToJs() {
    debugPrint('[SafePdfViewer] _trySendPdfToJs: base64Loaded=${_base64Data != null}, webviewReady=$_isWebviewReady');
    if (_base64Data != null && _isWebviewReady) {
      debugPrint('[SafePdfViewer] Executing JS loadPdfFromBase64...');
      _externalSafePdfViewerController._webViewController?.runJavaScript
          ?.call('loadPdfFromBase64("$_base64Data");');
    }
  }

  void _handleMessage(String messageJson) {
    debugPrint('[SafePdfViewer] _handleMessage: $messageJson');
    try {
      var data = jsonDecode(messageJson);
      if (data is String) {
        data = jsonDecode(data);
      }
      final type = data['type'];
      switch (type) {
        case 'ready':
          setState(() {
            _isWebviewReady = true;
          });
          _trySendPdfToJs();
          break;
        case 'loaded':
          final count = data['pageCount'] as int;
          debugPrint('[SafePdfViewer] PDF loaded successfully. Total pages: $count');
          _externalSafePdfViewerController._updatePageCount(count);
          setState(() {
            _isLoading = false;
          });
          if (widget.onDocumentLoaded != null) {
            widget.onDocumentLoaded!(PdfDocumentLoadedDetails(PdfDocument()));
          }
          break;
        case 'pageChanged':
          final pageNum = data['pageNumber'] as int;
          final oldPageNum = _externalSafePdfViewerController._currentPageNumber;
          if (pageNum != oldPageNum) {
            _externalSafePdfViewerController._updatePageNumber(pageNum);
            if (widget.onPageChanged != null) {
              widget.onPageChanged!(PdfPageChangedDetails(
                pageNum,
                oldPageNum,
                pageNum == 1,
                pageNum == _externalSafePdfViewerController.pageCount,
              ));
            }
          }
          break;
        case 'searchResult':
          final hasResult = data['hasResult'] as bool;
          final currentInstanceIndex = data['currentInstanceIndex'] as int;
          final totalInstanceCount = data['totalInstanceCount'] as int;
          _externalSafePdfViewerController._activeSearchResult?.update(
            hasResult: hasResult,
            currentInstanceIndex: currentInstanceIndex,
            totalInstanceCount: totalInstanceCount,
          );
          break;
        case 'error':
          final msg = data['message'] as String;
          debugPrint('[SafePdfViewer] JS Error: $msg');
          setState(() {
            _hasError = true;
            _errorMessage = msg;
            _isLoading = false;
          });
          if (widget.onDocumentLoadFailed != null) {
            widget.onDocumentLoadFailed!(PdfDocumentLoadFailedDetails(
              msg,
              'Error in WebView PDF rendering.',
            ));
          }
          break;
      }
    } catch (e) {
      debugPrint('[SafePdfViewer] Exception in _handleMessage: $e');
    }
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

    return PlatformWebView(
      html: _htmlTemplate,
      onMessage: _handleMessage,
      onJsError: (err) {
        debugPrint('[SafePdfViewer] PlatformWebView.onJsError: $err');
        setState(() {
          _hasError = true;
          _errorMessage = err;
          _isLoading = false;
        });
        if (widget.onDocumentLoadFailed != null) {
          widget.onDocumentLoadFailed!(PdfDocumentLoadFailedDetails(
            err,
            'JavaScript error in WebView.',
          ));
        }
      },
      onControllerCreated: (controller) {
        debugPrint('[SafePdfViewer] PlatformWebView.onControllerCreated');
        _externalSafePdfViewerController._webViewController = controller;
        _trySendPdfToJs();
      },
    );
  }
}

const String _htmlTemplate = """<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <meta http-equiv="Content-Security-Policy" content="default-src * 'unsafe-inline' 'unsafe-eval' data: blob:;">
  <script>
    window.onerror = function(message, source, lineno, colno, error) {
      var errStr = message + " (" + source + ":" + lineno + ")";
      if (window.DuoErrorChannel) {
        if (typeof window.DuoErrorChannel.postMessage === 'function') {
          window.DuoErrorChannel.postMessage(errStr);
        } else if (typeof window.DuoErrorChannel === 'function') {
          window.DuoErrorChannel(errStr);
        }
      } else {
        if (window.DuoMessageChannel) {
          var msg = JSON.stringify({type: 'error', message: errStr});
          if (typeof window.DuoMessageChannel.postMessage === 'function') {
            window.DuoMessageChannel.postMessage(msg);
          } else if (typeof window.DuoMessageChannel === 'function') {
            window.DuoMessageChannel(msg);
          }
        }
      }
      return false;
    };
  </script>
  <script>
    window.addEventListener('error', function(e) {
      if (e.target && (e.target.tagName === 'SCRIPT' || e.target.tagName === 'LINK')) {
        var errStr = "Failed to load resource: " + (e.target.src || e.target.href);
        if (window.DuoErrorChannel) {
          if (typeof window.DuoErrorChannel.postMessage === 'function') {
            window.DuoErrorChannel.postMessage(errStr);
          } else if (typeof window.DuoErrorChannel === 'function') {
            window.DuoErrorChannel(errStr);
          }
        } else {
          if (window.DuoMessageChannel) {
            var msg = JSON.stringify({type: 'error', message: errStr});
            if (typeof window.DuoMessageChannel.postMessage === 'function') {
              window.DuoMessageChannel.postMessage(msg);
            } else if (typeof window.DuoMessageChannel === 'function') {
              window.DuoMessageChannel(msg);
            }
          }
        }
      }
    }, true);
  </script>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #0b0f19;
      display: flex;
      flex-direction: column;
      align-items: center;
      overflow-x: hidden;
      overflow-y: auto;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    }
    #pdf-container {
      width: 100%;
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 20px;
      padding: 20px 0;
      box-sizing: border-box;
    }
    .page-wrapper {
      position: relative;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
      background-color: #1e293b;
      border-radius: 8px;
      overflow: hidden;
      display: flex;
      justify-content: center;
      align-items: center;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      width: 90vw;
      max-width: 800px;
    }
    .page-wrapper:hover {
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.6);
    }
    canvas {
      display: block;
      max-width: 100%;
      height: auto !important;
      animation: fadeIn 0.4s ease-in-out;
    }
    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }
    .loading-placeholder {
      position: absolute;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      color: #94a3b8;
      font-size: 14px;
      font-weight: 500;
    }
    .spinner {
      border: 3px solid rgba(255, 255, 255, 0.1);
      border-top: 3px solid #3b82f6;
      border-radius: 50%;
      width: 28px;
      height: 28px;
      animation: spin 1s linear infinite;
      margin-bottom: 12px;
    }
    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }
  </style>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js"></script>
</head>
<body>
  <div id="pdf-container"></div>
  <script>
    pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js';
    
    var pdfDoc = null;
    var container = document.getElementById('pdf-container');
    var pages = [];
    var currentScale = 1.5;
    var observer = null;
    var trackingObserver = null;
    
    var searchInstances = [];
    var currentSearchIndex = -1;

    function postDuoMessage(msg) {
      if (window.DuoMessageChannel) {
        if (typeof window.DuoMessageChannel.postMessage === 'function') {
          window.DuoMessageChannel.postMessage(msg);
        } else if (typeof window.DuoMessageChannel === 'function') {
          window.DuoMessageChannel(msg);
        }
      }
    }

    function postDuoError(err) {
      if (window.DuoErrorChannel) {
        if (typeof window.DuoErrorChannel.postMessage === 'function') {
          window.DuoErrorChannel.postMessage(err);
        } else if (typeof window.DuoErrorChannel === 'function') {
          window.DuoErrorChannel(err);
        }
      } else {
        postDuoMessage(JSON.stringify({type: 'error', message: err}));
      }
    }

    function checkReady() {
      if (window.DuoMessageChannel) {
        postDuoMessage(JSON.stringify({type: 'ready'}));
      } else {
        setTimeout(checkReady, 50);
      }
    }

    window.onload = function() {
      checkReady();
    };

    function loadPdfFromBase64(base64Data) {
      try {
        if (observer) observer.disconnect();
        if (trackingObserver) trackingObserver.disconnect();
        
        container.innerHTML = '';
        pages = [];
        searchInstances = [];
        currentSearchIndex = -1;
        
        var binaryString = atob(base64Data);
        var len = binaryString.length;
        var bytes = new Uint8Array(len);
        for (var i = 0; i < len; i++) {
          bytes[i] = binaryString.charCodeAt(i);
        }
        
        var loadingTask = pdfjsLib.getDocument({data: bytes});
        loadingTask.promise.then(function(pdf) {
          pdfDoc = pdf;
          
          postDuoMessage(JSON.stringify({
            type: 'loaded',
            pageCount: pdf.numPages
          }));
          
          pdf.getPage(1).then(function(firstPage) {
            var viewport = firstPage.getViewport({scale: 1.0});
            var aspectRatio = viewport.height / viewport.width;
            
            for (var i = 1; i <= pdf.numPages; i++) {
              createPagePlaceholder(i, aspectRatio);
            }
            
            setupObservers();
          });
        }, function(error) {
          postDuoError(error.message);
        });
      } catch (err) {
        postDuoError(err.message);
      }
    }

    function createPagePlaceholder(pageNum, aspectRatio) {
      var wrapper = document.createElement('div');
      wrapper.id = 'page-wrapper-' + pageNum;
      wrapper.className = 'page-wrapper';
      wrapper.setAttribute('data-page-number', pageNum);
      
      var width = Math.min(window.innerWidth * 0.9, 800);
      wrapper.style.height = (width * aspectRatio) + 'px';
      
      var placeholder = document.createElement('div');
      placeholder.className = 'loading-placeholder';
      
      var spinner = document.createElement('div');
      spinner.className = 'spinner';
      placeholder.appendChild(spinner);
      
      var text = document.createElement('div');
      text.innerText = 'Page ' + pageNum;
      placeholder.appendChild(text);
      
      wrapper.appendChild(placeholder);
      container.appendChild(wrapper);
      
      pages[pageNum] = {
        rendered: false,
        rendering: false,
        wrapper: wrapper,
        placeholder: placeholder,
        canvas: null,
        aspectRatio: aspectRatio
      };
    }

    function renderPage(pageNum) {
      if (!pdfDoc) return;
      var pageInfo = pages[pageNum];
      if (!pageInfo || pageInfo.rendered || pageInfo.rendering) return;
      
      pageInfo.rendering = true;
      
      pdfDoc.getPage(pageNum).then(function(page) {
        var viewport = page.getViewport({scale: currentScale});
        
        if (pageInfo.placeholder && pageInfo.placeholder.parentNode) {
          pageInfo.placeholder.parentNode.removeChild(pageInfo.placeholder);
          pageInfo.placeholder = null;
        }
        
        var canvas = document.createElement('canvas');
        var context = canvas.getContext('2d');
        canvas.height = viewport.height;
        canvas.width = viewport.width;
        
        var ratio = viewport.height / viewport.width;
        pageInfo.aspectRatio = ratio;
        pageInfo.wrapper.style.height = (pageInfo.wrapper.clientWidth * ratio) + 'px';
        
        pageInfo.wrapper.appendChild(canvas);
        pageInfo.canvas = canvas;
        
        var renderContext = {
          canvasContext: context,
          viewport: viewport
        };
        
        page.render(renderContext).promise.then(function() {
          pageInfo.rendered = true;
          pageInfo.rendering = false;
        });
      });
    }

    function setupObservers() {
      var renderOptions = {
        root: null,
        rootMargin: '600px 0px',
        threshold: 0.01
      };
      
      observer = new IntersectionObserver(function(entries) {
        entries.forEach(function(entry) {
          if (entry.isIntersecting) {
            var pageNum = parseInt(entry.target.getAttribute('data-page-number'));
            renderPage(pageNum);
          }
        });
      }, renderOptions);
      
      var trackingOptions = {
        root: null,
        rootMargin: '-45% 0px -45% 0px',
        threshold: 0
      };
      
      trackingObserver = new IntersectionObserver(function(entries) {
        entries.forEach(function(entry) {
          if (entry.isIntersecting) {
            var pageNum = parseInt(entry.target.getAttribute('data-page-number'));
            postDuoMessage(JSON.stringify({
              type: 'pageChanged',
              pageNumber: pageNum
            }));
          }
        });
      }, trackingOptions);
      
      for (var i = 1; i <= pdfDoc.numPages; i++) {
        if (pages[i]) {
          observer.observe(pages[i].wrapper);
          trackingObserver.observe(pages[i].wrapper);
        }
      }
    }

    function jumpToPage(pageNum) {
      var pageInfo = pages[pageNum];
      if (pageInfo && pageInfo.wrapper) {
        pageInfo.wrapper.scrollIntoView({behavior: 'smooth', block: 'start'});
        renderPage(pageNum);
      }
    }

    function setZoom(zoomFactor) {
      currentScale = 1.5 * zoomFactor;
      for (var i = 1; i <= pages.length; i++) {
        var pageInfo = pages[i];
        if (pageInfo) {
          var width = Math.min(window.innerWidth * 0.9, 800);
          pageInfo.wrapper.style.height = (width * pageInfo.aspectRatio) + 'px';
          
          if (pageInfo.rendered) {
            if (pageInfo.canvas && pageInfo.canvas.parentNode) {
              pageInfo.canvas.parentNode.removeChild(pageInfo.canvas);
            }
            pageInfo.rendered = false;
            pageInfo.rendering = false;
            renderPage(i);
          }
        }
      }
    }

    function scrollToOffset(x, y) {
      if (y > 500000) {
        window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });
      } else if (y === 0 && x === 0) {
        window.scrollTo({ top: 0, behavior: 'smooth' });
      } else {
        window.scrollTo({ left: x, top: y, behavior: 'smooth' });
      }
    }

    function performSearch(query) {
      searchInstances = [];
      currentSearchIndex = -1;
      if (!pdfDoc || !query) {
        reportSearchResults();
        return;
      }
      
      var queryLower = query.toLowerCase();
      var promises = [];
      
      for (var i = 1; i <= pdfDoc.numPages; i++) {
        (function(pageNum) {
          promises.push(
            pdfDoc.getPage(pageNum).then(function(page) {
              return page.getTextContent().then(function(textContent) {
                var pageText = textContent.items.map(function(item) { return item.str; }).join(' ');
                var idx = 0;
                while (true) {
                  idx = pageText.toLowerCase().indexOf(queryLower, idx);
                  if (idx === -1) break;
                  searchInstances.push({
                    pageNum: pageNum,
                    index: idx
                  });
                  idx += queryLower.length;
                }
              });
            })
          );
        })(i);
      }
      
      Promise.all(promises).then(function() {
        searchInstances.sort(function(a, b) {
          if (a.pageNum !== b.pageNum) return a.pageNum - b.pageNum;
          return a.index - b.index;
        });
        
        if (searchInstances.length > 0) {
          currentSearchIndex = 0;
          jumpToSearchInstance(0);
        }
        reportSearchResults();
      });
    }

    function jumpToSearchInstance(index) {
      if (index < 0 || index >= searchInstances.length) return;
      var instance = searchInstances[index];
      jumpToPage(instance.pageNum);
    }

    function nextSearchInstance() {
      if (searchInstances.length === 0) return;
      currentSearchIndex = (currentSearchIndex + 1) % searchInstances.length;
      jumpToSearchInstance(currentSearchIndex);
      reportSearchResults();
    }

    function prevSearchInstance() {
      if (searchInstances.length === 0) return;
      currentSearchIndex = (currentSearchIndex - 1 + searchInstances.length) % searchInstances.length;
      jumpToSearchInstance(currentSearchIndex);
      reportSearchResults();
    }

    function clearSearch() {
      searchInstances = [];
      currentSearchIndex = -1;
      reportSearchResults();
    }

    function reportSearchResults() {
      postDuoMessage(JSON.stringify({
        type: 'searchResult',
        hasResult: searchInstances.length > 0,
        currentInstanceIndex: currentSearchIndex + 1,
        totalInstanceCount: searchInstances.length
      }));
    }
  </script>
</body>
</html>
""";
