

import 'package:flame/components.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/ui/actualizar_ui.dart';
import 'package:minibonk/features/juego/presentation/componentes/entidades.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';

void reiniciarJuegoExterno(JuegoMiniBonk juego) {
  for (final componente in [
    ...juego.mapContainer.children.whereType<Enemigo>(),
    ...juego.mapContainer.children.whereType<Bala>(),
    ...juego.mapContainer.children.whereType<OrbeXp>(),
  ]) {
    componente.removeFromParent();
  }
  juego.eliminarMonedasEntreRondas();

  juego.mapContainer.position = Vector2.zero();
  juego.jugador.position = juego.size / 2;
  juego.jugador.reiniciarAtributos();

  juego.oleada = 1;
  juego.nivel = 1;
  juego.xp = 0;
  juego.xpSiguiente = 36;
  juego.enemigosEliminados = 0;
  juego.temporizadorAparicion = 0;
  juego.temporizadorOleada = 0;
  juego.temporizadorEsperaOleada = 0;
  juego.intervaloAparicion = 1.1;
  juego.objetivoEnemigosOleada = 6 + (juego.oleada * 2);
  juego.enemigosGeneradosOleada = 0;
  juego.enemigosActivosOleada = 0;
  juego.estaPausadoPorMejora = false;
  juego.estaPausadoManual = false;
  juego.finDePartida = false;
  juego.opcionesActualesDeMejoraInternas.clear();
  juego.overlays.remove('Mejoras');
  juego.resumeEngine();
  juego.distribuirMonedasOleada();
  actualizarUiJuego(juego);
}

void volverAlMenuInicio(JuegoMiniBonk juego) {
  for (final componente in [
    ...juego.mapContainer.children.whereType<Enemigo>(),
    ...juego.mapContainer.children.whereType<Bala>(),
    ...juego.mapContainer.children.whereType<OrbeXp>(),
    ...juego.mapContainer.children.whereType<PersonajeBase>(),
  ]) {
    componente.removeFromParent();
  }
  juego.eliminarMonedasEntreRondas();

  juego.mapContainer.position = Vector2.zero();
  juego.oleada = 1;
  juego.nivel = 1;
  juego.xp = 0;
  juego.xpSiguiente = 36;
  juego.enemigosEliminados = 0;
  juego.temporizadorAparicion = 0;
  juego.temporizadorOleada = 0;
  juego.temporizadorEsperaOleada = 0;
  juego.intervaloAparicion = 1.1;
  juego.objetivoEnemigosOleada = 6 + (juego.oleada * 2);
  juego.enemigosGeneradosOleada = 0;
  juego.enemigosActivosOleada = 0;
  juego.estaPausadoPorMejora = false;
  juego.estaPausadoManual = false;
  juego.finDePartida = false;
  juego.juegoIniciado = false;
  juego.opcionesActualesDeMejoraInternas.clear();
  juego.overlays.remove('Interfaz');
  juego.overlays.remove('Mejoras');
  juego.overlays.add('MenuInicio');
  juego.pauseEngine();
  actualizarUiJuego(juego);
}