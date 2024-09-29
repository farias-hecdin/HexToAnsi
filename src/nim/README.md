<!-- toc omit heading -->
# Documentación

Esta es una implementacion de `HexToAnsi` para nim que convierte los colores en formato hexadecimal a códigos de color ANSI.

- [Instalación](#instalacin)
- [Uso](#uso)
- [Procs](#procs)
  - [`hexToAnsi`](#hextoansi)
  - [`fg` y `bg`](#fg-y-bg)
  - [`cfg` y `cbg`](#cfg-y-cbg)
  - [Otras expresiones utiles](#otras-expresiones-utiles)

## Instalación

Para instalar **HexToAnsi**, utiliza el siguiente comando:

```sh
nimble install "https://github.com/farias-hecdin/HexToAnsi"
```

## Uso

A continuación se muestra un ejemplo de cómo utilizar `HexToAnsi`:

```nim
import pkg/hex2ansi

let fgRojo = fg("#ff0000")  # Output: "\e[38;5;196m"
let bgRojo = bg("#ff0000")  # Output: "\e[48;5;196m"

echo fgRojo & "Este texto es de color rojo" & unstyle()
echo bgRojo & "Este texto tiene fondo rojo" & unstyle()
```

## Procs

### `hexToAnsi`

Convierte un color hexadecimal a un código de color ANSI.

**Parámetros:**
* `hex`: Código de color hexadecimal (por ejemplo, `#FF0000`)
* `mode`: Modo de conversión (`0` para foreground y `1` para background).

```nim
proc hexToAnsi(hex: string, mode: int): string
```

### `fg` y `bg`

Obtener el color 'Foreground' o 'background' en tiempo de ejecución.

**Parámetros:**
* `hex`: Código de color hexadecimal (por ejemplo, `#FF0000`)

```nim
# Foreground
proc fg(hex: string): string

# Background
proc bg(hex: string): string
```

### `cfg` y `cbg`

Obtener el color 'foreground' o 'background' en tiempo de compilación.

**Parámetros:**
* `hex`: Código de color hexadecimal (por ejemplo, `#FF0000`)

```nim
# Foreground
proc cfg(hex: static string): string

# Background
proc cbg(hex: static string): string
```

### Otras expresiones utiles

Estos funciones adicionales permiten aplicar estilos de texto comunes:

```nim
# Apply bold
proc bold(): string

# Apply underline
proc underline(): string

# Apply emphasis (combines bold and underline)
proc emphasis(): string

# Remove all styles
proc unstyle(): string
```
