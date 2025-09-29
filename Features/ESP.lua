-- Features/ESP.lua

-- Carregamos as dependências. Ajuste a URL/caminho conforme seu executor.
local Utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Core/Utils.lua"))()
local Config = loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Core/Config.lua"))()

-- Módulos e Serviços específicos para o ESP
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera

local ESPModule = {}

-- Variáveis locais para controlar o estado
local espConnection = nil
local drawingObjects = {} -- Tabela para guardar os objetos desenhados (para podermos removê-los)

-- Função para limpar todos os desenhos da tela
function ESPModule:ClearDrawings()
    for player, objects in pairs(drawingObjects) do
        for i, v in ipairs(objects) do
            v:Remove()
        end
    end
    drawingObjects = {}
end

-- Função principal do loop de desenho
function ESPModule:Render()
    -- Primeiro, limpamos os desenhos do frame anterior para evitar sobrecarga
    ESPModule:ClearDrawings()

    for i, player in ipairs(Players:GetPlayers()) do
        -- Ignoramos nós mesmos
        if player == Utils.Player then continue end

        -- Verificamos se o jogador alvo tem um personagem válido
        local character = player.Character
        if not (character and character.PrimaryPart and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0) then continue end
        
        local head = character:FindFirstChild("Head")
        if not head then continue end
        
        -- Converte a posição 3D do personagem para uma posição 2D na tela
        local position, onScreen = Camera:WorldToViewportPoint(head.Position)
        
        if onScreen then
            -- Criamos um container para os objetos deste jogador
            drawingObjects[player] = {}
            
            -- Desenhar Caixa (Box)
            if Config.ESP.ShowBoxes then
                local box = Drawing.new("Quad")
                box.Visible = true
                box.PointA = Vector2.new(position.X - 15, position.Y - 15)
                box.PointB = Vector2.new(position.X + 15, position.Y - 15)
                box.PointC = Vector2.new(position.X + 15, position.Y + 15)
                box.PointD = Vector2.new(position.X - 15, position.Y + 15)
                box.Color = Config.ESP.Color
                box.Thickness = 1
                box.Filled = false
                table.insert(drawingObjects[player], box) -- Guardamos para remover depois
            end

            -- Desenhar Nome
            if Config.ESP.ShowNames then
                local text = Drawing.new("Text")
                text.Visible = true
                text.Text = player.Name
                text.Size = 14
                text.Center = true
                text.Outline = true
                text.Color = Config.ESP.Color
                text.Position = Vector2.new(position.X, position.Y + 20)
                table.insert(drawingObjects[player], text) -- Guardamos para remover depois
            end
        end
    end
end

-- Função que é chamada pelo Toggle da UI
function ESPModule:Toggle(enabled)
    Config.ESP.Enabled = enabled
    
    if enabled then
        -- Conecta a função de renderização ao evento RenderStepped para máxima fluidez visual
        if not espConnection then
            espConnection = RunService.RenderStepped:Connect(ESPModule.Render)
        end
    else
        -- Desconecta o evento para parar o loop (CRUCIAL para performance)
        if espConnection then
            espConnection:Disconnect()
            espConnection = nil
        end
        -- Limpa qualquer desenho que tenha sobrado na tela
        ESPModule:ClearDrawings()
    end
end

-- Função que cria a UI desta feature
function ESPModule:Init(targetTab)

    targetTab:AddToggle({
        Name = "Enable ESP",
        Default = Config.ESP.Enabled,
        Callback = function(value)
            ESPModule:Toggle(value)
        end
    })
    
    targetTab:AddToggle({
        Name = "Show Boxes",
        Default = Config.ESP.ShowBoxes,
        Callback = function(value)
            Config.ESP.ShowBoxes = value
        end
    })

    targetTab:AddToggle({
        Name = "Show Names",
        Default = Config.ESP.ShowNames,
        Callback = function(value)
            Config.ESP.ShowNames = value
        end
    })
end

return ESPModule