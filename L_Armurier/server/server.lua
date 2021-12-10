TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'armurie', 'alerte armurie', true, true)

TriggerEvent('esx_society:registerSociety', 'armurie', 'armurie', 'society_armurie', 'society_armurie', 'society_armurie', {type = 'public'})

RegisterServerEvent('Ouvre:armurie')
AddEventHandler('Ouvre:armurie', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~p~Armurie', '~r~Annonce', 'Armurie ~g~Ouverte~s~ !', 'CHAR_AMMUNATION', 8)
	end
end)

RegisterServerEvent('Ferme:armurie')
AddEventHandler('Ferme:armurie', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~p~Armurie', '~r~Annonce', 'Armurie ~r~Fermer~s~ !', 'CHAR_AMMUNATION', 8)
	end
end)

-----------------------------------------------------------

ESX.RegisterServerCallback('lunatic_getWeapon', function(source, cb, namesociety)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_'..namesociety..'', function(store)
  
	  local weapons = store.get('weapons')
  
	  if weapons == nil then
		weapons = {}
	  end
  
	  cb(weapons)	
	end)
  
  end)

ESX.RegisterServerCallback('lunatic_putWeapon', function(source, cb, weaponName, namesociety)

	local xPlayer = ESX.GetPlayerFromId(source)
  
	xPlayer.removeWeapon(weaponName)
  
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_'..namesociety..'', function(store)
  
	  local weapons = store.get('weapons')
  
	  if weapons == nil then
		weapons = {}
	  end
  
	  local foundWeapon = false
  
	  for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
		  weapons[i].count = weapons[i].count + 1
		  foundWeapon = true
		end
	  end
  
	  if not foundWeapon then
		table.insert(weapons, {
		  name  = weaponName,
		  count = 1
		})
	  end
  
	   store.set('weapons', weapons)
  
	   cb()

	end)
end)

ESX.RegisterServerCallback('lunatic_removeWeapon', function(source, cb, weaponName, namesociety)

	local xPlayer = ESX.GetPlayerFromId(source)
  
	xPlayer.addWeapon(weaponName, 1000)
  
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_'..namesociety..'', function(store)
  
	  local weapons = store.get('weapons')
	  local weaponLabel = ESX.GetWeaponLabel(weaponName)
  
	  if weapons == nil then
		weapons = {}
	  end
  
	  local foundWeapon = false
  
	  for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
		  weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
		  foundWeapon = true
		end
	  end
  
	  if not foundWeapon then
		table.insert(weapons, {
		  name  = weaponName,
		  count = 0
		})
	  end
  
	   store.set('weapons', weapons)
  
	   cb()
  
	end)
  
  end)


-----------------------------------------------------------
achatarme = {} 

RegisterServerEvent('AchatPistolet')
AddEventHandler('AchatPistolet', function()
    local _source = source
    achatarme[source] = true
	achatarmeP(source)
end)

function achatarmeP(source)
    if achatarme[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
		local pistolet = "weapon_snspistol"
		local id = math.random(0, 9999)

        if xPlayer.hasWeapon("weapon_snspistol") then
            TriggerClientEvent('esx:showNotification', source, "~r~Tu ne peut pas acheter ce type d'arme si tu la sur toi !")
            achatarme[source] = false
        else
				xPlayer.addWeapon(pistolet, 1)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous avez reçu votre arme \n ~r~Numero de Série ~w~: ~p~"..id.."")
                xPlayer.removeMoney(50000)
            end
        end
    end

achatarme1 = {} 

RegisterServerEvent('AchatCouteau')
AddEventHandler('AchatCouteau', function()
    local _source = source
    achatarme1[source] = true
    achatarme1P(source)
end)
    
function achatarme1P(source)
    if achatarme1[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local couteau = "weapon_knife"
    
        if xPlayer.hasWeapon("weapon_knife") then
            TriggerClientEvent('esx:showNotification', source, "~r~Tu ne peut pas acheter ce type d'arme si tu la sur toi !")
            achatarme1[source] = false
        else
                xPlayer.addWeapon(couteau, 1)
                xPlayer.removeMoney(5000)
            end
        end
    end

achatarme2 = {} 

RegisterServerEvent('Achatmachette')
AddEventHandler('Achatmachette', function()
    local _source = source
    achatarme2[source] = true
    achatarme2P(source)
end)
    
function achatarme2P(source)
    if achatarme2[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local machete = "weapon_machete"
    
        if xPlayer.hasWeapon("weapon_machete") then
            TriggerClientEvent('esx:showNotification', source, "~r~Tu ne peut pas acheter ce type d'arme si tu la sur toi !")
            achatarme2[source] = false
        else
                xPlayer.addWeapon(machete, 1)
                xPlayer.removeMoney(5000)
            end
        end
    end
    

achatarme3 = {} 

RegisterServerEvent('Achatca')
AddEventHandler('Achatca', function()
    local _source = source
    achatarme3[source] = true
    achatarme3P(source)
end)
    
function achatarme3P(source)
    if achatarme3[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local switch = "weapon_switchblade"
    
        if xPlayer.hasWeapon("weapon_switchblade") then
            TriggerClientEvent('esx:showNotification', source, "~r~Tu ne peut pas acheter ce type d'arme si tu la sur toi !")
            achatarme3[source] = false
        else
                xPlayer.addWeapon(switch, 1)
                xPlayer.removeMoney(5000)
            end
        end
    end  

achatarme4 = {} 

RegisterServerEvent('Achatbaseball')
AddEventHandler('Achatbaseball', function()
    local _source = source
    achatarme4[source] = true
    achatarme4P(source)
end)
    
function achatarme4P(source)
    if achatarme4[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local bat = "weapon_bat"
    
        if xPlayer.hasWeapon("weapon_bat") then
            TriggerClientEvent('esx:showNotification', source, "~r~Tu ne peut pas acheter ce type d'arme si tu la sur toi !")
            achatarme4[source] = false
        else
                xPlayer.addWeapon(bat, 1)
                xPlayer.removeMoney(5000)
            end
        end
    end 

    ESX.RegisterUsableItem('kevlar', function (source)

        local xPlayer = ESX.GetPlayerFromId(source)
    
        xPlayer.removeInventoryItem('kevlar', 1)
    
        TriggerClientEvent('cosasvariadas:kevlar', source)
    
    end)

    achatkevlar = {} 

    RegisterServerEvent('Achatkevlar')
    AddEventHandler('Achatkevlar', function()
        local _source = source
        achatkevlar[source] = true
        achatkevlarP(source)
    end)
        
    function achatkevlarP(source)
        if achatkevlar[source] == true then
            local xPlayer = ESX.GetPlayerFromId(source)
            local kevlar = "kevlar"
            local limiteitem = 10
            local nbkevlarinventory = xPlayer.getInventoryItem("kevlar").count
        
            if nbkevlarinventory >= limiteitem then
                TriggerClientEvent('esx:showNotification', source, "~r~Tu ne peut pas en prendre plus sur toi !")
                achatkevlar[source] = false
            else
                    xPlayer.addInventoryItem(kevlar, 1)
                    xPlayer.removeMoney(50000)
                end
            end
        end 
    
        ESX.RegisterUsableItem('kevlar', function (source)
    
            local xPlayer = ESX.GetPlayerFromId(source)
        
            xPlayer.removeInventoryItem('kevlar', 1)
        
            TriggerClientEvent('cosasvariadas:kevlar', source)
        
        end)
-------------------------------------------------------

RegisterServerEvent('esx_armuriejob:prendreitems')
AddEventHandler('esx_armuriejob:prendreitems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_armurie', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then

			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
			end
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)


RegisterNetEvent('esx_armuriejob:stockitem')
AddEventHandler('esx_armuriejob:stockitem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_armurie', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _source, "Objet déposé "..count..""..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('esx_armuriejob:inventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('esx_armuriejob:prendreitem', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_armurie', function(inventory)
		cb(inventory.items)
	end)
end)

------------------------------------------------------------------