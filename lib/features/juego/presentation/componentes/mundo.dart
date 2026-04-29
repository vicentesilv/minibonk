import 'dart:ui';

import 'package:flame/components.dart';

class MundoIsometrico extends PositionComponent with HasGameRef {
  static const int columnas = 30;
  static const int filas = 30;
  static const double tamanoTile = 128;
  static const int bordeAgua = 3;

  late Sprite grassSprite;
  late Sprite aguaSprite;

  @override
  Future<void> onLoad() async {
    // Cargamos las imágenes del terreno y del mar
    final imagePasto = await gameRef.images.load('Escenario/Suelos/pasto.png');
    final imageAgua = await gameRef.images.load('Escenario/Suelos/agua.png');
    grassSprite = Sprite(imagePasto);
    aguaSprite = Sprite(imageAgua);

    // Generamos el mapa 30x30
    _generarMapa();
  }

  void _generarMapa() {
    // Tamaño del tile (128x128) con superposición para evitar separaciones por renderizado
    const double tileSizeIso = tamanoTile;
    const double tileSizeRender = 128.5; // Superposición de 0.5 píxeles

    final inicioX = -bordeAgua;
    final finX = columnas + bordeAgua;
    final inicioY = -bordeAgua;
    final finY = filas + bordeAgua;

    for (int x = inicioX; x < finX; x++) {
      for (int y = inicioY; y < finY; y++) {
        // Posicionamiento ortográfico simple
        final posX = x.toDouble() * tileSizeIso;
        final posY = y.toDouble() * tileSizeIso;

        final esPasto = x >= 0 && x < columnas && y >= 0 && y < filas;

        final tile = SpriteComponent(
          sprite: esPasto ? grassSprite : aguaSprite,
          position: Vector2(posX, posY),
          size: Vector2(tileSizeRender, tileSizeRender),
          priority: y,
          anchor: Anchor.topLeft,
        );
        
        // Configurar paint para evitar antialiasing
        tile.paint = Paint()
          ..filterQuality = FilterQuality.none
          ..isAntiAlias = false;
        
        add(tile);
      }
    }
  }
}
