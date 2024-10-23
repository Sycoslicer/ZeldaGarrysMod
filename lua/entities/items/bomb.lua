-- bomb.lua
DEFINE_BASECLASS("base_entity")

ENT.Base = "base_entity"
ENT.Type = "anim"
ENT.PrintName = "Bomb"

function ENT:Initialize()
    self:SetModel("models/props_c17/oildrum001.mdl") -- Replace with a bomb model
    self:SetTrigger(true)
end

function ENT:StartTouch(ent)
    if ent:IsPlayer() then
        -- Apply explosion effect
        local explosion = ents.Create("env_explosion")
        explosion:SetPos(self:GetPos())
        explosion:SetOwner(ent)
        explosion:Spawn()
        explosion:Activate()
        explosion:SetKeyValue("iMagnitude", "100")
        explosion:Fire("Explode", 0, 0)
        self:Remove()
    end
end
