local Players = game : GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local killPlayer = ReplicatedStorage:WaitForChild("KillPlayer")

--local textLabel = script.Parent:WaitForChild("TextLabel")
local textLabel = script.Parent

killPlayer.OnClientEvent:Connect(function()
    print("KillPlayer 메시지 받음")
    --Kills 객체가 없으면 추가함
    if not Players.LocalPlayer:FindFirstChild("Kills") then
        --IntValue 추가
        local kills = Instance.new("IntValue")
        kills.Name = "Kills"
        kills.Value = 0
        kills.Parent = Players.LocalPlayer
    end
    -- 플레이어 객체에 kills 객체로 현재 점수 저장
    Players.LocalPlayer.Kills.Value += 1
    -- 텍스트 라벨의 점수 갱신
    textLabel.Text = Players.LocalPlayer.Kills.Value
end)