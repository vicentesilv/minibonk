import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minibonk/features/juego/presentation/aplicacion/aplicacion_mini_bonk.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const AplicacionMiniBonk());
}