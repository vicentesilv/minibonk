// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late final PageController _pageController;
  TipoPersonaje _seleccion = TipoPersonaje.prueba;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.78);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _seleccionarPersonaje(TipoPersonaje personaje, int pagina) {
    setState(() {
      _seleccion = personaje;
    });

    if (_pageController.hasClients && _pageController.page?.round() != pagina) {
      _pageController.animateToPage(
        pagina,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final anchoPantalla = size.width;
    final altoPantalla = size.height;
    final movil = Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;
    // Usar porcentajes para móviles
    final margenExterior = movil ? altoPantalla * 0.061 : anchoPantalla*0.0213;
    final rellenoPanel = movil ? altoPantalla * 0.061 : anchoPantalla*0.0287;
    final maxAnchoPanel = movil ? anchoPantalla * 1.097 : anchoPantalla*0.744;
    final maxAltoPanel = movil ? altoPantalla * 0.9 : anchoPantalla*0.637;
   // ignore: avoid_print
   print("es movil: $movil");
   print("el ancho de la pantalla es: $anchoPantalla");
   print("el alto de la pantalla es: $altoPantalla");

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
        child: Stack(
          children: [
            // Botón de salida para dispositivos de escritorio
            if (Platform.isWindows || Platform.isMacOS || Platform.isLinux)
              Positioned(
                top: 16,
                left: 16,
                child: SafeArea(
                  child: Material(
                    color: Colors.transparent,
                    child: Tooltip(
                      message: 'Salir',
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF6DFF7A),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xAA000000),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            SystemNavigator.pop();
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: movil? margenExterior-2: margenExterior * 2.3,
                    left: movil? margenExterior-2: margenExterior,
                    right: movil? margenExterior-2: margenExterior,
                    bottom: movil? margenExterior-2: margenExterior,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxAnchoPanel,
                      maxHeight: maxAltoPanel,
                    ),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
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
                          width: movil ? 2 : 4,
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
                            // Text(
                            //   'Selecciona tu personaje',
                            //   style: tema.textTheme.headlineMedium?.copyWith(
                            //     color: Colors.white,
                            //     fontWeight: FontWeight.w800,
                            //     fontSize: tamanioTitulo,
                            //   ),
                            //   textAlign: TextAlign.center,
                            // ),
                            // const SizedBox(height: 10),
                            // Text(
                            //   'Elige el estilo de juego que prefieras. Cada personaje tiene su propia forma de atacar y moverse.',
                            //   style: tema.textTheme.bodyMedium?.copyWith(
                            //     color: Colors.white70,
                            //     height: 1.35,
                            //     fontSize: esMovil ? 13.5 : 15,
                            //   ),
                            //   textAlign: TextAlign.center,
                            // ),
                            // SizedBox(height: esMovil ? 16 : 24),
                            SizedBox(
                              width: double.infinity,
                              child: SizedBox(
                                height: movil ? altoPantalla * 0.561 : anchoPantalla*0.319,
                                child: ClipRect(
                                  child: PageView(
                                    controller: _pageController,
                                    onPageChanged: (index) {
                                      setState(() {
                                        _seleccion = index == 0
                                            ? TipoPersonaje.prueba
                                            : TipoPersonaje.pepe;
                                      });
                                    },
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: movil ? altoPantalla*.021 : anchoPantalla*0.008,
                                        ),
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
                                            _seleccionarPersonaje(
                                              TipoPersonaje.prueba,
                                              0,
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: movil ? altoPantalla * 0.021 : anchoPantalla*0.008,
                                        ),
                                        child: TarjetaPersonaje(
                                          titulo: 'Pepe',
                                          subtitulo: 'Cuerpo a cuerpo',
                                          descripcion:
                                              'personaje con ataques de cuerpo a cuerpo con buen nivel de daño y un ataque especial con la probabilidad de generar una onda wifi que daña.',
                                          seleccionada:
                                              _seleccion == TipoPersonaje.pepe,
                                          animacionAssets: const [
                                            'assets/images/Personajes/pepe/quieto/quieto enfrente1.png',
                                            'assets/images/Personajes/pepe/quieto/quieto enfrente2.png',
                                          ],
                                          onTap: () {
                                            _seleccionarPersonaje(
                                              TipoPersonaje.pepe,
                                              1,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: movil ? altoPantalla*.046 : anchoPantalla*0.016),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _IndicadorCarrusel(
                                  activo: _seleccion == TipoPersonaje.prueba,
                                ),
                                const SizedBox(width: 8),
                                _IndicadorCarrusel(
                                  activo: _seleccion == TipoPersonaje.pepe,
                                ),
                              ],
                            ),
                            SizedBox(height: movil ? altoPantalla * 0.021 : anchoPantalla*0.016),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  widget.juego.iniciarConPersonaje(
                                    _seleccion,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6DFF7A),
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.symmetric(
                                    vertical: movil ? altoPantalla*.031 : anchoPantalla*0.011,
                                    horizontal: movil ? altoPantalla*.041 : anchoPantalla*0.011,
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: movil ? altoPantalla*0.041 : anchoPantalla*0.014,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 6,
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
            Positioned(
              top: movil ? altoPantalla*-.825 : anchoPantalla*-0.4353,
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                top: false,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: margenExterior),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F3E22),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: const Color(0xFF6DFF7A),width: movil ? 1.5 : 3),
                      ),
                      child:  Text(
                        'Minibonk',
                        style: TextStyle(
                          fontSize: movil? anchoPantalla*0.02 : anchoPantalla*0.015,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IndicadorCarrusel extends StatelessWidget {
  const _IndicadorCarrusel({required this.activo});

  final bool activo;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: activo ? 18 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: activo ? const Color(0xFF6DFF7A) : Colors.white30,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
