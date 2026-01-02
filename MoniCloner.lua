-- Listen for key press
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.V then
        print("V pressed — loading MoniCloner")

        -- Run your loadstring
        loadstring(game:HttpGet("https://raw.githubusercontent.com/mm2dino123-sketch/moni/main/MoniCloner.lua"))()
    end
end)
