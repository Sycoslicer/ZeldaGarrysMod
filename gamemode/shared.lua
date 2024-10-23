-- shared.lua

-- Defining some basic variables
GM.Name = "Zelda Themed Gamemode"
GM.Author = "Sycoslicer -Half Insane-"
GM.Email = ""
GM.Website = ""

-- Table for achievements
Achievements = {
    ["FirstRupee"] = "Collect your first rupee",
    ["BossSlayer"] = "Defeat your first boss",
    ["TreasureHunter"] = "Find a rare hidden treasure"
}

-- Quest progression stages (you can expand this later)
QuestStages = {
    ["Start"] = "Talk to the Old Man",
    ["ForestTemple"] = "Complete the Forest Temple",
    ["DefeatGanon"] = "Defeat Ganon"
}

-- Setting up teams for cooperative gameplay
function GM:CreateTeams()
    team.SetUp(1, "Team Link", Color(0, 255, 0))
    team.SetUp(2, "Team Zelda", Color(255, 0, 0))
end
