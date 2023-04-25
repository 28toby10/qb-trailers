fx_version 'adamant'
games { 'gta5' }

description 'qb-trailers'
version '1.0.4'

shared_scripts {
	'@qb-core/shared/locale.lua',
	'locales/en.lua',
	'locales/*.lua'
}

client_scripts {
	'config.lua',
    'client/*.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
}
