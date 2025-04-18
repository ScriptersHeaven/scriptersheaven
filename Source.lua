-- Create a window for Scripters Heaven
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/ScriptersHeaven/scriptersheaven/main/Source.lua'))()
local window = Rayfield:CreateWindow({
    Name = "Scripters Heaven",
    LoadingTitle = "Loading Scripters Heaven",
    LoadingSubtitle = "Bubble Gum Simulator",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Scripters Heaven"
    },
    Discord = {
        Enabled = true,
        Name = "Scripters Heaven",
        Invite = "https://discord.gg/mU9SSFRT",
        Description = "Welcome to Scripters Heaven!"
    },
    KeySystem = false,
    Key = nil
})

-- Create a Tab for functions
local tab = window:CreateTab("Main", 4483362458)

-- Add a welcome note
tab:CreateLabel("Welcome to Scripters Heaven!")
tab:CreateLabel("Join our Discord: https://discord.gg/mU9SSFRT")

-- Auto Bubble
local autoBubble = false
local autoBubbleButton = tab:CreateButton({
    Name = "Auto Bubble",
    Callback = function()
        autoBubble = not autoBubble
        if autoBubble then
            autoBubbleButton:SetText("Auto Bubble - On")
        else
            autoBubbleButton:SetText("Auto Bubble - Off")
        end
    end
})

game:GetService("RunService").Heartbeat:Connect(function()
    if autoBubble then
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            -- Example of simulating bubble action
            -- Your actual game mechanics for bubbling will go here
            fireclickdetector(workspace.BubbleGum:FindFirstChild("BubbleGumClickDetector")) -- Example action
        end
    end
end)

-- Auto Sell
local autoSell = false
local autoSellButton = tab:CreateButton({
    Name = "Auto Sell",
    Callback = function()
        autoSell = not autoSell
        if autoSell then
            autoSellButton:SetText("Auto Sell - On")
        else
            autoSellButton:SetText("Auto Sell - Off")
        end
    end
})

game:GetService("RunService").Heartbeat:Connect(function()
    if autoSell then
        -- Example of triggering an auto sell action in Bubble Gum Simulator
        local sellArea = workspace:WaitForChild("SellArea")
        local player = game.Players.LocalPlayer
        if player.Character then
            local char = player.Character
            char.HumanoidRootPart.CFrame = sellArea.CFrame
            -- Simulate auto sell action here
            fireclickdetector(sellArea:FindFirstChild("ClickDetector")) -- Example action
        end
    end
end)

-- Auto Collect
local autoCollect = false
local autoCollectButton = tab:CreateButton({
    Name = "Auto Collect",
    Callback = function()
        autoCollect = not autoCollect
        if autoCollect then
            autoCollectButton:SetText("Auto Collect - On")
        else
            autoCollectButton:SetText("Auto Collect - Off")
        end
    end
})

game:GetService("RunService").Heartbeat:Connect(function()
    if autoCollect then
        local player = game.Players.LocalPlayer
        for _,pickup in pairs(workspace.Pickups:GetChildren()) do
            if pickup:IsA("Part") and (pickup.Position - player.Character.HumanoidRootPart.Position).Magnitude < 10 then
                -- Simulate collection of the pickup
                fireclickdetector(pickup:FindFirstChild("ClickDetector"))
            end
        end
    end
end)

-- Minimize and Close Buttons
local minimizeButton = window:CreateButton({
    Name = "Minimize",
    Callback = function()
        window:Minimize()
    end
})

local closeButton = window:CreateButton({
    Name = "Close",
    Callback = function()
        window:Close()
    end
})
