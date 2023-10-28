Config_Bell = {

Desks = {
  {coords = vector3(441.96099853516,-980.16595458984,31.893302917 - 0.9), job = 'police'},              
  }
}
    
function SendNotice(msg)
  TriggerEvent("esx:showNotification", msg)
  SetNotificationTextEntry('STRING')
  AddTextComponentString(msg)
  DrawNotification(0,1)
end