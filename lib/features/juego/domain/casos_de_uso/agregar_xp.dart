

import 'package:minibonk/features/juego/domain/casos_de_uso/actualizar_ui.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/mostrar_opciones_mejora.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';


void agregarXpJuego(JuegoMiniBonk juego, double cantidad) {
  juego.xp += cantidad;
  while (juego.xp >= juego.xpSiguiente) {
    juego.xp -= juego.xpSiguiente;
    juego.nivel++;
    juego.xpSiguiente = (juego.xpSiguiente * 1.3).roundToDouble();
    mostrarOpcionesMejoraJuego(juego);
  }
  actualizarUiJuego(juego);
}