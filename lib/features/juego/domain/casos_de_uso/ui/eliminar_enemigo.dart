import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';

import 'actualizar_ui.dart';

void alEliminarEnemigoJuego(JuegoMiniBonk juego) {
  juego.enemigosEliminados++;
  if (juego.enemigosActivosOleada > 0) {
    juego.enemigosActivosOleada--;
  }
  actualizarUiJuego(juego);
}