import 'package:flame/components.dart';
import 'package:minibonk/features/juego/presentation/componentes/entidades.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';


void crearBalaJuego(
  JuegoMiniBonk juego, {
  required Vector2 origen,
  required Vector2 direccion,
  required double velocidad,
  required double danio,
}) {
  juego.mapContainer.add(
    Bala(
      position: origen,
      velocidad: direccion.normalized() * velocidad,
      danio: danio,
    ),
  );
}