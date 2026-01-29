-- Gui principal
local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
local length = math.random(1,10)
local result = ""

for i = 1, length do
	result ..= chars:sub(math.random(#chars), math.random(#chars))
end


local screen = Instance.new("ScreenGui")
screen.Name = result
screen.ResetOnSpawn = false
screen.Parent = game.CoreGui

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

local Manipulate1Frame = Instance.new("Frame")
Manipulate1Frame.Parent = frame1
Manipulate1Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Manipulate1Frame.BackgroundColor3 = Color3.fromRGB(168, 168, 168)
Manipulate1Frame.Position = UDim2.new(0.262, 0, 0.564, 0)
Manipulate1Frame.Size = UDim2.new(0.423, 0, 0.707, 0)

local Manipulate1Corner = Instance.new("UICorner")
Manipulate1Corner.CornerRadius = UDim.new(0, 4)
Manipulate1Corner.Parent = Manipulate1Frame

local IDBox1 = createEntry(Manipulate1Frame, 0.069, "InsertID")
local PitchBox = createEntry(Manipulate1Frame, 0.363, "Pitch")
local VolumeBox = createEntry(Manipulate1Frame, 0.661, "Volume")

--- Music_FE

local Manipulate2Frame = Instance.new("Frame")
Manipulate2Frame.Parent = frame1
Manipulate2Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Manipulate2Frame.BackgroundColor3 = Color3.fromRGB(168, 168, 168)
Manipulate2Frame.Position = UDim2.new(0.738, 0, 0.564, 0)
Manipulate2Frame.Size = UDim2.new(0.423, 0, 0.707, 0)

local Manipulate2Corner = Instance.new("UICorner")
Manipulate2Corner.CornerRadius = UDim.new(0, 4)
Manipulate2Corner.Parent = Manipulate2Frame

local IDBox2 = createEntry(Manipulate2Frame, 0.069, "InsertID")
local TimeBox = createEntry(Manipulate2Frame, 0.363, "Time")
local Gain = createEntry(Manipulate2Frame, 0.661, "Gain")

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




---- ac6 lol

for _, v in pairs(workspace:GetDescendants()) do
	if v:IsA("RemoteEvent") and v.Name == "AC6_FE_Sounds" then
		print("REMOTE ENCONTRADO : " .. v.Name)

	end
end

local sound = true
local Name = "gayporn"

IDBox1:GetPropertyChangedSignal("Text"):Connect(function()
	local soundid = IDBox1.Text
	if not tonumber(soundid) then return end
	local volume = VolumeBox.Text
	if not tonumber(volume) then return end
	local pitch = PitchBox.Text
	if not tonumber(pitch) then return end
	local ID = "rbxassetid://"..tonumber(soundid)

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


----- music fe chipeo lol (quema wawas)

for _, v in pairs(workspace:GetDescendants()) do
	if v:IsA("RemoteEvent") and v.Name == "Music_FE" then
		print("REMOTE ENCONTRADO : " .. v.Name)

	end
end

IDBox2:GetPropertyChangedSignal("Text"):Connect(function()
	while true do
		wait(TimeBox.Text)
		for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
			if v:IsA("RemoteEvent") and v.Name == "Music_FE" then
				if sound == true then
					v:FireServer("Song", "agr", IDBox2.Text)
					v:FireServer("Volume", "agr", 10)
					
					v:FireServer("EQ1", "agr", "LowGain", Gain.Text)
					v:FireServer("EQ1", "agr", "MidGain", Gain.Text)
					v:FireServer("EQ1", "agr", "HighGain", Gain.Text)
					
					v:FireServer("EQ2", "agr", "LowGain", Gain.Text)
					v:FireServer("EQ2", "agr", "MidGain", Gain.Text)
					v:FireServer("EQ2", "agr", "HighGain", Gain.Text)
					
					v:FireServer("EQ3", "agr", "LowGain", Gain.Text)
					v:FireServer("EQ3", "agr", "MidGain", Gain.Text)
					v:FireServer("EQ3", "agr", "HighGain", Gain.Text)
					
					v:FireServer("EQ4", "agr", "LowGain", Gain.Text)
					v:FireServer("EQ4", "agr", "MidGain", Gain.Text)
					v:FireServer("EQ4", "agr", "HighGain", Gain.Text)
				elseif sound == false then
					v:FireServer("Song", "agr", 0)
					v:FireServer("Volume", "agr", 0)
				end
			end	
		end
	end
end)
