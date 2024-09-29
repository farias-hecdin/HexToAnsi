import strutils, strformat

### Convertir color hex a RGB
proc hexToRgb(hexColor: string): tuple[r, g, b: int] =
  var hexColor = hexColor.replace("#", "")
  let r = hexColor[0..1].parseHexInt
  let g = hexColor[2..3].parseHexInt
  let b = hexColor[4..5].parseHexInt
  result = (r: r, g: g, b: b)

### Convertir RGB al código ANSI 256 más cercano
proc rgbToAnsi256(r, g, b: int): int =
  # Verificar si es mejor aproximación en escala de grises
  if r == g and g == b:
    if r < 8: return 16
    elif r > 248: return 231
    else:
      let grayIndex = (r - 8) * 24 div 247
      return 232 + grayIndex
  else:
    # Mapear valores RGB a rango 0..5
    let ri = r * 5 div 255
    let gi = g * 5 div 255
    let bi = b * 5 div 255
    return 16 + 36 * ri + 6 * gi + bi

### Convertir color hex a código ANSI escape
proc hexToAnsi(hex: string, mode: int): string =
  let (r, g, b) = hexToRgb(hex)
  let ansiCode = rgbToAnsi256(r, g, b)
  result = if mode != 1:
    &"\e[38;5;{ansiCode}m" # Establecer color de primer plano
  else:
    &"\e[48;5;{ansiCode}m" # Establecer color de fondo

### Funciones para primer plano y fondo
proc fg(hex: string): string = hexToAnsi(hex, 0)
proc bg(hex: string): string = hexToAnsi(hex, 1)

### Funciones en tiempo de compilación
proc cfg(hex: string): string {.compileTime.} = hexToAnsi(hex, 0)
proc cbg(hex: string): string {.compileTime.} = hexToAnsi(hex, 1)

### Otros estilos útiles
proc bold(): string = "\e[1m"
proc underline(): string = "\e[4m"
proc emphasis(): string = bold() & underline()
proc unstyle(): string = "\e[0m"

### Ejemplo de uso:
# let hexColor = "#FFFF00"
# echo fg(hexColor) & "¡Hola mundo!" & unstyle()

export hexToAnsi, fg, bg, cfg, cbg, bold, underline, unstyle, emphasis
