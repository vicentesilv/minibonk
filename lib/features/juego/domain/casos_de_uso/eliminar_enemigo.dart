import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';

import 'actualizar_ui.dart';

void alEliminarEnemigoJuego(JuegoMiniBonk juego) {
  juego.enemigosEliminados++;
  actualizarUiJuego(juego);
}