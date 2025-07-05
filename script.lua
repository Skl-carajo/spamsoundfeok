-- Gui principal
local screen = Instance.new("ScreenGui")
screen.Name = "SoundSpamUI"
screen.ResetOnSpawn = false
screen.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame1 = Instance.new("Frame")
frame1.Name = "MainFrame"
frame1.Parent = screen
frame1.AnchorPoint = Vector2.new(0.5, 0.5)
frame1.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame1.Position = UDim2.new(0.5, 0, 0.5, 0)
frame1.Size = UDim2.new(0.3, 0, 0.4, 0)

local Text = Instance.new("TextLabel")
Text.Parent = frame1
Text.AnchorPoint = Vector2.new(0.5, 0)
Text.BackgroundTransparency = 1
Text.Position = UDim2.new(0.5, 0 , 0.02, 0)
Text.Size = UDim2.new(0.9, 0 , 0.15, 0)
Text.TextColor3 = Color3.fromRGB(255, 255, 255)
Text.Font = Enum.Font.PatrickHand
Text.TextScaled = true
Text.RichText = true
Text.Text = 'FE+ AC6 Sound Spam (<font size="5" color="rgb(255,0,0)">❌</font>)'

local ManipulateFrame = Instance.new("Frame")
ManipulateFrame.Parent = frame1
ManipulateFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ManipulateFrame.BackgroundColor3 = Color3.fromRGB(168, 168, 168)
ManipulateFrame.Position = UDim2.new(0.5, 0, 0.6, 0)
ManipulateFrame.Size = UDim2.new(0.9, 0, 0.7, 0)

local ManipulateCorner = Instance.new("UICorner")
ManipulateCorner.CornerRadius = UDim.new(0, 4)
ManipulateCorner.Parent = ManipulateFrame

local function createEntry(parent, posY, defaultText)
	local frame = Instance.new("Frame")
	frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	frame.Position = UDim2.new(0.017, 0, posY, 0)
	frame.Size = UDim2.new(0.966, 0, 0.266, 0)
	frame.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 4)
	corner.Parent = frame

	local box = Instance.new("TextBox")
	box.AnchorPoint = Vector2.new(0.5, 0.5)
	box.BackgroundTransparency = 1
	box.Position = UDim2.new(0.5, 0, 0.5, 0)
	box.Size = UDim2.new(1, 0, 0.6, 0)
	box.Font = Enum.Font.Sarpanch
	box.PlaceholderColor3 = Color3.fromRGB(240, 240, 240)
	box.PlaceholderText = "..."
	box.Text = defaultText
	box.TextColor3 = Color3.fromRGB(240, 240, 240)
	box.TextScaled = true
	box.Parent = frame

	return box
end

local IDBox = createEntry(ManipulateFrame, 0.069, "InsertID")
local PitchBox = createEntry(ManipulateFrame, 0.363, "Pitch")
local VolumeBox = createEntry(ManipulateFrame, 0.661, "Volume")

-- Drag UI
local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	frame1.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame1.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame1.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

frame1.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)


task.spawn(function()
	while true do
		task.wait(0.5)
		local setting = game:GetService("SoundService").RespectFilteringEnabled
		if setting then
			Text.Text = 'FE+ AC6 Sound Spam (<font size="5" color="rgb(255,0,0)">❌</font>)'
		else
			Text.Text = 'FE+ AC6 Sound Spam (<font size="5" color="rgb(0,255,0)">✅</font>)'
		end
	end
end)


for _, v in pairs(workspace:GetDescendants()) do
	if v:IsA("RemoteEvent") and v.Name == "AC6_FE_Sounds" then
		print("REMOTE ENCONTRADO!!!! JAJAJAJAJA")
		print("REMOTE ENCONTRADO!!!! JAJAJAJAJA")
		print("REMOTE ENCONTRADO!!!! JAJAJAJAJA")
		print("REMOTE ENCONTRADO!!!! JAJAJAJAJA")
		print("REMOTE ENCONTRADO!!!! JAJAJAJAJA")
		print("REMOTE ENCONTRADO!!!! JAJAJAJAJA")
		print("REMOTE ENCONTRADO!!!! JAJAJAJAJA")
	end
end

local sound = true
local Name = "gayporn"

IDBox:GetPropertyChangedSignal("Text"):Connect(function()
	local soundid = IDBox.Text
	local volume = VolumeBox.Text
	local pitch = PitchBox.Text
	local ID = "rbxassetid://"..soundid

	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("RemoteEvent") and v.Name == "AC6_FE_Sounds" then
			if sound then
				v:FireServer("newSound", Name, workspace, ID, pitch, volume, true)
				v:FireServer("playSound", Name)
			else
				v:FireServer("stopSound", Name)
			end
		end
	end
end)
