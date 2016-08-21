LoadLibrary("Renderer")
LoadLibrary("Texture")
LoadLibrary("Sprite")
LoadLibrary("Vector")
LoadLibrary("Asset")
LoadLibrary("System")

Asset.Run("BitmapText.lua")
Asset.Run("DefaultFontDef.lua")
Asset.Run("CombatFontDef.lua")

gRenderer = Renderer:Create()
gRenderer:AlignText("center", "center")

local lorem = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
gMaxWidth = 200

gBackColor = Vector.Create(248/255, 243/255, 214/255, 1)
gDotColor = Vector.Create(1, 0, 0, 1)
function drawDot(x, y)
    local halfWidth = 2
    local halfHeight = 2
    gRenderer:DrawRect2d(
        x - halfWidth,
        y - halfHeight,
        x + halfWidth,
        y + halfHeight,
        gDotColor
    )
end

gLineColor = Vector.Create(0, 0, 1, 1)
function drawCross(x, y)
    gRenderer:DrawLine2d(x, y, x, y - 30, gLineColor)
    gRenderer:DrawLine2d(x, y, x, y + 30, gLineColor)

    gRenderer:DrawLine2d(x, y, x - 60, y, gLineColor)
    gRenderer:DrawLine2d(x, y, x + 60, y, gLineColor)
end

function drawText(bitmapText, x, y, alignX, alignY, text, maxW, color)

    local maxWidth = maxW or gMaxWidth
    text = text or lorem
    local size1 = bitmapText:MeasureText(text, maxWidth)
    local size = Vector.Create(size1)

    bitmapText:AlignText(alignX, alignY or "bottom")

    bitmapText:DrawText2d(gRenderer, x, y, text, color or Vector.Create(0,0,0,1), maxWidth)
    drawCross(x, y)
    drawDot(x, y)

    if alignX == "right" then
        size1:SetX(size1:X() * -1)
    elseif alignX == "center" then
        x = x - size1:X() /2
    end

    if alignY == "center" then
        y = y - size1:Y() /2
    elseif alignY == "top" then
        y = y - size1:Y()
    end

    gRenderer:DrawLine2d(x, y, x + size1:X(), y, Vector.Create(1, 0, 0, 1))
    gRenderer:DrawLine2d(x, y, x, y + size1:Y(), Vector.Create(1, 0, 0, 1))
    gRenderer:DrawLine2d(x + size1:X(), y, x + size1:X(), y + size1:Y(), Vector.Create(1,0,0,1))
    gRenderer:DrawLine2d(x + size1:X(), y + size1:Y(), x, y + size1:Y(), Vector.Create(1,0,0,1))



    -- yeh this is pretty hacky
    return size

end

function drawBackground()
    local x = 0
    local y = 0
    local halfWidth = System.ScreenWidth() / 2
    local halfHeight = System.ScreenHeight() / 2
    gRenderer:DrawRect2d(
        x - halfWidth,
        y - halfHeight,
        x + halfWidth,
        y + halfHeight,
        gBackColor
    )
end

function drawTextWithLabel(textX, textY, alignX, alignY)
    local alignX = alignX
    local alignY = alignY
    bText:AlignText(alignX, alignY)

    local posLabel = string.format("AlignX: %s AlignY: %s", alignX, alignY)

    local posText = textX

    if alignX == "center" then
        posText = 0
    end

    local size = drawText(bText, posText, textY, alignX, alignY)
    local offsetX = textX + size:X()/2
    local offsetY = -15

    if alignX == "right" then
        offsetX = textX + (size:X() * -0.5)
    elseif alignX == "center" then
        offsetX = 0
    end

    if alignY == "center" then
        offsetY = (textY - size:Y()*0.5) - 15
    end

    gRenderer:DrawText2d(offsetX , offsetY, posLabel, Vector.Create(0,0,0,1))

    if alignX == "left" then
        gRenderer:DrawLine2d(textX + gMaxWidth, -150, textX + gMaxWidth, 150, Vector.Create(0, 1, 0, 1))
        gRenderer:AlignText("center", "center")
        gRenderer:DrawText2d(textX + gMaxWidth, -50, "MaxWidth: " .. gMaxWidth, Vector.Create(0,0,0,1), 80)
    elseif alignX == "right" then
        gRenderer:DrawLine2d(textX - gMaxWidth, -150, textX - gMaxWidth, 150, Vector.Create(0, 1, 0, 1))
        gRenderer:AlignText("center", "center")
        gRenderer:DrawText2d(textX - gMaxWidth, -50, "MaxWidth: " .. gMaxWidth, Vector.Create(0,0,0,1), 80)
    elseif alignX == "center" then

    end
end


bText = BitmapText:Create(DefaultFontDef)
cText = BitmapText:Create(CombatFontDef)

function update()

    drawBackground()

    local textX = 125

    drawTextWithLabel(textX, 0, "left", "bottom")
    drawTextWithLabel(-textX, 0, "right", "bottom")
    drawTextWithLabel(200, 150, "center", "center")

    local x = 0
    local y = -100

    drawText(cText, x, y - 25, "center", "top", "11337", 30, Vector.Create(1,1,1,1))

    drawText(bText, x, y, "center", "bottom", "1010")
    drawText(bText, x - 50, y, "right", "bottom", "1010")
    drawText(bText, x + 50, y, "left", "bottom", "1010")

    -- pixel width is 26, so do a 30 width
    y = -125
    drawText(bText, x - 50, y, "right", "center", "1010 1010", 30)
    drawText(bText, x + 50, y, "left", "center", "1010 1010", 30)

    y = -150
    drawText(bText, x, y, "center", "top", "1010 101010", 30)
    drawText(bText, x - 50, y, "right", "top", "1010 1010", 30)
    drawText(bText, x + 50, y, "left", "top", "1010 1010", 30)


end