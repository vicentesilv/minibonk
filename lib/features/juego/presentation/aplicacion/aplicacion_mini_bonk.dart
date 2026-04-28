import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../juego/juego_mini_bonk.dart';
import '../overlays/superposicion_hud.dart';
import '../overlays/superposicion_mejora.dart';

class AplicacionMiniBonk extends StatelessWidget {
  const AplicacionMiniBonk({super.key});

  @override
  Widget build(BuildContext context) {
    final juego = JuegoMiniBonk()..debugMode = false;  // ...debugMode = true; para mostrar colisiones 

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: GameWidget(
          game: juego,
          overlayBuilderMap: {
            'Interfaz': (context, juego) =>
                SuperposicionHud(juego: juego as JuegoMiniBonk),
            'Mejoras': (context, juego) =>
                SuperposicionMejora(juego: juego as JuegoMiniBonk),
          },
        ),
      ),
    );
  }
}