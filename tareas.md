# Lista unificada de tareas (guía + ejecución)

Este listado une las tareas funcionales con la guía técnica para implementarlas en el proyecto actual.

## 1) Configurar punto de entrada

- **Descripción:** Inicializar Flutter y arrancar la aplicación principal del juego.
- **Módulo:** App.
- **Archivo:** `lib/main.dart`.
- **Componentes a usar:** `WidgetsFlutterBinding`, `runApp`, `AppMiniBonk`.
- **Funciones/métodos clave:** `main()`, `WidgetsFlutterBinding.ensureInitialized()`.

## 2) Crear contenedor de app

- **Descripción:** Montar `MaterialApp`, `Scaffold` y `GameWidget` con overlays registrados.
- **Módulo:** App.
- **Archivo:** `lib/src/app/app_mini_bonk.dart`.
- **Componentes a usar:** `MaterialApp`, `Scaffold`, `GameWidget`, `overlayBuilderMap`.
- **Funciones/métodos clave:** `build(BuildContext)`, constructor de `JuegoMiniBonk`.

## 3) Definir estado de UI

- **Descripción:** Modelar vida, XP, oleada, nivel, kills, pausa y game over.
- **Módulo:** Game Models.
- **Archivo:** `lib/src/game/models/estado_ui.dart`.
- **Componentes a usar:** clase inmutable `EstadoUi`.
- **Funciones/métodos clave:** `const EstadoUi(...)`, `copyWith(...)`.

## 4) Definir catálogo de mejoras

- **Descripción:** Declarar mejoras y textos para su visualización en UI.
- **Módulo:** Game Models.
- **Archivo:** `lib/src/game/models/tipo_mejora.dart`.
- **Componentes a usar:** `enum TipoMejora`, extensión `TextosMejora`.
- **Funciones/métodos clave:** getters `titulo`, `descripcion`.

## 5) Implementar núcleo del juego

- **Descripción:** Crear loop principal, temporizadores y progresión de oleadas.
- **Módulo:** Game Core.
- **Archivo:** `lib/src/game/juego_mini_bonk.dart`.
- **Componentes a usar:** `FlameGame`, `HasCollisionDetection`, `KeyboardEvents`, `ValueNotifier<EstadoUi>`.
- **Funciones/métodos clave:** `onLoad()`, `update(double dt)`, `onGameResize(...)`, `_actualizarUi()`.

## 6) Implementar entrada de movimiento

- **Descripción:** Soportar WASD/flechas y joystick en una sola dirección final.
- **Módulo:** Game Core.
- **Archivo:** `lib/src/game/juego_mini_bonk.dart`.
- **Componentes a usar:** `JoystickComponent`, `LogicalKeyboardKey`, `Vector2`.
- **Funciones/métodos clave:** `onKeyEvent(...)`, getter `entradaMovimiento`, `normalize()`.

## 7) Implementar sistema de spawn

- **Descripción:** Crear enemigos desde bordes con escalado por oleada.
- **Módulo:** Game Core.
- **Archivo:** `lib/src/game/juego_mini_bonk.dart`.
- **Componentes a usar:** `Random`, `Enemigo`.
- **Funciones/métodos clave:** `_crearEnemigo()`, control de `_temporizadorAparicion`, ajuste de `_intervaloAparicion`.

## 8) Implementar jugador

- **Descripción:** Movimiento, límites del mapa y atributos base/reinicio.
- **Módulo:** Game Components.
- **Archivo:** `lib/src/game/components/entidades.dart`.
- **Componentes a usar:** `Jugador extends CircleComponent`, `CircleHitbox`.
- **Funciones/métodos clave:** `onLoad()`, `update(dt)`, `reiniciarAtributos()`.

## 9) Implementar auto-disparo

- **Descripción:** Disparar automáticamente al enemigo más cercano y soportar multi-disparo.
- **Módulo:** Game Components.
- **Archivo:** `lib/src/game/components/entidades.dart`.
- **Componentes a usar:** `Jugador`, `Bala`, `Vector2`.
- **Funciones/métodos clave:** `_dispararAlMasCercano()`, `obtenerEnemigoMasCercano(...)`, `crearBala(...)`.

## 10) Implementar enemigos

- **Descripción:** Persecución al jugador, contacto con daño y muerte por impacto.
- **Módulo:** Game Components.
- **Archivo:** `lib/src/game/components/entidades.dart`.
- **Componentes a usar:** `Enemigo`, `CollisionCallbacks`.
- **Funciones/métodos clave:** `update(dt)`, `recibirImpacto(...)`, `onCollision(...)`.

## 11) Implementar balas y daño

- **Descripción:** Mover balas, expirar por tiempo/salida y dañar enemigos al colisionar.
- **Módulo:** Game Components.
- **Archivo:** `lib/src/game/components/entidades.dart`.
- **Componentes a usar:** `Bala`, `Enemigo`.
- **Funciones/métodos clave:** `update(dt)`, `onCollision(...)`.

## 12) Implementar orbes de XP

- **Descripción:** Soltar XP en muertes y recolectarla con colisión del jugador.
- **Módulo:** Game Components.
- **Archivo:** `lib/src/game/components/entidades.dart`.
- **Componentes a usar:** `OrbeXp`, `Jugador`.
- **Funciones/métodos clave:** `onCollision(...)`, `crearOrbeXp(...)`, `agregarXp(...)`.

## 13) Implementar subida de nivel

- **Descripción:** Subir nivel al superar XP objetivo y abrir selección de mejoras.
- **Módulo:** Game Core.
- **Archivo:** `lib/src/game/juego_mini_bonk.dart`.
- **Componentes a usar:** estado de progreso (`xp`, `xpSiguiente`, `nivel`), overlay `Upgrade`.
- **Funciones/métodos clave:** `agregarXp(...)`, `_mostrarOpcionesMejora()`, `pauseEngine()`, `overlays.add('Upgrade')`.

## 14) Aplicar mejoras al jugador

- **Descripción:** Modificar stats del jugador según mejora elegida y reanudar partida.
- **Módulo:** Game Core.
- **Archivo:** `lib/src/game/juego_mini_bonk.dart`.
- **Componentes a usar:** `TipoMejora`, `jugador`.
- **Funciones/métodos clave:** `aplicarMejora(...)`, `resumeEngine()`, `overlays.remove('Upgrade')`.

## 15) Crear HUD de partida

- **Descripción:** Mostrar estado de partida (HP/XP/oleada/nivel/kills) y game over.
- **Módulo:** UI Overlays.
- **Archivo:** `lib/src/ui/overlays/superposicion_hud.dart`.
- **Componentes a usar:** `SuperposicionHud`, `ValueListenableBuilder<EstadoUi>`, `LinearProgressIndicator`.
- **Funciones/métodos clave:** `build(BuildContext)`, cálculo de porcentajes, `juego.reiniciarJuego`.

## 16) Crear overlay de mejoras

- **Descripción:** Presentar opciones al subir nivel y aplicar la seleccionada.
- **Módulo:** UI Overlays.
- **Archivo:** `lib/src/ui/overlays/superposicion_mejora.dart`.
- **Componentes a usar:** `SuperposicionMejora`, `FilledButton.tonal`, `Card`, `Column`.
- **Funciones/métodos clave:** `build(BuildContext)`, `juego.opcionesActualesDeMejora.map(...)`, `juego.aplicarMejora(...)`.

## 17) Sincronizar estado y UI

- **Descripción:** Reflejar en HUD todos los cambios del juego en tiempo real.
- **Módulo:** Game Core + UI.
- **Archivo:** `lib/src/game/juego_mini_bonk.dart`.
- **Componentes a usar:** `ValueNotifier<EstadoUi>`.
- **Funciones/métodos clave:** `_actualizarUi()` llamado desde `alEliminarEnemigo()`, `recibirDanioJugador()`, `agregarXp()`, `reiniciarJuego()`.

## 18) Modularizar arquitectura

- **Descripción:** Mantener separación clara por dominios y evitar archivos monolíticos.
- **Módulo:** Arquitectura.
- **Archivo:** `lib/main.dart` + `lib/src/`.
- **Componentes a usar:** carpetas `app`, `game`, `ui`, imports explícitos.
- **Funciones/métodos clave:** migrar clases por responsabilidad, eliminar `part/part of`, actualizar imports.

## Orden recomendado de ejecución

1. Tareas 1 a 4.
2. Tareas 5 a 8.
3. Tareas 9 a 12.
4. Tareas 13 a 17.
5. Tarea 18.

## Checklist rápido

- [ ] Completar tareas 1–4 (base del proyecto).
- [ ] Completar tareas 5–12 (gameplay funcional).
- [ ] Completar tareas 13–17 (progresión + UI reactiva).
- [ ] Completar tarea 18 (arquitectura final).
