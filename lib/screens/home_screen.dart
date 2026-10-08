import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/nav_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/service_card.dart';
import '../widgets/stats_bar.dart';
import '../widgets/cert_badges.dart';
import '../widgets/contact_form.dart';
import '../widgets/site_footer.dart';
import '../widgets/page_container.dart';
import '../widgets/fade_slide_in.dart';
import '../models/stat_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(onCtaPressed: () => Navigator.pushNamed(context, '/contact')),
            PageContainer(child: _ServicesRow()),
            const StatsBar(
              stats: [
                StatModel(value: '2,521+', label: 'Completed Projects'),
                StatModel(value: '12+', label: 'Countries Served'),
                StatModel(value: '15+', label: 'Years of Experience'),
              ],
            ),
            const CertBadges(),
            PageContainer(child: _ContactSection()),
            const SiteFooter(),
          ],
        ),
      ),
    );
  }
}

/// The two headline service cards. Side-by-side (equal height) on wide screens,
/// stacked on narrow ones — without ever putting an [Expanded] inside a Column.
class _ServicesRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inspection = FadeSlideIn(
      child: ServiceCard(
        icon: Icons.fact_check_outlined,
        title: 'Inspection Services',
        description: 'We provide third-party inspection services for heavy '
            'equipment, lifting tools, cranes, and related assets in '
            'compliance with international standards.',
        onReadMore: () => Navigator.pushNamed(context, '/services/inspection'),
      ),
    );
    final training = FadeSlideIn(
      delay: const Duration(milliseconds: 90),
      child: ServiceCard(
        icon: Icons.groups_outlined,
        title: 'Training Services',
        description: 'We deliver professional training programs designed to '
            'enhance skills, ensure safety, and support compliance with '
            'industry regulations.',
        onReadMore: () => Navigator.pushNamed(context, '/services/training'),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 900;
        if (isNarrow) {
          return Column(
            children: [inspection, const SizedBox(height: 24), training],
          );
        }
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: inspection),
              const SizedBox(width: 24),
              Expanded(child: training),
            ],
          ),
        );
      },
    );
  }
}

/// "Get In Touch" form + offices list. Two columns on wide screens, stacked on
/// narrow ones.
class _ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final form = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Get In Touch',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.navy)),
        Container(
          width: 40,
          height: 3,
          color: AppColors.red,
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
        const Text(
          'Have a question or need an inspection? Fill out the form and our team will get back to you.',
          style: TextStyle(color: AppColors.textSecondary, height: 1.5),
        ),
        const SizedBox(height: 24),
        const ContactForm(),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 900;
        if (isNarrow) {
          return FadeSlideIn(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [form, const SizedBox(height: 32), const _OfficesList()],
            ),
          );
        }
        return FadeSlideIn(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: form),
              const SizedBox(width: 40),
              const Expanded(flex: 2, child: _OfficesList()),
            ],
          ),
        );
      },
    );
  }
}

class _OfficesList extends StatelessWidget {
  const _OfficesList();

  static const offices = {
    'Riyadh': '+966 11 271 0460',
    'Jeddah': '+966 12 605 0590',
    'Dammam': '+966 13 833 1961',
    'Tabuk': '+966 14 427 0370',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Our Offices',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.navy)),
        const SizedBox(height: 16),
        ...offices.entries.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(Icons.location_on, color: AppColors.red, size: 18),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.key,
                        style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.navy)),
                    Text(e.value,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
