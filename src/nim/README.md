# Documentación

- [Documentación](#documentacin)
  - [Procs](#procs)

## Instalación

```nim
nimble install https://github.com/farias-hecdin/HexToAnsi
```

## Procs

```nim
#-- Convert hex color to ANSI color
proc hexToAnsi(hex: string, mode: int): string

#-- Foreground and background
proc fg(hex: string): string
proc bg(hex: string): string

#-- Foreground and background in compTime
proc fgx(hex: static string): string
proc bgx(hex: static string): string
```

