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
    final esMovil = anchoPantalla < 600;
    // Usar porcentajes para móviles
    final margenExterior = esMovil ? altoPantalla * 0.015 : 24.0;
    final rellenoPanel = esMovil ? altoPantalla * 0.02 : 24.0;
    final maxAnchoPanel = esMovil ? anchoPantalla * 0.95 : 920.0;
    final maxAltoPanel = esMovil ? altoPantalla * 0.9 : altoPantalla * 0.9;
    

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
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  // padding: EdgeInsets.only(
                  //   top: margenExterior * 2.3,
                  //   left: margenExterior,
                  //   right: margenExterior,
                  //   bottom: margenExterior,
                  // ),
                  padding: EdgeInsets.all(margenExterior-2),
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
                                height: esMovil ? altoPantalla * 0.22 : 220,
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
                                          horizontal: esMovil ? 2 : 8,
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
                                          horizontal: esMovil ? 2 : 8,
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
                            SizedBox(height: esMovil ? 12 : 18),
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
                            SizedBox(height: esMovil ? 5 : 14),
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
                                    vertical: esMovil ? 10 : 12,
                                    horizontal: esMovil ? 12 : 16,
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: esMovil ? 14 : 16,
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
              top: -325,
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
                        border: Border.all(color: const Color(0xFF6DFF7A)),
                      ),
                      child: const Text(
                        'Minibonk',
                        style: TextStyle(
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
