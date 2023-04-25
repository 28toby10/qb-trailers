local QBCore = exports["qb-core"]:GetCoreObject()
local notfindtrailer = true
local globalSearch = function()
    return GetVehicleInDirection(GetEntityCoords(PlayerPedId()), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0))
end

attachKey = 51 -- Index number for attach key - http://docs.fivem.net/game-references/controls/

function GetVehicleInDirection(cFrom, cTo)
    local rayHandle = CastRayPointToPoint(cFrom.x, cFrom.y, cFrom.z, cTo.x, cTo.y, cTo.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

CreateThread(function()
    while true do
        Wait(0)
        local ped = GetPlayerPed(-1) -- Made the whole thing forgot to add this line lol, maybe thats why it broke #4:32AMLife
        local veh = GetVehiclePedIsIn(ped)
        if veh ~= nil then
            for i = 1, #Config.BoatCanTrail do
                if GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == Config.BoatCanTrail[i]['boat'] then -- After a few hours here at 4am GetDisplayNameFromVehicleModel() got it working well :P
                    local belowFaxMachine = GetOffsetFromEntityInWorldCoords(veh, 1.0, 0.0, -1.0)
                    local boatCoordsInWorldLol = GetEntityCoords(veh)
                    local trailerLoc = GetVehicleInDirection(boatCoordsInWorldLol, belowFaxMachine)
                    
                    if GetDisplayNameFromVehicleModel(GetEntityModel(trailerLoc)) == "BOATTRAILER" then -- Is there a trailer????
                        if IsEntityAttached(veh) then -- Is boat already attached?
                            exports['qb-core']:DrawText(Lang:t("task.detach"))
                            if IsControlJustReleased(1, attachKey) then -- detach
                                DetachEntity(veh, false, true)
                                Wait(2500)
                                exports['qb-core']:HideText()
                            end
                        else
                            exports['qb-core']:DrawText(Lang:t("task.attach"))
                            if IsControlJustReleased(1, attachKey) then -- Attach
                                AttachEntityToEntity(veh, trailerLoc, 20, Config.BoatCanTrail[i]['position'].x, Config.BoatCanTrail[i]['position'].y, Config.BoatCanTrail[i]['position'].z, 0.0, 0.0, 0.0, false, false, true, false, 20, true)
                                TaskLeaveVehicle(ped, veh, 64)
                                Wait(2500)
                                exports['qb-core']:HideText()
                            end
                        end
                    end
                end
            end
        end
    end
end)

RegisterCommand('attach', function()
    local veh = GetVehiclePedIsIn(PlayerPedId())
    local havetobreak = false
    if veh ~= nil and veh ~= 0 then
        local belowFaxMachine = GetOffsetFromEntityInWorldCoords(veh, 1.0, 0.0, -1.0)
        local vehicleCoordsInWorldLol = GetEntityCoords(veh)
        havefindclass = false
        testnb = 0.0
        while notfindtrailer do
            local trailerfind = GetVehicleInDirection(vector3(vehicleCoordsInWorldLol.x, vehicleCoordsInWorldLol.y, vehicleCoordsInWorldLol.z), vector3(belowFaxMachine.x, belowFaxMachine.y, belowFaxMachine.z - testnb))
            testnb = testnb + 0.1
            if not startdecompte then
                startdecompte = true
                SetTimeout(5000, function()
                    if trailerfind ~= 0 and trailerfind ~= nil then
                        startdecompte = false
                        QBCore.Functions.Notify(Lang:t("error.trailer_not_found"), "error")
                        havetobreak = true
                    end
                end)
            end
            if havetobreak then
                break
            end
            Wait(0)
        end
        if tonumber(trailerfind) ~= 0 and trailerfind ~= nil then
            for k, v in pairs(Config.VehicleCanTrail) do
                if v.name == GetDisplayNameFromVehicleModel(GetEntityModel(trailerfind)) then
                    for x, w in pairs(v.class) do
                        if w == GetVehicleClass(veh) then
                            havefindclass = true
                        end
                    end
                    if havefindclass then
                        AttachEntityToEntity(veh, trailerfind, GetEntityBoneIndexByName(trailerfind, 'chassis'), GetOffsetFromEntityGivenWorldCoords(trailerfind, vehicleCoordsInWorldLol), 0.0, 0.0, 0.0, false, false, true, false, 20, true)
                        TaskLeaveVehicle(PlayerPedId(), veh, 64)
                    else
                        QBCore.Functions.Notify(Lang:t("error.cannot_attach"), "error")
                    end
                end
            end
            trailerfind = nil
            notfindtrailer = true
        else
            QBCore.Functions.Notify(Lang:t("error.trailer_not_found"), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t("error.not_in_vehicle"), "error")
    end
end)
RegisterCommand('detach', function()
    if IsPedInAnyVehicle(PlayerPedId(), true) then
        local veh = GetVehiclePedIsIn(PlayerPedId())
        if DoesEntityExist(veh) and IsEntityAttached(veh) then
            DetachEntity(veh, true, true)
            notfindtrailer = true
            trailerfind = nil
        else
            QBCore.Functions.Notify(Lang:t("error.vehicle_not_found"), "error")
        end
    else
        local vehicleintrailer = globalSearch()
        if tonumber(vehicleintrailer) ~= 0 and vehicleintrailer ~= nil and IsEntityAttached(vehicleintrailer) then
            DetachEntity(vehicleintrailer, true, true)
            notfindtrailer = true
            trailerfind = nil
        else
            QBCore.Functions.Notify(Lang:t("error.trailer_not_found"), "error")
        end
    end
end)
RegisterCommand('openramp', function()
    local trailerfind = globalSearch()
    if tonumber(trailerfind) ~= 0 and trailerfind ~= nil then
        if GetDisplayNameFromVehicleModel(GetEntityModel(trailerfind)) == 'TRAILER' then
            SetVehicleDoorOpen(trailerfind, 4, false, false)
        end
        trailerfind = nil
        notfindtrailer = true
    else
        QBCore.Functions.Notify(Lang:t("error.trailer_not_found"), "error")
    end
end)
RegisterCommand('closeramp', function()
        local trailerfind = globalSearch()
        if tonumber(trailerfind) ~= 0 and trailerfind ~= nil then
            if GetDisplayNameFromVehicleModel(GetEntityModel(trailerfind)) == 'TRAILER' then
                SetVehicleDoorShut(trailerfind, 4, false, false)
            end
            trailerfind = nil
            notfindtrailer = true
        else
            QBCore.Functions.Notify(Lang:t("error.trailer_not_found"), "error")
        end
    end)
RegisterCommand('opentrunk', function()
        local trailerfind = globalSearch()
        if tonumber(trailerfind) ~= 0 and trailerfind ~= nil then
            if GetDisplayNameFromVehicleModel(GetEntityModel(trailerfind)) == 'TRAILER' then
                SetVehicleDoorOpen(trailerfind, 5, false, false)
            end
            trailerfind = nil
            notfindtrailer = true
        else
            QBCore.Functions.Notify(Lang:t("error.trailer_not_found"), "error")
        end
    end)
RegisterCommand('closetrunk', function()
    local trailerfind = globalSearch()
    if tonumber(trailerfind) ~= 0 and trailerfind ~= nil then
        if GetDisplayNameFromVehicleModel(GetEntityModel(trailerfind)) == 'TRAILER' then
            SetVehicleDoorShut(trailerfind, 5, false, false)
        end
        trailerfind = nil
        notfindtrailer = true
    else
        QBCore.Functions.Notify(Lang:t("error.trailer_not_found"), "error")
    end
end)


function GetVehicleInDirection(cFrom, cTo)
    trailerfind = nil
    notfindtrailer = true
    local rayHandle = CastRayPointToPoint(cFrom.x, cFrom.y, cFrom.z, cTo.x, cTo.y, cTo.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    if vehicle == 0 then
        notfindtrailer = true
    else
        notfindtrailer = false
        trailerfind = vehicle
    end
    return trailerfind
end
