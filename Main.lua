local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

if getgenv().HubLoaded then return end
getgenv().HubLoaded = true

local Utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Core/Utils.lua"))()
local Config = loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Core/Config.lua"))()
local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Core/GUI.lua"))()

local FeatureList = {
    "Walkspeed",
    "Aimbot",
    "ESP",
    "Noclip"
}

for _, featureName in ipairs(FeatureList) do
    local success, featureModule = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Features/" .. featureName .. ".lua"))()
    end)

    if success and featureModule then
        local Tabs = GUI.Tabs
        if featureName == "Walkspeed" or featureName == "Noclip" then
            Tabs = GUI.Tabs.Player
        elseif featureName == "Aimbot" then
            Tabs = GUI.Tabs.Combat
        elseif featureName == "ESP" then
            Tabs = GUI.Tabs.Visuals
        end
        
        if Tabs and featureModule.Init then
            pcall(featureModule.Init, featureModule, Tabs)
        else
            warn("Módulo", featureName, "não possui Init ou aba de destino.")
        end
    else
        warn("Falha ao carregar o módulo:", featureName, featureModule)
    end
end