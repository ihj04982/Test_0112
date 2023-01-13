local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LaserRenderer = require(script.Parent:WaitForChild("LaserRenderer"))

local function displayOtherLaser(player, startPos, endPos)
    --해당 플레이어가 레이저를 발사한 플레이어가 아니라면,
    if player ~= Players.LocalPlayer then
        LaserRenderer.createLaser(startPos, endPos)
    end
end

ReplicatedStorage.FiredLaser.OnClientEvent:Connect(displayOtherLaser)