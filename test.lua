getgenv().Rdy = false;
local Table = {};
local TowerCounter = 0;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Workspace = game:GetService("Workspace");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

if not game:IsLoaded() then
    game.Loaded:Wait()
else
    getgenv().Rdy = true
    print('ready')
end

repeat task.wait() until getgenv().Rdy

function IsLobby()
    if game.PlaceId == 4739557376 then
        return true
    else
        return false
    end
end

function IsGame()
    if game.PlaceId == 5527929546 then
        return true
    else
        return false
    end
end

if IsGame() then
    spawn(function()
        while task.wait() do
            if Workspace.Game.GameFinished.FinishedTime.Value > 0 then
                game.TeleportService:Teleport(4739557376)
            end
        end
    end)
end

if syn then
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
        if State == Enum.TeleportState.Started then
            syn.queue_on_teleport([[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/amogusimposter123123/tbz/main/test.lua"))()
            ]])
        end
    end)
end

Workspace.Game.Towers.ChildAdded:Connect(function(Tower)
    if IsGame() then
        TowerCounter = TowerCounter + 1
        local NumberValue = Instance.new("NumberValue", Tower)
        NumberValue.Name = "Number"
        NumberValue.Value = TowerCounter
    end
end)

function Table:EquipTower(Tower)
    if IsLobby() then
        local TowersEquipped = {}
        for i, v in next, LocalPlayer.TowersChosen:GetChildren() do
            table.insert(TowersEquipped, v.Value) 
        end
        if table.find(TowersEquipped, Tower) then
            warn("Tower is equipped, can not equip.")
        else
            ReplicatedStorage.Events.EquipTower:InvokeServer(Tower)
        end       
    end
end

function Table:UnequipTower(Tower)
    if IsLobby() then
        local TowersEquipped = {}
        for i, v in next, LocalPlayer.TowersChosen:GetChildren() do 
            table.insert(TowersEquipped, v.Value) 
        end
        if table.find(TowersEquipped, Tower) then
            ReplicatedStorage.Events.EquipTower:InvokeServer(Tower)
        else
            warn("Tower is not equipped, can not unequip.")
        end       
    end
end

function Table:UnequipAllTowers()
    if IsLobby() then
        for i, v in next, LocalPlayer.TowersChosen:GetChildren() do 
            if v.Value ~= "" then
                ReplicatedStorage.Events.EquipTower:InvokeServer(v.Value)
            end
        end       
    end
end

function Table:PlaceTower(Tower,pos1,pos2,pos3,Wave,Time)
    if IsGame() then
        repeat task.wait() until Workspace.Game.GameStats.Wave.Value == Wave
        repeat task.wait() until Workspace.Game.GameStats.TimeLeft.Value == Time
        ReplicatedStorage.Events.PlaceTower:InvokeServer(Tower, Vector3.new(pos1, pos2, pos3), 0)
    end
end

function Table:SellTower(Tower,Wave,Time)
    if IsGame() then
        repeat task.wait() until Workspace.Game.GameStats.Wave.Value == Wave
        repeat task.wait() until Workspace.Game.GameStats.TimeLeft.Value == Time
        for i,v in next, Workspace.Game.Towers:GetChildren() do
            if v.Number.Value == Tower then
                ReplicatedStorage.Events.SellTower:InvokeServer(v)
                break
            end
        end
    end
end

function Table:UpgradeTower(Tower,Path,Wave,Time)
    if IsGame() then
        repeat task.wait() until Workspace.Game.GameStats.Wave.Value == Wave
        repeat task.wait() until Workspace.Game.GameStats.TimeLeft.Value == Time
        for i,v in next, Workspace.Game.Towers:GetChildren() do
            if v.Number.Value == Tower then
                ReplicatedStorage.Events.UpgradeTower:InvokeServer(v, Path)
                break
            end
        end
    end
end

function Table:CreateServer(Mode, WhoJoin)
    if IsLobby() then
        ReplicatedStorage.Events.LeaveServer:InvokeServer()
        task.wait()
        ReplicatedStorage.Events.StartServer:InvokeServer(Mode, WhoJoin)        
    end
end

function Table:SelectMap(Map)
    if IsLobby() then
        ReplicatedStorage.Events.UpdateMap:InvokeServer(Map)   
    end
end

function Table:StartGame()
    if IsLobby() then
        ReplicatedStorage.Events.StartGame:InvokeServer()        
    end
end

function Table:SelectModify(Modify)
    if IsLobby() then
        ReplicatedStorage.Events.UpdateAttributes:FireServer(Modify)      
    end
end
