--[[
	.____    _____.___._______  ____  ___   _________       _____  __                       __                 .____    .____   _________  
	|    |   \__  |   |\      \ \   \/  /  /   _____/ _____/ ____\/  |___  _  _____________|  | __  ______     |    |   |    |  \_   ___ \ 
	|    |    /   |   |/   |   \ \     /   \_____  \ /  _ \   __\\   __\ \/ \/ /  _ \_  __ \  |/ / /  ___/     |    |   |    |  /    \  \/
	|    |___ \____   /    |    \/     \   /        (  <_> )  |   |  |  \     (  <_> )  | \/    <  \___ \      |    |___|    |__\     \____
	|_______ \/ ______\____|__  /___/\  \ /_______  /\____/|__|   |__|   \/\_/ \____/|__|  |__|_ \/____  > /\  |_______ \_______ \______  /
        	\/\/              \/      \_/         \/                                            \/     \/  )/          \/       \/      \/ 
	Last Updated: 03/21/2026 at 21:01 MDT
	Updated by: kaosu

	Script protected by wearedevs.net Lua Obfuscater v1.0.0

]]

--// SETTINGS
local GAME_NAME = "free chat!"
local LOGO_IMAGE = "rbxassetid://75538670845842"
local REQUIRED_KEY = "1234"

--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--// GUI SETUP
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingScreen"
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local background = Instance.new("Frame")
background.Size = UDim2.new(1,0,1,0)
background.BackgroundColor3 = Color3.fromRGB(10,10,12)
background.Parent = screenGui

-- MAIN CONTAINER (modern panel)
local container = Instance.new("Frame")
container.Size = UDim2.new(0.35,0,0.5,0)
container.Position = UDim2.new(0.5,0,0.5,0)
container.AnchorPoint = Vector2.new(0.5,0.5)
container.BackgroundColor3 = Color3.fromRGB(20,20,25)
container.Parent = background

Instance.new("UICorner", container).CornerRadius = UDim.new(0,16)

--// LOGO
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0,120,0,120)
logo.Position = UDim2.new(0.5,-60,0.1,0)
logo.BackgroundTransparency = 1
logo.Image = LOGO_IMAGE
logo.ImageTransparency = 1
logo.Parent = container

--// TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0.4,0)
title.BackgroundTransparency = 1
title.Text = GAME_NAME
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.TextTransparency = 1
title.Parent = container

--// LOADING BAR BG
local barBG = Instance.new("Frame")
barBG.Size = UDim2.new(0.8,0,0,14)
barBG.Position = UDim2.new(0.1,0,0.6,0)
barBG.BackgroundColor3 = Color3.fromRGB(40,40,45)
barBG.Parent = container
Instance.new("UICorner", barBG).CornerRadius = UDim.new(1,0)

--// LOADING BAR
local bar = Instance.new("Frame")
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(0,170,255)
bar.Parent = barBG
Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)

--// KEY FRAME
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0.8,0,0.3,0)
keyFrame.Position = UDim2.new(0.1,0,0.65,0)
keyFrame.BackgroundTransparency = 1
keyFrame.Visible = false
keyFrame.Parent = container

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1,0,0.4,0)
keyBox.PlaceholderText = "Enter Key..."
keyBox.Text = ""
keyBox.TextScaled = true
keyBox.Font = Enum.Font.Gotham
keyBox.BackgroundColor3 = Color3.fromRGB(30,30,35)
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.Parent = keyFrame
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0,10)

local submit = Instance.new("TextButton")
submit.Size = UDim2.new(1,0,0.4,0)
submit.Position = UDim2.new(0,0,0.55,0)
submit.Text = "Submit"
submit.TextScaled = true
submit.Font = Enum.Font.GothamBold
submit.BackgroundColor3 = Color3.fromRGB(0,170,255)
submit.TextColor3 = Color3.new(1,1,1)
submit.Parent = keyFrame
Instance.new("UICorner", submit).CornerRadius = UDim.new(0,10)

--// PLAY BUTTON
local playButton = Instance.new("TextButton")
playButton.Size = UDim2.new(0.8,0,0.2,0)
playButton.Position = UDim2.new(0.1,0,0.65,0)
playButton.Text = "PLAY"
playButton.TextScaled = true
playButton.Font = Enum.Font.GothamBold
playButton.BackgroundColor3 = Color3.fromRGB(0,200,120)
playButton.TextColor3 = Color3.new(1,1,1)
playButton.Visible = false
playButton.Parent = container
Instance.new("UICorner", playButton).CornerRadius = UDim.new(0,12)

--// TWEEN FUNCTION
local function tween(obj, props, time)
	local t = TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
	t:Play()
	return t
end

-- Fade in
tween(logo, {ImageTransparency = 0}, 0.8)
tween(title, {TextTransparency = 0}, 0.8)

--// LOADING
local assets = game:GetDescendants()
local total = #assets
local loaded = 0

for _, asset in ipairs(assets) do
	ContentProvider:PreloadAsync({asset})
	loaded += 1

	local progress = loaded / total
	tween(bar, {Size = UDim2.new(progress,0,1,0)}, 0.08)
end

tween(bar, {Size = UDim2.new(1,0,1,0)}, 0.3)
task.wait(0.4)

-- Hide loading bar, show key system
tween(barBG, {BackgroundTransparency = 1}, 0.3)
tween(bar, {BackgroundTransparency = 1}, 0.3)

task.wait(0.3)
keyFrame.Visible = true

-- Button hover
local function hover(btn, sizeUp)
	btn.MouseEnter:Connect(function()
		tween(btn, {Size = sizeUp}, 0.15)
	end)
	btn.MouseLeave:Connect(function()
		tween(btn, {Size = btn.Size}, 0.15)
	end)
end

hover(submit, UDim2.new(1.05,0,0.42,0))
hover(playButton, UDim2.new(0.85,0,0.22,0))

-- Key check
submit.MouseButton1Click:Connect(function()
	if keyBox.Text == REQUIRED_KEY then
		keyFrame.Visible = false
		playButton.Visible = true
		playButton.TextTransparency = 1
		tween(playButton, {TextTransparency = 0}, 0.3)
	else
		keyBox.Text = ""
		keyBox.PlaceholderText = "Wrong Key"
	end
end)

-- Play click
playButton.MouseButton1Click:Connect(function()
	tween(container, {BackgroundTransparency = 1}, 0.5)
	tween(logo, {ImageTransparency = 1}, 0.5)
	tween(title, {TextTransparency = 1}, 0.5)

	task.wait(0.5)
	screenGui:Destroy()
end)
