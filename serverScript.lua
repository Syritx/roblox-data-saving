local dataStore = game:GetService("DataStoreService")
local store = data:GetDataStore("ADataStore")

function OnPlayerJoined(player)

    -- creating the leaderboard
    local leaderboard = Instance.new("Folder",player)
    leaderboard.Name = "leaderstats" -- important
    
    local money = Instance.new("IntValue",leaderboard)
    money.Name = "Money"
    
    local loadedDat = nil
    local playerKey = player.UserId.."money"
    
    local isSuccess, err = pcall(function()
        loadedDat = store:GetAsync(playerKey)
    end)
    
    if (isSuccess) then
        money.Value = loadedDat
    else    
       -- sets a default amount of money
       money.Value = 100
       warn(err)
    end
end -- void OnPlayerJoined

function OnPlayerLeft(player)

    local playerKey = player.UserId.."money"
    local isSuccess, err = pcall(function()
        store:SetAsync(playerKey,player.leaderstats.Money.Value)
    end)
    
    if (not isSuccess) then
       warn(err)
    end
end -- void OnPlayerLeft

game.Players.PlayerAdded:Connect(OnPlayerJoined)
game.Players.PlayerRemoving:Connect(OnPlayerLeft)
