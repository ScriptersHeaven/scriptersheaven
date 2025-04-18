-- Load Orion UI Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Main Window
local Window = OrionLib:MakeWindow({
    Name = "🌌 Scripters Heaven by @ok",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "ScriptersHeaven"
})

-- Global Toggles
getgenv().autoBubble = false
getgenv().autoSell = false
getgenv().autoHatch = false
getgenv().autoEnchant = false
getgenv().fpsBoost = false

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage:WaitForChild("Events")

-- Generic loop handler
local function toggleLoop(flag, delay, action)
    task.spawn(function()
        while getgenv()[flag] do
            pcall(action)
            task.wait(delay)
        end
    end)
end

-- FPS Boost Function
local function enableFPSBoost(enable)
    if enable then
        -- Disabling unnecessary physics and visual effects
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Workspace").StreamingEnabled = false
        game:GetService("Workspace").Gravity = 0 -- Reduce gravity to lighten physics calculations
        game:GetService("Workspace").Terrain.CanCollide = false -- Disable terrain collisions
        game:GetService("Workspace").Terrain.Material = Enum.Material.SmoothPlastic -- Lighter terrain material
        game:GetService("Workspace").Terrain.WaterWaveSize = 0 -- Disable water effects
        game:GetService("ReplicatedStorage").Waterfall:SetAttribute("Enabled", false) -- Disable waterfall
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("ParticleEmitter") then
                part.Enabled = false -- Disable particle effects
            end
        end
    else
        -- Re-enable settings if FPS Boost is turned off
        game:GetService("Lighting").GlobalShadows = true
        game:GetService("Workspace").StreamingEnabled = true
        game:GetService("Workspace").Gravity = 196.2 -- Default gravity
        game:GetService("Workspace").Terrain.CanCollide = true
        game:GetService("Workspace").Terrain.Material = Enum.Material.SmoothPlastic -- Default terrain material
        game:GetService("Workspace").Terrain.WaterWaveSize = 1 -- Default water effects
        game:GetService("ReplicatedStorage").Waterfall:SetAttribute("Enabled", true) -- Re-enable waterfall
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("ParticleEmitter") then
                part.Enabled = true -- Enable particle effects
            end
        end
    end
end

-- 📝 Welcome Tab
local InfoTab = Window:MakeTab({
    Name = "📢 Welcome",
    Icon = "rbxassetid://6031075938",
    PremiumOnly = false
})

InfoTab:AddParagraph("Welcome to Scripters Heaven", "Made with 💜 by @ok")
InfoTab:AddParagraph("Join our Discord", "🔗 https://discord.gg/mU9SSFRT")

-- 🛠️ Main Features Tab
local MainTab = Window:MakeTab({
    Name = "Main Features",
    Icon = "rbxassetid://6034977833",
    PremiumOnly = false
})

-- Auto Bubble Toggle
MainTab:AddToggle({
    Name = "🫧 Auto Bubble",
    Default = false,
    Callback = function(v)
        getgenv().autoBubble = v
        if v then toggleLoop("autoBubble", 0.2, function()
            Events.BlowBubble:FireServer()
        end) end
    end
})

-- Auto Sell Toggle
MainTab:AddToggle({
    Name = "💰 Auto Sell",
    Default = false,
    Callback = function(v)
        getgenv().autoSell = v
        if v then toggleLoop("autoSell", 2, function()
            Events.Sell:FireServer()
        end) end
    end
})

-- Auto Hatch Toggle
MainTab:AddToggle({
    Name = "🐣 Fast Auto Hatch (Skip Animation)",
    Default = false,
    Callback = function(v)
        getgenv().autoHatch = v
        if v then toggleLoop("autoHatch", 0.1, function()
            Events.HatchEgg:FireServer()
        end) end
    end
})

-- Auto Enchant Toggle
MainTab:AddToggle({
    Name = "✨ Auto Enchant",
    Default = false,
    Callback = function(v)
        getgenv().autoEnchant = v
        if v then toggleLoop("autoEnchant", 2, function()
            Events.EnchantPet:FireServer()
        end) end
    end
})

-- FPS Boost Toggle
MainTab:AddToggle({
    Name = "🚀 FPS Boost",
    Default = false,
    Callback = function(value)
        getgenv().fpsBoost = value
        enableFPSBoost(value)
    end
})

-- Launch UI
OrionLib:Init()
