-- dungeons.lua
Dungeons = {
    ["ForestTemple"] = {puzzles = {"SwitchPuzzle", "BlockPuzzle"}, boss = "PhantomGanon", unlocked = false},
    ["FireTemple"] = {puzzles = {"LavaPuzzle"}, boss = "Volvagia", unlocked = false},
    -- Add more dungeons here
}

function SolvePuzzle(ply, dungeonName, puzzle)
    local dungeon = Dungeons[dungeonName]
    if dungeon and table.HasValue(dungeon.puzzles, puzzle) then
        ply:ChatPrint("Puzzle solved: " .. puzzle)
        UnlockDungeon(dungeonName)
    end
end

function UnlockDungeon(dungeonName)
    local dungeon = Dungeons[dungeonName]
    if dungeon then
        dungeon.unlocked = true
        -- Additional code to unlock the next part of the dungeon or prepare the boss fight
        PrintMessage(HUD_PRINTTALK, "Dungeon unlocked: " .. dungeonName)
    end
end
