import strutils, math, strformat

### Convert hex color to RGB
proc hexToRgb(hexColor: string): tuple[r, g, b: int] =
  var hexColor = hexColor.replace("#", "")
  result = (
    r: hexColor[0..1].parseHexInt,
    g: hexColor[2..3].parseHexInt,
    b: hexColor[4..5].parseHexInt
  )

### Calculate the squared distance between two RGB colors
proc distance(r1, g1, b1, r2, g2, b2: int): int =
  (r1 - r2)^2 + (g1 - g2)^2 + (b1 - b2)^2

### Convert RGB to the closest ANSI 256 color
proc rgbToAnsi(r, g, b: int): int =
  # ANSI color cube definition (6x6x6)
  let ansiColors = @[
    (0x00, 0x00, 0x00), (0x00, 0x00, 0x5f), (0x00, 0x00, 0x87), (0x00, 0x00, 0xaf), (0x00, 0x00, 0xd7), (0x00, 0x00, 0xff),
    (0x00, 0x5f, 0x00), (0x00, 0x5f, 0x5f), (0x00, 0x5f, 0x87), (0x00, 0x5f, 0xaf), (0x00, 0x5f, 0xd7), (0x00, 0x5f, 0xff),
    (0x00, 0x87, 0x00), (0x00, 0x87, 0x5f), (0x00, 0x87, 0x87), (0x00, 0x87, 0xaf), (0x00, 0x87, 0xd7), (0x00, 0x87, 0xff),
    (0x00, 0xaf, 0x00), (0x00, 0xaf, 0x5f), (0x00, 0xaf, 0x87), (0x00, 0xaf, 0xaf), (0x00, 0xaf, 0xd7), (0x00, 0xaf, 0xff),
    (0x00, 0xd7, 0x00), (0x00, 0xd7, 0x5f), (0x00, 0xd7, 0x87), (0x00, 0xd7, 0xaf), (0x00, 0xd7, 0xd7), (0x00, 0xd7, 0xff),
    (0x00, 0xff, 0x00), (0x00, 0xff, 0x5f), (0x00, 0xff, 0x87), (0x00, 0xff, 0xaf), (0x00, 0xff, 0xd7), (0x00, 0xff, 0xff),
    (0x5f, 0x00, 0x00), (0x5f, 0x00, 0x5f), (0x5f, 0x00, 0x87), (0x5f, 0x00, 0xaf), (0x5f, 0x00, 0xd7), (0x5f, 0x00, 0xff),
    (0x5f, 0x5f, 0x00), (0x5f, 0x5f, 0x5f), (0x5f, 0x5f, 0x87), (0x5f, 0x5f, 0xaf), (0x5f, 0x5f, 0xd7), (0x5f, 0x5f, 0xff),
    (0x5f, 0x87, 0x00), (0x5f, 0x87, 0x5f), (0x5f, 0x87, 0x87), (0x5f, 0x87, 0xaf), (0x5f, 0x87, 0xd7), (0x5f, 0x87, 0xff),
    (0x5f, 0xaf, 0x00), (0x5f, 0xaf, 0x5f), (0x5f, 0xaf, 0x87), (0x5f, 0xaf, 0xaf), (0x5f, 0xaf, 0xd7), (0x5f, 0xaf, 0xff),
    (0x5f, 0xd7, 0x00), (0x5f, 0xd7, 0x5f), (0x5f, 0xd7, 0x87), (0x5f, 0xd7, 0xaf), (0x5f, 0xd7, 0xd7), (0x5f, 0xd7, 0xff),
    (0x5f, 0xff, 0x00), (0x5f, 0xff, 0x5f), (0x5f, 0xff, 0x87), (0x5f, 0xff, 0xaf), (0x5f, 0xff, 0xd7), (0x5f, 0xff, 0xff),
    (0x87, 0x00, 0x00), (0x87, 0x00, 0x5f), (0x87, 0x00, 0x87), (0x87, 0x00, 0xaf), (0x87, 0x00, 0xd7), (0x87, 0x00, 0xff),
    (0x87, 0x5f, 0x00), (0x87, 0x5f, 0x5f), (0x87, 0x5f, 0x87), (0x87, 0x5f, 0xaf), (0x87, 0x5f, 0xd7), (0x87, 0x5f, 0xff),
    (0x87, 0x87, 0x00), (0x87, 0x87, 0x5f), (0x87, 0x87, 0x87), (0x87, 0x87, 0xaf), (0x87, 0x87, 0xd7), (0x87, 0x87, 0xff),
    (0x87, 0xaf, 0x00), (0x87, 0xaf, 0x5f), (0x87, 0xaf, 0x87), (0x87, 0xaf, 0xaf), (0x87, 0xaf, 0xd7), (0x87, 0xaf, 0xff),
    (0x87, 0xd7, 0x00), (0x87, 0xd7, 0x5f), (0x87, 0xd7, 0x87), (0x87, 0xd7, 0xaf), (0x87, 0xd7, 0xd7), (0x87, 0xd7, 0xff),
    (0x87, 0xff, 0x00), (0x87, 0xff, 0x5f), (0x87, 0xff, 0x87), (0x87, 0xff, 0xaf), (0x87, 0xff, 0xd7), (0x87, 0xff, 0xff),
    (0xaf, 0x00, 0x00), (0xaf, 0x00, 0x5f), (0xaf, 0x00, 0x87), (0xaf, 0x00, 0xaf), (0xaf, 0x00, 0xd7), (0xaf, 0x00, 0xff),
    (0xaf, 0x5f, 0x00), (0xaf, 0x5f, 0x5f), (0xaf, 0x5f, 0x87), (0xaf, 0x5f, 0xaf), (0xaf, 0x5f, 0xd7), (0xaf, 0x5f, 0xff),
    (0xaf, 0x87, 0x00), (0xaf, 0x87, 0x5f), (0xaf, 0x87, 0x87), (0xaf, 0x87, 0xaf), (0xaf, 0x87, 0xd7), (0xaf, 0x87, 0xff),
    (0xaf, 0xaf, 0x00), (0xaf, 0xaf, 0x5f), (0xaf, 0xaf, 0x87), (0xaf, 0xaf, 0xaf), (0xaf, 0xaf, 0xd7), (0xaf, 0xaf, 0xff),
    (0xaf, 0xd7, 0x00), (0xaf, 0xd7, 0x5f), (0xaf, 0xd7, 0x87), (0xaf, 0xd7, 0xaf), (0xaf, 0xd7, 0xd7), (0xaf, 0xd7, 0xff),
    (0xaf, 0xff, 0x00), (0xaf, 0xff, 0x5f), (0xaf, 0xff, 0x87), (0xaf, 0xff, 0xaf), (0xaf, 0xff, 0xd7), (0xaf, 0xff, 0xff),
    (0xd7, 0x00, 0x00), (0xd7, 0x00, 0x5f), (0xd7, 0x00, 0x87), (0xd7, 0x00, 0xaf), (0xd7, 0x00, 0xd7), (0xd7, 0x00, 0xff),
    (0xd7, 0x5f, 0x00), (0xd7, 0x5f, 0x5f), (0xd7, 0x5f, 0x87), (0xd7, 0x5f, 0xaf), (0xd7, 0x5f, 0xd7), (0xd7, 0x5f, 0xff),
    (0xd7, 0x87, 0x00), (0xd7, 0x87, 0x5f), (0xd7, 0x87, 0x87), (0xd7, 0x87, 0xaf), (0xd7, 0x87, 0xd7), (0xd7, 0x87, 0xff),
    (0xd7, 0xaf, 0x00), (0xd7, 0xaf, 0x5f), (0xd7, 0xaf, 0x87), (0xd7, 0xaf, 0xaf), (0xd7, 0xaf, 0xd7), (0xd7, 0xaf, 0xff),
    (0xd7, 0xd7, 0x00), (0xd7, 0xd7, 0x5f), (0xd7, 0xd7, 0x87), (0xd7, 0xd7, 0xaf), (0xd7, 0xd7, 0xd7), (0xd7, 0xd7, 0xff),
    (0xd7, 0xff, 0x00), (0xd7, 0xff, 0x5f), (0xd7, 0xff, 0x87), (0xd7, 0xff, 0xaf), (0xd7, 0xff, 0xd7), (0xd7, 0xff, 0xff),
    (0xff, 0x00, 0x00), (0xff, 0x00, 0x5f), (0xff, 0x00, 0x87), (0xff, 0x00, 0xaf), (0xff, 0x00, 0xd7), (0xff, 0x00, 0xff),
    (0xff, 0x5f, 0x00), (0xff, 0x5f, 0x5f), (0xff, 0x5f, 0x87), (0xff, 0x5f, 0xaf), (0xff, 0x5f, 0xd7), (0xff, 0x5f, 0xff),
    (0xff, 0x87, 0x00), (0xff, 0x87, 0x5f), (0xff, 0x87, 0x87), (0xff, 0x87, 0xaf), (0xff, 0x87, 0xd7), (0xff, 0x87, 0xff),
    (0xff, 0xaf, 0x00), (0xff, 0xaf, 0x5f), (0xff, 0xaf, 0x87), (0xff, 0xaf, 0xaf), (0xff, 0xaf, 0xd7), (0xff, 0xaf, 0xff),
    (0xff, 0xd7, 0x00), (0xff, 0xd7, 0x5f), (0xff, 0xd7, 0x87), (0xff, 0xd7, 0xaf), (0xff, 0xd7, 0xd7), (0xff, 0xd7, 0xff),
    (0xff, 0xff, 0x00), (0xff, 0xff, 0x5f), (0xff, 0xff, 0x87), (0xff, 0xff, 0xaf), (0xff, 0xff, 0xd7), (0xff, 0xff, 0xff),
    # Grayscale colors
    (0x08, 0x08, 0x08), (0x12, 0x12, 0x12), (0x1c, 0x1c, 0x1c), (0x26, 0x26, 0x26), (0x30, 0x30, 0x30), (0x3a, 0x3a, 0x3a),
    (0x44, 0x44, 0x44), (0x4e, 0x4e, 0x4e), (0x58, 0x58, 0x58), (0x62, 0x62, 0x62), (0x6c, 0x6c, 0x6c), (0x76, 0x76, 0x76),
    (0x80, 0x80, 0x80), (0x8a, 0x8a, 0x8a), (0x94, 0x94, 0x94), (0x9e, 0x9e, 0x9e), (0xa8, 0xa8, 0xa8), (0xb2, 0xb2, 0xb2),
    (0xbc, 0xbc, 0xbc), (0xc6, 0xc6, 0xc6), (0xd0, 0xd0, 0xd0), (0xda, 0xda, 0xda), (0xe4, 0xe4, 0xe4), (0xee, 0xee, 0xee)
  ]

  var bestMatch = 0
  var bestDistance = distance(r, g, b, ansiColors[0][0], ansiColors[0][1], ansiColors[0][2])

  for i in 1..<ansiColors.len:
    let dist = distance(r, g, b, ansiColors[i][0], ansiColors[i][1], ansiColors[i][2])
    if dist < bestDistance:
      bestMatch = i
      bestDistance = dist

  return bestMatch + 16 # ANSI colors start at 16

### Convert hex color to ANSI color -------------------------------------------
proc hexToAnsi(hex: string, mode: int): string =
  let (r, g, b) = hexToRgb(hex)
  let ansiCode = rgbToAnsi(r, g, b)
  result = (if mode != 1: &"\e[38;5;{ansiCode}m" else: &"\e[48;5;{ansiCode}m")

### Foreground and background
proc fg(hex: string): string = hexToAnsi(hex, 0)
proc bg(hex: string): string = hexToAnsi(hex, 1)

### Foreground and background in compTime
proc cfg(hex: string): string {.compileTime.} = hexToAnsi(hex, 0)
proc cbg(hex: string): string {.compileTime.} = hexToAnsi(hex, 1)

### Other useful additional expressions
proc bold(): string {.inline.} = "\e[1;97m"
proc underline(): string {.inline.} = "\e[1;97m"
proc emphasis(): string {.inline.} = "\e[1;97m" & "\e[1;97m"
proc unstyle(): string {.inline.} = "\e[0m"

### Example usage:
# const hexColor = "#FFFF00"
# const ansiColor = hexToAnsi(hexColor, 0)
# echo ansiColor, "Hello world!"

export hexToAnsi, fg, bg, cfg, cbg, bold, underline, unstyle, emphasis
