local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local ContentProvider = game:GetService("ContentProvider")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Util = ReplicatedStorage:WaitForChild("Util")

local remoteServices= require(Util.RemoteServices)
local dashRemote = remoteServices:getRemote("Movement","dashRemote")

local dashVFX = remoteServices:getRemote("Vfx","vfxDashRemote")

local Assets = ReplicatedStorage:WaitForChild("Assets")

local player = Players.LocalPlayer
local character =player.Character or player.CharacterAdded:Wait()

local db = os.clock()

local keys = {
    Forward = Enum.KeyCode.W,
    Back = Enum.KeyCode.S,
    Left = Enum.KeyCode.A,
    Right = Enum.KeyCode.D
}



local function Fade(ty,char)
    for i , v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            if ty == "out" then
                v.Transparency = 1
            elseif not CollectionService:HasTag(v,"noTrans") then
                v.Transparency = 0
                if v.Name == "HumanoidRootPart" then
                    v.Transparency = 1
                end
            end



        end
    end
end


local function get(basePartName)
    if basePartName == "char" then
        return character
    else
        return character:WaitForChild(basePartName)
    end
end

local function soruParticle(callback,char,shape)
    local Soru = Assets.DashVFX.Soru:Clone()
    Soru.Parent = char.HumanoidRootPart
    Soru.ShapeInOut = shape
    local emitCount = Soru:GetAttribute("EmitCount")
    Soru:Emit(emitCount or  Soru.Rate)
    if callback then
        callback()
    end
    Debris:AddItem(Soru,.2)
end
local function dashfx_func(char)
    for i , v in pairs(Assets.DashVFX:GetChildren()) do
        if v.Name ~= "Soru" then
            local cl = v:Clone()
            cl.Parent = char.HumanoidRootPart
            task.delay(.5,function()
                cl:Destroy()
            end)
        end
    end
end


local function playSound()
    local sound = Instance.new("Sound")
    sound.Parent = workspace
    sound.Volume = 1
    sound.TimePosition = .3
    sound.PlayOnRemove = true
    sound.SoundId = "rbxassetid://8788993681"
    sound:Destroy()
end

local function dash(type,speed)
    local BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.MaxForce = Vector3.new(1,0,1) * 100000
    BodyVelocity.P = 10000
    if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
    if type == "Forward" then 
        BodyVelocity.Velocity = get("HumanoidRootPart").CFrame.LookVector * speed
    elseif type == "Back" then
        BodyVelocity.Velocity = get("HumanoidRootPart").CFrame.LookVector* -speed
    elseif type == "Right" then
        BodyVelocity.Velocity = get("HumanoidRootPart").CFrame.RightVector * speed
    elseif type == "Left" then
        BodyVelocity.Velocity = get("HumanoidRootPart").CFrame.RightVector *  -speed
    end
else
    BodyVelocity.Velocity = get("HumanoidRootPart").CFrame.LookVector * speed
end
    BodyVelocity.Parent = get("HumanoidRootPart")
    Debris:AddItem(BodyVelocity,.2)
end




local function getKey()
    local keyPressed

    for index , key in pairs(keys) do
        if UserInputService:IsKeyDown(key) then
            keyPressed = index
            return keyPressed
        end
    end
end


UserInputService.InputBegan:Connect(function(input,gameProceesedEvent)
    if gameProceesedEvent then return end
    if input.KeyCode == Enum.KeyCode.Q and os.clock()  - db > 0.5 then
         local keypreesed = getKey()
         if keypreesed then 
             dash(keypreesed,100)
         end
         task.spawn(function()
            Fade("out",get("char"))
            dashfx_func(get("char"))
            soruParticle(playSound,get("char"),Enum.ParticleEmitterShapeInOut.Outward)
            task.wait(.7)
            Fade("in",get("char"))
            soruParticle(nil,get("char"),Enum.ParticleEmitterShapeInOut.Inward)
            end)
		dashVFX:FireServer()
		db = os.clock()
    end
end)

dashVFX.OnClientEvent:Connect(function(playerDashedCharacter)
    if playerDashedCharacter ~= get("char") then
    Fade("out",playerDashedCharacter)
    dashfx_func(playerDashedCharacter)
    soruParticle(playSound,playerDashedCharacter,Enum.ParticleEmitterShapeInOut.Outward)
    task.wait(.7)
    Fade("in",playerDashedCharacter)
    soruParticle(nil,playerDashedCharacter,Enum.ParticleEmitterShapeInOut.Inward)
    end
end)




