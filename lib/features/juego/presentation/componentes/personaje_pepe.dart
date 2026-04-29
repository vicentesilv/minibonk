import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:minibonk/features/juego/presentation/componentes/entidades.dart';
import 'package:minibonk/features/juego/presentation/componentes/mundo.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';

class Pepe extends PersonajeBase {
  Pepe({required super.position})
      : super(size: Vector2(56, 56));

  late List<Sprite> _quietoArriba;
  late List<Sprite> _quietoAbajo;
  late List<Sprite> _quietoDerecha;
  late List<Sprite> _quietoIzquierda;

  late List<Sprite> _moverArriba;
  late List<Sprite> _moverAbajo;
  late List<Sprite> _moverDerecha;
  late List<Sprite> _moverIzquierda;

  late List<Sprite> _ataqueArriba;
  late List<Sprite> _ataqueAbajo;
  late List<Sprite> _ataqueDerecha;
  late List<Sprite> _ataqueIzquierda;

  double _temporizadorAtaque = 0;
  double _temporizadorWifi = 0;
  double _tiempoAtaqueActivo = 0;
  bool _ataqueActivo = false;
  Vector2 _ultimaDireccion = Vector2(0, 1);
  String _direccionActual = 'abajo';
  List<Sprite> _animacionActual = [];
  int _frameActual = 0;
  double _timerFrame = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _quietoArriba = await _cargarSprites([
      'Personajes/pepe/quieto/quieto atras1.png',
      'Personajes/pepe/quieto/quieto atras2.png',
    ]);
    _quietoAbajo = await _cargarSprites([
      'Personajes/pepe/quieto/quieto enfrente1.png',
      'Personajes/pepe/quieto/quieto enfrente2.png',
    ]);
    _quietoDerecha = await _cargarSprites([
      'Personajes/pepe/quieto/quieto derecha1.png',
      'Personajes/pepe/quieto/quieto derecha2.png',
    ]);
    _quietoIzquierda = await _cargarSprites([
      'Personajes/pepe/quieto/quieto izquierda1.png',
      'Personajes/pepe/quieto/quieto izquierda2.png',
    ]);

    _moverArriba = await _cargarSprites([
      'Personajes/pepe/mover/caminar atras1.png',
      'Personajes/pepe/mover/caminar atras2.png',
      'Personajes/pepe/mover/caminar atras3.png',
      'Personajes/pepe/mover/caminar atras4.png',
    ]);
    _moverAbajo = await _cargarSprites([
      'Personajes/pepe/mover/caminar enfrente1.png',
      'Personajes/pepe/mover/caminar enfrente2.png',
      'Personajes/pepe/mover/caminar enfrente3.png',
      'Personajes/pepe/mover/caminar enfrente4.png',
    ]);
    _moverDerecha = await _cargarSprites([
      'Personajes/pepe/mover/caminar derecha1.png',
      'Personajes/pepe/mover/caminar derecha2.png',
      'Personajes/pepe/mover/caminar derecha3.png',
      'Personajes/pepe/mover/caminar derecha4.png',
    ]);
    _moverIzquierda = await _cargarSprites([
      'Personajes/pepe/mover/caminar izquierda1.png',
      'Personajes/pepe/mover/caminar izquierda2.png',
      'Personajes/pepe/mover/caminar izquierda3.png',
      'Personajes/pepe/mover/caminar izquierda4.png',
    ]);

    _ataqueArriba = await _cargarSprites([
      'Personajes/pepe/ataque/ataque atras1.png',
      'Personajes/pepe/ataque/ataque atras2.png',
      'Personajes/pepe/ataque/ataque atras3.png',
    ]);
    _ataqueAbajo = await _cargarSprites([
      'Personajes/pepe/ataque/ataque enfrente1.png',
      'Personajes/pepe/ataque/ataque enfrente2.png',
      'Personajes/pepe/ataque/ataque enfrente3.png',
    ]);
    _ataqueDerecha = await _cargarSprites([
      'Personajes/pepe/ataque/ataque derecha1.png',
      'Personajes/pepe/ataque/ataque derecha2.png',
      'Personajes/pepe/ataque/ataque derecha3.png',
    ]);
    _ataqueIzquierda = await _cargarSprites([
      'Personajes/pepe/ataque/ataque izquierda1.png',
      'Personajes/pepe/ataque/ataque izquierda2.png',
      'Personajes/pepe/ataque/ataque izquierda3.png',
    ]);

    sprite = _quietoAbajo.first;
    _animacionActual = _quietoAbajo;
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
      _direccionActual = _obtenerDireccion();
    }

    _temporizadorAtaque += dt;
    _temporizadorWifi += dt;

    if (_temporizadorAtaque >= cadenciaDisparo) {
      _temporizadorAtaque = 0;
      _atacarCuerpoACuerpo();
    }

    if (_temporizadorWifi >= 5) {
      _temporizadorWifi = 0;
      _activarWifi();
    }

    if (_ataqueActivo) {
      _tiempoAtaqueActivo -= dt;
      if (_tiempoAtaqueActivo <= 0) {
        _ataqueActivo = false;
      }
    }

    _actualizarAnimacion(dt, entrada.length2 > 0);
  }

  Future<List<Sprite>> _cargarSprites(List<String> rutas) async {
    final sprites = <Sprite>[];
    for (final ruta in rutas) {
      sprites.add(await Sprite.load(ruta));
    }
    return sprites;
  }

  String _obtenerDireccion() {
    final absX = _ultimaDireccion.x.abs();
    final absY = _ultimaDireccion.y.abs();

    if (absY > absX) {
      return _ultimaDireccion.y < 0 ? 'arriba' : 'abajo';
    }
    return _ultimaDireccion.x < 0 ? 'izquierda' : 'derecha';
  }

  List<Sprite> _obtenerAnimacion(bool moviendose) {
    final dir = _direccionActual;
    if (_ataqueActivo) {
      switch (dir) {
        case 'arriba':
          return _ataqueArriba;
        case 'izquierda':
          return _ataqueIzquierda;
        case 'derecha':
          return _ataqueDerecha;
        default:
          return _ataqueAbajo;
      }
    }

    if (moviendose) {
      switch (dir) {
        case 'arriba':
          return _moverArriba;
        case 'izquierda':
          return _moverIzquierda;
        case 'derecha':
          return _moverDerecha;
        default:
          return _moverAbajo;
      }
    }

    switch (dir) {
      case 'arriba':
        return _quietoArriba;
      case 'izquierda':
        return _quietoIzquierda;
      case 'derecha':
        return _quietoDerecha;
      default:
        return _quietoAbajo;
    }
  }

  void _actualizarAnimacion(double dt, bool moviendose) {
    final animacion = _obtenerAnimacion(moviendose);
    if (!identical(animacion, _animacionActual)) {
      _animacionActual = animacion;
      _frameActual = 0;
      _timerFrame = 0;
      sprite = _animacionActual.first;
      return;
    }

    if (_animacionActual.length <= 1) {
      sprite = _animacionActual.first;
      return;
    }

    _timerFrame += dt;
    if (_timerFrame >= 0.12) {
      _timerFrame = 0;
      _frameActual = (_frameActual + 1) % _animacionActual.length;
      sprite = _animacionActual[_frameActual];
    }
  }

  void _atacarCuerpoACuerpo() {
    final objetivo = game.obtenerEnemigoMasCercano(position);
    if (objetivo == null) {
      return;
    }

    final distancia = objetivo.position.distanceTo(position);
    if (distancia > 130) {
      return;
    }

    _ataqueActivo = true;
    _tiempoAtaqueActivo = 0.28;
    objetivo.recibirImpacto(danioBala);
  }

  void _activarWifi() {
    final direccion = _obtenerDireccion();
    final desplazamiento = switch (direccion) {
      'arriba' => Vector2(0, -90),
      'izquierda' => Vector2(-90, 0),
      'derecha' => Vector2(90, 0),
      _ => Vector2(0, 90),
    };

    final wifi = AtaqueWifi(
      position: position + desplazamiento,
      direccion: direccion,
      danio: danioBala * 2,
    );
    game.mapContainer.add(wifi);
  }

  @override
  void reiniciarAtributos() {
    velocidadMovimiento = 190;
    vidaMaxima = 100;
    vida = 100;
    cadenciaDisparo = 0.35;
    danioBala = 12;
    velocidadProyectil = 300;
    proyectilesPorDisparo = 1;
    _temporizadorAtaque = 0;
    _temporizadorWifi = 0;
    _tiempoAtaqueActivo = 0;
    _ataqueActivo = false;
    _frameActual = 0;
    _timerFrame = 0;
    game.estadoUi.value = game.estadoUi.value.copyWith(vida: vida, vidaMaxima: vidaMaxima);
  }
}

class AtaqueWifi extends SpriteComponent with HasGameReference<JuegoMiniBonk> {
  AtaqueWifi({
    required super.position,
    required this.direccion,
    required this.danio,
  }) : super(
          size: Vector2(180, 180),
          anchor: Anchor.center,
        );

  final String direccion;
  final double danio;
  double _tiempoVida = 0.55;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await _cargarSprite();
    _danarEnemigosCercanos();
  }

  Future<Sprite> _cargarSprite() async {
    switch (direccion) {
      case 'arriba':
        return Sprite.load('Personajes/pepe/ataque/wifi/wifi arriba.png');
      case 'izquierda':
        return Sprite.load('Personajes/pepe/ataque/wifi/wifi izquierda.png');
      case 'derecha':
        return Sprite.load('Personajes/pepe/ataque/wifi/wifi derecha.png');
      default:
        return Sprite.load('Personajes/pepe/ataque/wifi/wifi abajo.png');
    }
  }

  void _danarEnemigosCercanos() {
    for (final enemigo in game.mapContainer.children.whereType<Enemigo>()) {
      if (enemigo.position.distanceTo(position) <= 160) {
        enemigo.recibirImpacto(danio);
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    _tiempoVida -= dt;
    if (_tiempoVida <= 0) {
      removeFromParent();
    }
  }

}
