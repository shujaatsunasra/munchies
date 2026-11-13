import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practical/core/widgets/app_frame.dart';
import 'package:practical/features/onboarding/views/onboarding_view.dart';
import 'package:practical/features/onboarding/views/splash_view.dart';

void main() {
  testWidgets('SplashView has logo with 30% increased size (130)',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SplashView(onContinue: () {}),
      ),
    );

    final logoFinder = find.byType(MunchlyLogo);
    expect(logoFinder, findsOneWidget);
    final logoWidget = tester.widget<MunchlyLogo>(logoFinder);
    expect(logoWidget.size, equals(130));

    // Pump past the 2.8s timer so no pending timers remain
    await tester.pump(const Duration(milliseconds: 3000));
  });

  testWidgets('OnboardingView renders 3 pages matching dot indicators',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(393 * 3, 852 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    bool nextCalled = false;
    bool skipCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: OnboardingView(
          onNext: () => nextCalled = true,
          onSkip: () => skipCalled = true,
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify first page text
    expect(find.textContaining('Your favourite food'), findsOneWidget);

    // Verify Skip button exists
    final skipFinder = find.text('Skip');
    expect(skipFinder, findsOneWidget);

    // Tap Next to advance to page 2
    final nextFinder = find.widgetWithText(ElevatedButton, 'Next');
    expect(nextFinder, findsOneWidget);
    await tester.tap(nextFinder);
    await tester.pumpAndSettle();

    // Page 2 text
    expect(find.textContaining('Lightning-fast delivery'), findsOneWidget);

    // Tap Next to advance to page 3
    await tester.tap(nextFinder);
    await tester.pumpAndSettle();

    // Page 3 text
    expect(find.textContaining('Exclusive deals'), findsOneWidget);

    // Last page button says "Get Started"
    final getStartedFinder =
        find.widgetWithText(ElevatedButton, 'Get Started');
    expect(getStartedFinder, findsOneWidget);

    // Tap Get Started - triggers onNext
    await tester.tap(getStartedFinder);
    await tester.pumpAndSettle();
    expect(nextCalled, isTrue);

    // Test Skip button callback
    await tester.tap(skipFinder);
    await tester.pumpAndSettle();
    expect(skipCalled, isTrue);
  });
}
