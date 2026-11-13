import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppScreen {
  splash,
  onboarding,
  login,
  signup,
  home,
  restaurantDetail,
}

class NavigationState {
  final AppScreen current;
  final AppScreen? previous;
  final Map<String, dynamic> args;

  NavigationState({
    required this.current,
    this.previous,
    this.args = const {},
  });

  bool get goingForward => 
      previous == null || current.index >= previous!.index;
}

class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier() : super(NavigationState(current: AppScreen.splash));

  void navigateTo(AppScreen screen, {Map<String, dynamic>? args}) {
    state = NavigationState(
      current: screen,
      previous: state.current,
      args: args ?? {},
    );
  }

  void goBack() {
    if (state.previous != null) {
      state = NavigationState(
        current: state.previous!,
        previous: null,
      );
    }
  }
}

final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});
