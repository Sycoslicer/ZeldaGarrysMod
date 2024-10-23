-- daynight.lua
DayNightCycle = {
    time = 0, -- In-game time in minutes (0-1440 for 24 hours)
    duration = 720, -- In-game day duration for Ocarina of Time
    majorasCycleDays = 3, -- Duration for Majora's Mask
    currentCycleDay = 1,
    isMajorasMask = false, -- Track whether the current gamemode is Majora's Mask
}

function StartMajorasMaskCycle()
    DayNightCycle.isMajorasMask = true
    timer.Create("DayNightCycleTimer", 1, 0, UpdateMajorasMaskCycle)
end

function StartOcarinaOfTimeCycle()
    DayNightCycle.isMajorasMask = false
    timer.Create("DayNightCycleTimer", 1, 0, UpdateOcarinaOfTimeCycle)
end

function UpdateMajorasMaskCycle()
    DayNightCycle.time = (DayNightCycle.time + 1) % 54 -- Cycle lasts 54 minutes

    if DayNightCycle.time < 18 then
        SetDayTime() -- First day
    elseif DayNightCycle.time < 36 then
        SetNightTime()
        SpawnStalchildren() -- Spawn Stalchildren at night
    elseif DayNightCycle.time < 54 then
        SetDayTime() -- Second day
    elseif DayNightCycle.time < 72 then
        SetNightTime()
        SpawnStalchildren()
    elseif DayNightCycle.time < 90 then
        SetDayTime() -- Third day
    elseif DayNightCycle.time < 108 then
        -- Check for reset on the third night
        SetNightTime()
        SpawnStalchildren()
        if DayNightCycle.time >= 108 then
            ResetGame() -- Call a function to reset the game
        end
    end
end

function UpdateOcarinaOfTimeCycle()
    DayNightCycle.time = (DayNightCycle.time + 1) % 24 -- Cycle lasts 24 minutes (12 day + 12 night)

    if DayNightCycle.time < 12 then
        SetDayTime()
        RemoveStalchildren() -- Remove Stalchildren during the day
    else
        SetNightTime()
        SpawnStalchildren()
    end
end

function SetDayTime()
    print("Daytime!")
    -- Logic for day time: change lighting, music, etc.
    SetGlobalBool("IsDay", true)
end

function SetNightTime()
    print("Nighttime!")
    -- Logic for night time: change lighting, music, etc.
    SetGlobalBool("IsDay", false)
end

function SpawnStalchildren()
    -- Logic to spawn Stalchildren when it's night
    local stalchild = ents.Create("npc_stalchild")
    stalchild:SetPos(Vector(math.random(-1000, 1000), math.random(-1000, 1000), 0)) -- Random position
    stalchild:Spawn()
end

function RemoveStalchildren()
    -- Logic to remove Stalchildren during the day
    for _, ent in pairs(ents.FindByClass("npc_stalchild")) do
        ent:Remove()
    end
end

function ResetGame()
    print("Game reset due to Majora's Mask cycle completion!")
    -- Implement reset logic (like respawning players, resetting dungeons)
    -- Reset the DayNightCycle.time and currentCycleDay
    DayNightCycle.time = 0
    DayNightCycle.currentCycleDay = 1
end
