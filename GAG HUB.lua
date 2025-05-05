local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "PORN HUB",
	LoadingTitle = "PORN HUB",
	LoadingSubtitle = "by Handsome Toxin :wink:",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "GAG",
		FileName = "PORN HUB"
	},
})

local AutoTab = Window:CreateTab("Automation", 4483362458)
local Shop = Window:CreateTab("Shop", 4483362458)
local Weather = Window:CreateTab("Weather", 4483362458)
local Misc = Window:CreateTab("Misc", 4483362458)

-- Dynamic Labels
local PurchaseParagraph = Shop:CreateParagraph({
	Title = "Purchased Items:",
	Content = "",
})

local MoneyLabel = Shop:CreateLabel("Money Earned: 0")

local Status = AutoTab:CreateLabel("Status: Stopped")

-- Tables and Shits
local SeedCounts, GearCounts, EggCounts, Spots, canPlantParts, lastBought, MoneyEarned, index, spotIndex = {}, {}, {}, {}, {}, {}, 0, 1, 1
local AllSeeds, AllGears, AllEggs, AllMutations = {}, {}, {}, {"Frozen", "Shocked", "Wet", "Rainbow", "Gold", "Chilled"}
local Selling, Moving, Checking = false, false, false

local PlantedObject = nil
local SelectedSeed = nil
local PlantedObjectCFrame = nil
local DisabledParts = {}
local FreeTrowelConnection = nil

_G.AutoBuySeed, _G.AutoBuyGear, _G.AutoBuyEgg = false, false, false
_G.wantedgear, _G.wantedseed, _G.wantedegg= {}, {}, {}
_G.IgnoreSeed, _G.IgnoreMutation, _G.WeathersStop, _G.IgnoreWeight, _G.Harvest, _G.AutoSell, _G.AutoPlace, _G.StopOnWeather, _G.StopHarvest, _G.Farm, _G.WeatherConnection, _G.ButtonCon, _G.FreeTrowelConnection = {}, {}, {}, "None", false, false, false, false, nil, nil, nil, nil
if not _G.ReducedPlants then
    _G.ReducedPlants = {}
end
--Positions and CFrames
local HBLocations = {
	[1] = CFrame.new(-264.04126, 2.87553048, -3.26961374),
	[2] = CFrame.new(-264.039246, 2.79750657, 4.77034855),
	[3] = CFrame.new(-264.031219, 2.79750657, 0.740396142),
}
local offsetList = {
    Vector3.new(0, 0, 0),
    Vector3.new(0, 0, 0),
    Vector3.new(0, 0, 25),
    Vector3.new(0, 0, -25),
    Vector3.new(0, 0, 25),
    Vector3.new(0, 0, -25),
}

-- Player Setup
local Players = game.Players
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local ReplicatedStorage = game.ReplicatedStorage
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local Modules = ReplicatedStorage.Modules

local GetFarm = require(Modules.GetFarm)

local TrowelRemote = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("TrowelRemote")

local SeedShop = PlayerGui:WaitForChild("Seed_Shop")
local GearShop = PlayerGui:WaitForChild("Gear_Shop")
local PetConf = PlayerGui:WaitForChild("ConfirmPetEggPurchase")
local Eggs = workspace.NPCS["Pet Stand"]:WaitForChild("EggLocations")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
local EggModels = ReplicatedStorage.Assets.Models.EggModels

_G.Farm = GetFarm(Player).Important

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
if _G.Farm and _G.Farm:FindFirstChild("Plant_Locations") then
    for _, descendant in ipairs(_G.Farm.Plant_Locations:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.Name == "Can_Plant" then
            table.insert(canPlantParts, descendant)
        end
    end
else
    warn("There was an error Loading your plot, Restart the script.")
    return
end
for _, part in ipairs(canPlantParts) do
    for _, offset in ipairs(offsetList) do
        Spots[index] = part.CFrame * CFrame.new(offset)
        index += 1
    end
end
local function split(str, sep)
	local result = {}
	for item in string.gmatch(str, "([^"..sep.."]+)") do
		table.insert(result, item)
	end
	return result
end

local weatherString = workspace:GetAttribute("AllWeather")
local weatherOptions = split(weatherString, ",")
local weatherOptions = game:GetService("HttpService"):JSONDecode(weatherString)
-- Functions
local StartOffMoney = Player.leaderstats:WaitForChild("Sheckles").Value
Player.leaderstats.Sheckles.Changed:Connect(function()
    local currentMoney = Player.leaderstats.Sheckles.Value
    if currentMoney > StartOffMoney then
        local added = currentMoney - StartOffMoney
        MoneyEarned += added
        MoneyLabel:Set("Money Earned: " .. MoneyEarned)
    end
    StartOffMoney = currentMoney
end)
local function CancelPlanting()
    if PlantedObject then
        local prevObject = PlantedObject
        PlantedObject = nil
        if Player.Character:FindFirstChildOfClass("Humanoid") then
            Player.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
        end
        TrowelRemote:InvokeServer("Cancel", SelectedSeed, prevObject)
        for _, part in DisabledParts do
            part.CanCollide = true
            part.CanQuery = true
        end
    end
end
local function RaycastIgnoreShovel(mousePosition)
    local ray = Camera:ViewportPointToRay(mousePosition.X, mousePosition.Y)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { game:GetService("CollectionService"):GetTagged("ShovelIgnore") }
    return workspace:Raycast(ray.Origin, ray.Direction * 500, params)
end
local function RaycastPlantLocations(mousePosition)
    local ray = Camera:ViewportPointToRay(mousePosition.X, mousePosition.Y)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Include
    params.FilterDescendantsInstances = { GetFarm(Player).Important.Plant_Locations:GetChildren() }
    return workspace:Raycast(ray.Origin, ray.Direction * 500, params)
end
_G.TrowelCon = RunService.RenderStepped:Connect(function()
    if _G.FreeTrowel and _G.FreeTrowel.Parent == Player.Character then
        local mousePos = UIS:GetMouseLocation()
        if PlantedObject then
            local rayResult = RaycastPlantLocations(mousePos)
            if rayResult and rayResult.Position then
                PlantedObject:PivotTo(CFrame.new(rayResult.Position) * CFrame.new(0, 3, 0) * PlantedObjectCFrame.Rotation)
            else
                PlantedObject:PivotTo(PlantedObjectCFrame)
            end
        end
    else
        if PlantedObject then
            CancelPlanting()
        end
        return
    end
end)
local function IsValidPlantTarget(target)
    local farmModel = GetFarm(Player).Important
    if farmModel then
        if target:IsDescendantOf(farmModel) then
            return target:FindFirstChild("Grow")
                and target:FindFirstChild("Fruits")
                and target:FindFirstChild("Fruit_Spawn")
                and target.Parent.Name ~= "Fruits"
                and target:FindFirstChild("ADD_DATA") or false
        else
            return false
        end
    else
        return false
    end
end
local function UseTrowel()
    if _G.FreeTrowel and _G.FreeTrowel.Parent == Player.Character then
        local mousePos = UIS:GetMouseLocation()
        if PlantedObject then
            local rayResult = RaycastPlantLocations(mousePos)
            if rayResult then
                local plantCheckParams = RaycastParams.new()
                plantCheckParams.FilterType = Enum.RaycastFilterType.Include
                plantCheckParams.FilterDescendantsInstances = { GetFarm(Player).Important.Plants_Physical:GetChildren() }
                if not workspace:Raycast(rayResult.Position + Vector3.new(0, 20, 0), Vector3.new(0, -25, 0), plantCheckParams) then
                    task.spawn(function()
                        local newCFrame = CFrame.new(rayResult.Position) * CFrame.new(0, 3, 0) * PlantedObjectCFrame.Rotation
                        local endCFrame = CFrame.new(rayResult.Position.X, PlantedObjectCFrame.Y, rayResult.Position.Z) * PlantedObjectCFrame.Rotation
                        local object = PlantedObject
                        object:PivotTo(newCFrame)
                        local timeElapsed = 0
                        while timeElapsed < 0.15 do
                            timeElapsed += RunService.Heartbeat:Wait()
                            object:PivotTo(newCFrame:Lerp(endCFrame, game:GetService("TweenService"):GetValue(timeElapsed / 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)))
                        end
                        TrowelRemote:InvokeServer("Place", SelectedSeed, object, endCFrame)
                    end)
                    for _, part in DisabledParts do
                        part.CanCollide = true
                        part.CanQuery = true
                    end
                    PlantedObject = nil
                end
            end
        else
            local rayHit = RaycastIgnoreShovel(mousePos)
            if rayHit then
                local hitParent = rayHit.Instance.Parent
                if IsValidPlantTarget(hitParent) then
                    TrowelRemote:InvokeServer("Pickup", SelectedSeed, hitParent)
                    PlantedObjectCFrame = hitParent:GetPivot()
                    for _, part in hitParent:GetDescendants() do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                            part.CanQuery = false
                            table.insert(DisabledParts, part)
                        elseif part:IsA("BasePart") then
                            part.CanQuery = false
                        end
                    end
                    PlantedObject = hitParent
                end
            end
        end
    end
end
local function updateParagraph()
	local allItems = {}

	for name, count in pairs(SeedCounts) do
		table.insert(allItems, "Seed - " .. name .. " : " .. count)
	end
	for name, count in pairs(GearCounts) do
		table.insert(allItems, "Gear - " .. name .. " : " .. count)
	end
	for name, count in pairs(EggCounts) do
		table.insert(allItems, "Egg - " .. name .. " : " .. count)
	end

	PurchaseParagraph:Set({
		Title = "Purchased Items:",
		Content = table.concat(allItems, "\n")
	})
end
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
local function StartAutoBuy()
	while true do
		if _G.AutoBuySeed then
			for _, seed in pairs(SeedShop.Frame.ScrollingFrame:GetChildren()) do
				if table.find(_G.wantedseed, seed.Name) then
					local stockText = seed:FindFirstChild("Main_Frame") and seed.Main_Frame:FindFirstChild("Stock_Text")
					if stockText and stockText.Text ~= "X0 Stock" then
						GameEvents:WaitForChild("BuySeedStock"):FireServer(seed.Name)
						SeedCounts[seed.Name] = (SeedCounts[seed.Name] or 0) + 1
						updateParagraph()
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
						updateParagraph()
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
							updateParagraph()
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
local function Alternate()
    local character = Player.Character
    if character and character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart") and not Moving and Spots[spotIndex] and not Selling then
        local humanoid = character.Humanoid
        local destination = Spots[spotIndex].Position
		Moving = true

        local connection
        connection = humanoid.MoveToFinished:Connect(function(reached)
		    Moving = false
            if connection then
                connection:Disconnect()
            end
        end)

		character.HumanoidRootPart.Anchored = false
		character.Humanoid.PlatformStand = false

		if math.random(1,3) == 3 then
            character.HumanoidRootPart.CFrame = CFrame.new(destination + Vector3.new(0, math.random(25,30), 0))
			character.Humanoid.PlatformStand = true
			character.HumanoidRootPart.Anchored = true
			task.delay(0.3, function()
			    Moving = false
			end)
		else
		    humanoid:MoveTo(destination)
		end

        task.spawn(function()
		    if Checking then return end
			Checking = true
            while humanoid and humanoid.Health > 0 and Checking do
				if not _G.Harvest or _G.StopHarvest then
					break
				end
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                task.wait(0.7)
            end
			Checking = false
        end)

        spotIndex += 1
        if spotIndex > #Spots then
            spotIndex = 1 
        end
    end
end
local function StartHarvest()
    Player.Character.HumanoidRootPart.CFrame = _G.Farm.Parent.Spawn_Point.CFrame
	task.wait(1)
    while _G.Harvest do
        if _G.Farm and not Selling and not _G.StopHarvest then
            task.spawn(removeCollision)

            for _, plant in pairs(_G.Farm["Plants_Physical"]:GetChildren()) do
                if table.find(_G.IgnoreSeed, plant.Name) then
                    continue
                end

                if not _G.Harvest or Selling or _G.StopHarvest then
                    break
                end

                local skipDueToAttribute = false

				if not plant:FindFirstChild("Fruits") then
				    if _G.IgnoreWeight ~= "None" and plant.Weight.Value >= _G.IgnoreWeight then
					    continue
					end
                    if plant:FindFirstChild("Variant") then
					    if table.find(_G.IgnoreMutation, plant:FindFirstChild("Variant").Value) then
						    continue
						end
					end
                    for name, value in pairs(plant:GetAttributes()) do
                        if table.find(_G.IgnoreMutation, name) and value == true then
                            skipDueToAttribute = true
                            break
                        end
                    end
				end

                if skipDueToAttribute then
                    continue
                end

                for _, descendant in pairs(plant:GetDescendants()) do
                    local parent = descendant.Parent

                    local parentVariant = parent:FindFirstChild("Variant")
                    if parentVariant and table.find(_G.IgnoreMutation, parentVariant.Value) then
                        continue
                    end

					if parent:FindFirstChild("Weight") and _G.IgnoreWeight ~= "None" then
					    if parent:FindFirstChild("Weight").Value >= _G.IgnoreWeight then
						    continue
						end
					end

                    local skipChild = false
                    for name, value in pairs(parent:GetAttributes()) do
                        if table.find(_G.IgnoreMutation, name) and value == true then
                            skipChild = true
                            break
                        end
                    end
                    if skipChild then
                        continue
                    end

                    if descendant:IsA("ProximityPrompt") then
                        if not _G.Harvest or Selling or _G.StopHarvest then
                            break
                        end
                        Status:Set("Status: Picking Up Seeds!")
                        task.spawn(Alternate)
                        fireproximityprompt(descendant)
                    end
                end
            end
        end
        task.wait(3)
    end
    Player.Character.HumanoidRootPart.Anchored = false
	Player.Character.Humanoid.PlatformStand = false
    Status:Set("Status: Stopped")
end
local function AutoSell()
	while _G.AutoSell do
		if #Player.Backpack:GetChildren() >= 200 and not Selling then
			Selling = true
            Status:Set("Status: Selling")
			Player.Character.Humanoid.PlatformStand = false
		    Player.Character.HumanoidRootPart.Anchored = false
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(61.579361, 3, 0.426799864)
			task.wait(.1)
			Player.Character.Humanoid:MoveTo(Vector3.new(65, 3, 1))
			task.wait(.2)
            game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
			task.wait(3)
			Player.Character.HumanoidRootPart.CFrame = _G.Farm.Parent.Spawn_Point.CFrame
			task.wait(1.3)
			Selling = false
		end
		task.wait(1)
	end
end
local function StopOnWeather()
    if _G.WeatherConnection then _G.WeatherConnection:Disconnect() end 

	for name, value in pairs(workspace:GetAttributes()) do
        if value and name:match("(.+)Event$") then 
            local weatherName = name:match("(.+)Event")

            if table.find(_G.WeathersStop, weatherName) then
                _G.StopHarvest = true
                Status:Set("Status: Waiting for weather to end...")
                while workspace:GetAttribute(name) do
                    if not _G.StopOnWeather then
                        break
                    end
                    task.wait(0.25)
                end
                _G.StopHarvest = false
                break
            end
        end
    end

    _G.WeatherConnection = workspace.AttributeChanged:Connect(function(attribute)
        if table.find(_G.WeathersStop, attribute) and workspace:GetAttribute(attribute) then
            _G.StopHarvest = true
            while workspace:GetAttribute(attribute) do
			    if not _G.StopOnWeather then
				    break
				end
                task.wait(0.25)
            end
            _G.StopHarvest = false
        end
    end)
end
task.spawn(StopOnWeather)
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
	Name = "Ignored Mutations",
	Options = AllMutations,
	MultipleOptions = true,
	CurrentOption = {},
	Flag = "IgnoredMutationsDropdown",
	Callback = function(Selected) _G.IgnoreMutation = Selected end
})
AutoTab:CreateDropdown({
	Name = "Ignored Crops",
	Options = AllSeeds,
	MultipleOptions = true,
	CurrentOption = {},
	Flag = "IgnoredCropsDropdown",
	Callback = function(Selected) _G.IgnoreSeed = Selected end
})
local WeightSlider = AutoTab:CreateSlider({
   Name = "Ignore Weight Scale",
   Range = {0, 100},
   Increment = 0.1,
   Suffix = "Scale",
   CurrentValue = 0,
   Flag = "WeightValue", 
   Callback = function(Value)
        if Value == 0 then
		    _G.IgnoreWeight = "None"
		else
		    _G.IgnoreWeight = tonumber(Value)
		end
   end,
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
Weather:CreateToggle({
	Name = "Stop On Weather",
	CurrentValue = false,
	Flag = "StopOnWeather",
	Callback = function(Value)
		_G.StopOnWeather = Value
	end
})
Weather:CreateDropdown({
	Name = "Weather to Stop On",
	Options = weatherOptions,
	MultipleOptions = true,
	CurrentOption = {},
	Flag = "WeatherToStopOn",
	Callback = function(Selected) 
	    _G.WeathersStop = Selected 
		task.spawn(function()
		    if _G.StopHarvest then return end
            for name, value in pairs(workspace:GetAttributes()) do
                if value and name:match("(.+)Event$") then 
                    local weatherName = name:match("(.+)Event")
                    if table.find(_G.WeathersStop, weatherName) then
                        _G.StopHarvest = true
                        Status:Set("Status: Waiting for weather to end...")
                        while workspace:GetAttribute(name) do
                            if not _G.StopOnWeather then
                                break
                            end
                            task.wait(0.25)
                        end
                        _G.StopHarvest = false
                        break
                    end
                end
            end
		end)
	end
})
Misc:CreateButton({
   Name = "Teleport to Gear Shop",
   Callback = function()
       Player.Character.HumanoidRootPart.CFrame = CFrame.new(-261.435242, 2.99999976, -30.9976654, -5.7586225e-05, -1.86026283e-09, 1, 8.98066066e-09, 1, 1.86077997e-09, -1, 8.98076813e-09, -5.7586225e-05)
   end,
})
Misc:CreateButton({
   Name = "Teleport to Egg Shop",
   Callback = function()
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(-257.941437, 2.99999976, 0.139790639, 0.00901781209, 3.10404964e-08, 0.99995935, -7.48513003e-08, 1, -3.03667385e-08, -0.99995935, -7.4574416e-08, 0.00901781209)
   end,
})
Misc:CreateButton({
   Name = "INF Trowel (Does not save the Position)",
   Callback = function()
       if not Player.Backpack:FindFirstChild("Free Trowel") then
	        if Player.PlayerScripts["Trowel_Client"].Enabled then
                Player.PlayerScripts["Trowel_Client"].Disabled = true
            end
            _G.FreeTrowel = Instance.new("Tool")
	        _G.FreeTrowel.Name = "Free Trowel"
	        _G.FreeTrowel.Parent = Player.Backpack

			_G.FreeTrowelConnection = _G.FreeTrowel.Unequipped:Connect(CancelPlanting)
			_G.ButtonCon = Player:GetMouse().Button1Down:Connect(UseTrowel)
		else
		     CancelPlanting()
		    _G.FreeTrowelConnection = Player.Backpack:FindFirstChild("Free Trowel").Unequipped:Connect(CancelPlanting)
			_G.ButtonCon = Player:GetMouse().Button1Down:Connect(UseTrowel)
	   end
   end,
})
Misc:CreateToggle({
	Name = "Reduce Lag",
	CurrentValue = false,
	Flag = "ReduceLag",
	Callback = function(Value)
		if _G.Farm then
            if Value then 
			    if #_G.ReducedPlants > 0 then
                    for _, reduced in pairs(_G.ReducedPlants) do
				        if reduced:IsA("ParticleEmitter") then
					        reduced.Enabled = false
					    else
					        reduced.Transparency = 1
					    end
				    end
				end
			    for _, plant in pairs(_G.Farm["Plants_Physical"]:GetDescendants()) do
				    if plant:IsA("BasePart") and plant.Transparency ~= 1 and not table.find(_G.ReducedPlants, plant) then
					    task.spawn(function()
					        plant:SetAttribute("DefaultTransparency", plant.Transparency)
					        task.wait()
					        plant.Transparency = 1
					        table.insert(_G.ReducedPlants, plant)
					    end)
					elseif plant:IsA("ParticleEmitter") and plant.Enabled and not table.find(_G.ReducedPlants, plant) then
					    task.spawn(function()
						    plant.Enabled = false
							table.insert(_G.ReducedPlants, plant)
						end)
					end
				end
		    else
			    for _, reduced in pairs(_G.ReducedPlants) do
				    if reduced:IsA("ParticleEmitter") then
					    reduced.Enabled = true
					else
					    reduced.Transparency = reduced:GetAttribute("DefaultTransparency") or 0
					end
				end
		    end
		end
	end
})
Rayfield:LoadConfiguration()
