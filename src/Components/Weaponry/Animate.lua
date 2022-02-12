local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Util = ReplicatedStorage:WaitForChild("Util")

local animationService = require(Util.AnimationServices)


local Animate = {}
Animate.__index = Animate

function Animate.new(character : Model,wepname : string) :  table
    local self =  setmetatable({
        storedAnimationId = nil,
        char  = character,
        animate = character:WaitForChild("Animate"),
        weaponName = wepname
    },Animate)
    return self
end


function Animate:changeAnimate() : nil
    -- set the script disable --
    self.animate.Disabled = true
    --change animation--
    for i , v in pairs(self.animate.idle:GetChildren()) do
        v.AnimationId = animationService:getAnimation(self.weaponName,"Idle").AnimationId
    end----
    local walk = self.animate.walk.WalkAnim
    walk.AnimationId = animationService:getAnimation(self.weaponName,"Walk").AnimationId
    self.animate.Disabled = false
end

function Animate:restoreBack()

end



return Animate
