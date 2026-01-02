--// Moni's Hub v4.0 (DISCORD KEY + TARGETED AP SPAMMER)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- HIDDEN KEY SYSTEM (Discord invite only)
local KEY = "GVbJZWW2YR"
local guiUnlocked = false
local keyInput = ""

-- MAIN GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MonisHub"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

-- DISCORD KEY FRAME
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 350, 0, 220)
keyFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = gui

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 15)
keyCorner.Parent = keyFrame

local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(88, 101, 242)
keyStroke.Thickness = 3
keyStroke.Parent = keyFrame

-- Discord Title
local discordTitle = Instance.new("TextLabel")
discordTitle.Size = UDim2.new(1, 0, 0, 50)
discordTitle.Position = UDim2.new(0, 0, 0, 10)
discordTitle.BackgroundTransparency = 1
discordTitle.Text = "🔐 MONI'S HUB - DISCORD EXCLUSIVE 🔐"
discordTitle.TextColor3 = Color3.fromRGB(88, 101, 242)
discordTitle.TextScaled = true
discordTitle.Font = Enum.Font.GothamBold
discordTitle.Parent = keyFrame

-- Discord Invite Button
local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(0.9, 0, 0, 40)
discordBtn.Position = UDim2.new(0.05, 0, 0, 65)
discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
discordBtn.Text = "📱 JOIN DISCORD FOR KEY\nhttps://discord.gg/GVbJZWW2YR"
discordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
discordBtn.TextScaled = true
discordBtn.Font = Enum.Font.GothamBold
discordBtn.Parent = keyFrame

local discordCorner = Instance.new("UICorner")
discordCorner.CornerRadius = UDim.new(0, 12)
discordCorner.Parent = discordBtn

-- Key Input Box (Hidden key)
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.9, 0, 0, 35)
keyBox.Position = UDim2.new(0.05, 0, 0, 115)
keyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
keyBox.Text = ""
keyBox.PlaceholderText = "🔑 Get key from Discord (9 chars)"
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
keyBox.TextScaled = true
keyBox.Font = Enum.Font.GothamSemibold
keyBox.Parent = keyFrame

local keyBoxCorner = Instance.new("UICorner")
keyBoxCorner.CornerRadius = UDim.new(0, 10)
keyBoxCorner.Parent = keyBox

-- Unlock Button
local unlockBtn = Instance.new("TextButton")
unlockBtn.Size = UDim2.new(0.9, 0, 0, 35)
unlockBtn.Position = UDim2.new(0.05, 0, 0, 165)
unlockBtn.BackgroundColor3 = Color3.fromRGB(40, 163, 40)
unlockBtn.Text = "🚀 UNLOCK PREMIUM HUB"
unlockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
unlockBtn.TextScaled = true
unlockBtn.Font = Enum.Font.GothamBold
unlockBtn.Parent = keyFrame

local unlockCorner = Instance.new("UICorner")
unlockCorner.CornerRadius = UDim.new(0, 10)
unlockCorner.Parent = unlockBtn

-- MAIN HUB FRAME
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 380)
mainFrame.Position = UDim2.new(0, 20, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(88, 101, 242)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

-- Hub Title
local hubTitle = Instance.new("TextLabel")
hubTitle.Size = UDim2.new(1, 0, 0, 45)
hubTitle.Position = UDim2.new(0, 0, 0, 10)
hubTitle.BackgroundTransparency = 1
hubTitle.Text = "🎯 MONI'S PREMIUM HUB v4.0"
hubTitle.TextColor3 = Color3.fromRGB(88, 101, 242)
hubTitle.TextScaled = true
hubTitle.Font = Enum.Font.GothamBold
hubTitle.Parent = mainFrame

-- AP SPAMMER TARGET SELECTOR
local targetFrame = Instance.new("Frame")
targetFrame.Size = UDim2.new(1, -20, 0, 60)
targetFrame.Position = UDim2.new(0, 10, 0, 65)
targetFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
targetFrame.BorderSizePixel = 0
targetFrame.Parent = mainFrame

local targetCorner = Instance.new("UICorner")
targetCorner.CornerRadius = UDim.new(0, 12)
targetCorner.Parent = targetFrame

local targetLabel = Instance.new("TextLabel")
targetLabel.Size = UDim2.new(0.6, 0, 1, 0)
targetLabel.Position = UDim2.new(0, 10, 0, 0)
targetLabel.BackgroundTransparency = 1
targetLabel.Text = "🎯 Target: NONE"
targetLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
targetLabel.TextScaled = true
targetLabel.Font = Enum.Font.GothamSemibold
targetLabel.TextXAlignment = Enum.TextXAlignment.Left
targetLabel.Parent = targetFrame

local targetDropBtn = Instance.new("TextButton")
targetDropBtn.Size = UDim2.new(0.35, -10, 0.8, 0)
targetDropBtn.Position = UDim2.new(0.62, 0, 0.1, 0)
targetDropBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
targetDropBtn.Text = "📋 SELECT"
targetDropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
targetDropBtn.TextScaled = true
targetDropBtn.Font = Enum.Font.GothamBold
targetDropBtn.Parent = targetFrame

local dropCorner = Instance.new("UICorner")
dropCorner.CornerRadius = UDim.new(0, 8)
dropCorner.Parent = targetDropBtn

-- TARGET DROPDOWN
local dropdownFrame = Instance.new("Frame")
dropdownFrame.Size = UDim2.new(1, -20, 0, 180)
dropdownFrame.Position = UDim2.new(0, 10, 0, 130)
dropdownFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
dropdownFrame.BorderSizePixel = 0
dropdownFrame.Visible = false
dropdownFrame.Parent = mainFrame

local dropdownCorner = Instance.new("UICorner")
dropdownCorner.CornerRadius = UDim.new(0, 12)
dropdownCorner.Parent = dropdownFrame

local dropdownList = Instance.new("ScrollingFrame")
dropdownList.Size = UDim2.new(1, -10, 1, -10)
dropdownList.Position = UDim2.new(0, 5, 0, 5)
dropdownList.BackgroundTransparency = 1
dropdownList.BorderSizePixel = 0
dropdownList.ScrollBarThickness = 6
dropdownList.ScrollBarImageColor3 = Color3.fromRGB(88, 101, 242)
dropdownList.Parent = dropdownFrame

-- BUTTON CREATOR
local function createHubButton(text, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 45)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Text = text
    btn.BorderSizePixel = 0
    btn.Parent = mainFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- SERVICES
local ToggleRemote = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/PlotService/ToggleFriends")
local apRemote = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/AdminPanelService/ExecuteCommand")
local apCommands = {"ragdoll", "rocket", "balloon", "inverse", "jail"}

-- FUNCTIONS
local plotToggled = false
local espEnabled = false
local highlights = {}
local selectedTarget = nil

local function togglePlot() 
    ToggleRemote:FireServer()
    ToggleRemote:FireServer()
    plotToggled = not plotToggled
    print("🏠 Plot " .. (plotToggled and "OPENED" or "CLOSED"))
end

local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(0, 255, 255)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.4
                highlight.Parent = player.Character
                highlights[player] = highlight
            end
        end
    else
        for player, highlight in pairs(highlights) do
            if highlight then highlight:Destroy() end
        end
        highlights = {}
    end
    print("✨ ESP " .. (espEnabled and "ON" or "OFF"))
end

local function spamTarget(target)
    if not target or not target.Parent then return end
    for _, cmd in pairs(apCommands) do
        pcall(function()
            apRemote:FireServer(target, cmd)
        end)
    end
    print("🎯 SPAMMED " .. target.DisplayName)
end

local function updatePlayerList()
    for _, child in pairs(dropdownList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local players = Players:GetPlayers()
    local yPos = 0
    
    for i, player in pairs(players) do
        if player ~= LocalPlayer then
            local playerBtn = Instance.new("TextButton")
            playerBtn.Size = UDim2.new(1, -10, 0, 35)
            playerBtn.Position = UDim2.new(0, 5, 0, yPos)
            playerBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            playerBtn.Text = "👤 " .. player.DisplayName .. " (" .. player.Name .. ")"
            playerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerBtn.TextScaled = true
            playerBtn.Font = Enum.Font.Gotham
            playerBtn.BorderSizePixel = 0
            playerBtn.Parent = dropdownList
            
            local pCorner = Instance.new("UICorner")
            pCorner.CornerRadius = UDim.new(0, 8)
            pCorner.Parent = playerBtn
            
            playerBtn.MouseButton1Click:Connect(function()
                selectedTarget = player
                targetLabel.Text = "🎯 Target: " .. player.DisplayName
                dropdownFrame.Visible = false
                print("🎯 Selected target: " .. player.DisplayName)
            end)
            
            yPos = yPos + 40
        end
    end
    
    dropdownList.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- CREATE BUTTONS
local plotBtn = createHubButton("🏠 Toggle Plot Opener", 320, togglePlot)
local espBtn = createHubButton("✨ Toggle Player ESP", 375, toggleESP)
local spamBtn = createHubButton("💥 SPAM SELECTED TARGET (ONCE)", 275, function()
    if selectedTarget then
        spamTarget(selectedTarget)
        targetLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        wait(0.5)
        targetLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        print("❌ No target selected!")
    end
end)

-- KEY SYSTEM
unlockBtn.MouseButton1Click:Connect(function()
    if keyInput == KEY then
        guiUnlocked = true
        keyFrame:Destroy()
        mainFrame.Visible = true
        TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(0, 20, 0.5, -190)}):Play()
        print("✅ PREMIUM HUB UNLOCKED!")
    else
        keyBox.Text = ""
        TweenService:Create(keyStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 100, 100)}):Play()
        wait(1)
        TweenService:Create(keyStroke, TweenInfo.new(0.5), {Color = Color3.fromRGB(88, 101, 242)}):Play()
    end
end)

keyBox.FocusLost:Connect(function() keyInput = keyBox.Text end)

-- TARGET SYSTEM
targetDropBtn.MouseButton1Click:Connect(function()
    dropdownFrame.Visible = not dropdownFrame.Visible
    if dropdownFrame.Visible then
        updatePlayerList()
    end
end)

-- PLAYER EVENTS
Players.PlayerAdded:Connect(function()
    wait(1)
    if dropdownFrame.Visible then updatePlayerList() end
end)

Players.PlayerRemoving:Connect(function(player)
    if selectedTarget == player then
        selectedTarget = nil
        targetLabel.Text = "🎯 Target: NONE"
    end
end)

-- HUB TOGGLE (Right Shift)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift and guiUnlocked then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- DRAGGING
local dragging, dragStart, startPos
local function setupDragging(frame)
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    frame.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

setupDragging(keyFrame)
setupDragging(mainFrame)

-- HOVER EFFECTS
local hoverEffects = {
    {discordBtn, Color3.fromRGB(100, 120, 255)},
    {unlockBtn, Color3.fromRGB(60, 200, 60)},
    {targetDropBtn, Color3.fromRGB(255, 80, 130)},
    {plotBtn, Color3.fromRGB(0, 150, 255)},
    {espBtn, Color3.fromRGB(255, 200, 0)},
    {spamBtn, Color3.fromRGB(255, 80, 80)}
}

for _, effect in pairs(hoverEffects) do
    local btn, color = effect[1], effect[2]
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = btn == discordBtn and Color3.fromRGB(88,101,242) or 
                             btn == unlockBtn and Color3.fromRGB(40,163,40) or 
                             btn == targetDropBtn and Color3.fromRGB(255,50,100) or
                             Color3.fromRGB(40,40,55)
        }):Play()
    end)
end

print("🎯 MONI'S PREMIUM HUB v4.0 LOADED!")
print("🔗 Discord: https://discord.gg/GVbJZWW2YR")
print("⌨️ Toggle: Right Shift")
