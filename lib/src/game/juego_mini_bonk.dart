import 'dart:io';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/entidades.dart';
import 'models/estado_ui.dart';
import 'models/tipo_mejora.dart';

class JuegoMiniBonk extends FlameGame
    with HasCollisionDetection, KeyboardEvents {
  final Random _aleatorio = Random();
  final ValueNotifier<EstadoUi> estadoUi = ValueNotifier(const EstadoUi());

  late final Jugador jugador;
  late final JoystickComponent palanca;

  Vector2 _entradaTeclado = Vector2.zero();
  double _temporizadorAparicion = 0;
  double _temporizadorOleada = 0;
  double _intervaloAparicion = 1.1;

  int oleada = 1;
  int nivel = 1;
  double xp = 0;
  double xpSiguiente = 36;
  int enemigosEliminados = 0;
  bool estaPausadoPorMejora = false;
  bool finDePartida = false;

  final List<TipoMejora> _opcionesActualesDeMejora = [];

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.topLeft;

    final fondo = RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFF111318),
    );
    add(fondo);

    jugador = Jugador(position: size / 2);
    add(jugador);

    palanca = JoystickComponent(
      knob: CircleComponent(
        radius: 22,
        paint: Paint()..color = const Color(0x66FFFFFF),
      ),
      background: CircleComponent(
        radius: 44,
        paint: Paint()..color = const Color(0x33000000),
      ),
      margin: const EdgeInsets.only(left: 24, bottom: 24),
    );

    if (Platform.isAndroid || Platform.isIOS || Platform.isFuchsia) {
      add(palanca);
    }

    overlays.add('Hud');
    _actualizarUi();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    children.whereType<RectangleComponent>().firstOrNull?.size = size;
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final x = (keysPressed.contains(LogicalKeyboardKey.keyD) ||
                keysPressed.contains(LogicalKeyboardKey.arrowRight)
            ? 1
            : 0) -
        (keysPressed.contains(LogicalKeyboardKey.keyA) ||
                keysPressed.contains(LogicalKeyboardKey.arrowLeft)
            ? 1
            : 0);

    final y = (keysPressed.contains(LogicalKeyboardKey.keyS) ||
                keysPressed.contains(LogicalKeyboardKey.arrowDown)
            ? 1
            : 0) -
        (keysPressed.contains(LogicalKeyboardKey.keyW) ||
                keysPressed.contains(LogicalKeyboardKey.arrowUp)
            ? 1
            : 0);

    _entradaTeclado = Vector2(x.toDouble(), y.toDouble());
    if (_entradaTeclado.length2 > 1) {
      _entradaTeclado.normalize();
    }
    return KeyEventResult.handled;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (estaPausadoPorMejora || finDePartida) {
      return;
    }

    _temporizadorOleada += dt;
    _temporizadorAparicion += dt;

    if (_temporizadorOleada >= 20) {
      _temporizadorOleada = 0;
      oleada++;
      _intervaloAparicion = max(0.32, _intervaloAparicion * 0.9);
      _actualizarUi();
    }

    if (_temporizadorAparicion >= _intervaloAparicion) {
      _temporizadorAparicion = 0;
      _crearEnemigo();
    }
  }

  Vector2 get entradaMovimiento {
    final palancaRelativa = palanca.relativeDelta;
    final mezcla = _entradaTeclado + palancaRelativa;
    if (mezcla.length2 > 1) {
      mezcla.normalize();
    }
    return mezcla;
  }

  Enemigo? obtenerEnemigoMasCercano(Vector2 desde) {
    Enemigo? mejor;
    var mejorDistancia = double.infinity;
    for (final enemigo in children.whereType<Enemigo>()) {
      final distancia = enemigo.position.distanceToSquared(desde);
      if (distancia < mejorDistancia) {
        mejorDistancia = distancia;
        mejor = enemigo;
      }
    }
    return mejor;
  }

  void crearBala({
    required Vector2 origen,
    required Vector2 direccion,
    required double velocidad,
    required double danio,
  }) {
    add(
      Bala(
        position: origen,
        velocidad: direccion.normalized() * velocidad,
        danio: danio,
      ),
    );
  }

  void crearOrbeXp(Vector2 en, double cantidad) {
    add(OrbeXp(position: en, valor: cantidad));
  }

  void agregarXp(double cantidad) {
    xp += cantidad;
    while (xp >= xpSiguiente) {
      xp -= xpSiguiente;
      nivel++;
      xpSiguiente = (xpSiguiente * 1.3).roundToDouble();
      _mostrarOpcionesMejora();
    }
    _actualizarUi();
  }

  void alEliminarEnemigo() {
    enemigosEliminados++;
    _actualizarUi();
  }

  void recibirDanioJugador(double danio) {
    if (finDePartida) {
      return;
    }
    jugador.vida = max(0, jugador.vida - danio);
    if (jugador.vida <= 0) {
      finDePartida = true;
    }
    _actualizarUi();
  }

  void reiniciarJuego() {
    for (final componente in [
      ...children.whereType<Enemigo>(),
      ...children.whereType<Bala>(),
      ...children.whereType<OrbeXp>(),
    ]) {
      componente.removeFromParent();
    }

    jugador.position = size / 2;
    jugador.reiniciarAtributos();

    oleada = 1;
    nivel = 1;
    xp = 0;
    xpSiguiente = 36;
    enemigosEliminados = 0;
    _temporizadorAparicion = 0;
    _temporizadorOleada = 0;
    _intervaloAparicion = 1.1;
    estaPausadoPorMejora = false;
    finDePartida = false;
    _opcionesActualesDeMejora.clear();
    overlays.remove('Upgrade');
    resumeEngine();
    _actualizarUi();
  }

  void aplicarMejora(TipoMejora tipo) {
    switch (tipo) {
      case TipoMejora.fuegoRapido:
        jugador.cadenciaDisparo = max(0.14, jugador.cadenciaDisparo * 0.82);
      case TipoMejora.masDanio:
        jugador.danioBala += 4;
      case TipoMejora.velocidadMovimiento:
        jugador.velocidadMovimiento += 20;
      case TipoMejora.vidaMaxima:
        jugador.vidaMaxima += 20;
        jugador.vida = min(jugador.vidaMaxima, jugador.vida + 20);
      case TipoMejora.velocidadProyectil:
        jugador.velocidadProyectil += 45;
      case TipoMejora.multiDisparo:
        jugador.proyectilesPorDisparo = min(4, jugador.proyectilesPorDisparo + 1);
    }

    estaPausadoPorMejora = false;
    overlays.remove('Upgrade');
    resumeEngine();
    _opcionesActualesDeMejora.clear();
    _actualizarUi();
  }

  List<TipoMejora> get opcionesActualesDeMejora => _opcionesActualesDeMejora;

  void _mostrarOpcionesMejora() {
    if (finDePartida) {
      return;
    }

    final opciones = TipoMejora.values.toList()..shuffle(_aleatorio);
    _opcionesActualesDeMejora
      ..clear()
      ..addAll(opciones.take(3));

    estaPausadoPorMejora = true;
    pauseEngine();
    overlays.add('Upgrade');
    _actualizarUi();
  }

  void _crearEnemigo() {
    final lado = _aleatorio.nextInt(4);
    late Vector2 posicion;

    switch (lado) {
      case 0:
        posicion = Vector2(_aleatorio.nextDouble() * size.x, -20);
      case 1:
        posicion = Vector2(size.x + 20, _aleatorio.nextDouble() * size.y);
      case 2:
        posicion = Vector2(_aleatorio.nextDouble() * size.x, size.y + 20);
      case 3:
        posicion = Vector2(-20, _aleatorio.nextDouble() * size.y);
    }

    add(
      Enemigo(
        position: posicion,
        velocidad: 55 + (oleada * 2.2),
        vida: 16 + (oleada * 3.6),
        danioContacto: 10,
      ),
    );
  }

  void _actualizarUi() {
    estadoUi.value = EstadoUi(
      oleada: oleada,
      nivel: nivel,
      xp: xp,
      xpSiguiente: xpSiguiente,
      vida: jugador.vida,
      vidaMaxima: jugador.vidaMaxima,
      eliminaciones: enemigosEliminados,
      pausadoPorMejora: estaPausadoPorMejora,
      finDePartida: finDePartida,
    );
  }
}
