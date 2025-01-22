-- Set the thread speed and plugin details
ThreadSpeed = 1000
Owner = "SpeedySaky"
Name = "Fishing Example"

-- Get the current player unit
Player = GetPlayer()

-- Function to log player information
function LogPlayerInfo()
    -- Use pcall to catch any errors
    local status, err = pcall(function()
        -- Get player username
        local username = GetWEPWUser()
        if username == nil then
            error("GetWEPWUser returned nil")
        end
        Log("Username: " .. username)

        -- Define a list of auras to check
        local aurasToCheck = {"AuraName1", "AuraName2", "AuraName3"}

        -- Check each aura
        for _, auraName in ipairs(aurasToCheck) do
            local hasAura = UnitHasAura(Player, auraName)
            if hasAura == nil then
                error("UnitHasAura returned nil for " .. auraName)
            end
            Log("Has " .. auraName .. ": " .. tostring(hasAura))
        end
    end)

    -- If there was an error, log it
    if not status then
        Log("Error in LogPlayerInfo: " .. err)
    end
end

-- Log player information once
LogPlayerInfo()



