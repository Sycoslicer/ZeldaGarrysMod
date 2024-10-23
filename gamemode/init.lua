-- init.lua
AddCSLuaFile("checkpoints.lua")
AddCSLuaFile("inventory.lua")
AddCSLuaFile("quests.lua")
AddCSLuaFile("npc.lua")
AddCSLuaFile("daynight.lua")
AddCSLuaFile("config.lua")

include("checkpoints.lua")
include("inventory.lua")
include("quests.lua")
include("npc.lua")
include("daynight.lua")
include("config.lua")

function GM:Initialize()
    print("Zelda Gamemode Initialized")
    SetGlobalInt("CurrentDay", 1)
end

-- Commands to trigger checkpoint saving/loading
concommand.Add("save_checkpoint", function(ply)
    SaveCheckpoint(ply)
end)

concommand.Add("load_checkpoint", function(ply)
    LoadCheckpoint(ply)
end)

-- Commands for inventory management
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

-- Commands for quest management
concommand.Add("start_quest", function(ply, cmd, args)
    if args[1] then
        StartQuest(ply, args[1])
    end
end)

concommand.Add("complete_quest", function(ply, cmd, args)
    if args[1] then
        CompleteQuest(ply, args[1])
    end
end)

concommand.Add("view_quests", function(ply)
    ViewQuests(ply)
end)
