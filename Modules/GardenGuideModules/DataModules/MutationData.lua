-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Data.GardenGuideData);
require(ReplicatedStorage.Data.GardenGuideData.GardenGuideTypes);
require(ReplicatedStorage.Modules.NumberUtil);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry);
local MutationCombos = require(ReplicatedStorage.Modules.MutationHandler.MutationCombos);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local u1 = ReplicatedStorage.GameEvents.GardenGuide.GetGGBlacklist:InvokeServer();
local u2 = {
    Data = {},
    Total = 0,
    Unlocked = {}
};
local Data = DataService:GetData();

local function SetComboData(p3: string, p4: any) -- Line: 26
    -- upvalues: Data (copy)
    local v5 = {
        SpecificIngr = {},
        BroadIngr = {}
    };
    local _ = Data.GardenGuide.PlantData;

    if not p4.Data then
        return v5;
    end;

    if p4.Type == "Fusion Combo" then
        for _, v in p4.Data.Requires do
            if #v == 1 then
                v5.SpecificIngr[v[1]] = {
                    ImageId = "",
                    Name = v[1]
                };
            else
                local LargerArrayName = p4.Data.LargerArrayName;

                if LargerArrayName and not v5.BroadIngr[LargerArrayName] then
                    v5.BroadIngr[LargerArrayName] = {};
                end;

                for _, v2 in v do
                    v5.BroadIngr[LargerArrayName][v2] = v2;
                end;
            end;
        end;

        return v5;
    end;

    if p4.Type == "Chain Combo" then
        local Order = p4.Data.Order;

        for i = #Order, 1, -1 do
            if Order[i] == p3 then
                v5.SpecificIngr[Order[i]] = {
                    ImageId = "",
                    Name = Order[i]
                };

                return v5;
            end;

            v5.SpecificIngr[Order[i]] = {
                ImageId = "",
                Name = Order[i]
            };
            local _ = i;
        end;

        return v5;
    end;
end;

local function FormatData(p6, p7, p8, p9) -- Line: 89
    -- upvalues: MutationCombos (copy), SetComboData (copy)
    local v10 = {};
    local v11 = {};
    local v12 = nil;
    local v13 = "None";

    for i, v in {
        Plant = p7,
        Pet = p8
    } do
        if v then
            table.insert(v10, i);
            v11[i] = `x{v.ValueMulti}`;

            if not v12 then
                v12 = v.Color;
            end;
        end;
    end;

    local v14 = v12 or Color3.fromRGB(80, 80, 80);

    if #v10 > 0 then
        v13 = table.concat(v10, ", ");
    end;

    local ComboData = MutationCombos.GetComboData(p6);
    local v15 = ComboData and (ComboData.Type or "No Combo") or "No Combo";
    local v16 = {
        ImageId = "",
        Source = "???",
        DisplayName = p6:gsub("[^%a%s%d]", ""):gsub("(%l)(%u)", "%1 %2"),
        Name = p6
    };
    local v17;

    if p9 then
        v17 = p9.NewMutation or false;
    else
        v17 = false;
    end;

    v16.New = v17;
    v16.Seen = p9 and true or false;
    v16.Applicable = v13;
    v16.ValueMultis = v11;
    v16.ComboType = v15 or "No Combo";
    local v18;

    if ComboData then
        v18 = SetComboData(p6, ComboData);
    else
        v18 = nil;
    end;

    v16.RecipeData = v18;
    v16.Color = v14;
    v16.HarvestedCount = p9 and (p9.HarvestCount or 0) or 0;
    v16.AppliedCount = p9 and (p9.AppliedCount or 0) or 0;
    v16.SoldCount = p9 and p9.SoldCount or 0;

    return v16;
end;

local function GatherData() -- Line: 135
    -- upvalues: MutationHandler (copy), u1 (copy), u2 (copy), PetMutationRegistry (copy)
    for i, _ in MutationHandler.MutationNames do
        if not (u1.MutationBlacklist[i] or u2.Data[i]) then
            local v19 = u2;
            v19.Total = v19.Total + 1;
            u2.UpdateData(i);
        end;
    end;

    for i, _ in PetMutationRegistry.PetMutationRegistry do
        if not (u1.MutationBlacklist[i] or u2.Data[i]) then
            local v20 = u2;
            v20.Total = v20.Total + 1;
            u2.UpdateData(i);
        end;
    end;
end;

function u2.UpdateData(p21: string) -- Line: 155
    -- upvalues: MutationHandler (copy), PetMutationRegistry (copy), Data (copy), u1 (copy), UpdateService (copy), u2 (copy), FormatData (copy)
    local v22 = MutationHandler.GetMutations()[p21];
    local v23 = PetMutationRegistry.PetMutationRegistry[p21];

    if not (v22 or v23) then
        warn((`MutationData | No MutationData or PetMutationData for mutation {p21}`));

        return;
    end;

    local v24;

    if Data.GardenGuide.MutationData then
        v24 = Data.GardenGuide.MutationData[p21] or nil;
    else
        v24 = nil;
    end;

    if u1.MutationBlacklist[p21] then
        return;
    end;

    if not UpdateService:IsUpdateDone() and UpdateService:IsHiddenFromUpdate(p21) then
        return;
    end;

    u2.Data[p21] = FormatData(p21, v22, v23, v24);

    if v24 and not table.find(u2.Unlocked, p21) then
        table.insert(u2.Unlocked, p21);
    end;
end;

function u2.RegatherData() -- Line: 179
    -- upvalues: GatherData (copy)
    GatherData();
end;

GatherData();

return u2;