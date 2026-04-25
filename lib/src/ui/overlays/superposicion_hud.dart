import 'package:flutter/material.dart';

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
                _FilaEtiqueta(
                  texto:
                      'Wave ${estado.oleada}  •  Nivel ${estado.nivel}  •  Kills ${estado.eliminaciones}',
                ),
                const SizedBox(height: 8),
                _Barra(
                  etiqueta: 'HP',
                  valor: porcentajeVida,
                  color: const Color(0xFFFF5A5A),
                ),
                const SizedBox(height: 6),
                _Barra(
                  etiqueta: 'XP',
                  valor: porcentajeXp,
                  color: const Color(0xFF64D2FF),
                ),
                const Spacer(),
                const _FilaEtiqueta(
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

class _FilaEtiqueta extends StatelessWidget {
  const _FilaEtiqueta({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xAA000000),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _Barra extends StatelessWidget {
  const _Barra({required this.etiqueta, required this.valor, required this.color});

  final String etiqueta;
  final double valor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final valorAjustado = valor.clamp(0.0, 1.0);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xAA000000),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              etiqueta,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 10,
                value: valorAjustado,
                backgroundColor: const Color(0x553A3A3A),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
