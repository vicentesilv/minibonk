import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minibonk/features/juego/presentation/aplicacion/aplicacion_mini_bonk.dart';
import 'dart:async';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ignorar mensajes relacionados con Impeller (workaround)
  WidgetsBinding.instance.platformDispatcher.onPlatformMessage =
      (String name, ByteData? data, PlatformMessageResponseCallback? callback) {
        if (name == 'flutter/settings') {
          final String message = data != null
              ? String.fromCharCodes(data.buffer.asUint8List())
              : '';
          if (message.contains('impeller')) {
            // Ignorar mensajes relacionados con impeller
            return;
          }
        }
        ServicesBinding.instance.defaultBinaryMessenger.handlePlatformMessage(
          name,
          data,
          callback,
        );
      };

  // Forzar orientación horizontal y bloquear vertical
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Esperar a que el tamaño del viewport sea válido
  await _waitForValidViewport();

  runApp(const AplicacionMiniBonk());
}

Future<void> _waitForValidViewport() async {
  // Espera hasta que el tamaño de pantalla sea válido (no 0)
  while (true) {
    final size = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;
    if (size.width > 0 && size.height > 0) {
      break;
    }
    await Future.delayed(const Duration(milliseconds: 50));
  }
}
