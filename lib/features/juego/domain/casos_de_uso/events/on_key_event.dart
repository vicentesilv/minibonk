import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';

KeyEventResult onKeyEventJuego(
  JuegoMiniBonk juego,
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

  juego.entradaTeclado = Vector2(x.toDouble(), y.toDouble());
  if (juego.entradaTeclado.length2 > 1) {
    juego.entradaTeclado.normalize();
  }
  return KeyEventResult.handled;
}