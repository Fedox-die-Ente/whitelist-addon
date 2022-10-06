hook.Add("OnPlayerChat", "WhitelistCommand", function(ply, text, isTeam, isDead)
    if text == "!whitelist" then
        local Frame = vgui.Create( "DFrame" )
        Frame:SetTitle( "========================= Whitelist Menü ======================== ")
        Frame:SetSize( 500,150 )
        Frame:Center()			
        Frame:MakePopup()
        Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
            draw.RoundedBox( 10, 0, 0, w, h, Color( 48, 48, 46, 150 ) ) -- Draw a red box instead of the frame
        end
            

        local entry = vgui.Create("DTextEntry", Frame)
        entry:SetPos(10, 5 + (150 - 30 - 50) + 5)
        entry:SetSize(500-20, 20)
        entry:SetPlaceholderText("Hier die Steam64ID vom Spieler angeben.")

        local status = vgui.Create("DTextEntry", Frame)
        status:SetPos(10, 30)
        status:SetPlaceholderText("Status: -/-")
        status:SetSize(500-20, 20)
        status:SetDisabled(true)
        status.OnEnter = function(s)
            s:SetText("")
            notification.AddLegacy("Nachricht wurde gesendet!", 3, 2)
        end

        local Button = vgui.Create("DButton", Frame)
        Button:SetText( "Hinzufügen" )
        Button:SetTextColor( Color(0, 0, 0) )
        Button:SetPos( 0 + 200 - 5 - 100, 30 + (150 - 30 - 50) + 5 )
        Button:SetSize( 100, 30 )
        Button.Paint = function( self, w, h )
            draw.RoundedBox( 5, 0, 0, w, h, Color( 99, 255, 74, 250 ) ) -- Draw a blue button
        end
        Button.DoClick = function()
            local group = ply:GetUserGroup()
            if group == "projektleitung" or group == "admin" then
                local BounceSound = Sound( "garrysmod/balloon_pop_cute.wav" )
                sound.Play( BounceSound, ply:GetPos(), 100, 100, 100 )
                local steam64id = entry:GetText()
                entry:SetText("")
                status:SetText("Der Spieler wurde erfolgreich hinzugefügt!")
                RunConsoleCommand("whitelist-add", steam64id)
                notification.AddLegacy("Der Spieler wurde hinzugefügt, falls er es noch nicht ist.", 3, 5)
            else
                status:SetText("Du hast keine Berechtigung, um diesen Befehl auszuführen!")
                notification.AddLegacy("Du hast keine Berechtigung, um diesen Befehl auszuführen!", 3, 5)
            end
        end

        local Button2 = vgui.Create("DButton", Frame)
        Button2:SetText( "Entfernen" )
        Button2:SetTextColor( Color(0, 0, 0) )
        Button2:SetPos( 0 + 300 + 5, 30 + (150 - 30 - 50) + 5 )
        Button2:SetSize( 100, 30 )
        Button2.Paint = function( self, w, h )
            draw.RoundedBox( 5, 0, 0, w, h, Color( 255, 74, 74, 250 ) ) -- Draw a blue button
        end
        Button2.DoClick = function()
            local group = ply:GetUserGroup()
            if group == "projektleitung" or group == "admin" then
                local BounceSound = Sound( "garrysmod/balloon_pop_cute.wav" )
                sound.Play( BounceSound, ply:GetPos(), 100, 100, 100 )
                local steam64id = entry:GetText()
                entry:SetText("")
                status:SetText("Der Spieler wurde erfolgreich entfernt!")
                RunConsoleCommand("whitelist-remove", steam64id)
                notification.AddLegacy("Der Spieler wurde entfernt, falls er hinzugefügt worden ist.", 3, 5)
            else
                status:SetText("Du hast keine Berechtigung, um diesen Befehl auszuführen!")
                notification.AddLegacy("Du hast keine Berechtigung, um diesen Befehl auszuführen!", 3, 5)
            end
        end

        local Button3 = vgui.Create("DButton", Frame)
        Button3:SetText( "Liste" )
        Button3:SetTextColor( Color(0, 0, 0) )
        Button3:SetPos( 0 + 200, 30 + (150 - 30 - 50) + 5 )
        Button3:SetSize( 100, 30 )
        Button3.Paint = function( self, w, h )
            draw.RoundedBox( 5, 0, 0, w, h, Color( 236, 255, 61, 250 ) ) -- Draw a blue button
        end
        Button3.DoClick = function()
            local group = ply:GetUserGroup()
            if group == "projektleitung" or group == "admin" then
                local BounceSound = Sound( "garrysmod/balloon_pop_cute.wav" )
                sound.Play( BounceSound, ply:GetPos(), 100, 100, 100 )
                status:SetText("Die Whitelist wurde in die Konsole und in den Chat geschrieben!")
                RunConsoleCommand("whitelist-list")
                notification.AddLegacy("Die Whitelist wurde in die Konsole und in den Chat geschrieben!", 3, 5)
            else
                status:SetText("Du hast keine Berechtigung, um diesen Befehl auszuführen!")
                notification.AddLegacy("Du hast keine Berechtigung, um diesen Befehl auszuführen!", 3, 5)
            end
        end

        return true
    end
end)

