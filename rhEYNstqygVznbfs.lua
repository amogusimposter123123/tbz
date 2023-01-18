if not game:IsLoaded() then
    game.Loaded:Wait()
end

repeat task.wait(1) until game:IsLoaded()

local Table = {};
local TowerCounter = 0;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Workspace = game:GetService("Workspace");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

spawn(function()for v15,v16 in next,game:GetService("CoreGui"):GetChildren() do if string.find(v16.Name,"TbzAutoFarm") then v16:Destroy();break;end end end);CountTime=function()local v12=math.floor(game:GetService("Workspace").DistributedGameTime%60);local v13=math.floor((game:GetService("Workspace").DistributedGameTime/60)%60);local v14=math.floor(game:GetService("Workspace").DistributedGameTime/3600);v14=((v14<10) and ("0"   .. v14)) or v14;v12=((v12<10) and ("0"   .. v12)) or v12;v13=((v13<10) and ("0"   .. v13)) or v13;return v14   .. ":"   .. v13   .. ":"   .. v12;end;local v0=game:GetService("Players").LocalPlayer;local v1=loadstring(game:HttpGet("https://raw.githubusercontent.com/amogusimposter123123/ADsadAutoStratTestAbdaD/main/lib.lua"))();local v2=v1:CreateWindow("Auto Farm");v2:Section("Game","Game");v2:Section("Last Record:");v2:Section("","LastRecord");v2:Section("Spended Time: 00:00:00","SpendedTime");v2:Section("");v2:Section("Stats","Stats");v2:Section("Level: 0","Level");v2:Section("Tokens: 0","Tokens");v2:Section("");v2:Section("Towers","Towers");v2:Section("Slot 1: Not Founded","Slot1");v2:Section("Slot 2: Not Founded","Slot2");v2:Section("Slot 3: Not Founded","Slot3");v2:Section("Slot 4: Not Founded","Slot4");v2:Section("Slot 5: Not Founded","Slot5");v2:Section("");v2:Section("discord.gg/BvtEFn2Wjq","invite");v2:Button("Copy Invite",function()setclipboard("discord.gg/BvtEFn2Wjq");end);local v3=game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.SpendedTime.TextLabel;local v4=game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.LastRecord.TextLabel;local v5=game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Slot1.TextLabel;local v6=game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Slot2.TextLabel;local v7=game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Slot3.TextLabel;local v8=game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Slot4.TextLabel;local v9=game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Slot5.TextLabel;game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Level.TextLabel.Text="Level: "   .. v0.Level.Value;game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Tokens.TextLabel.Text="Tokens: "   .. v0.Tokens.Value;spawn(function()repeat game:GetService("RunService").Heartbeat:Wait();v3.Text="Spended Time: "   .. CountTime();v4.Text=getgenv().lc or "Nothing";if (v0.TowersChosen.Slot1.Value=="") then v5.Text="Slot1: Not Founded";else v5.Text="Slot1: "   .. v0.TowersChosen.Slot1.Value;end if (v0.TowersChosen.Slot2.Value=="") then v6.Text="Slot2: Not Founded";else v6.Text="Slot2: "   .. v0.TowersChosen.Slot2.Value;end if (v0.TowersChosen.Slot3.Value=="") then v7.Text="Slot3: Not Founded";else v7.Text="Slot3: "   .. v0.TowersChosen.Slot3.Value;end if (v0.TowersChosen.Slot4.Value=="") then v8.Text="Slot4: Not Founded";else v8.Text="Slot4: "   .. v0.TowersChosen.Slot4.Value;end if (v0.TowersChosen.Slot5.Value=="") then v9.Text="Slot5: Not Founded";else v9.Text="Slot5: "   .. v0.TowersChosen.Slot5.Value;end until  not game:GetService("CoreGui"):FindFirstChild("TbzAutoFarm") end);

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
Workspace.Game.Towers.ChildAdded:Connect(function(Tower)
        TowerCounter = TowerCounter + 1
        local NumberValue = Instance.new("NumberValue", Tower)
        NumberValue.Name = "Number"
        NumberValue.Value = TowerCounter
    end)
end

function Table:EquipLoadout(Tower1,Tower2,Tower3,Tower4,Tower5)
    if IsLobby() then
        local TowerList = {Tower1,Tower2,Tower3,Tower4,Tower5}
        for _,v in next, LocalPlayer.TowersChosen:GetChildren() do
            if v.Value ~= "" then
                ReplicatedStorage.Events.EquipTower:InvokeServer(v.Value)
            end
        end
        for i=1,5 do
            if TowerList[i] ~= "" then
                ReplicatedStorage.Events.EquipTower:InvokeServer(TowerList[i])
            end
        end
    end
end

function Table:PlaceTower(Tower,pos1,pos2,pos3,Wave,Time)
    if IsGame() then
        repeat task.wait(0.2) until Workspace.Game.GameStats.Wave.Value == Wave
        repeat task.wait(0.2) until Workspace.Game.GameStats.TimeLeft.Value == Time
        ReplicatedStorage.Events.PlaceTower:InvokeServer(Tower, Vector3.new(pos1, pos2, pos3), 0)
    end
end

function Table:SellTower(Tower,Wave,Time)
    if IsGame() then
        repeat task.wait(0.2) until Workspace.Game.GameStats.Wave.Value == Wave
        repeat task.wait(0.2) until Workspace.Game.GameStats.TimeLeft.Value == Time
        for _,v in next, Workspace.Game.Towers:GetChildren() do
            if v.Number.Value == Tower then
                ReplicatedStorage.Events.SellTower:InvokeServer(v)
                break
            end
        end
    end
end

function Table:UpgradeTower(Tower,Path,Wave,Time)
    if IsGame() then
        repeat task.wait(0.2) until Workspace.Game.GameStats.Wave.Value == Wave
        repeat task.wait(0.2) until Workspace.Game.GameStats.TimeLeft.Value == Time
        for _,v in next, Workspace.Game.Towers:GetChildren() do
            if v.Number.Value == Tower then
                ReplicatedStorage.Events.UpgradeTower:InvokeServer(v, Path)
                break
            end
        end
    end
end

function Table:CreateGame(Mode, Map, ModifiersTable)
    if IsLobby() then
        ReplicatedStorage.Events.LeaveServer:InvokeServer()
        task.wait()
        ReplicatedStorage.Events.StartServer:InvokeServer(Mode, "Invite")
        task.wait()
        ReplicatedStorage.Events.ChangeServerJoinOptions:InvokeServer(false)
        task.wait()
        ReplicatedStorage.Events.UpdateMap:InvokeServer(Map)
        if ModifiersTable then
            for _,v in next, ModifiersTable do
                ReplicatedStorage.Events.UpdateAttributes:FireServer(v)
            end
        end
        --ReplicatedStorage.Events.StartGame:InvokeServer()
    end
end

function Table:StartGame(Difficulty)
    if IsGame() then
        ReplicatedStorage.Events.VoteGamemode:InvokeServer(Difficulty)
        task.wait()
        ReplicatedStorage.Events.EndVote:FireServer()
    end
end

return Table
