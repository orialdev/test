-- Features/Walkspeed.lua

local Utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Core/Utils.lua"))()
local Config = loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/test/refs/heads/main/Core/Config.lua"))()

local WalkspeedModule = {}

local originalSpeed = 16
local connection

function WalkspeedModule:Toggle(enabled)
    Config.Movement.Enabled = enabled

    if enabled then
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if Utils.Humanoid and Utils.Humanoid.WalkSpeed ~= Config.Movement.Walkspeed then
                Utils.Humanoid.WalkSpeed = Config.Movement.Walkspeed
            end
        end)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
        if Utils.Humanoid then
            Utils.Humanoid.WalkSpeed = originalSpeed
        end
    end
end

function WalkspeedModule:SetSpeed(value)
    Config.Movement.Walkspeed = value
end

function WalkspeedModule:Init(Tabs)
    Tabs:Section({ Title = "Walkspeed", Icon = "" })
    
    Tabs:Toggle({
        Title = "Enable Walkspeed",
        Default = Config.Movement.Enabled,
        Callback = function(value)
            WalkspeedModule:Toggle(value)
        end
    })

    Tabs:Slider({
        Title = "Speed",
        Value = {
            Min = 16,
            Max = 100,
            Default = Config.Movement.Walkspeed,
        },
        Callback = function(value)
            WalkspeedModule:SetSpeed(value)
        end
    })
end

return WalkspeedModule
