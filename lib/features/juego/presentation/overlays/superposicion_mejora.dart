import 'package:flutter/material.dart';
import 'package:minibonk/features/juego/domain/modelos/tipo_mejora.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';



class SuperposicionMejora extends StatelessWidget {
  const SuperposicionMejora({super.key, required this.juego});

  final JuegoMiniBonk juego;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xAA000000),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            color: const Color(0xFF1C222D),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Subes de nivel',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Elige una mejora',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  ...juego.opcionesActualesDeMejora.map(
                    (mejora) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton.tonal(
                          onPressed: () => juego.aplicarMejora(mejora),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mejora.titulo,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(mejora.descripcion),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
