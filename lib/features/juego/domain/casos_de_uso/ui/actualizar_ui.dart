

import 'package:minibonk/features/juego/domain/modelos/estado_interfaz_juego.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';

void actualizarUiJuego(JuegoMiniBonk juego) {
  juego.estadoUi.value = EstadoInterfazJuego(
    oleada: juego.oleada,
    nivel: juego.nivel,
    xp: juego.xp,
    xpSiguiente: juego.xpSiguiente,
    vida: juego.jugador.vida,
    vidaMaxima: juego.jugador.vidaMaxima,
    eliminaciones: juego.enemigosEliminados,
    pausadoPorMejora: juego.estaPausadoPorMejora,
    pausadoManual: juego.estaPausadoManual,
    finDePartida: juego.finDePartida,
  );
}