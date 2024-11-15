local clickedRanked, clickedSolo = {}, {}

local function createScreenGui(p)
    local sg, f = Instance.new("ScreenGui", p.PlayerGui), Instance.new("Frame", sg)
    sg.IgnoreGuiInset, f.Size, f.BackgroundColor3 = true, UDim2.new(1, 0, 1, 0), Color3.fromRGB(0, 255, 0)

    local tutorialText = Instance.new("TextLabel", f)
    tutorialText.Size, tutorialText.Position, tutorialText.Text, tutorialText.BackgroundTransparency, tutorialText.TextColor3 = UDim2.new(0, 400, 0, 100), UDim2.new(0.5, -200, 0, 20), "Tutorial: 1. Get 2 accounts, after you get 2 accounts, join this game with both accounts, after u joined with both accounts, select the same queue on both accounts, after that, press queue button and wait till u get teleported to a place.", 1, Color3.fromRGB(150, 150, 150)

    local queuesButton, dropdownFrame = Instance.new("TextButton", f), Instance.new("Frame", f)
    queuesButton.Size, queuesButton.Position, queuesButton.Text, queuesButton.BackgroundColor3 = UDim2.new(0, 200, 0, 50), UDim2.new(0.5, -100, 0.5, -150), "Queues", Color3.fromRGB(150, 150, 150)
    dropdownFrame.Size, dropdownFrame.Position, dropdownFrame.BackgroundColor3, dropdownFrame.Visible = UDim2.new(0, 200, 0, 110), UDim2.new(0.5, -100, 0.5, -85), Color3.fromRGB(80, 80, 80), false

    local rankedButton, soloButton = Instance.new("TextButton", dropdownFrame), Instance.new("TextButton", dropdownFrame)
    rankedButton.Size, rankedButton.Position, rankedButton.Text, rankedButton.BackgroundColor3 = UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 10), "Ranked", Color3.fromRGB(100, 100, 100)
    soloButton.Size, soloButton.Position, soloButton.Text, soloButton.BackgroundColor3 = UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 60), "Solo", Color3.fromRGB(100, 100, 100)

    local queueButtonRanked, queueButtonSolo = Instance.new("TextButton", f), Instance.new("TextButton", f)
    queueButtonRanked.Size, queueButtonRanked.Position, queueButtonRanked.Text, queueButtonRanked.BackgroundColor3, queueButtonRanked.Visible = UDim2.new(0, 200, 0, 50), UDim2.new(0.5, -100, 0.5, 50), "Queue for ranked farm (0/2)", Color3.fromRGB(255, 255, 0), false
    queueButtonSolo.Size, queueButtonSolo.Position, queueButtonSolo.Text, queueButtonSolo.BackgroundColor3, queueButtonSolo.Visible = UDim2.new(0, 200, 0, 50), UDim2.new(0.5, -100, 0.5, 110), "Queue for solo farm (0/2)", Color3.fromRGB(255, 255, 0), false

    local leaveQueueButton = Instance.new("TextButton", f)
    leaveQueueButton.Size, leaveQueueButton.Position, leaveQueueButton.Text, leaveQueueButton.BackgroundColor3, leaveQueueButton.Visible = UDim2.new(0, 200, 0, 50), UDim2.new(0.5, -100, 0.5, 170), "Leave Queue", Color3.fromRGB(255, 0, 0), false

    local function updateQueueButtonText()
        queueButtonRanked.Text = "Queue for ranked farm ("..#clickedRanked.."/2)"
        queueButtonSolo.Text = "Queue for solo farm ("..#clickedSolo.."/2)"
    end

    queuesButton.MouseButton1Click:Connect(function() dropdownFrame.Visible = not dropdownFrame.Visible end)
    rankedButton.MouseButton1Click:Connect(function() queueButtonRanked.Visible, queueButtonSolo.Visible = true, false end)
    soloButton.MouseButton1Click:Connect(function() queueButtonRanked.Visible, queueButtonSolo.Visible = false, true end)

    coroutine.wrap(function()
        while true do
            updateQueueButtonText()
            wait(1)
        end
    end)()

    local function joinQueue(queue, player, placeId)
        if not table.find(queue, player) and #queue < 2 then table.insert(queue, player) end
        if #queue == 2 then
            local playerList = queue
            queue = {}
            for _, v in ipairs(playerList) do game:GetService("TeleportService"):Teleport(placeId, v) end
        end
    end

    queueButtonRanked.MouseButton1Click:Connect(function()
        if #clickedRanked < 2 and not table.find(clickedRanked, p) and #clickedSolo == 0 then
            table.insert(clickedRanked, p)
            queueButtonRanked.Visible = false
            leaveQueueButton.Visible = true
        end
    end)

    queueButtonSolo.MouseButton1Click:Connect(function()
        if #clickedSolo < 2 and not table.find(clickedSolo, p) and #clickedRanked == 0 then
            table.insert(clickedSolo, p)
            queueButtonSolo.Visible = false
            leaveQueueButton.Visible = true
        end
    end)

    leaveQueueButton.MouseButton1Click:Connect(function()
        if table.find(clickedRanked, p) then
            table.remove(clickedRanked, table.find(clickedRanked, p))
            queueButtonRanked.Visible = true
        elseif table.find(clickedSolo, p) then
            table.remove(clickedSolo, table.find(clickedSolo, p))
            queueButtonSolo.Visible = true
        end
        leaveQueueButton.Visible = false
    end)

    local function addUICorner(obj)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = obj
    end

    addUICorner(queuesButton)
    addUICorner(dropdownFrame)
    addUICorner(rankedButton)
    addUICorner(soloButton)
    addUICorner(queueButtonRanked)
    addUICorner(queueButtonSolo)
    addUICorner(leaveQueueButton)
end

for _, p in ipairs(game.Players:GetPlayers()) do createScreenGui(p) end
game.Players.PlayerAdded:Connect(createScreenGui)
