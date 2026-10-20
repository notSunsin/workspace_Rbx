-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local CosmeticCrates = require(ReplicatedStorage.Data.CosmeticCrateRegistry.CosmeticCrates);
local CosmeticList = require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList;
local Trove = require(ReplicatedStorage.Modules.Trove);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local ItemRarityFinder = require(ReplicatedStorage.Modules.ItemRarityFinder);
local GGStaticData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
local DisclaimerPresets = require(ReplicatedStorage.Modules.UIComponents.DisclaimerPresets);
local Odds_UI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Odds_UI");
local Items = Odds_UI.Frame.Main.Items;
local u1 = Trove.new();

local function DisplayedPercent(p2: number) -- Line: 31
    return tonumber(string.format("%.2f", p2)) or 0;
end;

local function ApplyDisclaimer(p3: userdata, p4: string?) -- Line: 43
    -- upvalues: DisclaimerPresets (copy)
    local Parent = p3.Parent;

    if Parent then
        Parent = Parent.Parent;
    end;

    if not Parent then
        return;
    end;

    local Disclaimer = Parent:FindFirstChild("Disclaimer");

    if Disclaimer and Disclaimer:IsA("TextLabel") then
        Disclaimer.Text = DisclaimerPresets.Resolve(p4);
    end;
end;

local v33 = {
    Open = function(p5: table, p6: string, u7: userdata?) -- Line: 58, Name: Open
        -- upvalues: CosmeticCrates (copy), ItemInfoHover (copy), GuiController (copy), Odds_UI (copy), u1 (copy), Items (copy), DisclaimerPresets (copy), ItemRarityFinder (copy), GGStaticData (copy), CosmeticList (copy), RunService (copy)
        local v8 = CosmeticCrates[p6];

        if not v8 then
            warn((`Crate '{p6}' not found in CosmeticCrates`));

            return;
        end;

        local u9 = {};

        for _, v in v8.CosmeticRolls.Items do
            table.insert(u9, {
                Type = "Cosmetic",
                Value = v.Name
            });
        end;

        ItemInfoHover:AddRewardTable("CosmeticCrateOdds", u9);
        local StateForGui = GuiController:GetStateForGui(Odds_UI);
        u1:Destroy();

        for _, child in Items.ScrollingFrame:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                child:Destroy();
            end;
        end;

        local v10 = 0;
        local v11 = {};

        for _, v in v8.CosmeticRolls.Items do
            v10 = v10 + v.ItemOdd;
        end;

        for i, v in v8.CosmeticRolls.Items do
            table.insert(v11, {
                Name = i,
                Item = v,
                NormalizedOdd = v.ItemOdd / v10 * 100
            });
        end;

        local v12 = 0;

        for _, v in v11 do
            v12 = v12 + (tonumber(string.format("%.2f", v.NormalizedOdd)) or 0);
        end;

        local v13 = v10 > 0 and math.abs(v12 - 100) >= 1e-9 and "PRESETS/RoundedOddsCompliance" or nil;
        local Parent = Items.Parent;

        if Parent then
            Parent = Parent.Parent;
        end;

        if Parent then
            local Disclaimer = Parent:FindFirstChild("Disclaimer");

            if Disclaimer and Disclaimer:IsA("TextLabel") then
                Disclaimer.Text = DisclaimerPresets.Resolve(v13);
            end;
        end;

        table.sort(v11, function(p14, p15) -- Line: 124
            return p14.NormalizedOdd < p15.NormalizedOdd;
        end);
        local v16 = true;

        for i = 2, #v11 do
            if math.abs(v11[i].NormalizedOdd - v11[1].NormalizedOdd) > 1e-6 then
                v16 = false;
                break;
            end;

            local _ = i;
        end;

        local NormalizedOdd = v11[1].NormalizedOdd;
        local v17 = nil;

        for i = 2, #v11 do
            if math.abs(v11[i].NormalizedOdd - NormalizedOdd) > 1e-6 then
                v17 = v11[i].NormalizedOdd;
                break;
            end;

            local _ = i;
        end;

        table.sort(v11, function(p18, p19) -- Line: 145
            -- upvalues: ItemRarityFinder (ref), GGStaticData (ref)
            local v20 = ItemRarityFinder(p18.Name, "Cosmetic");
            local v21 = ItemRarityFinder(p19.Name, "Cosmetic");

            return (GGStaticData.RarityLayoutMap[v20] or 0) < (GGStaticData.RarityLayoutMap[v21] or 0);
        end);
        local v22 = 0;
        local v23 = {};

        for _, v in v11 do
            local v24 = not v16 and math.abs(v.NormalizedOdd - NormalizedOdd) < 1e-6;
            local v25;

            if v17 then
                v25 = math.abs(v.NormalizedOdd - v17) < 1e-6;
            else
                v25 = v17;
            end;

            local v26;

            if v24 then
                v26 = Items.ScrollingFrame.UIListLayout.TemplateRainbow;
            elseif v25 then
                v26 = Items.ScrollingFrame.UIListLayout.TemplateBigger;
            else
                v26 = Items.ScrollingFrame.UIListLayout.TemplateSmaller;
            end;

            v22 = v22 + 1;
            local u27 = u1:Clone(v26);
            u27:SetAttribute("UUID", (`CosmeticCrateOdds_Cosmetic_{v.Name}`));
            u27:AddTag("ItemInfoHoverTag");
            u27.LayoutOrder = -math.floor(v.NormalizedOdd * 1000);
            u27.Title.Text = v.Name;
            local Odds = u27.Odds;
            local v28 = tonumber(string.format("%.2f", v.NormalizedOdd)) or 0;
            Odds.Text = tostring(v28) .. "%";
            local v29 = CosmeticList[v.Name];

            if v29 and v29.Icon then
                u27.Vector.Image = v29.Icon;
                u27.Vector.Visible = true;
            else
                u27.Vector.Visible = false;
            end;

            if v24 then
                local u30 = nil;
                u1:Add(StateForGui.Visible:Observe(function(p31: boolean) -- Line: 187
                    -- upvalues: u30 (ref), u1 (ref), RunService (ref), u27 (copy)
                    if p31 and not u30 then
                        u30 = u1:Add(RunService.PostSimulation:Connect(function() -- Line: 189
                            -- upvalues: u27 (ref)
                            local Color3_fromHSV_ret = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
                            u27.Odds.TextColor3 = Color3_fromHSV_ret;
                            u27.Title.TextColor3 = Color3_fromHSV_ret;
                        end));

                        return;
                    end;

                    if not p31 and u30 then
                        u1:Remove(u30);
                        u30 = nil;
                    end;
                end));
            elseif v25 then
                local Color3_fromRGB_ret = Color3.fromRGB(255, 204, 1);
                u27.Odds.TextColor3 = Color3_fromRGB_ret;
                u27.Title.TextColor3 = Color3_fromRGB_ret;
            end;

            u27.Title.TextScaled = true;
            u27.Odds.TextScaled = true;
            u27.Parent = Items.ScrollingFrame;
            table.insert(v23, u27);
        end;

        if Items.ScrollingFrame.AbsoluteCanvasSize.X > Items.ScrollingFrame.AbsoluteWindowSize.X then
            Items.ScrollingFrame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
        else
            Items.ScrollingFrame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        end;

        GuiController:Open(Odds_UI);

        if u7 then
            u1:Add(Odds_UI.Frame.ExitButton.Activated:Once(function() -- Line: 231
                -- upvalues: ItemInfoHover (ref), u9 (copy), GuiController (ref), Odds_UI (ref), u7 (copy), u1 (ref)
                ItemInfoHover:RemoveRewardTable("CosmeticCrateOdds", u9);
                GuiController:Close(Odds_UI);
                GuiController:Open(u7);
                u1:Clean();
            end));

            return;
        end;

        u1:Add(Odds_UI.Frame.ExitButton.Activated:Once(function() -- Line: 239
            -- upvalues: ItemInfoHover (ref), u9 (copy), GuiController (ref), Odds_UI (ref), u1 (ref)
            ItemInfoHover:RemoveRewardTable("CosmeticCrateOdds", u9);
            GuiController:Close(Odds_UI);
            u1:Clean();
        end));
    end,

    Start = function(p32) -- Line: 248, Name: Start
        -- upvalues: GuiController (copy), Odds_UI (copy)
        GuiController:UsePopupAnims(Odds_UI);
    end
};
task.spawn(v33.Start, v33);

return v33;