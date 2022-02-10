local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationServices = {}

function AnimationServices.loadAnimation(Humanoid : Humanoid , animationFolderName :string , animationName : string )
    local animationFolder = ReplicatedStorage.Remotes:FindFirstChild(animationFolderName)
    if animationFolder then
        local Animation = animationFolder:FindFirstChild(animationName)
        if Animation then
            return Humanoid:LoadAnimation(Animation)
        end
    end
end



return AnimationServices
