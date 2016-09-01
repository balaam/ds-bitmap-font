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
        ['CombatFontDef.lua'] =
        {
            path = "CombatFontDef.lua"
        },
        ['FantasyFontDef.lua'] =
        {
            path = "FantasyFontDef.lua"
        },
        ['DamageFontDef.lua'] =
        {
            path = "DamageFontDef.lua"
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
        ['combat_font.png'] =
        {
            path = "combat_font.png",
            scale = "pixelart"
        },
        ['fantasy_font.png'] =
        {
            path = "fantasy_font.png",
            scale = "pixelart"
        },
        ['damage_font.png'] =
        {
            path = "damage_font.png",
            scale = "pixelart"
        },
    }
}