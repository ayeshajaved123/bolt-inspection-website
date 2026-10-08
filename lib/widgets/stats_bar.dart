import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/stat_model.dart';

class StatsBar extends StatelessWidget {
  final List<StatModel> stats;
  const StatsBar({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.navy,
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 48,
              runSpacing: 24,
              children: stats.map((s) => _StatItem(stat: s)).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final StatModel stat;
  const _StatItem({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.verified_outlined, color: AppColors.amber, size: 32),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stat.value,
              style: const TextStyle(color: AppColors.amber, fontSize: 28, fontWeight: FontWeight.w800),
            ),
            Text(stat.label, style: const TextStyle(color: AppColors.onNavySecondary, fontSize: 13)),
          ],
        ),
      ],
    );
  }
}
