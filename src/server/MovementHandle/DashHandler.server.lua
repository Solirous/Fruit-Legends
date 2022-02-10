local Players = game:GetService("Players")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Util = ReplicatedStorage:WaitForChild("Util")

local remoteServices= require(Util.RemoteServices)

local dashRemote = remoteServices:getRemote("Movement","dashRemote")

local dashVFX = remoteServices:getRemote("Vfx","vfxDashRemote")

local dashCoolDown = {}

local dashCoolDownTime = .4

Players.PlayerAdded:Connect(function(player)
    local key = player.UserId
    dashCoolDown[key] = os.clock()
end)



dashRemote.OnServerInvoke = function(player)
    local character = player.Character
    if os.clock() - dashCoolDown[player.UserId] > dashCoolDownTime then
        dashCoolDown[player.UserId] = os.clock()
        dashVFX:FireAllClients(character)
        return true
    end
end


