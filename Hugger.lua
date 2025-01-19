ThreadSpeed = 3000; -- Set the thread speed to 3000 milliseconds (3 seconds)
Owner = "SpeedySaky";
Name = "Hugger";
Player = GetPlayer();

-- Log player name and level at the start of the plugin
local playerName = Player.Name;
local playerLevel = Player.Level;
Log("Player Name: " .. playerName .. ", Player Level: " .. playerLevel);

local isMoving = false;
local targetPosition = nil;

function IsUnitAlive(unit)
    return IsUnitValid(unit) and unit.Health > 0 and not unit.IsGhost
end

function GetPlayerAndTargetLocation()
    -- Get the player's position
    local playerPosition = UnitPosToFloatArray(Player);
    Log("Player Position: X=" .. playerPosition[1] .. " Y=" .. playerPosition[2] .. " Z=" .. playerPosition[3]);

    -- Get the target unit
    local target = GetTargetUnit();
    if target ~= nil and IsUnitAlive(target) then
        -- Get the target's position
        targetPosition = UnitPosToFloatArray(target);
        Log("Target Position: X=" .. targetPosition[1] .. " Y=" .. targetPosition[2] .. " Z=" .. targetPosition[3]);

        -- Calculate the distance between the player and the target
        local distance = DistanceBetweenPoints(playerPosition, targetPosition);
        Log("Distance to Target: " .. distance);

        -- If the distance is greater than 3 yards, move the player to a position within 5 yards
        if distance > 3 then
            Log("Target is more than 3 yards away, moving closer.");
            InteractWithUnit(target);
            isMoving = true;
        elseif distance <= 5 then
            Log("Target is within 5 yards, stopping Hugger.");
            isMoving = false;
            targetPosition = nil;
        end
    else
        Log("No target selected or target is not alive.");
    end
end

function CheckIfPlayerReachedTarget()
    if isMoving and targetPosition ~= nil then
        -- Get the player's current position
        local playerPosition = UnitPosToFloatArray(Player);
        -- Calculate the distance to the target position
        local distanceToTarget = DistanceBetweenPoints(playerPosition, targetPosition);
        Log("Distance to Target Position: " .. distanceToTarget);
        if distanceToTarget <= 4 then -- Adjust the threshold as needed
            Log("Player reached the target position.");
            StopMoving();
            FaceUnit(GetTargetUnit());
            isMoving = false;
            targetPosition = nil;
        elseif distanceToTarget >= 5 then
            Log("Target is more than 5 yards away, moving closer.");
            InteractWithUnit(GetTargetUnit());
        end
    end
end

-- Main loop
while true do
    Log("Starting main loop iteration.");
    local status, err = pcall(function()
        GetPlayerAndTargetLocation();
        if isMoving then
            CheckIfPlayerReachedTarget();
        end
    end)
    if not status then
        Log("Error in main loop: " .. err);
    end
    Sleep(ThreadSpeed);
end
