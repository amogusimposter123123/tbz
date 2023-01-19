--MS_WATERMARK("hi")
if not game:IsLoaded() then
    game.Loaded:Wait()
end

repeat task.wait(1) until game:IsLoaded()

local Table = {};
local TowerCounter = 0;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Workspace = game:GetService("Workspace");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

spawn(function()for v16,v17 in next,game:GetService("CoreGui"):GetChildren() do if string.find(v17.Name,"TbzAutoFarm") then v17:Destroy();break;end end end);CountTime=function()local v13=math.floor(game:GetService("Workspace").DistributedGameTime%60);local v14=math.floor((game:GetService("Workspace").DistributedGameTime/60)%60);local v15=math.floor(game:GetService("Workspace").DistributedGameTime/3600);v15=((v15<10) and ("0"   .. v15)) or v15;v13=((v13<10) and ("0"   .. v13)) or v13;v14=((v14<10) and ("0"   .. v14)) or v14;return v15   .. ":"   .. v14   .. ":"   .. v13;end;local v0=game:GetService("Players").LocalPlayer;task.wait(1);local v1=loadstring(game:HttpGet("https://raw.githubusercontent.com/amogusimposter123123/ADsadAutoStratTestAbdaD/main/lib.lua"))();local v2=v1:CreateWindow("Auto Farm");v2:Section("Game","Game");v2:Section("Spended Time: 00:00:00","SpendedTime");v2:Section("");v2:Section("Stats","Stats");v2:Section("Level: 0","Level");v2:Section("Experience: 0","Experience");v2:Section("Tokens: 0","Tokens");v2:Section("");v2:Section("Towers","Towers");v2:Section("Slot 1: Not Founded","Slot1");v2:Section("Slot 2: Not Founded","Slot2");v2:Section("Slot 3: Not Founded","Slot3");v2:Section("Slot 4: Not Founded","Slot4");v2:Section("Slot 5: Not Founded","Slot5");v2:Section("");v2:Section("discord.gg/BvtEFn2Wjq","invite");v2:Button("Copy Invite",function()setclipboard("discord.gg/BvtEFn2Wjq");end);local v3=game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.SpendedTime.TextLabel;local v5=game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Slot1.TextLabel;local v6=game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Slot2.TextLabel;local v7=game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Slot3.TextLabel;local v8=game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Slot4.TextLabel;local v9=game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Slot5.TextLabel;game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Level.TextLabel.Text="Level: "   .. v0.Level.Value;game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Experience.TextLabel.Text="Experience: "   .. v0.Experience.Value;game:GetService("CoreGui").TbzAutoFarm.Container["Auto Farm"].container.Tokens.TextLabel.Text="Tokens: "   .. v0.Tokens.Value;spawn(function()repeat game:GetService("RunService").Heartbeat:Wait();v3.Text="Spended Time: "   .. CountTime();if (v0.TowersChosen.Slot1.Value=="") then v5.Text="Slot1: Not Founded";else v5.Text="Slot1: "   .. v0.TowersChosen.Slot1.Value;end if (v0.TowersChosen.Slot2.Value=="") then v6.Text="Slot2: Not Founded";else v6.Text="Slot2: "   .. v0.TowersChosen.Slot2.Value;end if (v0.TowersChosen.Slot3.Value=="") then v7.Text="Slot3: Not Founded";else v7.Text="Slot3: "   .. v0.TowersChosen.Slot3.Value;end if (v0.TowersChosen.Slot4.Value=="") then v8.Text="Slot4: Not Founded";else v8.Text="Slot4: "   .. v0.TowersChosen.Slot4.Value;end if (v0.TowersChosen.Slot5.Value=="") then v9.Text="Slot5: Not Founded";else v9.Text="Slot5: "   .. v0.TowersChosen.Slot5.Value;end until  not game:GetService("CoreGui"):FindFirstChild("TbzAutoFarm") end);

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
    spawn(function()
        local NumberValue = Instance.new("NumberValue", Tower)
        NumberValue.Value = TowerCounter
	print(TowerCounter, NumberValue.Name)
    end)
end)
local OldNameCall = nil;
    OldNameCall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local Args = {...}
        if self.Name == "PlaceTower" then
            TowerCounter = TowerCounter + 1
        end
        return OldNameCall(self, ...)
    end))
end

function Table:EquipLoadout(Tower1,Tower2,Tower3,Tower4,Tower5)
    spawn(function()
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
    end)
end

function Table:PlaceTower(Tower,pos1,pos2,pos3,Wave,Time)
    spawn(function()
        if IsGame() then
            repeat task.wait() until Workspace.Game.GameStats.Wave.Value == Wave
            repeat task.wait() until Workspace.Game.GameStats.TimeLeft.Value == Time
            ReplicatedStorage.Events.PlaceTower:InvokeServer(Tower, Vector3.new(pos1, pos2, pos3), 0)
        end
    end)
end

function Table:SellTower(Tower,Wave,Time)
    spawn(function()
        if IsGame() then
            repeat task.wait() until Workspace.Game.GameStats.Wave.Value == Wave
            repeat task.wait() until Workspace.Game.GameStats.TimeLeft.Value == Time
            for _,v in next, Workspace.Game.Towers:GetChildren() do
                if v.Value.Value == Tower then
                    ReplicatedStorage.Events.SellTower:InvokeServer(v)
                end
            end
        end
    end)
end

function Table:UpgradeTower(Tower,Path,Wave,Time)
    spawn(function()
        if IsGame() then
            repeat task.wait() until Workspace.Game.GameStats.Wave.Value == Wave
            repeat task.wait(0.6) until Workspace.Game.GameStats.TimeLeft.Value == Time
	    print('ok')
            for _,v in next, Workspace.Game.Towers:GetChildren() do
                if v.Value.Value == Tower then
                    ReplicatedStorage.Events.UpgradeTower:InvokeServer(v, Path)
                end
            end
        end
    end)
end

function Table:CreateGame(Mode, Map, ModifiersTable)
    spawn(function()
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
            ReplicatedStorage.Events.StartGame:InvokeServer()
        end
    end)
end

function Table:StartGame(Difficulty)
    spawn(function()
        if IsGame() then
            ReplicatedStorage.Events.VoteGamemode:FireServer(Difficulty)
        end
    end)
end

function Table:EndVote(Time)
    spawn(function()
        if IsGame() then
            repeat task.wait() until Workspace.Game.GameStats.TimeLeft.Value == Time
            ReplicatedStorage.Events.EndVote:FireServer()
        end
    end)
end

function Table:SkipWave(Wave, Time)
    spawn(function()
        if IsGame() then
	    repeat task.wait() until Workspace.Game.GameStats.Wave.Value == Time
            repeat task.wait() until Workspace.Game.GameStats.TimeLeft.Value == Time
	    ReplicatedStorage.Events.VoteSkip:FireServer(true)
        end
    end)
end

return Table
