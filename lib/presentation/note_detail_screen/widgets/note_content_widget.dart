import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

/// Widget displaying note content with zoom and selection capabilities
class NoteContentWidget extends StatefulWidget {
  final String content;

  const NoteContentWidget({super.key, required this.content});

  @override
  State<NoteContentWidget> createState() => _NoteContentWidgetState();
}

class _NoteContentWidgetState extends State<NoteContentWidget> {
  double _textScale = 1.0;
  static const double _minScale = 0.8;
  static const double _maxScale = 2.0;

  void _handleDoubleTap() {
    HapticFeedback.mediumImpact();
    setState(() {
      _textScale = _textScale == 1.0 ? 1.5 : 1.0;
    });
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _textScale = (_textScale * details.scale).clamp(_minScale, _maxScale);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      onScaleUpdate: _handleScaleUpdate,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SelectableText(
          widget.content,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: (16 * _textScale).sp,
            height: 1.6,
            color: theme.colorScheme.onSurface,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
