import 'package:flame/components.dart';

import '../../game/juego_mini_bonk.dart';

void onGameResizeJuego(JuegoMiniBonk juego, Vector2 size) {
  juego.children.whereType<RectangleComponent>().firstOrNull?.size = size;
}