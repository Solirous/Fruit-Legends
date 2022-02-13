local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Util = ReplicatedStorage:WaitForChild("Util")

local remoteServices= require(Util.RemoteServices)

local initRemote = remoteServices:getRemote("Katana","Init")

initRemote:FireServer({Type = "Init"})


local Util = ReplicatedStorage:WaitForChild("Util")

local animationServices = require(Util.AnimationServices)

local db = os.clock()

local dbResetCombo = os.clock()

local coolDownTime = .3
local resetComboTime = 2

local combo =  0

local canAttack = true

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()


local function get(o)
    if o == "char" then
        return character
    else
        return character:WaitForChild(o)
    end
end


local function loadAnimationWithCombo()
    animationServices:loadAnimation(get("Humanoid"),"Katana","Slash"..combo):Play()
end


UserInputService.InputBegan:Connect(function(input , gameProceesedEvent)
    if gameProceesedEvent then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
    if os.clock()- db >= coolDownTime and canAttack == true then
        db = os.clock()
        if os.clock() - dbResetCombo >= resetComboTime then
            combo = 0
        end
        dbResetCombo = os.clock()

        task.spawn(function()
            loadAnimationWithCombo()
        end)

        if combo == 3 then
            canAttack = false
            combo = 0
            task.delay(1,function()
                canAttack = true
            end)
        else
            combo += 1
        end

    

        print("Player slashed with the combo : "..combo)

    end
end
end)