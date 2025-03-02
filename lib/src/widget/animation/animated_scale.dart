import 'package:flutter/widgets.dart';

/// A implicit animated widget than update the child's scale depending on the
/// parameter `scale` and `duration`
///
/// eg: in an stateful widget
///
/// double _scale = 1;
///
/// AnimatedScale(
///   scale: _scale,
///   child: /* a widget */
/// )
///
/// then use
///
/// setState((){
///   _scale = 0.5
/// });
///
/// This will animate the child's scale from 1 to 0.5 in 150ms (default duration)
///
class AnimatedScale extends StatefulWidget {
  final Widget? child;
  final double scale;
  final Duration duration;
  final Alignment alignment;
  final FilterQuality? filterQuality;
  final Curve curve;

  const AnimatedScale({
    this.child,
    this.scale = 1,
    this.duration = const Duration(milliseconds: 150),
    this.alignment = Alignment.center,
    this.filterQuality,
    this.curve = Curves.linear,
  });

  @override
  _AnimatedScaleState createState() => _AnimatedScaleState();
}

class _AnimatedScaleState extends State<AnimatedScale>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _animation = ConstantTween<double>(widget.scale).animate(_controller);
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedScale oldWidget) {
    if (oldWidget.scale != widget.scale) {
      final double oldScale = _animation.value;
      final double newScale = widget.scale;
      _animation = Tween<double>(
        begin: oldScale,
        end: newScale,
      ).animate(_controller);
      if (newScale > oldScale) {
        _controller.animateTo(
          newScale,
          duration: widget.duration,
          curve: widget.curve,
        );
      } else if (newScale < oldScale) {
        _controller.animateBack(
          newScale,
          duration: widget.duration,
          curve: widget.curve,
        );
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      alignment: widget.alignment,
      filterQuality: widget.filterQuality,
      child: widget.child,
    );
  }
}
