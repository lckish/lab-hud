local speed = 0.0
local seatbeltOn = false
local cruiseOn = false
-- Variable
local currVeh = 0; 
local cruiseEnabled, seatbeltEnabled = false, false;
local vehData = {
    hasBelt = false,
    engineRunning = false,

    currSpd = 0.0,
    cruiseSpd = 0.0,
    prevVelocity = {x = 0.0, y = 0.0, z = 0.0}, 
};
inVehicle = false
local inair = 0
local cruiseSpeeding = 0
local bleedingPercentage = 0
local stam = 100
local defaultAspectRatio = 1920/1080 -- Don't change this.
local resolutionX, resolutionY = GetActiveScreenResolution()
local aspectRatio = resolutionX/resolutionY
local minimapOffset = 0
if aspectRatio > defaultAspectRatio then
    minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
end
--212 leaks--
local toggleHud = true
--212 leaks--
RegisterNetEvent('lab-hud:toggleHud')
AddEventHandler('lab-hud:toggleHud', function(toggleHud1)
    toggleHud = toggleHud1
end)
--212 leaks--
AddEventHandler("pma-voice:radioActive", function(isRadioTalking)
    radioTalking = isRadioTalking
end)
--212 leaks--
local idplayer = 0
Citizen.CreateThread(function()
    idplayer = GetPlayerServerId(PlayerId())
    while true do
        Citizen.Wait(800)
        TriggerEvent('esx_status:getStatus', 'hunger',function(status) 
            hunger = status.val / 10000 
        end)
        TriggerEvent('esx_status:getStatus', 'thirst',function(status)
            thirst = status.val / 10000 
        end)
        TriggerEvent('esx_status:getStatus', 'stress',function(status)
            stress = status.val / 10000 
        end)
        if stress == nil then 
            stress = 0
        end
    end
end)
--212 leaks--
Citizen.CreateThread(function()
    Citizen.Wait(500)
    while true do 
        if ESX ~= nil and isLoggedIn and RCHud.Show then
            local playerId = PlayerId()
            local isTalking = NetworkIsPlayerTalking(PlayerId())
            local veh = GetVehiclePedIsUsing(PlayerPedId(), false)
            local speed = math.floor(GetEntitySpeed(veh) * 3.6)
            if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
                local pos = GetEntityCoords(GetPlayerPed(-1))
                local engine = GetVehicleEngineHealth(GetVehiclePedIsIn(GetPlayerPed(-1)))
                SetVehRadioStation(GetVehiclePedIsIn(PlayerPedId(),true), "OFF")
                SendNUIMessage({
                    action = "hudtick",
                    incar =  true,
                    show = IsPauseMenuActive(),
                    health = GetEntityHealth(GetPlayerPed(-1)),
                    armor = GetPedArmour(GetPlayerPed(-1)),
                    thirst = thirst,
                    hunger = hunger,
                    stress = stress,
                    seatbelt = seatbeltOn,
                    oxygen = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10,
                    idplayer2 = idplayer,
                    speed = speed,
                    engineHealth = engine,
                    togglehud = toggleHud,
                    talking = isTalking
                })
                inVehicle  = true
            else
                SendNUIMessage({
                    action = "hudtick",
                    show = IsPauseMenuActive(),
                    health = GetEntityHealth(GetPlayerPed(-1)),
                    armor = GetPedArmour(GetPlayerPed(-1)),
                    incar =  false,
                    thirst = thirst,
                    hunger = hunger,
                    stress = stress,
                    idplayer = idplayer,
                    seatbelt = seatbeltOn,
                    oxygen = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10,
                    togglehud = toggleHud,
                    talking = isTalking
                })
            end
            Citizen.Wait(500)
        end
    end
end)

--212 leaks--
local voiceS = 7.0
RegisterNetEvent('updatevoice')
AddEventHandler('updatevoice', function(val)
	SendNUIMessage({
        action = "UpdateProximity", 
        prova = val,
    })
	voiceS = val * 2
end)
--212 leaks--
Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    SetRadarBigmapEnabled(false, false)
    while true do
		Wait(1000) --magari rimettere a 0 dal riavvio
		Citizen.InvokeNative(0xF6E48914C7A8694E, minimap, "SETUP_HEALTH_ARMOUR")
		Citizen.InvokeNative(0xC3D0841A0CC546A6,3)
		Citizen.InvokeNative(0xC6796A8FFA375E53 )
    end
end)
--212 leaks--
Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)
    Citizen.Wait(500)
    SetRadarZoom(1000)
    SetRadarBigmapEnabled(false, false)
end)
