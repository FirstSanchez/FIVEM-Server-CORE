Config_schoenheitsklinik = {}

Config_schoenheitsklinik.MarkerType   = -1
Config_schoenheitsklinik.DrawDistance = 100.0
Config_schoenheitsklinik.MarkerSize   = {x = 2.0, y = 2.0, z = 1.0}
Config_schoenheitsklinik.MarkerColor  = {r = 102, g = 102, b = 204}

Config_schoenheitsklinik.BlipPlasticSurgery = {
	Sprite = 468,
	Color = 8,
	Display = 2,
	Scale = 0.8
}

Config_schoenheitsklinik.Price = 100000

Config_schoenheitsklinik.EnableUnemployedOnly = false 
Config_schoenheitsklinik.EnableBlips = true
Config_schoenheitsklinik.EnablePeds = true 

Config_schoenheitsklinik.Locations = {
	-- { x = 356.1, y = -596.33, z = 27.77, heading = 255.22 , price = true},
	{ x = 330.0383, y = -587.6910, z = 47.2143, heading = 338.9099 , price = true},   
	{ x = -1079.1750, y = -2833.8198, z = 25.1144, heading = 241.2491 , price = false},
}

Config_schoenheitsklinik.Zones = {}

for i=1, #Config_schoenheitsklinik.Locations, 1 do
	Config_schoenheitsklinik.Zones['Shop_' .. i] = {
		Pos   = Config_schoenheitsklinik.Locations[i],
		Size  = Config_schoenheitsklinik.MarkerSize,
		Color = Config_schoenheitsklinik.MarkerColor,
		Type  = Config_schoenheitsklinik.MarkerType
	}
end
