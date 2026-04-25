# minibonk

Guía de desarrollo del proyecto miniBonk, un juego hecho con Flutter y Flame.

## Objetivo

Este proyecto implementa un survival de acción con:

- movimiento con teclado o joystick táctil adaptandose a la plataforma de juego
- auto-disparo hacia el enemigo más cercano con probabilidad de fallo
- oleadas crecientes de enemigos
- experiencia y subida de nivel
- sistema de mejoras temporales al subir de nivel
- HUD con vida, XP, oleada, nivel y eliminaciones

## Stack principal

- Flutter
- Flame
- Dart 3.10+

## Estructura del proyecto

- [lib/main.dart](lib/main.dart): punto de entrada de la app
- [lib/src/app/app_mini_bonk.dart](lib/src/app/app_mini_bonk.dart): montaje de la aplicación y de las superposiciones
- [lib/src/game/juego_mini_bonk.dart](lib/src/game/juego_mini_bonk.dart): lógica principal del juego
- [lib/src/game/components/entidades.dart](lib/src/game/components/entidades.dart): jugador, enemigos, balas y orbes de XP
- [lib/src/game/models/estado_ui.dart](lib/src/game/models/estado_ui.dart): estado expuesto al HUD
- [lib/src/game/models/tipo_mejora.dart](lib/src/game/models/tipo_mejora.dart): catálogo de mejoras disponibles
- [lib/src/ui/overlays/superposicion_hud.dart](lib/src/ui/overlays/superposicion_hud.dart): interfaz del HUD con vida, XP, oleada, nivel y eliminaciones
- [lib/src/ui/overlays/superposicion_mejora.dart](lib/src/ui/overlays/superposicion_mejora.dart): selector de mejoras

## Cómo ejecutar el proyecto

### Requisitos

- Flutter instalado y configurado
- Dependencias del proyecto descargadas con `flutter pub get`

### Arranque en desarrollo

- Ejecutar la app con `flutter run`
- En escritorio, el juego abre en una ventana Flutter
- En móvil, usa el joystick táctil o el teclado virtual según la plataforma

## Flujo de juego

1. El juego crea al jugador, el fondo y el joystick al cargar.
2. El jugador se mueve con WASD, flechas o joystick.
3. El auto-disparo apunta al enemigo más cercano.
4. Los enemigos aparecen por tiempo y persiguen al jugador.
5. Al eliminar enemigos, sueltan orbes de XP.
6. Al alcanzar XP suficiente, sube el nivel y se pausa el juego para elegir una mejora.
7. Si la vida del jugador llega a 0, aparece Game Over.

## Sistema de mejoras

Las mejoras disponibles están definidas en [lib/src/game/models/tipo_mejora.dart](lib/src/game/models/tipo_mejora.dart):

- ritmo de fuego
- más daño
- velocidad de movimiento
- vida máxima
- velocidad de proyectil
- multi-disparo

Cada vez que se sube de nivel:

- se seleccionan 3 mejoras aleatorias
- el juego se pausa
- al elegir una mejora, el juego continúa

## Puntos de extensión recomendados

### Añadir una nueva mejora

1. Agregar el nuevo valor en [lib/src/game/models/tipo_mejora.dart](lib/src/game/models/tipo_mejora.dart).
2. Definir su título y descripción en la extensión `TextosMejora`.
3. Implementar su efecto en `aplicarMejora()` dentro de [lib/src/game/juego_mini_bonk.dart](lib/src/game/juego_mini_bonk.dart).

### Añadir una nueva entidad

1. Crear la clase en [lib/src/game/components/entidades.dart](lib/src/game/components/entidades.dart) o en un archivo nuevo dentro de `lib/src/game/components/`.
2. Integrar su creación desde [lib/src/game/juego_mini_bonk.dart](lib/src/game/juego_mini_bonk.dart).
3. Exponer su estado en `EstadoUi` solo si la interfaz lo necesita.

### Cambiar la interfaz

- El HUD vive en [lib/src/ui/overlays/superposicion_hud.dart](lib/src/ui/overlays/superposicion_hud.dart)
- La pantalla de mejoras vive en [lib/src/ui/overlays/superposicion_mejora.dart](lib/src/ui/overlays/superposicion_mejora.dart)
- Las superposiciones se registran en [lib/src/app/app_mini_bonk.dart](lib/src/app/app_mini_bonk.dart)

## Convenciones de desarrollo

- Mantener la lógica del juego en `JuegoMiniBonk`
- Mantener las entidades con responsabilidad única
- Usar `ValueNotifier<EstadoUi>` para datos visibles en UI
- Evitar mezclar lógica de renderizado con lógica de reglas
- Priorizar cambios pequeños y verificables

## Buenas prácticas para trabajar en este código

- Probar el juego después de cualquier cambio en movimiento, colisiones o mejoras
- Revisar que el HUD siga reflejando el estado real
- Confirmar que reinicio, pausa y Game Over no dejen componentes huérfanos
- Validar que las nuevas entidades respeten los límites de pantalla y las colisiones

## Estado actual

El proyecto ya incluye:

- jugador con auto-disparo
- enemigos con persecución
- balas con colisión
- orbes de XP
- subida de nivel con selección de mejoras
- HUD y pantalla de Game Over

## Próximos pasos sugeridos

- ajustar balance de daño, vida y velocidad
- añadir más tipos de enemigos
- incorporar efectos visuales y sonido
- guardar progreso o puntuación máxima
- agregar pruebas de comportamiento para la lógica del juego
