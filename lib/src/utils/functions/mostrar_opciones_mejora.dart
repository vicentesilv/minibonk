import '../../game/juego_mini_bonk.dart';
import '../../game/models/tipo_mejora.dart';
import 'actualizar_ui.dart';

void mostrarOpcionesMejoraJuego(JuegoMiniBonk juego) {
  if (juego.finDePartida) {
    return;
  }

  final opciones = TipoMejora.values.toList()..shuffle(juego.aleatorio);
  juego.opcionesActualesDeMejoraInternas
    ..clear()
    ..addAll(opciones.take(3));

  juego.estaPausadoPorMejora = true;
  juego.pauseEngine();
  juego.overlays.add('Upgrade');
  actualizarUiJuego(juego);
}