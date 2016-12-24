local network = require('network')

-- Create the class
local notifications = class({})

function notifications:send(ply, data)
	network:sendNotification(ply, data)
end

-- Define the export
return notifications()
