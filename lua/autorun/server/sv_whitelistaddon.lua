local storagename = "whitelist-system.txt"

function getIDFromFile(steamID64)
    if !file.Exists(storagename, "DATA") then
        print("File does not exist!") 
    else
        local content = file.Read(storagename, "DATA")
        local containsId = string.find(content, "hello")
        if containsId != nil then
            return true
        else
            return false
        end
    end
end

hook.Add("CheckPassword", "IDCheck", function(steamID64, ipAdress, svPassword, clPassword, name)
    
end)

getIDFromFile()