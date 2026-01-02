-- Moni's Plot Opener UI v2.0 (Black + Neon Blue Edition)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remote path
local ToggleRemote = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/PlotService/ToggleFriends")

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MonisPlotOpener"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Main Toggle Button (Black + Blue)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(10, 10, 20) -- black base
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.Size = UDim2.new(0, 240, 0, 70)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "🏠 MONI'S PLOT OPENER\n🔒 CLOSED"
ToggleButton.TextColor3 = Color3.fromRGB(0, 170, 255) -- neon blue text
ToggleButton.TextScaled = true
ToggleButton.BorderSizePixel = 0

-- Corner rounding
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 12)

-- Neon Blue Stroke
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Thickness = 2
UIStroke.Transparency = 0.25
UIStroke.Parent = ToggleButton

-- Pulse animation
task.spawn(function()
    while ToggleButton.Parent do
        TweenService:Create(UIStroke, TweenInfo.new(0.6), {Transparency = 0.6}):Play()
        task.wait(0.6)
        TweenService:Create(UIStroke, TweenInfo.new(0.6), {Transparency = 0.2}):Play()
        task.wait(0.6)
    end
end)

-- Variables
local IsOpen = false

-- Toggle plot function
local function TogglePlot()
    ToggleRemote:FireServer()
    ToggleRemote:FireServer()

    IsOpen = not IsOpen

    if IsOpen then
        ToggleButton.Text = "🏠 MONI'S PLOT OPENER\n✅ OPEN"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 60) -- green open
        ToggleButton.TextColor3 = Color3.fromRGB(200, 255, 200)
    else
        ToggleButton.Text = "🏠 MONI'S PLOT OPENER\n🔒 CLOSED"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(10, 10, 20) -- black closed
        ToggleButton.TextColor3 = Color3.fromRGB(0, 170, 255)
    end
end

ToggleButton.MouseButton1Click:Connect(TogglePlot)

-- Smooth Draggable System
local dragging = false
local dragStart, startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    ToggleButton.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position
        ToggleButton.BackgroundTransparency = 0.1
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateDrag(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        ToggleButton.BackgroundTransparency = 0
    end
end)

-- Hover effects (Blue glow expand)
ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 250, 0, 75),
        BackgroundTransparency = 0.05
    }):Play()
end)

ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 240, 0, 70),
        BackgroundTransparency = 0
    }):Play()
end)

print("🎯 Moni's Plot Opener UI v2.0 (Black + Neon Blue Edition) Loaded!")
