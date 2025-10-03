local GUI = {}

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Vision Hub",
    Icon = "rbxassetid://72201625354894",
    Author = "orialdev",
    Folder = "visionfolder",
    User = {
        Enabled = true,
        Anonymous = false,
    }
})

GUI.Tabs = {
    Player      = Window:Tab({ Title = "Player", Icon = "user" }),
    Combat      = Window:Tab({ Title = "Combat", Icon = "swords" }),
    Visuals     = Window:Tab({ Title = "Visuals", Icon = "eye" }),
    Teleports   = Window:Tab({ Title = "Teleports", Icon = "map-pin" }),
    Utilities   = Window:Tab({ Title = "Utilities", Icon = "box" }),
    Extras    = Window:Tab({ Title = "Extras", Icon = "book-open" }),
}

return GUI