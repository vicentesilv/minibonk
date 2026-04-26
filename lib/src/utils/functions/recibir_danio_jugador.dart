import 'dart:math';

import '../../game/juego_mini_bonk.dart';
import 'actualizar_ui.dart';

void recibirDanioJugadorJuego(JuegoMiniBonk juego, double danio) {
  if (juego.finDePartida) {
    return;
  }
  juego.jugador.vida = max(0, juego.jugador.vida - danio);
  if (juego.jugador.vida <= 0) {
    juego.finDePartida = true;
  }
  actualizarUiJuego(juego);
}