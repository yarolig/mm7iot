
--[[
common events:
 10-19 change map
 20-29 shops, services
 30-39 houses
 40-49 wells, fountains
 50-59 doors
 60-69 chests
 70-79 traps
 80-89 tour guide, npc talks
 90-99 monster respawn
]]


--[[


]]

evt.map[1] = function() evt.EnterHouse(1);  end -- weapon shop
evt.map[2] = function() evt.EnterHouse(89); end -- training
evt.map[3] = function() evt.EnterHouse(74); end -- temple



--evt.map[10] = function(); evt.EnterHouse(74); end; -- surface
--evt.map[11] = function(); evt.EnterHouse(74); end; -- dungeon
evt.map[12] = function() evt.MoveToMap(0,0,0,0, 0,0, 0, 0, "mm3c2.odm"); end; -- c2

evt.map[20] = function() evt.EnterHouse(74); end -- weapons
evt.map[21] = function() evt.EnterHouse(74); end -- armor
evt.map[22] = function() evt.EnterHouse(74); end -- items
evt.map[23] = function() evt.EnterHouse(74); end -- temple
evt.map[24] = function() evt.EnterHouse(74); end -- training
evt.map[25] = function() evt.EnterHouse(74); end -- guild
evt.map[26] = function() evt.EnterHouse(74); end -- tavern
evt.map[27] = function() evt.EnterHouse(74); end -- inn
evt.map[28] = function() evt.EnterHouse(74); end -- 
evt.map[29] = function() evt.EnterHouse(74); end -- mirror

evt.map[30] = function() evt.EnterHouse(74); end -- guild membership
evt.map[31] = function() evt.EnterHouse(74); end -- silver skull quest
evt.map[32] = function() evt.EnterHouse(74); end -- 
evt.map[33] = function() evt.EnterHouse(74); end -- 
evt.map[34] = function() evt.EnterHouse(74); end -- 
evt.map[35] = function() evt.EnterHouse(74); end -- 
evt.map[36] = function() evt.EnterHouse(74); end -- 





evt.map[10] = function()
    --evt.EnterHouse(1)
    --MoveToMap  {X = -1208, Y = -4225, Z = 366, Direction = 320, LookAngle = 0, SpeedZ = 0, HouseId = 191, Icon = 3, Name = "D06.blv"}  -- "Temple of the Moon"
    Hint = "Exit to isles?"
    evt.MoveToMap(-8709, 13826, 640, 1507, 0,0, 0, 4, "mm3a1.odm");
    --evt.MoveToMap(0,0,0,0, 0,0, 0, 0, "mm3a1.odm");
end