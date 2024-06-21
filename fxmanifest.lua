fx_version "cerulean"
game "gta5"

author "StevoScripts"
description "Citizen System."
version "1.1.0"

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}

client_scripts {
    'modules/bridge/client/**.lua',
    'modules/citizenship/client.lua',
    'modules/interactions/**.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'modules/bridge/server/*.lua',
    'modules/citizenship/server.lua',
}

dependencies {
    'ox_lib',
    'oxmysql',
    '/server:4500',
}
   

lua54 "yes"





