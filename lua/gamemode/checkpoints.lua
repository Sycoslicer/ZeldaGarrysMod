-- checkpoints.lua
Checkpoints = {}

function SaveCheckpoint(player)
    local checkpointData = {
        position = player:GetPos(),
        inventory = player:GetInventory(), -- Assume GetInventory() returns player's inventory
        currentDay = GetGlobalInt("CurrentDay"), -- Global variable for current day
    }
    
    -- Store the checkpoint data in the player's table
    Checkpoints[player:SteamID()] = checkpointData
    player:ChatPrint("Checkpoint saved!")
end

function LoadCheckpoint(player)
    local checkpointData = Checkpoints[player:SteamID()]
    
    if checkpointData then
        player:SetPos(checkpointData.position)
        player:SetInventory(checkpointData.inventory) -- Assume SetInventory() can restore inventory
        SetGlobalInt("CurrentDay", checkpointData.currentDay) -- Restore current day
        player:ChatPrint("Checkpoint loaded!")
    else
        player:ChatPrint("No checkpoint found!")
    end
end

-- Add console commands for saving/loading checkpoints
concommand.Add("save_checkpoint", function(ply)
    SaveCheckpoint(ply)
end)

concommand.Add("load_checkpoint", function(ply)
    LoadCheckpoint(ply)
end)
