--
-- A manifest of all the game's assets test
--
manifest =
{
    scripts =
    {
        ['Main.lua'] =
        {
            path = "main.lua"
        },
        ['BitmapText.lua'] =
        {
            path = "BitmapText.lua"
        },
        ['DefaultFontDef.lua'] =
        {
            path = "DefaultFontDef.lua"
        },
    },
    shaders =
    {

    },
    -- fonts =
    -- {
    --     ['font'] =
    --     {
    --         path = "font.ttf"
    --     }
    -- },
    textures =
    {
        ['font.png'] =
        {
            path = "bitmap_font.png",
            scale = "pixelart"
        },
    }
}