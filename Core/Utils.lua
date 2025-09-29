-- Core/Utils.lua
local Utils = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

Utils.Player = Players.LocalPlayer
Utils.Character = Utils.Player.Character or Utils.Player.CharacterAdded:Wait()
Utils.Humanoid = Utils.Character:WaitForChild("Humanoid")

-- Atualiza o personagem se o jogador morrer
Utils.Player.CharacterAdded:Connect(function(character)
    Utils.Character = character
    Utils.Humanoid = character:WaitForChild("Humanoid")
end)

-- Função para obter um serviço de forma segura
function Utils.GetService(serviceName)
    local success, service = pcall(function()
        return game:GetService(serviceName)
    end)
    return success and service or nil
end

-- Outras funções úteis podem vir aqui...

return Utils