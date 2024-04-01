RCHud = {}

RCHud.Show = true

systemNotify = function (msg)
    ESX.ShowNotification(msg)
end

RegisterNetEvent('lab-hud:client:notify', function(msg)
    systemNotify(msg)
end)

RCHud.Radar = {}
RCHud.Radar.NoRadarVehicles = {
    "bmx",
    "cruiser",
    "fixter",
    "scorcher",
    "tribike",
    "tribike2",
    "tribike3",
}

RCHud['useKM'] = true

RCHud['seatbeltInput'] = 29  -- b
RCHud['seatbeltEjectSpeed'] = 45.0 
RCHud['seatbeltEjectAccel'] = 60.0 

RCHud['cruiseInput'] = 20 

RCHud['BeltClass'] = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = false,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = false,
    [14] = false,
    [15] = false,
    [16] = false,
    [17] = true,
    [18] = true,
    [19] = true,
};
--212 leaks--