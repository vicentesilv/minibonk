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
    final esMovil = anchoPantalla < 600;
    final altoImagen = esMovil ? 110.0 : 180.0;
    final tamanioTitulo = esMovil ? 18.0 : 22.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: fondo,
          borderRadius: BorderRadius.circular(22),
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
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borde),
              ),
              padding: const EdgeInsets.all(12),
              child: animacionAssets != null
                  ? PreviewAnim(frames: animacionAssets!)
                  : Image.asset(
                      imagenAsset ?? '',
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.none,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.person, size: 72, color: Colors.white54),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              titulo,
              style: TextStyle(
                color: Colors.white,
                fontSize: tamanioTitulo,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitulo,
              style: TextStyle(
                color: seleccionada ? const Color(0xFF8CFF93) : Colors.white60,
                fontWeight: FontWeight.w600,
                fontSize: esMovil ? 13 : 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            const SizedBox(height: 8),
            Text(
              descripcion,
              style: TextStyle(
                color: Colors.white70,
                height: 1.25,
                fontSize: esMovil ? 12.5 : 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.symmetric(horizontal: esMovil ? 12 : 14, vertical: esMovil ? 7 : 8),
              decoration: BoxDecoration(
                color: seleccionada ? const Color(0xFF2D6B31) : const Color(0xFF26302A),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                seleccionada ? 'Seleccionado' : 'Toca para elegir',
                style: TextStyle(
                  color: seleccionada ? Colors.white : Colors.white70,
                  fontWeight: FontWeight.w700,
                  fontSize: esMovil ? 12.5 : 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
