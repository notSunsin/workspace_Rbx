-- Decompiled with Potassium's decompiler.

game:GetService("UserInputService");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local GuiService = game:GetService("GuiService");
local ProximityPromptService = game:GetService("ProximityPromptService");
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local CalculatePlantValue = require(ReplicatedStorage.Modules.CalculatePlantValue);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local VariantColors = require(ReplicatedStorage.Data.VariantColors);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local Frame = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("FruitMutation_UI"):WaitForChild("Frame");
local FruitName = Frame:WaitForChild("FruitName");
local FruitMutation = Frame:WaitForChild("FruitMutation");
local FruitValue = Frame:WaitForChild("FruitValue");
ReplicatedStorage:WaitForChild("GameEvents");
require(ReplicatedStorage.Modules.GetFarm);
local SeedData = require(ReplicatedStorage.Data.SeedData);
require(ReplicatedStorage.Modules.PlantTraitsData);
local Item_Module = require(ReplicatedStorage.Item_Module);
local _ = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Highlight = Instance.new("Highlight");
Highlight.Name = "Highlight";
Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
Highlight.FillColor = Color3.fromRGB(255, 51, 51);
Highlight.FillTransparency = 1;
Highlight.Parent = script;
local u1 = nil;
local Mutations = MutationHandler:GetMutations();
local u2 = {};
local u3 = {};

local function StartRainbowTween(u4: userdata, u5: string, u6: string) -- Line: 52
    -- upvalues: u3 (copy), RunService (copy)
    if u3[u4] then
        u3[u4]:Disconnect();
    end;

    local v7 = Color3.fromHSV(0, 1, 1):ToHex();
    u4.Text = u5:gsub("🌈", string.format("<font color=\"#%s\">%s</font>", v7, u6));
    local u8 = 0;
    u3[u4] = RunService.RenderStepped:Connect(function(p9) -- Line: 62
        -- upvalues: u8 (ref), u6 (copy), u4 (copy), u5 (copy)
        u8 = (u8 + p9 * 0.2) % 1;
        local Color3_fromHSV_ret = Color3.fromHSV(u8, 1, 1);
        u4.Text = u5:gsub("🌈", (string.format("<font color=\"#%s\">%s</font>", Color3_fromHSV_ret:ToHex(), u6)));
    end);
end;

local function StartTranscendentTween(u10: userdata, u11: string, u12: string) -- Line: 70
    -- upvalues: u3 (copy), RunService (copy)
    if u3[u10] then
        u3[u10]:Disconnect();
    end;

    local u13 = 0.75;
    u3[u10] = RunService.RenderStepped:Connect(function(p14) -- Line: 76
        -- upvalues: u13 (ref), u12 (copy), u10 (copy), u11 (copy)
        u13 = (u13 + p14 * 0.05) % 1;
        local v15 = tick() * 1.5;
        local v16 = math.sin(v15) * 0.03 + 0.72;
        local v17 = Color3.fromHSV(v16, 1, 1):ToHex();
        u10.Text = u11:gsub("💜", (string.format("<font color=\"#%s\">%s</font>", v17, u12)));
    end);
end;

local function StopAllTweens() -- Line: 86
    -- upvalues: u3 (copy)
    for _, v in pairs(u3) do
        v:Disconnect();
    end;

    table.clear(u3);
end;

local function UpdateModel(p18) -- Line: 94
    -- upvalues: u1 (ref), Highlight (copy), Frame (copy), u3 (copy), SeedData (copy), Item_Module (copy), StartRainbowTween (copy), FruitName (copy), RunService (copy), CalculatePlantValue (copy), Comma_Module (copy), FruitValue (copy), NumberUtil (copy), VariantColors (copy), Mutations (copy), FruitMutation (copy)
    if p18 == u1 then
        return;
    end;

    if p18 == nil then
        if u1 then
            Highlight.Adornee = nil;
            Frame.Visible = false;
            u1:SetAttribute("IsOutlined", nil);
            u1 = nil;

            for _, v in pairs(u3) do
                v:Disconnect();
            end;

            table.clear(u3);
        end;

        return;
    end;

    for _, v in pairs(u3) do
        v:Disconnect();
    end;

    table.clear(u3);
    u1 = p18;
    u1:SetAttribute("IsOutlined", true);

    if Highlight.Adornee ~= p18 then
        Highlight.FillTransparency = 1;
    end;

    Highlight.Adornee = p18;
    Frame.Visible = true;
    local u19 = p18:GetAttribute("DisplayName") or p18.Name;
    local v20 = SeedData[u19];

    if v20 then
        v20 = v20.SeedRarity;
    end;

    local v21;

    if v20 then
        v21 = Item_Module.Return_Rarity_Data(v20);
    else
        v21 = v20;
    end;

    if v20 == "Prismatic" then
        StartRainbowTween(FruitName, "🌈", u19);
    elseif v20 == "Transcendent" then
        local u22 = FruitName;

        if u3[u22] then
            u3[u22]:Disconnect();
        end;

        local u23 = 0.75;
        local u24 = "💜";
        u3[u22] = RunService.RenderStepped:Connect(function(p25) -- Line: 76
            -- upvalues: u23 (ref), u19 (copy), u22 (copy), u24 (copy)
            u23 = (u23 + p25 * 0.05) % 1;
            local v26 = tick() * 1.5;
            local v27 = math.sin(v26) * 0.03 + 0.72;
            local v28 = Color3.fromHSV(v27, 1, 1):ToHex();
            u22.Text = u24:gsub("💜", (string.format("<font color=\"#%s\">%s</font>", v28, u19)));
        end);
    elseif v21 then
        local v29 = v21[2]:ToHex();
        FruitName.Text = string.format("<font color=\"#%s\">%s</font>", v29, u19);
    else
        FruitName.Text = u19;
    end;

    if p18:GetAttribute("Inspected") then
        local v30 = CalculatePlantValue(p18);
        Comma_Module.Comma(v30);
        FruitValue.Text = NumberUtil.DisplaySheckles(v30);
    else
        FruitValue.Text = "";
    end;

    FruitValue.Visible = FruitValue.Text ~= "";
    local v31 = nil;
    local v32 = nil;
    local Variant = p18:FindFirstChild("Variant");
    local v33;

    if Variant and Variant:IsA("StringValue") then
        v33 = Variant.Value;

        if v33 == "" or v33 == "Normal" then
            v33 = v31;
        else
            v32 = VariantColors:GetHex(v33);
        end;
    else
        v33 = v31;
    end;

    local v34 = {};

    for i, v in pairs(Mutations) do
        if p18:GetAttribute(i) then
            local v35 = {
                Name = v.DisplayName or v.Name,
                Color = v.Color and `{v.Color:ToHex()}` or "FFFFFF"
            };
            table.insert(v34, v35);
        end;
    end;

    local v36 = {};

    if v33 then
        if v33 == "Rainbow" then
            table.insert(v36, "🌈");
        else
            table.insert(v36, string.format("<font color=\"%s\">%s</font>", v32, v33));
        end;
    end;

    for _, v in ipairs(v34) do
        table.insert(v36, string.format("<font color=\"#%s\">%s</font>", v.Color, v.Name));
    end;

    if #v36 > 0 then
        local table_concat_ret = table.concat(v36, " <font color=\"#FFFFFF\">+</font> ");
        FruitMutation.Text = table_concat_ret;
        FruitMutation.Visible = true;

        if v33 == "Rainbow" then
            StartRainbowTween(FruitMutation, table_concat_ret, "Rainbow");
        end;
    else
        FruitMutation.Visible = false;
    end;

    if #v34 > 0 then
        Highlight.FillColor = Color3.fromHex(v34[1].Color);

        return;
    end;

    if v32 then
        Highlight.FillColor = Color3.fromHex(v32);

        return;
    end;

    Highlight.FillColor = Color3.new(1, 1, 1);
end;

ProximityPromptService.PromptShown:Connect(function(p37: userdata, p38: any) -- Line: 220
    -- upvalues: UpdateModel (copy)
    local v39 = p37:FindFirstAncestorWhichIsA("Model");

    if not (v39 and v39:HasTag("Harvestable")) then
        return;
    end;

    if p37:HasTag("TendProximityPrompt") then
        return;
    end;

    p37.ActionText = "Collect";
    p37.HoldDuration = 0;
    UpdateModel(v39);
end);
ProximityPromptService.PromptHidden:Connect(function(p40: userdata) -- Line: 237
    -- upvalues: u1 (ref), Highlight (copy), Frame (copy), u3 (copy)
    local v41 = p40:FindFirstAncestorWhichIsA("Model");

    if v41 and (v41:HasTag("Harvestable") and u1 == v41) then
        if u1 == nil then
            return;
        end;

        if u1 then
            Highlight.Adornee = nil;
            Frame.Visible = false;
            u1:SetAttribute("IsOutlined", nil);
            u1 = nil;

            for _, v in pairs(u3) do
                v:Disconnect();
            end;

            table.clear(u3);
        end;
    end;
end);

function u2.GetActivePrompt(p42) -- Line: 244
    -- upvalues: u1 (ref)
    if not u1 then
        return nil;
    end;

    for _, descendant in u1:GetDescendants() do
        if descendant:IsA("ProximityPrompt") and (descendant.Enabled and not descendant:HasTag("TendProximityPrompt")) then
            return descendant;
        end;
    end;

    return nil;
end;

RunService.RenderStepped:Connect(function() -- Line: 259
    -- upvalues: u1 (ref), Frame (copy), u2 (copy), workspace_CurrentCamera (copy), GuiService (copy)
    if not u1 then
        Frame.Visible = false;

        return;
    end;

    local ActivePrompt = u2:GetActivePrompt();

    if not (ActivePrompt and ActivePrompt.Parent:IsA("BasePart")) then
        Frame.Visible = false;

        return;
    end;

    local v43, v44 = workspace_CurrentCamera:WorldToViewportPoint(ActivePrompt.Parent.Position);

    if not v44 then
        Frame.Visible = false;

        return;
    end;

    Frame.Position = UDim2.new(0, v43.X, 0, v43.Y + GuiService.TopbarInset.Height);
    Frame.Visible = true;
end);

return u2;