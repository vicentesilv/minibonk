import 'package:flutter/material.dart';

class FilaEtiqueta extends StatelessWidget {
  const FilaEtiqueta({
    super.key,
    required this.texto,
    this.compacta = false,
  });

  final String texto;
  final bool compacta;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xAA000000),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compacta ? 8 : 10,
          vertical: compacta ? 4 : 6,
        ),
        child: Text(
          texto,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: compacta ? 12 : 14,
          ),
        ),
      ),
    );
  }
}