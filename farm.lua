local clickedPlayersRanked = {}
local clickedPlayersSolo = {}
local dropdownOpen = false

local function createScreenGui(player)
    local screengui = Instance.new("ScreenGui")
    screengui.Parent = player.PlayerGui
    screengui.IgnoreGuiInset = true

    local frame = Instance.new("Frame")
    frame.Parent = screengui
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    
    local queuesButton = Instance.new("TextButton")
    queuesButton.Parent = frame
    queuesButton.Size = UDim2.new(0, 200, 0, 50)
    queuesButton.Position = UDim2.new(0.5, -100, 0.5, -150)
    queuesButton.Text = "Queues"
    queuesButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    queuesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    local queuesUICorner = Instance.new("UICorner")
    queuesUICorner.Parent = queuesButton

    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Parent = frame
    dropdownFrame.Size = UDim2.new(0, 200, 0, 110)
    dropdownFrame.Position = UDim2.new(0.5, -100, 0.5, -85)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    dropdownFrame.Visible = false
    local dropdownUICorner = Instance.new("UICorner")
    dropdownUICorner.Parent = dropdownFrame

    local rankedButton = Instance.new("TextButton")
    rankedButton.Parent = dropdownFrame
    rankedButton.Size = UDim2.new(1, -20, 0, 40)
    rankedButton.Position = UDim2.new(0, 10, 0, 10)
    rankedButton.Text = "Ranked"
    rankedButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    rankedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    local rankedUICorner = Instance.new("UICorner")
    rankedUICorner.Parent = rankedButton

    local soloButton = Instance.new("TextButton")
    soloButton.Parent = dropdownFrame
    soloButton.Size = UDim2.new(1, -20, 0, 40)
    soloButton.Position = UDim2.new(0, 10, 0, 60)
    soloButton.Text = "Solo"
    soloButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    soloButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    local soloUICorner = Instance.new("UICorner")
    soloUICorner.Parent = soloButton

    queuesButton.MouseButton1Click:Connect(function()
        dropdownOpen = not dropdownOpen
        dropdownFrame.Visible = dropdownOpen
    end)

    local queueButtonRanked = Instance.new("TextButton")
    queueButtonRanked.Parent = frame
    queueButtonRanked.Size = UDim2.new(0, 200, 0, 50)
    queueButtonRanked.Position = UDim2.new(0.5, -100, 0.5, 50)
    queueButtonRanked.Text = "Queue for ranked farm (0/2)"
    queueButtonRanked.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    queueButtonRanked.TextColor3 = Color3.fromRGB(0, 0, 0)
    queueButtonRanked.Visible = true
    local rankedUICornerButton = Instance.new("UICorner")
    rankedUICornerButton.Parent = queueButtonRanked

    local queueButtonSolo = Instance.new("TextButton")
    queueButtonSolo.Parent = frame
    queueButtonSolo.Size = UDim2.new(0, 200, 0, 50)
    queueButtonSolo.Position = UDim2.new(0.5, -100, 0.5, 110)
    queueButtonSolo.Text = "Queue for solo farm (0/2)"
    queueButtonSolo.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    queueButtonSolo.TextColor3 = Color3.fromRGB(0, 0, 0)
    queueButtonSolo.Visible = false
    local soloUICornerButton = Instance.new("UICorner")
    soloUICornerButton.Parent = queueButtonSolo

    local function updateButtonText()
        while true do
            queueButtonRanked.Text = "Queue for ranked farm (" .. #clickedPlayersRanked .. "/2)"
            queueButtonSolo.Text = "Queue for solo farm (" .. #clickedPlayersSolo .. "/2)"
            wait(1)
        end
    end
    coroutine.wrap(updateButtonText)()

    rankedButton.MouseButton1Click:Connect(function()
        queueButtonRanked.Visible = true
        queueButtonSolo.Visible = false
    end)

    soloButton.MouseButton1Click:Connect(function()
        queueButtonRanked.Visible = false
        queueButtonSolo.Visible = true
    end)

    queueButtonRanked.MouseButton1Click:Connect(function()
        if not table.find(clickedPlayersRanked, player) then
            table.insert(clickedPlayersRanked, player)
        end

        if #clickedPlayersRanked == 2 then
            local playersToTeleport = clickedPlayersRanked
            clickedPlayersRanked = {}
            for _, v in pairs(playersToTeleport) do
                game:GetService("TeleportService"):Teleport(18836990947, v)
            end
        end
    end)

    queueButtonSolo.MouseButton1Click:Connect(function()
        if not table.find(clickedPlayersSolo, player) then
            table.insert(clickedPlayersSolo, player)
        end

        if #clickedPlayersSolo == 2 then
            local playersToTeleport = clickedPlayersSolo
            clickedPlayersSolo = {}

            local soloPlaceID = 71264075259626
            for _, v in pairs(playersToTeleport) do
                game:GetService("TeleportService"):Teleport(soloPlaceID, v)
            end
        end
    end)
end

for _, player in ipairs(game.Players:GetPlayers()) do
    createScreenGui(player)
end

game.Players.PlayerAdded:Connect(createScreenGui)
