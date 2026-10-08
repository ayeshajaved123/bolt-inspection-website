import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'fade_slide_in.dart';

class HeroSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final String ctaLabel;
  final VoidCallback onCtaPressed;

  const HeroSection({
    super.key,
    this.title = 'Delivering The Trust',
    this.subtitle = 'ISO 17020 compliant inspection services you can rely on, across Saudi Arabia.',
    this.ctaLabel = 'Contact Us',
    required this.onCtaPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Slightly shorter on small screens so the hero doesn't dominate the fold.
    final isNarrow = MediaQuery.of(context).size.width < 700;
    return Container(
      height: isNarrow ? 360 : 460,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          // See assets/images/hero_crane_inspection.jpg
          image: AssetImage('assets/images/hero_crane_inspection.jpg'),
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
        color: AppColors.navy, // shows if the image asset is missing
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.navy.withValues(alpha: 0.94),
              AppColors.navy.withValues(alpha: 0.60),
              AppColors.navy.withValues(alpha: 0.20),
            ],
          ),
        ),
        // Content is capped to a centered max-width container (so it lines up
        // with the nav logo and the sections below), then anchored to the left
        // edge of that container rather than floating in the middle.
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FadeSlideIn(
                      child: SizedBox(
                        width: 48,
                        height: 4,
                        child: DecoratedBox(decoration: BoxDecoration(color: AppColors.amber)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeSlideIn(
                      delay: const Duration(milliseconds: 70),
                      child: Text(title, style: Theme.of(context).textTheme.headlineLarge),
                    ),
                    const SizedBox(height: 16),
                    FadeSlideIn(
                      delay: const Duration(milliseconds: 140),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 480),
                        child: Text(
                          subtitle,
                          style: const TextStyle(color: AppColors.onNavySecondary, fontSize: 16, height: 1.55),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    FadeSlideIn(
                      delay: const Duration(milliseconds: 210),
                      child: ElevatedButton.icon(
                        onPressed: onCtaPressed,
                        icon: const Icon(Icons.arrow_forward, size: 18),
                        label: Text(ctaLabel),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
