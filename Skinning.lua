ThreadSpeed = 500;
Owner = "Speedysaky";
Name = "Skinning";
Player = GetPlayer();

function FindMeshPathToUnit(targetUnit)
    local interactionRange = 5 -- Set this to your game's interaction range

    -- Check if the unit is already within interaction range
    local distance = DistanceToUnit(Player, targetUnit)
    if distance <= interactionRange then
        Log("Target is within interaction range.")
        return distance
    end

    if targetUnit.IsFalling() then
        Log("Target is falling !")
        return 0
    end

    CurrentPath = GetCurrentPath()
    CurrentPathSize = GetCurrentPathSize()
    if CurrentPath.Length < CurrentPathSize then
        FindMeshPathToUnit(targetUnit)
        Log("No path yet...")
        return 100
    end

    MyVecFloatArray = VecToFloatArray(CurrentPath[CurrentPathSize-1])
    targetUnitFloatArray = UnitPosToFloatArray(targetUnit)
    Distance = DistanceBetweenPoints(targetUnitFloatArray,MyVecFloatArray)
    return Distance
end

function SkinNearbyMobs() 
    local previousState = GetBOTState()
    SetBOTState("Skinning");
    
    Units = GetUnitsList();
    local skinnableUnits = {}

    foreach Unit in Units do
        if (Unit.Health == 0) and (IsUnitValid(Unit)== true) and (IsUnitSkinnable(Unit) == true) then
            local distance = DistanceToUnit(Player,Unit)
            table.insert(skinnableUnits, {unit=Unit, distance=distance})
        end;         
    end; 

    -- Sort the skinnable units by distance
    table.sort(skinnableUnits, function(a, b) return a.distance < b.distance end)

   foreach item in skinnableUnits do
    if Player.IsInCombat then
        Log("Player entered combat, stopping skinning.")
        break
    end
    Log("Skinnable " .. item.unit.Name .. " found at position " .. item.unit.Position);
    StopMoving()
    FindMeshPathToUnit(item.unit); 
    InteractWithUnit(item.unit);
    Sleep(3000)
end


    SetBOTState(previousState);
end 

    SetBOTState(previousState);
end 

if (Player.IsInCombat ~= true) then
    SkinNearbyMobs();
end
Sleep(2000);
