-- init.lua

-- Include the shared.lua
include("shared.lua")

-- NPC Dialogues
local NPCDialogues = {
    ["OldMan"] = {
        "Ah, young traveler! You seek the sword of legend.",
        "Hint: Explore the forests near the large tree with the cracked stone."
    },
    ["Shopkeeper"] = {
        "Welcome! Rare rupees are hidden near Death Mountain.",
        "Use your rupees wisely!"
    }
}

-- Rupee spawn locations (can expand with more maps/locations)
local rupeeSpawns = {
    Vector(100, 100, 50),
    Vector(200, 200, 50)
}

-- Player data to store rupees and progression
local PlayerData = {}

-- Initialize player data when they join
hook.Add("PlayerInitialSpawn", "SetupPlayerData", function(ply)
    PlayerData[ply:SteamID()] = {
        Rupees = 0,
        Progress = "Start",
        Achievements = {}
    }
end)

-- Function to give rupees to player on NPC kill
function GM:OnNPCKilled(npc, attacker, inflictor)
    if IsValid(attacker) and attacker:IsPlayer() then
        local rupeeValue = math.random(1, 10)
        PlayerData[attacker:SteamID()].Rupees = PlayerData[attacker:SteamID()].Rupees + rupeeValue
        attacker:ChatPrint("You collected " .. rupeeValue .. " Rupees!")
    end
end

-- NPC interaction to trigger dialogue
util.AddNetworkString("SendDialogue")
function NPCDialogue(ply, npc)
    local dialogue = NPCDialogues[npc:GetName()]
    if dialogue then
        for _, line in ipairs(dialogue) do
            net.Start("SendDialogue")
            net.WriteString(line)
            net.Send(ply)
        end
    end
end

-- Function to check and update quest progression
function CheckQuestProgress(ply)
    local progress = PlayerData[ply:SteamID()].Progress
    if progress == "ForestTemple" then
        ply:ChatPrint("You are ready to face Ganon!")
        -- Spawn Ganon boss
        local ganon = ents.Create("npc_ganon")  -- Placeholder for Ganon NPC
        ganon:SetPos(Vector(0, 0, 0))  -- Replace with boss location
        ganon:Spawn()
    end
end

-- Handle achievement unlocking
function UnlockAchievement(ply, achievement)
    if not PlayerData[ply:SteamID()].Achievements[achievement] then
        PlayerData[ply:SteamID()].Achievements[achievement] = true
        ply:ChatPrint("Achievement unlocked: " .. Achievements[achievement])
    end
end

-- Handle rupee respawn timer
function RespawnRupees()
    for _, pos in ipairs(rupeeSpawns) do
        local rupee = ents.Create("item_rupee")
        rupee:SetPos(pos)
        rupee:Spawn()
    end
end
timer.Create("RupeeRespawnTimer", 600, 0, RespawnRupees)

-- Hook to update quest progression on interaction or completion
hook.Add("PlayerSay", "PlayerProgressUpdate", function(ply, text)
    if string.lower(text) == "!progress" then
        ply:ChatPrint("Your current quest: " .. PlayerData[ply:SteamID()].Progress)
    end
end)
