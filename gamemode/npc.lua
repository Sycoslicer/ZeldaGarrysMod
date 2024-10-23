-- npc.lua
NPCDialogue = {
    ["npc_zora"] = {
        "Welcome to Zora's Domain!",
        "Have you seen any water spirits?",
        "I can help you with your quest!"
    },
    ["npc_goron"] = {
        "We Gorons are strong and hearty!",
        "Be careful of the lava!",
        "I can sell you some bombs!"
    },
}

function DisplayDialogue(player, npcName)
    if NPCDialogue[npcName] then
        local dialogues = NPCDialogue[npcName]
        local response = dialogues[math.random(#dialogues)]
        player:ChatPrint(response)
    else
        player:ChatPrint("This NPC has no dialogue.")
    end
end

-- Create an NPC that displays dialogue
function CreateNPC(name, position)
    local npc = ents.Create("npc_custom")
    npc:SetPos(position)
    npc:SetModel("models/props_c17/oildrum001.mdl") -- Change to appropriate model
    npc:Spawn()
    npc:SetNWString("NPCName", name)
    return npc
end

-- Assuming there's a way to trigger dialogue
hook.Add("PlayerUse", "NPCDialogueTrigger", function(player, entity)
    if entity:GetClass() == "npc_custom" then
        local npcName = entity:GetNWString("NPCName")
        DisplayDialogue(player, npcName)
        return false -- Prevent default use action
    end
end)
