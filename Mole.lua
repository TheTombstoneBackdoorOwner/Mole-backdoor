local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Use Hint instead of Message (Message deprecated)
local hint = Instance.new("Hint", workspace)
hint.Text = "Thanks for using Fuse SS (This is the 281st time ive done this😭🙏)"
wait(1) -- Adjust how long it stays
hint:Destroy()

-- UI Setup
local UI = Instance.new("ScreenGui")
UI.Name = "BackdoorUI"
UI.ResetOnSpawn = false
UI.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 480, 0, 380) -- taller to fit tabs + content
Main.Position = UDim2.new(0.5, -240, 0.5, -190)
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
Title.Size = UDim2.new(1, -130, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Fuse Backdoor"
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

-- Tab Buttons Holder
local TabHolder = Instance.new("Frame")
TabHolder.Size = UDim2.new(1, -20, 0, 36)
TabHolder.Position = UDim2.new(0, 10, 0, 45)
TabHolder.BackgroundTransparency = 1
TabHolder.Parent = Main

local function createTabButton(text, position)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.BorderSizePixel = 0
    btn.Parent = TabHolder
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

local EditorTabBtn = createTabButton("Editor", UDim2.new(0, 0, 0, 0))
local ScriptHubTabBtn = createTabButton("Script Hub", UDim2.new(0, 110, 0, 0))

-- Content Frames inside Main (overlapping, only one visible)
local ContentHolder = Instance.new("Frame")
ContentHolder.Size = UDim2.new(1, -20, 1, -95)
ContentHolder.Position = UDim2.new(0, 10, 0, 85)
ContentHolder.BackgroundTransparency = 1
ContentHolder.ClipsDescendants = true
ContentHolder.Parent = Main

-- Editor Content
local EditorContent = Instance.new("Frame")
EditorContent.Size = UDim2.new(1, 0, 1, 0)
EditorContent.Position = UDim2.new(0, 0, 0, 0)
EditorContent.BackgroundTransparency = 1
EditorContent.Parent = ContentHolder

local Editor = Instance.new("TextBox")
Editor.Size = UDim2.new(1, -120, 1, 0)
Editor.Position = UDim2.new(0, 0, 0, 0)
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
Editor.Parent = EditorContent
Instance.new("UICorner", Editor).CornerRadius = UDim.new(0, 8)

local ButtonHolder = Instance.new("Frame")
ButtonHolder.Size = UDim2.new(0, 90, 1, 0)
ButtonHolder.Position = UDim2.new(1, -90, 0, 0)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = EditorContent

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

-- Script Hub Content
local ScriptHubContent = Instance.new("Frame")
ScriptHubContent.Size = UDim2.new(1, 0, 1, 0)
ScriptHubContent.Position = UDim2.new(0, 0, 1, 0) -- Start off-screen (below)
ScriptHubContent.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
ScriptHubContent.BorderSizePixel = 0
ScriptHubContent.Parent = ContentHolder
Instance.new("UICorner", ScriptHubContent).CornerRadius = UDim.new(0, 10)

local HubTopBar = Instance.new("Frame")
HubTopBar.Size = UDim2.new(1, 0, 0, 30)
HubTopBar.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
HubTopBar.BorderSizePixel = 0
HubTopBar.Parent = ScriptHubContent
Instance.new("UICorner", HubTopBar).CornerRadius = UDim.new(0, 10)

local HubTitle = Instance.new("TextLabel")
HubTitle.Size = UDim2.new(1, 0, 1, 0)
HubTitle.BackgroundTransparency = 1
HubTitle.Text = "Script Hub"
HubTitle.Font = Enum.Font.GothamBold
HubTitle.TextColor3 = Color3.fromRGB(230, 230, 230)
HubTitle.TextSize = 18
HubTitle.Parent = HubTopBar

local ScriptList = Instance.new("ScrollingFrame")
ScriptList.Size = UDim2.new(1, -20, 1, -40)
ScriptList.Position = UDim2.new(0, 10, 0, 35)
ScriptList.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
ScriptList.BorderSizePixel = 0
ScriptList.CanvasSize = UDim2.new(0, 0, 5, 0)
ScriptList.ScrollBarThickness = 8
ScriptList.Parent = ScriptHubContent
Instance.new("UICorner", ScriptList).CornerRadius = UDim.new(0, 8)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScriptList

-- Define switchToTab BEFORE usage
local currentTab = "Editor"
local tweenTime = 0.3

local function switchToTab(tabName)
 if tabName == currentTab then return end

 if tabName == "Editor" then
  TweenService:Create(EditorContent, TweenInfo.new(tweenTime), {Position = UDim2.new(0, 0, 0, 0)}):Play()
  TweenService:Create(ScriptHubContent, TweenInfo.new(tweenTime), {Position = UDim2.new(0, 0, 1, 0)}):Play()

  EditorTabBtn.BackgroundColor3 = Color3.fromRGB(60, 130, 230)
  EditorTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
  ScriptHubTabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
  ScriptHubTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)

 elseif tabName == "Script Hub" then
  TweenService:Create(EditorContent, TweenInfo.new(tweenTime), {Position = UDim2.new(0, 0, -1, 0)}):Play()
  TweenService:Create(ScriptHubContent, TweenInfo.new(tweenTime), {Position = UDim2.new(0, 0, 0, 0)}):Play()

  ScriptHubTabBtn.BackgroundColor3 = Color3.fromRGB(60, 130, 230)
  ScriptHubTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
  EditorTabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
  EditorTabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
 end

 currentTab = tabName
end

-- Your existing scripts table here (ensure you fill this)
local scripts = {
  ["Troll"] = {
   ["Hint Message"] = [[
local hint = Instance.new("Hint", workspace)
hint.Text = "THIS GAME JUST GOT FUCKED BY PEPSI (DISCORD: https://discord.gg/jzYpRg3vqX)"
]],
   ["Message Popup"] = [[
local hint = Instance.new("Hint", workspace)
hint.Text = "THIS GAME JUST GOT FUCKED BY PEPSI (DISCORD: https://discord.gg/jzYpRg3vqX)"
wait(1)
hint:Destroy()
]]
  },
  ["Utility"] = {
   ["Print Hello"] = [[print("Made by Wanna Die? (Put your own print here)")]]
  },
  ["Exploit"] = {
   ["Polaria Loader"] = {
    code = [[
require(123255432303221):Pload("Yournamehere")
]],
    dangerous = true
   }
  },
  ["⚙ Settings"] = {
   ["Toggle Dark Theme"] = {
    action = function()
     local isDark = Main.BackgroundColor3 == Color3.fromRGB(22, 22, 28)
     if isDark then
      Main.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
      TopBar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
      Editor.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
      Editor.TextColor3 = Color3.fromRGB(10, 10, 10)
      ButtonHolder.BackgroundTransparency = 1
     else
      Main.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
      TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
      Editor.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
      Editor.TextColor3 = Color3.fromRGB(235, 235, 235)
     end
    end
   },
   ["Made by Wanna Die?"] = [[-- Respect the creator]]
  }
}

-- Populate ScriptList
for categoryName, categoryScripts in pairs(scripts) do
  local categoryLabel = Instance.new("TextLabel")
  categoryLabel.Size = UDim2.new(1, 0, 0, 25)
  categoryLabel.BackgroundTransparency = 1
  categoryLabel.Text = categoryName
  categoryLabel.Font = Enum.Font.GothamBold
  categoryLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
  categoryLabel.TextSize = 16
  categoryLabel.TextXAlignment = Enum.TextXAlignment.Left
  categoryLabel.Parent = ScriptList

  for name, data in pairs(categoryScripts) do
