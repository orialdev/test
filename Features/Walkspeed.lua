-- Features/Walkspeed.lua

-- Carregamos as dependências necessárias no início
local Utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Core/Utils.lua"))()
local Config = loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Core/Config.lua"))()

-- O módulo em si
local WalkspeedModule = {}

-- Variáveis locais ao módulo
local originalSpeed = 16
local connection

-- Função principal que será chamada pela UI
function WalkspeedModule:Toggle(enabled)
    Config.Movement.Enabled = enabled -- Salva no config

    if enabled then
        -- Usando RunService para garantir que a velocidade seja mantida
        -- Isso é mais robusto contra scripts anti-cheat do jogo
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if Utils.Humanoid and Utils.Humanoid.WalkSpeed ~= Config.Movement.Walkspeed then
                Utils.Humanoid.WalkSpeed = Config.Movement.Walkspeed
            end
        end)
    else
        -- Desconecta o loop para otimizar e para de alterar a velocidade
        if connection then
            connection:Disconnect()
            connection = nil
        end
        -- Restaura a velocidade original
        if Utils.Humanoid then
            Utils.Humanoid.WalkSpeed = originalSpeed
        end
    end
end

function WalkspeedModule:SetSpeed(value)
    Config.Movement.Walkspeed = value
end

-- Função de inicialização: cria a UI para este módulo específico
function WalkspeedModule:Init(targetTab)
    local section = targetTab:Section({ 
    Title = "Section",
    Box = false,
    FontWeight = "SemiBold",
    TextTransparency = 0.05,
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
    Opened = true,
})

    section:Toggle({
        Title = "Enable Walkspeed",
        Default = Config.Movement.Enabled, -- Pega o valor do config
        Callback = function(value)
            WalkspeedModule:Toggle(value)
        end
    })

    section:Slider({
        Title = "Speed",
        Value = {
            Min = 16,
            Max = 100,
            Default = Config.Movement.Walkspeed, -- Pega o valor do config
        },
        Callback = function(value)
            WalkspeedModule:SetSpeed(value)
        end
    })
end

return WalkspeedModule