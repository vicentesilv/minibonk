import '../../game/juego_mini_bonk.dart';
import '../../game/models/estado_ui.dart';

void actualizarUiJuego(JuegoMiniBonk juego) {
  juego.estadoUi.value = EstadoUi(
    oleada: juego.oleada,
    nivel: juego.nivel,
    xp: juego.xp,
    xpSiguiente: juego.xpSiguiente,
    vida: juego.jugador.vida,
    vidaMaxima: juego.jugador.vidaMaxima,
    eliminaciones: juego.enemigosEliminados,
    pausadoPorMejora: juego.estaPausadoPorMejora,
    finDePartida: juego.finDePartida,
  );
}