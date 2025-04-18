-- Load VapeLib (an alternative to OrionLib)
local VapeLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/axstin/rbx-vapelibs/main/source.lua"))()

-- Create the main window using VapeLib
local Window = VapeLib:Window({
    Name = "Scripters Heaven by @ok",
    Size = UDim2.new(0, 500, 0, 300),
    Theme = VapeLib.Theme.Light
})

-- Global variables to store toggle states
getgenv().autoBubble = false
getgenv().autoSell = false
getgenv().autoHatch = false

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage:WaitForChild("Events")

-- Function to manage looping actions
local function toggleLoop(flag, delay, action)
    while getgenv()[flag] do
        pcall(action)
        wait(delay)
    end
end

-- Auto Bubble Feature
local function autoBubbleFunction()
    while getgenv().autoBubble do
        pcall(function()
            Events.BlowBubble:FireServer()  -- Adjust this if necessary
        end)
        wait(0.2) -- Adjust the delay to your preference
    end
end

-- Auto Sell Feature
local function autoSellFunction()
    while getgenv().autoSell do
        pcall(function()
            Events.Sell:FireServer()  -- Adjust this if necessary
        end)
        wait(2) -- Adjust the wait time as per your needs
    end
end

-- Fast Hatch Feature
local function fastHatchFunction()
    while getgenv().autoHatch do
        pcall(function()
            Events.HatchEgg:FireServer()  -- Adjust this if necessary
        end)
        wait(0.1)  -- Almost no wait for instant hatching
    end
end

-- Create Tabs and Buttons in the GUI

-- Info Tab (with Discord link)
local InfoTab = Window:Tab({
    Name = "📢 Welcome",
    Icon = "rbxassetid://6031075938"
})
InfoTab:Label("Welcome to Scripters Heaven!")
InfoTab:Label("Join our Discord: https://discord.gg/mU9SSFRT")

-- Main Features Tab
local FeaturesTab = Window:Tab({
    Name = "Main Features",
    Icon = "rbxassetid://6034977833"
})

-- Auto Bubble Toggle
FeaturesTab:Button({
    Name = "🫧 Auto Bubble",
    Callback = function()
        getgenv().autoBubble = not getgenv().autoBubble
        if getgenv().autoBubble then
            spawn(autoBubbleFunction)
        end
    end
})

-- Auto Sell Toggle
FeaturesTab:Button({
    Name = "💰 Auto Sell",
    Callback = function()
        getgenv().autoSell = not getgenv().autoSell
        if getgenv().autoSell then
            spawn(autoSellFunction)
        end
    end
})

-- Fast Hatch Toggle
FeaturesTab:Button({
    Name = "🐣 Fast Hatch",
    Callback = function()
        getgenv().autoHatch = not getgenv().autoHatch
        if getgenv().autoHatch then
            spawn(fastHatchFunction)
        end
    end
})

-- Initialize the VapeLib GUI
VapeLib:Init()
