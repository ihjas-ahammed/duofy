import 'package:flutter/material.dart';

/// A wrapper around [IndexedStack] that lazily instantiates its children
/// when they are first navigated to. This is crucial for performance, as it
/// prevents heavy screens from building and executing expensive lifecycle methods
/// before they are actually visible.
class LazyIndexedStack extends StatefulWidget {
  final int index;
  final List<WidgetBuilder> builders;
  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final StackFit fit;

  const LazyIndexedStack({
    super.key,
    required this.index,
    required this.builders,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.fit = StackFit.loose,
  });

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late List<bool> _activated;

  @override
  void initState() {
    super.initState();
    _activated = List.generate(
      widget.builders.length,
      (i) => i == widget.index,
    );
  }

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_activated.length != widget.builders.length) {
      _activated = List.generate(
        widget.builders.length,
        (i) => i < _activated.length ? _activated[i] : (i == widget.index),
      );
    }
    if (widget.index >= 0 && widget.index < _activated.length && !_activated[widget.index]) {
      _activated[widget.index] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.index,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      fit: widget.fit,
      children: List.generate(widget.builders.length, (i) {
        if (_activated[i]) {
          return widget.builders[i](context);
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
