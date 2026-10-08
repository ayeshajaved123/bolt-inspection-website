import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/auth_service.dart';

/// Shared sidebar + top bar layout for every admin screen.
/// Deliberately looks like a different product from the public site —
/// light neutral background, flat utilitarian cards, no navy flooding
/// the whole page.
class AdminShell extends StatelessWidget {
  final String activeRoute;
  final Widget child;

  const AdminShell({super.key, required this.activeRoute, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          _Sidebar(activeRoute: activeRoute),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  final String activeRoute;
  const _Sidebar({required this.activeRoute});

  @override
  Widget build(BuildContext context) {
    final items = <_NavItem>[
      _NavItem('Dashboard', Icons.dashboard_outlined, '/admin/dashboard'),
      _NavItem('Messages', Icons.mail_outline, '/admin/messages'),
      _NavItem('Content', Icons.article_outlined, '/admin/content'),
      _NavItem('Media', Icons.image_outlined, '/admin/media'),
    ];

    return Container(
      width: 240,
      color: AppColors.navy,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              // White/mono logo — see assets/logos/logo_white.png
              child: Image.asset(
                'assets/logos/logo_white.png',
                height: 36,
                errorBuilder: (_, __, ___) => const Text(
                  'Bolt Inspection',
                  style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w800, fontSize: 18),
                ),
              ),
            ),
            ...items.map((i) => _SidebarTile(item: i, active: activeRoute == i.route)),
            const Spacer(),
            const Divider(color: AppColors.onNavyDivider, height: 1),
            _SidebarTile(
              item: _NavItem('Logout', Icons.logout, '/admin/logout'),
              active: false,
              onTapOverride: () async {
                await AuthService().signOut();
                if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, '/admin/login', (r) => false);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final String route;
  _NavItem(this.label, this.icon, this.route);
}

class _SidebarTile extends StatelessWidget {
  final _NavItem item;
  final bool active;
  final VoidCallback? onTapOverride;

  const _SidebarTile({required this.item, required this.active, this.onTapOverride});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: active ? AppColors.amber : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onTapOverride ??
              () {
                if (!active) Navigator.pushReplacementNamed(context, item.route);
              },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(item.icon, color: AppColors.white, size: 20),
                const SizedBox(width: 12),
                Text(
                  item.label,
                  style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
