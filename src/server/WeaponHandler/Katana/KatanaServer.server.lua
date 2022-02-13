local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Util = ReplicatedStorage:WaitForChild("Util")

local remoteServices= require(Util.RemoteServices)

local initRemote = remoteServices:getRemote("Katana","Init")

local Class = ReplicatedStorage.Class

local Katana = require(Class.Katana)


function initOnServerEvent(player ,data  : table)
   local katanaClass =  Katana.new(player,"Katana")
   katanaClass:init()
end


initRemote.OnServerEvent:Connect(initOnServerEvent)