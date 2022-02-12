local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Util = ReplicatedStorage:WaitForChild("Util")

local animationService = require(Util.AnimationServices)


local Animate = {}
Animate.__index = Animate

function Animate.new(character : Model) :  table
    local self =  setmetatable({
        storedAnimationId = nil,
        char  = character,
        animate = character:WaitForChild("Animate")
    },Animate)
    return self
end


function Animate:changeAnimate() : nil
    -- set the script disable --
    self.Animate.Disabled = true
    --change animation--
    for i, animation in pairs(self.Animate:GetDescendants()) do
        for j , animationInPack in pairs(animationService:getAnimationPack(self.weaponName):GetChildren())  do
            if animation.Name == animationInPack.Name and animation:IsA("Animation") and animationInPack:IsA("Animation") then
                animation.AnimationId = animationInPack.AnimationId
             end
        end
        end
        ----
    self.Animate.Disabled = false
end

function Animate:restoreBack()

end



return Animate
