local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Components = ReplicatedStorage:WaitForChild("Components")

local Weaponry = Components.Weaponry

local Animate = require(Weaponry.Animate)

local Welder = require(Weaponry.Welder)

local findWeapon = require(Weaponry.FindWeapon)

local katana = {}
katana.__index = katana
function katana.new(player : Player ,swordNameInServer : string) : table 
    local self = setmetatable({
        player,
        char = player.Character,
        swordName = swordNameInServer,
        AnimateClass = Animate.new(player.Character,swordNameInServer)
    },katana)
    return self
end

function katana:init()
    local sword = findWeapon.new(self.swordName)
    print(sword)
    if sword then 
        sword.Parent = self.char
        local welderClass = Welder.new(self.char["Right Arm"],sword.PrimaryPart,"swordWeld")
       local welded =  welderClass:newWeld()
       if welded then
        warn("A")
        self.AnimateClass:changeAnimate()
       end
    end
end




return katana