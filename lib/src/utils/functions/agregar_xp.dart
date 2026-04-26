import '../../game/juego_mini_bonk.dart';
import 'actualizar_ui.dart';
import 'mostrar_opciones_mejora.dart';

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