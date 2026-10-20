-- Decompiled with Potassium's decompiler.

game:GetService("ProximityPromptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local WaspRewardOddsShared = require(ReplicatedStorage.Modules.BeeEventV2Controllers.WaspRewardOddsShared);
local BeeEggRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEggRegistry);
require(ReplicatedStorage.Modules.CreateTagHandler);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Trove = require(ReplicatedStorage.Modules.Trove);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local StringUtils = require(ReplicatedStorage.Modules.StringUtils);
local Odds_UI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Odds_UI");
local Items = Odds_UI.Frame.Main.Items;
local u1 = Trove.new();
local RewardsTable = WaspRewardOddsShared.GetRewardsTable();
local v2 = {
    States = {}
};

local function GetLootingBonus() -- Line: 31
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();
    local v3 = Data and Data.BeeEventData and Data.BeeEventData.CombatSkillTree;

    return (v3 and v3.Looting or 0) * 0.15;
end;

local function GetRewardImage(p4: string, p5: string) -- Line: 43
    -- upvalues: BeeEggRegistry (copy), ItemImageFinder (copy)
    local v6 = BeeEggRegistry.Entries[p4];

    if v6 and v6.Icon then
        return v6.Icon;
    end;

    return ItemImageFinder(p4, p5);
end;

local function FormatPercent(p7: number) -- Line: 53
    return `{tonumber(string.format("%.2f", p7))}%`;
end;

local function FormatRewardTitle(p8) -- Line: 57
    -- upvalues: StringUtils (copy)
    local v9 = StringUtils:SplitWordWithSpace(p8.Name);

    if p8.Min == 1 and p8.Max == 1 then
        return v9;
    end;

    if p8.Min == p8.Max then
        return `{p8.Min}x {v9}`;
    end;

    return `{p8.Min}-{p8.Max}x {v9}`;
end;

function v2.ClearEntries(p10) -- Line: 70
    -- upvalues: Items (copy)
    for _, child in Items.ScrollingFrame:GetChildren() do
        if child:IsA("GuiObject") and (child.Name ~= "UIListLayout" and not child:IsDescendantOf(Items.ScrollingFrame.UIListLayout)) then
            child:Destroy();
        end;
    end;
end;

function v2.Render(p11: table, p12: string) -- Line: 81
    -- upvalues: DataService (copy), WaspRewardOddsShared (copy), Items (copy), u1 (ref), StringUtils (copy), BeeEggRegistry (copy), ItemImageFinder (copy), RunService (copy), Odds_UI (copy)
    p11:ClearEntries();
    local Data = DataService:GetData();
    local v13 = Data and Data.BeeEventData and Data.BeeEventData.CombatSkillTree;
    local v14 = {};

    for _, v in WaspRewardOddsShared.GetOdds(p12, (v13 and v13.Looting or 0) * 0.15) do
        local v15 = v.PerCrateChance * 100;
        local v16 = {
            Name = v.Value,
            Type = v.Type,
            Odd = v15,
            Text = `{tonumber(string.format("%.2f", v15))}%`,
            Tier = v.Tier,
            Min = v.Min,
            Max = v.Max
        };
        table.insert(v14, v16);
    end;

    table.sort(v14, function(p17, p18) -- Line: 103
        if p17.IsGuaranteed then
            return true;
        end;

        if p18.IsGuaranteed then
            return false;
        end;

        return p17.Odd < p18.Odd;
    end);
    local v19 = (1 / 0);
    local v20 = nil;
    local v21 = true;

    for _, v in v14 do
        if not v.IsGuaranteed and v.Odd < v19 then
            v19 = v.Odd;
        end;
    end;

    for _, v in v14 do
        if not v.IsGuaranteed and math.abs(v.Odd - v19) > 1e-6 then
            v21 = false;

            if v20 == nil or v.Odd < v20 then
                v20 = v.Odd;
            end;
        end;
    end;

    local ScrollingFrame = Items.ScrollingFrame;

    for _, v in v14 do
        local v22 = not (v.IsGuaranteed or v21) and math.abs(v.Odd - v19) < 1e-6;
        local v23 = not v.IsGuaranteed;

        if v23 then
            if v20 == nil then
                v23 = false;
            else
                v23 = math.abs(v.Odd - v20) < 1e-6;
            end;
        end;

        local v24;

        if v22 then
            v24 = ScrollingFrame.UIListLayout.TemplateRainbow;
        elseif v23 then
            v24 = ScrollingFrame.UIListLayout.TemplateBigger;
        else
            v24 = ScrollingFrame.UIListLayout.TemplateSmaller;
        end;

        local u25 = u1:Clone(v24);
        u25:SetAttribute("UUID", (`WaspEventOdds_{v.Type}_{v.Name}`));
        u25:AddTag("ItemInfoHoverTag");
        u25.LayoutOrder = -math.floor(v.Odd * 1000);
        local Title = u25.Title;
        local v26 = StringUtils:SplitWordWithSpace(v.Name);

        if v.Min ~= 1 or v.Max ~= 1 then
            if v.Min == v.Max then
                v26 = `{v.Min}x {v26}`;
            else
                v26 = `{v.Min}-{v.Max}x {v26}`;
            end;
        end;

        Title.Text = v26;
        u25.Odds.Text = "";
        local Name = v.Name;
        local Type = v.Type;
        local v27 = BeeEggRegistry.Entries[Name];
        local v28;

        if v27 and v27.Icon then
            v28 = v27.Icon;
        else
            v28 = ItemImageFinder(Name, Type);
        end;

        u25.Vector.Image = v28;
        local v29;

        if v28 == nil then
            v29 = false;
        else
            v29 = v28 ~= "";
        end;

        u25.Vector.Visible = v29;

        if u25:FindFirstChild("OddsButton") then
            u25.OddsButton.Visible = false;
        end;

        if v22 then
            u1:Add(RunService.PostSimulation:Connect(function() -- Line: 173
                -- upvalues: u25 (copy)
                if not u25.Parent then
                    return;
                end;

                local Color3_fromHSV_ret = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
                u25.Odds.TextColor3 = Color3_fromHSV_ret;
                u25.Title.TextColor3 = Color3_fromHSV_ret;
            end));
        elseif v23 then
            local Color3_fromRGB_ret = Color3.fromRGB(255, 204, 1);
            u25.Odds.TextColor3 = Color3_fromRGB_ret;
            u25.Title.TextColor3 = Color3_fromRGB_ret;
        end;

        u25.Title.TextScaled = true;
        u25.Odds.TextScaled = true;
        u25.Parent = ScrollingFrame;
    end;

    if ScrollingFrame.AbsoluteCanvasSize.X > ScrollingFrame.AbsoluteWindowSize.X then
        ScrollingFrame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    else
        ScrollingFrame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    end;

    Odds_UI.Frame.ExpandButton.Visible = false;
end;

function v2.Open(p30: table, p31: string?, u32: userdata?) -- Line: 200
    -- upvalues: u1 (ref), Trove (copy), ItemInfoHover (copy), RewardsTable (copy), GuiController (copy), Odds_UI (copy)
    u1:Destroy();
    u1 = Trove.new();
    p30:Render(p31 or "Wasp King");
    ItemInfoHover:AddRewardTable("WaspEventOdds", RewardsTable);
    GuiController:Open(Odds_UI);
    u1:Add(Odds_UI.Frame.ExitButton.Activated:Once(function() -- Line: 212
        -- upvalues: ItemInfoHover (ref), RewardsTable (ref), GuiController (ref), Odds_UI (ref), u32 (copy), u1 (ref)
        ItemInfoHover:RemoveRewardTable("WaspEventOdds", RewardsTable);
        GuiController:Close(Odds_UI);

        if u32 then
            GuiController:Open(u32);
        end;

        u1:Clean();
    end));
end;

function v2.Start(p33) -- Line: 225
    -- upvalues: GuiController (copy), Odds_UI (copy)
    GuiController:UsePopupAnims(Odds_UI);
end;

task.spawn(v2.Start, v2);

return v2;