-- Core/GUI.lua
local GUI = {}

-- Supondo que você está usando uma biblioteca de UI chamada 'OrionLib'
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:MakeWindow({
    Name = "testing",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "MyHubConfig"
})

-- Criamos as abas aqui e as guardamos para que os módulos possam usá-las
GUI.Tabs = {
    Player      = Window:Tab({ Title = "Player", Icon = "user" }),
    Combat      = Window:Tab({ Title = "Combat", Icon = "swords" }),
    Visuals     = Window:Tab({ Title = "Visuals", Icon = "eye" }),
    Teleports   = Window:Tab({ Title = "Teleports", Icon = "map-pin" }),
    Utilities   = Window:Tab({ Title = "Utilities", Icon = "box" }),
    Extras    = Window:Tab({ Title = "Extras", Icon = "book-open" }),
}

return GUI