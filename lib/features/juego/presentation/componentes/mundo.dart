import 'dart:ui';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:minibonk/features/juego/presentation/componentes/decorado.dart';

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
    
    // Generamos decoraciones aleatorias
    _generarDecoraciones();
  }

  void _generarDecoraciones() {
    const double tileSizeIso = tamanoTile;
    final random = math.Random();
    const double densidadFlores = 0.50; // 50% del mapa tiene flores
    const double densidadPasto = 0.90; // 90% del mapa tiene pasto
    const double distanciaMinima = 256; // Distancia mínima entre flores (2 tiles)
    
    final List<Vector2> posicionesFlores = [];
    
    // Primera pasada: generar pasto
    for (int x = 0; x < columnas; x++) {
      for (int y = 0; y < filas; y++) {
        final posX = x.toDouble() * tileSizeIso + tileSizeIso / 2;
        final posY = y.toDouble() * tileSizeIso + tileSizeIso / 2;
        
        if (random.nextDouble() < densidadPasto) {
          final pasto = GeneradorDecoraciones.crearPasto(
            Vector2(posX, posY),
          );
          pasto.priority = y + 1;
          add(pasto);
        }
      }
    }
    
    // Segunda pasada: generar flores con verificación de distancia
    for (int x = 0; x < columnas; x++) {
      for (int y = 0; y < filas; y++) {
        if (random.nextDouble() < densidadFlores) {
          final posX = x.toDouble() * tileSizeIso + tileSizeIso / 2;
          final posY = y.toDouble() * tileSizeIso + tileSizeIso / 2;
          final posFlor = Vector2(posX, posY);
          
          // Verificar que no haya flor muy cercana
          bool hayFlorasCerca = false;
          for (final posFlorExistente in posicionesFlores) {
            if (posFlor.distanceTo(posFlorExistente) < distanciaMinima) {
              hayFlorasCerca = true;
              break;
            }
          }
          
          // Solo generar flor si no hay flores cerca
          if (!hayFlorasCerca) {
            final flor = GeneradorDecoraciones.crearFlor(posFlor);
            flor.priority = y + 2;
            add(flor);
            posicionesFlores.add(posFlor);
          }
        }
      }
    }
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
