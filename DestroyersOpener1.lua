-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Load external script ONCE
loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()

-------------------------------------------------
-- DESTROYERS OPENER GUI
-------------------------------------------------
local openerGui = Instance.new("ScreenGui")
openerGui.Name = "DestroyersOpenerGui"
openerGui.ResetOnSpawn = false
openerGui.Parent = playerGui

local openerFrame = Instance.new("Frame")
openerFrame.Size = UDim2.new(0, 250, 0, 60)
openerFrame.Position = UDim2.new(0.5, -125, 0, 10)
openerFrame.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
openerFrame.BorderSizePixel = 2
openerFrame.BorderColor3 = Color3.fromRGB(135, 206, 250)
openerFrame.Parent = openerGui

Instance.new("UICorner", openerFrame).CornerRadius = UDim.new(0, 8)

local openerTitle = Instance.new("TextLabel")
openerTitle.Size = UDim2.new(1, 0, 0, 25)
openerTitle.Position = UDim2.new(0, 0, 0, 5)
openerTitle.BackgroundTransparency = 1
openerTitle.Text = "Destroyers Opener"
openerTitle.TextSize = 16
openerTitle.Font = Enum.Font.GothamBold
openerTitle.TextColor3 = Color3.new(0, 0, 0)
openerTitle.Parent = openerFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 200, 0, 25)
toggleButton.Position = UDim2.new(0.5, -100, 1, -30)
toggleButton.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
toggleButton.Text = "Toggle Friends Access"
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.TextSize = 14
toggleButton.Font = Enum.Font.GothamSemibold
toggleButton.Parent = openerFrame

Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 6)

toggleButton.MouseButton1Click:Connect(function()
    local success = pcall(function()
        ReplicatedStorage
            :WaitForChild("Packages")
            :WaitForChild("Net")
            :WaitForChild("RE/PlotService/ToggleFriends")
            :FireServer()
    end)

    toggleButton.Text = success and "✓ Toggled!" or "✗ Failed!"
    toggleButton.BackgroundColor3 = success and Color3.fromRGB(50,200,100) or Color3.fromRGB(255,100,100)

    task.wait(1)
    toggleButton.Text = "Toggle Friends Access"
    toggleButton.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
end)

-- Dragging for opener GUI
local dragging, dragStart, startPos
openerFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = openerFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        openerFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-------------------------------------------------
-- FLOOR UNLOCKER GUI
-------------------------------------------------
local floorGui = Instance.new("ScreenGui")
floorGui.Name = "FloorUnlockerGUI"
floorGui.ResetOnSpawn = false
floorGui.Parent = playerGui

local floorFrame = Instance.new("Frame")
floorFrame.Size = UDim2.new(0, 200, 0, 180)
floorFrame.Position = UDim2.new(1, -210, 0, 10)
floorFrame.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
floorFrame.BorderSizePixel = 2
floorFrame.BorderColor3 = Color3.fromRGB(100, 150, 200)
floorFrame.Parent = floorGui

local floorTitle = Instance.new("TextLabel")
floorTitle.Size = UDim2.new(1, 0, 0, 40)
floorTitle.BackgroundColor3 = Color3.fromRGB(135, 206, 250)
floorTitle.Text = "Floor Unlocker"
floorTitle.TextColor3 = Color3.new(1, 1, 1)
floorTitle.TextSize = 18
floorTitle.Font = Enum.Font.SourceSansBold
floorTitle.Parent = floorFrame

local function createFloorButton(text, yPos, floorId)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 180, 0, 35)
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    button.Text = "Unlock Floor " .. text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 16
    button.Font = Enum.Font.SourceSansBold
    button.Parent = floorFrame

    button.MouseButton1Click:Connect(function()
        ReplicatedStorage
            :WaitForChild("Packages")
            :WaitForChild("Net")
            :WaitForChild("RE/ShopService/Purchase")
            :FireServer(floorId, 6142281814)
    end)
end

createFloorButton("1", 50, 3312023518)
createFloorButton("2", 95, 3312023590)
createFloorButton("3", 140, 3312023715)
