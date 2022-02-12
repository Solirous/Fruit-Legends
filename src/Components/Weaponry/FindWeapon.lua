local ServerStorage = game:GetService("ServerStorage")

local Assets = ServerStorage:WaitForChild("Assets")

local Weapon = Assets.Weapons

local Weapon = {}
Weapon.__index = Weapon


function Weapon.new(weaponName :  string ) : Model
    if Weapon:FindFirstChild(weaponName) then 
        return Weapon[weaponName]:Clone()
    end
end


return Weapon