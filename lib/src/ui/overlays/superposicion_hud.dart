import 'package:flutter/material.dart';
import 'package:minibonk/src/utils/components/barra.dart';
import 'package:minibonk/src/utils/components/filaetiqueta.dart';

import '../../game/juego_mini_bonk.dart';
import '../../game/models/estado_ui.dart';

class SuperposicionHud extends StatelessWidget {
  const SuperposicionHud({super.key, required this.juego});

  final JuegoMiniBonk juego;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ValueListenableBuilder<EstadoUi>(
          valueListenable: juego.estadoUi,
          builder: (context, estado, _) {
            final porcentajeVida =
                estado.vidaMaxima == 0 ? 0.0 : (estado.vida / estado.vidaMaxima);
            final porcentajeXp =
                estado.xpSiguiente == 0 ? 0.0 : (estado.xp / estado.xpSiguiente);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilaEtiqueta(
                  texto:
                      'oleada ${estado.oleada}  •  Nivel ${estado.nivel}  •  Kills ${estado.eliminaciones}',
                ),
                const SizedBox(height: 8),
                Barra(
                  etiqueta: 'HP',
                  valor: porcentajeVida,
                  color: const Color(0xFFFF5A5A),
                ),
                const SizedBox(height: 6),
                Barra(
                  etiqueta: 'XP',
                  valor: porcentajeXp,
                  color: const Color(0xFF64D2FF),
                ),
                const Spacer(),
                const FilaEtiqueta(
                  texto: 'Mueve con WASD/Flechas o joystick • Auto-disparo',
                ),
                if (estado.finDePartida) ...[
                  const SizedBox(height: 10),
                  Center(
                    child: Card(
                      color: const Color(0xDD1A1D24),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'GAME OVER',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FilledButton(
                              onPressed: juego.reiniciarJuego,
                              child: const Text('Reiniciar'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}