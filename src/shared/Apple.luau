--!strict
-- Builds the apple Model from basic parts, so the apple lives in code instead of only in the place file.

local Apple = {}

local RED = Color3.fromRGB(205, 30, 35)
local DARK_RED = Color3.fromRGB(120, 12, 20)
local BROWN = Color3.fromRGB(125, 80, 45)
local GREEN = Color3.fromRGB(70, 170, 60)

local function addPart(
	model: Model,
	name: string,
	shape: Enum.PartType,
	size: Vector3,
	cframe: CFrame,
	color: Color3,
	material: Enum.Material?
): Part
	local part = Instance.new("Part")
	part.Name = name
	part.Shape = shape
	part.Size = size
	part.CFrame = cframe
	part.Color = color
	part.Material = material or Enum.Material.SmoothPlastic
	part.Anchored = true
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Parent = model
	return part
end

-- Returns a new "Apple" Model whose base sits at `origin` (default: world origin, resting on y = 0).
function Apple.build(origin: CFrame?): Model
	local base = origin or CFrame.new()
	local model = Instance.new("Model")
	model.Name = "Apple"

	local ball = Enum.PartType.Ball
	local body = addPart(model, "Body", ball, Vector3.new(8, 8.6, 8), base * CFrame.new(0, 4.6, 0), RED)
	addPart(model, "ShoulderL", ball, Vector3.new(6, 7.2, 6.4), base * CFrame.new(-1.0, 5.2, 0), RED)
	addPart(model, "ShoulderR", ball, Vector3.new(6, 7.2, 6.4), base * CFrame.new(1.0, 5.2, 0), RED)
	addPart(model, "Bottom", ball, Vector3.new(5.6, 4.4, 5.6), base * CFrame.new(0, 2.2, 0), RED)
	addPart(model, "TopDip", ball, Vector3.new(3, 1.4, 3), base * CFrame.new(0, 8.7, 0), DARK_RED)

	addPart(
		model,
		"Stem",
		Enum.PartType.Cylinder,
		Vector3.new(2.8, 0.7, 0.7),
		base * CFrame.new(0.3, 9.7, 0) * CFrame.Angles(0, 0, math.rad(90 - 12)),
		BROWN,
		Enum.Material.Wood
	)

	-- Ball parts are always spheres, so the flat leaf is a Block with a sphere mesh stretched over it.
	local leaf = addPart(
		model,
		"Leaf",
		Enum.PartType.Block,
		Vector3.new(4.2, 0.3, 2.0),
		base * CFrame.new(2.4, 10.7, 0) * CFrame.Angles(0, math.rad(10), math.rad(20)),
		GREEN,
		Enum.Material.Grass
	)
	local mesh = Instance.new("SpecialMesh")
	mesh.MeshType = Enum.MeshType.Sphere
	mesh.Parent = leaf

	model.PrimaryPart = body
	return model
end

return Apple
