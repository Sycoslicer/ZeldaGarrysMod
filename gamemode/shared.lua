-- shared.lua

GM.Name = "Zelda Themed Gamemode"
GM.Author = "Sycoslicer -Half Insane-"
GM.Email = ""
GM.Website = ""

-- Table for achievements
Achievements = {
    ["FirstRupee"] = "Collect your first rupee",
    ["BossSlayer"] = "Defeat your first boss",
    ["TreasureHunter"] = "Find a rare hidden treasure",
    ["MasterSwordsman"] = "Obtain the Master Sword",
    ["DungeonExplorer"] = "Complete all dungeons"
}

-- Quest progression stages
QuestStages = {
    ["Start"] = "Talk to the Old Man",
    ["KokiriSword"] = "Find the Kokiri Sword",
    ["SlayGohma"] = "Defeat Queen Gohma in the Deku Tree",
    ["ForestTemple"] = "Complete the Forest Temple",
    ["WaterTemple"] = "Complete the Water Temple",
    ["SpiritTemple"] = "Complete the Spirit Temple",
    ["DefeatGanon"] = "Defeat Ganon"
}

-- Setting up teams for cooperative gameplay
function GM:CreateTeams()
    team.SetUp(1, "Team Link", Color(0, 255, 0), true)
    team.SetUp(2, "Team Zelda", Color(255, 0, 0), true)
end

-- Define collectible items (e.g., rupees, health, and items like hearts, bombs, etc.)
Collectibles = {
    ["GreenRupee"] = {value = 1},
    ["BlueRupee"] = {value = 5},
    ["RedRupee"] = {value = 20},
    ["Heart"] = {heal = 25},
    ["Bomb"] = {give = "weapon_bomb"}
}

-- Define bosses and unique enemies for the game
Bosses = {
    ["Ganon"] = "npc_ganon",
    ["Gohma"] = "npc_gohma",
    ["PhantomGanon"] = "npc_phantomganon"
}
