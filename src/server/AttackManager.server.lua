local ReplicatedStorage = game: GetService("ReplicatedStorage")
local ServerStorage = game: GetService("ServerStorage")
local LASER_DAMAGE = 50
local MAX_HIT_PROXIMITY = 9
local MAX_LASER_DISTANCE = 512

local function isLayCastingValid(playerFired, characterToDamage, hitPosition)
    local weapon = playerFired.Character : FindFirstChildOfClass("Tool")
    if weapon then
        local toolHandle = weapon : FindFirstChild("Handle")
        if toolHandle then
            local rayDirection = (hitPosition - toolHandle.Position).Unit * MAX_LASER_DISTANCE
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {playerFired.Character}
            local rayResult = workspace : Raycast(toolHandle.Position, rayDirection, raycastParams)
            if rayResult then
                if rayResult and rayResult.Instance:IsDescendantOf(characterToDamage) then
                    return true
                end
            end
        end
    end
    return false
end

local function isHitValid(playerFired, characterToDamage, hitPosition)
    local humanoid = characterToDamage:FindFirstChild("Humanoid")
    if humanoid then
        local characterHitProximity = (humanoid.RootPart.Position - hitPosition).Magnitude
        if characterHitProximity > MAX_HIT_PROXIMITY then
            return false
        end
    end
    if isLayCastingValid(playerFired, characterToDamage, hitPosition) == false then
        return false
    end
    return true
end


function damagePlayer(playerFired, characterToDamage, hitPosition)
    local humanoid = characterToDamage:FindFirstChild("Humanoid")
    local isValid = isHitValid(playerFired, characterToDamage, hitPosition)
    if humanoid and isValid then
        humanoid.Health -= LASER_DAMAGE
        if humanoid.Health <= 0 then
            --플레이어가 죽으면 killEvent 발생
            ServerStorage.KillEvent:Fire(playerFired)
        end
    else
        print("유효성 검증 실패")
    end
end

--모든 클라이언트에게 레이저 빔의 발사 정보를 알려 주는 함수
local function notifyFiredLaser(playerFired, endPos)
    local weapon = playerFired.Character:FindFirstChildOfClass("Tool")
    --도구가 있는 플레이어만이 레이저 빔을 발사할 수 있다
    if weapon then
        local handle = weapon : FindFirstChild("Handle")
        if weapon then
            --레이저 빔의 시작 위치
            local startPos = handle.Position
            --모든 클라이언트에게 레이저 빔 발사 정보 전달
            ReplicatedStorage.FiredLaser:FireAllClients(playerFired, startPos, endPos)
        end
    end
end

ReplicatedStorage.DamagePlayer.OnServerEvent : Connect(damagePlayer)
ReplicatedStorage.FiredLaser.OnServerEvent : Connect(notifyFiredLaser)