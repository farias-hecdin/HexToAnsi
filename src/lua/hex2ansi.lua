-- Convert hex color to RGB
local function hexToRgb(hex)
  hex = hex:gsub("#","")
  return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

-- Convert RGB to the closest ANSI 256 color
local function rgbToAnsi256(r, g, b)
  -- Verificar si es mejor aproximación en escala de grises
  if r == g and g == b then
    if r < 8 then
      return 16
    elseif r > 248 then
      return 231
    else
      local grayIndex = (r - 8) * 24 / 247
      return 232 + grayIndex
    end
  else
    -- Mapear valores RGB a rango 0..5
    local ri = r * 5 / 255
    local gi = g * 5 / 255
    local bi = b * 5 / 255
    return 16 + 36 * ri + 6 * gi + bi
  end
end

-- Convert hex color to ANSI color
local function hexToAnsi(hex)
  local r, g, b = hexToRgb(hex)
  local ansiCode = rgbToAnsi256(r, g, b)
  return string.format("\\e[38;5;%dm", ansiCode)
end

-- Example usage
local hexColor = "#47a95e"
local ansiColor = hexToAnsi(hexColor)
print(ansiColor)

