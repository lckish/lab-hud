
Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}
--212 leaks--
isLoggedIn = true
--212 leaks--
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
--212 leaks--
RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function()
    isLoggedIn = true
    RCHud.Show = true

    Wait(3200)
    local defaultAspectRatio = 1920/1080
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX/resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
    end
    local minimap = RequestScaleformMovie("minimap")
    RequestStreamedTextureDict("squaremap", false)
    if not HasStreamedTextureDictLoaded("squaremap") then
        Wait(100) 
    end
    SetMinimapClipType(0)
    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
    AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
    SetMinimapComponentPosition("minimap", "L", "B", 0.0 + minimapOffset, -0.047, 0.1638, 0.183)

    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0 + minimapOffset, 0.0, 0.128, 0.20)

    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.01 + minimapOffset, 0.025, 0.262, 0.300)
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetRadarBigmapEnabled(true, false)
    SetMinimapClipType(0)
    Wait(50)
    SetRadarBigmapEnabled(false, false)
    DisplayRadar(false)
end)
--212 leaks--
local prop
RegisterNetEvent('createpropradio')
AddEventHandler('createpropradio', function(value)
    if value then 
        local hash = GetHashKey("prop_cs_hand_radio")
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(100)
            RequestModel(hash)
        end
        prop = CreateObject(hash, GetEntityCoords(PlayerPedId()), true, true, true)
        SetEntityCompletelyDisableCollision(prop, false, false)
        AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.13, 0.01, -0.04, -38.0, -233.0, -273.0, true, true, false, false, 1, true)
    else
        DeleteEntity(prop)
    end
end)

local mappachiusa = false
CreateThread(function()
    Wait(1000)
    while true do
        Citizen.Wait(2000)
        SetRadarZoom(1150)
        
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            DisplayRadar(true)
            mappachiusa = false
        elseif mappachiusa == false then
            mappachiusa = true
            DisplayRadar(false)
        end

    end
end)
--212 leaks--
--212 leaks--
--212 leaks--
--212 leaks--
--212 leaks--

