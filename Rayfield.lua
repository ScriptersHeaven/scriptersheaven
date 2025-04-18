-- Custom GUI using built-in Roblox methods
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button1 = Instance.new("TextButton")
local Button2 = Instance.new("TextButton")
local Button3 = Instance.new("TextButton")
local Button4 = Instance.new("TextButton")

-- Parent the GUI to the player’s screen
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "BubbleSimHub"

-- Setup the frame
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Setup Buttons
Button1.Parent = Frame
Button1.Size = UDim2.new(0, 280, 0, 50)
Button1.Position = UDim2.new(0, 10, 0, 10)
Button1.Text = "Auto Bubble"
Button1.BackgroundColor3 = Color3.fromRGB(255, 100, 100)

Button2.Parent = Frame
Button2.Size = UDim2.new(0, 280, 0, 50)
Button2.Position = UDim2.new(0, 10, 0, 70)
Button2.Text = "Auto Sell"
Button2.BackgroundColor3 = Color3.fromRGB(100, 255, 100)

Button3.Parent = Frame
Button3.Size = UDim2.new(0, 280, 0, 50)
Button3.Position = UDim2.new(0, 10, 0, 130)
Button3.Text = "Fast Hatch"
Button3.BackgroundColor3 = Color3.fromRGB(100, 100, 255)

Button4.Parent = Frame
Button4.Size = UDim2.new(0, 280, 0, 50)
Button4.Position = UDim2.new(0, 10, 0, 190)
Button4.Text = "Auto Collect Coins"
Button4.BackgroundColor3 = Color3.fromRGB(255, 255, 100)

-- Variables to control toggles
local autoBubble = false
local autoSell = false
local autoHatch = false
local autoCollectCoins = false

-- Functions for features

-- Auto Bubble Function
local function autoBubbleFunction()
    while autoBubble do
        -- Fire the event to blow bubble
        game.ReplicatedStorage.Events.BlowBubble:FireServer()
        wait(0.2)
    end
end

-- Auto Sell Function
local function autoSellFunction()
    while autoSell do
        -- Fire the event to sell bubbles
        game.ReplicatedStorage.Events.Sell:FireServer()
        wait(2)
    end
end

-- Fast Hatch Function
local function fastHatchFunction()
    while autoHatch do
        -- Fire the event to hatch eggs
        game.ReplicatedStorage.Events.HatchEgg:FireServer()
        wait(0.1)
    end
end

-- Auto Collect Coins Function
local function autoCollectCoinsFunction()
    while autoCollectCoins do
        -- Loop through all coin pickups in the workspace and collect them
        for _, pickup in pairs(workspace:GetChildren()) do
            if pickup:IsA("Part") and pickup.Name == "CoinPickup" then
                game.ReplicatedStorage.Events.CollectCoin:FireServer(pickup)
            end
        end
        wait(0.5) -- Adjust the delay for collecting coins
    end
end

-- Button Callbacks

-- Auto Bubble Button
Button1.MouseButton1Click:Connect(function()
    autoBubble = not autoBubble
    if autoBubble then
        spawn(autoBubbleFunction)
    end
end)

-- Auto Sell Button
Button2.MouseButton1Click:Connect(function()
    autoSell = not autoSell
    if autoSell then
        spawn(autoSellFunction)
    end
end)

-- Fast Hatch Button
Button3.MouseButton1Click:Connect(function()
    autoHatch = not autoHatch
    if autoHatch then
        spawn(fastHatchFunction)
    end
end)

-- Auto Collect Coins Button
Button4.MouseButton1Click:Connect(function()
    autoCollectCoins = not autoCollectCoins
    if autoCollectCoins then
        spawn(autoCollectCoinsFunction)
    end
end)

-- All functions and events are properly closed now
