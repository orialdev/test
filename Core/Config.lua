-- Core/Config.lua (versão atualizada)

local Config = {
    -- Valores padrão
    Aimbot = {
        Enabled = false,
        FOV = 90,
    },
    Movement = {
        Walkspeed = 16,
        Jumppower = 50,
        Noclip = {       -- <<< NOVA SEÇÃO
            Enabled = false
        }
    },
    ESP = {             -- <<< NOVA SEÇÃO
        Enabled = false,
        ShowBoxes = true,
        ShowNames = true,
        Color = Color3.fromRGB(255, 0, 255)
    }
}

-- Funções para salvar/carregar podem ser adicionadas aqui
getgenv().MyHubConfig = Config

return Config