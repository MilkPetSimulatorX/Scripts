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
local AllSeeds, AllGears, AllEggs, AllMutations = {}, {}, {}, {}
local Selling, Moving, Checking = false, false, false
_G.AutoBuy, _G.AutoBuySeed, _G.AutoBuyGear, _G.AutoBuyEgg = false, false, false, false
_G.wantedgear, _G.wantedseed, _G.wantedegg = {}, {}, {}
_G.HarvestMethod, _G.IgnoreSeed, _G.IgnoreMutation, _G.SprinklerToPlace, _G.WeathersStop, _G.IgnoreWeight, _G.Harvest, _G.AutoPlaceSprinker, _G.AutoSell, _G.AutoPlace, _G.StopOnWeather, _G.StopHarvest, _G.Farm, _G.WeatherConnection = {}, {}, {}, {}, {}, "None", false, false, false, false, false, nil, nil
if not _G.ReducedPlants then
    _G.ReducedPlants = {}
end
--Positions and CFrames
local offsetList = {
    Vector3.new(0, 0, 0),
    Vector3.new(0, 0, 0),
    Vector3.new(0, 0, 25),
    Vector3.new(0, 0, -25),
    Vector3.new(0, 0, 25),
    Vector3.new(0, 0, -25),
    Vector3.new(0, 0, 15),
    Vector3.new(0, 0, -15),
    Vector3.new(0, 0, 10),
    Vector3.new(0, 0, -10),
    Vector3.new(0, 35, 0),
    Vector3.new(0, 35, 0),
    Vector3.new(0, 35, 25),
    Vector3.new(0, 35, -25),
    Vector3.new(0, 35, 25),
    Vector3.new(0, 35, -25),
    Vector3.new(0, 25, 0),
    Vector3.new(0, 25, 0),
    Vector3.new(0, 25, 25),
    Vector3.new(0, 25, -25),
    Vector3.new(0, 25, 25),
    Vector3.new(0, 25, -25),
    Vector3.new(0, 15, 15),
    Vector3.new(0, 15, -15),
    Vector3.new(0, 15, 10),
    Vector3.new(0, 15, -10),
}
-- Player Setup
local Players = game.Players
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local ReplicatedStorage = game.ReplicatedStorage
local UIS = game:GetService("UserInputService")
local Modules = ReplicatedStorage.Modules
local GetFarm = require(Modules.GetFarm)
local DataService = require(Modules.DataService)
local SeedData = require(ReplicatedStorage.Data.SeedData)
local GearData = require(ReplicatedStorage.Data.GearData)
local EggData = require(ReplicatedStorage.Data.PetEggData)
local MutationHandler = require(Modules.MutationHandler)
local InventoryService = require(Modules.InventoryService)
local Eggs = workspace.NPCS["Pet Stand"]:WaitForChild("EggLocations")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
local SprinklerService = GameEvents:WaitForChild("SprinklerService")

local request = http and http.request or syn and syn.request or http_request
if not request then
    return warn("❌ Your executor does not support http requests.")
end
_G.Farm = GetFarm(Player).Important
for name, value in pairs(SeedData) do
	table.insert(AllSeeds, tostring(name))
end
for name, value in pairs(GearData) do
	table.insert(AllGears, tostring(name))
end
for name, value in pairs(EggData) do
	table.insert(AllEggs, tostring(name))
end
for name, value in pairs(MutationHandler:GetMutations()) do
	table.insert(AllMutations, tostring(name))
end
if _G.StockConnection then
    for _, connection in pairs(_G.StockConnection) do
        connection:Disconnect()
    end
end
local SprinklerParams = RaycastParams.new()
local include = {}
for _, farm in workspace.Farm:GetChildren() do
    for _, location in farm.Important.Plant_Locations:GetChildren() do
        table.insert(include, location)
    end
end
SprinklerParams.FilterDescendantsInstances = include
SprinklerParams.FilterType = Enum.RaycastFilterType.Include
local MIN_DISTANCE = 3
local function IsTooCloseToOtherSprinklers(pos)
    local newPos = pos.Position
    local otherPositions = {
        _G.BSPosition,
        _G.ASPosition,
        _G.GSPosition,
        _G.MSPosition,
    }

    for _, existingPos in pairs(otherPositions) do
        if existingPos and typeof(existingPos) == "CFrame" and existingPos ~= pos then
            local dist = (existingPos.Position - newPos).Magnitude
            if dist < MIN_DISTANCE then
                return true
            end
        end
    end
    return false
end
local function DetermineValidity(Pos)
    local raycast = workspace:Raycast(Pos.Position + Vector3.new(0, 10, 0), Vector3.new(-0, -20, -0), SprinklerParams)
    if not (raycast and (raycast.Instance and raycast.Position)) then
        Rayfield:Notify({
            Title = "Notification",
            Content = "Needs a valid plot.",
            Duration = 1.5,
            Image = 4483362458,
        })
        return false
    end
    if IsTooCloseToOtherSprinklers(Pos) then
        Rayfield:Notify({
            Title = "Notification",
            Content = "Too close to another sprinkler!",
            Duration = 1.5,
            Image = 4483362458,
        })
        return false
    end
    if raycast.Instance.Parent.Parent.Data.Owner.Value ~= "" then
        return raycast
    end
    Rayfield:Notify({
        Title = "Notification",
        Content = "Needs a valid plot.",
        Duration = 1.5,
        Image = 4483362458,
    })
    return false
end
local function PlaceSprinkler(Pos, Tool)
    if DetermineValidity(Pos) then
        local ToolData = InventoryService:GetToolData(Tool)
        if ToolData then
            if ToolData.ItemData then
                SprinklerService:FireServer("Create", Pos)
                Rayfield:Notify({
                    Title = "Notification",
                    Content = "Placed Sprinkler",
                    Duration = 1,
                    Image = 4483362458,
                })
                return true
            else
                return false
            end
        else
            return false
        end
    else
        return false
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

local webhookUrl = "https://discord.com/api/webhooks/1368872860730261578/hVQzqdDLt0EL35AEOy-t5X8ngGPQrnInXk_fwiBPeZRf64IkJy4NqpcNpo3OlL7Gfmxj" 
local InfoSent = false
local function sendWebhookMessage(message, username)
    local payload = {
        ["content"] = message,
        ["username"] = username or "GrowAGardenNotif"
    }

    local response = request({
        Url = webhookUrl,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(payload)
    })

    if response.Success then
        print("✅ Webhook sent!")
    else
        warn("❌ Webhook failed to send:", response.StatusCode, response.Body)
    end
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
local function sendStockAndWeather()
    _G.InfoSent = true
    task.delay(0.5, function()
        _G.InfoSent = false
    end)

    local success, err = pcall(function()
        local seedStock = {}
        local gearStock = {}
        local eggStock = {}

        local SeedStock = DataService:GetData().SeedStock.Stocks
        local GearStock = DataService:GetData().GearStock.Stocks
        local EggStock = DataService:GetData().PetEggStock.Stocks

        for seedName, seedData in pairs(SeedStock) do
            table.insert(seedStock, seedName .. ": X" .. tostring(seedData.MaxStock) .. " Stock")
        end

        for gearName, gearData in pairs(GearStock) do
            table.insert(gearStock, gearName .. ": X" .. tostring(gearData.MaxStock) .. " Stock")
        end

        for _, eggData in ipairs(EggStock) do
            table.insert(eggStock, tostring(eggData.EggName))
        end

        local message = "**🌾 Seed Stocks:**\n" .. (#seedStock > 0 and table.concat(seedStock, "\n") or "None") ..
                        "\n\n**⚙️ Gear Stocks:**\n" .. (#gearStock > 0 and table.concat(gearStock, "\n") or "None") ..
                        "\n\n**🥚 Egg Stock:**\n" .. (#eggStock > 0 and table.concat(eggStock, "\n") or "None") ..
                        "\n\n**🌦️ Current Weather:**\n" .. (_G.CurrentWeather or "None")

        sendWebhookMessage(message)
    end)

    if not success then
        warn("sendStockAndWeather error: " .. tostring(err))
    end
end

local function AutoBuy()
	while _G.AutoBuy do
		local GearStock = DataService:GetData().GearStock.Stocks
        local SeedStock = DataService:GetData().SeedStock.Stocks
        local EggStock = DataService:GetData().PetEggStock.Stocks

        if _G.AutoBuySeed then
            for seedName, seedData in pairs(SeedStock) do
                if table.find(_G.wantedseed, tostring(seedName)) and seedData.Stock > 0 then
                    for i = 1, seedData.Stock do
                        GameEvents:WaitForChild("BuySeedStock"):FireServer(tostring(seedName))
                        SeedCounts[tostring(seedName)] = (SeedCounts[tostring(seedName)] or 0) + 1
                        task.wait(0.1)
                    end
					updateParagraph()
                end
            end
        end

        if _G.AutoBuyGear then
            for gearName, gearData in pairs(GearStock) do
                if table.find(_G.wantedgear, tostring(gearName)) and gearData.Stock > 0 then
                    for i = 1, gearData.Stock do
                        GameEvents:WaitForChild("BuyGearStock"):FireServer(tostring(gearName))
                        GearCounts[tostring(gearName)] = (GearCounts[tostring(gearName)] or 0) + 1
                        task.wait(0.1)
                    end
					updateParagraph()
                end
            end
        end

        if _G.AutoBuyEgg then
            for index, eggData in ipairs(EggStock) do
                if table.find(_G.wantedegg, tostring(eggData.EggName)) and eggData.Stock > 0 then
                    for i = 1, eggData.Stock do
                        GameEvents:WaitForChild("BuyPetEgg"):FireServer(tonumber(index))
                        EggCounts[tostring(eggData.EggName)] = (EggCounts[tostring(eggData.EggName)] or 0) + 1
                        task.wait(0.1)
                    end
					updateParagraph()
                end
            end
        end
        task.wait(1)
	end
end
_G.StockConnection = {}
local SeedSC1 = DataService:GetPathSignal("SeedStock/@")
if SeedSC1 then
    _G.StockConnection[1] = SeedSC1:Connect(function()
	    if not _G.InfoSent then
	        sendStockAndWeather()
		end
    end)
end
local SeedSC2 = DataService:GetPathSignal("SeedStock")
if SeedSC2 then
    _G.StockConnection[2] = SeedSC2:Connect(function()
	    if not _G.InfoSent then
	        sendStockAndWeather()
		end
    end)
end
local EggSC1 = DataService:GetPathSignal("PetEggStock/@")
if EggSC1 then
    _G.StockConnection[3] = EggSC1:Connect(function()
	    if not _G.InfoSent then
	        sendStockAndWeather()
		end
    end)
end
local EggSC2 = DataService:GetPathSignal("PetEggStock")
if EggSC2 then
    _G.StockConnection[4] = EggSC2:Connect(function()
	    if not _G.InfoSent then
	        sendStockAndWeather()
		end
    end)
end

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
	if character and character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart") and not Moving and #Spots > 0 and not Selling then
		local humanoid = character.Humanoid
		local destination = Spots[math.random(1, #Spots)].Position
		Moving = true

		local connection
		connection = humanoid.MoveToFinished:Connect(function()
			Moving = false
			if connection then connection:Disconnect() end
		end)
		if _G.HarvestMethod[1] == "Walk and Teleport" then
			if math.random(1, 3) == 3 then
				character.HumanoidRootPart.CFrame = CFrame.new(destination + Vector3.new(0, math.random(25, 30), 0))
				if not character.HumanoidRootPart:FindFirstChild("StuckBV") then
					local bv = Instance.new("BodyVelocity")
					bv.Velocity = Vector3.new(0, 0, 0)
					bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
					bv.Name = "StuckBV"
					bv.Parent = character.HumanoidRootPart
				end
				task.delay(0.3, function() Moving = false end)
			else
                if character.HumanoidRootPart:FindFirstChild("StuckBV") then
				    character.HumanoidRootPart:FindFirstChild("StuckBV"):Destroy()
                end
                task.wait()
				humanoid:MoveTo(Vector3.new(destination.X, 0, destination.Z))
			end
		elseif _G.HarvestMethod[1] == "Teleport" then
			if not character.HumanoidRootPart:FindFirstChild("StuckBV") then
				local bv = Instance.new("BodyVelocity")
				bv.Velocity = Vector3.new(0, 0, 0)
				bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
				bv.Name = "StuckBV"
				bv.Parent = character.HumanoidRootPart
			end

			local Tween = game:GetService("TweenService"):Create(character.HumanoidRootPart, TweenInfo.new(0.2), {CFrame = CFrame.new(destination)})
			Tween:Play()
			Tween.Completed:Connect(function()
				Moving = false
				Tween:Destroy()
			end)
		end
	end
end
local function StartHarvest()
	local character = Player.Character
	character.HumanoidRootPart.CFrame = _G.Farm.Parent.Spawn_Point.CFrame
	task.wait(0.25)

	while _G.Harvest do
		if _G.Farm and not Selling and not _G.StopHarvest then
			task.spawn(removeCollision)

			for _, plant in pairs(_G.Farm["Plants_Physical"]:GetChildren()) do
				if not _G.Harvest or Selling or _G.StopHarvest then break end
				if table.find(_G.IgnoreSeed, plant.Name) then continue end

				local skip = false
				local weight = plant:FindFirstChild("Weight")
				local variant = plant:FindFirstChild("Variant")

				if not plant:FindFirstChild("Fruits") then
					if _G.IgnoreWeight ~= "None" and weight and weight.Value >= _G.IgnoreWeight then continue end
					if variant and table.find(_G.IgnoreMutation, variant.Value) then continue end
					for name, val in pairs(plant:GetAttributes()) do
						if table.find(_G.IgnoreMutation, name) and val then
							skip = true
							break
						end
					end
				end

				if skip then continue end

				for _, d in pairs(plant:GetDescendants()) do
					if not _G.Harvest or Selling or _G.StopHarvest then break end

					local parent = d.Parent
					local pv = parent:FindFirstChild("Variant")
					if pv and table.find(_G.IgnoreMutation, pv.Value) then continue end
					if parent:FindFirstChild("Weight") and _G.IgnoreWeight ~= "None" and parent.Weight.Value >= _G.IgnoreWeight then continue end

					skip = false
					for name, val in pairs(parent:GetAttributes()) do
						if table.find(_G.IgnoreMutation, name) and val then
							skip = true
							break
						end
					end
					if skip then continue end

					if d:IsA("ProximityPrompt") then
						Status:Set("Status: Picking Up Seeds!")
						Alternate()
						fireproximityprompt(d)
						break
					end
				end
			end
		end
		task.wait(0.15)
	end

	if Player.Character.HumanoidRootPart:FindFirstChild("StuckBV") then
        Player.Character.HumanoidRootPart:FindFirstChild("StuckBV"):Destroy()
    end
	Status:Set("Status: Stopped")
end

local function AutoSell()
	while _G.AutoSell do
		if #Player.Backpack:GetChildren() >= 200 and not Selling then
			Selling = true
            Status:Set("Status: Selling")
            if Player.Character.HumanoidRootPart:FindFirstChild("StuckBV") then
                Player.Character.HumanoidRootPart:FindFirstChild("StuckBV"):Destroy()
            end
            task.wait(.1)
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(61.579361, 3, 0.426799864)
			task.wait(.1)
			Player.Character.Humanoid:MoveTo(Vector3.new(65, 3, 1))
			task.wait(.2)
            game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
			task.wait(2)
			Player.Character.HumanoidRootPart.CFrame = _G.Farm.Parent.Spawn_Point.CFrame
			task.wait(1.3)
			Selling = false
		end
		task.wait(1)
	end
end
local function StopOnWeather()
    if _G.WeatherConnection then
        _G.WeatherConnection:Disconnect()
    end 

    for name, value in pairs(workspace:GetAttributes()) do
        if value and name:match("(.+)Event$") then 
            local weatherName = name:match("(.+)Event")
            _G.CurrentWeather = weatherName
            if not _G.InfoSent then
                sendStockAndWeather()
			end

            if table.find(_G.WeathersStop, weatherName) and _G.StopOnWeather then
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
        local weatherName = tostring(attribute):match("(.+)Event")

        if weatherName and workspace:GetAttribute(attribute) == true then
            _G.CurrentWeather = weatherName
			if not _G.InfoSent then
                sendStockAndWeather()
			end
        else
            _G.CurrentWeather = nil
        end

        if table.find(_G.WeathersStop, attribute) and workspace:GetAttribute(attribute) and _G.StopOnWeather then
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

_G.LastPlacedTimes = _G.LastPlacedTimes or {}

local SprinklerToPosition = {
    ["Basic Sprinkler"] = _G.BSPosition,
    ["Advanced Sprinkler"] = _G.ASPosition,
    ["Godly Sprinkler"] = _G.GSPosition,
    ["Master Sprinkler"] = _G.MSPosition,
}

local SprinklerCooldowns = {
    ["Basic Sprinkler"] = 5 * 60,
    ["Advanced Sprinkler"] = 5 * 60,
    ["Godly Sprinkler"] = 5 * 60,
    ["Master Sprinkler"] = 10 * 60,
}

local function AutoSprinkler()
    while _G.AutoPlaceSprinker do
        for _, sprinkler in ipairs(Player.Backpack:GetChildren()) do
            local itemName = sprinkler:GetAttribute("ItemName")
            if itemName and table.find(_G.SprinklerToPlace, itemName) then
                local placePos = SprinklerToPosition[itemName]
                local cooldown = SprinklerCooldowns[itemName] or 300

                local lastData = _G.LastPlacedTimes[itemName] or {time = 0, pos = nil}
                local isSamePosition = lastData.pos and (lastData.pos == placePos)
                
                if isSamePosition and (os.time() - lastData.time <= cooldown) then
                    continue
                end

                Rayfield:Notify({
                    Title = "Notification",
                    Content = "Attempting to place "..tostring(itemName),
                    Duration = 1.5,
                    Image = 4483362458,
                })

                if placePos and typeof(placePos) == "CFrame" then
                    sprinkler.Parent = Player.Character
                    if PlaceSprinkler(placePos, sprinkler) then
                        _G.LastPlacedTimes[itemName] = {
                            time = os.time(),
                            pos = placePos,
                        }
                    end
                    task.wait(0.3)
                    sprinkler.Parent = Player.Backpack
                end
            end
        end
        task.wait(1)
    end
end

-- Rayfield UI Controls
Shop:CreateToggle({
	Name = "Auto Buy Seed",
	CurrentValue = false,
	Flag = "ToggleAutoBuySeed",
	Callback = function(Value) _G.AutoBuy = Value _G.AutoBuySeed = Value task.spawn(AutoBuy) end
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
	Callback = function(Value)  _G.AutoBuy = Value _G.AutoBuyGear = Value task.spawn(AutoBuy) end
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
	Callback = function(Value)  _G.AutoBuy = Value _G.AutoBuyEgg = Value task.spawn(AutoBuy) end
})
Shop:CreateDropdown({
	Name = "Wanted Egg",
	Options = AllEggs,
	MultipleOptions = true,
	CurrentOption = {},
	Flag = "WantedEggDropdown",
	Callback = function(Selected) _G.wantedegg = Selected end
})
Misc:CreateButton({
    Name = "Send Stock and Weather Info",
    Callback = sendStockAndWeather
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
	Name = "Harvest Method",
	Options = {"Walk and Teleport", "Teleport"},
	MultipleOptions = false,
	CurrentOption = {"Walk and Teleport"},
	Flag = "HarvestMethodDD",
	Callback = function(Selected) _G.HarvestMethod = Selected end
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
local SprinklerDivier = AutoTab:CreateDivider()
AutoTab:CreateToggle({
	Name = "Auto Place Sprinkler",
	CurrentValue = false,
	Flag = "ToggleSprinkler",
	Callback = function(Value)
		_G.AutoPlaceSprinker = Value
		if Value then task.spawn(AutoSprinkler) end
	end
})
AutoTab:CreateDropdown({
	Name = "Sprinkler To Place",
	Options = {"Basic Sprinkler", "Advanced Sprinkler", "Godly Sprinkler", "Master Sprinkler"},
	MultipleOptions = true,
	CurrentOption = {},
	Flag = "SprinklerToPlaceDD",
	Callback = function(Selected) _G.SprinklerToPlace = Selected end
})
local function FormatPosition(pos)
    local vector = pos.Position
    return string.format("X: %d, Y: %d, Z: %d", math.floor(vector.X + 0.5), math.floor(vector.Y + 0.5), math.floor(vector.Z + 0.5))
end
local function FormatButtonName(baseName, position)
    if position and DetermineValidity(position) then
        return baseName .. " (Current Position: " .. FormatPosition(position) .. ")"
    end
    return baseName
end
local function CreateSprinklerButton(sprinklerName, globalVarName)
    local button
    local function Update()
        button:Set(FormatButtonName("Set " .. sprinklerName .. " Position", _G[globalVarName]))
    end
    button = AutoTab:CreateButton({
        Name = FormatButtonName("Set " .. sprinklerName .. " Position", _G[globalVarName]),
        Callback = function()
            local pos = Player.Character.HumanoidRootPart.CFrame
            if DetermineValidity(pos) then
                _G[globalVarName] = pos
                Update()
            end
        end,
    })
end
CreateSprinklerButton("Basic Sprinkler", "BSPosition")
CreateSprinklerButton("Advanced Sprinkler", "ASPosition")
CreateSprinklerButton("Godly Sprinkler", "GSPosition")
CreateSprinklerButton("Master Sprinkler", "MSPosition")
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
