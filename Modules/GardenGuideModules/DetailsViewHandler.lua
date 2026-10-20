-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("GuiService");
require(script.Parent.GGAnimateColor);
local ImageCycle = require(script.Parent.ImageCycle);
local GGStaticData = require(script.Parent.DataModules.GGStaticData);
local GGData = require(script.Parent.DataModules.GGData);
local CropMasteryData = require(ReplicatedStorage.Data.CropMasteryData);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Data.SeasonPass.SeasonPassData);
local Templates = script.Parent.Templates;
local DetailsTemplates = Templates.DetailsTemplates;
local BroadIngrTemplate = Templates.RecipeTemplates.BroadIngrTemplate;
local SpecificIngrTemplate = Templates.RecipeTemplates.SpecificIngrTemplate;
local IngredientTemplate = Templates.RecipeTemplates.IngredientTemplate;
local u1 = {};

local function IsLightColor(p2: string) -- Line: 23
    local string_split_ret = string.split(p2, ",");

    if #string_split_ret < 3 then
        warn("Invalid RGB string format. Expected \'R,G,B\'");

        return false;
    end;

    local v3 = tonumber(string_split_ret[1]) or 0;
    local v4 = tonumber(string_split_ret[2]) or 0;
    local v5 = tonumber(string_split_ret[3]) or 0;

    return 0.299 * v3 + 0.587 * v4 + 0.114 * v5 > 186;
end;

local function MainStats(p6: table, p7: userdata) -- Line: 41
    -- upvalues: GGStaticData (copy)
    local Main = p7:FindFirstChild("MainStats"):FindFirstChild("Main");
    Main:FindFirstChild("ImageFrame"):FindFirstChild("ITEM_IMAGE").Image = p6.ImageId;

    for _, child in Main:FindFirstChild("Stats"):GetChildren() do
        if child:IsA("Frame") then
            local STAT_VALUE = child:FindFirstChild("STAT_VALUE");

            if child.Name == "Rarity" then
                local Rarity = p6.Rarity;
                STAT_VALUE:SetAttribute("Rarity", Rarity);

                if GGStaticData.AnimatedColors[Rarity] then
                    GGStaticData.AnimatedColors[Rarity](STAT_VALUE);
                else
                    STAT_VALUE.TextColor3 = GGStaticData.RarityColorMap[Rarity] or Color3.fromRGB(255, 255, 255);
                end;
            end;

            local STAT_VALUE_SHADOW = child:FindFirstChild("STAT_VALUE_SHADOW");
            local v8 = `{p6[child.Name]}`;
            STAT_VALUE.Text = v8;
            STAT_VALUE_SHADOW.Text = v8;
        end;
    end;
end;

local function UpdateCropMastery(p9: table, p10: userdata) -- Line: 72
    -- upvalues: CropMasteryData (copy), UserInputService (copy)
    local MasteryProgress = p9.MasteryProgress;
    local MasteryLevel = p9.MasteryLevel;
    local MaxMasteryLevel = CropMasteryData.MaxMasteryLevel;
    local Multipliers = CropMasteryData:GetMultipliers(p9.Name, MasteryLevel);
    local CropMastery = p10:FindFirstChild("CropMastery");
    CropMastery.Visible = true;

    for _, child in CropMastery:FindFirstChild("Content"):GetChildren() do
        if child:IsA("Frame") then
            local STAT_VALUE = child:FindFirstChild("STAT_VALUE");
            local STAT_VALUE_SHADOW = child:FindFirstChild("STAT_VALUE_SHADOW");
            STAT_VALUE.Text = `x{Multipliers[child.Name]}`;
            STAT_VALUE_SHADOW.Text = `x{Multipliers[child.Name]}`;
        end;
    end;

    CropMastery:FindFirstChild("Level"):FindFirstChild("LEVEL_VALUE").Text = `{MasteryLevel}`;
    local MasteryProgBar = CropMastery:FindFirstChild("MasteryProgBar");
    local Bar_Actual = MasteryProgBar:FindFirstChild("Bar_Actual");
    local PROGRESS = MasteryProgBar:FindFirstChild("PROGRESS");
    Bar_Actual.Size = UDim2.fromScale(MasteryProgress % 1, 1);
    PROGRESS.Text = `{math.round(MasteryProgress % 1 * 100)}%`;

    if MasteryLevel == MaxMasteryLevel then
        Bar_Actual.Size = UDim2.fromScale(1, 1);
        PROGRESS.Text = "FULL MASTERY";
    end;

    local Hover = CropMastery:FindFirstChild("Hover");
    local Button = CropMastery:FindFirstChild("Info"):FindFirstChild("Button");
    local u11 = Button.Activated:Connect(function() -- Line: 113
        -- upvalues: UserInputService (ref), Hover (copy)
        if UserInputService.TouchEnabled then
            Hover.Visible = not Hover.Visible;
        end;
    end);
    local u12 = Button.MouseEnter:Connect(function() -- Line: 119
        -- upvalues: Hover (copy)
        Hover.Visible = true;
    end);
    local u13 = Button.MouseLeave:Connect(function() -- Line: 123
        -- upvalues: Hover (copy)
        Hover.Visible = false;
    end);
    Button.Destroying:Once(function() -- Line: 126
        -- upvalues: u12 (ref), u13 (ref), u11 (ref)
        if u12 then
            u12:Disconnect();
        end;

        u12 = nil;

        if u13 then
            u13:Disconnect();
        end;

        u13 = nil;

        if u11 then
            u11:Disconnect();
        end;

        u11 = nil;
    end);
end;

local function PlantSpecificDetails(p14: table, p15: any) -- Line: 138
    -- upvalues: UpdateCropMastery (copy)
    local Traits = p15:FindFirstChild("MainStats"):FindFirstChild("Main"):FindFirstChild("Traits");
    local STAT_VALUE = Traits:FindFirstChild("Stats"):FindFirstChild("STAT_VALUE");
    local STAT_VALUE_SHADOW = Traits:FindFirstChild("Stats"):FindFirstChild("STAT_VALUE_SHADOW");
    local v16 = `{p14.Traits}`;
    local v17 = v16:gsub("<[^>]->", "");
    STAT_VALUE.Text = v16;
    STAT_VALUE_SHADOW.Text = v17;

    for _, child in p15:FindFirstChild("ExtraStats"):FindFirstChild("Content"):GetChildren() do
        if child:IsA("Frame") then
            local STAT_VALUE2 = child:FindFirstChild("STAT_VALUE");
            local STAT_VALUE_SHADOW2 = child:FindFirstChild("STAT_VALUE_SHADOW");
            local v18 = p14[`{child.Name}Count`];
            STAT_VALUE2.Text = v18;
            STAT_VALUE_SHADOW2.Text = v18;
        end;
    end;

    UpdateCropMastery(p14, p15);
end;

local function IngredientsDisplay(p19: table, p20: any, p21: any, p22: any) -- Line: 164
    -- upvalues: SpecificIngrTemplate (copy), DataService (copy), SeedData (copy), ImageCycle (copy), GGData (copy), IsLightColor (copy), BroadIngrTemplate (copy), IngredientTemplate (copy)
    local IngredientsList = p20:FindFirstChild("KnownRecipes"):FindFirstChild("Main"):FindFirstChild("IngredientsList");
    local RecipeData = p19.RecipeData;

    for _, v in RecipeData.SpecificIngr do
        if not IngredientsList:FindFirstChild(v.Name) then
            local v23 = SpecificIngrTemplate:Clone();
            v23.Parent = IngredientsList;
            v23.Name = v.Name;
            local v24;

            if v.Name == "Any Plant" then
                local PlantData = DataService:GetData().GardenGuide.PlantData;

                if not PlantData then
                    warn("ImageCycle | No Player PlantData");

                    return;
                end;

                v24 = v;
                local v25 = {};

                for i, _ in PlantData do
                    if SeedData[i] then
                        table.insert(v25, {
                            Type = "Fruit",
                            Quantity = 1,
                            DisplayName = i,
                            Value = i
                        });
                    end;
                end;

                ImageCycle.CycleRewardImages(v23.INGREDIENT_IMAGE, nil, nil, p22, v25);
            else
                v23.INGREDIENT_IMAGE.Image = v.ImageId;
                v24 = v;
            end;

            local ItemName = v23.ItemName;
            local TITLE = ItemName.TITLE;
            local TITLE_SHADOW = ItemName.TITLE_SHADOW;
            local v26 = v24.Name:gsub("(%l)(%u)", "%1 %2");
            TITLE.Text = v26;
            TITLE_SHADOW.Text = v26;

            if p21 == "Mutation" then
                TITLE.TextTransparency = 0;
                local Color = GGData.Mutation.Data[v24.Name].Color;
                TITLE.TextColor3 = Color;

                if not IsLightColor((string.format("(%d, %d, %d)", Color.R * 255, Color.G * 255, Color.B * 255))) then
                    TITLE:FindFirstChild("UIStroke").Color = Color:Lerp(Color3.fromRGB(255, 255, 255), 0.85);
                end;
            end;
        end;
    end;

    for i, v in RecipeData.BroadIngr do
        local v27 = IngredientsList:FindFirstChild(i);

        if not v27 then
            v27 = BroadIngrTemplate:Clone();
            v27.Parent = IngredientsList;
            v27.Name = i;
        end;

        local Content = v27.ScrollingFrame.Content;
        local ItemName = v27.ItemName;
        local TITLE_SHADOW = ItemName.TITLE_SHADOW;
        ItemName.TITLE.Text = i;
        TITLE_SHADOW.Text = i;

        for _, v2 in v do
            if not Content:FindFirstChild(v2) then
                local v28 = IngredientTemplate:Clone();
                v28.Parent = Content;
                v28.Name = v2;
                local ITEM_NAME = v28.ITEM_NAME;
                local ITEM_NAME_SHADOW = v28.ITEM_NAME_SHADOW;
                local v29 = v2:gsub("(%l)(%u)", "%1 %2");
                ITEM_NAME.Text = v29;
                ITEM_NAME_SHADOW.Text = v29;

                if p21 == "Mutation" then
                    ITEM_NAME.TextTransparency = 0;
                    local Color = GGData.Mutation.Data[v2].Color;
                    ITEM_NAME.TextColor3 = Color;

                    if not IsLightColor((string.format("(%d, %d, %d)", Color.R * 255, Color.G * 255, Color.B * 255))) then
                        ITEM_NAME:FindFirstChild("UIStroke").Color = Color:Lerp(Color3.fromRGB(255, 255, 255), 0.85);
                    end;
                end;
            end;
        end;
    end;
end;

local function MutationSpecificDetails(p30: table, p31: userdata, p32: userdata) -- Line: 265
    local Stats = p31:FindFirstChild("MainStats"):FindFirstChild("Main"):FindFirstChild("Stats");
    local KnownRecipes = p31:FindFirstChild("KnownRecipes");
    local Main = KnownRecipes:FindFirstChild("Main");

    if p30.ComboType == "No Combo" then
        KnownRecipes.Visible = false;
        p32.CanvasSize = UDim2.fromScale(0, 1);
    else
        local Item = Main:FindFirstChild("Item");
        local TITLE = Item:FindFirstChild("TITLE");
        local TITLE_SHADOW = Item:FindFirstChild("TITLE_SHADOW");
        local v33 = `{p30.ComboType}`;
        TITLE.Text = v33;
        TITLE_SHADOW.Text = v33;
    end;

    local ValueMultis = p30.ValueMultis;

    if ValueMultis then
        for _, child in Stats:GetChildren() do
            if child:IsA("Frame") and string.find(child.Name, "ValueMulti") then
                local v34 = ValueMultis[child.Name:gsub("ValueMulti", "")] or "-";
                local STAT_VALUE = child:FindFirstChild("STAT_VALUE");
                local STAT_VALUE_SHADOW = child:FindFirstChild("STAT_VALUE_SHADOW");
                STAT_VALUE.Text = v34;
                STAT_VALUE_SHADOW.Text = v34;
            end;
        end;
    end;

    for _, child in p31:FindFirstChild("ExtraStats"):FindFirstChild("Content"):GetChildren() do
        if child:IsA("Frame") then
            local STAT_VALUE = child:FindFirstChild("STAT_VALUE");
            local STAT_VALUE_SHADOW = child:FindFirstChild("STAT_VALUE_SHADOW");
            local v35 = p30[`{child.Name}Count`];
            STAT_VALUE.Text = v35;
            STAT_VALUE_SHADOW.Text = v35;
        end;
    end;
end;

local function DescriptionDetails(p36, p37) -- Line: 311
    local Desc = p37:FindFirstChild("Desc");
    local Main = Desc:FindFirstChild("Main");

    if p36.Description == "" then
        Desc.Visible = false;
    end;

    local ABILITY = Main:FindFirstChild("ABILITY");
    local ABILITY_SHADOW = Main:FindFirstChild("ABILITY_SHADOW");
    ABILITY.Text = p36.Description;
    ABILITY_SHADOW.Text = p36.Description;
end;

local function RecordsDisplay(p38, p39) -- Line: 326
    local v40 = 1;

    for _, child in p39:FindFirstChild("BestRecords"):FindFirstChild("Main"):GetChildren() do
        if child:IsA("Frame") then
            local HIGHLIGHT_NAME = child:FindFirstChild("HIGHLIGHT_NAME");
            local HIGHLIGHT_NAME_SHADOW = child:FindFirstChild("HIGHLIGHT_NAME_SHADOW");
            local RecordName = p38.Records[v40].RecordName;
            HIGHLIGHT_NAME.Text = RecordName;
            HIGHLIGHT_NAME_SHADOW.Text = RecordName;
            local HIGHLIGHT_VALUE = child:FindFirstChild("HIGHLIGHT_VALUE");
            local HIGHLIGHT_VALUE_SHADOW = child:FindFirstChild("HIGHLIGHT_VALUE_SHADOW");
            local _ = p38.Records[v40].RecordData;
            local v41 = `{p38.Records[v40].RecordData}`;
            HIGHLIGHT_VALUE.Text = v41;
            HIGHLIGHT_VALUE_SHADOW.Text = v41;
            local DATE = child:FindFirstChild("DATE");
            local DATE_SHADOW = child:FindFirstChild("DATE_SHADOW");
            local v42 = `Achieved on {p38.Records[v40].RecordDate}`;
            DATE.Text = v42;
            DATE_SHADOW.Text = v42;
            v40 = v40 + 1;
        end;
    end;
end;

function u1.CreateDetailsView(p43: userdata, p44: table, p45: string) -- Line: 354
    -- upvalues: DetailsTemplates (copy), MainStats (copy), PlantSpecificDetails (copy), MutationSpecificDetails (copy), IngredientsDisplay (copy), DescriptionDetails (copy), RecordsDisplay (copy)
    local v46 = DetailsTemplates:FindFirstChild((`{p45}DetailsTemplate`));

    if not v46 then
        warn((`No template w/ name {`{p45}DetailsTemplate`}`));

        return nil;
    end;

    local v47 = p43:FindFirstChild((`{p44.Name}Details`));

    if not v47 then
        v47 = v46:Clone();
        v47.Name = `{p44.Name}Details`;
    end;

    local ScrollingFrame = v47:FindFirstChild("ScrollingFrame");
    local Content = ScrollingFrame:FindFirstChild("Content");
    task.spawn(MainStats, p44, Content);

    if p45 == "Plant" then
        task.spawn(PlantSpecificDetails, p44, Content);
    end;

    if p45 == "Mutation" then
        task.spawn(MutationSpecificDetails, p44, Content, ScrollingFrame);
        task.spawn(IngredientsDisplay, p44, Content, p45, v47);
    end;

    if p45 == "Food" then
        task.spawn(IngredientsDisplay, p44, Content, p45, v47);
    end;

    if p45 == "Pet" or (p45 == "Cosmetic" or p45 == "Plant") then
        task.spawn(DescriptionDetails, p44, Content);
    end;

    if p44.Records then
        task.spawn(RecordsDisplay, p44, Content);
    end;

    v47.Parent = p43;

    return v47;
end;

function u1.UpdateDetailsView(p48: userdata, p49: any, p50: any) -- Line: 406
    -- upvalues: u1 (copy)
    u1.CreateDetailsView(p48.Parent, p49, p50);
end;

return u1;