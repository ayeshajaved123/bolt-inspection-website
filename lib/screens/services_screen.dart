import 'package:flutter/material.dart';
import '../widgets/simple_page_scaffold.dart';
import '../widgets/service_card.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePageScaffold(
      title: 'Services',
      body: Column(
        children: [
          ServiceCard(
            icon: Icons.fact_check_outlined,
            title: 'Inspection Services',
            description: 'Third-party inspection for heavy equipment, lifting tools, cranes, '
                'and related assets, fully compliant with international standards.',
            onReadMore: () => Navigator.pushNamed(context, '/services/inspection'),
          ),
          const SizedBox(height: 20),
          ServiceCard(
            icon: Icons.groups_outlined,
            title: 'Training Services',
            description: 'Professional training programs to enhance skills, ensure safety, and '
                'support compliance with industry regulations.',
            onReadMore: () => Navigator.pushNamed(context, '/services/training'),
          ),
        ],
      ),
    );
  }
}
