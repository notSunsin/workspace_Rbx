-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local PityHoverController = require(ReplicatedStorage.Modules.PityHoverController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local PityData = require(ReplicatedStorage.Data.PityData);
local Trove = require(ReplicatedStorage.Modules.Trove);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local Odds_UI = Players.LocalPlayer.PlayerGui.Odds_UI;
local Items = Odds_UI.Frame.Main.Items;
local u1 = SeedPackData.Packs["Season Pass Quests"];
local u2 = {};
task.spawn(function() -- Line: 24
    -- upvalues: u1 (copy), u2 (copy)
    for _, v in u1.Items do
        table.insert(u2, {
            Type = v.Type,
            Value = v.RewardId,
            Quantity = v.Quantity
        });
    end;
end);
local u3 = Trove.new();
local v28 = {
    Open = function(p4: table, u5: userdata?, p6: string?) -- Line: 38, Name: Open
        -- upvalues: SeedPackData (copy), ItemInfoHover (copy), u2 (copy), PityData (copy), GuiController (copy), Odds_UI (copy), u3 (copy), Items (copy), ItemNameFinder (copy), PityHoverController (copy), ItemImageFinder (copy), RunService (copy)
        local v7 = SeedPackData.Packs["Season Pass Quests"];

        if not v7 then
            return;
        end;

        ItemInfoHover:AddRewardTable("SPQuestsOdds", u2);
        local v8;

        if p6 then
            v8 = PityData[p6];
        else
            v8 = nil;
        end;

        local StateForGui = GuiController:GetStateForGui(Odds_UI);
        u3:Destroy();

        for _, child in Items.ScrollingFrame:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                child:Destroy();
            end;
        end;

        local v9 = 0;
        local v10 = {};

        for _, v in v7.Items do
            if not (v.RemoveChance or v.HideChance) then
                v9 = v9 + (v.Chance or 0);
            end;
        end;

        for i, v in v7.Items do
            table.insert(v10, {
                Reward = v,
                Index = i,
                Normalized = (v.RemoveChance or v.HideChance) and 0 or (v.Chance or 0) / v9 * 100
            });
        end;

        table.sort(v10, function(p11, p12) -- Line: 74
            return p11.Normalized < p12.Normalized;
        end);
        local v13 = true;

        for i = 2, #v10 do
            if math.abs(v10[i].Normalized - v10[1].Normalized) > 1e-6 then
                v13 = false;
                break;
            end;

            local _ = i;
        end;

        local Normalized = v10[1].Normalized;
        local v14 = nil;

        for i = 2, #v10 do
            if math.abs(v10[i].Normalized - Normalized) > 1e-6 then
                v14 = v10[i].Normalized;
                break;
            end;

            local _ = i;
        end;

        local v15 = 0;

        for _, v in v10 do
            local Reward = v.Reward;
            local v16;

            if Reward.Type == "RainbowSeed" then
                v16 = true;
            else
                v16 = string.find(Reward.RewardId, "Rainbow ") or not v13 and math.abs(v.Normalized - Normalized) < 1e-6;
            end;

            local v17;

            if v14 then
                v17 = math.abs(v.Normalized - v14) < 1e-6;
            else
                v17 = v14;
            end;

            local v18;

            if v16 then
                v18 = Items.ScrollingFrame.UIListLayout.TemplateRainbow;
            elseif v17 then
                v18 = Items.ScrollingFrame.UIListLayout.TemplateBigger;
            else
                v18 = Items.ScrollingFrame.UIListLayout.TemplateSmaller;
            end;

            v15 = v15 + 1;
            local u19 = u3:Clone(v18);
            u19:SetAttribute("UUID", (`SPQuestsOdds_{Reward.Type}_{Reward.RewardId}`));
            u19:AddTag("ItemInfoHoverTag");
            u19.LayoutOrder = v.Index;
            local v20 = not v.Reward.Quantity and "" or ` x{v.Reward.Quantity}`;
            u19.Title.Text = `{ItemNameFinder(Reward.RewardId, Reward.Type)}{v20}`;
            local v21;

            if v8 then
                v21 = v;
                local v22 = 0;

                for _, v2 in v8.Items do
                    if v2.RewardId == v21.Reward.RewardId and v2.Type == v21.Reward.Type then
                        v22 = v2.Pity;
                        break;
                    end;
                end;

                if v22 > 0 then
                    local Pity = u19.Pity;
                    Pity.Text = `{v22}*`;
                    Pity.Visible = true;
                    PityHoverController:AddGuiObject(u19, v22, v8.DisplayPlural);
                    u3:Add(function() -- Line: 133
                        -- upvalues: PityHoverController (ref), u19 (copy)
                        PityHoverController:RemoveGuiObject(u19);
                    end);
                end;
            else
                v21 = v;
            end;

            if Reward.RemoveChance then
                u19.Odds.Text = "";
            elseif Reward.HideChance then
                u19.Odds.Text = "???";
            else
                local v23 = tonumber(string.format("%.2f", v21.Normalized));
                u19.Odds.Text = `{v23}%`;
            end;

            if Reward.Icon then
                u19.Vector.Image = Reward.Icon;
                u19.Vector.Visible = true;
            else
                local v24 = ItemImageFinder(Reward.RewardId, Reward.Type);

                if v24 then
                    u19.Vector.Image = v24;
                    u19.Vector.Visible = true;
                else
                    u19.Vector.Visible = false;
                end;
            end;

            if v16 then
                local u25 = nil;
                u3:Add(StateForGui.Visible:Observe(function(p26: boolean) -- Line: 165
                    -- upvalues: u25 (ref), u3 (ref), RunService (ref), u19 (copy)
                    if p26 and not u25 then
                        u25 = u3:Add(RunService.PostSimulation:Connect(function() -- Line: 167
                            -- upvalues: u19 (ref)
                            local Color3_fromHSV_ret = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
                            u19.Odds.TextColor3 = Color3_fromHSV_ret;
                            u19.Title.TextColor3 = Color3_fromHSV_ret;
                        end));

                        return;
                    end;

                    if not p26 and u25 then
                        u3:Remove(u25);
                        u25 = nil;
                    end;
                end));
            elseif v17 then
                local Color3_fromRGB_ret = Color3.fromRGB(255, 204, 1);
                u19.Odds.TextColor3 = Color3_fromRGB_ret;
                u19.Title.TextColor3 = Color3_fromRGB_ret;
            end;

            u19.Title.TextScaled = true;
            u19.Odds.TextScaled = true;
            u19.Parent = Items.ScrollingFrame;
        end;

        for _, v in v10 do
            if v.Reward.Type ~= "RainbowSeed" and not string.find(v.Reward.RewardId, "Rainbow ") then
                break;
            end;
        end;

        if Items.ScrollingFrame.AbsoluteCanvasSize.X > Items.ScrollingFrame.AbsoluteWindowSize.X then
            Items.ScrollingFrame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
        else
            Items.ScrollingFrame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        end;

        GuiController:Open(Odds_UI);

        if u5 then
            u3:Add(Odds_UI.Frame.ExitButton.Activated:Once(function() -- Line: 205
                -- upvalues: ItemInfoHover (ref), u2 (ref), GuiController (ref), Odds_UI (ref), u5 (copy), u3 (ref)
                ItemInfoHover:RemoveRewardTable("SPQuestsOdds", u2);
                GuiController:Close(Odds_UI);
                GuiController:Open(u5);
                u3:Clean();
            end));

            return;
        end;

        u3:Add(Odds_UI.Frame.ExitButton.Activated:Once(function() -- Line: 213
            -- upvalues: ItemInfoHover (ref), u2 (ref), GuiController (ref), Odds_UI (ref), u3 (ref)
            ItemInfoHover:RemoveRewardTable("SPQuestsOdds", u2);
            GuiController:Close(Odds_UI);
            u3:Clean();
        end));
    end,

    Start = function(p27) -- Line: 222, Name: Start
        -- upvalues: GuiController (copy), Odds_UI (copy)
        GuiController:UsePopupAnims(Odds_UI);
    end
};
task.spawn(v28.Start, v28);

return v28;