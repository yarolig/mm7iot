--Game.MapEvtLines:RemoveEvent(1)  -- remove original event

evt.map[3] = function()
    for n, pl in Party do
        local fullhp = pl:GetFullHP()
        if pl.HP > 0 then
            pl.HP = math.min(pl.HP + 50, fullhp + 50)
            
        end
    end
    Game.NeedRedraw = true  -- I remember having problems with minimap not getting drawn
    Sleep(1)  -- sleep for 1 tick to let it be drawn
    Message("Your health boosted!")
    
    evt.StatusText(3)
end


evt.map[1] = function()
    evt.EnterHouse(1)
end



evt.map[73] = function()
    --evt.EnterHouse(1)
    --MoveToMap  {X = -1208, Y = -4225, Z = 366, Direction = 320, LookAngle = 0, SpeedZ = 0, HouseId = 191, Icon = 3, Name = "D06.blv"}  -- "Temple of the Moon"
    evt.MoveToMap(0,0,0,0, 0,0, 0,0, "mm3fh.blv");
        
end
