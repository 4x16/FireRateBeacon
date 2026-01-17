local BOOST = 3

hook.Add("Think", "Beacon_Overdrive_Final", function()
    for _, ply in ipairs(player.GetAll()) do
        if not IsValid(ply) or not ply:Alive() then continue end

        local inRange = ply:GetNW2Bool("ArcCW_InBeaconRange", false)
        local wep = ply:GetActiveWeapon()

        if inRange and IsValid(wep) and wep.ArcCW then
            local curTime = CurTime()
            local nextFire = wep:GetNextPrimaryFire()
            local diff = nextFire - curTime

            -- Handle the fire rate timing
            if diff > 0 then
                if not wep.BeaconBoosted then
                    wep:SetNextPrimaryFire(curTime + (diff / BOOST))
                    wep.BeaconBoosted = true
                end
            else
                wep.BeaconBoosted = false
            end
        end
    end
end)