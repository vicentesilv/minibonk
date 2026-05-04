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
    final ancho = MediaQuery.sizeOf(context).width;
    final compacto = esMovil || ancho < 700;
    final margen = compacto ? 8.0 : 12.0;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(margen),
        child: ValueListenableBuilder<EstadoInterfazJuego>(
          valueListenable: juego.estadoUi,
          builder: (context, estado, _) {
            final porcentajeVida =
                estado.vidaMaxima == 0 ? 0.0 : (estado.vida / estado.vidaMaxima);
            final porcentajeXp =
                estado.xpSiguiente == 0 ? 0.0 : (estado.xp / estado.xpSiguiente);

            if (compacto) {
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 280),
                      child: FilaEtiqueta(
                        texto:
                            'Oleada ${estado.oleada}  •   Eliminaciones ${estado.eliminaciones}${estado.tiempoEsperaOleada > 0 ? '  •  Siguiente en ${estado.tiempoEsperaOleada.ceil()}s' : ''}',
                        compacta: true,
                      ),
                    ),
                  ),
                  if (!estado.pausadoManual && !estado.finDePartida)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: FilledButton.icon(
                        onPressed: juego.alternarPausaManual,
                        icon: const Icon(Icons.pause_rounded, size: 18),
                        label: const Text('Pausar'),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF2A3346),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          minimumSize: const Size(0, 44),
                          elevation: 4,
                          shadowColor: Colors.black.withOpacity(0.28),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.08),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 640),
                      child: const SizedBox.shrink(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Barra(
                              etiqueta: 'Vida',
                              valor: porcentajeVida,
                              color: const Color(0xFFFF5A5A),
                              compacta: true,
                            ),
                            const SizedBox(height: 4),
                            Barra(
                              etiqueta: 'Experiencia',
                              valor: porcentajeXp,
                              color: const Color(0xFF64D2FF),
                              compacta: true,
                            ),
                          ],
                        ),
                      ),
                    ),
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
                                  FilledButton.tonalIcon(
                                    onPressed: juego.nuevaPartida,
                                    icon: const Icon(Icons.replay),
                                    label: const Text('Nueva partida'),
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
                ],
              );
            }

            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: FilaEtiqueta(
                          texto:
                              'Oleada ${estado.oleada}a  •  Eliminaciones ${estado.eliminaciones}${estado.tiempoEsperaOleada > 0 ? '  •  Siguiente en ${estado.tiempoEsperaOleada.ceil()}s' : ''}',
                          compacta: compacto,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (!estado.pausadoManual && !estado.finDePartida)
                        FilledButton.icon(
                          onPressed: juego.alternarPausaManual,
                          icon: const Icon(Icons.pause_rounded, size: 18),
                          label: const Text('Pausar'),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF2A3346),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                            minimumSize: const Size(0, 46),
                            elevation: 5,
                            shadowColor: Colors.black.withOpacity(0.28),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                              side: BorderSide(
                                color: Colors.white.withOpacity(0.08),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Barra(
                            etiqueta: 'Vida',
                            valor: porcentajeVida,
                            color: const Color(0xFFFF5A5A),
                            compacta: compacto,
                          ),
                          SizedBox(height: compacto ? 3 : 4),
                          Barra(
                            etiqueta: 'Experiencia',
                            valor: porcentajeXp,
                            color: const Color(0xFF64D2FF),
                            compacta: compacto,
                          ),
                        ],
                      ),
                    ),
                  ),
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
                                FilledButton.tonalIcon(
                                  onPressed: juego.nuevaPartida,
                                  icon: const Icon(Icons.replay),
                                  label: const Text('Nueva partida'),
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