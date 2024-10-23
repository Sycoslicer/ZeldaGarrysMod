-- cl_init.lua

-- Include the shared.lua
include("shared.lua")

function GM:PlayerInitialSpawn(ply)
    -- Display a selection menu
    net.Start("OpenGameModeMenu")
    net.Send(ply)
end

-- Client-side code to open the menu
-- In a separate file (e.g., cl_menu.lua)
net.Receive("OpenGameModeMenu", function()
    local frame = vgui.Create("DFrame")
    frame:SetSize(300, 200)
    frame:SetTitle("Select Gamemode")
    
    local button1 = vgui.Create("DButton", frame)
    button1:SetText("Ocarina of Time")
    button1:SetPos(50, 50)
    button1.DoClick = function()
        RunConsoleCommand("set_gamemode", "oot")
        frame:Close()
    end

    local button2 = vgui.Create("DButton", frame)
    button2:SetText("Majora's Mask")
    button2:SetPos(50, 100)
    button2.DoClick = function()
        RunConsoleCommand("set_gamemode", "mm")
        frame:Close()
    end

    frame:MakePopup()
end)


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

-- Create a UI for inventory
function GM:OpenInventory(ply)
    net.Start("OpenInventoryUI")
    net.Send(ply)
end

-- Client-side code to open the inventory UI
net.Receive("OpenInventoryUI", function()
    local frame = vgui.Create("DFrame")
    frame:SetSize(400, 300)
    frame:SetTitle("Inventory")
    
    -- Loop through player's inventory and display items
    local items = LocalPlayer():GetInventory()
    for k, v in pairs(items) do
        local label = vgui.Create("DLabel", frame)
        label:SetText(k)
        label:Dock(TOP)
    end

    frame:MakePopup()
end)
