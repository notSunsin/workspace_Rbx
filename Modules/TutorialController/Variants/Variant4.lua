-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local Seed_Shop = PlayerGui.Seed_Shop;
local DeviceController = require(ReplicatedStorage.Modules.DeviceController);
local Notification = require(ReplicatedStorage.Modules.Notification);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Observers = require(ReplicatedStorage.Modules.Observers);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
require(ReplicatedStorage.Modules.GetFarm);
local Trove = require(ReplicatedStorage.Modules.Trove);
local TutorialUtils = require(ReplicatedStorage.Modules.TutorialController.TutorialUtils);
local Arrow_Module = require(ReplicatedStorage.Arrow_Module);

return function() -- Line: 23
    -- upvalues: Trove (copy), Arrow_Module (copy), LocalPlayer (copy), DataService (copy), Observers (copy), TutorialUtils (copy), ReplicatedStorage (copy), Notification (copy), Seed_Shop (copy), DeviceController (copy), UserInputService (copy), PlayerGui (copy), FastTween (copy)
    local u1 = Trove.new();

    local function createArrow(p2) -- Line: 26
        -- upvalues: u1 (copy), Arrow_Module (ref), LocalPlayer (ref)
        local v3 = u1:Extend();
        local u4 = Arrow_Module.GenerateArrow(LocalPlayer, p2, math.random(1, 1000000));
        v3:Add(function() -- Line: 30
            -- upvalues: Arrow_Module (ref), u4 (copy)
            Arrow_Module.Remove_Arrow(u4);
        end);

        return v3:WrapClean();
    end;

    local Data = DataService:GetData();

    local function isOnBeeSlot() -- Line: 41
        -- upvalues: Data (copy)
        if not (Data and (Data.SaveSlots and Data.SaveSlots.AllSlots)) then
            return false;
        end;

        local SelectedSlot = Data.SaveSlots.SelectedSlot;

        if SelectedSlot then
            SelectedSlot = Data.SaveSlots.AllSlots[SelectedSlot];
        end;

        if SelectedSlot then
            SelectedSlot = SelectedSlot.IsBeeSlot == true;
        end;

        return SelectedSlot;
    end;

    local u5 = nil;
    local u6 = nil;

    local function hideGrowSigns() -- Line: 53
        -- upvalues: u5 (ref), Observers (ref)
        if u5 then
            return;
        end;

        u5 = Observers.observeTag("GrowSign", function(u7) -- Line: 55
            u7:SetAttribute("Visible", false);

            return function() -- Line: 57
                -- upvalues: u7 (copy)
                u7:SetAttribute("Visible", true);
            end;
        end);
    end;

    local function showGrowSigns() -- Line: 63
        -- upvalues: u5 (ref), u6 (ref)
        if u5 then
            u5();
            u5 = nil;
        end;

        if u6 then
            u6:Disconnect();
            u6 = nil;
        end;
    end;

    local function evaluateGrowSignVisibility() -- Line: 74
        -- upvalues: Data (copy), u5 (ref), u6 (ref), Observers (ref)
        local v8;

        if Data and (Data.SaveSlots and Data.SaveSlots.AllSlots) then
            v8 = Data.SaveSlots.SelectedSlot;

            if v8 then
                v8 = Data.SaveSlots.AllSlots[v8];
            end;

            if v8 then
                v8 = v8.IsBeeSlot == true;
            end;
        else
            v8 = false;
        end;

        if v8 or Data and Data.CropsSold >= 5 then
            if u5 then
                u5();
                u5 = nil;
            end;

            if u6 then
                u6:Disconnect();
                u6 = nil;
            end;
        else
            if u5 then
                return;
            end;

            u5 = Observers.observeTag("GrowSign", function(u9) -- Line: 55
                u9:SetAttribute("Visible", false);

                return function() -- Line: 57
                    -- upvalues: u9 (copy)
                    u9:SetAttribute("Visible", true);
                end;
            end);
        end;
    end;

    local v10;

    if Data and (Data.SaveSlots and Data.SaveSlots.AllSlots) then
        v10 = Data.SaveSlots.SelectedSlot;

        if v10 then
            v10 = Data.SaveSlots.AllSlots[v10];
        end;

        if v10 then
            v10 = v10.IsBeeSlot == true;
        end;
    else
        v10 = false;
    end;

    if v10 or Data and Data.CropsSold >= 5 then
        if u5 then
            u5();
            u5 = nil;
        end;

        if u6 then
            u6:Disconnect();
            u6 = nil;
        end;
    elseif not u5 then
        u5 = Observers.observeTag("GrowSign", function(u11) -- Line: 55
            u11:SetAttribute("Visible", false);

            return function() -- Line: 57
                -- upvalues: u11 (copy)
                u11:SetAttribute("Visible", true);
            end;
        end);
    end;

    u6 = assert(DataService:GetPathSignal("CropsSold")):Connect(evaluateGrowSignVisibility);
    assert(DataService:GetPathSignal("SaveSlots/SelectedSlot")):Connect(evaluateGrowSignVisibility);
    workspace:SetAttribute("InTutorial", true);
    u1:Add(function() -- Line: 89
        workspace:SetAttribute("InTutorial", nil);
    end);
    u1:Add(task.spawn(function() -- Line: 93
        -- upvalues: TutorialUtils (ref), DataService (ref), u1 (copy), ReplicatedStorage (ref), createArrow (copy), Notification (ref), Seed_Shop (ref), DeviceController (ref), LocalPlayer (ref), UserInputService (ref), PlayerGui (ref), FastTween (ref)
        local v12 = TutorialUtils.waitForFarm();
        local Data2 = DataService:GetData();

        if Data2 and Data2.CropsSold and Data2.CropsSold > 0 then
            workspace:SetAttribute("InTutorialShopMovement", nil);
            workspace:SetAttribute("InTutorial", nil);
            u1:Clean();
            ReplicatedStorage.GameEvents.SetTutorialFinished:FireServer();

            return;
        end;

        local v13 = false;

        for _, v in TutorialUtils.getTools() do
            if v:FindFirstChild("Item_String") then
                v13 = true;
                break;
            end;
        end;

        local v14 = v12.Important and v12.Important.Plants_Physical and #v12.Important.Plants_Physical:GetChildren() > 0;

        if not (TutorialUtils.hasSeed() or (v14 or v13)) then
            local v15 = createArrow(workspace.Tutorial_Points.Tutorial_Point_1.Position);
            TutorialUtils.waitUntilDistance(workspace.Tutorial_Points.Tutorial_Point_1.Position, 10);
            v15();
            Notification:CreateNotification("Talk to Sam!");

            while not Seed_Shop.Enabled do
                task.wait(0.1);
            end;

            local function getCarrotObject() -- Line: 128
                -- upvalues: Seed_Shop (ref)
                return Seed_Shop.Frame.ScrollingFrame:FindFirstChild("Carrot");
            end;

            local u16 = nil;

            local function u20() -- Line: 135
                -- upvalues: Seed_Shop (ref), TutorialUtils (ref), u16 (ref)
                Seed_Shop.Frame.ScrollingFrame.ScrollingEnabled = false;
                local u17 = TutorialUtils.pointToUI(function() -- Line: 138
                    -- upvalues: Seed_Shop (ref)
                    local Carrot = Seed_Shop.Frame.ScrollingFrame:FindFirstChild("Carrot");

                    if not Carrot then
                        return nil;
                    end;

                    local Main_Frame = Carrot.Main_Frame;

                    return Main_Frame.AbsolutePosition + Main_Frame.AbsoluteSize * 0.5;
                end);
                local v18 = TutorialUtils.focusObject(function() -- Line: 148
                    -- upvalues: Seed_Shop (ref)
                    local Carrot = Seed_Shop.Frame.ScrollingFrame:FindFirstChild("Carrot");

                    if not Carrot then
                        return nil;
                    end;

                    local Main_Frame = Carrot.Main_Frame;

                    return {
                        Position = Main_Frame.AbsolutePosition,
                        Size = Main_Frame.AbsoluteSize
                    };
                end);
                local v19 = Seed_Shop:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 161
                    -- upvalues: Seed_Shop (ref), u17 (ref), TutorialUtils (ref)
                    if Seed_Shop.Enabled then
                        u17 = TutorialUtils.pointToUI(function() -- Line: 165
                            -- upvalues: Seed_Shop (ref)
                            local Carrot = Seed_Shop.Frame.ScrollingFrame:FindFirstChild("Carrot");

                            if not Carrot then
                                return nil;
                            end;

                            local Main_Frame = Carrot.Main_Frame;

                            return Main_Frame.AbsolutePosition + Main_Frame.AbsoluteSize * 0.5;
                        end);

                        return;
                    end;

                    u17();
                end);

                while true do
                    task.wait(0.1);

                    if not Seed_Shop.Enabled then
                        break;
                    end;

                    local Carrot = Seed_Shop.Frame.ScrollingFrame:FindFirstChild("Carrot");

                    if Carrot and Carrot.Frame.Position.Y.Scale > 1 then
                        break;
                    end;
                end;

                v19:Disconnect();
                v18();
                u17();

                while not (Seed_Shop.Enabled or TutorialUtils.hasSeed()) do
                    task.wait(0.1);
                end;

                u16();
            end;

            u16 = function() -- Line: 204
                -- upvalues: Seed_Shop (ref), TutorialUtils (ref), u20 (ref)
                Seed_Shop.Frame.ScrollingFrame.ScrollingEnabled = false;
                local u21 = TutorialUtils.pointToUI(function() -- Line: 207
                    -- upvalues: Seed_Shop (ref)
                    local Carrot = Seed_Shop.Frame.ScrollingFrame:FindFirstChild("Carrot");

                    if not Carrot then
                        return nil;
                    end;

                    local Sheckles_Buy = Carrot.Frame.Sheckles_Buy;

                    return Sheckles_Buy.AbsolutePosition + Sheckles_Buy.AbsoluteSize * 0.5;
                end);
                local v22 = TutorialUtils.focusObject(function() -- Line: 217
                    -- upvalues: Seed_Shop (ref)
                    local Carrot = Seed_Shop.Frame.ScrollingFrame:FindFirstChild("Carrot");

                    if not Carrot then
                        return nil;
                    end;

                    local Sheckles_Buy = Carrot.Frame.Sheckles_Buy;

                    return {
                        Position = Sheckles_Buy.AbsolutePosition,
                        Size = Sheckles_Buy.AbsoluteSize
                    };
                end);
                local v23 = Seed_Shop:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 230
                    -- upvalues: Seed_Shop (ref), u21 (ref), TutorialUtils (ref)
                    if Seed_Shop.Enabled then
                        u21 = TutorialUtils.pointToUI(function() -- Line: 234
                            -- upvalues: Seed_Shop (ref)
                            local Carrot = Seed_Shop.Frame.ScrollingFrame:FindFirstChild("Carrot");

                            if not Carrot then
                                return nil;
                            end;

                            local Sheckles_Buy = Carrot.Frame.Sheckles_Buy;

                            return Sheckles_Buy.AbsolutePosition + Sheckles_Buy.AbsoluteSize * 0.5;
                        end);

                        return;
                    end;

                    u21();
                end);
                local v24;

                repeat
                    task.wait(0.1);
                    v24 = Seed_Shop.Frame.ScrollingFrame:FindFirstChild("Carrot");
                until v24 and (TutorialUtils.hasSeed() or (not Seed_Shop.Enabled or v24.Frame.Position.Y.Scale < 1));

                v23:Disconnect();
                v22();
                u21();

                while not (Seed_Shop.Enabled or TutorialUtils.hasSeed()) do
                    task.wait(0.1);
                end;

                if not TutorialUtils.hasSeed() then
                    return u20();
                end;
            end;

            u20();
            Seed_Shop.Frame.ScrollingFrame.ScrollingEnabled = true;
            workspace:SetAttribute("InTutorialShopMovement", true);
            local v25 = TutorialUtils.pointToUI(function() -- Line: 279
                -- upvalues: Seed_Shop (ref)
                local ExitButton = Seed_Shop.Frame.Frame.ExitButton;

                return ExitButton.AbsolutePosition + ExitButton.AbsoluteSize * 0.5;
            end);
            local v26 = TutorialUtils.focusObject(Seed_Shop.Frame.Frame.ExitButton);

            while Seed_Shop.Enabled do
                task.wait();
            end;

            v26();
            v25();
        end;

        if not (v14 or v13) then
            local Position = (v12.Spawn_Point.CFrame * CFrame.new(0, 0, -10)).Position;
            local v27 = createArrow(Position);
            TutorialUtils.waitUntilDistance(Position, 10);
            local u28 = nil;
            local v29 = DeviceController:GetCurrentDevice() == "Gamepad";

            if v29 then
                if LocalPlayer.Backpack:FindFirstChild("Shovel [Destroy Plants]") ~= nil then
                    pcall(function() -- Line: 306
                        -- upvalues: u28 (ref), UserInputService (ref)
                        u28 = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonL1);
                    end);
                else
                    pcall(function() -- Line: 310
                        -- upvalues: u28 (ref), UserInputService (ref)
                        u28 = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonR1);
                    end);
                end;
            end;

            local v34 = TutorialUtils.pointToUI(function(p30) -- Line: 316
                -- upvalues: PlayerGui (ref), u28 (ref)
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

                local v31 = nil;

                for i = 1, 10 do
                    local v32 = BackpackGui:FindFirstChild((tostring(i)));

                    if v32 and string.find(v32.ToolName.Text, "Seed") then
                        v31 = v32;
                        break;
                    end;

                    local _ = i;
                end;

                if not v31 then
                    return nil;
                end;

                local v33 = v31.AbsolutePosition + Vector2.new(v31.AbsoluteSize.X * 0.5, 0);

                if u28 ~= nil then
                    v33 = v33 + Vector2.new(0, -(v31.AbsoluteSize.Y * 1.75 + p30.AbsoluteSize.Y) * 0.5);
                end;

                return v33;
            end, nil, nil, u28);
            TutorialUtils.waitUntilSeedEquipped();
            v34();
            v27();
            local u35 = "R2";
            pcall(function() -- Line: 351
                -- upvalues: u35 (ref), UserInputService (ref)
                u35 = string.gsub(UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonR2), "Button", "");
            end);
            Notification:CreateNotification(not v29 and "Click on your plot to plant!" or `Press {u35} on your plot to plant!`);
            local u36 = ReplicatedStorage.Tutorial_Parts.Tutorial_Click:Clone();
            u36.Size = Vector3.new(0.001, 0.001, 0.001);
            u36.Position = (v12.Spawn_Point.CFrame * CFrame.new(15, -5, -15)).Position;

            if v29 then
                pcall(function() -- Line: 362
                    -- upvalues: u36 (copy), UserInputService (ref)
                    u36.BillboardGui.Size = UDim2.fromScale(1.5, 1.5);
                    u36.BillboardGui.ImageLabel.Image = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonR2);
                end);
            end;

            u36.Parent = workspace.Click_Points;

            while #v12.Important.Plants_Physical:GetChildren() <= 0 do
                task.wait();
            end;

            u36:Destroy();
            Notification:CreateNotification("Wait for your plant to grow then Collect it");
        end;

        if not v13 then
            local v37 = nil;

            for _, child in v12.Important.Plants_Physical:GetChildren() do
                if child:IsA("Model") and child:FindFirstChild("Grow") then
                    v37 = child;

                    while v37:IsDescendantOf(v12) and not v37:GetAttribute("MaxAge") do
                        v37:GetAttributeChangedSignal("MaxAge"):Wait();
                    end;

                    while v37:IsDescendantOf(v12) and v37.Grow.Age.Value < v37:GetAttribute("MaxAge") do
                        v37.Grow.Age.Changed:Wait();
                    end;

                    break;
                end;
            end;

            if v37 then
                local v38 = createArrow(v37:GetPivot().Position);
                Notification:CreateNotification("Collect your plant!");
                TutorialUtils.waitUntilSellableItem();
                v38();
            else
                TutorialUtils.waitUntilSellableItem();
            end;
        end;

        local v39 = createArrow(workspace.Tutorial_Points.Tutorial_Point_2.Position);
        TutorialUtils.waitUntilDistance(workspace.Tutorial_Points.Tutorial_Point_2.Position, 5);
        v39();
        Notification:CreateNotification("Talk to Steven!");
        local v40 = nil;
        local v41;

        while true do
            if Data2.CropsSold > 0 then
                v41 = v40;
                break;
            end;

            local Billboard_UI = PlayerGui:FindFirstChild("Billboard_UI");
            v41 = Billboard_UI and Billboard_UI:FindFirstChild("Objects") and Billboard_UI.Objects:FindFirstChildWhichIsA("GuiObject");

            if v41 and v41.Frame.Frame.Text_Element:GetAttribute("Text") == "I want to sell my inventory" then
                break;
            end;

            task.wait(0.1);
        end;

        local function billboardPositionToScreenPosition(p42: userdata) -- Line: 431
            local v43 = p42.Adornee or p42.Parent;
            local v44 = v43 and v43:IsA("PVInstance") and workspace.CurrentCamera;
            assert(v44);
            local v45 = v43:GetPivot() * p42.StudsOffset;
            local v46, v47 = workspace.CurrentCamera:WorldToScreenPoint(v45);

            if v47 then
                return Vector2.new(v46.X, v46.Y);
            end;

            return Vector2.new(0, 99999);
        end;

        if v41 then
            local Billboard_UI = PlayerGui:FindFirstChild("Billboard_UI");
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Name = "UIStroke";
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
            UIStroke.LineJoinMode = Enum.LineJoinMode.Bevel;
            UIStroke.Thickness = 10000;
            UIStroke.Transparency = 1;
            FastTween(UIStroke, TweenInfo.new(0.2), {
                Transparency = 0.3
            });
            local v48 = TutorialUtils.pointToUI(function() -- Line: 468
                -- upvalues: billboardPositionToScreenPosition (copy), Billboard_UI (copy)
                return billboardPositionToScreenPosition(Billboard_UI);
            end);

            while Data2.CropsSold <= 0 do
                local Billboard_UI2 = PlayerGui:FindFirstChild("Billboard_UI");

                if not (Billboard_UI2 and (Billboard_UI2:FindFirstChild("Objects") and Billboard_UI2.Objects:FindFirstChildWhichIsA("GuiObject"))) then
                    break;
                end;

                Billboard_UI2.ClipsDescendants = false;
                UIStroke.Parent = Billboard_UI2.Objects:FindFirstChild("Option_UI");
                task.wait(0.1);
            end;

            v48();
            FastTween(UIStroke, TweenInfo.new(0.2), {
                Transparency = 1
            }).Completed:Once(function() -- Line: 489
                -- upvalues: UIStroke (copy)
                UIStroke:Destroy();
            end);
        end;

        workspace:SetAttribute("InTutorialShopMovement", nil);
        workspace:SetAttribute("InTutorial", nil);
        u1:Clean();
        ReplicatedStorage.GameEvents.SetTutorialFinished:FireServer();
    end));

    return u1:WrapClean();
end;