ThreadSpeed = 50 -- How long the thread will sleep after every tick
Owner = "MrFade + SpeedySaky + erizzle" -- Declaring the owner of this plugin
Name = "Healing BOT + Looting + Clear Target" -- Plugin Name M

--ATTENTION
--MAKE A MACRO Named: "ClearTarget" Macro Content: "/cleartarget"

Player = GetPlayer() -- Returns the current Player wUnit
Units = GetUnitsList() -- Returns a list of all current wUnits (includes players)
Players = GetPlayersList() -- Returns a list of all current players

MasterName = "Testiemctest" -- You would change this to the name of your master char!
YardsBehindMaster = 8 -- This is how many yards behind the master the slave must stay!
YardsToHealUnits = 41 -- This is how many yards away from the player the BOT will target other players to heal

function FindMaster()
    FoundMaster = FindPlayerByName(MasterName)
end

function DistanceOfMeshToMaster()
    if FoundMaster and FoundMaster.IsFalling() then
        Log("Master is falling!")
        return 0
    end

    CurrentPath = GetCurrentPath()
    CurrentPathSize = GetCurrentPathSize()
    if CurrentPath.Length < CurrentPathSize then
        FindMeshPathToUnit(FoundMaster)
        Log("No path yet...")
        return 100
    end

    MyVecFloatArray = VecToFloatArray(CurrentPath[CurrentPathSize-1])
    FoundMasterFloatArray = UnitPosToFloatArray(FoundMaster)
    Distance = DistanceBetweenPoints(FoundMasterFloatArray, MyVecFloatArray)
    return Distance
end

function LootNearbyMobs()
    Units = GetUnitsList()
    foreach Unit in Units do
        if (Unit.Health == 0) and (IsUnitValid(Unit) == true) and (IsUnitLootable(Unit) == true) and Player.IsInCombat == false then
            if DistanceToUnit(Player, Unit) <= 100 then
                Log("Lootable " .. Unit.Name .. " found at position " .. Unit.Position)
                StopMoving()
                FindMeshPathToUnit(Unit)
                SetBOTState("PathingToLoot")

                -- Wait until we reach the unit
                while GetBOTState() == "PathingToLoot" and DistanceToUnit(Player, Unit) > 1 do
                    Path()
                    Sleep(25) -- Reduced delay for smoother pathing
                end

                if DistanceToUnit(Player, Unit) <= 5 then -- Verify we reached the lootable unit
                    TargetUnit(Unit) -- Target the lootable unit
                    Log("Targeted lootable unit: " .. Unit.Name)
                    InteractWithUnit(Unit) -- Loot the unit
                    Log("Looted unit: " .. Unit.Name)
                    Sleep(3000) -- Wait for loot to complete
                else
                    Log("Failed to reach lootable unit.")
                end
            end
        end
    end
end

Max = 100
HealTarget = nil -- Initialize HealTarget to nil
PartyMembers = GetPartyMembers() -- Get the list of party members

-- Check health of party members and include it in the healing logic
foreach Member in PartyMembers do
    if Member and GetUnitReaction(Member, Player) == 4 and DistanceToUnit(Player, Member) < YardsToHealUnits then
        if Member.HealthPercent < Max and Member.IsDead() ~= true then
            Max = Member.HealthPercent
            HealTarget = Member -- Storing the lowest unit health
        end
    end
end

if HealTarget and IsUnitValid(HealTarget) and HealTarget.HealthPercent < 90 then -- Check if the HealTarget's health is below 90%
    TargetUnit(HealTarget) -- Target the unit
    Log("Healing target: " .. HealTarget.Name .. " with health: " .. HealTarget.HealthPercent)
    -- More Healing Logic would go here
elseif Player.Target then
    local TargetUnit = GetTargetUnit()
    if TargetUnit and GetUnitReaction(TargetUnit, Player) == 4 and TargetUnit.HealthPercent >= 90 then
        Log("Make a macro!!!! MacroName = ClearTarget MacroContent: /cleartarget")
        Sleep(1000) -- Adding a 1-second delay before clearing the target
        UseMacro("ClearTarget")
        Log("Clearing target as health is above 90% or no valid heal target found.")
    end
end

if IsUnitValid(FoundMaster) then -- Checking to see if our Unit is valid before anything else
    if (GetBOTState() == "Pathing" or GetBOTState() == "Idle" or GetBOTState() == "UpdateQuestState") and DistanceToUnit(Player, FoundMaster) > YardsBehindMaster then -- Checking our bot state then checking if we are more than YardsBehindMaster yards from our master; if we are, we generate a path to him
        FindMeshPathToUnit(FoundMaster) -- Generating a path to our master
        SetBOTState("PathingToMaster") -- Setting our state so we don't spam
    end

    if GetBOTState() == "PathingToMaster" and DistanceOfMeshToMaster() < YardsBehindMaster and DistanceToUnit(Player, FoundMaster) < YardsBehindMaster then
        SetBOTState("TooCloseToMaster")
        StopMoving()
    else
        if GetBOTState() == "TooCloseToMaster" and DistanceOfMeshToMaster() > YardsBehindMaster then
            FindMeshPathToUnit(FoundMaster) -- Generating a path to our master
            SetBOTState("PathingToMaster") -- Setting our state so we don't spam
        end
    end

    if GetBOTState() == "PathingToMaster" then -- Calling our path tick
        Path()
    end

    if GetBOTState() == "Done" then -- We have reached the end of our path
        SetBOTState("Pathing")
    end
    
else
    Log("Looking for master")
    FindMaster() -- Call FindMaster to rescan for our master
end

-- Perform looting if not in combat
if Player.IsInCombat ~= true then
    LootNearbyMobs()
end

-- Basic example of a healing BOT written entirely in our API
