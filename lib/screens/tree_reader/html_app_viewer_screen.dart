import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../platform/io_shim.dart';
import '../../widgets/platform_webview.dart';

/// Full-screen interactive viewer for the standalone STEM HTML applications
/// located under docs/apps (e.g. PYTHON_12.html, LATEX_1.html, SOLID_STATE_1.html).
class HtmlAppViewerScreen extends StatefulWidget {
  final String title;
  final String htmlAssetPath;

  const HtmlAppViewerScreen({
    super.key,
    required this.title,
    required this.htmlAssetPath,
  });

  @override
  State<HtmlAppViewerScreen> createState() => _HtmlAppViewerScreenState();
}

class _HtmlAppViewerScreenState extends State<HtmlAppViewerScreen> {
  String? _htmlContent;
  String? _error;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFile();
  }

  Future<void> _loadFile() async {
    try {
      // 1. Try Flutter asset bundle (works on Android, iOS, Web, Desktop)
      try {
        final content = await rootBundle.loadString(widget.htmlAssetPath);
        if (content.isNotEmpty) {
          setState(() {
            _htmlContent = content;
            _isLoading = false;
          });
          return;
        }
      } catch (_) {}

      // 2. Try file system
      final file = File(widget.htmlAssetPath);
      if (await file.exists()) {
        final content = await file.readAsString();
        setState(() {
          _htmlContent = content;
          _isLoading = false;
        });
        return;
      }

      // 3. Try relative to workspace
      final altFile = File('/home/ihjas/Documents/GitHub/duofy/${widget.htmlAssetPath}');
      if (await altFile.exists()) {
        final content = await altFile.readAsString();
        setState(() {
          _htmlContent = content;
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _error = 'Could not locate file at ${widget.htmlAssetPath}';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading document: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.refreshCw, size: 18),
            tooltip: 'Reload',
            onPressed: () {
              setState(() {
                _isLoading = true;
                _error = null;
              });
              _loadFile();
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LucideIcons.alertCircle, size: 36, color: Colors.red),
              const SizedBox(height: 12),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }

    return PlatformWebView(
      html: _htmlContent ?? '',
    );
  }
}
