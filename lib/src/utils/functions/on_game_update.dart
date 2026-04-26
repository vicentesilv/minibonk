import 'dart:math';

import '../../game/juego_mini_bonk.dart';
import 'actualizar_ui.dart';
import 'crear_enemigo.dart';

void onGameUpdate(JuegoMiniBonk juego, double dt) {
  if (juego.estaPausadoPorMejora || juego.finDePartida) {
    return;
  }

  juego.temporizadorOleada += dt;
  juego.temporizadorAparicion += dt;

  if (juego.temporizadorOleada >= 20) {
    juego.temporizadorOleada = 0;
    juego.oleada++;
    juego.intervaloAparicion = max(0.32, juego.intervaloAparicion * 0.9);
    actualizarUiJuego(juego);
  }

  if (juego.temporizadorAparicion >= juego.intervaloAparicion) {
    juego.temporizadorAparicion = 0;
    crearEnemigoJuego(juego);
  }
}