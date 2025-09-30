-- Main.lua
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- Carregar os módulos principais
-- O método de carregar (require, loadstring, etc.) depende do seu executor
local Utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Core/Utils.lua"))()
local Config = loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Core/Config.lua"))()
local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Core/GUI.lua"))()

-- Lista dos módulos de features a serem carregados
local FeatureList = {
    "Walkspeed",
    "Aimbot",
    "ESP",      -- <<< ADICIONADO
    "Noclip"    -- <<< ADICIONADO
}

-- Carregar e inicializar cada feature
for _, featureName in ipairs(FeatureList) do
    local success, featureModule = pcall(function()
        -- Carrega o módulo da feature
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Features/" .. featureName .. ".lua"))()
    end)

    if success and featureModule then
        local targetTab
        -- ATUALIZADO: Lógica de atribuição de abas
        if featureName == "Walkspeed" or featureName == "Noclip" then
            targetTab = GUI.Tabs.Player
        elseif featureName == "Aimbot" then
            targetTab = GUI.Tabs.Combat
        elseif featureName == "ESP" then
            targetTab = GUI.Tabs.Visuals
        end
        
        if targetTab and featureModule.Init then
            pcall(featureModule.Init, featureModule, targetTab) -- pcall para segurança
        else
            warn("Módulo", featureName, "não possui Init ou aba de destino.")
        end
    else
        warn("Falha ao carregar o módulo:", featureName, featureModule)
    end
end