import 'dart:math';

import 'package:minibonk/features/juego/domain/casos_de_uso/ui/actualizar_ui.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/instancias/generar_enemigo.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/world/mover_mapa.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';


void onGameUpdate(JuegoMiniBonk juego, double dt) {
  if (juego.estaEnPausa) {
    return;
  }

  // Mover el mapa con joystick/teclado
  moverMapaJuego(juego, dt);

  if (juego.temporizadorEsperaOleada > 0) {
    juego.temporizadorEsperaOleada -= dt;

    if (juego.temporizadorEsperaOleada <= 0) {
      juego.temporizadorEsperaOleada = 0;
      juego.oleada++;
      juego.intervaloAparicion = max(0.32, juego.intervaloAparicion * 0.9);
      juego.temporizadorAparicion = 0;
      juego.temporizadorOleada = 0;
      juego.objetivoEnemigosOleada = 6 + (juego.oleada * 2);
      juego.enemigosGeneradosOleada = 0;
      juego.enemigosActivosOleada = 0;
      juego.distribuirMonedasOleada();
    }

    actualizarUiJuego(juego);
    return;
  }

  juego.temporizadorAparicion += dt;

  if (juego.enemigosGeneradosOleada >= juego.objetivoEnemigosOleada) {
    if (juego.enemigosActivosOleada == 0) {
      juego.temporizadorAparicion = 0;
      juego.temporizadorEsperaOleada = 10;
      actualizarUiJuego(juego);
    }
    return;
  }

  if (juego.temporizadorAparicion >= juego.intervaloAparicion) {
    juego.temporizadorAparicion = 0;
    crearEnemigoJuego(juego);
  }
}