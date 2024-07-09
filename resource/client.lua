--[[
   _____ _                     _____           _       _       
  / ____| |                   / ____|         (_)     | |      
 | (___ | |_ _____   _____   | (___   ___ _ __ _ _ __ | |_ ___ 
  \___ \| __/ _ \ \ / / _ \   \___ \ / __| '__| | '_ \| __/ __|
  ____) | ||  __/\ V / (_) |  ____) | (__| |  | | |_) | |_\__ \
 |_____/ \__\___| \_/ \___/  |_____/ \___|_|  |_| .__/ \__|___/
                                                | |            
                                                |_|             
      Discord: https://discord.gg/stevoscripts
      Website: https://stevoscripts.com
      Github: https://github.com/stevoscriptss
]]--	

local Config = lib.require('config')
local stevo_lib = exports['stevo_lib']:import()
local examCompleted = false

function beginExam()
    local ped = PlayerPedId()	
    if ped then
        local alert = lib.alertDialog({
            header = Config.StartExamHeader,
            content = Config.StartExamContent,
            centered = true,
            cancel = true,
            labels = {
                confirm = 'Begin Exam',
                cancel = 'Close'
            }
        })
        if alert == 'cancel' then
            return
        end

        local score = 0
        for _, question in ipairs(Config.Questions) do
            local options = {}
            for _, option in ipairs(question.options) do
                table.insert(options, {type = 'checkbox', label = option.label})
            end
            local input = lib.inputDialog(question.title, options)
            if not input then 
                stevo_lib.Notify('You cancelled the exam', 'error')
                return
            end
            for i, answer in ipairs(input) do
                print('hello')
                if answer and question.options[i].correct then
                    score = score + 1
                end
            end
        end

        if score >= Config.PassingScore then
            local alert = lib.alertDialog({
                header = Config.SuccessHeader,
                content = Config.SuccessContent,
                centered = true,
                cancel = false,
                labels = {
                    confirm = 'Play',
                    cancel = 'Close'
                }
            })
            lib.callback.await('stevo_citizenship:addCitizenship', false)
            examCompleted = true
            DoScreenFadeOut(800)
            Wait(800)
            SetEntityCoords(ped, Config.completionCoords, 1, 0, 0, 1)
            SetEntityHeading(ped, Config.completionCoords.h)
            Wait(500)
            DoScreenFadeIn(1000)
        else
            lib.alertDialog({
                header = Config.FailedHeader,
                content = Config.FailedContent,
                centered = true,
                cancel = false,
                labels = {
                    confirm = 'Close',
                    cancel = 'Close'
                }
            })
        end
    end
end

function escapeCitizenship()

    if examCompleted then return end

    DoScreenFadeOut(500)
    FreezeEntityPosition(cache.ped, true)
    Wait(800)

    SetEntityCoords(cache.ped, Config.spawnCoords.x, Config.spawnCoords.y, Config.spawnCoords.z)
    SetEntityHeading(cache.ped, Config.spawnCoords.h)

    FreezeEntityPosition(cache.ped, false)
    DoScreenFadeIn(1000) 
    stevo_lib.Notify(Config.escapeNotify, 'escape')
end

function loadCitizenship()

    DoScreenFadeOut(500)
    FreezeEntityPosition(cache.ped, true)
    Wait(800)

    SetEntityCoords(cache.ped, Config.spawnCoords.x, Config.spawnCoords.y, Config.spawnCoords.z)
    SetEntityHeading(cache.ped, Config.spawnCoords.h)

    loadInteractions()


    local citizenZone = lib.zones.box({
        name = "citizenZone",
        coords = Config.citizenZone.coords,
        size = Config.citizenZone.size,
        rotation = Config.citizenZone.rotation,
    })

    function citizenZone:onExit(self)
        if examCompleted then citizenZone:remove() return end

        escapeCitizenship()
    end

    FreezeEntityPosition(cache.ped, false)
    DoScreenFadeIn(1000) 
    stevo_lib.Notify(Config.loadNotify, 'info')
end

function OnPlayerLoaded()
    local isCitizen = lib.callback.await('stevo_citizenship:checkCitizenship', false)

    if not isCitizen then
        loadCitizenship()
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    OnPlayerLoaded()
end)

RegisterNetEvent('stevo_lib:playerLoaded', function()
    OnPlayerLoaded()
end)
