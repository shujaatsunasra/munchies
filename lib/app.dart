import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/navigation_providers.dart';
import 'core/providers/auth_providers.dart';
import 'features/auth/views/login_view.dart';
import 'features/auth/views/signup_view.dart';
import 'features/onboarding/views/onboarding_view.dart';
import 'features/onboarding/views/splash_view.dart';
import 'features/home/views/home_view.dart';
import 'features/restaurant/views/restaurant_detail_view.dart';

class MunchlyApp extends StatelessWidget {
  const MunchlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Munchies',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MunchlyShell(),
    );
  }
}

class MunchlyShell extends ConsumerWidget {
  const MunchlyShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(navigationProvider);
    final authRepo = ref.watch(authRepositoryProvider);

    final screens = {
      AppScreen.splash: SplashView(
        key: const ValueKey('splash'),
        onContinue: () => ref
            .read(navigationProvider.notifier)
            .navigateTo(AppScreen.onboarding),
      ),
      AppScreen.onboarding: OnboardingView(
        key: const ValueKey('onboarding'),
        onSkip: () =>
            ref.read(navigationProvider.notifier).navigateTo(AppScreen.login),
        onNext: () =>
            ref.read(navigationProvider.notifier).navigateTo(AppScreen.login),
      ),
      AppScreen.login: LoginView(
        key: const ValueKey('login'),
        repository: authRepo,
        onSignUp: () =>
            ref.read(navigationProvider.notifier).navigateTo(AppScreen.signup),
        onLoginSuccess: () =>
            ref.read(navigationProvider.notifier).navigateTo(AppScreen.home),
      ),
      AppScreen.signup: SignupView(
        key: const ValueKey('signup'),
        repository: authRepo,
        onLogin: () =>
            ref.read(navigationProvider.notifier).navigateTo(AppScreen.login),
        onRegistered: () =>
            ref.read(navigationProvider.notifier).navigateTo(AppScreen.home),
      ),
      AppScreen.home: HomeView(
        key: const ValueKey('home'),
        onRestaurantTap: () => ref
            .read(navigationProvider.notifier)
            .navigateTo(AppScreen.restaurantDetail),
      ),
      AppScreen.restaurantDetail: RestaurantDetailView(
        key: const ValueKey('restaurant'),
        onBack: () =>
            ref.read(navigationProvider.notifier).navigateTo(AppScreen.home),
      ),
    };

    return PageTransitionSwitcher(
      goingForward: navState.goingForward,
      child: screens[navState.current]!,
    );
  }
}

class PageTransitionSwitcher extends StatelessWidget {
  const PageTransitionSwitcher({
    required this.child,
    required this.goingForward,
    super.key,
  });

  final Widget child;
  final bool goingForward;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 380),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final begin = goingForward
            ? const Offset(1.0, 0.0)
            : const Offset(-1.0, 0.0);
        final slideTween = Tween<Offset>(
          begin: begin,
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOutCubic));

        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 0.70, curve: Curves.easeOut),
          ),
          child: SlideTransition(
            position: animation.drive(slideTween),
            child: child,
          ),
        );
      },
      layoutBuilder: (currentChild, previousChildren) => Stack(
        fit: StackFit.expand,
        children: [...previousChildren, if (currentChild != null) currentChild],
      ),
      child: child,
    );
  }
}
