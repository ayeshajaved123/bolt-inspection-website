import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'nav_bar.dart';
import 'site_footer.dart';
import 'page_container.dart';
import 'fade_slide_in.dart';

/// Shared layout for the simpler inner pages (About, Services, Contact, etc.)
/// so every page keeps the same nav + footer + heading style without
/// repeating boilerplate.
class SimplePageScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const SimplePageScaffold({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 700;
    return Scaffold(
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.navy,
              padding: EdgeInsets.symmetric(vertical: isNarrow ? 40 : 56, horizontal: 24),
              child: Center(
                child: FadeSlideIn(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: isNarrow ? 28 : 34,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(width: 48, height: 4, color: AppColors.amber),
                    ],
                  ),
                ),
              ),
            ),
            PageContainer(child: FadeSlideIn(delay: const Duration(milliseconds: 80), child: body)),
            const SiteFooter(),
          ],
        ),
      ),
    );
  }
}
