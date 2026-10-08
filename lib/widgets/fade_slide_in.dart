import 'package:flutter/material.dart';
import '../theme/app_motion.dart';

/// Plays a single, subtle "fade and rise" entrance when the widget first
/// mounts: opacity 0→1 while translating up by [AppMotion.riseOffset].
///
/// Use [delay] to stagger a group of items (e.g. cards) so they settle in
/// sequence rather than all at once. Honors the platform "reduce motion"
/// setting — when animations are disabled the child appears immediately.
class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;

  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = AppMotion.base,
  });

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: widget.duration);
  late final Animation<double> _curved =
      CurvedAnimation(parent: _controller, curve: AppMotion.enter);

  @override
  void initState() {
    super.initState();
    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Respect users who prefer reduced motion.
    if (MediaQuery.maybeOf(context)?.disableAnimations ?? false) {
      return widget.child;
    }
    return AnimatedBuilder(
      animation: _curved,
      builder: (context, child) => Opacity(
        opacity: _curved.value,
        child: Transform.translate(
          offset: Offset(0, (1 - _curved.value) * AppMotion.riseOffset),
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
