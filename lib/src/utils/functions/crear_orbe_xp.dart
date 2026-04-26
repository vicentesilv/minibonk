import 'package:flame/components.dart';

import '../../game/components/entidades.dart';
import '../../game/juego_mini_bonk.dart';

void crearOrbeXpJuego(JuegoMiniBonk juego, Vector2 en, double cantidad) {
  juego.add(OrbeXp(position: en, valor: cantidad));
}