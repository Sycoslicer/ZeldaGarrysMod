-- player.lua
function GM:PlayerSpawn(ply)
    ply:SetHealth(100)
    ply:SetMaxHealth(100)
    ply.Inventory = {}
    ply.NextItemUse = {}

    -- Give starting items
    GiveItem(ply, "Bomb")
end

function GiveItem(ply, itemName)
    if not ply.Inventory[itemName] then
        ply.Inventory[itemName] = {count = 1}
        ply:ChatPrint("You have received: " .. itemName)
    else
        ply.Inventory[itemName].count = ply.Inventory[itemName].count + 1
    end
end

function UseItem(ply, itemName)
    local item = Items[itemName]
    if item and ply.Inventory[itemName] and ply.Inventory[itemName].count > 0 then
        if not ply.NextItemUse[itemName] or ply.NextItemUse[itemName] < CurTime() then
            ply.Inventory[itemName].count = ply.Inventory[itemName].count - 1
            ply.NextItemUse[itemName] = CurTime() + item.cooldown
            ply:ChatPrint("Using " .. itemName)
            -- Additional effects (like explosions for bombs)
        else
            ply:ChatPrint(itemName .. " is on cooldown!")
        end
    else
        ply:ChatPrint("You don't have that item!")
    end
end
