LoadLibrary("Renderer")
LoadLibrary("Texture")
LoadLibrary("Sprite")
LoadLibrary("Vector")
LoadLibrary("Asset")
LoadLibrary("System")

Asset.Run("BitmapText.lua")

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

function drawText(bitmapText, x, y, alignX)

    local size1 = bitmapText:MeasureText(lorem, gMaxWidth)
    bitmapText:DrawText2d(gRenderer, x, y, lorem, Vector.Create(0,0,0,1), gMaxWidth)
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

end


bText = BitmapText:Create("font.png", 8, 8)

function update()

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

    local textX = 125

    alignX = "left"
    bText:AlignText(alignX, "bottom")
    drawText(bText, textX, 0, alignX)

    alignX = "right"
    bText:AlignText(alignX, "bottom")
    drawText(bText, -textX, 0, alignX)
    gRenderer:AlignText("center", "center")
    gRenderer:DrawText2d(-textX, 0 - 50, "AlignX: right AlignY: top", Vector.Create(0,0,0,1))


    alignX = "center"
    bText:AlignText("center", "center")
    drawText(bText, 0, 150, alignX)
    gRenderer:AlignText("center", "center")
    gRenderer:DrawText2d(0, 85, "AlignX: center AlignY: center MaxWidth: 200", Vector.Create(0,0,0,1), 200)

end