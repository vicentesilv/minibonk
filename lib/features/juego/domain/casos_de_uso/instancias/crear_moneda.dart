import 'package:flame/components.dart';
import 'package:minibonk/features/juego/presentation/componentes/entidades.dart';
import 'package:minibonk/features/juego/presentation/componentes/mundo.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';

void crearMonedaJuego(JuegoMiniBonk juego, {required Vector2 posicion}) {
  juego.mapContainer.add(Moneda(position: posicion));
}

void distribuirMonedasOleadaJuego(JuegoMiniBonk juego) {
  juego.eliminarMonedasEntreRondas();

  const columnas = 4;
  const filas = 3;
  const margen = 96.0;

  final anchoMundo = MundoIsometrico.columnas * MundoIsometrico.tamanoTile;
  final altoMundo = MundoIsometrico.filas * MundoIsometrico.tamanoTile;
  final anchoSector = anchoMundo / columnas;
  final altoSector = altoMundo / filas;

  for (var fila = 0; fila < filas; fila++) {
    for (var columna = 0; columna < columnas; columna++) {
      final centroX = (columna + 0.5) * anchoSector;
      final centroY = (fila + 0.5) * altoSector;

      final x = (centroX + (juego.aleatorio.nextDouble() - 0.5) * anchoSector * 0.55)
          .clamp(margen, anchoMundo - margen)
          .toDouble();
      final y = (centroY + (juego.aleatorio.nextDouble() - 0.5) * altoSector * 0.55)
          .clamp(margen, altoMundo - margen)
          .toDouble();

      crearMonedaJuego(juego, posicion: Vector2(x, y));
    }
  }
}