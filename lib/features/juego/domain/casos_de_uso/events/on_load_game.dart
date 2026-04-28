import 'dart:io';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/actualizar_ui.dart';
import 'package:minibonk/features/juego/presentation/componentes/entidades.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';


Future<void> onLoadJuego(JuegoMiniBonk juego) async {
  juego.camera.viewfinder.anchor = Anchor.topLeft;

  final fondo = RectangleComponent(
    size: juego.size,
    paint: Paint()..color = const Color(0xFF111318),
  );
  juego.add(fondo);

  juego.jugador = Jugador(position: juego.size / 2);
  juego.add(juego.jugador);

  juego.palanca = JoystickComponent(
    knob: CircleComponent(
      radius: 22,
      paint: Paint()..color = const Color(0x66FFFFFF),
    ),
    background: CircleComponent(
      radius: 44,
      paint: Paint()..color = const Color(0x33000000),
    ),
    margin: const EdgeInsets.only(left: 24, bottom: 24),
  );

  if (Platform.isAndroid || Platform.isIOS || Platform.isFuchsia) {
    juego.add(juego.palanca);
  }

  juego.overlays.add('Interfaz');
  actualizarUiJuego(juego);
}