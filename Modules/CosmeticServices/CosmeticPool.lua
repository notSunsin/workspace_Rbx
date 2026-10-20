-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GenerateRandomString = require(ReplicatedStorage.Modules.GenerateRandomString);
local CosmeticList = require(ReplicatedStorage.Data.CosmeticRegistry.CosmeticList);
local u1 = {
    KEEP = 10
};
local u2 = {
    ["Cooking Kit"] = true,
    ["Egg Incubator"] = true,
    ["Pet Incubator"] = true,
    ["Statue Of Achievement"] = true
};

if game:GetService("RunService"):IsServer() then
    local Modules = game:GetService("ServerScriptService"):FindFirstChild("Modules");

    if Modules then
        Modules = Modules:FindFirstChild("CosmeticsServices");
    end;

    if Modules then
        Modules = Modules:FindFirstChild("CosmeticHooks");
    end;

    if Modules then
        for _, child in Modules:GetChildren() do
            if child:IsA("ModuleScript") then
                u2[child.Name] = true;
            end;
        end;
    end;
end;

local function ReadCount(p3) -- Line: 54
    return (typeof(p3) ~= "number" or (p3 ~= p3 or (p3 < 1 or p3 == (1 / 0)))) and 0 or math.floor(p3);
end;

local function GetCosmeticData(p4) -- Line: 61
    if typeof(p4) ~= "table" then
        return nil;
    end;

    local CosmeticData = p4.CosmeticData;

    if typeof(CosmeticData) == "table" then
        return CosmeticData;
    end;

    return nil;
end;

local function GetInventory(p5) -- Line: 69
    local v6;

    if typeof(p5) == "table" then
        v6 = p5.CosmeticData;

        if typeof(v6) ~= "table" then
            v6 = nil;
        end;
    else
        v6 = nil;
    end;

    if v6 then
        v6 = v6.Inventory;
    end;

    if typeof(v6) == "table" then
        return v6;
    end;

    return nil;
end;

function u1.GetPool(p7) -- Line: 75
    local v8;

    if typeof(p7) == "table" then
        v8 = p7.CosmeticData;

        if typeof(v8) ~= "table" then
            v8 = nil;
        end;
    else
        v8 = nil;
    end;

    if v8 then
        v8 = v8.Pool;
    end;

    if typeof(v8) == "table" then
        return v8;
    end;

    return nil;
end;

function u1.GetPooled(p9, p10) -- Line: 81
    -- upvalues: u1 (copy)
    local Pool = u1.GetPool(p9);

    if not Pool or typeof(p10) ~= "string" then
        return 0;
    end;

    local v11 = Pool[p10];

    return (typeof(v11) ~= "number" or (v11 ~= v11 or (v11 < 1 or v11 == (1 / 0)))) and 0 or math.floor(v11);
end;

function u1.CountOwned(p12, p13) -- Line: 89
    -- upvalues: u1 (copy)
    if typeof(p13) ~= "string" then
        return 0;
    end;

    local v14 = 0;
    local v15;

    if typeof(p12) == "table" then
        v15 = p12.CosmeticData;

        if typeof(v15) ~= "table" then
            v15 = nil;
        end;
    else
        v15 = nil;
    end;

    if v15 then
        v15 = v15.Inventory;
    end;

    if typeof(v15) ~= "table" then
        v15 = nil;
    end;

    if v15 then
        for _, v in v15 do
            if typeof(v) == "table" and v.Name == p13 then
                v14 = v14 + 1;
            end;
        end;
    end;

    return v14 + u1.GetPooled(p12, p13);
end;

function u1.CountAllOwned(p16) -- Line: 107
    -- upvalues: u1 (copy)
    local v17 = {};
    local v18;

    if typeof(p16) == "table" then
        v18 = p16.CosmeticData;

        if typeof(v18) ~= "table" then
            v18 = nil;
        end;
    else
        v18 = nil;
    end;

    if v18 then
        v18 = v18.Inventory;
    end;

    if typeof(v18) ~= "table" then
        v18 = nil;
    end;

    if v18 then
        for _, v in v18 do
            local v19;

            if typeof(v) == "table" then
                v19 = v.Name;
            else
                v19 = nil;
            end;

            if typeof(v19) == "string" then
                v17[v19] = (v17[v19] or 0) + 1;
            end;
        end;
    end;

    local Pool = u1.GetPool(p16);

    if Pool then
        for i, v in Pool do
            local v20 = (typeof(v) ~= "number" or (v ~= v or (v < 1 or v == (1 / 0)))) and 0 or math.floor(v);

            if typeof(i) == "string" and v20 > 0 then
                v17[i] = (v17[i] or 0) + v20;
            end;
        end;
    end;

    return v17;
end;

function u1.IsPoolableName(p21) -- Line: 133
    -- upvalues: u2 (copy), CosmeticList (copy)
    if typeof(p21) ~= "string" or u2[p21] then
        return false;
    end;

    local v22 = CosmeticList[p21];
    local v23;

    if typeof(v22) == "table" then
        v23 = not v22.Undeletable and not v22.Max;
    else
        v23 = false;
    end;

    return v23;
end;

function u1.IsFungibleEntry(p24) -- Line: 141
    -- upvalues: u1 (copy)
    if typeof(p24) ~= "table" or not u1.IsPoolableName(p24.Name) then
        return false;
    end;

    for i, v in p24 do
        if i ~= "Name" and (i ~= "Data" and (i ~= "New" or v ~= true)) then
            return false;
        end;
    end;

    local Data = p24.Data;
    local v25;

    if typeof(Data) == "table" then
        v25 = next(Data) == nil;
    else
        v25 = false;
    end;

    return v25;
end;

local function AddKeys(p26: table, p27: any) -- Line: 158
    if p27 == nil then
        return true;
    end;

    if typeof(p27) ~= "table" then
        return false;
    end;

    for i, v in p27 do
        p26[i] = true;

        if typeof(v) == "string" then
            p26[v] = true;
        end;
    end;

    return true;
end;

function u1.CollectKnownReferences(p28) -- Line: 180
    local v29 = {};

    if typeof(p28) ~= "table" then
        return nil;
    end;

    local SaveSlots = p28.SaveSlots;

    if SaveSlots ~= nil then
        if typeof(SaveSlots) ~= "table" then
            return nil;
        end;

        local AllSlots = SaveSlots.AllSlots;

        if AllSlots ~= nil then
            if typeof(AllSlots) ~= "table" then
                return nil;
            end;

            for _, v in AllSlots do
                if typeof(v) ~= "table" then
                    return nil;
                end;

                local EquippedCosmetics = v.EquippedCosmetics;
                local v30;

                if EquippedCosmetics == nil then
                    v30 = true;
                elseif typeof(EquippedCosmetics) == "table" then
                    for i, v2 in EquippedCosmetics do
                        v29[i] = true;

                        if typeof(v2) == "string" then
                            v29[v2] = true;
                        end;
                    end;

                    v30 = true;
                else
                    v30 = false;
                end;

                if not v30 then
                    return nil;
                end;
            end;
        end;
    end;

    local v31;

    if typeof(p28) == "table" then
        v31 = p28.CosmeticData;

        if typeof(v31) ~= "table" then
            v31 = nil;
        end;
    else
        v31 = nil;
    end;

    if v31 then
        local Equipped = v31.Equipped;
        local v32;

        if Equipped == nil then
            v32 = true;
        elseif typeof(Equipped) == "table" then
            for i, v in Equipped do
                v29[i] = true;

                if typeof(v) == "string" then
                    v29[v] = true;
                end;
            end;

            v32 = true;
        else
            v32 = false;
        end;

        if not v32 then
            return nil;
        end;
    end;

    local CookingKit = p28.CookingKit;

    if CookingKit ~= nil then
        if typeof(CookingKit) ~= "table" then
            return nil;
        end;

        for _, v in CookingKit do
            local v33;

            if v == nil then
                v33 = true;
            elseif typeof(v) == "table" then
                for i, v2 in v do
                    v29[i] = true;

                    if typeof(v2) == "string" then
                        v29[v2] = true;
                    end;
                end;

                v33 = true;
            else
                v33 = false;
            end;

            if not v33 then
                return nil;
            end;
        end;
    end;

    local PetsData = p28.PetsData;

    if typeof(PetsData) ~= "table" then
        return v29;
    end;

    for _, v in { "PetIncubatorData", "PetEggIncubatorData" } do
        local v34 = PetsData[v];

        if v34 ~= nil then
            if typeof(v34) ~= "table" then
                return nil;
            end;

            local IncubatorData = v34.IncubatorData;
            local v35;

            if IncubatorData == nil then
                v35 = true;
            elseif typeof(IncubatorData) == "table" then
                for i, v2 in IncubatorData do
                    v29[i] = true;

                    if typeof(v2) == "string" then
                        v29[v2] = true;
                    end;
                end;

                v35 = true;
            else
                v35 = false;
            end;

            if not v35 then
                return nil;
            end;
        end;
    end;

    return v29;
end;

local function CollectAnyReferences(p36: any, u37: any, u38: table) -- Line: 238
    local CosmeticData = p36.CosmeticData;
    local u39 = {};

    local function Walk(p40: any, p41: number) -- Line: 242
        -- upvalues: u39 (copy), u37 (copy), u38 (copy), CosmeticData (copy), Walk (copy)
        if p41 > 64 or u39[p40] then
            return;
        end;

        u39[p40] = true;

        for i, v in p40 do
            if typeof(i) == "string" and u37[i] ~= nil then
                u38[i] = true;
            end;

            local v42 = typeof(v);

            if v42 == "string" then
                if u37[v] ~= nil then
                    u38[v] = true;
                end;
            elseif v42 == "table" and (p40 ~= CosmeticData or i ~= "Inventory" and i ~= "Pool") then
                Walk(v, p41 + 1);
            end;
        end;
    end;

    Walk(p36, 0);
end;

local function IsTaken(p43: string, p44: any, p45: table) -- Line: 267
    return string.match(p43, "^%d+$") and true or (p44[p43] ~= nil and true or p45[p43] == true);
end;

function u1.GenerateUUID(p46: any, p47: table?) -- Line: 275
    -- upvalues: GenerateRandomString (copy)
    local v48 = p47 or {};

    for i = 1, 64 do
        local v49 = GenerateRandomString(5);

        if not (string.match(v49, "^%d+$") or (p46[v49] ~= nil or v48[v49] == true)) then
            return v49;
        end;

        local _ = i;
    end;

    local v50 = 6;
    local v51;

    while true do
        v51 = GenerateRandomString(v50);

        if not (string.match(v51, "^%d+$") or (p46[v51] ~= nil or v48[v51] == true)) then
            break;
        end;

        v50 = v50 + 1;
    end;

    return v51;
end;

local function Sanitize(p52: table) -- Line: 296
    local v53 = {};
    local v54 = 0;

    for i, v in p52 do
        if typeof(i) == "string" then
            local v55;

            if typeof(v) == "string" then
                v55 = tonumber(v);
            else
                v55 = v;
            end;

            local v56 = (typeof(v55) ~= "number" or (v55 ~= v55 or (v55 < 1 or v55 == (1 / 0)))) and 0 or math.floor(v55);

            if v56 <= 0 then
                v53[i] = false;
            elseif v56 ~= v then
                v53[i] = v56;
            end;
        else
            v53[i] = false;
        end;
    end;

    for i, v in v53 do
        if v == false then
            p52[i] = nil;
            v54 = v54 + 1;
        else
            p52[i] = v;
        end;
    end;

    return v54;
end;

local function Mint(p57: any, p58: table, p59: table, p60: string, p61: number) -- Line: 325
    -- upvalues: u1 (copy)
    local v62 = {};

    for i = 1, p61 do
        local v63 = p58[p60];
        local v64 = (typeof(v63) ~= "number" or (v63 ~= v63 or (v63 < 1 or v63 == (1 / 0)))) and 0 or math.floor(v63);

        if v64 <= 0 then
            break;
        end;

        local v65 = u1.GenerateUUID(p57, p59);
        p57[v65] = {
            Name = p60,
            Data = {}
        };
        local v66;

        if v64 > 1 then
            v66 = v64 - 1;
        else
            v66 = nil;
        end;

        p58[p60] = v66;
        table.insert(v62, v65);
        local _ = i;
    end;

    return v62;
end;

local function CountSpare(p67: any, p68: table, p69: string) -- Line: 343
    -- upvalues: u1 (copy)
    local v70 = 0;

    for i, v in p67 do
        if typeof(v) == "table" and (v.Name == p69 and (not p68[i] and u1.IsFungibleEntry(v))) then
            v70 = v70 + 1;
        end;
    end;

    return v70;
end;

function u1.Refill(p71: any, p72: any, p73: number?) -- Line: 358
    -- upvalues: u1 (copy), CountSpare (copy), Mint (copy)
    if not u1.IsPoolableName(p72) then
        return {};
    end;

    local v74;

    if typeof(p71) == "table" then
        v74 = p71.CosmeticData;

        if typeof(v74) ~= "table" then
            v74 = nil;
        end;
    else
        v74 = nil;
    end;

    if v74 then
        v74 = v74.Inventory;
    end;

    if typeof(v74) ~= "table" then
        v74 = nil;
    end;

    local Pool = u1.GetPool(p71);

    if v74 and Pool then
        local v75 = Pool[p72];

        if ((typeof(v75) ~= "number" or (v75 ~= v75 or (v75 < 1 or v75 == (1 / 0)))) and 0 or math.floor(v75)) > 0 then
            local v76 = u1.CollectKnownReferences(p71);

            if not v76 then
                return {};
            end;

            local v77 = (typeof(p73) ~= "number" or (p73 ~= p73 or (p73 < 1 or p73 == (1 / 0)))) and 0 or math.floor(p73);
            local math_max_ret = math.max(v77, u1.KEEP);
            local v78 = CountSpare(v74, v76, p72);

            return math_max_ret <= v78 and {} or Mint(v74, Pool, v76, p72, math_max_ret - v78);
        end;
    end;

    return {};
end;

function u1.TopUp(p79) -- Line: 387
    -- upvalues: u1 (copy)
    local v80;

    if typeof(p79) == "table" then
        v80 = p79.CosmeticData;

        if typeof(v80) ~= "table" then
            v80 = nil;
        end;
    else
        v80 = nil;
    end;

    if v80 then
        v80 = v80.Inventory;
    end;

    if typeof(v80) ~= "table" then
        v80 = nil;
    end;

    local Pool = u1.GetPool(p79);

    if not (v80 and (Pool and next(Pool) ~= nil)) then
        return 0;
    end;

    if not u1.CollectKnownReferences(p79) then
        return 0;
    end;

    local v81 = 0;

    for i in table.clone(Pool) do
        v81 = v81 + #u1.Refill(p79, i);
    end;

    return v81;
end;

local function EntryBytes(p82: string) -- Line: 407
    return #p82 + 30;
end;

function u1.Unpool(p83: any, p84: number, p85: number) -- Line: 417
    -- upvalues: u1 (copy), CosmeticList (copy), Mint (copy)
    local v86;

    if typeof(p83) == "table" then
        v86 = p83.CosmeticData;

        if typeof(v86) ~= "table" then
            v86 = nil;
        end;
    else
        v86 = nil;
    end;

    if v86 then
        v86 = v86.Inventory;
    end;

    if typeof(v86) ~= "table" then
        v86 = nil;
    end;

    local Pool = u1.GetPool(p83);

    if not (v86 and Pool) then
        return 0, 0;
    end;

    local v87 = u1.CollectKnownReferences(p83) or {};
    local v88 = p84 - p85;
    local v89 = {};

    for i, v in Pool do
        if typeof(i) == "string" and (((typeof(v) ~= "number" or (v ~= v or (v < 1 or v == (1 / 0)))) and 0 or math.floor(v)) > 0 and typeof(CosmeticList[i]) == "table") then
            table.insert(v89, i);
        end;
    end;

    table.sort(v89);
    local v90 = true;
    local v91 = 0;

    while v88 > 0 and v90 do
        v90 = false;

        for _, v in v89 do
            local math_floor_ret = math.floor(v88 / (#v + 30));
            local KEEP = u1.KEEP;
            local v92 = Pool[v];
            local v93 = (typeof(v92) ~= "number" or (v92 ~= v92 or (v92 < 1 or v92 == (1 / 0)))) and 0 or math.floor(v92);
            local math_min_ret = math.min(KEEP, v93, math_floor_ret);

            if math_min_ret > 0 then
                local v94 = #Mint(v86, Pool, v87, v, math_min_ret);
                v91 = v91 + v94;
                v88 = v88 - v94 * (#v + 30);
                v90 = v90 or v94 > 0;
            end;
        end;
    end;

    local v95 = 0;

    for _, v in u1.CountAllOwned({
        CosmeticData = {
            Pool = Pool
        }
    }) do
        v95 = v95 + v;
    end;

    return v91, v95;
end;

function u1.TakePooled(p96, p97) -- Line: 462
    -- upvalues: u1 (copy)
    local Pool = u1.GetPool(p96);

    if not Pool or typeof(p97) ~= "string" then
        return false;
    end;

    local v98 = Pool[p97];
    local v99 = (typeof(v98) ~= "number" or (v98 ~= v98 or (v98 < 1 or v98 == (1 / 0)))) and 0 or math.floor(v98);

    if v99 <= 0 then
        return false;
    end;

    local v100;

    if v99 > 1 then
        v100 = v99 - 1;
    else
        v100 = nil;
    end;

    Pool[p97] = v100;

    return true;
end;

local function BuildSpare(p101: any, p102: table) -- Line: 479
    -- upvalues: u1 (copy)
    local v103 = {};
    local v104 = {};

    for i, v in p101 do
        if not (p102[i] or (typeof(i) ~= "string" or not u1.IsFungibleEntry(v))) then
            local v105;

            if v.New then
                v105 = v103;
            else
                v105 = v104;
            end;

            local v106 = v105[v.Name];

            if not v106 then
                v106 = {};
                v105[v.Name] = v106;
            end;

            table.insert(v106, i);
        end;
    end;

    for i, v in v104 do
        local v107 = v103[i];

        if v107 then
            table.move(v, 1, #v, #v107 + 1, v107);
        else
            v103[i] = v;
        end;
    end;

    return v103;
end;

function u1.Compact(p108: any, p109: boolean?) -- Line: 522
    -- upvalues: u1 (copy), BuildSpare (copy), Sanitize (copy), CosmeticList (copy), Mint (copy)
    local v110 = {
        Moved = 0,
        Minted = 0,
        Sanitized = 0,
        Skipped = nil
    };
    local v111;

    if typeof(p108) == "table" then
        v111 = p108.CosmeticData;

        if typeof(v111) ~= "table" then
            v111 = nil;
        end;
    else
        v111 = nil;
    end;

    local u112;

    if typeof(p108) == "table" then
        u112 = p108.CosmeticData;

        if typeof(u112) ~= "table" then
            u112 = nil;
        end;
    else
        u112 = nil;
    end;

    if u112 then
        u112 = u112.Inventory;
    end;

    if typeof(u112) ~= "table" then
        u112 = nil;
    end;

    if not (v111 and u112) then
        v110.Skipped = "NoInventory";

        return v110;
    end;

    if v111.Pool ~= nil and typeof(v111.Pool) ~= "table" then
        v110.Skipped = "PoolNotTable";

        return v110;
    end;

    local u113 = u1.CollectKnownReferences(p108);

    if not u113 then
        v110.Skipped = "UnexpectedShape";

        return v110;
    end;

    local KEEP = u1.KEEP;
    local v114 = BuildSpare(u112, u113);

    for _, v in v114 do
        if KEEP < #v then
            local CosmeticData = p108.CosmeticData;
            local u115 = {};

            local function u119(p116: any, p117: number) -- Line: 242
                -- upvalues: u115 (copy), u112 (copy), u113 (copy), CosmeticData (copy), u119 (copy)
                if p117 > 64 or u115[p116] then
                    return;
                end;

                u115[p116] = true;

                for i, v2 in p116 do
                    if typeof(i) == "string" and u112[i] ~= nil then
                        u113[i] = true;
                    end;

                    local v118 = typeof(v2);

                    if v118 == "string" then
                        if u112[v2] ~= nil then
                            u113[v2] = true;
                        end;
                    elseif v118 == "table" and (p116 ~= CosmeticData or i ~= "Inventory" and i ~= "Pool") then
                        u119(v2, p117 + 1);
                    end;
                end;
            end;

            u119(p108, 0);
            v114 = BuildSpare(u112, u113);
            break;
        end;
    end;

    if v111.Pool == nil then
        v111.Pool = {};
    end;

    local Pool = u1.GetPool(p108);
    v110.Sanitized = Sanitize(Pool);
    local v120 = {};

    for i, v in v114 do
        local v121 = #v - KEEP;

        if v121 > 0 then
            local v122 = Pool[i];
            Pool[i] = ((typeof(v122) ~= "number" or (v122 ~= v122 or (v122 < 1 or v122 == (1 / 0)))) and 0 or math.floor(v122)) + v121;
            local v123 = v;

            for i2 = KEEP + 1, #v do
                v120[v123[i2]] = true;
                local _ = i2;
            end;

            v110.Moved = v110.Moved + v121;
        end;
    end;

    if v110.Moved > 0 then
        if p109 then
            u112 = {};

            for i, v in u112 do
                if not v120[i] then
                    u112[i] = v;
                end;
            end;

            v111.Inventory = u112;
        else
            for i in v120 do
                u112[i] = nil;
            end;
        end;
    end;

    local v124 = {};

    for i, v in Pool do
        local v125 = (typeof(v) ~= "number" or (v ~= v or (v < 1 or v == (1 / 0)))) and 0 or math.floor(v);

        if v125 > 0 then
            if u1.IsPoolableName(i) then
                local v126 = not v114[i] and 0 or math.min(#v114[i], KEEP);

                if v126 < KEEP then
                    v124[i] = KEEP - v126;
                end;
            elseif typeof(CosmeticList[i]) == "table" then
                v124[i] = v125;
            end;
        end;
    end;

    for i, v in v124 do
        v110.Minted = v110.Minted + #Mint(u112, Pool, u113, i, v);
    end;

    return v110;
end;

return u1;