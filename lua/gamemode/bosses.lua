-- bosses.lua
Bosses = {
    ["PhantomGanon"] = {hp = 100, phase = "painting", cooldown = 5}
}

function StartBossFight(ply, bossName)
    local boss = Bosses[bossName]
    if boss then
        ply:ChatPrint("Boss fight started: " .. bossName)
        -- Implement boss mechanics here
    end
end

-- Handle boss behavior and attacks
