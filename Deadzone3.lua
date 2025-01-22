ThreadSpeed = 1000;
Owner = "SpeedySaky";
Name = "Deadzone";
Player = GetPlayer();

-- Log player name and level at the start of the plugin
local playerName = Player.Name;
local playerLevel = Player.Level;
Log("Player Name: " .. playerName .. ", Player Level: " .. playerLevel);

local isMoving = false;
local targetPosition = nil;

function GetPlayerAndTargetLocation()
    -- Get the player's position
    local playerPosition = UnitPosToFloatArray(Player);
    Log("Player Position: X=" .. playerPosition[1] .. " Y=" .. playerPosition[2] .. " Z=" .. playerPosition[3]);

    -- Get the target unit
    local target = GetTargetUnit();
    if target ~= nil then
        -- Get the target's position
        targetPosition = UnitPosToFloatArray(target);
        Log("Target Position: X=" .. targetPosition[1] .. " Y=" .. targetPosition[2] .. " Z=" .. targetPosition[3]);

        -- Calculate the distance between the player and the target
        local distance = DistanceBetweenPoints(playerPosition, targetPosition);
        Log("Distance to Target: " .. distance);

        -- If the distance is less than 10 yards and the player is not already moving, move the player to a position more than 15 yards away
        if distance < 10 and not isMoving then
            local directionX = playerPosition[1] - targetPosition[1];
            local directionY = playerPosition[2] - targetPosition[2];
            local magnitude = math.sqrt(directionX * directionX + directionY * directionY);
            local scale = 15 / magnitude;

            local newX = playerPosition[1] + directionX * scale;
            local newY = playerPosition[2] + directionY * scale;
            local newZ = playerPosition[3]; -- Keep the same Z coordinate for simplicity

            Log("Moving player to new position: X=" .. newX .. " Y=" .. newY .. " Z=" .. newZ);
            if FindMeshPathToPoint(newX, newY, newZ) then
                Log("Path found, moving player.");
                isMoving = true;
            else
                Log("Failed to find path to new position.");
            end
        end
    else
        Log("No target selected.");
    end
end

function CheckIfPlayerReachedTarget()
    if isMoving and targetPosition ~= nil then
        -- Get the player's current position
        local playerPosition = UnitPosToFloatArray(Player);
        -- Calculate the distance to the target position
        local distanceToTarget = DistanceBetweenPoints(playerPosition, targetPosition);
        Log("Distance to Target Position: " .. distanceToTarget);
        if distanceToTarget < 1 then -- Adjust the threshold as needed
            Log("Player reached the target position.");
            StopMoving();
            FaceUnit(GetTargetUnit());
            isMoving = false;
            targetPosition = nil;
        elseif distanceToTarget > 10 then
            Log("Target is more than 10 yards away, stopping movement.");
            StopMoving();
            FaceUnit(GetTargetUnit());
            isMoving = false;
            targetPosition = nil;
        else
            Log("Continuing to move towards target.");
            Path();
        end
    end
end

-- Example usage
if Player.IsInCombat ~= true then
    GetPlayerAndTargetLocation();
end
CheckIfPlayerReachedTarget();
Sleep(2000);







