import 'package:flame/components.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';

void moverMapaJuego(JuegoMiniBonk juego, double dt) {
  const double margen = 120.0;

  final screenWidth = juego.size.x;
  final screenHeight = juego.size.y;
  final posicionJugadorEnPantalla =
      juego.mapContainer.position + juego.jugador.position;

  final correccion = Vector2.zero();

  if (posicionJugadorEnPantalla.x < margen) {
    correccion.x = margen - posicionJugadorEnPantalla.x;
  } else if (posicionJugadorEnPantalla.x > screenWidth - margen) {
    correccion.x = (screenWidth - margen) - posicionJugadorEnPantalla.x;
  }

  if (posicionJugadorEnPantalla.y < margen) {
    correccion.y = margen - posicionJugadorEnPantalla.y;
  } else if (posicionJugadorEnPantalla.y > screenHeight - margen) {
    correccion.y = (screenHeight - margen) - posicionJugadorEnPantalla.y;
  }

  if (!correccion.isZero()) {
    juego.mapContainer.position.add(correccion);
  }
}
