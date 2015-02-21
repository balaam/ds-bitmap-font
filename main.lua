LoadLibrary("Renderer")
LoadLibrary("Texture")
LoadLibrary("Sprite")
LoadLibrary("Vector")
LoadLibrary("Asset")

Asset.Run("BitmapText.lua")

gRenderer = Renderer:Create()
gRenderer:AlignText("center", "center")



bText = BitmapText:Create("font.png", 8, 8)

function update()

    local maxWidth = 300
    local text = "But what if your Factories are also designed to be plug-and-play? For example, while the Factory concept is designed to insulate your code from the implementation of the desired class the Adapter maybe some adapter implementations require parameters which your Factory might not ship with knowledge of"
    local w = bText:CalcWidth(text)
    local h = bText:CalcHeight(text)
    local x = -w/2
    local y = -h/2
    local size = bText:MeasureText(text, maxWidth)

    local bX = -size:X()/2
    local bY = -size:Y()/2
    gRenderer:DrawRect2d(bX, bY, bX + size:X(), bY + size:Y(), Vector.Create(1, 0, 0, 1))
    bText:RenderLineWrap(gRenderer, 0, 0, text, Vector.Create(1,1,1,1),"center", "center", maxWidth)
end