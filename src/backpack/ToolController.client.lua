local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game: GetService("ReplicatedStorage")

local MAX_MOUSE_DISTANCE = 1024
local MAX_LASER_DISTANCE = 512
local FIRE_RATE = 0.5
local timeOfPreviousShot = 0

local LaserRenderer = require(Players.LocalPlayer.PlayerScripts.LaserRenderer)

local StarterPack = script.Parent
local tool = StarterPack:WaitForChild("Tool")



local function get3DMousePos()
    local mouse2D = UserInputService:GetMouseLocation()
    local screenToWorldRay = workspace.CurrentCamera : ViewportPointToRay(mouse2D.X, mouse2D.Y)
    local directionVector = screenToWorldRay.Direction * MAX_MOUSE_DISTANCE
    local raycastResult = workspace : Raycast(screenToWorldRay.Origin, directionVector)
    if raycastResult then
        return raycastResult.Position
    else
        return screenToWorldRay.Origin + directionVector
    end
end

local function fireWeapon()
    local mouseLocation = get3DMousePos()
    local gunLocation = tool.Handle.Position
    local vv = mouseLocation - gunLocation
    local targetDirection = vv.Unit * MAX_LASER_DISTANCE
    
    local weaponRaycastParams = RaycastParams.new()
    weaponRaycastParams.FilterDescendantsInstances={Players.LocalPlayer.Character}
    local weaponRaycastResult = workspace:Raycast(gunLocation, targetDirection, weaponRaycastParams)
    local hitPosition = weaponRaycastResult.Position
    if weaponRaycastResult then
        local characterModel = weaponRaycastResult.Instance : FindFirstAncestorOfClass("Model")
        if characterModel then
            local humanoid = characterModel : FindFirstChild("Humanoid")
            if humanoid then
                print("Player Hit")
                ReplicatedStorage.DamagePlayer:FireServer(characterModel, hitPosition)
            end
        end
    else
        hitPosition = gunLocation + targetDirection
    end
    timeOfPreviousShot = tick()
    LaserRenderer.createLaser(gunLocation, hitPosition)
    ReplicatedStorage.FiredLaser:FireServer(hitPosition)
end 

local function canShootWeapon()
    local currentTime = tick()
    if currentTime - timeOfPreviousShot < FIRE_RATE then
        return false
    end
    return true
end


local function toolEquipped()
    print("Equipped")
    tool.Handle.Equipped:Play()
end

local function toolAcitvated()
    if canShootWeapon() then
        print("Activated")
        tool.Handle.Activated:Play()
        fireWeapon()
    end
end

tool.Equipped:Connect(toolEquipped)
tool.Activated:Connect(toolAcitvated)
