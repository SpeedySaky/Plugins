ThreadSpeed = 50;--- How long the thread will sleep after every tick
Owner = "MrFade";  ---Declaring the owner of this plugin
Name = "Dps_Slave";  --- Plugin Name

Player = GetPlayer();  -- Returns the current Player wUnit;
Units = GetUnitsList(); -- returns a list of all current wUnits (includes players).
Players = GetPlayersList(); -- returns a list of all current players.

MasterName = "Xhael"; -- You would change this to the name of your master char!
YardsBehindMaster = 3 --- This is how many yards behind the master the slave must stay!

if HasPlayerFinishedQuest(363) then
Log("Finished Quest");
else
Log("Not Finished");
end;