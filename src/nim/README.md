# Documentación

- [Documentación](#documentacin)
  - [Procs](#procs)

## Instalación

```sh
nimble install "https://github.com/farias-hecdin/HexToAnsi"
```

## Procs

Convierte un color hexadecimal a un código de color ANSI.

Parámetros:
* `hex`: Código de color hexadecimal (por ejemplo, `#FF0000`)
* `mode`: Modo de conversión (`0` foreground y `1` background).

```nim
proc hexToAnsi(hex: string, mode: int): string
```

Obtener el color 'Foreground' o 'background' en tiempo de ejecución.

```nim
# Foreground
proc fg(hex: string): string

# Background
proc bg(hex: string): string
```

Obtener el color 'foreground' o 'background' en tiempo de compilación.

```nim
# Foreground
proc fgx(hex: static string): string

# Background
proc bgx(hex: static string): string
```

