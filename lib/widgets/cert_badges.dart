import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import 'hover_builder.dart';

class CertBadges extends StatelessWidget {
  const CertBadges({super.key});

  // Most of these logo files are white-on-transparent marks, which disappear on
  // a light background. We seat every logo on a white tile and tint the
  // monochrome ISO marks navy so they read; the full-color Vision 2030 mark is
  // left untinted (`tint: false`).
  static const _badges = <_CertItem>[
    _CertItem('assets/certifications/cert_iso_9001.png'),
    _CertItem('assets/certifications/cert_iso_17020.png'),
    _CertItem('assets/certifications/cert_vision_2030.png'),
    _CertItem('assets/certifications/cert_saudi_accreditation.png', tint: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.navyTint,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1040),
          child: Column(
            children: [
              const Text(
                'ACCREDITED & CERTIFIED',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(width: 40, height: 3, color: AppColors.amber),
              const SizedBox(height: 32),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 24,
                runSpacing: 24,
                children: _badges.map((b) => _Badge(item: b)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CertItem {
  final String path;

  /// Whether to tint the (white) logo navy. Full-color marks pass `false`.
  final bool tint;
  const _CertItem(this.path, {this.tint = true});
}

/// A single certification logo on a white tile, sized so logos of different
/// aspect ratios align on a common baseline without distortion.
class _Badge extends StatelessWidget {
  final _CertItem item;
  const _Badge({required this.item});

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      cursor: MouseCursor.defer,
      builder: (context, hovering) => AnimatedContainer(
        duration: AppMotion.fast,
        curve: AppMotion.standard,
        width: 180,
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        transform: Matrix4.translationValues(0, hovering ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy.withValues(alpha: hovering ? 0.16 : 0.07),
              blurRadius: hovering ? 20 : 12,
              offset: Offset(0, hovering ? 10 : 5),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Image.asset(
          item.path,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
          color: item.tint ? AppColors.navy : null,
          colorBlendMode: item.tint ? BlendMode.srcIn : BlendMode.dst,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.verified,
            color: AppColors.navy,
            size: 40,
          ),
        ),
      ),
    );
  }
}
