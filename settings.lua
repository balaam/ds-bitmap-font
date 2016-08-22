
name = "Bitmap Test Project"
width = 320
height = 244
manifest = "manifest.lua"

display_width = width * 2
display_height = height * 2

--
-- This script is expected to be an asset in the manifest file.
-- It's executed at the start
--
main_script = "Main.lua"
on_update = "update()"

webserver = true
