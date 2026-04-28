import 'package:flutter_test/flutter_test.dart';

import 'package:minibonk/features/juego/presentation/aplicacion/aplicacion_mini_bonk.dart';

void main() {
  testWidgets('MiniBonkApp carga el HUD', (WidgetTester tester) async {
    await tester.pumpWidget(const AplicacionMiniBonk());
    await tester.pump();

    expect(find.textContaining('Wave'), findsOneWidget);
  });
}
