--[[
   _____ _                     _____           _       _       
  / ____| |                   / ____|         (_)     | |      
 | (___ | |_ _____   _____   | (___   ___ _ __ _ _ __ | |_ ___ 
  \___ \| __/ _ \ \ / / _ \   \___ \ / __| '__| | '_ \| __/ __|
  ____) | ||  __/\ V / (_) |  ____) | (__| |  | | |_) | |_\__ \
 |_____/ \__\___| \_/ \___/  |_____/ \___|_|  |_| .__/ \__|___/
                                                | |            
                                                |_|             
	  StevoScripts | https://discord.gg/stevoscripts
]]--	

if GetResourceState('es_extended') ~= 'started' then return end

local ESX = exports['es_extended']:getSharedObject()


function GetIdentifier(id)
	local xPlayer = ESX.GetPlayerFromId(id)
    return xPlayer.getIdentifier()
end