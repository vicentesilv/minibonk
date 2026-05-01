import 'package:flutter/material.dart';
import 'package:minibonk/features/juego/domain/modelos/tipo_personaje.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';
import 'package:minibonk/features/juego/presentation/overlays/components/tarjeta_personaje.dart';

class SuperposicionMenuInicio extends StatefulWidget {
  const SuperposicionMenuInicio({super.key, required this.juego});

  final JuegoMiniBonk juego;

  @override
  State<SuperposicionMenuInicio> createState() =>
      _SuperposicionMenuInicioState();
}

class _SuperposicionMenuInicioState extends State<SuperposicionMenuInicio> {
  TipoPersonaje? _seleccion;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final anchoPantalla = size.width;
    final altoPantalla = size.height;
    final esMovil = anchoPantalla < 600;
    // Usar porcentajes para móviles
    final margenExterior = esMovil ? altoPantalla * 0.015 : 24.0;
    final rellenoPanel = esMovil ? altoPantalla * 0.02 : 24.0;
    final maxAnchoPanel = esMovil ? anchoPantalla * 0.95 : 920.0;
    final maxAltoPanel = esMovil ? altoPantalla * 0.7 : altoPantalla * 0.85;
    final separacionTarjetas = esMovil ? altoPantalla * 0.015 : 16.0;
    final tamanioTitulo = esMovil ? altoPantalla * 0.03 : 34.0;
    final tamanioBoton = esMovil ? altoPantalla * 0.02 : 18.0;

    return Material(
      color: const Color(0xCC17351D),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF17351D), Color(0xFF2A5B2E), Color(0xFF17351D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(margenExterior),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxAnchoPanel,
                  maxHeight: maxAltoPanel,
                ),
                child: Container(
                  padding: EdgeInsets.all(rellenoPanel),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xF21A221C), Color(0xF20D140E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: const Color(0xFF4F8F55),
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xAA000000),
                        blurRadius: 32,
                        offset: Offset(0, 18),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F3E22),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: const Color(0xFF6DFF7A)),
                          ),
                          child: const Text(
                            'Minibonk',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Selecciona tu personaje',
                          style: tema.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: tamanioTitulo,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Elige el estilo de juego que prefieras. Cada personaje tiene su propia forma de atacar y moverse.',
                          style: tema.textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                            height: 1.35,
                            fontSize: esMovil ? 13.5 : 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: esMovil ? 16 : 24),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final usarColumna =
                                constraints.maxWidth < 720 || esMovil;
                            return Flex(
                              direction: usarColumna
                                  ? Axis.vertical
                                  : Axis.horizontal,
                              children: [
                                Expanded(
                                  child: TarjetaPersonaje(
                                    titulo: 'prueba',
                                    subtitulo: 'Distancia',
                                    descripcion:
                                        'personaje con ataques a distancia con proyectiles permitiendo alcanzar a los enemigos desde lejos sin necesidad de acercarse.',
                                    seleccionada:
                                        _seleccion == TipoPersonaje.prueba,
                                    imagenAsset:
                                        'assets/images/personajes/prueba/abajo.png',
                                    onTap: () {
                                      setState(() {
                                        _seleccion = TipoPersonaje.prueba;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: usarColumna ? 0 : separacionTarjetas,
                                  height: usarColumna ? separacionTarjetas : 0,
                                ),
                                Expanded(
                                  child: TarjetaPersonaje(
                                    titulo: 'Pepe',
                                    subtitulo: 'Cuerpo a cuerpo',
                                    descripcion:
                                        'personaje con ataques de cuerpo a cuerpo con buen nivel de daño y un ataque especial con la probabilidad de generar una onda wifi que daña o elimina a los enemigos .',
                                    seleccionada:
                                        _seleccion == TipoPersonaje.pepe,
                                    animacionAssets: const [
                                      'assets/images/Personajes/pepe/quieto/quieto enfrente1.png',
                                      'assets/images/Personajes/pepe/quieto/quieto enfrente2.png',
                                    ],
                                    onTap: () {
                                      setState(() {
                                        _seleccion = TipoPersonaje.pepe;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: esMovil ? 16 : 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _seleccion == null
                                ? null
                                : () {
                                    widget.juego.iniciarConPersonaje(
                                      _seleccion!,
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6DFF7A),
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(
                                vertical: esMovil ? 14 : 18,
                              ),
                              textStyle: TextStyle(
                                fontSize: tamanioBoton,
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 8,
                            ),
                            child: const Text('Comenzar partida'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
