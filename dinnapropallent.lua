print("Run Lua script dinnapropallent.")

local API = require("api")
--[[
#Script Name:   <dinnapropallent.>
# Description:  <Collects Dino Propellant at anachronia by collecting an Inv full of dinos
                then feeds them and turns it itno propallant. best to start it with an empty inv >
# Autor:        <Saša>
# Version:      <1.0>
# Date:        <04.08.23>
--]]

-- gather station
local gatherd = 123400
-- feeding station 

local dinoData = {
    yellow = { tile = { x = 5330, y = 2271 }, id = 123407, invid = 53081 },
    brown = { tile = { x = 5288, y = 2259 }, id = 123409, invid = 53082 },
    violet = { tile = { x = 5312, y = 2305 }, id = 123405, invid = 53080 },
    pink = { tile = { x = 5333, y = 2292 }, id = 123403, invid = 53079 },
}

-- finishd product fertilizer to burn
local fertilizer = 53078
local tummisaurus = 56281
-- anti idle
local afk = os.time()

function idleCheck()
    local timeDiff = os.difftime(os.time(), afk)
    local randomTime = math.random(180, 280) -- between 3 and 4.66 minutes 

    if timeDiff > randomTime then
        -- do stuff here...  turn camera, send keys, move mouse w/e
        API.PIdle2()
        afk = os.time()
    end
end



function GatherDino()
    print("gather dinos")
    API.DoAction_Tile(WPOINT.new(5304, 2276, 0))
    API.RandomSleep2(300, 300, 450)
    API.WaitUntilMovingEnds()
    API.RandomSleep2(300, 300, 450)
    API.DoAction_Object1(0x2d, 0, {gatherd}, 50)
    API.RandomSleep2(300, 300, 450)
    API.WaitUntilMovingEnds()
end

-- Exported function list is in API
-- main loop
API.Write_LoopyLoop(true)
while (API.Read_LoopyLoop()) do

    -- idle check 
    idleCheck()
    API.RandomEvents()

    if not API.InvFull_() and not API.CheckInvStuff2(fertilizer) then
        -- Collects Dinos at the storm barn   
        if not API.CheckAnim(80) and not API.ReadPlayerMovin2() then
            print("Gathering Dinos at the storm barn")
            GatherDino()
            API.RandomSleep2(300, 300, 450)
        end
    end

    if API.InvItemcount_1(fertilizer) == 27 then
        -- Burning Fertilizer
        if not API.CheckAnim(40) and not API.ReadPlayerMovin2() then
            print("Burning Fertilizer")
            API.KeyboardPress2(0x51, 50, 90) -- pressing q on action bar
            API.RandomSleep2(300, 400, 500)
        end
    end

    if API.InvItemcount_1(tummisaurus) == 27 then
        -- feed brown dino
        if not API.CheckAnim(40) and not API.ReadPlayerMovin2() then
            print("feed brown dino")
            API.DoAction_Object1(0x2f, 0, {dinoData.brown.id}, 50);
            API.RandomSleep2(300, 300, 450)
            API.WaitUntilMovingEnds()
            API.RandomSleep2(300, 300, 450)

        end

    end
    if API.InvItemcount_1(dinoData.brown.invid) == 27 then
        -- feed brown dino
        if not API.CheckAnim(20) and not API.ReadPlayerMovin2() then
            print("feed yellow dino")
            API.DoAction_Tile(WPOINT.new(5310 + API.Math_RandomNumber(3), 2285 + API.Math_RandomNumber(3), 0))
            API.RandomSleep2(300, 300, 450)
            API.WaitUntilMovingEnds()
            API.RandomSleep2(300, 300, 450)
            API.DoAction_Object1(0x2f, 0, {dinoData.yellow.id}, 50);
            API.RandomSleep2(300, 300, 450)
            API.WaitUntilMovingEnds()
            API.RandomSleep2(300, 300, 450)

        end

    end

    if API.InvItemcount_1(dinoData.yellow.invid) == 27 then
        -- feed brown dino
        if not API.CheckAnim(20) and not API.ReadPlayerMovin2() then
            print("feed pink dino")
            API.DoAction_Object1(0x2f, 0, {dinoData.pink.id}, 50);
            API.RandomSleep2(300, 300, 450)
            API.WaitUntilMovingEnds()
            API.RandomSleep2(300, 300, 450)

        end

    end

    if API.InvItemcount_1(dinoData.pink.invid) == 27 then
        -- feed brown dino
        if not API.CheckAnim(20) and not API.ReadPlayerMovin2() then
            print("feed violet dino")
            API.DoAction_Object1(0x2f, 0, {dinoData.violet.id}, 50);
            API.RandomSleep2(300, 300, 450)
            API.WaitUntilMovingEnds()
            API.RandomSleep2(300, 300, 450)

        end

       

        
        API.RandomSleep2(500, 1000, 1550)
    end
end
