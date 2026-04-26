import 'package:flame/components.dart';

import '../../game/components/entidades.dart';
import '../../game/juego_mini_bonk.dart';

Enemigo? obtenerEnemigoMasCercanoJuego(JuegoMiniBonk juego, Vector2 desde) {
  Enemigo? mejor;
  var mejorDistancia = double.infinity;
  for (final enemigo in juego.children.whereType<Enemigo>()) {
    final distancia = enemigo.position.distanceToSquared(desde);
    if (distancia < mejorDistancia) {
      mejorDistancia = distancia;
      mejor = enemigo;
    }
  }
  return mejor;
}