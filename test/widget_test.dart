import 'package:flutter_test/flutter_test.dart';

import 'package:minibonk/src/app/app_mini_bonk.dart';

void main() {
  testWidgets('MiniBonkApp carga el HUD', (WidgetTester tester) async {
    await tester.pumpWidget(const AppMiniBonk());
    await tester.pump();

    expect(find.textContaining('Wave'), findsOneWidget);
  });
}
