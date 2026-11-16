--!strict
-- Builds a banana lying on its side: a curved row of overlapping balls with a stem and a dark tip.

local PartFactory = require(script.Parent.PartFactory)

local Banana = {}

local YELLOW = Color3.fromRGB(240, 205, 60)
local STEM_BROWN = Color3.fromRGB(110, 90, 40)
local TIP_BROWN = Color3.fromRGB(60, 40, 25)

local SEGMENTS = 17
local RADIUS = 8 -- radius of the curve
local HALF_ARC = math.rad(55)
local MAX_THICKNESS = 3.0
local MIN_THICKNESS = 1.5

-- Returns a new "Banana" Model centred on `origin` (default: world origin), resting on y = 0.
function Banana.build(origin: CFrame?): Model
	local base = origin or CFrame.new()
	local model = Instance.new("Model")
	model.Name = "Banana"

	local step = (HALF_ARC * 2) / (SEGMENTS - 1)
	local zShift = -RADIUS * (1 - math.cos(HALF_ARC)) / 2 -- centre the curve on the origin
	local middle: Part? = nil

	for i = 1, SEGMENTS do
		local angle = -HALF_ARC + (i - 1) * step
		local t = (i - 1) / (SEGMENTS - 1)
		-- thickest in the middle, thinner at both ends
		local thickness = MIN_THICKNESS + (MAX_THICKNESS - MIN_THICKNESS) * math.sin(t * math.pi)
		local position = Vector3.new(RADIUS * math.sin(angle), thickness / 2, RADIUS * (1 - math.cos(angle)) + zShift)
		-- Overlapping balls of varying size give a smooth, rounded body with no seams.
		local part = PartFactory.add(
			model,
			"Segment" .. i,
			Enum.PartType.Ball,
			Vector3.new(thickness, thickness, thickness),
			base * CFrame.new(position),
			YELLOW
		)
		if i == math.ceil(SEGMENTS / 2) then
			middle = part
		end
	end

	-- stem at the start of the curve
	local startAngle = -HALF_ARC
	local stemThickness = 0.8
	local stemPos = Vector3.new(
		RADIUS * math.sin(startAngle) - 1.6 * math.cos(startAngle),
		stemThickness / 2 + 0.2,
		RADIUS * (1 - math.cos(startAngle)) + zShift - 1.6 * math.sin(startAngle)
	)
	PartFactory.add(
		model,
		"Stem",
		Enum.PartType.Cylinder,
		Vector3.new(1.8, stemThickness, stemThickness),
		base * CFrame.new(stemPos) * CFrame.Angles(0, -startAngle, 0),
		STEM_BROWN,
		Enum.Material.Wood
	)

	-- dark tip at the end of the curve
	local endAngle = HALF_ARC
	local tipSize = 0.9
	local tipPos = Vector3.new(
		RADIUS * math.sin(endAngle) + 1.0 * math.cos(endAngle),
		tipSize / 2 + 0.15,
		RADIUS * (1 - math.cos(endAngle)) + zShift + 1.0 * math.sin(endAngle)
	)
	PartFactory.add(
		model,
		"Tip",
		Enum.PartType.Ball,
		Vector3.new(tipSize, tipSize, tipSize),
		base * CFrame.new(tipPos),
		TIP_BROWN
	)

	model.PrimaryPart = middle
	return model
end

return Banana
