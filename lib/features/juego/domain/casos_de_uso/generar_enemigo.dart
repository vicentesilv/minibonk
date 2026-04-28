import 'package:flame/components.dart';
import 'package:minibonk/features/juego/presentation/componentes/entidades.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';

void crearEnemigoJuego(JuegoMiniBonk juego) {
  final lado = juego.aleatorio.nextInt(4);
  late Vector2 posicion;

  switch (lado) {
    case 0:
      posicion = Vector2(juego.aleatorio.nextDouble() * juego.size.x, -20);
    case 1:
      posicion = Vector2(juego.size.x + 20, juego.aleatorio.nextDouble() * juego.size.y);
    case 2:
      posicion = Vector2(juego.aleatorio.nextDouble() * juego.size.x, juego.size.y + 20);
    case 3:
      posicion = Vector2(-20, juego.aleatorio.nextDouble() * juego.size.y);
  }

  juego.add(
    Enemigo(
      position: posicion,
      velocidad: 55 + (juego.oleada * 2.2),
      vida: 16 + (juego.oleada * 3.6),
      danioContacto: 10,
    ),
  );
}