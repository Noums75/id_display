local showingIDs = false

RegisterCommand('id', function()
    showingIDs = true
    ShowPlayerIDs()

    SetTimeout(10000, function()
        showingIDs = false
    end)
end, false)

function ShowPlayerIDs()
    CreateThread(function()
        while showingIDs do
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for _, player in ipairs(GetActivePlayers()) do
                if player ~= PlayerId() then
                    local targetPed = GetPlayerPed(player)
                    local targetCoords = GetEntityCoords(targetPed)
                    local dist = #(playerCoords - targetCoords)

                    if dist <= 30.0 and HasEntityClearLosToEntity(playerPed, targetPed, 17) then
                        local screen, x, y = World3dToScreen2d(targetCoords.x, targetCoords.y, targetCoords.z + 1.3)
                        if screen then
                            DrawText3D(x, y, "ID : " .. GetPlayerServerId(player))
                        end
                    end
                end
            end

            Wait(0)
        end
    end)
end

function DrawText3D(x, y, text)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.3, 0.3)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(tostring(text))
    DrawText(x, y)
end
