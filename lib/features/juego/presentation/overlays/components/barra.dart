import 'package:flutter/material.dart';

class Barra extends StatelessWidget {
  const Barra({
    super.key,
    required this.etiqueta,
    required this.valor,
    required this.color,
    this.compacta = false,
  });

  final String etiqueta;
  final double valor;
  final Color color;
  final bool compacta;

  @override
  Widget build(BuildContext context) {
    final valorAjustado = valor.clamp(0.0, 1.0);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xAA000000),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compacta ? 7 : 8,
          vertical: compacta ? 2 : 5,
        ),
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
            SizedBox(height: compacta ? 2 : 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: compacta ? 6 : 9,
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
