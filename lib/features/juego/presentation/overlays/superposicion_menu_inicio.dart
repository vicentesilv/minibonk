import 'package:flutter/material.dart';
import 'package:minibonk/features/juego/domain/modelos/tipo_personaje.dart';
import 'package:minibonk/features/juego/presentation/juego/juego_mini_bonk.dart';

class SuperposicionMenuInicio extends StatefulWidget {
  const SuperposicionMenuInicio({super.key, required this.juego});

  final JuegoMiniBonk juego;

  @override
  State<SuperposicionMenuInicio> createState() => _SuperposicionMenuInicioState();
}

class _SuperposicionMenuInicioState extends State<SuperposicionMenuInicio> {
  TipoPersonaje? _seleccion;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Material(
      color: const Color(0xCC17351D),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF17351D),
              Color(0xFF2A5B2E),
              Color(0xFF17351D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 920),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xF21A221C),
                        Color(0xF20D140E),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: const Color(0xFF4F8F55), width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xAA000000),
                        blurRadius: 32,
                        offset: Offset(0, 18),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Elige el estilo de juego que prefieras. Cada personaje tiene su propia forma de atacar y moverse.',
                        style: tema.textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                          height: 1.45,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final usarColumna = constraints.maxWidth < 720;
                          return Flex(
                            direction: usarColumna ? Axis.vertical : Axis.horizontal,
                            children: [
                              Expanded(
                                child: _TarjetaPersonaje(
                                  titulo: 'Actual',
                                  subtitulo: 'Distancia',
                                  descripcion: 'Ataque a distancia con proyectiles.',
                                  seleccionada: _seleccion == TipoPersonaje.prueba,
                                  imagenAsset: 'assets/images/personajes/prueba/abajo.png',
                                  onTap: () {
                                    setState(() {
                                      _seleccion = TipoPersonaje.prueba;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: usarColumna ? 0 : 16, height: usarColumna ? 16 : 0),
                              Expanded(
                                child: _TarjetaPersonaje(
                                  titulo: 'Pepe',
                                  subtitulo: 'Cuerpo a cuerpo',
                                  descripcion: 'Animaciones de quieto, mover y ataque con onda wifi especial.',
                                  seleccionada: _seleccion == TipoPersonaje.pepe,
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
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _seleccion == null
                              ? null
                              : () {
                                  widget.juego.iniciarConPersonaje(_seleccion!);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6DFF7A),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            textStyle: const TextStyle(
                              fontSize: 18,
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
    final borde = seleccionada ? const Color(0xFF6DFF7A) : const Color(0xFF3A4A3C);
    final fondo = seleccionada ? const Color(0xFF1E2F21) : const Color(0xFF0F1410);

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
              height: 180,
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
                  ? _PreviewAnim(frames: animacionAssets!)
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
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
              ),
            ),
            const SizedBox(height: 10),
            Text(
              descripcion,
              style: const TextStyle(
                color: Colors.white70,
                height: 1.35,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: seleccionada ? const Color(0xFF2D6B31) : const Color(0xFF26302A),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                seleccionada ? 'Seleccionado' : 'Toca para elegir',
                style: TextStyle(
                  color: seleccionada ? Colors.white : Colors.white70,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
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
