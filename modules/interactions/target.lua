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

local Config = lib.require('config')

if Config.interaction.type ~= "target" then return end

function loadInteractions()


    exports.ox_target:addSphereZone({
        coords = Config.examCoords,
        radius = Config.interaction.targetradius,
        debug = false,
        options = {
            {
                name = 'stevo_citizenship',
                icon =  Config.interaction.targeticon,
                label = Config.interaction.targetlabel,
                distance = Config.interaction.targetdistance,
                onSelect = function()
                    beginExam()
                end
            }
        }
    })    




    
end

