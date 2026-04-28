import 'package:flutter/material.dart';

class Barra extends StatelessWidget {
  const Barra({super.key, required this.etiqueta, required this.valor, required this.color});

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
