import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';

class ApiKeysManager extends StatefulWidget {
  final List<String> initialKeys;
  final Function(List<String>) onChanged;

  const ApiKeysManager({super.key, required this.initialKeys, required this.onChanged});

  @override
  State<ApiKeysManager> createState() => _ApiKeysManagerState();
}

class _ApiKeysManagerState extends State<ApiKeysManager> {
  late List<String> _keys;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _keys = List.from(widget.initialKeys);
  }

  void _addKey() {
    final val = _controller.text.trim();
    if (val.isNotEmpty && !_keys.contains(val)) {
      setState(() {
        _keys.add(val);
        _controller.clear();
      });
      widget.onChanged(_keys);
    }
  }

  void _removeKey(int index) {
    setState(() {
      _keys.removeAt(index);
    });
    widget.onChanged(_keys);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children:[
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter API Key',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.black26,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _addKey,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.duoGreen,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.duoGreenDark, width: 2),
                ),
                child: const Icon(LucideIcons.plus, color: Colors.white),
              ),
            )
          ],
        ),
        if (_keys.isNotEmpty) const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _keys.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children:[
                  const Icon(LucideIcons.key, color: Colors.amber, size: 18),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _keys[index],
                      style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _removeKey(index),
                    child: const Icon(LucideIcons.trash2, color: AppTheme.duoRed, size: 20),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}