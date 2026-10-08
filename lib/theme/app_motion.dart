import 'package:flutter/animation.dart';

/// Motion tokens. Deliberately short and restrained — this is an industrial /
/// compliance brand, so transitions are quick and functional with no bounce or
/// overshoot. Durations sit inside the 150–400ms "subtle" band; curves are all
/// decelerating (ease-out) so motion settles rather than springs.
class AppMotion {
  AppMotion._();

  /// Micro-interactions: hover fills, color shifts, small elevation changes.
  static const Duration fast = Duration(milliseconds: 160);

  /// Default for most transitions: entrance fades/slides, card lifts.
  static const Duration base = Duration(milliseconds: 240);

  /// Larger entrance moves that should still feel crisp.
  static const Duration slow = Duration(milliseconds: 360);

  /// Standard entrance curve — decelerates into place, never overshoots.
  static const Curve enter = Curves.easeOutCubic;

  /// Symmetric curve for reversible state (hover in/out).
  static const Curve standard = Curves.easeInOut;

  /// Vertical offset (logical px) for fade-and-rise entrance animations.
  static const double riseOffset = 16;
}
