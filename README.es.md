# Debloat Android (Español)

Este repositorio proporciona una habilidad especializada para agentes de IA (como OpenCode y Claude) para eliminar el bloatware de teléfonos y tabletas Android mediante ADB (Android Debug Bridge). Elimina aplicaciones preinstaladas innecesarias, incluyendo aplicaciones de Google y aplicaciones específicas de la marca, asegurando que el dispositivo siga siendo funcional.

## 🤖 Instrucciones para el Agente

Cuando se cargue este repositorio como una habilidad, el agente deberá:
1. **Verificar ADB**: Comprobar si `adb` está disponible en el entorno.
2. **Conectar Dispositivo**: Usar `./tools/debloat.sh` con el ID del dispositivo o IP proporcionados.
3. **Verificación de Seguridad**: Informar al usuario que Google Play Store y el Lanzador activo están protegidos y no serán eliminados.
4. **Ejecución**: Ejecutar el script de debloat e informar el resultado.

## 🚀 Características

- **Eliminación Exhaustiva**: Se enfoca en todos los paquetes instalados excepto los componentes críticos del sistema.
- **Seguridad Primero**: 
  - **Protege Google Play Store**: Asegura que aún se puedan instalar y actualizar aplicaciones.
  - **Protege el Lanzador Predeterminado**: Detecta dinámicamente y protege el lanzador activo para evitar que el dispositivo quede inutilizable (brick).
- **Mecanismo de Respaldo**: Si un paquete no puede desinstalarse completamente, la herramienta intenta desactivarlo.
- **Integración ADB**: Funciona a través de USB o Wi-Fi.

## 🛠️ Requisitos Previos

1. **ADB Instalado**: Asegúrese de tener `adb` instalado en su computadora.
2. **Depuración USB Activada**: 
   - Vaya a `Ajustes` $\rightarrow$ `Acerca del teléfono` $\rightarrow$ Pulse `Número de compilación` 7 veces.
   - Vaya a `Ajustes` $\rightarrow$ `Sistema` $\rightarrow$ `Opciones de desarrollador` $\rightarrow$ Active `Depuración USB`.
3. **Dispositivo Conectado**: Conecte su teléfono a la computadora mediante USB o Wi-Fi.

## 📖 Uso

### Para Agentes de IA
El agente puede ejecutar simplemente:
```bash
chmod +x tools/debloat.sh
./tools/debloat.sh [id_dispositivo/ip]
```

### Uso Manual
Si lo ejecuta manualmente:
```bash
chmod +x tools/debloat.sh
./tools/debloat.sh <su_id_o_ip_de_dispositivo>
```

### Restaurar aplicaciones
Si eliminó accidentalmente algo importante, puede reinstalarlo usando el siguiente comando ADB:
```bash
adb shell cmd package install-existing <nombre_del_paquete>
```

## 📂 Estructura del Proyecto

- `tools/`: Contiene los scripts principales de debloat y restauración.
  - `debloat.sh`: El script principal para eliminar bloatware.
  - `restore.sh`: Script de utilidad para guía de restauración.
- `AGENTS.md`: Guía específica para agentes de IA que operan en este repositorio.

## ⚠️ Descargo de Responsabilidad

**Use esta herramienta bajo su propio riesgo.** Aunque tomamos precauciones para proteger el lanzador y la Play Store, eliminar aplicaciones del sistema puede provocar comportamientos inesperados. Asegúrese siempre de tener una copia de seguridad de sus datos importantes.
