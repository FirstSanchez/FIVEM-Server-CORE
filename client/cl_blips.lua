local blips = {
  -- {title="", colour=27, id=, x=, y=, z=},
  ----------------------------------------------Fraktionen---------------------------------------------
  -- {title="XXX", colour=27, id=630, x=-1807.93, y=453.75, z=128.31},
}	

CreateThread(function()

  for _, info in pairs(blips) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 2.5)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
  BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
  end
end)