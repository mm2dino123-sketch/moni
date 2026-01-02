-- Moni's Plot Opener UI v1.0
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

-- Main Toggle Button (Floating, draggable)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.Size = UDim2.new(0, 220, 0, 60)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "🏠 MONI'S PLOT OPENER\n🔒 CLOSED"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextScaled = true
ToggleButton.BorderSizePixel = 0

-- Corner rounding
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = ToggleButton

-- Stroke
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Thickness = 2
UIStroke.Parent = ToggleButton

-- Variables
local IsOpen = false

-- Toggle plot function
local function TogglePlot()
    -- Fire the remote twice (as in your original)
    ToggleRemote:FireServer()
    ToggleRemote:FireServer()
    
    -- Update UI state
    IsOpen = not IsOpen
    
    if IsOpen then
        ToggleButton.Text = "🏠 MONI'S PLOT OPENER\n✅ OPEN"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        print("✅ Plot OPENED!")
    else
        ToggleButton.Text = "🏠 MONI'S PLOT OPENER\n🔒 CLOSED"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
        print("🔒 Plot CLOSED!")
    end
end

-- Button click
ToggleButton.MouseButton1Click:Connect(TogglePlot)

-- Draggable functionality
local dragging = false
local dragStart = nil
local startPos = nil

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Hover effects
ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 230, 0, 65),
        BackgroundTransparency = 0.1
    }):Play()
end)

ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 220, 0, 60),
        BackgroundTransparency = 0
    }):Play()
end)

print("🎯 Moni's Plot Opener UI loaded! Drag anywhere, click to toggle!")
