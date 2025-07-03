--// Backdoor Startup Messages
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

--// Create GUI
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MoleBackdoorGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Size = UDim2.new(0, 400, 0, 280)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
Frame.BorderColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 2
Frame.Parent = ScreenGui

-- Title bar
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 36)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "Mole SS (Backdoor)"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.Parent = Frame

-- Dragging functionality
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
editor.Font = Enum.Font.SourceSans
editor.TextSize = 14
editor.TextColor3 = Color3.fromRGB(0, 0, 0)
editor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
editor.BorderColor3 = Color3.fromRGB(60, 60, 60)
editor.BorderSizePixel = 2
editor.Size = UDim2.new(1, -90, 1, -46)
editor.Position = UDim2.new(0, 8, 0, 38)
editor.TextXAlignment = Enum.TextXAlignment.Left
editor.TextYAlignment = Enum.TextYAlignment.Top
editor.Parent = Frame

-- Buttons container
local buttonsFrame = Instance.new("Frame")
buttonsFrame.Name = "ButtonsFrame"
buttonsFrame.Size = UDim2.new(0, 74, 1, -40)
buttonsFrame.Position = UDim2.new(1, -82, 0, 38)
buttonsFrame.BackgroundTransparency = 1
buttonsFrame.Parent = Frame

-- Execute Button
local executeBtn = Instance.new("TextButton")
executeBtn.Name = "ExecuteButton"
executeBtn.Size = UDim2.new(1, 0, 0, 126)
executeBtn.Position = UDim2.new(0, 0, 0, 0)
executeBtn.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
executeBtn.BorderSizePixel = 1
executeBtn.BorderColor3 = Color3.fromRGB(40, 40, 40)
executeBtn.Font = Enum.Font.FredokaOne
executeBtn.Text = "EXECUTE"
executeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
executeBtn.TextSize = 18
executeBtn.Parent = buttonsFrame

-- Clear Button
local clearBtn = Instance.new("TextButton")
clearBtn.Name = "ClearButton"
clearBtn.Size = UDim2.new(1, 0, 0, 124)
clearBtn.Position = UDim2.new(0, 0, 0, 130)
clearBtn.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
clearBtn.BorderSizePixel = 1
clearBtn.BorderColor3 = Color3.fromRGB(40, 40, 40)
clearBtn.Font = Enum.Font.FredokaOne
clearBtn.Text = "CLEAR"
clearBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
clearBtn.TextSize = 18
clearBtn.Parent = buttonsFrame

-- Backdoor Remote Execution Logic
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
