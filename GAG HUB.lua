local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "PORN HUB",
	LoadingTitle = "PORN HUB",
	LoadingSubtitle = "by Handsome Toxin :wink:",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil,
		FileName = "PORN HUB"
	},
})

local AutoTab = Window:CreateTab("Automation", 4483362458)
local Shop = Window:CreateTab("Shop", 4483362458)

-- Dynamic Labels
local SeedLabel = Shop:CreateLabel("Seeds Purchased:")
local GearLabel = Shop:CreateLabel("Gears Purchased:")
local EggLabel = Shop:CreateLabel("Eggs Purchased:")

local Status = AutoTab:CreateLabel("Status: Stopped")

local SeedCounts, GearCounts, EggCounts = {}, {}, {}

local function updateLabels()
	local seedText, gearText, eggText = {}, {}, {}

	for name, count in pairs(SeedCounts) do
		table.insert(seedText, name .. " : " .. count)
	end
	for name, count in pairs(GearCounts) do
		table.insert(gearText, name .. " : " .. count)
	end
	for name, count in pairs(EggCounts) do
		table.insert(eggText, name .. " : " .. count)
	end

	SeedLabel:Set("Seeds Purchased:\n" .. table.concat(seedText, "\n"))
	GearLabel:Set("Gears Purchased:\n" .. table.concat(gearText, "\n"))
	EggLabel:Set("Eggs Purchased:\n" .. table.concat(eggText, "\n"))
end

-- Player Setup
local Players = game.Players
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local SeedShop = PlayerGui:WaitForChild("Seed_Shop")
local GearShop = PlayerGui:WaitForChild("Gear_Shop")
local PetConf = PlayerGui:WaitForChild("ConfirmPetEggPurchase")
local Eggs = workspace.NPCS["Pet Stand"]:WaitForChild("EggLocations")
local GameEvents = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")
local EggModels = game.ReplicatedStorage.Assets.Models.EggModels

local AllSeeds, AllGears, AllEggs = {}, {}, {}
local Selling = false

for _, seed in pairs(SeedShop.Frame.ScrollingFrame:GetChildren()) do
	if seed:FindFirstChild("Main_Frame") then
		table.insert(AllSeeds, seed.Name)
	end
end
for _, gear in pairs(GearShop.Frame.ScrollingFrame:GetChildren()) do
	if gear:FindFirstChild("Main_Frame") then
		table.insert(AllGears, gear.Name)
	end
end
for _, egg in pairs(EggModels:GetChildren()) do
	if egg:IsA("Model") then
		table.insert(AllEggs, egg.Name)
	end
end

_G.AutoBuySeed, _G.AutoBuyGear, _G.AutoBuyEgg = false, false, false
_G.wantedgear, _G.wantedseed, _G.wantedegg = {}, {}, {}

local HBLocations = {
	[1] = CFrame.new(-264.04126, 2.87553048, -3.26961374),
	[2] = CFrame.new(-264.039246, 2.79750657, 4.77034855),
	[3] = CFrame.new(-264.031219, 2.79750657, 0.740396142),
}

local function isSameCFrame(cf1, cf2, tolerance)
	tolerance = tolerance or 0.01
	return (cf1.Position - cf2.Position).magnitude <= tolerance
end

local function parseTimeStr(timeStr)
	local h, m, s = timeStr:match("^(%d+):(%d+):(%d+)$")
	h, m, s = tonumber(h), tonumber(m), tonumber(s)
	if not (h and m and s) then return 0 end
	return h * 3600 + m * 60 + s
end

local lastBought = {}

local function StartAutoBuy()
	while true do
		if _G.AutoBuySeed then
			for _, seed in pairs(SeedShop.Frame.ScrollingFrame:GetChildren()) do
				if table.find(_G.wantedseed, seed.Name) then
					local stockText = seed:FindFirstChild("Main_Frame") and seed.Main_Frame:FindFirstChild("Stock_Text")
					if stockText and stockText.Text ~= "X0 Stock" then
						GameEvents:WaitForChild("BuySeedStock"):FireServer(seed.Name)
						SeedCounts[seed.Name] = (SeedCounts[seed.Name] or 0) + 1
						updateLabels()
					end
				end
			end
		end

		if _G.AutoBuyGear then
			for _, gear in pairs(GearShop.Frame.ScrollingFrame:GetChildren()) do
				if table.find(_G.wantedgear, gear.Name) then
					local stockText = gear:FindFirstChild("Main_Frame") and gear.Main_Frame:FindFirstChild("Stock_Text")
					if stockText and stockText.Text ~= "X0 Stock" then
						GameEvents:WaitForChild("BuyGearStock"):FireServer(gear.Name)
						GearCounts[gear.Name] = (GearCounts[gear.Name] or 0) + 1
						updateLabels()
					end
				end
			end
		end

		if _G.AutoBuyEgg then
			for _, egg in pairs(Eggs:GetChildren()) do
				if table.find(_G.wantedegg, egg.Name) and egg.Part.Transparency ~= 0.65 then
					local timerLabel = workspace.NPCS["Pet Stand"].Timer.SurfaceGui:FindFirstChild("ResetTimeLabel")
					local timerText = timerLabel and timerLabel.Text or "00:00:00"
					local timeLeft = parseTimeStr(timerText)

					local now = tick()
					if lastBought[egg] and now < lastBought[egg] then continue end

					for index, loc in ipairs(HBLocations) do
						if isSameCFrame(egg.HitBox.CFrame, loc) then
							GameEvents:WaitForChild("BuyPetEgg"):FireServer(index)
							EggCounts[egg.Name] = (EggCounts[egg.Name] or 0) + 1
							updateLabels()
							lastBought[egg] = tick() + timeLeft
							break
						end
					end
				end
			end
		end
		task.wait(0.1)
	end
end

task.spawn(StartAutoBuy)

-- Harvest & Sell Section
_G.IgnoreSeed, _G.Harvest, _G.AutoSell, _G.Farm = {}, false, false, nil

local function removeCollision()
	if not _G.Farm then return end
	for _, plant in pairs(_G.Farm["Plants_Physical"]:GetChildren()) do
		for _, part in pairs(plant:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	end
end

for _, farm in pairs(workspace.Farm:GetChildren()) do
    if farm:FindFirstChild("Important") and farm.Important:FindFirstChild("Data") and farm.Important.Data.Owner.Value == Player.Name then
        _G.Farm = farm.Important
        break
    end
end

local Spots = {}
local canPlantParts = {}
local spotIndex = 1

if _G.Farm and _G.Farm:FindFirstChild("Plant_Locations") then
    for _, descendant in ipairs(_G.Farm.Plant_Locations:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.Name == "Can_Plant" then
            table.insert(canPlantParts, descendant)
        end
    end
end

local offsetList = {
    Vector3.new(0, 0, 0),
    Vector3.new(0, 0, 0),
    Vector3.new(0, 0, 25),
    Vector3.new(0, 0, -25),
    Vector3.new(0, 0, 25),
    Vector3.new(0, 0, -25),
}

local Moving = false
local Checking = false
local index = 1
for _, part in ipairs(canPlantParts) do
    for _, offset in ipairs(offsetList) do
        Spots[index] = part.CFrame * CFrame.new(offset)
        index += 1
    end
end

local function Alternate()
    local character = Player.Character
    if character and character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart") and not Moving and Spots[spotIndex] and not Selling then
        local humanoid = character.Humanoid
        local destination = Spots[spotIndex].Position
        local finished = false
		Moving = true

        local connection
        connection = humanoid.MoveToFinished:Connect(function(reached)
            finished = true
			Moving = false
            if connection then
                connection:Disconnect()
            end
        end)

        humanoid:MoveTo(destination)

        task.spawn(function()
		    if Checking then return end
			Checking = true
            while humanoid and humanoid.Health > 0 and Checking do
				if not _G.Harvest then
					break
				end
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                if finished then
					task.wait(0.5)
				else
				    task.wait(0.4)
				end
            end
        end)

        spotIndex += 1
        if spotIndex > #Spots then
            spotIndex = 1 
        end
    end
end

local function StartHarvest()
	Player.Character.HumanoidRootPart.CFrame = _G.Farm.Parent.Spawn_Point.CFrame

    while _G.Harvest do
        if _G.Farm and not Selling then
            task.spawn(removeCollision)

            for _, plant in pairs(_G.Farm["Plants_Physical"]:GetChildren()) do
                if not table.find(_G.IgnoreSeed, plant.Name) then
                    if not _G.Harvest or Selling then break end
                    for _, prox in pairs(plant:GetDescendants()) do
                        if prox:IsA("ProximityPrompt") then
                            if not _G.Harvest or Selling then break end
                            Status:Set("Status: Picking Up Seeds!")
							task.spawn(Alternate)
                            fireproximityprompt(prox)
                        end
                    end
                end
            end
        end
        task.wait(5)
    end
    Status:Set("Status: Stopped")
end

local function AutoSell()
	while _G.AutoSell do
		if #Player.Backpack:GetChildren() >= 200 and not Selling then
			Selling = true
            Status:Set("Status: Selling")
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(61.579361, 3, 0.426799864)
			task.wait()
			Player.Character.Humanoid:MoveTo(Vector3.new(65, 3, 1))
			task.wait(.2)
            game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
			task.wait(2)
			Selling = false
			Player.Character.HumanoidRootPart.CFrame = _G.Farm.Parent.Spawn_Point.CFrame
		end
		task.wait(1)
	end
end

-- Rayfield UI Controls
Shop:CreateToggle({
	Name = "Auto Buy Seed",
	CurrentValue = false,
	Flag = "ToggleAutoBuySeed",
	Callback = function(Value) _G.AutoBuySeed = Value end
})

Shop:CreateDropdown({
	Name = "Wanted Seeds",
	Options = AllSeeds,
	MultipleOptions = true,
	CurrentOption = {},
	Flag = "WantedSeedsDropdown",
	Callback = function(Selected) _G.wantedseed = Selected end
})

Shop:CreateToggle({
	Name = "Auto Buy Gear",
	CurrentValue = false,
	Flag = "ToggleAutoBuyGear",
	Callback = function(Value) _G.AutoBuyGear = Value end
})

Shop:CreateDropdown({
	Name = "Wanted Gear",
	Options = AllGears,
	MultipleOptions = true,
	CurrentOption = {},
	Flag = "WantedGearDropdown",
	Callback = function(Selected) _G.wantedgear = Selected end
})

Shop:CreateToggle({
	Name = "Auto Buy Egg",
	CurrentValue = false,
	Flag = "ToggleAutoBuyEgg",
	Callback = function(Value) _G.AutoBuyEgg = Value end
})

Shop:CreateDropdown({
	Name = "Wanted Egg",
	Options = AllEggs,
	MultipleOptions = true,
	CurrentOption = {},
	Flag = "WantedEggDropdown",
	Callback = function(Selected) _G.wantedegg = Selected end
})

AutoTab:CreateToggle({
	Name = "Auto Harvest",
	CurrentValue = false,
	Flag = "ToggleHarvest",
	Callback = function(Value)
		_G.Harvest = Value
		if Value then task.spawn(StartHarvest) end
	end
})

AutoTab:CreateDropdown({
	Name = "Ignored Crops",
	Options = AllSeeds,
	MultipleOptions = true,
	CurrentOption = {},
	Flag = "IgnoredCropsDropdown",
	Callback = function(Selected) _G.IgnoreSeed = Selected end
})

AutoTab:CreateToggle({
	Name = "Auto Sell",
	CurrentValue = false,
	Flag = "ToggleSell",
	Callback = function(Value)
		_G.AutoSell = Value
		if Value then task.spawn(AutoSell) end
	end
})
