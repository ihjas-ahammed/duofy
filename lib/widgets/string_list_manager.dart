import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';

class StringListManager extends StatefulWidget {
  final List<String> initialItems;
  final String hintText;
  final IconData itemIcon;
  final Function(List<String>) onChanged;

  const StringListManager({
    super.key,
    required this.initialItems,
    required this.hintText,
    required this.itemIcon,
    required this.onChanged
  });

  @override
  State<StringListManager> createState() => StringListManagerState();
}

class StringListManagerState extends State<StringListManager> {
  late List<String> _items;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.initialItems);
  }

  /// Commits whatever is currently typed in the input field as an item.
  /// Returns true if something was added. Safe to call when empty.
  bool commitPending() {
    return _addItem();
  }

  bool _addItem() {
    final val = _controller.text.trim();
    if (val.isNotEmpty && !_items.contains(val)) {
      if (_items.length >= 5) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Maximum 5 items allowed.')));
        return false;
      }
      setState(() {
        _items.add(val);
        _controller.clear();
      });
      widget.onChanged(_items);
      return true;
    }
    return false;
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    widget.onChanged(_items);
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
                onSubmitted: (_) => _addItem(),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.black26,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _addItem,
              child: Container(
                padding: const EdgeInsets.all(14),
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
        if (_items.isNotEmpty) const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _items.length,
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
                  Icon(widget.itemIcon, color: Colors.amber, size: 18),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _items[index],
                      style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _removeItem(index),
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