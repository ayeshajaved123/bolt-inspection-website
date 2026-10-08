import 'package:flutter/material.dart';

/// Centers content with a max width, like a standard web container.
/// Keeps every section consistent instead of each screen inventing its own
/// padding. When [padding] is omitted the horizontal/vertical padding adapts to
/// the viewport so content isn't cramped on phones or stranded on desktops.
class PageContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  const PageContainer({
    super.key,
    required this.child,
    this.maxWidth = 1200,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final resolved = padding ??
        EdgeInsets.symmetric(
          horizontal: width < 600 ? 20 : 24,
          vertical: width < 600 ? 40 : 56,
        );
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: resolved, child: child),
      ),
    );
  }
}
