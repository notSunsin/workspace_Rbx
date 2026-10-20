-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Notification = require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Modules.GetFarm);
local TutorialUtils = require(ReplicatedStorage.Modules.TutorialController.TutorialUtils);
local Arrow_Module = require(ReplicatedStorage.Arrow_Module);
local DataService = require(ReplicatedStorage.Modules.DataService);

return function() -- Line: 15
    -- upvalues: Arrow_Module (copy), LocalPlayer (copy), TutorialUtils (copy), DataService (copy), ReplicatedStorage (copy), Notification (copy)
    local u1 = nil;
    local u2 = {};

    local function createArrow(p3) -- Line: 19
        -- upvalues: Arrow_Module (ref), LocalPlayer (ref), u2 (copy)
        local u4 = Arrow_Module.GenerateArrow(LocalPlayer, p3, math.random(1, 1000000));
        table.insert(u2, u4);

        return function() -- Line: 23
            -- upvalues: u2 (ref), u4 (copy), Arrow_Module (ref)
            local table_find_ret = table.find(u2, u4);

            if table_find_ret then
                Arrow_Module.Remove_Arrow(u4);
                table.remove(u2, table_find_ret);
            end;
        end;
    end;

    workspace:SetAttribute("InTutorial", true);
    local task_spawn_ret = task.spawn(function() -- Line: 36
        -- upvalues: TutorialUtils (ref), DataService (ref), ReplicatedStorage (ref), Arrow_Module (ref), LocalPlayer (ref), u2 (copy), Notification (ref), u1 (ref)
        local v5 = TutorialUtils.waitForFarm();
        local Data = DataService:GetData();

        if Data and Data.CropsSold and Data.CropsSold > 0 then
            workspace:SetAttribute("InTutorial", nil);
            ReplicatedStorage.GameEvents.SetTutorialFinished:FireServer();

            return;
        end;

        local v6 = false;

        for _, v in TutorialUtils.getTools() do
            if v:FindFirstChild("Item_String") then
                v6 = true;
                break;
            end;
        end;

        local v7 = v5.Important and v5.Important.Plants_Physical and #v5.Important.Plants_Physical:GetChildren() > 0;

        if not (TutorialUtils.hasSeed() or (v7 or v6)) then
            local u8 = Arrow_Module.GenerateArrow(LocalPlayer, workspace.Tutorial_Points.Tutorial_Point_1.Position, math.random(1, 1000000));
            table.insert(u2, u8);

            local function v9() -- Line: 23
                -- upvalues: u2 (ref), u8 (copy), Arrow_Module (ref)
                local table_find_ret = table.find(u2, u8);

                if table_find_ret then
                    Arrow_Module.Remove_Arrow(u8);
                    table.remove(u2, table_find_ret);
                end;
            end;

            TutorialUtils.waitForSeed();
            v9();
        end;

        if not (v7 or v6) then
            local Position = (v5.Spawn_Point.CFrame * CFrame.new(0, 0, -10)).Position;
            local u10 = Arrow_Module.GenerateArrow(LocalPlayer, Position, math.random(1, 1000000));
            table.insert(u2, u10);

            local function v11() -- Line: 23
                -- upvalues: u2 (ref), u10 (copy), Arrow_Module (ref)
                local table_find_ret = table.find(u2, u10);

                if table_find_ret then
                    Arrow_Module.Remove_Arrow(u10);
                    table.remove(u2, table_find_ret);
                end;
            end;

            TutorialUtils.waitUntilDistance(Position, 30);
            TutorialUtils.waitUntilSeedEquipped();
            v11();
            Notification:CreateNotification("Click on your plot to plant!");
            local v12 = ReplicatedStorage.Tutorial_Parts.Tutorial_Click:Clone();
            v12.Size = Vector3.new(0.001, 0.001, 0.001);
            v12.Position = (v5.Spawn_Point.CFrame * CFrame.new(15, -5, -15)).Position;
            v12.Parent = workspace.Click_Points;
            u1 = v12;

            while #v5.Important.Plants_Physical:GetChildren() <= 0 do
                task.wait(0.1);
            end;

            u1 = nil;
            v12:Destroy();
        end;

        if not v6 then
            TutorialUtils.waitUntilSellableItem();
        end;

        local v13 = Arrow_Module.GenerateArrow(LocalPlayer, workspace.Tutorial_Points.Tutorial_Point_2.Position, math.random(1, 1000000));
        table.insert(u2, v13);
        workspace:SetAttribute("InTutorial", nil);
        ReplicatedStorage.GameEvents.SetTutorialFinished:FireServer();
    end);

    return function() -- Line: 101
        -- upvalues: task_spawn_ret (copy), u1 (ref), u2 (copy), Arrow_Module (ref)
        if coroutine.status(task_spawn_ret) == "suspended" then
            task.cancel(task_spawn_ret);
        end;

        workspace:SetAttribute("InTutorial", nil);

        if u1 then
            u1:Destroy();
            u1 = nil;
        end;

        for _, v in u2 do
            Arrow_Module.Remove_Arrow(v);
        end;

        table.clear(u2);
    end;
end;