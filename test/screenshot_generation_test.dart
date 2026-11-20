import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cv_flutter_auriol/main.dart';

void main() {
  testWidgets('capture application pages', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const CvApp());
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(CvApp),
      matchesGoldenFile('screenshots/connexion.png'),
    );

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
    await tester.runAsync(
      () => precacheImage(
        const AssetImage('assets/images/profile.jpg'),
        tester.element(find.byKey(const ValueKey('profile-photo'))),
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(CvApp),
      matchesGoldenFile('screenshots/cv.png'),
    );

    await tester.tap(find.byTooltip('Ouvrir le menu'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(of: find.byType(Drawer), matching: find.text('Famille')),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(CvApp),
      matchesGoldenFile('screenshots/famille.png'),
    );

    await tester.tap(find.byTooltip('Ouvrir le menu'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(of: find.byType(Drawer), matching: find.text('Contact')),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(CvApp),
      matchesGoldenFile('screenshots/contact.png'),
    );
  });
}
