-- cl_init.lua

-- Include the shared.lua
include("shared.lua")

-- HUD for displaying player's rupees
hook.Add("HUDPaint", "DrawRupeeCount", function()
    local rupeeCount = LocalPlayer().Rupees or 0
    draw.SimpleText("Rupees: " .. rupeeCount, "Trebuchet24", 15, 15, Color(0, 255, 0), 0, 0)
end)

-- Receive dialogue from the server
net.Receive("SendDialogue", function()
    local message = net.ReadString()
    chat.AddText(Color(255, 255, 0), "[NPC]: ", Color(255, 255, 255), message)
end)

-- Receive achievement notifications from the server
net.Receive("UnlockAchievement", function()
    local achievementName = net.ReadString()
    chat.AddText(Color(0, 255, 0), "Achievement Unlocked: ", Color(255, 255, 255), achievementName)
end)

-- Update Rupee count when it's changed on the server
net.Receive("UpdateRupeeCount", function()
    LocalPlayer().Rupees = net.ReadInt(32)
end)
