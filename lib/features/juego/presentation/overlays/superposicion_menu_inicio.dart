import 'package:flutter/material.dart';
import 'package:minibonk/features/juego/domain/modelos/tipo_personaje.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';

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
                                  child: _TarjetaPersonaje(
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
                                  child: _TarjetaPersonaje(
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

class _TarjetaPersonaje extends StatelessWidget {
  const _TarjetaPersonaje({
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
    final borde = seleccionada
        ? const Color(0xFF6DFF7A)
        : const Color(0xFF3A4A3C);
    final fondo = seleccionada
        ? const Color(0xFF1E2F21)
        : const Color(0xFF0F1410);
    final size = MediaQuery.sizeOf(context);
    final anchoPantalla = size.width;
    final altoPantalla = size.height;
    final esMovil = anchoPantalla < 600;
    // Usar porcentajes para tamaños
    final altoImagen = esMovil ? altoPantalla * 0.15 : altoPantalla * 0.22;
    final tamanioTitulo = esMovil
        ? (altoPantalla * 0.022).clamp(13.0, 18.0)
        : (altoPantalla * 0.025).clamp(15.0, 22.0);
    final tamanioSubtitulo = esMovil
        ? (altoPantalla * 0.016).clamp(11.0, 15.0)
        : (altoPantalla * 0.018).clamp(12.0, 16.0);
    final tamanioDescripcion = esMovil
        ? (altoPantalla * 0.015).clamp(10.0, 14.0)
        : (altoPantalla * 0.017).clamp(11.0, 15.0);
    final tamanioEstado = esMovil
        ? (altoPantalla * 0.015).clamp(10.0, 14.0)
        : (altoPantalla * 0.017).clamp(11.0, 15.0);
    final paddingGeneral = esMovil ? altoPantalla * 0.018 : 18.0;
    final paddingImagen = esMovil ? altoPantalla * 0.012 : 12.0;
    final separacionVertical = esMovil ? altoPantalla * 0.018 : 16.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 4),
        padding: EdgeInsets.all(paddingGeneral),
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
        child: SingleChildScrollView(
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
                      seleccionada
                          ? const Color(0xFF18361D)
                          : const Color(0xFF0F1511),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: borde),
                ),
                padding: EdgeInsets.all(paddingImagen),
                child: animacionAssets != null
                    ? _PreviewAnim(frames: animacionAssets!)
                    : Image.asset(
                        imagenAsset ?? '',
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.none,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.person,
                              size: altoImagen * 0.65,
                              color: Colors.white54,
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(height: separacionVertical),
              Text(
                titulo,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: tamanioTitulo,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: separacionVertical * 0.25),
              Text(
                subtitulo,
                style: TextStyle(
                  color: seleccionada
                      ? const Color(0xFF8CFF93)
                      : Colors.white60,
                  fontWeight: FontWeight.w600,
                  fontSize: tamanioSubtitulo,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: separacionVertical * 0.2),
              Text(
                descripcion,
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.25,
                  fontSize: tamanioDescripcion,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: separacionVertical * 0.5),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(
                  horizontal: paddingGeneral * 0.7,
                  vertical: paddingGeneral * 0.4,
                ),
                decoration: BoxDecoration(
                  color: seleccionada
                      ? const Color(0xFF2D6B31)
                      : const Color(0xFF26302A),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  seleccionada ? 'Seleccionado' : 'Toca para elegir',
                  style: TextStyle(
                    color: seleccionada ? Colors.white : Colors.white70,
                    fontWeight: FontWeight.w700,
                    fontSize: tamanioEstado,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewAnim extends StatefulWidget {
  const _PreviewAnim({required this.frames});

  final List<String> frames;

  @override
  State<_PreviewAnim> createState() => _PreviewAnimState();
}

class _PreviewAnimState extends State<_PreviewAnim> {
  int _frame = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || widget.frames.length <= 1) {
        return;
      }
      _tick();
    });
  }

  Future<void> _tick() async {
    while (mounted) {
      await Future<void>.delayed(const Duration(milliseconds: 350));
      if (!mounted) return;
      setState(() {
        _frame = (_frame + 1) % widget.frames.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.frames[_frame],
      fit: BoxFit.contain,
      filterQuality: FilterQuality.none,
      gaplessPlayback: true,
    );
  }
}
