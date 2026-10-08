import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/simple_page_scaffold.dart';

class TrainingServiceScreen extends StatelessWidget {
  const TrainingServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePageScaffold(
      title: 'Training Services',
      body: Text(
        'To improve the skills and knowledge of your team, we create and implement '
        'specialized training programs. Our training programs give your team the '
        'knowledge and abilities they need to operate efficiently, safely, and in '
        'accordance with all relevant rules and laws.\n\n'
        'Replace this placeholder with the full Training Service page content '
        '(course list, schedules, certification bodies, sign-up process).',
        style: TextStyle(fontSize: 16, color: AppColors.charcoal, height: 1.6),
      ),
    );
  }
}
