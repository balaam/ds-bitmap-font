LoadLibrary("Renderer")
LoadLibrary("Texture")
LoadLibrary("Sprite")
LoadLibrary("Vector")
LoadLibrary("Asset")
LoadLibrary("System")

Asset.Run("BitmapText.lua")
Asset.Run("DefaultFontDef.lua")

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

function drawText(bitmapText, x, y, alignX, text)

    text = text or lorem
    local size1 = bitmapText:MeasureText(text, gMaxWidth)
    local size = Vector.Create(size1)

    bitmapText:DrawText2d(gRenderer, x, y, text, Vector.Create(0,0,0,1), gMaxWidth)
    drawCross(x, y)
    drawDot(x, y)

    if alignX == "right" then
        size1:SetX(size1:X() * -1)
    elseif alignX == "center" then
        x = x - size1:X() /2
        y = y - size1:Y() /2
    end

    gRenderer:DrawLine2d(x, y, x + size1:X(), y, Vector.Create(1, 0, 0, 1))
    gRenderer:DrawLine2d(x, y, x, y + size1:Y(), Vector.Create(1, 0, 0, 1))
    gRenderer:DrawLine2d(x + size1:X(), y, x + size1:X(), y + size1:Y(), Vector.Create(1,0,0,1))
    gRenderer:DrawLine2d(x + size1:X(), y + size1:Y(), x, y + size1:Y(), Vector.Create(1,0,0,1))

    if alignX == "left" then
        gRenderer:DrawLine2d(x + gMaxWidth, -150, x + gMaxWidth, 150, Vector.Create(0, 1, 0, 1))
        gRenderer:AlignText("center", "center")
        gRenderer:DrawText2d(x + gMaxWidth, -50, "MaxWidth: " .. gMaxWidth, Vector.Create(0,0,0,1), 80)
    elseif alignX == "right" then
        gRenderer:DrawLine2d(x - gMaxWidth, -150, x - gMaxWidth, 150, Vector.Create(0, 1, 0, 1))
        gRenderer:AlignText("center", "center")
        gRenderer:DrawText2d(x - gMaxWidth, -50, "MaxWidth: " .. gMaxWidth, Vector.Create(0,0,0,1), 80)
    elseif alignX == "center" then

    end

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

    local size = drawText(bText, posText, textY, alignX)
    local offsetX = textX + size:X()/2
    local offsetY = -15

    if alignX == "right" then
        offsetX = textX + (size:X() * -0.5)
    elseif alignX == "center" then
        offsetX = 0
        offsetY = (textY - size:Y()*0.5) - 15
    end

    gRenderer:DrawText2d(offsetX , offsetY, posLabel, Vector.Create(0,0,0,1))
end


bText = BitmapText:Create(DefaultFontDef)

function update()

    drawBackground()

    local textX = 125

    drawTextWithLabel(textX, 0, "left", "bottom")
    drawTextWithLabel(-textX, 0, "right", "bottom")
    drawTextWithLabel(200, 150, "center", "center")

    local x = 0
    local y = -100
    drawText(bText, x, y, "center", "1010")
end