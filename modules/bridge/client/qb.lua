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

if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()
local Config = lib.require('config')

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    OnPlayerLoaded()
end)


function hasPlyLoaded()
    return LocalPlayer.state.isLoggedIn
end

function Notify(message, type)
    if Config.NotifyType == 'qb' then
        QBCore.Functions.Notify(message, type)
    end
    if Config.NotifyType == 'ox_lib' then
        lib.notify({
            title = message,
            type = type
        })
    end
    if Config.NotifyType == 'okok' then
        exports['okokNotify']:Alert("🔔   Notification   🔔", message, 3000, type)
    end
    if Config.NotifyType == 'custom' then
        -- Your notify script here
    end
end