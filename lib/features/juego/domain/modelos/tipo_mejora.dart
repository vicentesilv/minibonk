enum TipoMejora {
  fuegoRapido,
  masDanio,
  velocidadMovimiento,
  vidaMaxima,
  velocidadProyectil,
  multiDisparo,
}

extension TextosMejora on TipoMejora {
  String get titulo => switch (this) {
        TipoMejora.fuegoRapido => 'Ritmo de fuego',
        TipoMejora.masDanio => 'Más daño',
        TipoMejora.velocidadMovimiento => 'Velocidad',
        TipoMejora.vidaMaxima => 'Vida máxima',
        TipoMejora.velocidadProyectil => 'Velocidad de proyectil',
        TipoMejora.multiDisparo => 'Disparo múltiple',
      };

  String get descripcion => switch (this) {
        TipoMejora.fuegoRapido => '-18% tiempo entre disparos',
        TipoMejora.masDanio => '+4 daño por disparo',
        TipoMejora.velocidadMovimiento => '+20 velocidad de movimiento',
        TipoMejora.vidaMaxima => '+20 vida máxima y cura +20',
        TipoMejora.velocidadProyectil => '+45 velocidad del proyectil',
        TipoMejora.multiDisparo => '+1 proyectil por disparo',
      };
}