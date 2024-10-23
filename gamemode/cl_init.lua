-- cl_init.lua

-- Include the shared.lua
include("shared.lua")

-- Function to receive dialogue from the server
net.Receive("SendDialogue", function()
    local message = net.ReadString()
    chat.AddText(Color(255, 255, 0), "[NPC]: ", Color(255, 255, 255), message)
end)

-- HUD Paint for showing player's rupees
hook.Add("HUDPaint", "DrawRupeeCount", function()
    local rupeeCount = LocalPlayer().Rupees or 0
    draw.SimpleText("Rupees: " .. rupeeCount, "Trebuchet24", 15, 15, Color(0, 255, 0), 0, 0)
end)

-- Hook to display when an achievement is unlocked
net.Receive("UnlockAchievement", function()
    local achievementName = net.ReadString()
    chat.AddText(Color(0, 255, 0), "Achievement Unlocked: ", Color(255, 255, 255), achievementName)
end)
