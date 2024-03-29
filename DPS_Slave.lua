ThreadSpeed = 50;--- How long the thread will sleep after every tick
Owner = "MrFade";  ---Declaring the owner of this plugin
Name = "Dps_Slave";  --- Plugin Name

Player = GetPlayer();  -- Returns the current Player wUnit;
Units = GetUnitsList(); -- returns a list of all current wUnits (includes players).
Players = GetPlayersList(); -- returns a list of all current players.

MasterName = "MasterNameHere"; -- You would change this to the name of your master char!
YardsBehindMaster = 3 --- This is how many yards behind the master the slave must stay!

function FindMaster()

FoundMaster = FindPlayerByName(MasterName);
    -- This is outdated FindPlayerByName is far cleaner!
	--foreach PlayersAround in Players do  -- Loop through every object near the player	 
	--	if GetUnitReaction(Player,PlayersAround) == 5  then  --- we are checking to see that each playerAround is friendly to the player.
	--	  if PlayersAround.Name == MasterName then --- Checking to see what player matches our masters name then saving that wUnit.
	--	   FoundMaster = PlayersAround;
	--	  end
	--	end;
	--end;
end

function DistanceOfMeshToMaster()

if FoundMaster.IsFalling() then
 Log("Master is falling !");
 return 0;
end;


CurrentPath = GetCurrentPath();
CurrentPathSize = GetCurrentPathSize();
if CurrentPath.Length < CurrentPathSize then
 FindMeshPathToUnit(FoundMaster);
Log("No path yet...");
 return 100;
end


MyVecFloatArray = VecToFloatArray(CurrentPath[CurrentPathSize-1]);
FoundMasterFloatArray = UnitPosToFloatArray(FoundMaster);
Distance = DistanceBetweenPoints(FoundMasterFloatArray,MyVecFloatArray);
--Log(Distance);
return Distance;
end



if IsUnitValid(FoundMaster) then


    if FoundMaster.TargetGuid.IsEmpty() ~= true and CompareGUID(Player.TargetGuid, FoundMaster.TargetGuid) == false then
	  Log("Targeting master target");
	   TargetUnit(FindUnitByGUID(FoundMaster.TargetGuid));
	end
	
end




if IsUnitValid(FoundMaster) then   -- checking to see if our Unit is valid before anything else.	  	

	   if (GetBOTState() == "Pathing" or GetBOTState() == "Idle") and DistanceToUnit(Player,FoundMaster) > YardsBehindMaster then  --- checking our bot state then checking if we are more than YardsBehindMaster yards from our master if we are we generate a path to him.
		 FindMeshPathToUnit(FoundMaster);       -- Generating a path to our master.
		 SetBOTState("PathingToMaster");    --- Setting our state so we dont spam.
	   end;
	   
	   
	   if GetBOTState() == "PathingToMaster" and  DistanceOfMeshToMaster() < YardsBehindMaster and DistanceToUnit(Player,FoundMaster) < YardsBehindMaster then
			SetBOTState("TooCloseToMaster")
			StopMoving();
	    else
		  if GetBOTState() == "TooCloseToMaster" and DistanceOfMeshToMaster() > YardsBehindMaster then
    		  FindMeshPathToUnit(FoundMaster);       -- Generating a path to our master. 
			  SetBOTState("PathingToMaster");    --- Setting our state so we dont spam.
		  end
		end
	   
	   
	   if GetBOTState() == "PathingToMaster" then    ---- Calling our path tick.
		   Path();	  
	   end;
	   
	   if GetBOTState() == "Done" then   ---- We have reached the end of our path.
		SetBOTState("Pathing");
	   end;	     
	   
	   if FoundMaster.CastID == 8690 and Player.IsCasting == false then   --- Check if our master is casting Hearthstone if he is use the item as well !
	    Log("Our master is using its hearthstone following!!!");
		UseItem("Hearthstone");
	   end;	   	   
else
Log("Looking for master");
FindMaster();   --- Call FindMaster to rescan for our master.
end