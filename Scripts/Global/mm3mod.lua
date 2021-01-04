


print("mm3 main");
--MessageBox("mm3 main!")

function summon_peasant() 
    local mon = SummonMonster(151, Party.X, Party.Y, Party.Z, true)
    mon.NPC_ID = 52
    mon.Hostile = false
end

