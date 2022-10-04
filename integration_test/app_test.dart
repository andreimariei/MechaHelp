
import 'package:MechaHelp/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


void main() {
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('=> full app integration_test', (WidgetTester tester) async {
      const String email = 'a@a.com';
      const String password = '123466';
      const String serviceName= 'AutoBogdan';
      const int secondsForButtons = 10;
      const int secondsForTextFields = 5;

      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 20));

      //Insert the email
      final Finder emailKey = find.byKey(const Key('emailKey'));
      await tester.tap(emailKey);
      await tester.enterText(emailKey, email);
      await tester.pumpAndSettle(const Duration(seconds: secondsForTextFields));

      //Insert the password for the account
      final Finder passwordKey = find.byKey(const Key('passwordKey'));
      await tester.tap(passwordKey);
      await tester.enterText(passwordKey, password);
      await tester.pumpAndSettle(const Duration(seconds: secondsForTextFields));

      //Press the "Sign Up" button
      final Finder signInKey = find.byKey(const Key('signInKey'));
      await tester.tap(signInKey);
      await tester.pumpAndSettle(const Duration(seconds: secondsForButtons));

      //HERE we test the other actions

      //Select a service.
      final Finder service = find.byKey(const Key(serviceName));
      await tester.tap(service);
      await tester.pumpAndSettle(const Duration(seconds: secondsForButtons));

      //Click 'Redeem'.
      final Finder call = find.byKey(const Key('callKey'));
      await tester.tap(call);
      await tester.pumpAndSettle(const Duration(seconds: secondsForButtons));

    });
  });
}
