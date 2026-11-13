import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_frame.dart';

class SplashView extends StatefulWidget {
  const SplashView({required this.onContinue, super.key});
  final VoidCallback onContinue;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  
  late final Animation<double> _bottomFade;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _logoFade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
    );
    _logoScale = Tween<double>(begin: 0.80, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
      ),
    );
    _bottomFade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.45, 1.0, curve: Curves.easeOut),
    );

    _ctrl.forward();

    
    Timer(const Duration(milliseconds: 2800), () {
      if (mounted) widget.onContinue();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      background: AppColors.orange,
      lightStatusIcons: true,
      child: Stack(
        fit: StackFit.expand,
        children: [
          
          
          const Positioned(
            top: -80,
            right: -70,
            child: _Circle(400, Color(0x30FFFFFF)),
          ),
          
          const Positioned(
            bottom: -100,
            left: -80,
            child: _Circle(380, Color(0x28FFFFFF)),
          ),
          
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 1.5,
                ),
              ),
            ),
          ),

          
          Center(
            child: FadeTransition(
              opacity: _logoFade,
              child: ScaleTransition(
                scale: _logoScale,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const MunchlyLogo(size: 180),
                    const SizedBox(height: 12),
                    Text(
                      'Munchly',
                      style: AppText.inter(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.8,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Crave it. Get it.',
                      style: AppText.inter(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _bottomFade,
              child: Column(
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: i == 0 ? 20 : 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: i == 0
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Finding tasty spots near you',
                    style: AppText.inter(
                      color: Colors.white.withValues(alpha: 0.80),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'v1.0',
                    style: AppText.inter(
                      color: Colors.white.withValues(alpha: 0.50),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle(this.size, this.color);
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );
}
