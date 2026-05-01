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
    final alto = compacta ? 10.0 : 14.0;
    
    return Column(
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
        SizedBox(height: compacta ? 2 : 3),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: SizedBox(
            height: alto,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Fondo con imagen
                // Image.asset(
                //   'assets/images/Visual/Gui/Barra/Barra.png',
                //   fit: BoxFit.fitHeight,
                //   errorBuilder: (context, error, stackTrace) {
                //     return Container(
                //       color: Colors.grey[700],
                //     );
                //   },
                // ),
                // Barra de progreso con gradiente
                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: valorAjustado,
                    heightFactor: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.9),
                            color,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
