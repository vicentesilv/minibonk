import 'dart:math';

import 'package:minibonk/features/juego/domain/casos_de_uso/ui/actualizar_ui.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';

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