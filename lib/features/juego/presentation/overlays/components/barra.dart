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
        // Text(
        //   etiqueta,
        //   style: const TextStyle(
        //     color: Colors.white,
        //     fontSize: 12,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        // SizedBox(height: compacta ? 2 : 3),
        Container(
          padding: const EdgeInsets.all(1.2),
          decoration: BoxDecoration(
            color: const Color(0xFF0C1218),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFF95C6DA),
              width: 3,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: const Color(0xFF2B3A46),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: SizedBox(
                height: alto,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image.asset(
                    //   'assets/images/Visual/Gui/Barra/Barra.png',
                    //   fit: BoxFit.fill,
                    //   filterQuality: FilterQuality.none,
                    //   errorBuilder: (context, error, stackTrace) {
                    //     return Container(
                    //       color: Colors.grey[700],
                    //     );
                    //   },
                    // ),
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
          ),
        ),
      ],
    );
  }
}
