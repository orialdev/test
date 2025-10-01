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
        local targetTab
        if featureName == "Walkspeed" or featureName == "Noclip" then
            targetTab = GUI.Tabs.Player
        elseif featureName == "Aimbot" then
            targetTab = GUI.Tabs.Combat
        elseif featureName == "ESP" then
            targetTab = GUI.Tabs.Visuals
        end
        
        if targetTab and featureModule.Init then
            pcall(featureModule.Init, featureModule, targetTab)
        else
            warn("Módulo", featureName, "não possui Init ou aba de destino.")
        end
    else
        warn("Falha ao carregar o módulo:", featureName, featureModule)
    end
end