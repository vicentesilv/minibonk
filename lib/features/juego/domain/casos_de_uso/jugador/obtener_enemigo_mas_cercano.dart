import 'package:flame/components.dart';
import 'package:minibonk/features/juego/presentation/componentes/entidades.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';


Enemigo? obtenerEnemigoMasCercanoJuego(JuegoMiniBonk juego, Vector2 desde) {
  Enemigo? mejor;
  var mejorDistancia = double.infinity;
  for (final enemigo in juego.mapContainer.children.whereType<Enemigo>()) {
    final distancia = enemigo.position.distanceToSquared(desde);
    if (distancia < mejorDistancia) {
      mejorDistancia = distancia;
      mejor = enemigo;
    }
  }
  return mejor;
}