import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:minibonk/features/juego/domain/modelos/estado_interfaz_juego.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';
import 'package:minibonk/features/juego/presentation/overlays/components/barra.dart';
import 'package:minibonk/features/juego/presentation/overlays/components/filaetiqueta.dart';

class SuperposicionHud extends StatelessWidget {
  const SuperposicionHud({super.key, required this.juego});

  final JuegoMiniBonk juego;

  @override
  Widget build(BuildContext context) {
    final esMovil = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.fuchsia);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ValueListenableBuilder<EstadoInterfazJuego>(
          valueListenable: juego.estadoUi,
          builder: (context, estado, _) {
            final porcentajeVida =
                estado.vidaMaxima == 0 ? 0.0 : (estado.vida / estado.vidaMaxima);
            final porcentajeXp =
                estado.xpSiguiente == 0 ? 0.0 : (estado.xp / estado.xpSiguiente);

            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FilaEtiqueta(
                      texto:
                          'Oleada ${estado.oleada}  •  Nivel ${estado.nivel}  •  Eliminaciones ${estado.eliminaciones}',
                    ),
                    const SizedBox(height: 8),
                    Barra(
                      etiqueta: 'Vida',
                      valor: porcentajeVida,
                      color: const Color(0xFFFF5A5A),
                    ),
                    const SizedBox(height: 6),
                    Barra(
                      etiqueta: 'Experiencia',
                      valor: porcentajeXp,
                      color: const Color(0xFF64D2FF),
                    ),
                    const SizedBox(height: 8),
                    if (esMovil && !estado.pausadoManual && !estado.finDePartida)
                      Align(
                        alignment: Alignment.centerRight,
                        child: FilledButton.icon(
                          onPressed: juego.alternarPausaManual,
                          icon: const Icon(Icons.pause),
                          label: const Text('Pausar'),
                        ),
                      ),
                    const Spacer(),
                    const FilaEtiqueta(
                      texto: 'Muévete con WASD/Flechas o joystick • Disparo automático',
                    ),
                    const SizedBox(height: 8),
                    const FilaEtiqueta(
                      texto: 'En PC: pausa con ESC',
                    ),
                  ],
                ),
                if (estado.pausadoManual) ...[
                  Positioned.fill(
                    child: Container(
                      color: const Color(0x99000000),
                      alignment: Alignment.center,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 320),
                        child: Card(
                          color: const Color(0xFF1A1D24),
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'PAUSA',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                FilledButton.icon(
                                  onPressed: juego.alternarPausaManual,
                                  icon: const Icon(Icons.play_arrow),
                                  label: const Text('Quitar pausa'),
                                ),
                                const SizedBox(height: 10),
                                FilledButton.tonal(
                                  onPressed: juego.reiniciarJuego,
                                  child: const Text('Reiniciar partida'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                if (estado.finDePartida) ...[
                  Positioned.fill(
                    child: Container(
                      color: const Color(0x99000000),
                      alignment: Alignment.center,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 320),
                        child: Card(
                          color: const Color(0xFF1A1D24),
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'FIN DE PARTIDA',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                FilledButton(
                                  onPressed: juego.reiniciarJuego,
                                  child: const Text('Reiniciar partida'),
                                ),
                              ],
                            ),
                          ),
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