Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-------------------------------------------------

RMenu.Add('lunatic', 'main', RageUI.CreateMenu("", "~p~Menu Armurie")) -- Menu Principal
RMenu.Add('lunaticx', 'submenu', RageUI.CreateSubMenu(RMenu:Get('lunatic', 'main'), "", nil)) -- Sous menu

RMenu:Get('lunatic', 'main').EnableMouse = false
RMenu:Get('lunatic', 'main').Closed = function()
	local playerPed = PlayerPedId()
    open = false
end


function menuarmurie()
	if open then
		open = false
		RageUI.Visible(RMenu:Get('lunatic', 'main'), false)
	else
		open = true
		RageUI.Visible(RMenu:Get('lunatic', 'main'), true)
		Citizen.CreateThread(function()
			while open do                                         -- 2eme true/false = Planete menu
				RageUI.IsVisible(RMenu:Get('lunatic', 'main'), true,false,true,function()
					                                -- nil = Titre en dessous du menu facture
					RageUI.Separator("↓ ~p~Action Entreprise ~s~↓")								
					RageUI.ButtonWithStyle("»  ~g~Annonces", nil,  {RightLabel = "→→"}, true, function(h,a,s)
					end, RMenu:Get("lunaticx", "submenu"))

					RageUI.Separator("↓ ~p~Action Client ~s~↓")
					RageUI.ButtonWithStyle("»  ~g~Factures", "", {RightLabel = "→→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer == -1 or closestDistance > 3.0 then
								TriggerEvent("esx:showAdvancedNotification", '~p~lunatic', '~r~Facture', '~r~Il n\'y a personne autour de vous.', 'CHAR_BANK_FLEECA', 'spawn', 8)
							else
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
								title = ('Rentrer le montant de la facture')
							}, function(data, menu)
					
								local amount = tonumber(data.value)
								if amount == nil then
									ESX.ShowNotification('Mauvais montant')
								else
									menu.close()
									local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										TriggerEvent("esx:showAdvancedNotification", '~p~lunatic', '~r~Facture', '~r~Il n\'y a personne autour de vous.', 'CHAR_BANK_FLEECA', 'spawn', 8)
									else
										TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_lunatic', 'lunatic', amount)
					
										ESX.ShowNotification('Facture envoyée')
									end
					
								end
						
					
							end, function(data, menu)
								menu.close()
							end)
						end
					end 
					end)
				end, function()end, 1)

				RageUI.IsVisible(RMenu:Get("lunaticx", "submenu"), true, false, true, function()
					RageUI.Separator("↓ ~p~Annonces ~s~↓")
					
					RageUI.ButtonWithStyle("»  ~p~Annonce ~g~Ouvert", "", {RightLabel = "→→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then
							TriggerServerEvent('Ouvre:armurie')
						end
					end)

					RageUI.ButtonWithStyle("»  ~p~Annonce ~r~Fermer", "", {RightLabel = "→→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then
							TriggerServerEvent('Ferme:armurie')
						end
					end)

				end, function()end, 1)

                Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'armurie' then 
	
			if IsControlJustReleased(0 ,167) then
				menuarmurie()
			end
		end
	end
end)

-- GARAGE 

RMenu.Add('Garage', 'main', RageUI.CreateMenu("", "~p~Menu Garages")) -- Menu Principal
RMenu.Add('Garage', 'submenu', RageUI.CreateSubMenu(RMenu:Get('Garage', 'main'), "", nil)) -- Sous menu

function menuGarage()
	if open then
		open = false
		RageUI.Visible(RMenu:Get('Garage', 'main'), false)
	else
		open = true
		RageUI.Visible(RMenu:Get('Garage', 'main'), true)
		Citizen.CreateThread(function()
			while open do                                         -- 2eme true/false = Planete menu
				RageUI.IsVisible(RMenu:Get('Garage', 'main'), true,false,true,function()
					                                -- nil = Titre en dessous du menu facture								
					RageUI.ButtonWithStyle("» ~r~Ranger le véhicule",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
						if Selected then
							local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
							if dist4 < 4 then
								ESX.ShowAdvancedNotification("~p~Armurie", "~~Vehicule a était remis dans le Garage !", "", "CHAR_AMMUNATION", 1)
                				DeleteEntity(veh)
            				end
						end
					end)
					
               RageUI.Separator("↓ ~p~Véhicule Entreprise~s~ ↓")

					RageUI.ButtonWithStyle("»  ~b~Kuruma Livraison", "", {RightLabel = "→→"},true, function(Hovered, Active, Selected)
						if (Selected) then
							ESX.ShowAdvancedNotification("~y~Armurie", "La Kuruma arrive !", "", "CHAR_AMMUNATION", 1) 
							Citizen.Wait(2000)   
							spawnCar("kuruma")
							ESX.ShowAdvancedNotification("~y~Armurie", "Faites Attention sur la Route !", "", "CHAR_AMMUNATION", 1) 
						end
					end)  

				end, function()end, 1)
		
                Wait(0)
            end
        end)
    end
end

function spawnCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, -8.93, -1112.67, 28.49, 161.25, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Armurie"
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1) 
end

local pgara = {
	{x = -6.93, y = -1109.07, z = 28.80}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

        for k in pairs(pgara) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'armurie' then 
				local disgara = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pgara[k].x, pgara[k].y, pgara[k].z)
				if disgara <= 3 then
                DrawMarker(36, -6.93, -1109.07, 28.80, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 197, 10, 10, 255, true, true, p19, true)  
                local dist7 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pgara[k].x, pgara[k].y, pgara[k].z)
        
                if dist7 <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au Garage")
                    if IsControlJustPressed(1,51) then
                        menuGarage()
                    end
                end
				end
            end
        end
    end
end)

-- COFFRE

RMenu.Add('Stockage', 'main', RageUI.CreateMenu("", "~p~Menu Stockage")) -- Menu Principal
RMenu.Add('Stockage', 'submenu', RageUI.CreateSubMenu(RMenu:Get('Stockage', 'main'), "", nil)) -- Sous menu

function actionStockage()
	if open then
		open = false
		RageUI.Visible(RMenu:Get('Stockage', 'main'), false)
	else
		open = true
		RageUI.Visible(RMenu:Get('Stockage', 'main'), true)
		Citizen.CreateThread(function()
			while open do
				Citizen.Wait(1)                                         -- 2eme true/false = Planete menu
				RageUI.IsVisible(RMenu:Get('Stockage', 'main'), true, false, true, function()
					RageUI.Separator("↓ ~p~Action Entreprise~s~ ↓")
					RageUI.ButtonWithStyle("» ~g~Déposer Objets",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							OpenPutStocksarmurieMenu()
							RageUI.CloseAll()
						end 
					end)								
					RageUI.ButtonWithStyle("» ~r~Retirer Objets",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							OpenGetStocksarmurieMenu()
							RageUI.CloseAll()
						end 
					end)
				end, function()
				end)
			end
		end)
	end
end

function OpenGetWeaponMenu()

	ESX.TriggerServerCallback('esx_armuriejob:getArmoryWeapons', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon',
		{
			title    = _U('get_weapon_menu'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)

			menu.close()

			ESX.TriggerServerCallback('esx_armuriejob:removeArmoryWeapon', function()
				OpenGetWeaponMenu()
			end, data.current.value)

		end, function(data, menu)
			menu.close()
		end)
	end)

end

function OpenPutWeaponMenu()
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label,
				value = weaponList[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon',
	{
		title    = _U('put_weapon_menu'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		menu.close()

		ESX.TriggerServerCallback('esx_armuriejob:addArmoryWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value, true)

	end, function(data, menu)
		menu.close()
	end)
end
function OpenGetStocksarmurieMenu()
	ESX.TriggerServerCallback('esx_armuriejob:prendreitem', function(items)
		local elements = {}

		for i=1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'armurie',
			title    = 'armurie stockage',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                css      = 'armurie',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_armuriejob:prendreitems', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksarmurieMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksarmurieMenu()
	ESX.TriggerServerCallback('esx_armuriejob:inventairejoueur', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'armurie',
			title    = 'inventaire',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                css      = 'armurie',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_armuriejob:stockitem', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksarmurieMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

local pStockage = {
	{x = 16.59, y = -1110.91, z = 29.79}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

        for k in pairs(pStockage) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'armurie' then 
				local disStockage = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pStockage[k].x, pStockage[k].y, pStockage[k].z)
				if disStockage <= 3 then
                DrawMarker(20, 16.59, -1110.91, 29.79, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 197, 10, 10, 255, true, true, p19, true)   
                local dist6 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pStockage[k].x, pStockage[k].y, pStockage[k].z)
        
                if dist6 <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au Stockage")
                    if IsControlJustPressed(1,51) then
                        actionStockage()
                    end
                end
				end
            end
        end
    end
end)

-- BOSS
RMenu.Add('Patron', 'main', RageUI.CreateMenu("", "~p~Menu Patron")) -- Menu Principal
RMenu.Add('Patron', 'submenu', RageUI.CreateSubMenu(RMenu:Get('Patron', 'main'), "", nil)) -- Sous menu

function actionboss()
	if open then
		open = false
		RageUI.Visible(RMenu:Get('Patron', 'main'), false)
	else
		open = true
		RageUI.Visible(RMenu:Get('Patron', 'main'), true)
		Citizen.CreateThread(function()
			while open do
				Citizen.Wait(1)                                         -- 2eme true/false = Planete menu
				RageUI.IsVisible(RMenu:Get('Patron', 'main'), true, false, true, function()
					RageUI.Separator("↓ ~p~Action Entreprise~s~ ↓")							
					RageUI.ButtonWithStyle("» ~r~Gestion Armurie",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							patronmenu()
							RageUI.CloseAll()
						end 
					end)
				end, function()
				end)
			end
		end)
	end
end

function patronmenu()
	TriggerEvent('esx_society:openBossMenu', 'armurie', function(data, menu)
		menu.close()
    end, {wash = false})
end

local pboss = {
	{x = 12.55, y = -1105.78, z = 29.79}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

        for k in pairs(pboss) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'armurie' then 
				local disboss = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pboss[k].x, pboss[k].y, pboss[k].z)
				if disboss <= 3 then
                DrawMarker(20, 12.55, -1105.78, 29.79, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 197, 10, 10, 255, true, true, p19, true)  
                local dist5 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pboss[k].x, pboss[k].y, pboss[k].z)
        
                if dist5 <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au Action Patron")
                    if IsControlJustPressed(1,51) then
                        actionboss()
                    end
                end
				end
            end
        end
    end
end)

-- BLIP ENTREPRISE

Citizen.CreateThread(function()

	local blip = AddBlipForCoord(17.90, -1113.596, 29.80)
  
	SetBlipSprite (blip, 76) -- Model du blip
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.5) -- Taille du blip
	SetBlipColour (blip, 1) -- Couleur du blip
	SetBlipAsShortRange(blip, true)
  
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('~p~Armurie')
	EndTextCommandSetBlipName(blip)
  end)

  RegisterNetEvent('cosasvariadas:kevlar')
  AddEventHandler('cosasvariadas:kevlar', function()
  
	  local playerPed = PlayerPedId()
  
	  AddArmourToPed(playerPed,100)
	  SetPedArmour(playerPed, 100)
  
  end)
	  

------------------------------------------
---------  ACHAT ARMES  ------------------
------------------------------------------

local armeachat = false

RMenu.Add('armeachat', 'main', RageUI.CreateMenu("", ""))
RMenu:Get('armeachat', 'main'):SetSubtitle("~w~ Armes Armuries")

RMenu:Get('armeachat', 'main').EnableMouse = false
RMenu:Get('armeachat', 'main').Closed = function()
	local playerPed = PlayerPedId()
    armeachat = false
	TriggerServerEvent('stopactionarmurie')
	FreezeEntityPosition(playerPed, false)
end

function actionarme()
	if not armeachat then
		armeachat = true
		RageUI.Visible(RMenu:Get('armeachat', 'main'), true)

		Citizen.CreateThread(function()
			while armeachat do
				Citizen.Wait(1)
				RageUI.IsVisible(RMenu:Get('armeachat', 'main'), true, true, true, function()
					RageUI.Separator("↓ ~r~Armes de Poing~s~ ↓")

					RageUI.ButtonWithStyle("~p~» ~s~Achat Pétoire ~g~50.000 $", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							local playerPed = PlayerPedId()
							TriggerServerEvent("AchatPistolet")
						end 
					end)
					RageUI.Separator("↓ ~r~Armes Corps à Corps~s~ ↓")
					RageUI.ButtonWithStyle("~p~» ~s~Achat Couteau ~g~5.000 $", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							local playerPed = PlayerPedId()
							TriggerServerEvent("AchatCouteau")
						end 
					end)
					RageUI.ButtonWithStyle("~p~» ~s~Achat Machette ~g~5.000 $", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							local playerPed = PlayerPedId()
							TriggerServerEvent("Achatmachette")
						end 
					end)

					RageUI.ButtonWithStyle("~p~» ~s~Achat Cran d'arret ~g~5.000 $", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							local playerPed = PlayerPedId()
							TriggerServerEvent("Achatca")
						end 
					end)
					RageUI.ButtonWithStyle("~p~» ~s~Achat Batte de Baseball ~g~5.000 $", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							local playerPed = PlayerPedId()
							TriggerServerEvent("Achatbaseball")
						end 
					end)
					RageUI.Separator("↓ ~r~Protection~s~ ↓")
					RageUI.ButtonWithStyle("~p~» ~s~Achat Gilet Pare-Balle ~g~50.000 $", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							local playerPed = PlayerPedId()
							TriggerServerEvent("Achatkevlar")
						end 
					end)

				end, function()
				end)
			end
		end)
	end
end




local parmurie = {
	{x = 22.00, y = -1105.33, z = 29.79}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		 
        for k in pairs(parmurie) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'armurie' then
				local disarmurie = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, parmurie[k].x, parmurie[k].y, parmurie[k].z)
				if disarmurie <= 3 then
                DrawMarker(20, 22.00, -1105.33, 29.79,0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 197, 10, 10, 255, true, true, p19, true) 
                local dist1 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, parmurie[k].x, parmurie[k].y, parmurie[k].z)
        
                if dist1 <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour acheter des armes")
                    if IsControlJustPressed(1,51) then
                        actionarme()
                    end
                end
				end
            end
        end
    end
end)