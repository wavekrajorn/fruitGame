--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Apple = require(ReplicatedStorage.Shared.Apple)

-- The place already has a hand-placed Apple; only build one if it is missing.
if not workspace:FindFirstChild("Apple") then
	Apple.build(CFrame.new(0, 0, -20)).Parent = workspace
end
