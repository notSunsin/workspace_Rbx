-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local BeeEggRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEggRegistry);
local BeeEventEggsOddsController = require(ReplicatedStorage.Modules.BeeEventEggsOddsController);
local Trove = require(ReplicatedStorage.Modules.Trove);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local BeeEventEggInfo_UI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("BeeEventEggInfo_UI");
local Main = BeeEventEggInfo_UI.Main.Main;
local SENSOR = Main.Header.Exit.SENSOR;
local Content = Main.Holder.EggInfo.Content;
local TEMPLATE = Content.TEMPLATE;
local v12 = {
    Trove = nil,

    Cleanup = function(p1) -- Line: 27, Name: Cleanup
        if p1.Trove then
            p1.Trove:Destroy();
            p1.Trove = nil;
        end;
    end,

    ClearEntries = function(p2) -- Line: 34, Name: ClearEntries
        -- upvalues: Content (copy), TEMPLATE (copy)
        for _, child in Content:GetChildren() do
            if child:IsA("GuiObject") and child ~= TEMPLATE then
                child:Destroy();
            end;
        end;
    end,

    Render = function(p3) -- Line: 42, Name: Render
        -- upvalues: Trove (copy), BeeEggRegistry (copy), UpdateService (copy), TEMPLATE (copy), BeeEventEggsOddsController (copy), BeeEventEggInfo_UI (copy), Content (copy)
        p3:Cleanup();
        p3:ClearEntries();
        local v4 = Trove.new();
        p3.Trove = v4;
        local v5 = {};

        for i, v in BeeEggRegistry.Entries do
            if UpdateService:IsActive(i) then
                table.insert(v5, {
                    EggName = i,
                    EggData = v,
                    StockChance = v.StockChance or 1
                });
            end;
        end;

        table.sort(v5, function(p6, p7) -- Line: 65
            return p6.StockChance < p7.StockChance;
        end);

        for _, v in v5 do
            local v8 = v4:Clone(TEMPLATE);
            local EggData = v.EggData;
            local EGG_IMAGE = v8.Display.DisplayBox.EGG_IMAGE;
            v8.Name = v.EggName;
            v8.Visible = true;
            v8.LayoutOrder = v.StockChance;
            EGG_IMAGE.Image = EggData.Icon or "";
            EGG_IMAGE.Visible = EggData.Icon ~= nil;
            v8.Display.RARITY_NAME.Text = v.EggName;
            local math_floor_ret = math.floor(100 / v.StockChance);
            v8.Display.RARITY_CHANCE.Text = `{math_floor_ret}% of shops`;
            v4:Add(v8.Display.OddsButton.MouseButton1Click:Connect(function() -- Line: 85
                -- upvalues: BeeEventEggsOddsController (ref), v (copy), BeeEventEggInfo_UI (ref)
                BeeEventEggsOddsController:Open(v.EggName, BeeEventEggInfo_UI);
            end));
            v8.Parent = Content;
        end;
    end,

    Open = function(p9) -- Line: 93, Name: Open
        -- upvalues: BeeEventEggInfo_UI (copy), GuiController (copy)
        p9:Render();
        BeeEventEggInfo_UI.Enabled = true;
        GuiController:Open(BeeEventEggInfo_UI);
    end,

    Close = function(p10) -- Line: 99, Name: Close
        -- upvalues: GuiController (copy), BeeEventEggInfo_UI (copy)
        p10:Cleanup();
        GuiController:Close(BeeEventEggInfo_UI);
        BeeEventEggInfo_UI.Enabled = false;
    end,

    Start = function(u11) -- Line: 105, Name: Start
        -- upvalues: TEMPLATE (copy), GuiController (copy), BeeEventEggInfo_UI (copy), SENSOR (copy)
        TEMPLATE.Visible = false;
        GuiController:UsePopupAnims(BeeEventEggInfo_UI);
        SENSOR.MouseButton1Click:Connect(function() -- Line: 109
            -- upvalues: u11 (copy)
            u11:Close();
        end);
    end
};
task.spawn(v12.Start, v12);

return v12;