-- Backdoor Startup Messages (unchanged)
local function showMessage(text, duration)
    local message = Instance.new("Message", workspace)
    message.Text = text
    task.wait(duration)
    message:Destroy()
end

task.spawn(function()
    showMessage("Backdoor made by wanna die? credited by pepsi hub owner: Ghostin138", 3)
    showMessage("Thanks for using Mole Backdoor ;)", 3)
    showMessage("Pepsi Hub: https://discord.gg/WWw7U83mpJ", 5)
end)

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MoleBackdoorGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main Frame (with rounded corners & subtle shadow)
local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Size = UDim2.new(0, 420, 0, 320)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217" -- subtle shadow png
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Position = UDim2.new(0, -10, 0, -10)
Shadow.ZIndex = 0
Shadow.Parent = Frame

-- Title Bar
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 44)
Title.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Title.TextColor3 = Color3.fromRGB(230, 230, 230)
Title.Text = "Mole SS (Backdoor)"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.Parent = Frame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Dragging functionality (unchanged)
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Script Editor TextBox
local editor = Instance.new("TextBox")
editor.Name = "ScriptEditor"
editor.MultiLine = true
editor.ClearTextOnFocus = false
editor.TextWrapped = true
editor.Font = Enum.Font.Code
editor.TextSize = 16
editor.TextColor3 = Color3.fromRGB(220, 220, 220)
editor.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
editor.BorderSizePixel = 0
editor.Size = UDim2.new(1, -100, 1, -60)
editor.Position = UDim2.new(0, 12, 0, 52)
editor.TextXAlignment = Enum.TextXAlignment.Left
editor.TextYAlignment = Enum.TextYAlignment.Top
editor.PlaceholderText = "Enter your script here..."
editor.Parent = Frame

local editorCorner = Instance.new("UICorner")
editorCorner.CornerRadius = UDim.new(0, 8)
editorCorner.Parent = editor

-- Buttons container
local buttonsFrame = Instance.new("Frame")
buttonsFrame.Name = "ButtonsFrame"
buttonsFrame.Size = UDim2.new(0, 80, 1, -60)
buttonsFrame.Position = UDim2.new(1, -90, 0, 52)
buttonsFrame.BackgroundTransparency = 1
buttonsFrame.Parent = Frame

-- Common button style function
local function createButton(text, positionY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.Position = UDim2.new(0, 0, 0, positionY)
    btn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(245, 245, 245)
    btn.TextSize = 18
    btn.Parent = buttonsFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn

    -- Hover effect
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(100, 160, 210)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(70, 130, 180)}):Play()
    end)

    return btn
end

-- Execute Button
local executeBtn = createButton("EXECUTE", 0)

-- Clear Button
local clearBtn = createButton("CLEAR", 60)

-- Backdoor Remote Execution Logic (unchanged)
local servicesToScan = {
    game:GetService("ReplicatedStorage"),
    game:GetService("Lighting"),
    game:GetService("Workspace"),
}

local function fireRemote(remote, scriptText)
    if remote:IsA("RemoteEvent") then
        print("Firing remote:", remote.Name)
        remote:FireServer(scriptText)
        return true
    end
    return false
end

local function findAndFireBackdoor(scriptText)
    for _, service in ipairs(servicesToScan) do
        for _, descendant in ipairs(service:GetDescendants()) do
            if descendant:IsA("RemoteEvent") then
                local success = fireRemote(descendant, scriptText)
                if success then
                    return true
                end
            end
        end
    end
    return false
end

-- Execute Button Behavior
executeBtn.MouseButton1Click:Connect(function()
    local scriptText = editor.Text
    if scriptText == "" then
        warn("Script editor is empty.")
        return
    end

    local success = findAndFireBackdoor(scriptText)
    if success then
        warn("Backdoor remote fired successfully!")
    else
        warn("No backdoor remote found.")
    end
end)

-- Clear Button Behavior
clearBtn.MouseButton1Click:Connect(function()
    editor.Text = ""
end)
