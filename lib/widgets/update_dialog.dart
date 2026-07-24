import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/update_service.dart';

/// Shows the "What's new" update sheet for [info]. Returns when dismissed.
Future<void> showUpdateDialog(BuildContext context, UpdateInfo info) {
  UpdateService.instance.markPrompted();
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => UpdateDialog(info: info),
  );
}

enum _Stage { prompt, downloading, ready, failed }

class UpdateDialog extends StatefulWidget {
  final UpdateInfo info;
  const UpdateDialog({super.key, required this.info});

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  final _service = UpdateService.instance;
  _Stage _stage = _Stage.prompt;
  File? _apk;

  @override
  void initState() {
    super.initState();
    // If we already fully downloaded this version in a previous session, jump
    // straight to the install step instead of re-downloading.
    _service.cachedApk(widget.info).then((file) {
      if (file != null && mounted) {
        setState(() {
          _apk = file;
          _stage = _Stage.ready;
        });
      }
    });
  }

  Future<void> _download() async {
    setState(() => _stage = _Stage.downloading);
    final file = await _service.downloadApk(widget.info);
    if (!mounted) return;
    setState(() {
      _apk = file;
      _stage = file != null ? _Stage.ready : _Stage.failed;
    });
  }

  Future<void> _install() async {
    final apk = _apk;
    if (apk == null) return;
    await _service.installApk(apk);
    // Leave the dialog up — the OS installer takes over; the user returns here.
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final info = widget.info;

    return AlertDialog(
      backgroundColor: cs.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(LucideIcons.sparkles, size: 20, color: cs.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Update available',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                Text('Version ${info.versionName}',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface.withValues(alpha: 0.6))),
              ],
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: MarkdownBody(
                  data: info.changelog,
                  onTapLink: (text, href, title) {
                    if (href != null) {
                      launchUrl(Uri.parse(href),
                          mode: LaunchMode.externalApplication);
                    }
                  },
                  styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                      .copyWith(
                    p: TextStyle(
                        fontSize: 14,
                        height: 1.45,
                        color: cs.onSurface.withValues(alpha: 0.85)),
                    listBullet: TextStyle(
                        fontSize: 14, color: cs.onSurface.withValues(alpha: 0.85)),
                    h1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: cs.onSurface),
                    h2: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: cs.onSurface),
                    h3: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface),
                  ),
                ),
              ),
            ),
            if (_stage == _Stage.downloading) ...[
              const SizedBox(height: 20),
              _DownloadProgress(progress: _service.downloadProgress),
            ],
            if (_stage == _Stage.failed) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(LucideIcons.alertTriangle, size: 16, color: cs.error),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('Download failed. Check your connection and try again.',
                        style: TextStyle(fontSize: 13, color: cs.error)),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      actions: _actions(cs),
    );
  }

  List<Widget> _actions(ColorScheme cs) {
    switch (_stage) {
      case _Stage.downloading:
        return [
          TextButton(
            onPressed: null,
            child: Text('Downloading…',
                style: TextStyle(color: cs.onSurface.withValues(alpha: 0.5))),
          ),
        ];
      case _Stage.ready:
        return [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Later'),
          ),
          FilledButton.icon(
            onPressed: _install,
            icon: const Icon(LucideIcons.download, size: 18),
            label: const Text('Install'),
          ),
        ];
      case _Stage.failed:
        return [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Later'),
          ),
          FilledButton.icon(
            onPressed: _download,
            icon: const Icon(LucideIcons.refreshCw, size: 18),
            label: const Text('Retry'),
          ),
        ];
      case _Stage.prompt:
        return [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Later'),
          ),
          FilledButton.icon(
            onPressed: _download,
            icon: const Icon(LucideIcons.download, size: 18),
            label: const Text('Update'),
          ),
        ];
    }
  }
}

class _DownloadProgress extends StatelessWidget {
  final ValueNotifier<double> progress;
  const _DownloadProgress({required this.progress});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ValueListenableBuilder<double>(
      valueListenable: progress,
      builder: (context, value, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: value > 0 ? value : null,
                minHeight: 8,
                backgroundColor: cs.onSurface.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value > 0 ? 'Downloading… ${(value * 100).toStringAsFixed(0)}%'
                        : 'Starting download…',
              style: TextStyle(
                  fontSize: 12, color: cs.onSurface.withValues(alpha: 0.6)),
            ),
          ],
        );
      },
    );
  }
}