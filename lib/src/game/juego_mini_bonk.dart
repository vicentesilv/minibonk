import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/entidades.dart';
import 'models/estado_ui.dart';
import 'models/tipo_mejora.dart';
import '../utils/functions/agregar_xp.dart';
import '../utils/functions/al_eliminar_enemigo.dart';
import '../utils/functions/aplicar_mejora.dart';
import '../utils/functions/crear_bala.dart';
import '../utils/functions/crear_orbe_xp.dart';
import '../utils/functions/entrada_movimiento.dart';
import '../utils/functions/obtener_enemigo_mas_cercano.dart';
import '../utils/functions/on_game_resize.dart';
import '../utils/functions/on_game_update.dart';
import '../utils/functions/on_key_event.dart';
import '../utils/functions/on_load_game.dart';
import '../utils/functions/recibir_danio_jugador.dart';
import '../utils/functions/reiniciar_juego.dart';

class JuegoMiniBonk extends FlameGame
    with HasCollisionDetection, KeyboardEvents {
  final Random aleatorio = Random();
  final ValueNotifier<EstadoUi> estadoUi = ValueNotifier(const EstadoUi());

  late final Jugador jugador;
  late final JoystickComponent palanca;

  Vector2 entradaTeclado = Vector2.zero();
  double temporizadorAparicion = 0;
  double temporizadorOleada = 0;
  double intervaloAparicion = 1.1;

  int oleada = 1;
  int nivel = 1;
  double xp = 0;
  double xpSiguiente = 36;
  int enemigosEliminados = 0;
  bool estaPausadoPorMejora = false;
  bool finDePartida = false;

  final List<TipoMejora> opcionesActualesDeMejoraInternas = [];

  @override
  Future<void> onLoad() async {
    await onLoadJuego(this);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    onGameResizeJuego(this, size);
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    return onKeyEventJuego(this, event, keysPressed);
  }

  @override
  void update(double dt) {
    super.update(dt);
    onGameUpdate(this, dt);
  }

  Vector2 get entradaMovimiento {
    return entradaMovimientoJuego(this);
  }

  Enemigo? obtenerEnemigoMasCercano(Vector2 desde) {
    return obtenerEnemigoMasCercanoJuego(this, desde);
  }

  void crearBala({
    required Vector2 origen,
    required Vector2 direccion,
    required double velocidad,
    required double danio,
  }) {
    crearBalaJuego(
      this,
      origen: origen,
      direccion: direccion,
      velocidad: velocidad,
      danio: danio,
    );
  }

  void crearOrbeXp(Vector2 en, double cantidad) {
    crearOrbeXpJuego(this, en, cantidad);
  }

  void agregarXp(double cantidad) {
    agregarXpJuego(this, cantidad);
  }

  void alEliminarEnemigo() {
    alEliminarEnemigoJuego(this);
  }

  void recibirDanioJugador(double danio) {
    recibirDanioJugadorJuego(this, danio);
  }

  void reiniciarJuego() {
    reiniciarJuegoExterno(this);
  }

  void aplicarMejora(TipoMejora tipo) {
    aplicarMejoraJuego(this, tipo);
  }

  List<TipoMejora> get opcionesActualesDeMejora => opcionesActualesDeMejoraInternas;

}
