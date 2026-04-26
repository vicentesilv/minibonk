import 'package:flame/components.dart';

import '../../game/juego_mini_bonk.dart';

Vector2 entradaMovimientoJuego(JuegoMiniBonk juego) {
  final palancaRelativa = juego.palanca.relativeDelta;
  final mezcla = juego.entradaTeclado + palancaRelativa;
  if (mezcla.length2 > 1) {
    mezcla.normalize();
  }
  return mezcla;
}