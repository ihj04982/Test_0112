local Lighting = game:GetService("Lighting")

local minutesAfterMidnight = 9*60
while true do
    minutesAfterMidnight = minutesAfterMidnight + 1
    Lighting : SetMinutesAfterMidnight(minutesAfterMidnight)
    Wait()
end