local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = {}


function remote:getRemote(remotePack : string,remoteName:string)
    local Remotes = ReplicatedStorage:WaitForChild("Remotes")
    local remote = Remotes[remotePack]
    if remote then
        local ARemoteNeedToReturn = remote:WaitForChild(remoteName)
        if ARemoteNeedToReturn then
            return ARemoteNeedToReturn
        end
    end
end


return remote