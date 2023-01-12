local LaserRenderer = {}

local SHOT_DURATION = 0.15

function LaserRenderer.createLaser(startPos, endPos)
    local laserPart = Instance.new("Part")
    laserPart.Anchored = true
    laserPart.CanCollide = false
    laserPart.Color = Color3.fromRGB(225, 0, 0)
    laserPart.Material = Enum.Material.Neon
    laserPart.Parent = Workspace

    local laserDistance = (endPos - startPos).Magnitude
    lasePart.Size = Vector3.new(0.2, 0.2, laserDistance)
    local laserCFrameTemp = CFrame.lookAt(startPos, endPos)
    laserPart.CFrame = laserCFrameTemp * CFrame.new(0,0,-laserDistance*0.5)
end

return LaserRenderer
