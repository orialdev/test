-- Features/Noclip.lua

local Utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Core/Utils.lua"))()
local Config = loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Core/Config.lua"))()

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local NoclipModule = {}

local noclipConnection = nil
local noclip = false
local speed = 1 -- Velocidade do noclip

local function doNoclip()
    if not noclip or not Utils.Character or not Utils.Humanoid then return end

    -- Mantém o humanoide em um estado que permite voo livre
    Utils.Humanoid:ChangeState(Enum.HumanoidStateType.Running)

    local moveVector = Vector3.new()
    -- Checa as teclas pressionadas para movimento
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + workspace.CurrentCamera.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - workspace.CurrentCamera.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + workspace.CurrentCamera.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - workspace.CurrentCamera.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVector = moveVector + Vector3.new(0, 1, 0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveVector = moveVector - Vector3.new(0, 1, 0) end

    -- Aplica o movimento
    if Utils.Character.PrimaryPart then
        Utils.Character.PrimaryPart.Velocity = moveVector.Unit * 50 * speed
    end
end

function NoclipModule:Toggle(enabled)
    Config.Movement.Noclip.Enabled = enabled
    noclip = enabled
    
    if enabled then
        -- Usamos 'Stepped' para manipular a física de forma consistente
        if not noclipConnection then
            noclipConnection = RunService.Stepped:Connect(doNoclip)
        end
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        -- Reseta a velocidade para parar o personagem
        if Utils.Character.PrimaryPart then
            Utils.Character.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
        end
    end
end

function NoclipModule:Init(targetTab)
    local section = targetTab:Section({
    Title = "",
    Icon = "",
    TextXAlignment = "Left",
    TextSize = 26,
})
    
    section:Toggle({
        Title = "Enable Noclip",
        Default = Config.Movement.Noclip.Enabled,
        Callback = function(value)
            NoclipModule:Toggle(value)
        end
    })
    
    section:Slider({
        Title = "Noclip Speed",
        Value = {
            Min = 0.5,
            Max = 5,
            Default = Config.Movement.Noclip.Speed,
        },
        Callback = function(value)
            speed = value
        end
    })
end

return NoclipModule