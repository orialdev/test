local GUI = {}

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "My Super Hub",
    Icon = "door-open",
    Author = "by .ftgs and .ftgs",
    Folder = "MySuperHub",

    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    ToggleKey = Enum.KeyCode.RightShift,
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