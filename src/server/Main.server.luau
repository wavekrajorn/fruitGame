--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Apple = require(ReplicatedStorage.Shared.Apple)
local Banana = require(ReplicatedStorage.Shared.Banana)

-- The place may already have hand-placed fruit; only build one if it is missing.
if not workspace:FindFirstChild("Apple") then
	Apple.build(CFrame.new(0, 0, -20)).Parent = workspace
end

if not workspace:FindFirstChild("Banana") then
	Banana.build(CFrame.new(14, 0, -20)).Parent = workspace
end
