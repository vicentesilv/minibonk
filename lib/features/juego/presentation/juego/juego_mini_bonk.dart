import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/ui/actualizar_ui.dart';
import 'package:minibonk/features/juego/domain/modelos/tipo_personaje.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/jugador/agregar_xp.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/jugador/aplicar_mejora.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/instancias/crear_bala.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/instancias/crear_orbe_xp.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/ui/eliminar_enemigo.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/events/entrada_movimiento.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/events/on_game_resize.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/events/on_game_update.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/events/on_key_event.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/events/on_load_game.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/jugador/obtener_enemigo_mas_cercano.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/jugador/recibir_danio_jugador.dart';
import 'package:minibonk/features/juego/domain/casos_de_uso/ui/reiniciar_partida.dart';
import 'package:minibonk/features/juego/domain/modelos/estado_interfaz_juego.dart';
import 'package:minibonk/features/juego/domain/modelos/tipo_mejora.dart';
import 'package:minibonk/features/juego/presentation/componentes/entidades.dart';
import 'package:minibonk/features/juego/presentation/componentes/personaje_pepe.dart';


class JuegoMiniBonk extends FlameGame
    with HasCollisionDetection, KeyboardEvents {
  final Random aleatorio = Random();
  final ValueNotifier<EstadoInterfazJuego> estadoUi =
      ValueNotifier(const EstadoInterfazJuego());

  late PersonajeBase jugador;
  bool juegoIniciado = false;
  late final JoystickComponent palanca;
  late final PositionComponent mapContainer;

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
  bool estaPausadoManual = false;
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
    if (!juegoIniciado) {
      return KeyEventResult.ignored;
    }
    return onKeyEventJuego(this, event, keysPressed);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!juegoIniciado) {
      return;
    }
    onGameUpdate(this, dt);
  }

  bool get estaEnPausa =>
      estaPausadoPorMejora || estaPausadoManual || finDePartida;

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

  void alternarPausaManual() {
    if (!juegoIniciado || finDePartida || estaPausadoPorMejora) {
      return;
    }

    estaPausadoManual = !estaPausadoManual;
    if (estaPausadoManual) {
      pauseEngine();
    } else {
      resumeEngine();
    }
    actualizarUiJuego(this);
  }

  void reiniciarJuego() {
    reiniciarJuegoExterno(this);
  }

  void nuevaPartida() {
    volverAlMenuInicio(this);
  }

  void iniciarConPersonaje(TipoPersonaje tipo) {
    final posicionInicial = size / 2;

    final personajesActuales = mapContainer.children.whereType<PersonajeBase>().toList();
    for (final personaje in personajesActuales) {
      personaje.removeFromParent();
    }

    jugador = switch (tipo) {
      TipoPersonaje.prueba => Jugador(position: posicionInicial),
      TipoPersonaje.pepe => Pepe(position: posicionInicial),
    };

    mapContainer.add(jugador);
    juegoIniciado = true;
    estaPausadoManual = false;
    estaPausadoPorMejora = false;
    finDePartida = false;
    overlays.remove('MenuInicio');
    overlays.add('Interfaz');
    resumeEngine();
    actualizarUiJuego(this);
  }

  void aplicarMejora(TipoMejora tipo) {
    aplicarMejoraJuego(this, tipo);
  }

  List<TipoMejora> get opcionesActualesDeMejora => opcionesActualesDeMejoraInternas;

}
