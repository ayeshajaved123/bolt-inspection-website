import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/admin_shell.dart';

/// Media manager placeholder.
///
/// Full drag-and-drop upload to Firebase Storage needs the `firebase_storage`
/// package added and Storage enabled in your Firebase project — intentionally
/// left as the next increment rather than half-wired, since it wasn't part
/// of the config values exchanged yet. The screen below is the real layout;
/// wiring the upload button to Storage is a small, isolated follow-up once
/// Storage is enabled on your project.
class AdminMediaScreen extends StatelessWidget {
  const AdminMediaScreen({super.key});

  static const _slots = [
    ('Logo (color)', 'assets/logos/logo_color.png'),
    ('Logo (white)', 'assets/logos/logo_white.png'),
    ('Hero photo', 'assets/images/hero_crane_inspection.jpg'),
    ('ISO 9001 badge', 'assets/certifications/cert_iso_9001.png'),
    ('ISO 17020 badge', 'assets/certifications/cert_iso_17020.png'),
    ('Vision 2030 logo', 'assets/certifications/cert_vision_2030.png'),
    ('Saudi Accreditation logo', 'assets/certifications/cert_saudi_accreditation.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return AdminShell(
      activeRoute: '/admin/media',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Media', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.charcoal)),
            const SizedBox(height: 8),
            const Text(
              'Upload-from-dashboard (Firebase Storage) is the next increment — for now, '
              'these images are bundled as local assets in the app.',
              style: TextStyle(color: AppColors.textMuted),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _slots
                  .map(
                    (s) => Container(
                      width: 220,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(color: AppColors.lightGray, borderRadius: BorderRadius.circular(6)),
                            child: Image.asset(
                              s.$2,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Center(
                                child: Icon(Icons.image_outlined, color: AppColors.textMuted, size: 32),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(s.$1, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text(s.$2, style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
