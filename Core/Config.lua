-- Core/Config.lua
local Config = {
    -- Valores padrão
    Aimbot = {
        Enabled = false,
        FOV = 90,
    },
    Movement = {
        Walkspeed = 16,
        Jumppower = 50,
    },
    ESP = {
        Enabled = false,
        Boxes = true,
    }
}

-- Funções para salvar/carregar podem ser adicionadas aqui
-- Exemplo simples (usando getgenv, comum em executores):
-- getgenv().MyHubConfig = Config

return Config