import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_frame.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({required this.onSkip, required this.onNext, super.key});
  final VoidCallback onSkip;
  final VoidCallback onNext;

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.title,
    required this.subtitle,
    required this.mainAsset,
    required this.leftAsset,
    required this.rightAsset,
    required this.ratingText,
    required this.ratingSubtext,
    required this.timeText,
    required this.tagText,
    this.ratingIcon = Icons.star_rounded,
    this.ratingIconColor = const Color(0xFFF5A623),
    this.timeIcon = Icons.access_time_rounded,
    this.tagIcon = Icons.check_rounded,
  });

  final String title;
  final String subtitle;
  final String mainAsset;
  final String leftAsset;
  final String rightAsset;
  final String ratingText;
  final String ratingSubtext;
  final String timeText;
  final String tagText;
  final IconData ratingIcon;
  final Color ratingIconColor;
  final IconData timeIcon;
  final IconData tagIcon;
}

class _OnboardingViewState extends State<OnboardingView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final PageController _pageController;
  int _currentPage = 0;

  static const List<_OnboardingPageData> _pages = [
    _OnboardingPageData(
      title: 'Your favourite food,\none tap away.',
      subtitle:
          'From wood-fired pizza to late-night sushi — thousands of local restaurants, delivered straight to your door.',
      mainAsset: 'assets/photo-margherita.png',
      leftAsset: 'assets/photo-bowl.png',
      rightAsset: 'assets/photo-sushi.png',
      ratingText: '4.8',
      ratingSubtext: ' · 1.2k reviews',
      timeText: '25–35 min',
      tagText: 'Free delivery',
      ratingIcon: Icons.star_rounded,
      ratingIconColor: Color(0xFFF5A623),
      timeIcon: Icons.access_time_rounded,
      tagIcon: Icons.check_rounded,
    ),
    _OnboardingPageData(
      title: 'Lightning-fast delivery,\nright to your door.',
      subtitle:
          'Track your meals in real-time from the restaurant kitchen straight to your hands with live GPS updates.',
      mainAsset: 'assets/photo-bowl.png',
      leftAsset: 'assets/photo-sushi.png',
      rightAsset: 'assets/photo-margherita.png',
      ratingText: 'Fast',
      ratingSubtext: ' · Top local speed',
      timeText: '15–25 min',
      tagText: 'Live GPS tracking',
      ratingIcon: Icons.bolt_rounded,
      ratingIconColor: AppColors.orange,
      timeIcon: Icons.access_time_rounded,
      tagIcon: Icons.location_on_rounded,
    ),
    _OnboardingPageData(
      title: 'Exclusive deals &\nfresh flavours daily.',
      subtitle:
          'Discover daily chef specials, member discounts, and hand-picked recommendations curated for your taste.',
      mainAsset: 'assets/photo-sushi.png',
      leftAsset: 'assets/photo-bowl.png',
      rightAsset: 'assets/photo-margherita.png',
      ratingText: '5.0',
      ratingSubtext: ' · Chef’s special',
      timeText: '30% OFF',
      tagText: 'Curated daily offers',
      ratingIcon: Icons.star_rounded,
      ratingIconColor: Color(0xFFF5A623),
      timeIcon: Icons.local_offer_rounded,
      tagIcon: Icons.verified_rounded,
    ),
  ];

  
  late final Animation<double> _ringFade;
  late final Animation<double> _pizzaSlide;
  late final Animation<double> _pizzaFade;
  late final Animation<double> _bowlSlide;
  late final Animation<double> _bowlFade;
  late final Animation<double> _sushiSlide;
  late final Animation<double> _sushiFade;
  late final Animation<double> _badgesFade;
  late final Animation<double> _textSlide;
  late final Animation<double> _textFade;
  late final Animation<double> _bottomFade;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    Animation<double> interval(
      double from,
      double to, {
      Curve curve = Curves.easeOut,
    }) => CurvedAnimation(
      parent: _ctrl,
      curve: Interval(from, to, curve: curve),
    );

    _ringFade = interval(0.00, 0.35);
    _pizzaFade = interval(0.10, 0.45);
    _pizzaSlide = Tween<double>(
      begin: -32,
      end: 0,
    ).animate(interval(0.10, 0.50, curve: Curves.easeOutCubic));
    _bowlFade = interval(0.28, 0.60);
    _bowlSlide = Tween<double>(
      begin: -28,
      end: 0,
    ).animate(interval(0.28, 0.62, curve: Curves.easeOutCubic));
    _sushiFade = interval(0.35, 0.65);
    _sushiSlide = Tween<double>(
      begin: 28,
      end: 0,
    ).animate(interval(0.35, 0.67, curve: Curves.easeOutCubic));
    _badgesFade = interval(0.52, 0.80);
    _textFade = interval(0.60, 0.90);
    _textSlide = Tween<double>(
      begin: 20,
      end: 0,
    ).animate(interval(0.60, 0.92, curve: Curves.easeOut));
    _bottomFade = interval(0.72, 1.00);

    _ctrl.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: SafeArea(
        child: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 16, 0),
              child: FadeTransition(
                opacity: _bottomFade,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x10000000),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: widget.onSkip,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 7,
                          ),
                          child: Text(
                            'Skip',
                            style: AppText.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.muted,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final totalH = constraints.maxHeight;
                  final collageH = (totalH * 0.58).clamp(240.0, 430.0);

                  return PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (page) =>
                        setState(() => _currentPage = page),
                    itemBuilder: (context, index) {
                      final data = _pages[index];
                      final isFirstPage = index == 0;

                      return Column(
                        children: [
                          
                          SizedBox(
                            height: collageH,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: _FoodCollage(
                                data: data,
                                isFirstPage: isFirstPage,
                                ringFade: _ringFade,
                                pizzaFade: _pizzaFade,
                                pizzaSlide: _pizzaSlide,
                                bowlFade: _bowlFade,
                                bowlSlide: _bowlSlide,
                                sushiFade: _sushiFade,
                                sushiSlide: _sushiSlide,
                                badgesFade: _badgesFade,
                              ),
                            ),
                          ),

                          
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                              child: isFirstPage
                                  ? AnimatedBuilder(
                                      animation: _ctrl,
                                      builder: (context, child) =>
                                          Transform.translate(
                                            offset: Offset(0, _textSlide.value),
                                            child: Opacity(
                                              opacity: _textFade.value,
                                              child: child,
                                            ),
                                          ),
                                      child: _TextBlock(data: data),
                                    )
                                  : _TextBlock(data: data),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),

            
            FadeTransition(
              opacity: _bottomFade,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Row(
                  children: [
                    _PageDots(
                      total: _pages.length,
                      current: _currentPage,
                      onDotTap: (index) {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOutCubic,
                        );
                      },
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.orange.withValues(alpha: 0.38),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage < _pages.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInOutCubic,
                            );
                          } else {
                            widget.onNext();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                          shape: const StadiumBorder(),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _currentPage == _pages.length - 1
                                  ? 'Get Started'
                                  : 'Next',
                              style: AppText.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded, size: 17),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _TextBlock extends StatelessWidget {
  const _TextBlock({required this.data});
  final _OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.title,
              style: AppText.inter(
                color: AppColors.ink,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                height: 1.18,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              data.subtitle,
              style: AppText.inter(
                color: AppColors.muted,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.55,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FoodCollage extends StatelessWidget {
  const _FoodCollage({
    required this.data,
    required this.isFirstPage,
    required this.ringFade,
    required this.pizzaFade,
    required this.pizzaSlide,
    required this.bowlFade,
    required this.bowlSlide,
    required this.sushiFade,
    required this.sushiSlide,
    required this.badgesFade,
  });

  final _OnboardingPageData data;
  final bool isFirstPage;
  final Animation<double> ringFade;
  final Animation<double> pizzaFade;
  final Animation<double> pizzaSlide;
  final Animation<double> bowlFade;
  final Animation<double> bowlSlide;
  final Animation<double> sushiFade;
  final Animation<double> sushiSlide;
  final Animation<double> badgesFade;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final w = box.maxWidth;
        final h = box.maxHeight;

        final outlinedSize = (w * 0.95).clamp(330.0, 365.0);
        final coloredSize = (w * 0.95).clamp(330.0, 365.0);

        return Stack(
          clipBehavior: Clip.none,
          children: [
            
            Positioned(
              top: 80,
              right: (w - coloredSize) / 100 - 25,
              width: coloredSize,
              height: coloredSize,
              child: AnimatedBuilder(
                animation: ringFade,
                builder: (_, child) => Opacity(
                  opacity: isFirstPage ? ringFade.value : 1.0,
                  child: child,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF7D5C5).withValues(alpha: 0.70),
                  ),
                ),
              ),
            ),

            
            Positioned(
              top: 80,
              left: (w - outlinedSize) / 100 - 25,
              width: outlinedSize,
              height: outlinedSize,
              child: AnimatedBuilder(
                animation: ringFade,
                builder: (_, child) => Opacity(
                  opacity: isFirstPage ? ringFade.value : 1.0,
                  child: child,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE5B4A2).withValues(alpha: 0.45),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),

            
            Positioned(
              bottom: h * 0.15,
              left: -50,
              width: 180,
              height: 180,
              child: AnimatedBuilder(
                animation: ringFade,
                builder: (_, child) => Opacity(
                  opacity: isFirstPage ? ringFade.value * 0.6 : 0.6,
                  child: child,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF7D5C5).withValues(alpha: 0.35),
                  ),
                ),
              ),
            ),

            
            AnimatedBuilder(
              animation: pizzaFade,
              builder: (_, child) => Positioned(
                top: isFirstPage ? pizzaSlide.value : 0,
                left: w * 0.04,
                right: w * 0.08,
                height: h * 0.99,
                child: Opacity(
                  opacity: isFirstPage ? pizzaFade.value : 1.0,
                  child: child,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.asset(data.mainAsset, fit: BoxFit.cover),
              ),
            ),

            
            AnimatedBuilder(
              animation: bowlFade,
              builder: (_, child) => Positioned(
                bottom: h * 0.001,
                left: isFirstPage ? bowlSlide.value : 0,
                width: w * 0.40,
                height: h * 0.36,
                child: Opacity(
                  opacity: isFirstPage ? bowlFade.value : 1.0,
                  child: child,
                ),
              ),
              child: _ImageCard(asset: data.leftAsset),
            ),

            
            AnimatedBuilder(
              animation: sushiFade,
              builder: (_, child) => Positioned(
                bottom: h * 0.01,
                right: isFirstPage ? sushiSlide.value : 0,
                width: w * 0.40,
                height: h * 0.46,
                child: Opacity(
                  opacity: isFirstPage ? sushiFade.value : 1.0,
                  child: child,
                ),
              ),
              child: _ImageCard(asset: data.rightAsset),
            ),

            
            AnimatedBuilder(
              animation: badgesFade,
              builder: (_, child) => Positioned(
                top: h * 0.10,
                left: 0,
                child: Opacity(
                  opacity: isFirstPage ? badgesFade.value : 1.0,
                  child: child!,
                ),
              ),
              child: _RatingBadge(
                rating: data.ratingText,
                reviews: data.ratingSubtext,
                icon: data.ratingIcon,
                iconColor: data.ratingIconColor,
              ),
            ),

            
            AnimatedBuilder(
              animation: badgesFade,
              builder: (_, child) => Positioned(
                top: h * 0.05,
                right: 0,
                child: Opacity(
                  opacity: isFirstPage ? badgesFade.value : 1.0,
                  child: child!,
                ),
              ),
              child: _TimeBadge(time: data.timeText, icon: data.timeIcon),
            ),

            
            AnimatedBuilder(
              animation: badgesFade,
              builder: (_, child) => Positioned(
                bottom: h * 0.001,
                left: 0,
                right: w * 0.3,
                child: Center(
                  child: Opacity(
                    opacity: isFirstPage ? badgesFade.value : 1.0,
                    child: child!,
                  ),
                ),
              ),
              child: _GreenBadge(text: data.tagText, icon: data.tagIcon),
            ),
          ],
        );
      },
    );
  }
}

class _ImageCard extends StatelessWidget {
  const _ImageCard({required this.asset});
  final String asset;

  @override
  Widget build(BuildContext context) => Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(asset, fit: BoxFit.cover),
    ),
  );
}

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({
    required this.rating,
    required this.reviews,
    this.icon = Icons.star_rounded,
    this.iconColor = const Color(0xFFF5A623),
  });

  final String rating;
  final String reviews;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) => _Pill(
    dark: false,
    children: [
      Icon(icon, size: 13, color: iconColor),
      const SizedBox(width: 4),
      Text(
        rating,
        style: AppText.inter(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
      ),
      Text(
        reviews,
        style: AppText.inter(fontSize: 11, color: AppColors.muted),
      ),
    ],
  );
}

class _TimeBadge extends StatelessWidget {
  const _TimeBadge({required this.time, this.icon = Icons.access_time_rounded});

  final String time;
  final IconData icon;

  @override
  Widget build(BuildContext context) => _Pill(
    dark: true,
    children: [
      Icon(icon, size: 13, color: Colors.white.withValues(alpha: 0.85)),
      const SizedBox(width: 5),
      Text(
        time,
        style: AppText.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ],
  );
}

class _GreenBadge extends StatelessWidget {
  const _GreenBadge({required this.text, this.icon = Icons.check_rounded});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: AppColors.greenBg,
      borderRadius: BorderRadius.circular(100),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.green),
        const SizedBox(width: 5),
        Text(
          text,
          style: AppText.inter(
            color: AppColors.green,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

class _Pill extends StatelessWidget {
  const _Pill({required this.children, required this.dark});
  final List<Widget> children;
  final bool dark;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
    decoration: BoxDecoration(
      color: dark ? AppColors.ink : Colors.white,
      borderRadius: BorderRadius.circular(100),
      boxShadow: const [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: children),
  );
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.total, required this.current, this.onDotTap});

  final int total;
  final int current;
  final ValueChanged<int>? onDotTap;

  @override
  Widget build(BuildContext context) => Row(
    children: List.generate(total, (i) {
      final active = i == current;
      return GestureDetector(
        onTap: () => onDotTap?.call(i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(right: 6),
          width: active ? 22 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: active ? AppColors.orange : const Color(0xFFD8C9BF),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );
    }),
  );
}
