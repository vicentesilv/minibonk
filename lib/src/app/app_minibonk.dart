import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../game/juego_mini_bonk.dart';
import '../ui/overlays/superposicion_hud.dart';
import '../ui/overlays/superposicion_mejora.dart';

class AppMiniBonk extends StatelessWidget {
  const AppMiniBonk({super.key});

  @override
  Widget build(BuildContext context) {
    final juego = JuegoMiniBonk()..debugMode = true;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget(
          game: juego,
          overlayBuilderMap: {
            'Hud':
                (context, juego) => SuperposicionHud(juego: juego as JuegoMiniBonk),
            'Upgrade':
                (context, juego) =>
                    SuperposicionMejora(juego: juego as JuegoMiniBonk),
          },
        ),
      ),
    );
  }
}
