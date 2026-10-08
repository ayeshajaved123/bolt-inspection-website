import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import 'hover_builder.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  static const _links = <String, String>{
    'Home': '/',
    'About Us': '/about',
    'Services': '/services',
    'Contact Us': '/contact',
  };

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 900;
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      elevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.06),
      toolbarHeight: 78,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            // Full-color logo — see assets/logos/logo_color.png
            HoverBuilder(
              builder: (context, hovering) => GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/'),
                child: AnimatedOpacity(
                  duration: AppMotion.fast,
                  opacity: hovering ? 0.82 : 1,
                  child: Image.asset(
                    'assets/logos/logo_color.png',
                    height: 44,
                    filterQuality: FilterQuality.high,
                    errorBuilder: (_, __, ___) => const _LogoFallback(),
                  ),
                ),
              ),
            ),
            const Spacer(),
            if (!isNarrow) ...[
              for (final e in _links.entries) _NavLink(label: e.key, route: e.value),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/contact'),
                child: const Text('Get a Quote'),
              ),
            ] else
              IconButton(
                icon: const Icon(Icons.menu, color: AppColors.navy),
                onPressed: () => _showMobileMenu(context),
              ),
          ],
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            for (final e in _links.entries)
              ListTile(
                title: Text(e.key),
                onTap: () => Navigator.pushReplacementNamed(context, e.value),
              ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.request_quote_outlined, color: AppColors.amber),
              title: const Text('Get a Quote',
                  style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.navy)),
              onTap: () => Navigator.pushReplacementNamed(context, '/contact'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(78);
}

/// A top-level nav link with an animated underline that appears on hover and
/// stays lit for the active route.
class _NavLink extends StatelessWidget {
  final String label;
  final String route;
  const _NavLink({required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    final active = ModalRoute.of(context)?.settings.name == route;
    return HoverBuilder(
      builder: (context, hovering) {
        final show = hovering || active;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pushNamed(context, route),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      color: AppColors.navy, fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(height: 5),
                AnimatedContainer(
                  duration: AppMotion.fast,
                  curve: AppMotion.standard,
                  height: 2,
                  width: show ? 22 : 0,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LogoFallback extends StatelessWidget {
  const _LogoFallback();
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Bolt Inspection',
      style: TextStyle(color: AppColors.navy, fontWeight: FontWeight.w800, fontSize: 20),
    );
  }
}
