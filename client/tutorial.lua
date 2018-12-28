-- You have to replace your vrp/client/basic_garage for my basic_garage, if you have a custom modification you can put only the function

-- Put the text from line 60

function tvRP.despawnGarageVehicle(vtype,max_range)
  local vehicle = vehicles[vtype]
  if vehicle then
    local x,y,z = table.unpack(GetEntityCoords(vehicle[3],true))
    local px,py,pz = tvRP.getPosition()

    if GetDistanceBetweenCoords(x,y,z,px,py,pz,true) < max_range then -- para checar distancia entre garagem e veículo
      -- remover veículo
      if IsVehicleDamaged(vehicle[3]) then
        tvRP.notify("Conserte seu veículo antes de guardar !")
      else
        SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
        Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
        SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
        vehicles[vtype] = nil
        tvRP.notify("Veículo Guardado.")
      end
    else

      tvRP.notify("Você está muito longe do veiculo")
    end
  end
end
