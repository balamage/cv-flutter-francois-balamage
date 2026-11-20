import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cv_flutter_auriol/main.dart';

void main() {
  testWidgets('login rejects incorrect credentials', (tester) async {
    await tester.pumpWidget(const CvApp());

    await tester.enterText(
      find.byKey(const ValueKey('username-field')),
      'admin',
    );
    await tester.enterText(
      find.byKey(const ValueKey('password-field')),
      'wrong',
    );
    await tester.tap(find.byKey(const ValueKey('login-button')));
    await tester.pumpAndSettle();

    expect(find.text('Identifiant ou mot de passe incorrect.'), findsOneWidget);
    expect(find.text('Connexion'), findsOneWidget);
    expect(find.text('BIENVENUE'), findsNothing);
    expect(find.text('Mon espace\nprofessionnel.'), findsNothing);
  });

  testWidgets('login opens resume and navigation switches pages', (
    tester,
  ) async {
    await tester.pumpWidget(const CvApp());

    await tester.enterText(
      find.byKey(const ValueKey('username-field')),
      'admin',
    );
    await tester.enterText(
      find.byKey(const ValueKey('password-field')),
      '1234',
    );
    await tester.tap(find.byKey(const ValueKey('login-button')));
    await tester.pumpAndSettle();

    expect(find.text('AURIOL BASINYIZE'), findsOneWidget);
    expect(find.byKey(const ValueKey('profile-photo')), findsOneWidget);
    await tester.runAsync(
      () => precacheImage(
        const AssetImage('assets/images/profile.jpg'),
        tester.element(find.byKey(const ValueKey('profile-photo'))),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('I. Identité'), findsOneWidget);
    for (final section in [
      'II. Études faites',
      'III. Expériences',
      'IV. Langues parlées',
    ]) {
      for (
        var attempt = 0;
        attempt < 6 && find.text(section).evaluate().isEmpty;
        attempt++
      ) {
        await tester.drag(
          find.byKey(const ValueKey('resume-page')),
          const Offset(0, -350),
        );
        await tester.pumpAndSettle();
      }
      expect(find.text(section), findsOneWidget);
    }

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Famille'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Elon Musk'), findsOneWidget);

    await tester.tap(find.byTooltip('Ouvrir le menu'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(of: find.byType(Drawer), matching: find.text('Contact')),
    );
    await tester.pumpAndSettle();
    expect(find.text('+243 995 082 693'), findsOneWidget);
    expect(find.text('auriolbasinyize0001@gmail.com'), findsOneWidget);

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('CV'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Mon CV'), findsOneWidget);
  });
}
