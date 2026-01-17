AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_combine/combine_light001b.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then phys:Wake() end
end

-- MASTER OPTIMIZATION: One timer for all players/beacons
if not timer.Exists("Beacon_Master_Logic") then
    timer.Create("Beacon_Master_Logic", 0.2, 0, function()
        local beacons = ents.FindByClass("sent_fire_beacon")
        local players = player.GetAll()

        for i=1, #players do
            local ply = players[i]
            if not IsValid(ply) or not ply:Alive() then continue end

            local inRange = false
            local plyPos = ply:GetPos()

            -- Only loop through beacons if there are any
            for j=1, #beacons do
                local b = beacons[j]
                if IsValid(b) and plyPos:DistToSqr(b:GetPos()) < 90000 then -- 300 units squared
                    inRange = true
                    break -- Found one, stop checking others for this player
                end
            end

            -- Only update the network variable if it changed (saves bandwidth)
            if ply:GetNW2Bool("ArcCW_InBeaconRange") != inRange then
                ply:SetNW2Bool("ArcCW_InBeaconRange", inRange)
            end
        end
    end)
end