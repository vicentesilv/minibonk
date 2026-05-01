
import 'package:flutter/widgets.dart';

class PreviewAnim extends StatefulWidget {
  const PreviewAnim({super.key, required this.frames});

  final List<String> frames;

  @override
  State<PreviewAnim> createState() => _PreviewAnimState();
}

class _PreviewAnimState extends State<PreviewAnim> {
  int _frame = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || widget.frames.length <= 1) {
        return;
      }
      _tick();
    });
  }

  Future<void> _tick() async {
    while (mounted) {
      await Future<void>.delayed(const Duration(milliseconds: 350));
      if (!mounted) return;
      setState(() {
        _frame = (_frame + 1) % widget.frames.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.frames[_frame],
      fit: BoxFit.contain,
      filterQuality: FilterQuality.none,
      gaplessPlayback: true,
    );
  }
}
