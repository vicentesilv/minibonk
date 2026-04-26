import 'dart:math';

import '../../game/juego_mini_bonk.dart';
import '../../game/models/tipo_mejora.dart';
import 'actualizar_ui.dart';

void aplicarMejoraJuego(JuegoMiniBonk juego, TipoMejora tipo) {
  switch (tipo) {
    case TipoMejora.fuegoRapido:
      juego.jugador.cadenciaDisparo = max(0.14, juego.jugador.cadenciaDisparo * 0.82);
    case TipoMejora.masDanio:
      juego.jugador.danioBala += 4;
    case TipoMejora.velocidadMovimiento:
      juego.jugador.velocidadMovimiento += 20;
    case TipoMejora.vidaMaxima:
      juego.jugador.vidaMaxima += 20;
      juego.jugador.vida = min(juego.jugador.vidaMaxima, juego.jugador.vida + 20);
    case TipoMejora.velocidadProyectil:
      juego.jugador.velocidadProyectil += 45;
    case TipoMejora.multiDisparo:
      juego.jugador.proyectilesPorDisparo = min(4, juego.jugador.proyectilesPorDisparo + 1);
  }

  juego.estaPausadoPorMejora = false;
  juego.overlays.remove('Upgrade');
  juego.resumeEngine();
  juego.opcionesActualesDeMejoraInternas.clear();
  actualizarUiJuego(juego);
}