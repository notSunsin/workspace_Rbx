-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
game:GetService("CollectionService");
game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Modules = ReplicatedStorage:WaitForChild("Modules");
require(Modules:WaitForChild("TimeHelper"));
local PlantHover_UI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PlantHover_UI");
local Frame = PlantHover_UI:WaitForChild("Frame");
local PlantName = Frame:WaitForChild("PlantName");
local PlantInfo = Frame:WaitForChild("PlantInfo");
local FertInfo = Frame:WaitForChild("FertInfo");
local PlantValue = Frame:WaitForChild("PlantValue");
local PlantMuts = Frame:WaitForChild("PlantMuts");
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
local GrowableData = require(ReplicatedStorage.Data.GrowableData);
require(ReplicatedStorage.Modules.NumberUtil);
local Trove = require(ReplicatedStorage.Modules.Trove);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local Item_Module = require(ReplicatedStorage.Item_Module);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local CalculatePlantValue = require(ReplicatedStorage.Modules.CalculatePlantValue);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local VariantColors = require(ReplicatedStorage.Data.VariantColors);
local DataService = require(ReplicatedStorage.Modules.DataService);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local Signal = require(ReplicatedStorage.Modules.Signal);
require(ReplicatedStorage.Modules.Chalk);
local InfGrowPlantData = require(ReplicatedStorage.Data.InfGrowPlantData);
local Mutations = MutationHandler:GetMutations();
local script_Range = script.Range;
local u1 = nil;
local u2 = {};
local u3 = {
    ["Weeping Branch"] = Vector3.new(70, 0.1, 70),
    ["Great Pumpkin"] = Vector3.new(70, 0.1, 70),
    ["Severed Spine"] = Vector3.new(20, 0.1, 20),
    ["Trinity Fruit"] = Vector3.new(60, 0.1, 60),
    ["Four Leaf Clover"] = Vector3.new(60, 0.1, 60),
    ["Peppermint Vine"] = Vector3.new(50, 0.1, 50),
    ["Spirit Sparkle"] = Vector3.new(50, 0.1, 50),
    ["Reindeer Root"] = Vector3.new(60, 0.1, 60),
    ["Sparkle Slice"] = Vector3.new(50, 0.1, 50),
    ["Colorpop Crop"] = Vector3.new(50, 0.1, 50),
    ["Kernel Curl"] = Vector3.new(70, 0.1, 70),
    ["Bonanza Bloom"] = Vector3.new(70, 0.1, 70),
    ["Elder Candy Blossom"] = Vector3.new(70, 0.1, 70),
    Pollenvine = Vector3.new(70, 0.1, 70),
    ["Honey Pollenvine"] = Vector3.new(70, 0.1, 70),
    ["Firefly Spiral"] = Vector3.new(70, 0.1, 70),
    ["Tiki Totem"] = Vector3.new(70, 0.1, 70),
    ["Moongrain Meadow"] = Vector3.new(70, 0.1, 70),
    ["Aurum Spire"] = Vector3.new(70, 0.1, 70),
    ["Scarlet Aspen"] = Vector3.new(70, 0.1, 70),
    Dracuvine = Vector3.new(70, 0.1, 70)
};
local u4 = {
    CurrentPlant = nil,
    OnCurrentPlantChange = Signal.new()
};
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 75
    -- upvalues: workspace_CurrentCamera (copy)
    workspace.CurrentCamera = workspace_CurrentCamera;
end);
local GetMouseToWorld = require(ReplicatedStorage.Modules.GetMouseToWorld);
local u5 = nil;
local u6 = {};
local u7 = {};
local u8 = workspace:GetAttribute("CurrentWeatherEvent") or "Default";
local DataForWeather = GrowableData:GetDataForWeather(u8);
workspace:GetAttributeChangedSignal("CurrentWeatherEvent"):Connect(function() -- Line: 93
    -- upvalues: u8 (ref), DataForWeather (ref), GrowableData (copy)
    u8 = workspace:GetAttribute("CurrentWeatherEvent") or "Default";
    DataForWeather = GrowableData:GetDataForWeather(u8);
end);
local RaycastParams_new_ret = RaycastParams.new();
local u9 = false;
local u10 = {};

local function UpdateRaycastParams() -- Line: 104
    -- upvalues: u9 (ref), u10 (copy), u2 (copy), RaycastParams_new_ret (copy)
    u9 = false;
    table.clear(u10);

    for i in u2 do
        table.insert(u10, i);
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = u10;
end;

RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
u9 = false;
table.clear(u10);

for i in u2 do
    table.insert(u10, i);
end;

RaycastParams_new_ret.FilterDescendantsInstances = u10;

local function Color3ToHex(p11) -- Line: 117
    return string.format("#%02X%02X%02X", p11.R * 255, p11.G * 255, p11.B * 255);
end;

local function RoundToDP(p12: number, p13: number) -- Line: 121
    return math.round(p12 * 10 ^ p13) / 10 ^ p13;
end;

local function FloorToDP(p14: number, p15: number) -- Line: 125
    local v16 = 10 ^ p15;

    return math.floor(p14 * v16) / v16;
end;

CreateTagHandler({
    Tag = "Growable",

    OnInstanceAdded = function(p17) -- Line: 133, Name: OnInstanceAdded
        -- upvalues: u2 (copy), u9 (ref), UpdateRaycastParams (copy)
        if not p17:IsDescendantOf(workspace) then
            return;
        end;

        u2[p17] = true;

        if not u9 then
            u9 = true;
            task.delay(0.25, UpdateRaycastParams);
        end;
    end,

    OnInstanceRemoved = function(p18) -- Line: 144, Name: OnInstanceRemoved
        -- upvalues: u2 (copy), u6 (copy), u7 (copy), u9 (ref), UpdateRaycastParams (copy)
        u2[p18] = nil;
        u6[p18] = nil;
        u7[p18] = nil;

        if not u9 then
            u9 = true;
            task.delay(0.25, UpdateRaycastParams);
        end;
    end
});
local u19 = false;
local u20 = Trove.new();

local function GetGrowSpeedMulti(p21: userdata) -- Line: 161
    -- upvalues: DataForWeather (ref)
    local v22 = p21:GetAttribute("TendablePlantGrowRateMulti") or (p21:GetAttribute("GrowRateMulti") or 1);
    local v23 = p21:GetAttribute("MasteryGrowthMulti") or 1;
    local v24 = workspace:GetAttribute("MegaHarvest") and 2 or 1;
    local v25 = workspace:GetAttribute("HarvestMoon") and 2 or 1;

    return v22 * DataForWeather.GrowRateMulti * v23 * v24 * v25;
end;

local function GetGrowTimeLeft(p26: userdata) -- Line: 170
    -- upvalues: u7 (copy)
    return math.max(0, u7[p26] or 0);
end;

local function UpdateTimeLeft(p27) -- Line: 181
    -- upvalues: GrowableData (copy), u7 (copy), u6 (copy)
    if not p27 then
        return;
    end;

    local DataForPlant = GrowableData:GetDataForPlant(p27);

    if not DataForPlant then
        return;
    end;

    local Grow = p27:WaitForChild("Grow", 1);
    local v28;

    if Grow then
        v28 = Grow:WaitForChild("Age", 1);
    else
        v28 = nil;
    end;

    if not v28 then
        return;
    end;

    local GrowTickTime = DataForPlant.GrowTickTime;
    local Attribute = p27:GetAttribute("MaxAge");
    local v29 = (Attribute or 1) - v28.Value;
    local v30 = Random.new(p27.Item_Seed.Value):NextNumber() * (GrowTickTime.Max - GrowTickTime.Min) + GrowTickTime.Min;
    local v31 = math.ceil(v29 / DataForPlant.GrowRate) * v30;
    local v32 = u7[p27];

    if v32 and Attribute then
        u7[p27] = math.min(v32, v31);
    elseif Attribute then
        u7[p27] = v31;
    end;

    u6[p27] = nil;
end;

ReplicatedStorage.GameEvents.Plant.Update.OnClientEvent:Connect(function(p33) -- Line: 237
    -- upvalues: u19 (ref), u5 (ref), UpdateTimeLeft (copy)
    if not u19 then
        return;
    end;

    if p33 ~= u5 then
        return;
    end;

    pcall(UpdateTimeLeft, p33);
end);

local function StartABGrowTimer() -- Line: 250
    -- upvalues: u19 (ref), u5 (ref), u7 (copy), UpdateTimeLeft (copy), GetGrowSpeedMulti (copy), u20 (copy), RunService (copy)
    if u19 then
        return;
    end;

    u19 = true;
    local u34 = 0;
    u20:Add(RunService.PostSimulation:Connect(function(p35: number) -- Line: 258, Name: UpdateTimer
        -- upvalues: u34 (ref), u5 (ref), u7 (ref), UpdateTimeLeft (ref), GetGrowSpeedMulti (ref)
        u34 = u34 + p35;

        if u34 < 0.2 then
            return;
        end;

        local v36 = u34;
        u34 = 0;
        local v37 = u5;

        if not (v37 and v37.Parent) then
            return;
        end;

        local v38 = u7[v37];

        if v38 then
            if v38 <= 0 then
                return;
            end;

            local v39 = u7;
            v39[v37] = v39[v37] - v36 * GetGrowSpeedMulti(v37);

            return;
        end;

        local Grow = v37:FindFirstChild("Grow");

        if Grow then
            Grow = Grow:FindFirstChild("Age");
        end;

        if Grow and v37:GetAttribute("MaxAge") then
            UpdateTimeLeft(v37);
        end;
    end));
end;

if not u19 then
    u19 = true;
    local u40 = 0;
    u20:Add(RunService.PostSimulation:Connect(function(p41: number) -- Line: 258, Name: UpdateTimer
        -- upvalues: u40 (ref), u5 (ref), u7 (copy), UpdateTimeLeft (copy), GetGrowSpeedMulti (copy)
        u40 = u40 + p41;

        if u40 < 0.2 then
            return;
        end;

        local v42 = u40;
        u40 = 0;
        local v43 = u5;

        if not (v43 and v43.Parent) then
            return;
        end;

        local v44 = u7[v43];

        if v44 then
            if v44 <= 0 then
                return;
            end;

            local v45 = u7;
            v45[v43] = v45[v43] - v42 * GetGrowSpeedMulti(v43);

            return;
        end;

        local Grow = v43:FindFirstChild("Grow");

        if Grow then
            Grow = Grow:FindFirstChild("Age");
        end;

        if Grow and v43:GetAttribute("MaxAge") then
            UpdateTimeLeft(v43);
        end;
    end));
end;

local u46 = 0;
local u47 = false;
GuiService:GetGuiInset();

local function FindPlantModel(p48: userdata) -- Line: 305
    while p48 and p48 ~= workspace do
        if p48:IsA("Model") and p48:HasTag("Growable") then
            return p48;
        end;

        p48 = p48:FindFirstAncestorWhichIsA("Model");
    end;

    return nil;
end;

local u49 = {};

local function StartRainbowTween(u50: userdata, u51: string, u52: string) -- Line: 319
    -- upvalues: u49 (copy), RunService (copy)
    if u49[u50] then
        u49[u50]:Disconnect();
    end;

    local u53 = 0;
    local Color3_fromHSV_ret = Color3.fromHSV(u53, 1, 1);
    local v54 = Color3_fromHSV_ret;
    local string_format_ret = string.format("#%02X%02X%02X", v54.R * 255, v54.G * 255, v54.B * 255);
    local string_format_ret2 = string.format("<font color=\"#%s\">%s</font>", string_format_ret, u52);
    u50.Text = u51:gsub("🌈", string_format_ret2);
    u49[u50] = RunService.RenderStepped:Connect(function(p55) -- Line: 330
        -- upvalues: u53 (ref), Color3_fromHSV_ret (ref), string_format_ret (ref), string_format_ret2 (ref), u52 (copy), u50 (copy), u51 (copy)
        u53 = (u53 + p55 * 0.2) % 1;
        Color3_fromHSV_ret = Color3.fromHSV(u53, 1, 1);
        local v56 = Color3_fromHSV_ret;
        string_format_ret = string.format("#%02X%02X%02X", v56.R * 255, v56.G * 255, v56.B * 255);
        string_format_ret2 = string.format("<font color=\"#%s\">%s</font>", string_format_ret, u52);
        u50.Text = u51:gsub("🌈", string_format_ret2);
    end);
end;

local function StopAllRainbowTweens() -- Line: 339
    -- upvalues: u49 (copy)
    for _, v in pairs(u49) do
        v:Disconnect();
    end;

    table.clear(u49);
end;

local function StartTranscendentTween(u57: userdata, u58: string, u59: string) -- Line: 346
    -- upvalues: u49 (copy), RunService (copy)
    if u49[u57] then
        u49[u57]:Disconnect();
    end;

    local Color3_fromHSV_ret = Color3.fromHSV(0.72, 1, 1);
    local v60 = Color3_fromHSV_ret;
    local string_format_ret = string.format("#%02X%02X%02X", v60.R * 255, v60.G * 255, v60.B * 255);
    local string_format_ret2 = string.format("<font color=\"#%s\">%s</font>", string_format_ret, u59);
    u57.Text = u58:gsub("💜", string_format_ret2);
    u49[u57] = RunService.RenderStepped:Connect(function() -- Line: 357
        -- upvalues: Color3_fromHSV_ret (ref), string_format_ret (ref), string_format_ret2 (ref), u59 (copy), u57 (copy), u58 (copy)
        local v61 = tick() * 1.5;
        local v62 = math.sin(v61) * 0.03 + 0.72;
        Color3_fromHSV_ret = Color3.fromHSV(v62, 1, 1);
        local v63 = Color3_fromHSV_ret;
        string_format_ret = string.format("#%02X%02X%02X", v63.R * 255, v63.G * 255, v63.B * 255);
        string_format_ret2 = string.format("<font color=\"#%s\">%s</font>", string_format_ret, u59);
        u57.Text = u58:gsub("💜", string_format_ret2);
    end);
end;

local function UpdateFertInfo(p64: userdata) -- Line: 367
    -- upvalues: DataService (copy), Players (copy), NumberUtil (copy), FertInfo (copy), u49 (copy), VariantColors (copy)
    local Item_Seed = p64:FindFirstChild("Item_Seed");
    local v65 = `{Item_Seed and Item_Seed.Value or 0}-{p64.Name}`;
    local Data = DataService:GetData(Players);
    local v66 = Data and Data.Fertilizer and Data.Fertilizer.FertilizedPlants;
    local v67 = nil;
    local v68 = nil;

    if v66 then
        v66 = v66[v65];
    end;

    if v66 then
        v67 = v66.NewVarient;
        local v69 = (v66.EndTime or 0) - workspace:GetServerTimeNow();
        local math_max_ret = math.max(0, v69);
        v68 = math_max_ret > 0 and math_max_ret and math_max_ret or nil;
    end;

    FertInfo.Text = not (v67 and v68) and "" or `{v67} 🧪 {NumberUtil.compactFormat(v68)}`;
    FertInfo.Visible = FertInfo.Text ~= "";

    if v67 ~= "Rainbow" then
        if u49[FertInfo] then
            u49[FertInfo]:Disconnect();
            u49[FertInfo] = nil;
        end;

        if v67 then
            FertInfo.TextColor3 = VariantColors:GetColor3(v67) or FertInfo.TextColor3;
        end;
    end;

    return v67;
end;

RunService.PostSimulation:Connect(function(p70: number) -- Line: 410, Name: HoverLoop
    -- upvalues: UserInputService (copy), PlantHover_UI (copy), u46 (ref), GetMouseToWorld (copy), RaycastParams_new_ret (copy), FindPlantModel (copy), u47 (ref), Frame (copy), u5 (ref), u4 (copy), u49 (copy), u1 (ref), UpdateFertInfo (copy), UpdateTimeLeft (copy), u7 (copy), PlantInfo (copy), NumberUtil (copy), InfGrowPlantData (copy), FertInfo (copy), RunService (copy), SeedData (copy), Item_Module (copy), StartRainbowTween (copy), PlantName (copy), StartTranscendentTween (copy), CalculatePlantValue (copy), Comma_Module (copy), PlantValue (copy), VariantColors (copy), Mutations (copy), PlantMuts (copy), u3 (copy), script_Range (copy)
    local MouseLocation = UserInputService:GetMouseLocation();
    PlantHover_UI.Frame.Position = UDim2.new(0.01, MouseLocation.X, 0, MouseLocation.Y);
    u46 = u46 + p70;

    if u46 < 0.1 then
        return;
    end;

    u46 = 0;
    local v71 = GetMouseToWorld(RaycastParams_new_ret, 1000);
    local v72 = nil;

    if v71 and v71.Instance then
        local Instance = v71.Instance;
        local v73 = FindPlantModel(Instance);

        if v73:GetAttribute("Inspected") or not Instance:FindFirstAncestor("Fruits") then
            v72 = v73;
        end;
    end;

    if v72 and v72:GetAttribute("IsOutlined") then
        v72 = nil;
    end;

    if not v72 then
        if u47 then
            u47 = false;
            Frame.Show_Val.Value = false;
            Frame.Visible = false;

            if u5 then
                u5 = nil;
                u4.CurrentPlant = nil;
                u4.OnCurrentPlantChange:Fire(nil);
            end;

            for _, v in pairs(u49) do
                v:Disconnect();
            end;

            table.clear(u49);
        end;

        if u1 then
            u1:Destroy();
            u1 = nil;
        end;

        return;
    end;

    local Attribute = v72:GetAttribute("Inspected");
    local v74 = UpdateFertInfo(v72);
    pcall(UpdateTimeLeft, v72);

    if v72 == u5 then
        local Attribute2 = u5:GetAttribute("MaxAge");
        local Grow = u5:FindFirstChild("Grow");

        if not Grow then
            return;
        end;

        if Attribute2 and (Grow and Grow:FindFirstChild("Age")) then
            local math_max_ret = math.max(0, u7[u5] or 0);
            local v75;

            if math_max_ret <= 0 then
                v75 = "";
            elseif math_max_ret < 60 then
                v75 = `{string.format("%.1fs", math_max_ret)}*`;
            else
                v75 = `{NumberUtil.compactFormat(math_max_ret)}*`;
            end;

            PlantInfo.Text = v75;
        end;

        if InfGrowPlantData.InfGrowPlants[v72.Name] then
            local v76 = v72:FindFirstChild("Weight").Value * 100;
            PlantInfo.Text = `{math.floor(v76) / 100}kg`;
        end;

        PlantInfo.Visible = PlantInfo.Text ~= "";

        if not u47 then
            u47 = true;
            Frame.Show_Val.Value = true;
            Frame.Visible = true;
        end;

        return;
    end;

    u5 = v72;
    u4.CurrentPlant = v72;
    u4.OnCurrentPlantChange:Fire(v72);

    if not (u5:GetAttribute("MaxAge") and u5.Grow:FindFirstChild("Age")) then
        return;
    end;

    for _, v in pairs(u49) do
        v:Disconnect();
    end;

    table.clear(u49);

    if v74 == "Rainbow" then
        local u77 = 0;
        local Color3_new_ret = Color3.new(1, 0, 0);
        u49[FertInfo] = RunService.RenderStepped:Connect(function(p78) -- Line: 519
            -- upvalues: u77 (ref), Color3_new_ret (ref), FertInfo (ref)
            u77 = (u77 + p78 * 0.2) % 1;
            Color3_new_ret = Color3.fromHSV(u77, 1, 1);
            FertInfo.TextColor3 = Color3_new_ret;
        end);
    end;

    local v79 = u5:GetAttribute("DisplayName") or u5.Name;
    local v80 = v79 == "Four Leaf Clover" and "EGG LUCK BOOST🍀" or v79;
    local v81 = SeedData[v80];
    local v82 = v81 and v81.SeedRarity;
    local v83;

    if v82 then
        v83 = Item_Module.Return_Rarity_Data(v82);
    end;

    if v82 == "Prismatic" then
        StartRainbowTween(PlantName, "🌈", v80);
    elseif v82 == "Transcendent" then
        StartTranscendentTween(PlantName, "💜", v80);
    elseif v83 then
        local v84 = v83[2];
        local string_format_ret = string.format("#%02X%02X%02X", v84.R * 255, v84.G * 255, v84.B * 255);
        PlantName.Text = string.format("<font color=\"%s\">%s</font>", string_format_ret, v80);
    else
        PlantName.Text = v80;
    end;

    local math_max_ret = math.max(0, u7[u5] or 0);
    local v85;

    if math_max_ret <= 0 then
        v85 = "";
    elseif math_max_ret < 60 then
        v85 = `{string.format("%.1fs", math_max_ret)}*`;
    else
        v85 = `{NumberUtil.compactFormat(math_max_ret)}*`;
    end;

    PlantInfo.Text = v85;

    if InfGrowPlantData.InfGrowPlants[v72.Name] then
        local v86 = v72:FindFirstChild("Weight").Value * 100;
        PlantInfo.Text = `{math.floor(v86) / 100}kg`;
    end;

    PlantInfo.Visible = PlantInfo.Text ~= "";

    if Attribute then
        local v87 = CalculatePlantValue(v72);
        Comma_Module.Comma(v87);
        PlantValue.Text = NumberUtil.DisplaySheckles(v87);
    else
        PlantValue.Text = "";
    end;

    PlantValue.Visible = PlantValue.Text ~= "";
    local v88 = nil;
    local v89 = nil;
    local Variant = v72:FindFirstChild("Variant");
    local v90;

    if Variant and Variant:IsA("StringValue") then
        v90 = Variant.Value;

        if v90 == "" or (v90 == "Normal" or v90 == v74) then
            v90 = v88;
        else
            v89 = VariantColors:GetHex(v90);
        end;
    else
        v90 = v88;
    end;

    local v91 = {};

    for i, v in pairs(Mutations) do
        if v72:GetAttribute(i) then
            local v92 = {
                Name = v.DisplayName or v.Name
            };
            local v93;

            if v.Color then
                local Color = v.Color;
                v93 = string.format("#%02X%02X%02X", Color.R * 255, Color.G * 255, Color.B * 255) or "#FFFFFF";
            else
                v93 = "#FFFFFF";
            end;

            v92.Color = v93;
            table.insert(v91, v92);
        end;
    end;

    local v94 = {};

    if v90 then
        local v95 = v90 == "Rainbow" and "🌈" or string.format("<font color=\"%s\">%s</font>", v89, v90);
        table.insert(v94, v95);
    end;

    for _, v in ipairs(v91) do
        table.insert(v94, string.format("<font color=\"%s\">%s</font>", v.Color, v.Name));
    end;

    if #v94 > 0 then
        local table_concat_ret = table.concat(v94, " <font color=\"#FFFFFF\">+</font> ");
        PlantMuts.Text = table_concat_ret;

        if v90 == "Rainbow" then
            StartRainbowTween(PlantMuts, table_concat_ret, "Rainbow");
        end;
    else
        PlantMuts.Text = "";
    end;

    PlantMuts.Visible = PlantMuts.Text ~= "";

    if u3[v72.Name] then
        if u1 then
            u1:Destroy();
            u1 = nil;
        end;

        u1 = script_Range:Clone();
        u1.Parent = workspace.Visuals or workspace;
        local v96 = u3[v72.Name];

        if v90 == "Rainbow" then
            v96 = Vector3.new(v96.X * 1.5, v96.Y * 1.5, v96.Z * 1.5);
        end;

        u1.Size = v96;

        if v72.PrimaryPart then
            local PrimaryPart = v72.PrimaryPart;
            u1.CFrame = CFrame.new((Vector3.new(PrimaryPart.Position.X, PrimaryPart.Position.Y - PrimaryPart.Size.Y / 2 + 0.05, PrimaryPart.Position.Z)));
            u1.CanQuery = false;
        end;
    end;

    if not u47 then
        u47 = true;
        Frame.Show_Val.Value = true;
        Frame.Visible = true;
    end;
end);

local function updateScaling() -- Line: 663
    -- upvalues: Frame (copy), UserInputService (copy)
    Frame.UIScale.Scale = UserInputService.PreferredInput == Enum.PreferredInput.Touch and 1.5 or 1;
end;

UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(updateScaling);
task.spawn(updateScaling);

return u4;