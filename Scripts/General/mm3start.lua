
--Game.NewGameMap = "mm3a3.odm"
Game.NewGameMap = "mm3fh.blv"
--Game.NewGameMap = "d28.blv"
-- Red dragon cave is d28



function dump_sprites()
    for n,i in ipairs(Editor.Sprites) do
        --print(n .. '\t' .. i.Id .. '\t' .. i.DecListId .. '\t"' .. (i.DecName or "?") .. '"\t' .. i.X .. '\t'.. i.Y.. '\t'..i.Z)
        print(n .. '\t'.. '\t"' .. (i.DecName or "?").. '"\t'.. i.X .. '\t'.. i.Y.. '\t'..i.Z)
    end
end
--dump_sprites()

Keys[const.Keys.J] = function() 
    Party.Direction = ((Party.Direction+256):div(512)*512 + 512 + 2048) % 2048
end

Keys[const.Keys.L] = function() 
    Party.Direction = ((Party.Direction+256):div(512)*512 - 512 + 2048) % 2048
end


function center_party()
    Party.X = (Party.X-500):div(1000)*1000 + 500
    Party.Y = (Party.Y-500):div(1000)*1000 + 500
end

function center_direction()
    Party.Direction = ((Party.Direction+256):div(512)*512 + 2048) % 2048
end

Keys[const.Keys.K] = function() 
    center_direction()
    center_party()
    local dx = 0
    local dy = 0
    if Party.Direction==0 then --E
        dx = 1; dy = 0
    elseif Party.Direction==512 then -- N
        dx = 0; dy = 1
    elseif Party.Direction==1024 then -- W
        dx = -1; dy = 0
    elseif Party.Direction==1536 then -- S
        dx = 0; dy = -1
    end
    local distance = 1000
    Party.X = Party.X + distance*dx
    Party.Y = Party.Y + distance*dy

end



local function learn_skill(pl, skill, new_points, new_mastery)
    local skill, mastery = SplitSkill(pl.Skills[skill])
    pl.Skills[skill] = JoinSkill(math.max(skill, new_points), math.max(mastery, new_mastery))
end

function events.NewGameMap()
    print("mm3 NewGameMap2");
    --MessageBox("mm3 NewGameMap!2")
    XYZ(Party, 0, 0, 0)
	Party.Direction = 0
    Party.LookAngle = 0

    
    -- learn all magic skills
    
    for _, pl in Party do
        if pl.Class >= const.Class.Paladin then
            for sk=const.Skills.Fire,const.Skills.Dark do
                --learn_skill(pl, sk, 1, const.Novice)
                local new_points=1;
                local new_mastery=const.Novice;
                local skill, mastery = SplitSkill(pl.Skills[sk])
                pl.Skills[sk] = JoinSkill(math.max(skill, new_points), math.max(mastery, new_mastery))
                print('set skill', sk, 'to', pl.Skills[sk])
            end
        else
            print('no skills for ', pl.Class)
        end
        --local skill, mastery = SplitSkill(pl.Skills[const.Skills.Perception])
        --pl.Skills[const.Skills.Perception] = JoinSkill(math.max(skill, 4), math.max(mastery, const.Expert))
    end

    -- learn all spells
    for _, pl in Party do
        for i in pl.Spells do
            pl.Spells[i] = true
        end
    end

end

function events.DeathMapp(t)
	t.Name = "mm3fh.blv"
	XYZ(Party, 0, 0, 0)
	Party.Direction = 0
	Party.LookAngle = 0
end


function reverse_side(s) 
    if s == "up" then return "down"; end
    if s == "down" then return "up"; end
    if s == "left" then return "right"; end
    if s == "right" then return "left"; end
    return nil;
end




isle_map = {
    {false, false,false,false,false,false},
    {false, "mm3a1.odm",  "mm3b1.odm",  "mm3c1.odm",  "mm3d1.odm",  "mm3e1.odm",  "mm3f1.odm",  false},
    {false, "mm3a2.odm",  "mm3b2.odm",  "mm3c2.odm",  "mm3d2.odm",  "mm3e2.odm",  "mm3f2.odm",  false},
    {false, "mm3a3.odm",  "mm3b3.odm",  "mm3c3.odm",  "mm3d3.odm",  "mm3e3.odm",  "mm3f3.odm",  false},
    {false, "mm3a4.odm",  "mm3b4.odm",  "mm3c4.odm",  "mm3d4.odm",  "mm3e4.odm",  "mm3f4.odm",  false},
    {false, false,false,false,false,false},
}

function events.WalkToMap(t)
    local directions = {
        ["up"] = {"down", 0, -1},
        ["down"] = {"up", 0, 1},
        ["right"] = {"left", 1, 0},
        ["left"] = {"right", -1, 0},
    }
    --print(t.Days)
    --print(t.EnterMap)
    --print(t.EnterSide)
    --print(t.LeaveMap)
    --print(t.LeaveSide)
    -- print('events.WalkToMap',t.X, t.Y)
    --0 nil 0 wer.odm up 4032 22716

    pos, xxx, letter, number = string.find(t.LeaveMap, "mm3([abcdef])([1234]).odm");
    -- print('pxln', pos, xxx, letter, number)
    
    
    if pos == 1 and not Party.Flying then
        dd = directions[t.LeaveSide]
        opposite, dx, dy = dd[1], dd[2], dd[3]
        
        -- print('Move:', opposite, dx, dy, t.LeaveSide)
        new_number = number + dy
        if letter=='a' and dx == -1 then return; end
        if letter=='f' and dx == 1 then return; end
        if new_number == 0 then return; end
        if new_number == 5 then return; end
        new_letter = string.char(string.byte(letter) + dx)
        print('Moving to',"mm3" .. new_letter .. new_number .. ".odm")
        newx = t.X
        newy = t.Y
        if dx == 0 then newy = -newy-100*dy; end
        if dy == 0 then newx = -newx+100*dx; end

        evt.MoveToMap(newx, newy, Party.Z, Party.Direction,0,0, 0,0, "mm3" .. new_letter .. new_number .. ".odm");
        MessageBox("Entering ".."mm3" .. new_letter .. new_number .. ".odm")

        --t.EnterMap = "mm3" .. new_letter .. new_number .. ".odm";
        --t.EnterSide = opposite
        --t.X = 0 -- t.X - 1000*dx
        --t.Y = 0 --t.Y - 1000*dy
    end

    if t.LeaveMap == "wer.odm" and t.LeaveSide == "up" then
        t.EnterMap = "mm3a2.odm";
    end
end

--[[
    Hi everyone!

Could enyone help?

I'm using MMExtension, MMeditor, MMArchive, mmarch to make a one mod for MM7. I have a couple of questions.

1. How can I make a "map" for a new outdoor map? Right now full map looks like a black square without player's arrow. Automap is red with an arrow.

2. Is there any guides about making internal maps?
]]