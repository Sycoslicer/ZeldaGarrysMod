-- quests.lua
Quests = {}

function StartQuest(player, questName)
    if not Quests[player:SteamID()] then
        Quests[player:SteamID()] = {}
    end
    Quests[player:SteamID()][questName] = "Started"
    player:ChatPrint("Quest '" .. questName .. "' started!")
end

function CompleteQuest(player, questName)
    if Quests[player:SteamID()] and Quests[player:SteamID()][questName] then
        Quests[player:SteamID()][questName] = "Completed"
        player:ChatPrint("Quest '" .. questName .. "' completed!")
    else
        player:ChatPrint("Quest not found!")
    end
end

function ViewQuests(player)
    local playerQuests = Quests[player:SteamID()] or {}
    local output = {}
    for name, status in pairs(playerQuests) do
        table.insert(output, name .. ": " .. status)
    end
    player:ChatPrint("Your quests: " .. table.concat(output, ", ") or "No quests.")
end

-- Add console commands for quest management
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
