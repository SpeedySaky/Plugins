ThreadSpeed = 500;
Owner = "SpeedySaky";
Name = "Potion usage";
Player = GetPlayer();

-- Log player name and level at the start of the plugin
local playerName = Player.Name;
local playerLevel = Player.Level;
Log("Player Name: " .. playerName .. ", Player Level: " .. playerLevel);

-- Define the potion names
local healthPotions = { "Major Healing Potion", "Superior Healing Potion", "Greater Healing Potion", "Healing Potion", "Lesser Healing Potion", "Minor Healing Potion" };
local manaPotions = { "Major Mana Potion", "Superior Mana Potion", "Greater Mana Potion", "Mana Potion", "Lesser Mana Potion", "Minor Mana Potion" };

-- Define the thresholds for using potions
local healthThreshold = 70; -- Use health potion if health is below 70%
local manaThreshold = 30; -- Use mana potion if mana is below 30%

-- Define the cooldown time for potions (in milliseconds)
local potionCooldown = 125000; -- 125 seconds

-- Initialize the last used time for potions
local lastPotionUseTime = 0;

function HasItem(itemName)
    -- Check if the player has the item in their inventory
    return Api.Inventory.HasItem(itemName)
end

function UseItem(itemName)
    -- Use the item from the player's inventory
    return Api.Inventory.Use(itemName)
end

function UsePotions()
    -- Get the current time
    local currentTime = os.time() * 1000; -- Convert to milliseconds

    -- Check if the potion cooldown has expired
    if currentTime - lastPotionUseTime >= potionCooldown then
        -- Get the player's current health and mana percentages
        local currentHealth = Player.HealthPercent;
        local currentMana = Player.ManaPercent;

        Log("Current Health: " .. currentHealth .. "%, Health Threshold: " .. healthThreshold .. "%");
        Log("Current Mana: " .. currentMana .. "%, Mana Threshold: " .. manaThreshold .. "%");

        -- Check if the player needs to use a health potion
        if currentHealth < healthThreshold then
            for _, healthPotionName in ipairs(healthPotions) do
                if HasItem(healthPotionName) then
                    Log("Using health potion: " .. healthPotionName);
                    UseItem(healthPotionName);
                    lastPotionUseTime = currentTime; -- Update the last used time
                    return; -- Exit the function to avoid using both potions at the same time
                else
                    Log("Health potion not found: " .. healthPotionName);
                end
            end
        end

        -- Check if the player needs to use a mana potion
        if currentMana < manaThreshold then
            for _, manaPotionName in ipairs(manaPotions) do
                if HasItem(manaPotionName) then
                    Log("Using mana potion: " .. manaPotionName);
                    UseItem(manaPotionName);
                    lastPotionUseTime = currentTime; -- Update the last used time
                    return; -- Exit the function to avoid using both potions at the same time
                else
                    Log("Mana potion not found: " .. manaPotionName);
                end
            end
        end
    else
        -- Calculate the remaining cooldown time
        local remainingCooldown = potionCooldown - (currentTime - lastPotionUseTime);
        Log("Potions are on cooldown. Time remaining: " .. math.ceil(remainingCooldown / 1000) .. " seconds.");
    end
end

-- Example usage
if Player.IsInCombat ~= true then
    UsePotions();
end
Sleep(2000);
