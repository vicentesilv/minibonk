import 'package:flame/components.dart';
import 'dart:math' as math;
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';

class Decorado extends SpriteComponent with HasGameReference<JuegoMiniBonk> {
  final List<String> frames; // Rutas de las imágenes de la animación
  final double tiempoEntreFrames;
  
  int frameActual = 0;
  double tiempoTranscurrido = 0;

  Decorado({
    required super.position,
    required this.frames,
    this.tiempoEntreFrames = 0.15,
  }) : super(
    size: Vector2(120, 120),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Precargar todos los frames
    for (final frame in frames) {
      await game.images.load(frame);
    }
    if (frames.isNotEmpty) {
      sprite = Sprite(game.images.fromCache(frames[0]));
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    if (frames.length <= 1) return;

    tiempoTranscurrido += dt;
    
    if (tiempoTranscurrido >= tiempoEntreFrames) {
      tiempoTranscurrido = 0;
      frameActual = (frameActual + 1) % frames.length;
      // Cambiar al siguiente frame desde el cache
      sprite = Sprite(game.images.fromCache(frames[frameActual]));
    }
  }
}

class GeneradorDecoraciones {
  static const Map<String, List<String>> decoracionesDisponibles = {
    'Gusano con Flor': [
      'Escenario/Decorado/Gusano con Flor/Gusano Con Flor1.png',
      'Escenario/Decorado/Gusano con Flor/Gusano Con Flor2.png',
      'Escenario/Decorado/Gusano con Flor/Gusano Con Flor3.png',
      'Escenario/Decorado/Gusano con Flor/Gusano Con Flor4.png',
    ],
    'Gusano con Flor Rojo': [
      'Escenario/Decorado/Gusano con Flor/Gusano Con Flor(rojo)1.png',
      'Escenario/Decorado/Gusano con Flor/Gusano Con Flor(rojo)2.png',
      'Escenario/Decorado/Gusano con Flor/Gusano Con Flor(rojo)3.png',
      'Escenario/Decorado/Gusano con Flor/Gusano Con Flor(rojo)4.png',
    ],
    'Rocas': [
      'Escenario/Decorado/rocas/rocas.png',
    ],
    'Pasto': [
      'Escenario/Decorado/Pasto/Pasto1.png',
      'Escenario/Decorado/Pasto/Pasto2.png',
    ],
    'Pasto Dos': [
      'Escenario/Decorado/Pasto/Pasto dos1.png',
      'Escenario/Decorado/Pasto/Pasto dos2.png',
    ],
    'Flores Uno': [
      'Escenario/Decorado/Flores/Flores uno1.png',
      'Escenario/Decorado/Flores/Flores uno2.png',
    ],
    'Flores Uno Rojo': [
      'Escenario/Decorado/Flores/Flores uno(rojo)1.png',
      'Escenario/Decorado/Flores/Flores uno(rojo)2.png',
    ],
    'Flores Dos': [
      'Escenario/Decorado/Flores/Flores dos1.png',
      'Escenario/Decorado/Flores/Flores dos2.png',
    ],
    'Flores Dos Rojo': [
      'Escenario/Decorado/Flores/Flores dos(rojo)1.png',
      'Escenario/Decorado/Flores/Flores dos(rojo)2.png',
    ],
  };

  static Decorado crearDecoracionAleatoria(Vector2 posicion) {
    final random = math.Random();
    final decoraciones = decoracionesDisponibles.values.toList();
    final decoracionSeleccionada = decoraciones[random.nextInt(decoraciones.length)];
    
    return Decorado(
      position: posicion,
      frames: decoracionSeleccionada,
      tiempoEntreFrames: 0.2,
    );
  }

  static Decorado crearFlor(Vector2 posicion) {
    final random = math.Random();
    final flores = [
      decoracionesDisponibles['Flores Uno']!,
      decoracionesDisponibles['Flores Uno Rojo']!,
      decoracionesDisponibles['Flores Dos']!,
      decoracionesDisponibles['Flores Dos Rojo']!,
    ];
    final florSeleccionada = flores[random.nextInt(flores.length)];
    
    return Decorado(
      position: posicion,
      frames: florSeleccionada,
      tiempoEntreFrames: 0.2,
    );
  }

  static Decorado crearPasto(Vector2 posicion) {
    final random = math.Random();
    final pastos = [
      decoracionesDisponibles['Pasto']!,
      decoracionesDisponibles['Pasto Dos']!,
    ];
    final pastoSeleccionado = pastos[random.nextInt(pastos.length)];
    
    return Decorado(
      position: posicion,
      frames: pastoSeleccionado,
      tiempoEntreFrames: 0.2,
    );
  }
}
