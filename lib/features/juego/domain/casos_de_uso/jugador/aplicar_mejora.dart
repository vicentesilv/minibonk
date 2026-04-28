import 'dart:math';

import 'package:minibonk/features/juego/domain/casos_de_uso/ui/actualizar_ui.dart';
import 'package:minibonk/features/juego/domain/modelos/tipo_mejora.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';


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
  juego.estaPausadoManual = false;
  juego.overlays.remove('Mejoras');
  juego.resumeEngine();
  juego.opcionesActualesDeMejoraInternas.clear();
  actualizarUiJuego(juego);
}