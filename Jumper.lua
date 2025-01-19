ThreadSpeed = 1000; -- Set the thread speed to 1000 milliseconds (1 second)
Owner = "SpeedySaky";
Name = "Jumper";
Player = GetPlayer();

-- Log player name and level at the start of the plugin
local playerName = Player.Name;
local playerLevel = Player.Level;
Log("Player Name: " .. playerName .. ", Player Level: " .. playerLevel);

local minJumpInterval = 10000; -- Minimum interval in milliseconds (10 seconds)
local maxJumpInterval = 20000; -- Maximum interval in milliseconds (20 seconds)
local lastJumpTime = os.time() * 1000; -- Record the start time in milliseconds
local nextJumpInterval = math.random(minJumpInterval, maxJumpInterval); -- Randomize the first jump interval

function JumpPlayer()
    Log("Player is jumping.");
    SendKey(32, 50); -- Send the spacebar key (32) with a delay of 50ms
end

function ShouldJump()
    local target = GetTargetUnit();
    local attacker = WhoIsAttackingMe();

    if Player.Auras.Contains("Drink") or Player.Auras.Contains("Food") then
        Log("Player is drinking or eating, skipping jump.");
        return false;
    end

    if target ~= nil and attacker == nil then
        Log("Targeting a unit but not being attacked, allowing jump.");
        return true;
    elseif attacker ~= nil then
        Log("Player is in combat, skipping jump.");
        return false;
    end

    return true;
end

-- Main loop
while true do
    local currentTime = os.time() * 1000; -- Get the current time in milliseconds
    if currentTime - lastJumpTime >= nextJumpInterval then
        if ShouldJump() then
            JumpPlayer();
            lastJumpTime = currentTime; -- Update the last jump time
            nextJumpInterval = math.random(minJumpInterval, maxJumpInterval); -- Randomize the next jump interval
            Log("Next jump in " .. nextJumpInterval .. " milliseconds.");
        end
    end
    SleepPlugin(ThreadSpeed); -- Sleep for a short duration to prevent high CPU usage
end















