-- Decompiled with Potassium's decompiler.

game:GetService("ProximityPromptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local Trove = require(ReplicatedStorage.Modules.Trove);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local ItemOddsController = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController);
local Config = GameConfigController:GetConfig("ZenEventConfig");
local CorruptZenQuestRewardData = Config.CorruptZenQuestRewardData;
workspace:GetAttributeChangedSignal("ZenEventConfig"):Connect(function() -- Line: 16
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("ZenEventConfig");
end);
local CorruptedMonkOdds_UI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Events").ZenEvent:WaitForChild("CorruptedMonkOdds_UI");
local Holder = CorruptedMonkOdds_UI.Frame.Main.Holder;
local u1 = Trove.new();
local v14 = {
    Open = function(p2: table, u3: userdata?) -- Line: 29, Name: Open
        -- upvalues: GuiController (copy), CorruptedMonkOdds_UI (copy), u1 (copy), Holder (copy), CorruptZenQuestRewardData (copy), ItemImageFinder (copy), ItemOddsController (copy), RunService (copy)
        local StateForGui = GuiController:GetStateForGui(CorruptedMonkOdds_UI);
        u1:Destroy();

        for _, child in Holder.ScrollingFrame:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                child:Destroy();
            end;
        end;

        local v4 = 0;
        local v5 = {};

        for _, v in CorruptZenQuestRewardData do
            local v6 = v.Chance or 1;

            if v6 and v6 ~= 0 then
                v4 = v4 + v6;
                table.insert(v5, {
                    Name = v.ItemName,
                    Type = v.ItemType,
                    Amount = v.ItemAmount,
                    NormalizedOdd = v6
                });
            end;
        end;

        for _, v in v5 do
            v.NormalizedOdd = v.NormalizedOdd / v4;
            v.NormalizedOdd = v.NormalizedOdd * 100;
        end;

        table.sort(v5, function(p7, p8) -- Line: 61
            return p7.NormalizedOdd < p8.NormalizedOdd;
        end);

        for i = 2, #v5 do
            if math.abs(v5[i].NormalizedOdd - v5[1].NormalizedOdd) > 1e-6 then
                break;
            end;

            local _ = i;
        end;

        local _ = v5[1].NormalizedOdd;
        local v9 = 0;

        for _, v in v5 do
            v9 = v9 + 1;
            local Frame = u1:Clone(Holder.ScrollingFrame.UIGridLayout.TEMPLATE).Frame;
            Frame.Parent.LayoutOrder = -math.floor(v.NormalizedOdd * 1000);
            Frame.Title.Text = (v.Amount <= 1 and "" or `{v.Amount}x `) .. v.Name;
            Frame.Vector.Image = ItemImageFinder(v.Name, v.Type);
            ItemOddsController:ConnectOddsButton({
                Type = v.Type,
                Value = v.Value
            }, Frame.OddsButton, CorruptedMonkOdds_UI);
            local v10 = tonumber(string.format("%.2f", v.NormalizedOdd));
            Frame.Odds.Text = `{v10}%`;
            Frame.Vector.Visible = true;

            if v10 <= 1 then
                local u11 = nil;
                u1:Add(StateForGui.Visible:Listen(function(p12: boolean) -- Line: 99
                    -- upvalues: u11 (ref), u1 (ref), RunService (ref), Frame (copy)
                    if p12 and not u11 then
                        u11 = u1:Add(RunService.PostSimulation:Connect(function() -- Line: 101
                            -- upvalues: Frame (ref)
                            local Color3_fromHSV_ret = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
                            Frame.Odds.TextColor3 = Color3_fromHSV_ret;
                            Frame.Title.TextColor3 = Color3_fromHSV_ret;
                        end));

                        return;
                    end;

                    if not p12 and u11 then
                        u1:Remove(u11);
                        u11 = nil;
                    end;
                end));
            end;

            Frame.Title.TextScaled = true;
            Frame.Odds.TextScaled = true;
            Frame.Parent.Parent = Holder.ScrollingFrame;
        end;

        GuiController:Open(CorruptedMonkOdds_UI);

        if u3 then
            u1:Add(CorruptedMonkOdds_UI.Frame.Exit.EXIT_BUTTON.Activated:Once(function() -- Line: 121
                -- upvalues: GuiController (ref), CorruptedMonkOdds_UI (ref), u3 (copy), u1 (ref)
                GuiController:Close(CorruptedMonkOdds_UI);
                GuiController:Open(u3);
                u1:Clean();
            end));

            return;
        end;

        u1:Add(CorruptedMonkOdds_UI.Frame.Exit.EXIT_BUTTON.Activated:Once(function() -- Line: 127
            -- upvalues: GuiController (ref), CorruptedMonkOdds_UI (ref), u1 (ref)
            GuiController:Close(CorruptedMonkOdds_UI);
            u1:Clean();
        end));
    end,

    Start = function(p13) -- Line: 134, Name: Start
        -- upvalues: GuiController (copy), CorruptedMonkOdds_UI (copy)
        GuiController:UsePopupAnims(CorruptedMonkOdds_UI);
    end
};
task.spawn(v14.Start, v14);

return v14;