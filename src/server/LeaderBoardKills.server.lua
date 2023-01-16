local Players = game:GetService("Players")
local ServerStorage = game: GetService("ServerStorage")

local function onPlayerAdded(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local kills = Instance.new("IntValue")
    kills.Name = "Kills"
    kills.Value = 0
    --IntValue 객체는 반드시 leaderstats 폴더의 자식으로
    kills.Parent = leaderstats

    --player 객체의 CharacterAdded 이벤트에 연결된 무명함수
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        -- Humanoid의 displayName에 캐릭터 이름 넣기
        humanoid.DisplayName = character.Name
        humanoid.Died : Connect(function()
             local kills = player.leaderstats.Kills
             kills.Value = 0
        end)
    end)
end

local function onKillPlayer(playerFired)
    local kills = playerFired.leaderstats.Kills
    kills.Value += 1
end

Players.PlayerAdded:Connect(onPlayerAdded)
ServerStorage.KillEvent.Event:Connect(onKillPlayer)