--// Dino's Chilli-style Loader
local function safeLoad(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)

    if success then
        local fn = loadstring(result)
        if fn then
            fn()
        else
            warn("[Loader] Failed to compile remote code")
        end
    else
        warn("[Loader] Failed to fetch:", url)
    end
end

--// Replace with your actual raw GitHub URL
local remoteURL = "https://raw.githubusercontent.com/mm2dino123-sketch/main/moni/Main.lua"
safeLoad(remoteURL)
