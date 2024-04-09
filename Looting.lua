ThreadSpeed = 500;
Owner = "SpeedySaky";
Name = "LootMaster";
Player = GetPlayer();

function FindMeshPathToUnit(targetUnit)
    -- Assuming the necessary variables and functions are available in this scope
    if targetUnit.IsFalling() then
        Log("Target is falling !");
        return 0;
    end;

    CurrentPath = GetCurrentPath();
    CurrentPathSize = GetCurrentPathSize();
    if CurrentPath.Length < CurrentPathSize then
        FindMeshPathToUnit(targetUnit);
        Log("No path yet...");
        return 100;
    end

    MyVecFloatArray = VecToFloatArray(CurrentPath[CurrentPathSize-1]);
    targetUnitFloatArray = UnitPosToFloatArray(targetUnit);
    Distance = DistanceBetweenPoints(targetUnitFloatArray,MyVecFloatArray);
    return Distance;
end

function LootNearbyMobs() 
    local previousState = GetBOTState()
    SetBOTState("Looting");
    
    Units = GetUnitsList();
    foreach Unit in Units do
        if (Unit.Health == 0) and (IsUnitValid(Unit)== true) and (IsUnitLootable(Unit) == true) then
            if DistanceToUnit(Player,Unit) <= 100 then
                Log("Lootable " .. Unit.Name .. " found at position " .. Unit.Position);
                StopMoving()
                FindMeshPathToUnit(Unit); 
                InteractWithUnit(Unit);
                Sleep(3000)
            end
        end;         
    end; 

    SetBOTState(previousState);
end 

if (Player.IsInCombat ~= true) then
    LootNearbyMobs();
end
Sleep(2000);
