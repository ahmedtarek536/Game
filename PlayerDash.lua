local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local DASH_SPEED = 150
local DASH_DURATION = 0.1
local DASH_COOLDOWN = 0.25
local canDash = true

local function dash()
	if canDash and humanoid.Health > 0 then
		canDash = false

		local moveDirection = rootPart.CFrame.LookVector
		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.MaxForce = Vector3.new(math.huge, 0, math.huge)
		bodyVelocity.Velocity = moveDirection * DASH_SPEED
		bodyVelocity.Parent = rootPart

		wait(DASH_DURATION)
		bodyVelocity:Destroy()

		wait(DASH_COOLDOWN)
		canDash = true
	end
end

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if not gameProcessedEvent then
		if input.KeyCode == Enum.KeyCode.LeftShift then
			dash()
		end
	end
end)

player.CharacterAdded:Connect(function(newCharacter)
	character = newCharacter
	humanoid = character:WaitForChild("Humanoid")
	rootPart = character:WaitForChild("HumanoidRootPart")
	canDash = true
end)
