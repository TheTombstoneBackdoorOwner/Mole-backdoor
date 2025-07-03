local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local UI = Instance.new("ScreenGui")
UI.Name = "BackdoorUI"
UI.ResetOnSpawn = false
UI.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 480, 0, 340)
Main.Position = UDim2.new(0.5, -240, 0.5, -170)
Main.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
Main.BorderSizePixel = 0
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Parent = UI
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Mole Backdoor"
Title.Font = Enum.Font.GothamSemibold
Title.TextColor3 = Color3.fromRGB(240, 240, 240)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 40, 1, 0)
MinBtn.Position = UDim2.new(1, -90, 0, 0)
MinBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.BorderSizePixel = 0
MinBtn.Parent = TopBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 1, 0)
CloseBtn.Position = UDim2.new(1, -45, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(36, 20, 20)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(240, 100, 100)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

local Editor = Instance.new("TextBox")
Editor.Size = UDim2.new(1, -120, 1, -60)
Editor.Position = UDim2.new(0, 20, 0, 50)
Editor.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
Editor.TextColor3 = Color3.fromRGB(235, 235, 235)
Editor.Font = Enum.Font.Code
Editor.TextSize = 16
Editor.ClearTextOnFocus = false
Editor.MultiLine = true
Editor.TextXAlignment = Enum.TextXAlignment.Left
Editor.TextYAlignment = Enum.TextYAlignment.Top
Editor.PlaceholderText = "Write your script..."
Editor.TextWrapped = true
Editor.Text = ""
Editor.BorderSizePixel = 0
Editor.Parent = Main
Instance.new("UICorner", Editor).CornerRadius = UDim.new(0, 8)

local ButtonHolder = Instance.new("Frame")
ButtonHolder.Size = UDim2.new(0, 90, 1, -60)
ButtonHolder.Position = UDim2.new(1, -100, 0, 50)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = Main

local function createButton(text, yOffset)
	local Btn = Instance.new("TextButton")
	Btn.Size = UDim2.new(1, 0, 0, 44)
	Btn.Position = UDim2.new(0, 0, 0, yOffset)
	Btn.BackgroundColor3 = Color3.fromRGB(60, 130, 230)
	Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	Btn.TextSize = 16
	Btn.Font = Enum.Font.GothamBold
	Btn.Text = text
	Btn.BorderSizePixel = 0
	Btn.AutoButtonColor = false
	Btn.Parent = ButtonHolder
	Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

	Btn.MouseEnter:Connect(function()
		TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(90, 160, 255)}):Play()
	end)

	Btn.MouseLeave:Connect(function()
		TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 130, 230)}):Play()
	end)

	return Btn
end

local ExecuteBtn = createButton("EXECUTE", 0)
local ClearBtn = createButton("CLEAR", 52)

local servicesToScan = {
	game:GetService("ReplicatedStorage"),
	game:GetService("Workspace"),
	game:GetService("Lighting")
}

local function tryFireRemote(scriptText)
	for _, service in ipairs(servicesToScan) do
		for _, remote in ipairs(service:GetDescendants()) do
			if remote:IsA("RemoteEvent") then
				pcall(function()
					remote:FireServer(scriptText)
				end)
				return true
			end
		end
	end
	return false
end

local function tryLocalExecute(code)
	local f, err = loadstring(code)
	if f then
		local ok, execErr = pcall(f)
		if not ok then
			warn("Runtime Error:", execErr)
		end
	else
		warn("Loadstring failed:", err)
	end
end

ExecuteBtn.MouseButton1Click:Connect(function()
	local code = Editor.Text
	if code == "" then return end

	local sent = tryFireRemote(code)
	if not sent then
		tryLocalExecute(code)
	end
end)

ClearBtn.MouseButton1Click:Connect(function()
	Editor.Text = ""
end)

local dragging, dragStart, startPos

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

local minimized = false

local function toggleMinimize()
	minimized = not minimized
	Editor.Visible = not minimized
	ButtonHolder.Visible = not minimized
	Main.Size = minimized and UDim2.new(0, 480, 0, 60) or UDim2.new(0, 480, 0, 340)
end

MinBtn.MouseButton1Click:Connect(toggleMinimize)
CloseBtn.MouseButton1Click:Connect(function()
	UI:Destroy()
end)
