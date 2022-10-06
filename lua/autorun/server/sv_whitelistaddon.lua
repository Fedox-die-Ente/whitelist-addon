local storagename = "whitelist-system.txt"

function getIDFromFile(steamID64)
    if !file.Exists(storagename, "DATA") then
        print("File does not exist!") 
    else
        local content = file.Read(storagename, "DATA")
        local containsId = string.find(content, steamID64)
        if containsId != nil then
            return true
        else
            return false
        end
    end
end

hook.Add("CheckPassword", "IDCheck", function(steamID64, ipAdress, svPassword, clPassword, name)
    if getIDFromFile(steamID64) then
        return true
    else
        return false, "\n\n      ========== Whitelist System ==========\n                   Du bist nicht auf der Whitelist!\n\n"
    end
end)

--getIDFromFile()