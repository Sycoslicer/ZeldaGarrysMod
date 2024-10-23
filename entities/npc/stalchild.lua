-- stalchild.lua
DEFINE_BASECLASS("base_nextbot")

ENT.Base = "base_nextbot"
ENT.Type = "nextbot"
ENT.PrintName = "Stalchild"

function ENT:Initialize()
    self:SetModel("models/props_c17/oildrum001.mdl") -- Replace with an appropriate Stalchild model
    self:SetHealth(50)
end

function ENT:Think()
    -- Stalchild behavior logic (e.g., movement, attacking)
    self:NextThink(CurTime() + 0.5)
    -- Add your attack and movement logic here
end

function ENT:OnContact(ent)
    if ent:IsPlayer() then
        -- Deal damage to the player
        ent:TakeDamage(10, self, self)
    end
end
