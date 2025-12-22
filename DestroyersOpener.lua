-- External scripts
loadstring(game:HttpGet("https://raw.githubusercontent.com/sabscripts063-cloud/Kdml-Not-Me/refs/heads/main/KdmlPvPV1.3"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DestroyersOpenerGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 60)
mainFrame.Position = UDim2.new(0.5, -125, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(135, 206, 250)
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 25)
titleLabel.Position = UDim2.new(0, 0, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Destroyers Opener"
titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 200, 0, 25)
toggleButton.Position = UDim2.new(0.5, -100, 1, -30)
toggleButton.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "Toggle Friends Access"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 14
toggleButton.Font = Enum.Font.GothamSemibold
toggleButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = toggleButton

local function toggleFriendsAccess()
    local success = pcall(function()
        ReplicatedStorage
            :WaitForChild("Packages")
            :WaitForChild("Net")
            :WaitForChild("RE/PlotService/ToggleFriends")
            :FireServer()
    end)

    if success then
        toggleButton.Text = "✓ Toggled!"
        toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
        task.wait(1)
    else
        toggleButton.Text = "✗ Failed!"
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(1)
    end

    toggleButton.Text = "Toggle Friends Access"
    toggleButton.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
end

toggleButton.MouseButton1Click:Connect(toggleFriendsAccess)

-- Dragging
local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
