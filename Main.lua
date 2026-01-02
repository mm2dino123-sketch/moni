-- Moni's AP Spammer v1.1 (BIG VERSION)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Commands list
local COMMANDS = {"ragdoll", "rocket", "balloon", "inverse", "jail", "nightvision", "tiny"}

-- Remote path
local RemotePath = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/AdminPanelService/ExecuteCommand")

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MonisAPSpammer"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- BIGGER Main Frame (450x350)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175) -- Centered for bigger size
MainFrame.Size = UDim2.new(0, 450, 0, 350) -- MUCH BIGGER!
MainFrame.Active = true
MainFrame.Draggable = true

-- Corner rounding
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Stroke
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 50, 100)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Title (bigger)
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 20, 0, 15)
Title.Size = UDim2.new(1, -40, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "🎯 MONI'S AP SPAMMER - BIG EDITION"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Player Dropdown Frame (bigger)
local DropdownFrame = Instance.new("Frame")
DropdownFrame.Name = "DropdownFrame"
DropdownFrame.Parent = MainFrame
DropdownFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
DropdownFrame.Position = UDim2.new(0, 20, 0, 60)
DropdownFrame.Size = UDim2.new(1, -40, 0, 50) -- Bigger dropdown button
DropdownFrame.BorderSizePixel = 0

local DropdownCorner = Instance.new("UICorner")
DropdownCorner.CornerRadius = UDim.new(0, 8)
DropdownCorner.Parent = DropdownFrame

-- Dropdown Button (bigger text)
local DropdownButton = Instance.new("TextButton")
DropdownButton.Name = "DropdownButton"
DropdownButton.Parent = DropdownFrame
DropdownButton.BackgroundTransparency = 1
DropdownButton.Size = UDim2.new(1, 0, 1, 0)
DropdownButton.Font = Enum.Font.GothamBold
DropdownButton.Text = "👤 CLICK TO SELECT PLAYER (Shows ALL)"
DropdownButton.TextColor3 = Color3.fromRGB(200, 200, 200)
DropdownButton.TextScaled = true

-- BIG Dropdown List with Scrolling (200px tall!)
local DropdownList = Instance.new("ScrollingFrame")
DropdownList.Name = "DropdownList"
DropdownList.Parent = DropdownFrame
DropdownList.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
DropdownList.Position = UDim2.new(0, 0, 1, 5)
DropdownList.Size = UDim2.new(1, 0, 0, 200) -- BIG LIST!
DropdownList.Visible = false
DropdownList.BorderSizePixel = 0
DropdownList.ScrollBarThickness = 8
DropdownList.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 100)
DropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 8)
ListCorner.Parent = DropdownList

-- Spam Button (bigger)
local SpamButton = Instance.new("TextButton")
SpamButton.Name = "SpamButton"
SpamButton.Parent = MainFrame
SpamButton.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
SpamButton.Position = UDim2.new(0, 20, 0, 280)
SpamButton.Size = UDim2.new(0.45, 0, 0, 50) -- Wider buttons
SpamButton.Font = Enum.Font.GothamBold
SpamButton.Text = "💥 SINGLE SPAM BURST"
SpamButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpamButton.TextScaled = true
SpamButton.BorderSizePixel = 0

local SpamCorner = Instance.new("UICorner")
SpamCorner.CornerRadius = UDim.new(0, 8)
SpamCorner.Parent = SpamButton

-- Toggle Button (bigger, side by side)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
ToggleButton.Position = UDim2.new(0.52, 0, 0, 280)
ToggleButton.Size = UDim2.new(0.45, -20, 0, 50)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "🔄 CONTINUOUS SPAM: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextScaled = true
ToggleButton.BorderSizePixel = 0

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleButton

-- Status Label (bigger, top center)
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
StatusLabel.Position = UDim2.new(0, 20, 0, 230)
StatusLabel.Size = UDim2.new(1, -40, 0, 40)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.Text = "👆 Click dropdown to see ALL players!"
StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
StatusLabel.TextScaled = true

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 8)
StatusCorner.Parent = StatusLabel

-- Variables
local SelectedPlayer = nil
local IsSpamming = false
local SpamConnection = nil
local PlayerList = {}

-- Update player list
local function UpdatePlayerList()
    PlayerList = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(PlayerList, player)
        end
    end
end

-- Create player buttons (bigger, clearer)
local function CreatePlayerButtons()
    for _, child in pairs(DropdownList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local buttonHeight = 35 -- Bigger buttons
    local totalHeight = #PlayerList * buttonHeight
    
    DropdownList.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 10)
    
    for i, player in pairs(PlayerList) do
        local PlayerBtn = Instance.new("TextButton")
        PlayerBtn.Name = player.Name
        PlayerBtn.Parent = DropdownList
        PlayerBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
        PlayerBtn.Position = UDim2.new(0, 10, 0, (i-1) * buttonHeight + 5)
        PlayerBtn.Size = UDim2.new(1, -20, 0, buttonHeight)
        PlayerBtn.Font = Enum.Font.GothamSemibold
        PlayerBtn.Text = "👤 " .. player.DisplayName .. "\n(" .. player.Name .. ")  •  " .. math.floor((player.Character and player.Character.HumanoidRootPart.Position.Magnitude)/10)/100 .. " studs away"
        PlayerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayerBtn.TextScaled = true
        PlayerBtn.TextYAlignment = Enum.TextYAlignment.Top
        PlayerBtn.BorderSizePixel = 0
        
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 6)
        BtnCorner.Parent = PlayerBtn
        
        -- Hover effect
        PlayerBtn.MouseButton1Click:Connect(function()
            SelectedPlayer = player
            DropdownButton.Text = "👤 " .. player.DisplayName .. " (" .. player.Name .. ")"
            DropdownList.Visible = false
            StatusLabel.Text = "🎯 TARGET LOCKED: " .. player.DisplayName
            StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 150)
        end)
    end
end

-- Execute single command
local function ExecuteCommand(targetPlayer, command)
    local args = {targetPlayer, command}
    pcall(function()
        RemotePath:FireServer(unpack(args))
    end)
end

-- Spam functions
local function StartSpam()
    if not SelectedPlayer or not SelectedPlayer.Parent then
        StatusLabel.Text = "❌ SELECT A VALID TARGET FIRST!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    IsSpamming = true
    ToggleButton.Text = "⏹️ CONTINUOUS SPAM: ON"
    ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    StatusLabel.Text = "🔥 RAPID-FIRING ALL COMMANDS ON " .. SelectedPlayer.DisplayName .. "!"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
    
    SpamConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not IsSpamming then return end
        if not SelectedPlayer or not SelectedPlayer.Parent then
            StopSpam()
            return
        end
        
        for _, command in pairs(COMMANDS) do
            ExecuteCommand(SelectedPlayer, command)
        end
    end)
end

local function StopSpam()
    IsSpamming = false
    if SpamConnection then
        SpamConnection:Disconnect()
        SpamConnection = nil
    end
    ToggleButton.Text = "🔄 CONTINUOUS SPAM: OFF"
    ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    StatusLabel.Text = SelectedPlayer and "⏸️ Spam stopped on " .. SelectedPlayer.DisplayName or "Ready!"
    StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
end

-- Button connections
DropdownButton.MouseButton1Click:Connect(function()
    DropdownList.Visible = not DropdownList.Visible
    if DropdownList.Visible then
        UpdatePlayerList()
        CreatePlayerButtons()
        StatusLabel.Text = "📋 " .. #PlayerList .. " players available!"
    end
end)

SpamButton.MouseButton1Click:Connect(function()
    if SelectedPlayer then
        for _, command in pairs(COMMANDS) do
            ExecuteCommand(SelectedPlayer, command)
        end
        StatusLabel.Text = "💥 SINGLE BURST sent to " .. SelectedPlayer.DisplayName .. "!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        StatusLabel.Text = "❌ SELECT A PLAYER FIRST!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    if IsSpamming then
        StopSpam()
    else
        StartSpam()
    end
end)

-- Player events
Players.PlayerRemoving:Connect(function(player)
    if SelectedPlayer == player then
        SelectedPlayer = nil
        DropdownButton.Text = "👤 CLICK TO SELECT PLAYER"
        StopSpam()
        StatusLabel.Text = "⚠️ TARGET LEFT SERVER!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    end
end)

Players.PlayerAdded:Connect(function()
    wait(1)
    UpdatePlayerList()
end)

-- Initial setup
UpdatePlayerList()
CreatePlayerButtons()

-- Enhanced hover effects
local function AddHover(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = normalColor}):Play()
    end)
end

AddHover(SpamButton, Color3.fromRGB(255, 80, 130), Color3.fromRGB(255, 50, 100))
AddHover(ToggleButton, Color3.fromRGB(70, 170, 70), Color3.fromRGB(50, 150, 50))
AddHover(DropdownButton.Parent, Color3.fromRGB(55, 55, 65), Color3.fromRGB(45, 45, 55))

print("🎯 Moni's BIG AP Spammer loaded! (450x350) - All names visible!")
