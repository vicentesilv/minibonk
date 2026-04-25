class EstadoUi {
  const EstadoUi({
    this.oleada = 1,
    this.nivel = 1,
    this.xp = 0,
    this.xpSiguiente = 36,
    this.vida = 100,
    this.vidaMaxima = 100,
    this.eliminaciones = 0,
    this.pausadoPorMejora = false,
    this.finDePartida = false,
  });

  final int oleada;
  final int nivel;
  final double xp;
  final double xpSiguiente;
  final double vida;
  final double vidaMaxima;
  final int eliminaciones;
  final bool pausadoPorMejora;
  final bool finDePartida;

  EstadoUi copyWith({
    int? oleada,
    int? nivel,
    double? xp,
    double? xpSiguiente,
    double? vida,
    double? vidaMaxima,
    int? eliminaciones,
    bool? pausadoPorMejora,
    bool? finDePartida,
  }) {
    return EstadoUi(
      oleada: oleada ?? this.oleada,
      nivel: nivel ?? this.nivel,
      xp: xp ?? this.xp,
      xpSiguiente: xpSiguiente ?? this.xpSiguiente,
      vida: vida ?? this.vida,
      vidaMaxima: vidaMaxima ?? this.vidaMaxima,
      eliminaciones: eliminaciones ?? this.eliminaciones,
      pausadoPorMejora: pausadoPorMejora ?? this.pausadoPorMejora,
      finDePartida: finDePartida ?? this.finDePartida,
    );
  }
}
