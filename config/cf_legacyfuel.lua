
Configtanken = {}
Configtanken.UseESX = true
Configtanken.JerryCanCost = 200
Configtanken.RefillCost = 100 -- If it is missing half of it capacity, this amount will be divided in half, and so on.
Configtanken.FuelDecor = "_FUEL_LEVEL"
Configtanken.DisableKeys = {0, 22, 23, 24, 29, 30, 31, 37, 44, 56, 82, 140, 166, 167, 168, 170, 288, 289, 311, 323}
Configtanken.EnableHUD = false
Configtanken.ShowNearestGasStationOnly = true
Configtanken.ShowAllGasStations = false
Configtanken.CostMultiplier = 2.0
Configtanken.Strings = {
	ExitVehicle = "Verlasse das Fahrzeug um zu tanken",
	EToRefuel = "~g~E ~w~um das Fahrzeug zu tanken",
	JerryCanEmpty = "Kanister ist leer",
	FullTank = "Tank ist voll",
	PurchaseJerryCan = "~g~E ~w~um einen Kanister zu kaufen | Kosten:~g~€" .. Configtanken.JerryCanCost,
	CancelFuelingPump = "~g~E ~w~um das Tanken abzubrechen",
	CancelFuelingJerryCan = "~g~E ~w~um das Tanken abzubrechen",
	NotEnoughCash = "Nicht genug Geld",
	RefillJerryCan = "~g~E ~w~um den Kanister nach zu tanken | Kosten:~g~€",
	NotEnoughCashJerryCan = "Nicht genug Geld um den Kanister nach zu tanken",
	JerryCanFull = "Kanister ist voll",
	TotalCost = "Kosten",
}

if not Configtanken.UseESX then
	Configtanken.Strings.PurchaseJerryCan = "Dr&uumlcke ~g~E ~w~um einen Kanister zu kaufen."
	Configtanken.Strings.RefillJerryCan = "Dr&uumlcke ~g~E ~w~ um den Kanister nach zu f&uumlllen."
end

Configtanken.PumpModels = {
	[-2007231801] = true,
	[1339433404] = true,
	[1694452750] = true,
	[1933174915] = true,
	[-462817101] = true,
	[-469694731] = true,
	[-164877493] = true
}

Configtanken.Blacklist = {
	--"Adder",
	--276773164
}

Configtanken.RemoveHUDForBlacklistedVehicle = true
Configtanken.Classes = {
	[0] = 0.4, -- Compacts
	[1] = 0.4, -- Sedans
	[2] = 0.4, -- SUVs
	[3] = 0.4, -- Coupes
	[4] = 0.4, -- Muscle
	[5] = 0.4, -- Sports Classics
	[6] = 0.4, -- Sports
	[7] = 0.4, -- Super
	[8] = 0.4, -- Motorcycles
	[9] = 0.4, -- Off-road
	[10] = 0.4, -- Industrial
	[11] = 0.4, -- Utility
	[12] = 0.4, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 0.0, -- Boats
	[15] = 0.0, -- Helicopters
	[16] = 0.4, -- Planes
	[17] = 0.4, -- Service
	[18] = 0.4, -- Emergency
	[19] = 0.4, -- Military
	[20] = 0.4, -- Commercial
	[21] = 0.4, -- Trains
}
Configtanken.FuelUsage = {
	[1.0] = 1.4,
	[0.9] = 1.2,
	[0.8] = 1.0,
	[0.7] = 0.9,
	[0.6] = 0.8,
	[0.5] = 0.7,
	[0.4] = 0.5,
	[0.3] = 0.4,
	[0.2] = 0.2,
	[0.1] = 0.1,
	[0.0] = 0.0,
}

Configtanken.GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253)
}