import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';

class AppFrame extends StatelessWidget {
  const AppFrame({
    required this.child,
    this.background = AppColors.cream,
    this.lightStatusIcons = false,
    super.key,
  });

  final Widget child;
  final Color background;
  final bool lightStatusIcons;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: lightStatusIcons
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarColor: background,
        systemNavigationBarIconBrightness: lightStatusIcons
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        
        
        backgroundColor: background,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 520;
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 393),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isDesktop ? 44 : 0),
                  child: Container(
                    color: background,
                    width: double.infinity,
                    height: double.infinity,
                    child: child,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MunchlyLogo extends StatelessWidget {
  const MunchlyLogo({required this.size, super.key});
  final double size;

  @override
  Widget build(BuildContext context) =>
      Image.asset('assets/mark-96.png', width: size, height: size);
}
