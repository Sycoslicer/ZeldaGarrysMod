-- zelda_npc.lua
DEFINE_BASECLASS("base_nextbot")

ENT.Base = "base_nextbot"
ENT.Type = "nextbot"
ENT.PrintName = "Zelda NPC"

function ENT:Initialize()
    self:SetModel("models/props_c17/oildrum001.mdl") -- Replace with an appropriate model
    self:SetHealth(100)
end

function ENT:OnContact(ply)
    TalkToNPC(ply, "KaeporaGaebora") -- Example NPC
end

function ENT:Think()
    self:NextThink(CurTime())
    return true
end
