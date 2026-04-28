import 'package:flame/components.dart';
import 'package:minibonk/features/juego/presentation/componentes/entidades.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';


void crearOrbeXpJuego(JuegoMiniBonk juego, Vector2 en, double cantidad) {
  juego.mapContainer.add(OrbeXp(position: en, valor: cantidad));
}