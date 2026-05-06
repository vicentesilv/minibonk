import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:minibonk/features/juego/presentation/componentes/mundo.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';


abstract class PersonajeBase extends SpriteComponent
    with CollisionCallbacks, HasGameReference<JuegoMiniBonk> {
  PersonajeBase({required super.position, Vector2? size, Anchor anchor = Anchor.center})
      : super(
          size: size ?? Vector2(50, 50),
          anchor: anchor,
        );

  double velocidadMovimiento = 190;
  double vidaMaxima = 100;
  double vida = 100;
  double cadenciaDisparo = 0.35;
  double danioBala = 12;
  double velocidadProyectil = 300;
  int proyectilesPorDisparo = 1;

  void reiniciarAtributos() {}
}

class Jugador extends PersonajeBase {
  Jugador({required super.position})
      : super(size: Vector2(50, 50));

  double _temporizadorDisparo = 0;

  late Sprite _spriteArriba;
  late Sprite _spriteAbajo;
  late Sprite _spriteDerecha;
  late Sprite _spriteIzquierda;

  Vector2 _ultimaDireccion = Vector2(0, -1); // Por defecto mirando arriba

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Cargar las imágenes
    _spriteArriba = await Sprite.load('personajes/prueba/arriba.png');
    _spriteAbajo = await Sprite.load('personajes/prueba/abajo.png');
    _spriteDerecha = await Sprite.load('personajes/prueba/derecha.png');
    _spriteIzquierda = await Sprite.load('personajes/prueba/izquierda.png');

    // Establecer sprite inicial
    sprite = _spriteAbajo;
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    final entrada = game.entradaMovimiento;
    position += entrada * velocidadMovimiento * dt;

    final mitadAnchoJugador = size.x / 2;
    final mitadAltoJugador = size.y / 2;
    final limiteX = (MundoIsometrico.columnas * MundoIsometrico.tamanoTile) - mitadAnchoJugador;
    final limiteY = (MundoIsometrico.filas * MundoIsometrico.tamanoTile) - mitadAltoJugador;

    position.x = position.x.clamp(mitadAnchoJugador, limiteX);
    position.y = position.y.clamp(mitadAltoJugador, limiteY);

    if (entrada.length2 > 0) {
      _ultimaDireccion = entrada.normalized();
      _actualizarImagenSegunDireccion();
    }

    _temporizadorDisparo += dt;
    if (_temporizadorDisparo >= cadenciaDisparo) {
      _temporizadorDisparo = 0;
      _dispararAlMasCercano();
    }
  }

  void _actualizarImagenSegunDireccion() {
    sprite = (_ultimaDireccion.y.abs() > _ultimaDireccion.x.abs())
        ? (_ultimaDireccion.y < 0 ? _spriteArriba : _spriteAbajo)
        : (_ultimaDireccion.x < 0 ? _spriteIzquierda : _spriteDerecha);
  }


  // void _actualizarImagenSegunDireccion() {
  //   final absX = _ultimaDireccion.x.abs();
  //   final absY = _ultimaDireccion.y.abs();

  //   if (absY > absX) {
  //     // Movimiento vertical es dominante
  //     if (_ultimaDireccion.y < 0) {
  //       sprite = _spriteArriba;
  //     } else {
  //       sprite = _spriteAbajo;
  //     }
  //   } else {
  //     // Movimiento horizontal es dominante
  //     if (_ultimaDireccion.x < 0) {
  //       sprite = _spriteIzquierda;
  //     } else {
  //       sprite = _spriteDerecha;
  //     }
  //   }
  // }

  // void reiniciarAtributos() {
  //   velocidadMovimiento = 190;
  //   vidaMaxima = 100;
  //   vida = 100;
  //   cadenciaDisparo = 0.35;
  //   danioBala = 12;
  //   velocidadProyectil = 300;
  //   proyectilesPorDisparo = 1;
  //   _temporizadorDisparo = 0;
  //   game.estadoUi.value = game.estadoUi.value.copyWith(vida: vida, vidaMaxima: vidaMaxima);
  // }

  void _dispararAlMasCercano() {
    final objetivo = game.obtenerEnemigoMasCercano(position);
    if (objetivo == null) {
      return;
    }

    final base = (objetivo.position - position).normalized();

    if (proyectilesPorDisparo == 1) {
      game.crearBala(
        origen: position.clone(),
        direccion: base,
        velocidad: velocidadProyectil,
        danio: danioBala,
      );
      return;
    }

    final apertura = 0.18;
    final inicio = -apertura * (proyectilesPorDisparo - 1) / 2;

    for (var i = 0; i < proyectilesPorDisparo; i++) {
      final angulo = inicio + i * apertura;
      final direccion = base.clone()..rotate(angulo);
      game.crearBala(
        origen: position.clone(),
        direccion: direccion,
        velocidad: velocidadProyectil,
        danio: danioBala,
      );
    }
  }
}

class Enemigo extends CircleComponent
    with CollisionCallbacks, HasGameReference<JuegoMiniBonk> {
  Enemigo({
    required super.position,
    required this.velocidad,
    required this.vida,
    required this.danioContacto,
  }) : super(
         radius: 11,
         anchor: Anchor.center,
         paint: Paint()..color = const Color(0xFFAA4AFF),
       );

  final double velocidad;
  final double danioContacto;
  double vida;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (game.finDePartida) {
      return;
    }
    final direccion = (game.jugador.position - position).normalized();
    position += direccion * velocidad * dt;
  }

  void recibirImpacto(double danio) {
    vida -= danio;
    if (vida <= 0) {
      game.alEliminarEnemigo();
      game.crearOrbeXp(position.clone(), 9);
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is PersonajeBase) {
      game.recibirDanioJugador(danioContacto);
      game.alEliminarEnemigo();
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}

class Bala extends CircleComponent
    with CollisionCallbacks, HasGameReference<JuegoMiniBonk> {
  Bala({
    required super.position,
    required this.velocidad,
    required this.danio,
  }) : super(
         radius: 4,
         anchor: Anchor.center,
         paint: Paint()..color = const Color(0xFFFFD166),
       );

  final Vector2 velocidad;
  final double danio;
  double _tiempoDeVida = 1.7;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocidad * dt;
    _tiempoDeVida -= dt;
    // Eliminar la bala solo si agota su tiempo de vida
    // (ya no usar límites de pantalla porque está en mapContainer que se mueve)
    if (_tiempoDeVida <= 0) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Enemigo) {
      other.recibirImpacto(danio);
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}

class OrbeXp extends SpriteComponent
    with CollisionCallbacks, HasGameReference<JuegoMiniBonk> {
  OrbeXp({required super.position, required this.valor})
      : super(
          anchor: Anchor.center,
          priority: 100000,
        );

  final double valor;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load('Objetos del Mapa/exp.png');
    // Asegurar que el sprite se dibuje al tamaño deseado
    size = Vector2(84, 84);
    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is PersonajeBase) {
      game.agregarXp(valor);
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}

class Moneda extends SpriteComponent with HasGameReference<JuegoMiniBonk> {
  Moneda({required super.position})
      : super(
          anchor: Anchor.center,
          priority: 90000,
          
          // paint: Paint()..color = const Color(0xFFFFD54A),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load('Objetos del Mapa/moneda.png');
    size = Vector2(100, 100);   
}
}
