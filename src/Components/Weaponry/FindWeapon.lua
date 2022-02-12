local ServerStorage = game:GetService("ServerStorage")

local Assets = ServerStorage:WaitForChild("Assets")

local Weapons = Assets.Weapons

local Weapon = {}
Weapon.__index = Weapon

function Weapon.new(weaponName :  string ) : Model
    if Weapons:FindFirstChild(weaponName) then 
        return Weapons[weaponName]:Clone()
    end
end


return Weapon