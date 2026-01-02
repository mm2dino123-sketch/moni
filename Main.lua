--// Moni's Hub - Full UI Package
--// Hybrid Chilli + Neon style
--// UI ONLY — you attach your own game logic to callbacks

-------------------------------
-- CONFIG
-------------------------------

local CONFIG = {
    Key = "MONI-1234-KEY", -- change this and share in your Discord
    KeyAttempts = 3,
    DiscordInvite = "https://discord.gg/W9PzGBUkcG",
}

-------------------------------
-- SERVICES
-------------------------------

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local UIS = game:GetService("UserInputService")

-------------------------------
-- UTIL
-------------------------------

local function notify(title, text, duration)
    task.spawn(function()
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = title,
                Text = text,
                Duration = duration or 3
            })
        end)
    end)
end

local function tween(obj, props, time)
    local ts = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(time or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    ts:Create(obj, tweenInfo, props):Play()
end

-------------------------------
-- ROOT GUI
-------------------------------

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MonisHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-------------------------------
-- MH TOGGLE BUTTON (DRAGGABLE)
-------------------------------

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0, 150)
ToggleButton.BackgroundColor3 = Color3.fromRGB(8, 10, 25)
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "MH"
ToggleButton.TextColor3 = Color3.fromRGB(0, 220, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 16
ToggleButton.Parent = ScreenGui
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleButton)
ToggleStroke.Thickness = 1.3
ToggleStroke.Color = Color3.fromRGB(0, 170, 255)
ToggleStroke.Transparency = 0.2

-- subtle pulsing
task.spawn(function()
    while ToggleButton.Parent do
        tween(ToggleStroke, {Transparency = 0.5}, 0.7)
        task.wait(0.7)
        tween(ToggleStroke, {Transparency = 0.2}, 0.7)
        task.wait(0.7)
    end
end)

-- draggable logic
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
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        updateDrag(input)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-------------------------------
-- KEY SYSTEM UI
-------------------------------

local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 320, 0, 190)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -95)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 10)

local KFStroke = Instance.new("UIStroke", KeyFrame)
KFStroke.Thickness = 1.5
KFStroke.Color = Color3.fromRGB(0, 170, 255)
KFStroke.Transparency = 0.3

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Name = "KeyTitle"
KeyTitle.Size = UDim2.new(1, -20, 0, 30)
KeyTitle.Position = UDim2.new(0, 10, 0, 8)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "Moni's Hub - Access"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 20
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.Parent = KeyFrame

local KeyUnderline = Instance.new("Frame")
KeyUnderline.Size = UDim2.new(1, -20, 0, 1)
KeyUnderline.Position = UDim2.new(0, 10, 0, 38)
KeyUnderline.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
KeyUnderline.BorderSizePixel = 0
KeyUnderline.Parent = KeyFrame

local Info = Instance.new("TextLabel")
Info.Name = "Info"
Info.Size = UDim2.new(1, -20, 0, 40)
Info.Position = UDim2.new(0, 10, 0, 45)
Info.BackgroundTransparency = 1
Info.Text = "Get the key from Moni's Hub Discord."
Info.TextWrapped = true
Info.TextColor3 = Color3.fromRGB(200, 200, 200)
Info.Font = Enum.Font.Gotham
Info.TextSize = 14
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Name = "KeyBox"
KeyBox.Size = UDim2.new(1, -20, 0, 30)
KeyBox.Position = UDim2.new(0, 10, 0, 90)
KeyBox.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
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
Submit.Size = UDim2.new(0.5, -15, 0, 32)
Submit.Position = UDim2.new(0, 10, 0, 135)
Submit.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Submit.BorderSizePixel = 0
Submit.Text = "Unlock"
Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 15
Submit.Parent = KeyFrame
Instance.new("UICorner", Submit).CornerRadius = UDim.new(0, 6)

local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Name = "DiscordBtn"
DiscordBtn.Size = UDim2.new(0.5, -15, 0, 32)
DiscordBtn.Position = UDim2.new(0.5, 5, 0, 135)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
DiscordBtn.BorderSizePixel = 0
DiscordBtn.Text = "Copy Discord Link"
DiscordBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
DiscordBtn.Font = Enum.Font.Gotham
DiscordBtn.TextSize = 13
DiscordBtn.Parent = KeyFrame
Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0, 6)

DiscordBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(CONFIG.DiscordInvite)
        notify("Moni's Hub", "Discord invite copied to clipboard.", 3)
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
        notify("Moni's Hub", "Key accepted. Welcome to Moni's Hub.", 3)
        tween(KeyFrame, {Size = UDim2.new(0, 320, 0, 0), BackgroundTransparency = 1}, 0.2)
        task.wait(0.2)
        KeyFrame:Destroy()
    else
        notify("Moni's Hub", "Wrong key. Try again.", 3)
        if attempts >= CONFIG.KeyAttempts then
            notify("Moni's Hub", "Too many failed attempts. Closing.", 4)
            ScreenGui:Destroy()
        end
    end
end

Submit.MouseButton1Click:Connect(handleKeySubmit)

while not unlocked and ScreenGui.Parent do
    RunService.RenderStepped:Wait()
end

if not unlocked then
    return
end

-------------------------------
-- MAIN HUB + TABS
-------------------------------

local HubFrame = Instance.new("Frame")
HubFrame.Name = "HubFrame"
HubFrame.Size = UDim2.new(0, 520, 0, 300)
HubFrame.Position = UDim2.new(0.5, -260, 0.5, -150)
HubFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 15)
HubFrame.BorderSizePixel = 0
HubFrame.Active = true
HubFrame.Draggable = true
HubFrame.Parent = ScreenGui
Instance.new("UICorner", HubFrame).CornerRadius = UDim.new(0, 10)

local HubStroke = Instance.new("UIStroke", HubFrame)
HubStroke.Thickness = 1.5
HubStroke.Color = Color3.fromRGB(0, 170, 255)
HubStroke.Transparency = 0.4

local HubTitle = Instance.new("TextLabel")
HubTitle.Name = "HubTitle"
HubTitle.Size = UDim2.new(1, -40, 0, 32)
HubTitle.Position = UDim2.new(0, 10, 0, 6)
HubTitle.BackgroundTransparency = 1
HubTitle.Text = "Moni's Hub  |  Steal a Brainrot"
HubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HubTitle.Font = Enum.Font.GothamBold
HubTitle.TextSize = 18
HubTitle.TextXAlignment = Enum.TextXAlignment.Left
HubTitle.Parent = HubFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -32, 0, 8)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.Parent = HubFrame

CloseBtn.MouseButton1Click:Connect(function()
    HubFrame.Visible = not HubFrame.Visible
end)

-- LeftControl toggle
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.LeftControl then
        HubFrame.Visible = not HubFrame.Visible
    end
end)

-- MH button toggles hub
ToggleButton.MouseButton1Click:Connect(function()
    HubFrame.Visible = not HubFrame.Visible
end)

local HeaderLine = Instance.new("Frame")
HeaderLine.Size = UDim2.new(1, -20, 0, 1)
HeaderLine.Position = UDim2.new(0, 10, 0, 40)
HeaderLine.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
HeaderLine.BorderSizePixel = 0
HeaderLine.Parent = HubFrame

-- Tabs frame (left)
local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Size = UDim2.new(0, 120, 1, -55)
TabsFrame.Position = UDim2.new(0, 10, 0, 50)
TabsFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
TabsFrame.BorderSizePixel = 0
TabsFrame.Parent = HubFrame
Instance.new("UICorner", TabsFrame).CornerRadius = UDim.new(0, 8)

local TabsLayout = Instance.new("UIListLayout", TabsFrame)
TabsLayout.Padding = UDim.new(0, 5)
TabsLayout.FillDirection = Enum.FillDirection.Vertical
TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabsLayout.VerticalAlignment = Enum.VerticalAlignment.Top
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Content frame (right)
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -150, 1, -55)
ContentFrame.Position = UDim2.new(0, 140, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = HubFrame

-------------------------------
-- TAB HELPERS
-------------------------------

local Tabs = {}
local Pages = {}
local CurrentTab

local function createTabButton(tabName)
    local Btn = Instance.new("TextButton")
    Btn.Name = tabName .. "Tab"
    Btn.Size = UDim2.new(1, -10, 0, 26)
    Btn.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
    Btn.BorderSizePixel = 0
    Btn.Text = tabName
    Btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 13
    Btn.Parent = TabsFrame
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    local Stroke = Instance.new("UIStroke", Btn)
    Stroke.Thickness = 1
    Stroke.Color = Color3.fromRGB(0, 0, 0)
    Stroke.Transparency = 0.8

    Tabs[tabName] = Btn
    return Btn
end

local function createPage(tabName)
    local Page = Instance.new("Frame")
    Page.Name = tabName .. "Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.Parent = ContentFrame

    local Layout = Instance.new("UIListLayout", Page)
    Layout.Padding = UDim.new(0, 8)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    Pages[tabName] = Page
    return Page
end

local function switchTab(tabName)
    for name, page in pairs(Pages) do
        page.Visible = (name == tabName)
    end
    for name, btn in pairs(Tabs) do
        if name == tabName then
            tween(btn, {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}, 0.15)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            tween(btn, {BackgroundColor3 = Color3.fromRGB(18, 18, 26)}, 0.15)
            btn.TextColor3 = Color3.fromRGB(200, 200, 220)
        end
    end
    CurrentTab = tabName
end

local function createSectionLabel(parent, text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(150, 150, 210)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = parent
end

local function createSmallInfo(parent, text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 32)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(185, 185, 220)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextWrapped = true
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = parent
end

local function createToggle(parent, name, default, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Name = name
    Toggle.Size = UDim2.new(0, 230, 0, 30)
    Toggle.BackgroundColor3 = Color3.fromRGB(16, 16, 26)
    Toggle.BorderSizePixel = 0
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Font = Enum.Font.Gotham
    Toggle.TextSize = 14
    Toggle.TextXAlignment = Enum.TextXAlignment.Left
    Toggle.Parent = parent
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 6)

    local state = default or false

    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 12, 0, 12)
    Indicator.Position = UDim2.new(1, -20, 0.5, -6)
    Indicator.BackgroundColor3 = state and Color3.fromRGB(0, 220, 140) or Color3.fromRGB(60, 60, 80)
    Indicator.BorderSizePixel = 0
    Indicator.Parent = Toggle
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

    local function update()
        Toggle.Text = name .. " : " .. (state and "ON" or "OFF")
        tween(Indicator, {BackgroundColor3 = state and Color3.fromRGB(0, 220, 140) or Color3.fromRGB(60, 60, 80)}, 0.15)
    end
    update()

    Toggle.MouseButton1Click:Connect(function()
        state = not state
        update()
        callback(state)
    end)

    return function(v)
        state = v
        update()
        callback(state)
    end
end

local function createButton(parent, name, callback)
    local Btn = Instance.new("TextButton")
    Btn.Name = name
    Btn.Size = UDim2.new(0, 230, 0, 30)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    Btn.BorderSizePixel = 0
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 14
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Text = name
    Btn.Parent = parent
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    Btn.MouseButton1Click:Connect(function()
        tween(Btn, {BackgroundColor3 = Color3.fromRGB(40, 40, 70)}, 0.08)
        task.delay(0.1, function()
            tween(Btn, {BackgroundColor3 = Color3.fromRGB(25, 25, 40)}, 0.08)
        end)
        callback()
    end)

    return Btn
end

local function createSlider(parent, name, minValue, maxValue, defaultValue, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = name .. "_Slider"
    SliderFrame.Size = UDim2.new(0, 230, 0, 42)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 18)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. tostring(defaultValue)
    Label.TextColor3 = Color3.fromRGB(200, 200, 230)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1, 0, 0, 6)
    Bar.Position = UDim2.new(0, 0, 0, 22)
    Bar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    Bar.BorderSizePixel = 0
    Bar.Parent = SliderFrame
    Instance.new("UICorner", Bar).CornerRadius = UDim.new(0, 3)

    local relDefault = (defaultValue - minValue) / (maxValue - minValue)
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(relDefault, 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    Fill.BorderSizePixel = 0
    Fill.Parent = Bar
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(0, 3)

    local draggingSlider = false

    local function setValueFromX(x)
        local rel = math.clamp((x - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        local value = math.floor(minValue + (maxValue - minValue) * rel)
        Fill.Size = UDim2.new(rel, 0, 1, 0)
        Label.Text = name .. ": " .. tostring(value)
        callback(value)
    end

    Bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSlider = true
            setValueFromX(input.Position.X)
        end
    end)

    Bar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and draggingSlider then
            setValueFromX(input.Position.X)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSlider = false
        end
    end)

    return SliderFrame
end

-------------------------------
-- CREATE TABS
-------------------------------

local MainTab    = createTabButton("Main")
local StealerTab = createTabButton("Stealer")
local BoosterTab = createTabButton("Booster")
local PlayerTab  = createTabButton("Player")
local ServerTab  = createTabButton("Server")
local FinderTab  = createTabButton("Finder")
local SettingsTab= createTabButton("Settings")

local MainPage    = createPage("Main")
local StealerPage = createPage("Stealer")
local BoosterPage = createPage("Booster")
local PlayerPage  = createPage("Player")
local ServerPage  = createPage("Server")
local FinderPage  = createPage("Finder")
local SettingsPage= createPage("Settings")

-------------------------------
-- CALLBACK TABLE (YOU USE THIS)
-------------------------------

local Callbacks = {
    Stealer = {
        AutoSteal = function(state) end,
        HoldEUI   = function(state) end,
    },
    Booster = {
        BoosterToggle = function(state) end,
        SpeedChanged   = function(value) end,
        JumpChanged    = function(value) end,
        GravityChanged = function(value) end,
    },
    Player = {
        AntiRagdoll = function(state) end,
        SpeedUI     = function(state) end,
        InfJumpUI   = function(state) end,
        Custom1     = function(state) end,
    },
    Server = {
        Rejoin       = function() end,
        ServerHop    = function() end,
        JoinJobId    = function(jobId) end,
        CopyJobId    = function() end,
    },
    Finder = {
        AutoLoad     = function(state) end,
        StartHop     = function(state) end,
        HighValue    = function(state) end,
        MinMoneySec  = function(value) end,
        MythicServer = function(state) end,
        WebhookSet   = function(url) end,
    },
    Settings = {
        AutoLoadOnRejoin = function(state) end,
        SaveConfig       = function() end,
        ResetConfig      = function() end,
    }
}

_G.MONIS_HUB_CALLBACKS = Callbacks -- so you can access from other scripts if you want

-------------------------------
-- MAIN TAB CONTENT
-------------------------------

createSectionLabel(MainPage, "Welcome")

createSmallInfo(MainPage, "Moni's Hub UI loaded.\nDesigned for Steal a Brainrot. All toggles and sliders expose callbacks for you to hook.")

createButton(MainPage, "Copy Discord Invite", function()
    if setclipboard then
        setclipboard(CONFIG.DiscordInvite)
        notify("Moni's Hub", "Discord invite copied.", 3)
    else
        notify("Moni's Hub", "Executor does not support setclipboard.", 4)
    end
end)

createButton(MainPage, "Toggle Hub (LeftCtrl / MH)", function()
    HubFrame.Visible = not HubFrame.Visible
end)

-------------------------------
-- STEALER TAB (UI)
-------------------------------

createSectionLabel(StealerPage, "Stealer")

createSmallInfo(StealerPage, "These toggles are for your steal logic.\nHook into Callbacks.Stealer.* from your own scripts.")

createToggle(StealerPage, "Auto Steal", false, function(state)
    Callbacks.Stealer.AutoSteal(state)
end)

createToggle(StealerPage, "Hold E UI", false, function(state)
    Callbacks.Stealer.HoldEUI(state)
end)

-------------------------------
-- BOOSTER TAB (UI)
-------------------------------

createSectionLabel(BoosterPage, "Booster Core")

local BoosterToggleState = false

local setBoosterToggle = createToggle(BoosterPage, "Booster Mode", false, function(state)
    BoosterToggleState = state
    Callbacks.Booster.BoosterToggle(state)
end)

createSectionLabel(BoosterPage, "Booster Preset")

local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0, 230, 0, 60)
Panel.BackgroundColor3 = Color3.fromRGB(14, 14, 26)
Panel.BorderSizePixel = 0
Panel.Parent = BoosterPage
Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 8)

local PanelStroke = Instance.new("UIStroke", Panel)
PanelStroke.Thickness = 1
PanelStroke.Color = Color3.fromRGB(0, 170, 255)
PanelStroke.Transparency = 0.6

local PanelTitle = Instance.new("TextLabel")
PanelTitle.Size = UDim2.new(1, -10, 0, 18)
PanelTitle.Position = UDim2.new(0, 5, 0, 4)
PanelTitle.BackgroundTransparency = 1
PanelTitle.Text = "Preset"
PanelTitle.TextColor3 = Color3.fromRGB(200, 200, 230)
PanelTitle.Font = Enum.Font.GothamBold
PanelTitle.TextSize = 13
PanelTitle.TextXAlignment = Enum.TextXAlignment.Left
PanelTitle.Parent = Panel

local PanelLine = Instance.new("Frame")
PanelLine.Size = UDim2.new(1, -10, 0, 1)
PanelLine.Position = UDim2.new(0, 5, 0, 22)
PanelLine.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
PanelLine.BorderSizePixel = 0
PanelLine.Parent = Panel

local PanelInfo = Instance.new("TextLabel")
PanelInfo.Size = UDim2.new(1, -10, 0, 30)
PanelInfo.Position = UDim2.new(0, 5, 0, 25)
PanelInfo.BackgroundTransparency = 1
PanelInfo.Text = "Speed: 27   Jump: 30\nGravity: 200"
PanelInfo.TextColor3 = Color3.fromRGB(190, 190, 220)
PanelInfo.Font = Enum.Font.Gotham
PanelInfo.TextSize = 13
PanelInfo.TextWrapped = true
PanelInfo.TextXAlignment = Enum.TextXAlignment.Left
PanelInfo.Parent = Panel

createSectionLabel(BoosterPage, "Sliders (visual, hooked via callbacks)")

local currentSpeed = 27
local currentJump = 30
local currentGravity = 200

createSlider(BoosterPage, "Speed", 10, 50, currentSpeed, function(val)
    currentSpeed = val
    Callbacks.Booster.SpeedChanged(val)
end)

createSlider(BoosterPage, "Jump", 10, 100, currentJump, function(val)
    currentJump = val
    Callbacks.Booster.JumpChanged(val)
end)

createSlider(BoosterPage, "Gravity", 50, 300, currentGravity, function(val)
    currentGravity = val
    Callbacks.Booster.GravityChanged(val)
end)

createButton(BoosterPage, "Reset Booster UI", function()
    BoosterToggleState = false
    setBoosterToggle(false)
    notify("Moni's Hub", "Booster UI reset.", 2)
end)

-------------------------------
-- PLAYER TAB (UI)
-------------------------------

createSectionLabel(PlayerPage, "Player")

createToggle(PlayerPage, "Anti Ragdoll UI", false, function(state)
    Callbacks.Player.AntiRagdoll(state)
end)

createToggle(PlayerPage, "Speed UI Toggle", false, function(state)
    Callbacks.Player.SpeedUI(state)
end)

createToggle(PlayerPage, "Infinity Jump UI", false, function(state)
    Callbacks.Player.InfJumpUI(state)
end)

createToggle(PlayerPage, "Custom Player Option", false, function(state)
    Callbacks.Player.Custom1(state)
end)

-------------------------------
-- SERVER TAB (UI)
-------------------------------

createSectionLabel(ServerPage, "Server Tools")

createButton(ServerPage, "Rejoin Server", function()
    Callbacks.Server.Rejoin()
end)

createButton(ServerPage, "Server Hop", function()
    Callbacks.Server.ServerHop()
end)

local JobIdBox = Instance.new("TextBox")
JobIdBox.Size = UDim2.new(0, 230, 0, 28)
JobIdBox.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
JobIdBox.BorderSizePixel = 0
JobIdBox.PlaceholderText = "Job-ID Input"
JobIdBox.Text = ""
JobIdBox.TextColor3 = Color3.fromRGB(255, 255, 255)
JobIdBox.Font = Enum.Font.Gotham
JobIdBox.TextSize = 13
JobIdBox.Parent = ServerPage
Instance.new("UICorner", JobIdBox).CornerRadius = UDim.new(0, 6)

createButton(ServerPage, "Join Job-ID", function()
    Callbacks.Server.JoinJobId(JobIdBox.Text)
end)

createButton(ServerPage, "Copy Job-ID", function()
    Callbacks.Server.CopyJobId()
end)

-------------------------------
-- FINDER TAB (UI)
-------------------------------

createSectionLabel(FinderPage, "Finder")

local setAutoLoad = createToggle(FinderPage, "Auto Load Script", false, function(state)
    Callbacks.Finder.AutoLoad(state)
end)

createToggle(FinderPage, "Start server hop to find target", false, function(state)
    Callbacks.Finder.StartHop(state)
end)

local WebhookBox = Instance.new("TextBox")
WebhookBox.Size = UDim2.new(0, 230, 0, 28)
WebhookBox.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
WebhookBox.BorderSizePixel = 0
WebhookBox.PlaceholderText = "Webhook URL"
WebhookBox.Text = ""
WebhookBox.TextColor3 = Color3.fromRGB(255, 255, 255)
WebhookBox.Font = Enum.Font.Gotham
WebhookBox.TextSize = 13
WebhookBox.Parent = FinderPage
Instance.new("UICorner", WebhookBox).CornerRadius = UDim.new(0, 6)

createButton(FinderPage, "Set Webhook", function()
    Callbacks.Finder.WebhookSet(WebhookBox.Text)
end)

createToggle(FinderPage, "Find High Value Brainrot Server", false, function(state)
    Callbacks.Finder.HighValue(state)
end)

createSlider(FinderPage, "Min money per sec", 50, 1000, 200, function(val)
    Callbacks.Finder.MinMoneySec(val)
end)

createToggle(FinderPage, "Find < 2 min Guaranteed Mythic Server", false, function(state)
    Callbacks.Finder.MythicServer(state)
end)

-------------------------------
-- SETTINGS TAB (UI)
-------------------------------

createSectionLabel(SettingsPage, "Settings")

createToggle(SettingsPage, "Auto Load on Rejoin", false, function(state)
    Callbacks.Settings.AutoLoadOnRejoin(state)
end)

createButton(SettingsPage, "Save Config", function()
    Callbacks.Settings.SaveConfig()
end)

createButton(SettingsPage, "Reset Config", function()
    Callbacks.Settings.ResetConfig()
end)

createSmallInfo(SettingsPage, "All settings here are exposed through Callbacks.Settings.*.\nUse them to save / load your own data.")

-------------------------------
-- TAB BUTTON HOOKS
-------------------------------

MainTab.MouseButton1Click:Connect(function()
    switchTab("Main")
end)

StealerTab.MouseButton1Click:Connect(function()
    switchTab("Stealer")
end)

BoosterTab.MouseButton1Click:Connect(function()
    switchTab("Booster")
end)

PlayerTab.MouseButton1Click:Connect(function()
    switchTab("Player")
end)

ServerTab.MouseButton1Click:Connect(function()
    switchTab("Server")
end)

FinderTab.MouseButton1Click:Connect(function()
    switchTab("Finder")
end)

SettingsTab.MouseButton1Click:Connect(function()
    switchTab("Settings")
end)

-- default tab
switchTab("Main")

notify("Moni's Hub", "UI loaded. Use LeftCtrl or MH button to toggle hub.", 5)
