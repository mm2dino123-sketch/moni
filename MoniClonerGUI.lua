-- MoniCloner GUI + Keybind (Cool Version)
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local activated = false

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MoniClonerGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Create Button
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 55, 0, 55)
button.Position = UDim2.new(0, 15, 0.5, -27)
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Text = "V"
button.Font = Enum.Font.GothamBold
button.TextSize = 22
button.BorderSizePixel = 0
button.AutoButtonColor = false
button.Parent = gui

-- Round corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = button

-- Hover animation
local hoverTween = TweenService:Create(button, TweenInfo.new(0.15), {
    BackgroundColor3 = Color3.fromRGB(70, 70, 70)
})

local unhoverTween = TweenService:Create(button, TweenInfo.new(0.15), {
    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
})

button.MouseEnter:Connect(function()
    if not activated then hoverTween:Play() end
end)

button.MouseLeave:Connect(function()
    if not activated then unhoverTween:Play() end
end)

-- Click animation
button.MouseButton1Down:Connect(function()
    button.Size = UDim2.new(0, 52, 0, 52)
end)

button.MouseButton1Up:Connect(function()
    button.Size = UDim2.new(0, 55, 0, 55)
end)

-- Make draggable
local dragging = false
local dragStart, startPos

button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = button.Position
    end
end)

button.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        button.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Activation function
local function activateCloner()
    if activated then return end
    activated = true
    print("MoniCloner activated")

    -- Glow effect on activation
    TweenService:Create(button, TweenInfo.new(0.25), {
        BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    }):Play()

    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/mm2dino123-sketch/moni/main/MoniCloner.lua"))()
    end)

    if not success then
        warn("MoniCloner failed to load:", err)
    end
end

-- Button click
button.MouseButton1Click:Connect(activateCloner)

-- V key press
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or activated then return end
    if input.KeyCode == Enum.KeyCode.V then
        activateCloner()
    end
end)
