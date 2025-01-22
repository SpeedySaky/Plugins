bool HasItem(string ItemName) // Returns True if the player has the passed item name in their bags.



string GetWEPWUser(); // Returns the current username of the logged in WEPW user.


int ItemCount(string ItemName) // Returns the stack count of itemName in the players bags.



string GetPlayerClass(); // Returns a string with the class of the player IE "Druid".


Log(string Message) // Prints info to WEPWs log.



bool LoadRotation(string RotationName) // Attempts to load the passed rotation name - returns false if fails.



WoWUnit GetPlayer(); // Returns the local Player WoWUnit.


CastSpell(string Name); // Attempts to cast the passed spell.


UseMacro(string MacroName); // Attempts to trigger the passed MacroName.


bool UnitHasAura(WowUnit Unit, string AuraName); // Returns True if the passed WoWunit has AuraName active. False otherwise.


List<WoWUnit> GetUnitsList() // Returns a list of all Loaded units in the object manager.



List<WowObject> GetObjects(); // Returns a list of all loaded Objects in the Object manager.


List<WowUnit> GetPlayersList() // returns a list of all loaded Players in the Object Manager.



InteractWithObject(WoWObject Object); // Interacts with the passed Object. Consider this clicking the passed WoWObject in-game.


InteractWithUnit(WoWUnit Unit); // Interacts with the passed Unit. Consider this clicking the passed unit in-game.


SleepPlugin(int MS); // Sleeps the plugin thread for MS.


bool IsObjectBobbing(WoWObject Object); // Returns true if the passed WoWObject has the bobbing Flag set. (Used for fishing bobber.)


bool IsObjectValid(WowObject Object); // Returns true if the object is still valid in-game and in memory.


string GetBOTState(); // Returns the current BOT state IE OffPathToGather etc etc...


SetBOTState(string State); // Sets the BOT state to the passed string.


SendKey(int KeyCode int Delay); // Sends the KeyCode to your WoW client for Delay ms.



FaceUnit(WowUnit Unit); // Turns the player in-game to face the passed WoWUnit.


int GetStuckTime(); // Returns the current stuck count.


bool IsObjectOwnedByPlayer(WoWObject Object); // Returns true if the passed Object is owned by the player. IE a fishing bobber is owned by the player.


Path(); // Basic path call that will follow the last generation mesh path. So you would generate a path then call Path(); each thread tick to run the generated path.


int GetCurrentPoint(); // Returns the current Point in the path the BOT is on.


int GetCurrentPathSize(); // Returns how many points are in the current path.


bool FindMeshPathToUnit(WowUnit Unit); // Generates a mesh path to the passed Unit. You would then call Path(); after this to run the generated Path.


bool FindMeshPathToObject(WowObject Object); // Generates a mesh path to the passed Object. You would then call Path(); to run the path.


bool IsUnitValid(WowUnit Unit); // Returns true if the unit is valid in memory and in-game. IE the unit hasn't unloaded.


bool FindMeshPathToPoint(float X, float Y, float Z); // generates a mesh path to the passed X,Y,Z.


TargetUnit(WoWUnit Unit); // Targets the passed Unit.


WowUnit GetTargetUnit(); // Returns the players current target.


UseCommand(string Command); // attempts to use keybindable commands.

// Commands here :
// https://wowpedia.fandom.com/wiki/BindingID


BlackListPoint(X, Y, Z); // Blacklists the passed point in the meshes. in a circle of roughly ~8 yards.


int GetUnitReaction(WoWUnit Unit, WoWUnit Unit); // Returns the unit reaction between the passed units. 

public enum UnitReaction
{
    Unknown = -1,
    Hated = 0,
    Hostile = 1,
    Unfriendly = 2,
    Neutral = 3,
    Friendly = 4,
    Honored = 5,
    Revered = 6,
    Exalted = 7
}



bool CompareGUID(WowGuid GUID, WowGuid GUID); Returns true if the passed GUIDs are equal.
 

WowUnit FindUnitByGUID(WowGuid GUID); // Returns the WowUnit with the passed GUID.


int DistanceToUnit(WoWUnit Unit, WoWUnit Unit); // Returns the distance between the two passed Units. IE DistanceToUnit(Player,Target);


int DistanceBetweenPoints(Float[] P1, Float[] P2); // Returns the distance between the passed points.


float[] UnitPosToFloatArray(WoWUnit Unit); // Returns the Units position as a float[].


float[] VecToFloatArray(Vector3 Vector); // Converts a Vector3 to a float[];


Vector3 FloatToVec(float x, float y, float z); // Converts the passed X,Y,Z values into a Vector3.


UseItem(string Item); // Attempts to use the passed ItemName.


float GetZ(float X, Float Y); // attempts to use the meshes to calcuate the height at the given X & Y values.


StopMoving(); // Stops the player from moving forward.


WoWGuid[] GetUnitGUIDBlackList(); // Returns all the currently blacklisted GUIDs.


BlackListUnitGUID(WowUnit Unit); // Addes the passed WoWUnit to the blacklist. (It wont be consider for looting / combat etc)


int GetZoneID(); // Returns Zone ID of player.


int GetMapID(); // Returns the Map ID of the player.


int GetAreaID(); // Returns the Area ID of the player.


Vector3 GetCorpsePos(); // Returns the current players corpse's X,Y,Z values if the player is dead.


bool IsUnitLootable(WoWUnit Unit); // Returns true if the passed Unit is lootable.


bool IsInWorld();  // Returns true if the client is in-game IE not in a loading screen etc.


int FreeBagSpace(); // returns the current free bag space of the player.


bool HasSpell(int SpellID); // Returns true if the players Spell book contains the passed spell ID.


string GetLastMessage(); // Returns the last error message displayed in-game IE "you are facing the wrong way.".


bool IsPointInWater(float x, float y, float z); // Loads Meshes. Returns True if the passed X,Y,Z values are in Water.


WowUnit FindPlayerByName(String Name); // Returns the WoWUnit Player with the Passed Name.


WowUnit FindUnitByName(string Name); // Return the WoWUnit Unit with the passed name.


WowObject FindObjectByName(string Object); // Returns the WowObject Object with the passed Name.


public NPCInfo(string name, int id, int Level, int Health, int zoneID, List<Vector3> spawns, int mapID)
{
    Name = name;
    ID = id;
    level = Level;
    health = Health;
    ZoneID = zoneID;
    WSpawns = spawns;
    MapID = mapID;
}


NPCInfo GetNearestRepair(); // Returns the nearest Repair vendor according to the Database.


NPCInfo GetNearestVendor(); // Returns the nearest Sell Vendor according to the Database.


NPCInfo GetNearestClassTrainer(); // Returns the nearest player class trainer according to the Database.


BlackListRepairVendorByName(string RepairVendorName); // Blacklists the passed RepairVendor name (it wont be consider when querying the Database for nearest Repair vendor.)


RemoveBlackListedRepairVendorByName(string RepairVendorName); // Removes the passed Repair Vendor Name from the blacklist.


BlackListSellVendorByName(string Name); // Blacklists the passed Sell Vendor by name. (The vendor will not be considered when querying the Database by GetNearestVendor())


RemoveBlackListedSellVendorByName(); // Removes the passed Sell Vendor Name from the blacklist.


bool ItemHasEnch(int Slot, string Name); // Checks if the players equipment slot has the passed ench name.

public enum EquipmentSlot
{
    Head = 0,
    Neck = 1,
    Shoulder = 2,
    Shirt = 3,
    Chest = 4,
    Waist = 5,
    Legs = 6,
    Feet = 7,
    Wrist = 8,
    Hands = 9,
    Ring1 = 10,
    Ring2 = 11,
    Trinket1 = 12,
    Trinket2 = 13,
    Back = 14,
    MainHand = 15,
    OffHand = 16,
    Extra = 17,
    Tabard = 18,
    Maximum = 19
}



// Find Ench names here :
// https://wago.tools/db2/SpellItemEnchantment?build=1.15.1.53623&filter[Name_lang]=fish&page=1


int GetCreatureType(WoWUnit Unit); // Returns the CreatureType of the passed Unit. 

public enum CreatureType
{
    None = 0,
    Beast = 1,
    Dragonkin = 2,
    Demon = 3,
    Elemental = 4,
    Giant = 5,
    Undead = 6,
    Humanoid = 7,
    Critter = 8,
    Mechanical = 9,
    NotSpecified = 10,
    Totem = 11,
    NonCombatPet = 12,
    GasCloud = 13,
    WildPet = 14,
    Aberration = 15
}


bool IsUnitSkinnable(WowUnit Unit); // Returns true if the passed WowUnit is Skinnable.



bool PopMessage(string Message); // Displays an information prompt with the passed Message.


float[] GetNPCPostionFromDB(int NpcID) // Returns a float[] array with X,Y,Z positions of the request NPC_id (queries database).



SetQuestSellVendors(list<int> Vendors)  /// Sets the sell vendors for the questing profile. If this is not set the BOT will use the database to determine the nearest Sell vendor.


SetQuestRepairVendors(list<int> Repairvendors) // Sets the Repair vendors list for a questing profile if this is not set the BOT will use the database to fetch the nearest Repair vendor.



SetQuestRepairAt(int ItemDurability) // Sets the item durability % that the BOT will repair at (default 30).



SetQuestSellAt(int FreeSlots) // Sets the amount of free slots the BOT much have in order to sell. (Default 2).



int DumpQuestSellAt() // returns the current SellAt value (the amount of free slots the BOT will sell at.)



int DumpQuestRepairAt() // Returns the item durability % (as an int) the BOT must have before attempting to repair.



bool RemoveNameFromObjectAvoidWhiteList(string ObjectName) // Removes the Object name from the avoidance WHITELIST (the object will be avoided). Returns true if the name was on the list false otherwise.



bool AddNameToObjectAvoidWhiteList(string Name) // Adds Object name to the avoidance whitelist (the object WILL NOT be avoided).



bool AddNameToAvoidWhiteList(string Name) // Adds the name of a NPC to the avoidance whitelist (the NPC WILL NOT BE avoided.)



bool RemoveNameFromAvoidWhiteList(string Name) // Removes NPC name from Avoidance whitelist (the NPC WILL BE avoided.)



SetFood(string FoodName, int EatAt) /// FoodName -> The Item name the BOT must use to eat.  EatAt -> The HP value the BOT must have (or less than) to eat.


SetDrink(string DrinkName, int DrinkAt) // DrinkName -> The Item the BOT must use to drinking. DrinkAt -> The % of Power/Mana the BOT must drink at.



StartMobAvoidance(); // Starts the avoidance thread


QuestGoToPoint(float X, float Y, float Z, Bool AutoLoot = false, FightMobs = true) // Paths to the X,Y,Z value. Autoloot (false by default) if true will loot any lootable mobs along the way. FightMobs (true by default) if true will attack any mobs that agro the MOB along the way.



StopQuestProfile(); // Stops the current quest profile.


bool HasPlayerFinishedQuest(int QuestID) // Returns true if the player has Finished the passed quest ID.



bool CanTurnInQuest(int QuestID) // Returns True if the player has completed all objectives for the given quest ID.



public class QuestReturnInfo  // Returned by more complex quest API calls to help debug.
{
    public bool Sucessful = false;
    public int TimeInSeconds = 0;
    public string FailReason = "";
}


QuestReturnInfo AcceptQuestFrom(int QuestGiver, int QuestID) /// Queries the database for the spawn location of QuestGiver ID. The BOT will then attempt to path to the spawn location and interact with the QuestGiver and attempt to accept QuestID.


QuestReturnInfo TurnInQuestAt(int QuestTurnIn, int QuestID) // Queries database for QuestTurnIn spawn location paths there and attempts to interact with QuestTurnIn in order to turn in QuestID.



public class QuestObjective
{
    public int ObjIndex = 1;
    public int ObjEndCount = 1;
    public int AmountObjs = 1;
    public string Type = ""; //KillMobIDs - Gather Obj / etc etc
    public int QuestID = 0;
    public List<int> MobIDs = null;  // This will be used for multie mob searching
    public List<NPCDB.NPCInfo> NpcList = null;  // This will be used for better searching as well ! 
    public List<ObjDB.ObjectInfo> ObjectList = null; /// This will be used for better scanning objects ie NODES etc etc;
    public List<int> ObjIDs = null; // Multi Object searching
    public List<Vector3> CustomSpawns = null;
    public string UseItemName = ""; /// The item name we must use !
    public int AuraID = 0; // IE only use item when unit has AURA 
}


QuestObjective CreateObjective(string Type, int ObjIndex, int ObjCount, int AmountObjs, int QuestID, List<int> MobIDs, List<int> ObjIDs, List<Vector3> CustomSpawns);

/// I'll write more on this later lol sorry
/// This is mostly handled all entirely by the database now days but it is still possible to manaully create your objectives here is an old-ish guide on it:
//  https://automationvault.forumflash.com/forums/topic/1834-guide-to-making-a-quest-profile-from-a-noobs-perspective/


List<Vectors> TableToVecList(Table) // Used to convert a lua Table to a List of Vectors.



float[] TableToFloatArray(Table) // Used to convert a lua table to an array of float.



List<int> TableToList(Table) // Used to convert a lua table to an List of ints.



List<string> TableToStringList(Table) // Used to convert a lua table to a list of strings.



SellItemsAt(int SellAt) // Sets the amount of free slots the BOT must have before attempting to sell.



bool IsOnQuest(int QuestID) // returns true if the player has the passed QuestID in their quest log.



LoadAndRunQuestProfile(string Name) // Stops the current quest profile and loads and starts the passed profile name.



QuestReturnInfo GrindUntilLvl(int Lvl, QuestObjective MyObj, Bool AutoLoot = false) // Grinds mobs defined in the QuestObjective until the player reaches the passed Lvl. If Auto-loot is set to true the BOT will loot any lootable mobs.



QuestReturnInfo KillMobsUntilItem(string ItemName, QuestObjective MyObj, int ItemCount = 1) // Grinds mobs defined in the QuestObjective until the BOT has ItemCount of ItemName in its bags.



QuestReturnInfo QuestTrainAt(int TrainerID = 0, string TrainerName = "") // if trainer ID is passed the BOT will query the database for its spawn location path there and attempt to train. If TrainerName is passed the BOT will scan all LOADED NPCs (everything within render distance) for TrainerName if it finds it, it will path to it and attempt to train otherwise it will fail. 



QuestFlyToPoint(float X, Float Y, Float Z, float HeightOffset) /// The BOT will attempt to Path to the given point using the flight meshes.


QuestReturnInfo CompleteEntireQuest(int QuestID) /// The BOT will query the Database for ALL information regarding the quest and handle it all - From Accepting - to Objectives - To turning in the quest. (This is what the Auto-Quester features is based on.)


QuestReturnInfo AcceptQuestUsingDB(int Quest) //  now supports accepting quests from game objects, units and items. If the quest is started by a quest item the BOT will attempt to determine how to get that item (grinding/gathering) once it has done that it will accept the quest from the item and then return.



QuestReturnInfo TurnInQuestUsingDB(int QuestID) // Will QUery the Database for the quest turn in of the passed QuestID path there and turn in the Quest.



CompleteObjectiveOfQuest(int QuestID, int ObjectiveIndex) // Queries all the objective information from the Database based on the QuestID and attempts to complete the given quest objective. indexing starts a 1.



QuestReturnInfo GrindAreaUntilLevel(int Level) // The BOT will loop through all loaded NPCs in the area and determine the best MOB to grind until the player reaches the passed Level. 



UseDBToRepair(bool state = true) // if true the BOT will use the Database to determine the nearest RepairVendor and use that to repair. if false the BOT will rely on the SetQuestRepairVendors list.



UseDBToSell(bool state = true) // if true the BOT will use the Database to determine the nearest SellVendor and use that. If false the BOT will rely on the SetQuestSellVendors list.



NPCInfo GetNearestClassTrainer(); // Queries the Database and returns the NpcInfo of the nearest class trainer of the player.


QuestReturnInfo TrainAtNearestClassTrainer(); // Queries the Database for the nearest class trainer of the player's class and attempts to path to it and train.


QuestReturnInfo GrindAndGather(List<int> Spawns, int TargetRadius, float[] StartingPoint, bool SkinMobs = false); // This is the API point that the Map feature uses. 
                                                                                                                  // List<Int> Spawns -> IDs of things that you want to kill / gather.
                                                                                                                  // int TargetRadius -> The Radius around StartingPoint you want to farm in.
                                                                                                                  // StartingPoint -> The Starting point that the Radius is based around.
                                                                                                                  // SkinMobs -> If true it will skin all skinable mobs (false by default.)


// Queries all Spawns IDs from the Database for spawn locations.


IgnoreLowLevelQuests(bool state = true) // If the this is set to true AcceptQuestUsingDB and other "Complete" questing APIs will ignore quests that are consider grey to the player. This improves players running questing profiles from random points.



BlackListRepairVendorByName(string Name) /// Blacklists the Repair vendor name - This Repair vendor will no longer be consider when searching for a valid Repair vendor.


RemoveBlackListedRepairVendorByName(string Name) /// Removes the repair vendor from the blacklist. This repair vendor will once again be consider when looking for a near by RepairVendor.


BlackListSellVendorByName(string Name) // Blacklists the Sell Vendor name. The Vendor sell name will now longer be consider when searching for a near by vendor to sell at.



RemoveBlackListedSellVendorByName(string Name) // Removes the SellVendor name from the blacklist. This vendor will once again be consi


WowUnit WhoIsAttackingMe(); // Returns the Unit that the BOT would consider a combat target. (This unit is in-combat with us for some reason or other.)

int SkillMax(string SkillName); // Returns the current Max value of the skill the player can currently have.
int SkillValue(string SkillName); // Returns the current values of the Skill.
bool HasSkill(string SkillName); // Returns if the player has the current Skill IE Fishing.


string GetLootMethod(); // Returns a string of the current looting method.
bool IsPartyLFG(); // Returns if the current party was created by LFG.
bool IsInGroup(); // Returns if the player is currently in a group/party.
int GetNumGroupMembers(); // Returns the amount of members in your current group/party.
WowUnit GetPartyLeader(); // Returns the current Party leader unit.
List<WowUnit> GetPartyMembers(); // Returns a list of Units of everyone in your party.
WoWUnit GetPartyTank(); // Returns the WowUnit who has the role Tank -> Only works in RDF.


    while true do
        --If the player is in combat, do nothing
        if player.InCombat then
            PluginSleep(10);
        else
    --If there are lootable units, loot them
            if AnyUnitsLootable() then
                LootUnits()

                -- Add a delay to wait for the looting to finish
                PluginSleep(1000)  -- Wait for the loot window to appear in-game this sets the player.IsLooting bool

                while player.IsLooting() do -- Wait for the looting window in-game to go away, this sets the IsLooting bool to false;.
                    PluginSleep(10)
                end
            else
                -- If there are no lootable units, target the closest unit
                TargetClosestUnit()
            end
        end
    end
end


                Here's a list of all classes and their corresponding numbers:
1.	Warrior - 1
2.	Paladin - 2
3.	Hunter - 3
4.	Rogue - 4
5.	Priest - 5
6.	Death Knight - 6
7.	Shaman - 7
8.	Mage - 8
9.	Warlock - 9
10.	Monk - 10
11.	Druid - 11
12.	Demon Hunter - 12