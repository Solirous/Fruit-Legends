local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Util = ReplicatedStorage:WaitForChild("Util")

local remoteServices= require(Util.RemoteServices)

local initRemote = remoteServices:getRemote("Weapon","Init")


function initOnServerEvent(player)


    
end


initRemote.OnServerEvent:Connect(initOnServerEvent)