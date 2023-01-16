local LaserRenderer = {}

local SHOT_DURATION = 0.15

function LaserRenderer.createLaser(startPos, endPos)
    local laserPart = Instance.new("Part")
    laserPart.Anchored = true
    laserPart.CanCollide = false
    laserPart.Color = Color3.fromRGB(225, 0, 0)
    laserPart.Material = Enum.Material.Neon
    
    local laserDistance = (startPos - endPos).Magnitude
    laserPart.Size = Vector3.new(0.2, 0.2, laserDistance)
    local laserCFrameTemp = CFrame.lookAt(startPos, endPos)
    laserPart.CFrame = laserCFrameTemp * CFrame.new(0,0,-laserDistance*0.5)
    laserPart.Parent = workspace
    
    game.Debris:AddItem(laserPart, SHOT_DURATION)
end

return LaserRenderer
