import 'package:flutter/material.dart';

/// Centralized Motion and Interaction Micro-Timing System.
///
/// Defines fixed animation duration steps and consistent motion physics
/// curves to enforce a unified interactive signature across UI state shifts.
class AnimationConstants {
  const AnimationConstants._(); // Prevents instantiation

  /// ==========================================
  /// 1. DURATION SCALE TOKENS
  /// ==========================================

  /// Used for instantaneous responsive feedback like tap highlights or small scaling shifts.
  static const Duration durationFast = Duration(milliseconds: 150);

  /// Standard duration for general layout visibility changes and card switches.
  static const Duration durationNormal = Duration(milliseconds: 300);

  /// Used for major spatial layouts like page cross-fades or large modal drawer slides.
  static const Duration durationSlow = Duration(milliseconds: 500);

  /// Perfect cycle length for background placeholder loading skeleton gradients.
  static const Duration durationShimmerLoop = Duration(milliseconds: 1500);

  /// ==========================================
  /// 2. MOTION PHYSICS CURVES
  /// ==========================================

  /// Standard entrance physics acceleration style.
  static const Curve curveDefaultEntrance = Curves.easeOutCubic;

  /// Smooth acceleration physics for components moving off-canvas.
  static const Curve curveDefaultExit = Curves.easeInCubic;

  /// Snappy spring effect tailored for modal popups or action sheet springboards.
  static const Curve curveSpringBack = Curves.easeOutBack;
}
