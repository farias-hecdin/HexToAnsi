# Documentación

- [Documentación](#documentacin)
  - [Instalación](#instalacin)
  - [Uso](#uso)
  - [Procs](#procs)
    - [`hexToAnsi`](#hextoansi)
    - [`fg` y `bg`](#fg-y-bg)
    - [`cfg` y `cbg`](#cfg-y-cbg)

## Instalación

Para instalar esta utilidad, utiliza el siguiente comando:

```sh
nimble install "https://github.com/farias-hecdin/HexToAnsi"
```

## Uso

A continuación se muestra un ejemplo de cómo utilizar `HexToAnsi`:

```nim
import pkg/hex2ansi

let fgRed = fg("#ff0000")  # Output: "\e[38;5;196m"
let bgRed = bg("#ff0000")  # Output: "\e[48;5;196m"
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

```nim
### Other useful additional expressions
proc bold(): string
proc underline(): string
proc emphasis(): string
proc unstyle(): string
```
