import '../../game/components/entidades.dart';
import '../../game/juego_mini_bonk.dart';
import 'actualizar_ui.dart';

void reiniciarJuegoExterno(JuegoMiniBonk juego) {
  for (final componente in [
    ...juego.children.whereType<Enemigo>(),
    ...juego.children.whereType<Bala>(),
    ...juego.children.whereType<OrbeXp>(),
  ]) {
    componente.removeFromParent();
  }

  juego.jugador.position = juego.size / 2;
  juego.jugador.reiniciarAtributos();

  juego.oleada = 1;
  juego.nivel = 1;
  juego.xp = 0;
  juego.xpSiguiente = 36;
  juego.enemigosEliminados = 0;
  juego.temporizadorAparicion = 0;
  juego.temporizadorOleada = 0;
  juego.intervaloAparicion = 1.1;
  juego.estaPausadoPorMejora = false;
  juego.finDePartida = false;
  juego.opcionesActualesDeMejoraInternas.clear();
  juego.overlays.remove('Upgrade');
  juego.resumeEngine();
  actualizarUiJuego(juego);
}