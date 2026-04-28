import 'package:flame/components.dart';

class MundoIsometrico extends PositionComponent with HasGameRef {
  late Sprite grassSprite;

  @override
  Future<void> onLoad() async {
    // Cargamos la imagen del terreno
    final image = await gameRef.images.load('terreno.png');
    grassSprite = Sprite(
      image,
      srcPosition: Vector2(0, 0),
      srcSize: Vector2(256, 256),
    );

    // Generamos el mapa isométrico 30x30
    _generarMapaIsometrico();
  }

  void _generarMapaIsometrico() {
    // Tamaño del tile isométrico (128x128)
    const double tileSizeIso = 128;
    const double mitadTile = 64; // Mitad del tamaño para las coordenadas isométricas

    for (int x = 0; x < 30; x++) {
      for (int y = 0; y < 30; y++) {
        // Fórmula isométrica: convertir (x, y) a coordenadas de pantalla
        final posX = (x - y).toDouble() * mitadTile;
        final posY = (x + y).toDouble() * mitadTile / 2;

        add(
          SpriteComponent(
            sprite: grassSprite,
            position: Vector2(posX, posY),
            size: Vector2(tileSizeIso, tileSizeIso),
            // priority para renderizar en orden correcto (de arriba a abajo)
            priority: x + y,
          ),
        );
      }
    }
  }
}
