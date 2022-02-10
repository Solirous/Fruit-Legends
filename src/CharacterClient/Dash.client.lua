local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Util = ReplicatedStorage:WaitForChild("Util")

local remoteServices= require(Util.RemoteServices)
local dashRemote = remoteServices:getRemote("Movement","dashRemote")

local dashVFX = remoteServices:getRemote("Vfx","vfxDashRemote")


local keys = {
    Forward = Enum.KeyCode.W,
    Back = Enum.KeyCode.S,
    Left = Enum.KeyCode.A,
    Right = Enum.KeyCode.D
}




function Fade(ty,char)
    for i , v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            if ty == "out" then
                v.Transparency = 1
            else
                v.Transparency = 0
                if v.Name == "HumanoidRootPart" then
                    v.Transparency = 1
                end
            end



        end
    end
end

local function getKey()
    local keyPressed

    for index , key in pairs(keys) do
        if UserInputService:IsKeyDown(key) then
            keyPressed = key 
            return keyPressed
        end
    end
end


UserInputService.InputBegan:Connect(function(input,gameProceesedEvent)
    if gameProceesedEvent then return end
    if input.KeyCode == Enum.KeyCode.Q then
        local ableToDash = dashRemote:InvokeServer()
        if ableToDash then
            local keyPressed = getKey()
            if keyPressed then

                else
                    dashVFX:FireServer()
            end
        end
    end
end)

dashVFX.OnClientEvent:Connect(function(playerDashedCharacter)
    Fade("out",playerDashedCharacter)
    task.wait(.4)
    Fade("in",playerDashedCharacter)
end)


