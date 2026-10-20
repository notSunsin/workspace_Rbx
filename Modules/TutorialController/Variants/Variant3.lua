-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local Seed_Shop = PlayerGui.Seed_Shop;
local Notification = require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Modules.GetFarm);
local Trove = require(ReplicatedStorage.Modules.Trove);
local TutorialUtils = require(ReplicatedStorage.Modules.TutorialController.TutorialUtils);
local Arrow_Module = require(ReplicatedStorage.Arrow_Module);
local DataService = require(ReplicatedStorage.Modules.DataService);

return function() -- Line: 19
    -- upvalues: Trove (copy), Arrow_Module (copy), LocalPlayer (copy), TutorialUtils (copy), DataService (copy), ReplicatedStorage (copy), Notification (copy), Seed_Shop (copy), PlayerGui (copy)
    local u1 = Trove.new();

    local function createArrow(p2) -- Line: 22
        -- upvalues: u1 (copy), Arrow_Module (ref), LocalPlayer (ref)
        local v3 = u1:Extend();
        local u4 = Arrow_Module.GenerateArrow(LocalPlayer, p2, math.random(1, 1000000));
        v3:Add(function() -- Line: 26
            -- upvalues: Arrow_Module (ref), u4 (copy)
            Arrow_Module.Remove_Arrow(u4);
        end);

        return v3:WrapClean();
    end;

    workspace:SetAttribute("InTutorial", true);
    u1:Add(function() -- Line: 34
        workspace:SetAttribute("InTutorial", nil);
    end);
    u1:Add(task.spawn(function() -- Line: 38
        -- upvalues: TutorialUtils (ref), DataService (ref), u1 (copy), ReplicatedStorage (ref), createArrow (copy), Notification (ref), Seed_Shop (ref), PlayerGui (ref)
        local v5 = TutorialUtils.waitForFarm();
        local Data = DataService:GetData();

        if Data and Data.CropsSold and Data.CropsSold > 0 then
            workspace:SetAttribute("InTutorial", nil);
            u1:Clean();
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
            local v8 = createArrow(workspace.Tutorial_Points.Tutorial_Point_1.Position);
            TutorialUtils.waitUntilDistance(workspace.Tutorial_Points.Tutorial_Point_1.Position, 5);
            v8();
            Notification:CreateNotification("Talk to Sam!");

            while not Seed_Shop.Enabled do
                task.wait(0.1);
            end;

            local Carrot = Seed_Shop.Frame.ScrollingFrame:WaitForChild("Carrot");
            local u9 = TutorialUtils.pointToUI(function() -- Line: 74
                -- upvalues: Carrot (copy)
                local Main_Frame = Carrot.Main_Frame;

                return Main_Frame.AbsolutePosition + Main_Frame.AbsoluteSize * 0.5;
            end);
            local v10 = Seed_Shop:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 79
                -- upvalues: Seed_Shop (ref), u9 (ref), TutorialUtils (ref), Carrot (copy)
                if Seed_Shop.Enabled then
                    u9 = TutorialUtils.pointToUI(function() -- Line: 83
                        -- upvalues: Carrot (ref)
                        local Main_Frame = Carrot.Main_Frame;

                        return Main_Frame.AbsolutePosition + Main_Frame.AbsoluteSize * 0.5;
                    end);

                    return;
                end;

                u9();
            end);

            while Carrot.Frame.Position.Y.Scale < 1 do
                task.wait(0.1);
            end;

            v10:Disconnect();
            u9();
            local u11 = TutorialUtils.pointToUI(function() -- Line: 97
                -- upvalues: Carrot (copy)
                local Sheckles_Buy = Carrot.Frame.Sheckles_Buy;

                return Sheckles_Buy.AbsolutePosition + Sheckles_Buy.AbsoluteSize * 0.5;
            end);
            local v12 = Seed_Shop:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 102
                -- upvalues: Seed_Shop (ref), u11 (ref), TutorialUtils (ref), Carrot (copy)
                if Seed_Shop.Enabled then
                    u11 = TutorialUtils.pointToUI(function() -- Line: 106
                        -- upvalues: Carrot (ref)
                        local Sheckles_Buy = Carrot.Frame.Sheckles_Buy;

                        return Sheckles_Buy.AbsolutePosition + Sheckles_Buy.AbsoluteSize * 0.5;
                    end);

                    return;
                end;

                u11();
            end);
            TutorialUtils.waitForSeed();
            v12:Disconnect();
            u11();
            local v13 = TutorialUtils.pointToUI(function() -- Line: 118
                -- upvalues: Seed_Shop (ref)
                local ExitButton = Seed_Shop.Frame.Frame.ExitButton;

                return ExitButton.AbsolutePosition + ExitButton.AbsoluteSize * 0.5;
            end);

            while Seed_Shop.Enabled do
                task.wait();
            end;

            v13();
        end;

        if not (v7 or v6) then
            local Position = (v5.Spawn_Point.CFrame * CFrame.new(0, 0, -10)).Position;
            local v14 = createArrow(Position);
            TutorialUtils.waitUntilDistance(Position, 10);
            local v17 = TutorialUtils.pointToUI(function() -- Line: 136
                -- upvalues: PlayerGui (ref)
                local BackpackGui = PlayerGui:FindFirstChild("BackpackGui");

                if BackpackGui then
                    BackpackGui = BackpackGui:FindFirstChild("Backpack");
                end;

                if BackpackGui then
                    BackpackGui = BackpackGui:FindFirstChild("Hotbar");
                end;

                if not BackpackGui then
                    return nil;
                end;

                local v15 = nil;

                for i = 1, 10 do
                    local v16 = BackpackGui:FindFirstChild((tostring(i)));

                    if v16 and string.find(v16.ToolName.Text, "Seed") then
                        v15 = v16;
                        break;
                    end;

                    local _ = i;
                end;

                if v15 then
                    return v15.AbsolutePosition + Vector2.new(v15.AbsoluteSize.X * 0.5, 0);
                end;

                return nil;
            end);
            TutorialUtils.waitUntilSeedEquipped();
            v17();
            v14();
            Notification:CreateNotification("Click on your plot to plant!");
            local v18 = ReplicatedStorage.Tutorial_Parts.Tutorial_Click:Clone();
            v18.Size = Vector3.new(0.001, 0.001, 0.001);
            v18.Position = (v5.Spawn_Point.CFrame * CFrame.new(15, -5, -15)).Position;
            v18.Parent = workspace.Click_Points;

            while #v5.Important.Plants_Physical:GetChildren() <= 0 do
                task.wait();
            end;

            v18:Destroy();
            Notification:CreateNotification("Wait for your plant to grow then Collect it");
        end;

        if not v6 then
            TutorialUtils.waitUntilSellableItem();
        end;

        local v19 = createArrow(workspace.Tutorial_Points.Tutorial_Point_2.Position);
        TutorialUtils.waitUntilDistance(workspace.Tutorial_Points.Tutorial_Point_2.Position, 5);
        v19();
        Notification:CreateNotification("Talk to Steven!");

        while true do
            local Billboard_UI = PlayerGui:FindFirstChild("Billboard_UI");
            local v20 = Billboard_UI and Billboard_UI:FindFirstChild("Objects") and Billboard_UI.Objects:FindFirstChildWhichIsA("GuiObject");

            if v20 and v20.Frame.Frame.Text_Element:GetAttribute("Text") == "I want to sell my inventory" then
                local u21 = v20;

                if u21 then
                    local v25 = TutorialUtils.pointToUI(function() -- Line: 204
                        -- upvalues: u21 (ref), PlayerGui (ref)
                        local Vector2_zero = Vector2.zero;
                        local Billboard_UI2 = PlayerGui:FindFirstChild("Billboard_UI");

                        if Billboard_UI2 then
                            local v22 = Billboard_UI2.Adornee or Billboard_UI2.Parent;

                            if v22:IsA("PVInstance") then
                                local v23, v24 = workspace.CurrentCamera:WorldToScreenPoint(v22:GetPivot().Position);

                                if v24 then
                                    Vector2_zero = Vector2.new(v23.X, v23.Y);
                                else
                                    Vector2_zero = Vector2_zero + Vector2.new(0, 999999999999);
                                end;
                            end;
                        end;

                        return Vector2_zero + Vector2.new(u21.AbsoluteSize.X * 0.5, 0);
                    end);

                    while true do
                        local Billboard_UI2 = PlayerGui:FindFirstChild("Billboard_UI");

                        if not (Billboard_UI2 and (Billboard_UI2:FindFirstChild("Objects") and Billboard_UI2.Objects:FindFirstChildWhichIsA("GuiObject"))) then
                            break;
                        end;

                        task.wait(0.1);
                    end;

                    v25();
                end;

                workspace:SetAttribute("InTutorial", nil);
                u1:Clean();
                ReplicatedStorage.GameEvents.SetTutorialFinished:FireServer();

                return;
            end;

            task.wait(0.1);
        end;
    end));

    return u1:WrapClean();
end;