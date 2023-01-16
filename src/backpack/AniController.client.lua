local Players = game:GetService("Players")
local tool = script.Parent

local MAX_MOUSE_DISTANCE = 1024
local MAX_LASER_DISTANCE = 512
local FIRE_RATE = 0.5
local timeOfPreviousShot = 0

local player = Players.LocalPlayer
local character = player.Character
if not character or not character.Parent then
    character = player.CharacterAdded:Wait()
end

local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")

local aimAnimation = Instance.new("Animation")
aimAnimation.AnimationId = "rbxassetid://12172104782"
local aniTrack = animator:LoadAnimation(aimAnimation)
aniTrack.Priority = Enum.AnimationPriority.Action
aniTrack.Looped = true

local function toolEquipped()
    aniTrack:Play()
end

local function toolAcitvated()
    aniTrack:Stop()
end

tool.Equipped:Connect(toolEquipped)
tool.Activated:Connect(toolAcitvated)
