local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Components = ReplicatedStorage:WaitForChild("Components")

local Weaponry = Components.Weaponry

local Animate = require(Weaponry.Animate)

local Welder = require(Weaponry.Welder)

local katana = {}

function katana.new(player : Player ,swordName : string) : table 
    local self = setmetatable({
        player,
        char = player.Character,
        swordName,
        AnimateClass = Animate.new(player.Character)
    },katana)
    return self
end

function katana:initialize()
    
end




return katana