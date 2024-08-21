# Documentación

- [Documentación](#documentacin)
  - [Procs](#procs)

## Instalación

```sh
nimble install "https://github.com/farias-hecdin/HexToAnsi"
```

## Uso

```nim
import pkg/hex2ansi

let fgRed = fg("#ff0000") # Output: "\e[38;5;196m"
let bgRed = bg("#ff0000") # Output: "\e[48;5;196m"
```

## Procs

### `hexToAnsi`

Convierte un color hexadecimal a un código de color ANSI.

Parámetros:
* `hex`: Código de color hexadecimal (por ejemplo, `#FF0000`)
* `mode`: Modo de conversión (`0` foreground y `1` background).

```nim
proc hexToAnsi(hex: string, mode: int): string
```

### `fg` y `bg`

Obtener el color 'Foreground' o 'background' en tiempo de ejecución.

```nim
# Foreground
proc fg(hex: string): string

# Background
proc bg(hex: string): string
```

### `fgx` y `bgx`

Obtener el color 'foreground' o 'background' en tiempo de compilación.

```nim
# Foreground
proc fgx(hex: static string): string

# Background
proc bgx(hex: static string): string
```

