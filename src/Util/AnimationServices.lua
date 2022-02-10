local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationServices = {}

function AnimationServices:loadAnimation(Humanoid : Humanoid , animationFolderName :string , animationName : string )
    local animationFolder = ReplicatedStorage.Remotes:WaitForChild(animationFolderName,9e9)
    if animationFolder then
        local Animation = animationFolder:WaitForChild(animationName)
            return Humanoid:LoadAnimation(Animation)
    end
end
return AnimationServices