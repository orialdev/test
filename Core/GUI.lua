-- Core/GUI.lua
local GUI = {}

-- Supondo que você está usando uma biblioteca de UI chamada 'OrionLib'
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Meu Super Hub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "MyHubConfig"
})

-- Criamos as abas aqui e as guardamos para que os módulos possam usá-las
GUI.Tabs = {
    Combat = Window:MakeTab({ Name = "Combat", Icon = "rbxassetid://4483345998", PremiumOnly = false }),
    Movement = Window:MakeTab({ Name = "Movement", Icon = "rbxassetid://4483345998", PremiumOnly = false }),
    Visuals = Window:MakeTab({ Name = "Visuals", Icon = "rbxassetid://4483345998", PremiumOnly = false })
}

return GUI