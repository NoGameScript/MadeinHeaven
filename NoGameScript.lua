
-- SERVICES
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- UI SETUP
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "NoGameUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 220, 0, 100) -- Slightly bigger
frame.Position = UDim2.new(0, 50, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 255, 255) -- Neon white border
frame.Active = true
frame.Draggable = true

-- TITLE LABEL
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "NoGame"
title.Font = Enum.Font.FredokaOne
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.TextYAlignment = Enum.TextYAlignment.Center

-- SUBTITLE LABEL
local sub = Instance.new("TextLabel", frame)
sub.Size = UDim2.new(1, -20, 0.2, 0)
sub.Position = UDim2.new(0, 10, 0.3, 0)
sub.BackgroundTransparency = 1
sub.Text = "Script by NoGrindScripts"
sub.Font = Enum.Font.Garamond
sub.TextColor3 = Color3.fromRGB(255, 255, 255)
sub.TextScaled = true
sub.TextTransparency = 0.65
sub.TextYAlignment = Enum.TextYAlignment.Center

-- BUTTON
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.8, 0, 0.3, 0)
button.Position = UDim2.new(0.1, 0, 0.65, 0)
button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextScaled = true
button.Text = "Start"
button.BorderSizePixel = 0

-- FUNCTION
local function autoClaim()
	local coordinates = {
		Vector3.new(477.5, 11.5, -425.5),
		Vector3.new(-158.3, 15.6, -640.2),
		Vector3.new(-40.0, 38.2, -6563.9),
		Vector3.new(-5491.2, 14.4, -5796.5),
		Vector3.new(-5762.2, 57.9, 5435.7),
		Vector3.new(-8434.0, 52.7, -9435.2),
		Vector3.new(-8642.1, 365.3, -9524.5),
		Vector3.new(5371.3, 221.8, -9460.1)
	}

	local function triggerProximityPrompt()
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("ProximityPrompt") and obj.Enabled and obj.MaxActivationDistance > 0 then
				local dist = (obj.Parent.Position - hrp.Position).Magnitude
				if dist <= obj.MaxActivationDistance then
					pcall(function()
						obj:InputHoldBegin()
						task.wait(0.2)
						obj:InputHoldEnd()
					end)
					break
				end
			end
		end
	end

	for _, coord in ipairs(coordinates) do
		hrp.CFrame = CFrame.new(coord)
		task.wait(0.5)
		triggerProximityPrompt()
		task.wait(1.0) -- Adjusted for 1.5s total per location
	end
end

-- BUTTON CLICK
button.MouseButton1Click:Connect(autoClaim)
