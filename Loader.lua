--// Moni's Hub - Brainrot Script
--// Made for Dino

--========================--
-- CONFIG
--========================--

local CONFIG = {
    Key = "MONI-1234-KEY", -- change this; share it in your Discord
    KeyAttempts = 3,
    BrainrotStealDistance = 15, -- studs
    WalkSpeedBoost = 30,
    JumpPowerBoost = 80,
    GravityBoost = 50, -- lower = more floaty
}

--========================--
-- SERVICES
--========================--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Workspace = game:GetService("Workspace")

--========================--
-- UTIL
--========================--

local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3
        })
    end)
end

local function getCharacter()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Humanoid") then
        Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        Humanoid = Character:WaitForChild("Humanoid")
    end
    return Character, Humanoid
end

--========================--
-- KEY SYSTEM UI
--========================--

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MonisHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 300, 0, 150)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", KeyFrame)
UICorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "Moni's Hub - Key"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = KeyFrame

local Info = Instance.new("TextLabel")
Info.Name = "Info"
Info.Size = UDim2.new(1, -20, 0, 40)
Info.Position = UDim2.new(0, 10, 0, 30)
Info.BackgroundTransparency = 1
Info.Text = "Get the key from Moni's Discord."
Info.TextWrapped = true
Info.TextColor3 = Color3.fromRGB(200, 200, 200)
Info.Font = Enum.Font.Gotham
Info.TextSize = 14
Info.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Name = "KeyBox"
KeyBox.Size = UDim2.new(1, -20, 0, 30)
KeyBox.Position = UDim2.new(0, 10, 0, 75)
KeyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "Enter key here..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = KeyFrame
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 6)

local Submit = Instance.new("TextButton")
Submit.Name = "Submit"
Submit.Size = UDim2.new(0.5, -15, 0, 30)
Submit.Position = UDim2.new(0, 10, 0, 115)
Submit.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Submit.BorderSizePixel = 0
Submit.Text = "Unlock"
Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 14
Submit.Parent = KeyFrame
Instance.new("UICorner", Submit).CornerRadius = UDim.new(0, 6)

local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Name = "DiscordBtn"
DiscordBtn.Size = UDim2.new(0.5, -15, 0, 30)
DiscordBtn.Position = UDim2.new(0.5, 5, 0, 115)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
DiscordBtn.BorderSizePixel = 0
DiscordBtn.Text = "Copy Discord Link"
DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordBtn.Font = Enum.Font.Gotham
DiscordBtn.TextSize = 12
DiscordBtn.Parent = KeyFrame
Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0, 6)

-- put your real Discord invite here
local DISCORD_LINK = "https://discord.gg/yourserver"

DiscordBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_LINK)
        notify("Moni's Hub", "Discord invite copied!", 3)
    else
        notify("Moni's Hub", "Executor does not support setclipboard.", 4)
    end
end)

local attempts = 0
local unlocked = false

local function handleKeySubmit()
    attempts += 1
    if KeyBox.Text == CONFIG.Key then
        unlocked = true
        notify("Moni's Hub", "Key accepted. Welcome!", 3)
        KeyFrame:Destroy()
    else
        notify("Moni's Hub", "Wrong key. Try again.", 3)
        if attempts >= CONFIG.KeyAttempts then
            notify("Moni's Hub", "Too many wrong attempts.", 4)
            ScreenGui:Destroy()
        end
    end
end

Submit.MouseButton1Click:Connect(handleKeySubmit)

-- wait until unlocked or UI destroyed
while not unlocked and ScreenGui.Parent do
    RunService.RenderStepped:Wait()
end

if not unlocked then
    return
end

--========================--
-- MAIN HUB UI
--========================--

local HubFrame = Instance.new("Frame")
HubFrame.Name = "HubFrame"
HubFrame.Size = UDim2.new(0, 400, 0, 250)
HubFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
HubFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
HubFrame.BorderSizePixel = 0
HubFrame.Active = true
HubFrame.Draggable = true
HubFrame.Parent = ScreenGui
Instance.new("UICorner", HubFrame).CornerRadius = UDim.new(0, 10)

local HubTitle = Instance.new("TextLabel")
HubTitle.Name = "HubTitle"
HubTitle.Size = UDim2.new(1, 0, 0, 35)
HubTitle.BackgroundTransparency = 1
HubTitle.Text = "Moni's Hub - Brainrot"
HubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HubTitle.Font = Enum.Font.GothamBold
HubTitle.TextSize = 18
HubTitle.Parent = HubFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.Parent = HubFrame

CloseBtn.MouseButton1Click:Connect(function()
    HubFrame.Visible = not HubFrame.Visible
end)

-- Toggle with RightControl too
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        HubFrame.Visible = not HubFrame.Visible
    end
end)

-- LEFT SIDE SECTION TITLE
local SectionTitle = Instance.new("TextLabel")
SectionTitle.Name = "SectionTitle"
SectionTitle.Size = UDim2.new(1, -20, 0, 20)
SectionTitle.Position = UDim2.new(0, 10, 0, 40)
SectionTitle.BackgroundTransparency = 1
SectionTitle.Text = "Main"
SectionTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
SectionTitle.Font = Enum.Font.GothamBold
SectionTitle.TextSize = 14
SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
SectionTitle.Parent = HubFrame

-- CONTAINER
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -20, 1, -70)
Content.Position = UDim2.new(0, 10, 0, 60)
Content.BackgroundTransparency = 1
Content.Parent = HubFrame

local UIListLayout = Instance.new("UIListLayout", Content)
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function createToggle(name, default, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Name = name
    Toggle.Size = UDim2.new(0, 180, 0, 30)
    Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Toggle.BorderSizePixel = 0
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Font = Enum.Font.Gotham
    Toggle.TextSize = 14
    Toggle.TextXAlignment = Enum.TextXAlignment.Left
    Toggle.Parent = Content
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 6)

    local state = default or false
    local function updateText()
        Toggle.Text = name .. " : " .. (state and "ON" or "OFF")
        Toggle.BackgroundColor3 = state and Color3.fromRGB(0, 170, 80) or Color3.fromRGB(30, 30, 30)
    end
    updateText()

    Toggle.MouseButton1Click:Connect(function()
        state = not state
        updateText()
        callback(state)
    end)

    return function(v)
        state = v
        updateText()
        callback(state)
    end
end

local function createButton(name, callback)
    local Btn = Instance.new("TextButton")
    Btn.Name = name
    Btn.Size = UDim2.new(0, 180, 0, 30)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Btn.BorderSizePixel = 0
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 14
    Btn.Text = name
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Parent = Content
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    Btn.MouseButton1Click:Connect(callback)
end

--========================--
-- AUTO BRAINROT STEAL
--========================--

-- YOU must configure this:
-- 1) Find where the "brainrot" objects live (folder/part names)
-- 2) Adjust the logic below to match that game

local AutoStealEnabled = false

-- EXAMPLE: assume brainrot items are parts in Workspace.Brainrots
local function getClosestBrainrot(maxDistance)
    local closest, closestDist
    local char, hum = getCharacter()
    if not char or not hum.RootPart then return end

    local root = hum.RootPart
    local folder = Workspace:FindFirstChild("Brainrots") -- change this to actual folder
    if not folder then return end

    for _, obj in ipairs(folder:GetChildren()) do
        if obj:IsA("BasePart") then
            local dist = (obj.Position - root.Position).Magnitude
            if dist <= maxDistance and (not closestDist or dist < closestDist) then
                closest = obj
                closestDist = dist
            end
        end
    end

    return closest
end

-- EXAMPLE: fire a remote to "steal" brainrot
-- You MUST replace this with the actual RemoteEvent/Function name
local function stealBrainrot(target)
    --[[ EXAMPLE TEMPLATE:
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local remote = ReplicatedStorage:WaitForChild("StealBrainrot")
    remote:FireServer(target)
    ]]
    -- For now we just TP to it as a placeholder
    local char, hum = getCharacter()
    if char and hum.RootPart and target then
        hum.RootPart.CFrame = target.CFrame + Vector3.new(0, 3, 0)
    end
end

RunService.RenderStepped:Connect(function()
    if AutoStealEnabled then
        local target = getClosestBrainrot(CONFIG.BrainrotStealDistance)
        if target then
            stealBrainrot(target)
        end
    end
end)

--========================--
-- AUTO CLONER
--========================--

local AutoClonerEnabled = false

local function autoCloneStep()
    if not AutoClonerEnabled then return end

    --[[ TEMPLATE:
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local cloneRemote = ReplicatedStorage:WaitForChild("CloneBrainrot")
    cloneRemote:FireServer()
    ]]

    -- placeholder: just notify every second
    notify("Moni's Hub", "Auto Cloner tick", 1)
end

task.spawn(function()
    while true do
        if AutoClonerEnabled then
            autoCloneStep()
        end
        task.wait(1)
    end
end)

--========================--
-- MOVEMENT BOOSTS
--========================--

local SpeedBoostEnabled = false
local JumpBoostEnabled = false
local GravityBoostEnabled = false

local Original = {
    WalkSpeed = Humanoid.WalkSpeed,
    JumpPower = Humanoid.JumpPower,
    Gravity = Workspace.Gravity,
}

local function applyMovement()
    local char, hum = getCharacter()
    if not hum then return end

    hum.WalkSpeed = SpeedBoostEnabled and CONFIG.WalkSpeedBoost or Original.WalkSpeed
    hum.JumpPower = JumpBoostEnabled and CONFIG.JumpPowerBoost or Original.JumpPower
    Workspace.Gravity = GravityBoostEnabled and CONFIG.GravityBoost or Original.Gravity
end

Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(applyMovement)
Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(applyMovement)

--========================--
-- HOOK TOGGLE UI
--========================--

createToggle("Auto Brainrot Steal", false, function(state)
    AutoStealEnabled = state
end)

createToggle("Auto Cloner", false, function(state)
    AutoClonerEnabled = state
end)

createToggle("Speed Boost", false, function(state)
    SpeedBoostEnabled = state
    applyMovement()
end)

createToggle("Jump Boost", false, function(state)
    JumpBoostEnabled = state
    applyMovement()
end)

createToggle("Low Gravity", false, function(state)
    GravityBoostEnabled = state
    applyMovement()
end)

createButton("Reset Movement", function()
    SpeedBoostEnabled = false
    JumpBoostEnabled = false
    GravityBoostEnabled = false
    applyMovement()
    notify("Moni's Hub", "Movement reset.", 3)
end)

notify("Moni's Hub", "Loaded successfully. Press RightControl to toggle UI.", 5)
local function safeLoad(url)
    local ok, res = pcall(function()
        return game:HttpGet(url)
    end)

    if not ok then
        warn("[Moni's Hub] Failed to get script:", res)
        return
    end

    local fn, err = loadstring(res)
    if not fn then
        warn("[Moni's Hub] Failed to compile:", err)
        return
    end

    fn()
end

-- change this to your raw Main.lua URL
safeLoad("https://raw.githubusercontent.com/mm2dino123-sketch/main/moni/Main.lua")
