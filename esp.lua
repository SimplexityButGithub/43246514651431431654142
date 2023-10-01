local function createESP(player)
    local esp = Drawing.new("Text")
    esp.Text = player.Name
    esp.Size = 20
    esp.Color = Color3.new(1, 0, 0)
    esp.Center = true
    esp.Visible = false
    esp.Transparency = 0.7
    esp.Visible = true

    game:GetService("RunService").RenderStepped:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.Humanoid.Health > 0 then
            local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen or esp.Visible then
                esp.Position = Vector2.new(pos.X, pos.Y)
                esp.Visible = true
            else
                esp.Visible = false
            end
        else
            esp.Visible = false
        end
    end)
end

for _, player in ipairs(game.Players:GetPlayers()) do
    createESP(player)
end

game.Players.PlayerAdded:Connect(function(player)
    createESP(player)
end)

local GUI = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Switch = Instance.new("TextButton")

-- Set up the GUI
GUI.Name = "ESP GUI"
GUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Name = "MainFrame"
Frame.Parent = GUI
Frame.BackgroundColor3 = Color3.new(0, 0, 0)
Frame.BackgroundTransparency = 0.5
Frame.BorderColor3 = Color3.new(0, 0, 0)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Active = true
Frame.Draggable = true

Title.Name = "TitleLabel"
Title.Parent = Frame
Title.BackgroundColor3 = Color3.new(0, 0, 0)
Title.BackgroundTransparency = 1
Title.BorderColor3 = Color3.new(0, 0, 0)
Title.Size = UDim2.new(0, 200, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Network - ESP"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextScaled = true

Switch.Name = "SwitchButton"
Switch.Parent = Frame
Switch.BackgroundColor3 = Color3.new(0, 0, 0)
Switch.BackgroundTransparency = 0.5
Switch.BorderColor3 = Color3.new(0, 0, 0)
Switch.Position = UDim2.new(0, 10, 0, 50)
Switch.Size = UDim2.new(0, 100, 0, 70)
Switch.Font = Enum.Font.SourceSans
Switch.Text = "Utrah not entered could not turn off"
Switch.TextColor3 = Color3.new(1, 1, 1)

local ESPEnabled = false

Switch.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        Switch.Text = "ON"
        for _, player in ipairs(game.Players:GetPlayers()) do
            createESP(player)
        end
    else
        Switch.Text = "OFF"
        for _, player in ipairs(game.Players:GetPlayers()) do
            local esp = Drawing.new("Text")
            esp:Remove()
        end
    end
end)

-- Add the GUI to the player's screen
GUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
