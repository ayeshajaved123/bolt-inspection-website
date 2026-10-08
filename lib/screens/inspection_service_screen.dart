import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/simple_page_scaffold.dart';

class InspectionServiceScreen extends StatelessWidget {
  const InspectionServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePageScaffold(
      title: 'Inspection Services',
      body: Text(
        'Utilizing cutting-edge equipment and creative methods, we offer thorough '
        'inspection services. To assure the security, dependability, and compliance '
        'of your priceless assets, our team of skilled professionals performs '
        'in-depth evaluations.\n\n'
        'Replace this placeholder with the full Inspection Service page content '
        '(scope of inspections, equipment types, certifications, process steps).',
        style: TextStyle(fontSize: 16, color: AppColors.charcoal, height: 1.6),
      ),
    );
  }
}
