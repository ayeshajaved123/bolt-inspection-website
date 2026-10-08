import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/simple_page_scaffold.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePageScaffold(
      title: 'About Us',
      body: Text(
        'Bolt Inspection is an ISO 9001 certified leading provider of inspection '
        'services for heavy equipment, lifting tools, and cranes in Saudi Arabia. '
        'We are committed to delivering the highest standards of safety, quality, '
        'and compliance through our ISO 17020 accredited inspection services.\n\n'
        'Replace this placeholder copy with the real About Us content from the '
        'current site (careers info, client list, company history, etc.).',
        style: TextStyle(fontSize: 16, color: AppColors.charcoal, height: 1.6),
      ),
    );
  }
}
