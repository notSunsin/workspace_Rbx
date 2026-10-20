-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.ItemNameFinder);
require(ReplicatedStorage.Modules.ItemRarityFinder);
require(ReplicatedStorage.Modules.ItemImageFinder);
local Item_Module = require(ReplicatedStorage.Item_Module);
require(ReplicatedStorage.Calculate_Weight);
require(ReplicatedStorage.Data.PetRegistry);
require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry);
require(ReplicatedStorage.Data.TradeBoothSkinRegistry);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local ItemHoverFrame = Players.LocalPlayer.PlayerGui:WaitForChild("ItemHover").ItemHoverFrame;
local _ = ItemHoverFrame.CanvasGroup.Main.Item.Item.Detail;
local ITEM_NAME = ItemHoverFrame.CanvasGroup.Main.Item.ITEM_NAME;
local ITEM_IMAGE = ItemHoverFrame.CanvasGroup.Main.Item.Item.ITEM_IMAGE;
local ITEM_RARITY = ItemHoverFrame.CanvasGroup.Main.Item.ITEM_RARITY;
local Description = ItemHoverFrame.CanvasGroup.Main.Description;
local DescDetails = ItemHoverFrame.CanvasGroup.Main.DescDetails;
local DetailsSFrame = ItemHoverFrame.CanvasGroup.Main.DetailsSFrame;
local u1 = {
    Prismatic = true
};
local u2 = ITEM_RARITY:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient");
u2.Name = "RarityRainbow";
u2.Parent = ITEM_RARITY;
u2.Enabled = false;

local function BuildRainbow(p3: number) -- Line: 56
    local v4 = {};

    for i = 0, 8 do
        local v5 = i / 8;
        v4[i + 1] = ColorSequenceKeypoint.new(v5, Color3.fromHSV((v5 - p3) % 1, 1, 1));
        local _ = i;
    end;

    return ColorSequence.new(v4);
end;

local u6 = 0;
RunService.RenderStepped:Connect(function(p7: number) -- Line: 66
    -- upvalues: u2 (copy), u6 (ref), BuildRainbow (copy)
    if not u2.Enabled then
        return;
    end;

    u6 = (u6 + p7 * 0.35) % 1;
    u2.Color = BuildRainbow(u6);
end);
local u8 = {};
local u9 = {};

local function SetupFireWispText(p10: userdata, p11: string) -- Line: 76
    -- upvalues: u8 (copy), u9 (copy)
    p10.RichText = true;
    u8[p10] = nil;
    u9[p10] = nil;

    if not string.find(p11, "Fire Wisp", 1, true) then
        p10.Text = p11;

        return;
    end;

    u8[p10] = true;
    u9[p10] = p11;
    p10.Text = p11;
end;

local u12 = 0;
RunService.RenderStepped:Connect(function(p13: number) -- Line: 92
    -- upvalues: u8 (copy), u12 (ref), u9 (copy)
    if not next(u8) then
        return;
    end;

    u12 = u12 + p13;
    local v14 = (math.sin(u12 * 6) * 0.5 + 0.5) * 0.1 + 0.02;
    local Color3_fromHSV_ret = Color3.fromHSV(v14, 1, 1);
    local v15 = `<font color="{string.format("#%02X%02X%02X", math.floor(Color3_fromHSV_ret.R * 255 + 0.5), math.floor(Color3_fromHSV_ret.G * 255 + 0.5), (math.floor(Color3_fromHSV_ret.B * 255 + 0.5)))}">Fire Wisp</font>`;

    for i in u8 do
        i.Text = (u9[i] or ""):gsub("Fire Wisp", v15);
    end;
end);
local u16 = {};
local v17 = {};

local function CreateSegment() -- Line: 112
    -- upvalues: DetailsSFrame (copy), DescDetails (copy), u16 (copy)
    local v18;

    if DetailsSFrame.Visible then
        v18 = DetailsSFrame;
    else
        v18 = DescDetails.DetailsSFrame;
    end;

    local v19 = v18.SegmentTemplate:Clone();
    v19.BackgroundTransparency = #u16 % 2 == 0 and 0.96 or 0.9;
    table.insert(u16, v19);
    v19.LayoutOrder = #u16;
    v19.Visible = true;
    v19.Parent = v18;

    return v19;
end;

local u62 = {
    Custom = function(p20: string, p21: any) -- Line: 127
        -- upvalues: DetailsSFrame (copy), DescDetails (copy), u16 (copy)
        if typeof(p21) ~= "table" then
            local v22;

            if DetailsSFrame.Visible then
                v22 = DetailsSFrame;
            else
                v22 = DescDetails.DetailsSFrame;
            end;

            local v23 = v22.SegmentTemplate:Clone();
            v23.BackgroundTransparency = #u16 % 2 == 0 and 0.96 or 0.9;
            table.insert(u16, v23);
            v23.LayoutOrder = #u16;
            v23.Visible = true;
            v23.Parent = v22;
            v23.ITEM_STAT_NAME.Text = `{p20}`;
            v23.STAT_VALUE.Text = `{p21}`;

            return;
        end;

        local v24;

        if DetailsSFrame.Visible then
            v24 = DetailsSFrame;
        else
            v24 = DescDetails.DetailsSFrame;
        end;

        local v25 = v24.SegmentTemplate:Clone();
        v25.BackgroundTransparency = #u16 % 2 == 0 and 0.96 or 0.9;
        table.insert(u16, v25);
        v25.LayoutOrder = #u16;
        v25.Visible = true;
        v25.Parent = v24;
        v25.ITEM_STAT_NAME.Text = `{p20}`;
        v25.STAT_VALUE.Text = "";

        for i, v in p21 do
            local v26;

            if DetailsSFrame.Visible then
                v26 = DetailsSFrame;
            else
                v26 = DescDetails.DetailsSFrame;
            end;

            local v27 = v26.SegmentTemplate:Clone();
            v27.BackgroundTransparency = #u16 % 2 == 0 and 0.96 or 0.9;
            table.insert(u16, v27);
            v27.LayoutOrder = #u16;
            v27.Visible = true;
            v27.Parent = v26;
            v27.ITEM_STAT_NAME.Text = `\t{i}`;
            v27.STAT_VALUE.Text = `{v}`;
        end;
    end,

    PlantMutations = function(p28: string, p29: table) -- Line: 145
        -- upvalues: DetailsSFrame (copy), DescDetails (copy), u16 (copy), MutationHandler (copy)
        if #p29 == 0 then
            return;
        end;

        if #p29 == 1 and #p29[1] == 0 then
            return;
        end;

        local v30;

        if DetailsSFrame.Visible then
            v30 = DetailsSFrame;
        else
            v30 = DescDetails.DetailsSFrame;
        end;

        local v31 = v30.SegmentTemplate:Clone();
        v31.BackgroundTransparency = #u16 % 2 == 0 and 0.96 or 0.9;
        table.insert(u16, v31);
        v31.LayoutOrder = #u16;
        v31.Visible = true;
        v31.Parent = v30;
        v31.ITEM_STAT_NAME.Text = "Mutations";
        v31.STAT_VALUE.Text = "";

        for _, v in p29 do
            local v32 = MutationHandler:GetMutations()[v];
            local v33;

            if v32 then
                v33 = v32.DisplayName or (v32.Name or v);
            else
                v33 = v;
            end;

            local v34 = v32 and v32.Color or Color3.new(1, 1, 1);
            local v35 = v32 and v32.StrokeColor or Color3.fromRGB(59, 27, 14);
            local v36 = v32 and v32.ValueMulti or 1;
            local v37;

            if DetailsSFrame.Visible then
                v37 = DetailsSFrame;
            else
                v37 = DescDetails.DetailsSFrame;
            end;

            local v38 = v37.SegmentTemplate:Clone();
            v38.BackgroundTransparency = #u16 % 2 == 0 and 0.96 or 0.9;
            table.insert(u16, v38);
            v38.LayoutOrder = #u16;
            v38.Visible = true;
            v38.Parent = v37;
            v38.ITEM_STAT_NAME.Text = `\t{v33}`;
            v38.ITEM_STAT_NAME.TextColor3 = v34;
            v38.ITEM_STAT_NAME.UIStroke.Color = v35;
            v38.STAT_VALUE.Text = `x{v36}`;
        end;
    end,

    Traits = function(p39: string, p40: table) -- Line: 169
        -- upvalues: DetailsSFrame (copy), DescDetails (copy), u16 (copy)
        if #p40 == 0 then
            return;
        end;

        if #p40 == 1 and #p40[1] == 0 then
            return;
        end;

        local v41;

        if DetailsSFrame.Visible then
            v41 = DetailsSFrame;
        else
            v41 = DescDetails.DetailsSFrame;
        end;

        local v42 = v41.SegmentTemplate:Clone();
        v42.BackgroundTransparency = #u16 % 2 == 0 and 0.96 or 0.9;
        table.insert(u16, v42);
        v42.LayoutOrder = #u16;
        v42.Visible = true;
        v42.Parent = v41;
        v42.ITEM_STAT_NAME.Text = "Traits";
        v42.STAT_VALUE.Text = "";

        for _, v in p40 do
            local v43;

            if DetailsSFrame.Visible then
                v43 = DetailsSFrame;
            else
                v43 = DescDetails.DetailsSFrame;
            end;

            local v44 = v43.SegmentTemplate:Clone();
            v44.BackgroundTransparency = #u16 % 2 == 0 and 0.96 or 0.9;
            table.insert(u16, v44);
            v44.LayoutOrder = #u16;
            v44.Visible = true;
            v44.Parent = v43;
            v44.ITEM_STAT_NAME.Text = `\t{v}`;
            v44.STAT_VALUE.Text = "";
        end;
    end,

    PetMutation = function(p45: string, p46: string) -- Line: 184
        -- upvalues: DetailsSFrame (copy), DescDetails (copy), u16 (copy), PetMutationRegistry (copy)
        local v47;

        if DetailsSFrame.Visible then
            v47 = DetailsSFrame;
        else
            v47 = DescDetails.DetailsSFrame;
        end;

        local v48 = v47.SegmentTemplate:Clone();
        v48.BackgroundTransparency = #u16 % 2 == 0 and 0.96 or 0.9;
        table.insert(u16, v48);
        v48.LayoutOrder = #u16;
        v48.Visible = true;
        v48.Parent = v47;
        v48.ITEM_STAT_NAME.Text = "Mutation";
        v48.STAT_VALUE.Text = "";
        local v49 = PetMutationRegistry.PetMutationRegistry[p46];

        if not v49 then
            return;
        end;

        local v50 = v49.Color or Color3.new(1, 1, 1);
        local Color3_fromRGB_ret = Color3.fromRGB(59, 27, 14);
        local v51 = v49.ValueMulti or 1;
        local v52;

        if DetailsSFrame.Visible then
            v52 = DetailsSFrame;
        else
            v52 = DescDetails.DetailsSFrame;
        end;

        local v53 = v52.SegmentTemplate:Clone();
        v53.BackgroundTransparency = #u16 % 2 == 0 and 0.96 or 0.9;
        table.insert(u16, v53);
        v53.LayoutOrder = #u16;
        v53.Visible = true;
        v53.Parent = v52;
        v53.ITEM_STAT_NAME.Text = `\t{p46 or ""}`;
        v53.ITEM_STAT_NAME.TextColor3 = v50;
        v53.ITEM_STAT_NAME.UIStroke.Color = Color3_fromRGB_ret;
        v53.STAT_VALUE.Text = `x{v51}`;
    end,

    FoodIngredients = function(p54: string, p55: table) -- Line: 203
        -- upvalues: DetailsSFrame (copy), DescDetails (copy), u16 (copy), SeedData (copy)
        local v56;

        if DetailsSFrame.Visible then
            v56 = DetailsSFrame;
        else
            v56 = DescDetails.DetailsSFrame;
        end;

        local v57 = v56.SegmentTemplate:Clone();
        v57.BackgroundTransparency = #u16 % 2 == 0 and 0.96 or 0.9;
        table.insert(u16, v57);
        v57.LayoutOrder = #u16;
        v57.Visible = true;
        v57.Parent = v56;
        v57.ITEM_STAT_NAME.Text = "Ingredients";
        v57.STAT_VALUE.Text = "";

        for _, v in p55 do
            local v58 = SeedData[v];

            if v58 then
                local v59 = v58.DisplayName or (v or "");
                local Color3_new_ret = Color3.new(1, 1, 1);
                local Color3_fromRGB_ret = Color3.fromRGB(59, 27, 14);
                local v60;

                if DetailsSFrame.Visible then
                    v60 = DetailsSFrame;
                else
                    v60 = DescDetails.DetailsSFrame;
                end;

                local v61 = v60.SegmentTemplate:Clone();
                v61.BackgroundTransparency = #u16 % 2 == 0 and 0.96 or 0.9;
                table.insert(u16, v61);
                v61.LayoutOrder = #u16;
                v61.Visible = true;
                v61.Parent = v60;
                v61.ITEM_STAT_NAME.Text = `\t{v59}`;
                v61.ITEM_STAT_NAME.TextColor3 = Color3_new_ret;
                v61.ITEM_STAT_NAME.UIStroke.Color = Color3_fromRGB_ret;
                v61.STAT_VALUE.Text = "";
            end;
        end;
    end
};

local function RenderProperties(p63: table) -- Line: 228
    -- upvalues: u62 (copy)
    for i, v in p63 do
        if i ~= "Rarity" then
            (u62[i] or u62.Custom)(i, v);
        end;
    end;
end;

function v17.CleanupAllSegments(p64) -- Line: 239
    -- upvalues: u16 (copy)
    for _, v in u16 do
        v:Destroy();
    end;

    table.clear(u16);
end;

function v17.RenderInfo(p65: table, p66: table) -- Line: 246
    -- upvalues: ITEM_NAME (copy), Description (copy), u8 (copy), u9 (copy), DescDetails (copy), DetailsSFrame (copy), ITEM_IMAGE (copy), ITEM_RARITY (copy), Item_Module (copy), u1 (copy), u2 (copy), RenderProperties (copy)
    ITEM_NAME.Text = p66.DisplayName;
    local Description2 = p66.Description;
    local DescLabel = Description.DescLabel;
    DescLabel.RichText = true;
    u8[DescLabel] = nil;
    u9[DescLabel] = nil;

    if string.find(Description2, "Fire Wisp", 1, true) then
        u8[DescLabel] = true;
        u9[DescLabel] = Description2;
        DescLabel.Text = Description2;
    else
        DescLabel.Text = Description2;
    end;

    local DescLabel2 = DescDetails.Description.DescLabel;
    DescLabel2.RichText = true;
    u8[DescLabel2] = nil;
    u9[DescLabel2] = nil;

    if string.find(Description2, "Fire Wisp", 1, true) then
        u8[DescLabel2] = true;
        u9[DescLabel2] = Description2;
        DescLabel2.Text = Description2;
    else
        DescLabel2.Text = Description2;
    end;

    DetailsSFrame.Visible = p66.DetailsOnly or false;
    Description.Visible = p66.DescriptionOnly or false;
    DescDetails.Visible = not (DetailsSFrame.Visible or Description.Visible);
    ITEM_IMAGE.Image = p66.ItemImage;
    local Properties = p66.Properties;
    local v67 = Properties.Rarity or "";
    ITEM_RARITY.Text = v67;
    local v68 = Properties.Rarity and Item_Module.Return_Rarity_Data(v67);

    if u1[v67] then
        u2.Enabled = true;
        ITEM_RARITY.TextColor3 = Color3.fromRGB(255, 255, 255);
    else
        u2.Enabled = false;
        local v69;

        if v68 then
            v69 = v68[2];
        else
            v69 = Color3.fromRGB(255, 255, 255);
        end;

        ITEM_RARITY.TextColor3 = v69;
    end;

    if DetailsSFrame.Visible or DescDetails.Visible then
        RenderProperties(Properties, p66.DetailsOnly);
    end;
end;

return v17;