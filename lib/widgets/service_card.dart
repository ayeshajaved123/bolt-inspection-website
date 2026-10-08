import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import 'hover_builder.dart';

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onReadMore;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onReadMore,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context, hovering) => AnimatedContainer(
        duration: AppMotion.fast,
        curve: AppMotion.standard,
        transform: Matrix4.translationValues(0, hovering ? -4 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: const Border(top: BorderSide(color: AppColors.amber, width: 3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: hovering ? 0.12 : 0.05),
              blurRadius: hovering ? 22 : 12,
              offset: Offset(0, hovering ? 10 : 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: AppColors.navy, size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(description, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 14),
                  _ReadMore(onTap: onReadMore, nudge: hovering),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReadMore extends StatelessWidget {
  final VoidCallback onTap;
  final bool nudge;
  const _ReadMore({required this.onTap, required this.nudge});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Read More',
                style: TextStyle(color: AppColors.red, fontWeight: FontWeight.w600)),
            const SizedBox(width: 6),
            AnimatedSlide(
              duration: AppMotion.fast,
              curve: AppMotion.standard,
              offset: Offset(nudge ? 0.35 : 0, 0),
              child: const Icon(Icons.arrow_forward, size: 16, color: AppColors.red),
            ),
          ],
        ),
      ),
    );
  }
}
