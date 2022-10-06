local storagename = "whitelist-system.txt"

function getAllWhitelistedIds(ply, cmd, args)
    local group = ply:GetUserGroup()
        if group == "projektleitung" or group == "admin" then
            local content = file.Read(storagename, "DATA")
            return ply:ChatPrint(content)
        else
            return false
        end
end

local function getIDFromFile(steamID64)
    if !file.Exists(storagename, "DATA") then
        print("[Whitelist System] Die Datei existiert nicht!") 
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

local function addToWhitelist( ply, cmd, args )
	if args[1] != nil then
        local id = args[1]
        local group = ply:GetUserGroup()
        if group == "projektleitung" or group == "admin" then
            if getIDFromFile(id) then
                MsgN("[Whitelist System] Dieser Spieler ist bereits auf der Whitelist!")
            else
                local content = file.Read(storagename, "DATA")
                local playerr = player.GetBySteamID64(id)
                file.Append(storagename, "\n".. id)
                MsgN("[Whitelist System] Der Spieler mit der SteamID64 " .. id .. " wurde zur Whitelist hinzugefügt!")
            end
        else
            return false
        end
    else
        MsgN("[Whitelist System] Du musst eine ID angeben!")
	end
end


local function removeFromWhitelist( ply, cmd, args )
	if args[1] != nil then
        local id = args[1]
        local group = ply:GetUserGroup()
        if group == "projektleitung" or group == "admin" then
            if getIDFromFile(id) then
                local content = file.Read(storagename, "DATA")
                local newContent = string.gsub(content, id, "")
                file.Write(storagename, newContent)
                MsgN("[Whitelist System] Der Spieler mit der SteamID64 " .. id .. " wurde von der Whitelist entfernt!")
            else
                MsgN("[Whitelist System] Dieser Spieler ist nicht auf der Whitelist!")
            end
        else
            return false
        end
    else
        MsgN("[Whitelist System] Du musst eine ID angeben!")
	end
end

local function whitelistHelp(ply, cmd, args)
    print("\n\nWhitelist System Hilfe:")
    print("whitelist-add <SteamID64> - Fügt einen Spieler zur Whitelist hinzu")
    print("whitelist-remove <SteamID64> - Entfernt einen Spieler von der Whitelist")
    print("whitelist-list - Gibt alle Whitelist IDs aus\n\n")
    return ""
end

hook.Add("CheckPassword", "IDCheck", function(steamID64, ipAdress, svPassword, clPassword, name)
    if getIDFromFile(steamID64) then
        return true
    else
        return false, "\n\n      ========== Whitelist System ==========\n                   Du bist nicht auf der Whitelist!\n\n"
    end
end)


concommand.Add( "whitelist", whitelistHelp)
concommand.Add( "whitelist-add", addToWhitelist)
concommand.Add( "whitelist-remove", removeFromWhitelist)
concommand.Add( "whitelist-list", getAllWhitelistedIds)