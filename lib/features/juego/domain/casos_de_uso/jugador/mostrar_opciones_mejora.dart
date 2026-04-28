
import 'package:minibonk/features/juego/domain/modelos/tipo_mejora.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';

import '../ui/actualizar_ui.dart';

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
  juego.overlays.add('Mejoras');
  actualizarUiJuego(juego);
}