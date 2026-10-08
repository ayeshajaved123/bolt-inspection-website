import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 900;
    return Container(
      color: AppColors.navy,
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Flex(
                  direction: isNarrow ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // White/mono version — see assets/logos/logo_white.png
                          Image.asset(
                            'assets/logos/logo_white.png',
                            height: 40,
                            errorBuilder: (_, __, ___) => const Text(
                              'Bolt Inspection',
                              style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w800, fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'ISO 17020 accredited inspection body delivering trusted '
                            'inspection and certification services across Saudi Arabia.',
                            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => _launch('https://www.facebook.com/boltinspection'),
                                icon: const Icon(Icons.facebook, color: AppColors.white),
                              ),
                              IconButton(
                                onPressed: () => _launch('https://www.linkedin.com/company/boltinspection'),
                                icon: const Icon(Icons.business_center, color: AppColors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24, height: 24),
                    const _FooterColumn(title: 'Quick Links', items: ['Home', 'About Us', 'Services', 'Contact Us']),
                    const SizedBox(width: 24, height: 24),
                    const _FooterColumn(title: 'Our Services', items: ['Inspection Services', 'Training Services']),
                    const SizedBox(width: 24, height: 24),
                    const _FooterColumn(title: 'Our Offices', items: ['Riyadh', 'Jeddah', 'Dammam', 'Tabuk']),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(color: Colors.white24),
                const SizedBox(height: 12),
                const Text(
                  '© 2026 Bolt Inspection. All rights reserved.',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> items;
  const _FooterColumn({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 12),
          ...items.map(
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(i, style: const TextStyle(color: Colors.white70, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}
