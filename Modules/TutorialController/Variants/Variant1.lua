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
    local u1 = {};

    local function createArrow(p2) -- Line: 17
        -- upvalues: Arrow_Module (ref), LocalPlayer (ref), u1 (copy)
        local u3 = Arrow_Module.GenerateArrow(LocalPlayer, p2, math.random(1, 1000000));
        table.insert(u1, u3);

        return function() -- Line: 21
            -- upvalues: u1 (ref), u3 (copy), Arrow_Module (ref)
            local table_find_ret = table.find(u1, u3);

            if table_find_ret then
                Arrow_Module.Remove_Arrow(u3);
                table.remove(u1, table_find_ret);
            end;
        end;
    end;

    workspace:SetAttribute("InTutorial", true);
    local task_spawn_ret = task.spawn(function() -- Line: 34
        -- upvalues: TutorialUtils (ref), DataService (ref), ReplicatedStorage (ref), Arrow_Module (ref), LocalPlayer (ref), u1 (copy), Notification (ref)
        local v4 = TutorialUtils.waitForFarm();
        local Data = DataService:GetData();

        if Data and Data.CropsSold and Data.CropsSold > 0 then
            workspace:SetAttribute("InTutorial", nil);
            ReplicatedStorage.GameEvents.SetTutorialFinished:FireServer();

            return;
        end;

        local v5 = false;

        for _, v in TutorialUtils.getTools() do
            if v:FindFirstChild("Item_String") then
                v5 = true;
                break;
            end;
        end;

        local v6 = v4.Important and v4.Important.Plants_Physical and #v4.Important.Plants_Physical:GetChildren() > 0;

        if not (TutorialUtils.hasSeed() or (v6 or v5)) then
            local u7 = Arrow_Module.GenerateArrow(LocalPlayer, workspace.Tutorial_Points.Tutorial_Point_1.Position, math.random(1, 1000000));
            table.insert(u1, u7);

            local function v8() -- Line: 21
                -- upvalues: u1 (ref), u7 (copy), Arrow_Module (ref)
                local table_find_ret = table.find(u1, u7);

                if table_find_ret then
                    Arrow_Module.Remove_Arrow(u7);
                    table.remove(u1, table_find_ret);
                end;
            end;

            local task_delay_ret = task.delay(5, function() -- Line: 58
                -- upvalues: Notification (ref)
                Notification:CreateNotification("Go buy your first seed!");
            end);
            TutorialUtils.waitForSeed();

            if coroutine.status(task_delay_ret) == "suspended" then
                task.cancel(task_delay_ret);
            end;

            v8();
        end;

        if not v5 then
            if v6 then
                TutorialUtils.waitUntilSellableItem();
            else
                Notification:CreateNotification("Go plant your seed!");
                local Position = (v4.Spawn_Point.CFrame * CFrame.new(0, 0, -10)).Position;
                local u9 = Arrow_Module.GenerateArrow(LocalPlayer, Position, math.random(1, 1000000));
                table.insert(u1, u9);

                local function v10() -- Line: 21
                    -- upvalues: u1 (ref), u9 (copy), Arrow_Module (ref)
                    local table_find_ret = table.find(u1, u9);

                    if table_find_ret then
                        Arrow_Module.Remove_Arrow(u9);
                        table.remove(u1, table_find_ret);
                    end;
                end;

                TutorialUtils.waitUntilSellableItem();
                v10();
            end;
        end;

        Notification:CreateNotification("Go sell your plant!");
        local u11 = Arrow_Module.GenerateArrow(LocalPlayer, workspace.Tutorial_Points.Tutorial_Point_2.Position, math.random(1, 1000000));
        table.insert(u1, u11);

        local function v12() -- Line: 21
            -- upvalues: u1 (ref), u11 (copy), Arrow_Module (ref)
            local table_find_ret = table.find(u1, u11);

            if table_find_ret then
                Arrow_Module.Remove_Arrow(u11);
                table.remove(u1, table_find_ret);
            end;
        end;

        TutorialUtils.waitUntilNoSellableItems();
        v12();
        workspace:SetAttribute("InTutorial", nil);
        ReplicatedStorage.GameEvents.SetTutorialFinished:FireServer();
    end);

    return function() -- Line: 94
        -- upvalues: task_spawn_ret (copy), u1 (copy), Arrow_Module (ref)
        if coroutine.status(task_spawn_ret) == "suspended" then
            task.cancel(task_spawn_ret);
        end;

        workspace:SetAttribute("InTutorial", nil);

        for _, v in u1 do
            Arrow_Module.Remove_Arrow(v);
        end;

        table.clear(u1);
    end;
end;