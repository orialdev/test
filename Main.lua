-- Main.lua

-- Garante que o script não rode duas vezes
if getgenv().HubLoaded then return end
getgenv().HubLoaded = true

-- Carregar os módulos principais
-- O método de carregar (require, loadstring, etc.) depende do seu executor
local Utils = loadstring(game:HttpGet("URL_PARA/Core/Utils.lua"))()
local Config = loadstring(game:HttpGet("URL_PARA/Core/Config.lua"))()
local GUI = loadstring(game:HttpGet("URL_PARA/Core/GUI.lua"))()

-- Lista dos módulos de features a serem carregados
local FeatureList = {
    "Walkspeed",
    "Aimbot",
    "ESP"
}

-- Carregar e inicializar cada feature
for _, featureName in ipairs(FeatureList) do
    local success, featureModule = pcall(function()
        -- Carrega o módulo da feature
        return loadstring(game:HttpGet("URL_PARA/Features/" .. featureName .. ".lua"))()
    end)

    if success and featureModule then
        -- Descobre em qual aba a UI deve ser criada (poderia ser mais avançado)
        local targetTab
        if featureName == "Walkspeed" then
            targetTab = GUI.Tabs.Movement
        elseif featureName == "Aimbot" then
            targetTab = GUI.Tabs.Combat
        elseif featureName == "ESP" then
            targetTab = GUI.Tabs.Visuals
        end
        
        -- Inicializa o módulo, passando a aba de destino para ele
        if targetTab and featureModule.Init then
            featureModule:Init(targetTab)
        end
    else
        warn("Falha ao carregar o módulo:", featureName, featureModule)
    end
end