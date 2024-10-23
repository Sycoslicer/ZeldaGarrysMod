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

-- Player inventory management
function PlayerMeta:SetInventory(items)
    self.inventory = items or {}
end

function PlayerMeta:GetInventory()
    return self.inventory
end

-- Quest tracking
function PlayerMeta:AddQuest(quest)
    self.quests = self.quests or {}
    table.insert(self.quests, quest)
end

function PlayerMeta:GetQuests()
    return self.quests or {}
end

-- Achievement system
function GM:CheckAchievements(ply)
    if ply.dungeons_completed >= 1 then
        ply:AddAchievement("First Dungeon Completed")
    end
end

function PlayerMeta:AddAchievement(name)
    self.achievements = self.achievements or {}
    self.achievements[name] = true
end

function PlayerMeta:GetAchievements()
    return self.achievements or {}
end

-- Crafting function
function GM:CraftItem(ply, item1, item2)
    if ply:GetInventory()[item1] and ply:GetInventory()[item2] then
        -- Remove items from inventory
        ply:GetInventory()[item1] = nil
        ply:GetInventory()[item2] = nil
        
        -- Add crafted item
        ply:GetInventory()["NewItem"] = true
        ply:ChatPrint("Crafted NewItem!")
    end
end
