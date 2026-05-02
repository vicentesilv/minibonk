import 'package:flutter/material.dart';
import 'package:minibonk/features/juego/presentation/overlays/components/preview_personaje.dart';

class TarjetaPersonaje extends StatelessWidget {
  const TarjetaPersonaje({
    required this.titulo,
    required this.subtitulo,
    required this.descripcion,
    required this.seleccionada,
    required this.onTap,
    this.imagenAsset,
    this.animacionAssets,
  });

  final String titulo;
  final String subtitulo;
  final String descripcion;
  final bool seleccionada;
  final VoidCallback onTap;
  final String? imagenAsset;
  final List<String>? animacionAssets;

  @override
  Widget build(BuildContext context) {
    final borde = seleccionada ? const Color(0xFF6DFF7A) : const Color(0xFF3A4A3C);
    final fondo = seleccionada ? const Color(0xFF1E2F21) : const Color(0xFF0F1410);
    final anchoPantalla = MediaQuery.sizeOf(context).width;
    final esMovil = anchoPantalla < 700;
    final altoImagen = esMovil ? 84.0 : 128.0;
    final tamanioTitulo = esMovil ? 14.0 : 17.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: fondo,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borde, width: 2),
          boxShadow: [
            BoxShadow(
              color: seleccionada ? const Color(0x5533FF77) : Colors.black45,
              blurRadius: seleccionada ? 20 : 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: altoImagen,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF0D130F),
                    seleccionada ? const Color(0xFF18361D) : const Color(0xFF0F1511),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borde),
              ),
                padding: const EdgeInsets.all(6),
              child: animacionAssets != null
                  ? PreviewAnim(frames: animacionAssets!)
                  : Image.asset(
                      imagenAsset ?? '',
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.none,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.person, size: 54, color: Colors.white54),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 4),
            LayoutBuilder(
              builder: (context, constraints) {
                final usarColumna = constraints.maxWidth < 340;

                if (usarColumna) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: tamanioTitulo,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitulo,
                        style: TextStyle(
                          color: seleccionada
                              ? const Color(0xFF8CFF93)
                              : Colors.white60,
                          fontWeight: FontWeight.w600,
                          fontSize: esMovil ? 11 : 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        descripcion,
                        style: TextStyle(
                          color: Colors.white70,
                          height: 1.25,
                          fontSize: esMovil ? 10.0 : 11.0,
                        ),
                        maxLines: esMovil ? 3 : 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titulo,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: tamanioTitulo,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitulo,
                            style: TextStyle(
                              color: seleccionada
                                  ? const Color(0xFF8CFF93)
                                  : Colors.white60,
                              fontWeight: FontWeight.w600,
                              fontSize: esMovil ? 11 : 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 5,
                      child: Text(
                        descripcion,
                        style: TextStyle(
                          color: Colors.white70,
                          height: 1.25,
                          fontSize: esMovil ? 10.0 : 11.0,
                        ),
                        maxLines: esMovil ? 3 : 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
