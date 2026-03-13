import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InteractiveWebview extends StatefulWidget {
  final String url;

  const InteractiveWebview({super.key, required this.url});

  @override
  State<InteractiveWebview> createState() => _InteractiveWebviewState();
}

class _InteractiveWebviewState extends State<InteractiveWebview> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white12),
      ),
      clipBehavior: Clip.hardEdge,
      child: WebViewWidget(controller: _controller),
    );
  }
}