wait(3)
print("RBXShade | Hello, welcome to the script! Do not close console")
game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)

wait(2)

local outlineFolder = Instance.new("Folder")
outlineFolder.Name = "RBXShade"
outlineFolder.Parent = game.Workspace


local message1 = "RBXShade | Creating lighting.."
local message2 = "RBXShade | Lighting created!"
local message3 = "RBXShade | Shader for Part added:"
local message4 = "RBXShade | Removing old lighting.."
local message5 = "RBXShade | Script executed!"
local message6 = "RBXShade | Old lighting removed!"
function lighting()
	print(message4)
	local oldlight = game.Lighting:GetChildren()
	oldlight.Enabled = false
	print(message6)
	task.wait(3)

	print(message1)
	local outlineFolder = Instance.new("Folder")
	outlineFolder.Parent = game.Workspace
	outlineFolder.Name = "RBXShade"

	local a=Instance.new"Atmosphere"
	a.Offset=0.25
	a.Color=Color3.fromRGB(199,199,199)
	a.Decay=Color3.fromRGB(106,112,125)
	a.Density=0.3
	a.Parent=game:GetService"Lighting"

	local b=Instance.new"BloomEffect"
	b.Intensity=1
	b.Threshold=2
	b.Parent=game:GetService"Lighting"

	local c=Instance.new"DepthOfFieldEffect"
	c.Enabled=false
	c.FarIntensity=0.1
	c.InFocusRadius=30
	c.Parent=game:GetService"Lighting"

	local d=Instance.new"Sky"
	d.SkyboxUp="rbxassetid://6412503613"
	d.MoonTextureId="rbxassetid://6444320592"
	d.SkyboxLf="rbxassetid://6444884337"
	d.SkyboxBk="rbxassetid://6444884337"
	d.SkyboxFt="rbxassetid://6444884337"
	d.SkyboxDn="rbxassetid://6444884785"
	d.SunTextureId="rbxassetid://6196665106"
	d.SunAngularSize=11
	d.SkyboxRt="rbxassetid://6444884337"
	d.Parent=game:GetService"Lighting"

	local e=Instance.new"SunRaysEffect"
	e.Intensity=0.01
	e.Spread=0.1
	e.Parent=game:GetService"Lighting"
	print(message2)
end

lighting()

-- Функция для создания обводки вокруг объекта
local function createOutline(part)
	
	-- Создаём новый парт вокруг исходного с меньшими размерами
	local outlinePart = Instance.new("Part")
	outlinePart.CanCollide = false  -- Чтобы не мешал
	outlinePart.Size = part.Size + Vector3.new(0.1, 0.1, 0.1)  -- Увеличиваем размер на 1 по каждому направлению
	outlinePart.Position = part.Position
	outlinePart.Anchored = part.Anchored
	outlinePart.Material = Enum.Material.Glass
	outlinePart.Transparency = 1.7  -- Прозрачность 0.4 для материала Glass
	outlinePart.Massless = part.Massless
	outlinePart.Name = part.Name.. "_Shader"
	outlinePart.CastShadow = false
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = outlinePart
	weld.Part1 = part
	weld.Parent = outlinePart
	outlinePart.Parent = outlineFolder

	-- Создаём Highlight с базовыми настройками, но всегда выключаем
	local highlight = Instance.new("Highlight")
	highlight.Adornee = outlinePart  -- Highlight теперь привязан к outlinePart
	highlight.Parent = outlinePart   -- Highlight должен быть в парт для обновлений
	highlight.Enabled = false      -- Изначально выключаем
	print(message3.. part.Name)
	wait(0.6)
	return outlinePart, highlight
end

-- Проходим по всем партах и партоподобным объектам в Workspace
for _, obj in pairs(game.Workspace:GetChildren()) do
	-- Проверяем, является ли объект партом или партоподобным и есть ли у него Humanoid
	if (obj:IsA("Part") or obj:IsA("MeshPart")) and not obj:FindFirstChild("Humanoid") then
		local outlinePart, highlight = createOutline(obj)

		-- Не включаем Highlight, так как он всегда должен быть выключен
		highlight.Enabled = false  -- Оставляем всегда выключенным
	end
end

local command = Instance.new("TextChatCommand")
command.Parent = game.TextChatService
command.PrimaryAlias = "/dshade"
command.Triggered:Connect(function()
	local sadsoung = Instance.new("Sound")
	sadsoung.SoundId = "rbxassetid://8904888220"
	sadsoung.Parent = script
	game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
	warn("RBXShade | Removing shaders...")
	outlineFolder:Destroy()
	task.wait(1)
	sadsoung:Play()
	warn("RBXShade | Shaders removed. Goodbye!")
end)

print("RBXShade | If you wish to destroy shaders, type in chat /dshade ")
wait(1)
print("RBXShade | You can close console")
