-- inventory.lua
InventorySystem = {}

function CreateInventory(player)
    InventorySystem[player:SteamID()] = {}
end

function AddItem(player, item)
    if not InventorySystem[player:SteamID()] then
        CreateInventory(player)
    end
    table.insert(InventorySystem[player:SteamID()], item)
    player:ChatPrint("Added " .. item .. " to inventory!")
end

function RemoveItem(player, item)
    local inv = InventorySystem[player:SteamID()]
    for k, v in ipairs(inv) do
        if v == item then
            table.remove(inv, k)
            player:ChatPrint("Removed " .. item .. " from inventory!")
            return
        end
    end
    player:ChatPrint("Item not found in inventory!")
end

function ViewInventory(player)
    local inv = InventorySystem[player:SteamID()] or {}
    player:ChatPrint("Your inventory: " .. table.concat(inv, ", ") or "Empty")
end

-- Add console commands for inventory management
concommand.Add("add_item", function(ply, cmd, args)
    if args[1] then
        AddItem(ply, args[1])
    end
end)

concommand.Add("remove_item", function(ply, cmd, args)
    if args[1] then
        RemoveItem(ply, args[1])
    end
end)

concommand.Add("view_inventory", function(ply)
    ViewInventory(ply)
end)
