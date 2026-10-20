-- Decompiled with Potassium's decompiler.

local MemoryStoreService = game:GetService("MemoryStoreService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DataStoreService = game:GetService("DataStoreService");
local RunService = game:GetService("RunService");
local Replion = require(ReplicatedStorage.FFlags.Packages.Replion);
local Signal = require(ReplicatedStorage.Modules.Signal);
require(script.Parent.Types);
local Environments = require(script.Parent.Environments);
local Overrides = require(script.Parent.Overrides);
local u1 = game.GameId == 7436755782 and not RunService:IsStudio() and 15 or 2;
local u2 = game.GameId == 7436755782 and not RunService:IsStudio() and 8 or 2;
local Random_new_ret = Random.new();
local u3 = nil;
local u4 = nil;
local v5 = {
    _loaded = false,
    _loadedSignal = Signal.new(),
    _updatedSignal = Signal.new()
};

local function waitForBudget(p6: any, p7: number?) -- Line: 71
    -- upvalues: DataStoreService (copy)
    local os_clock_ret = os.clock();
    local v8 = os_clock_ret;
    local v9 = p7 or 10;

    while DataStoreService:GetRequestBudgetForRequestType(p6) < 1 and os_clock_ret - v8 < v9 do
        task.wait();
        os_clock_ret = os.clock();
    end;

    return os_clock_ret - v8 < v9;
end;

function v5.IsLoaded(p10) -- Line: 84
    return p10._loaded;
end;

function v5.OnLoad(p11, p12) -- Line: 88
    return p11._loadedSignal:Connect(p12);
end;

function v5.OnUpdate(p13, p14) -- Line: 92
    return p13._updatedSignal:Connect(p14);
end;

function v5.OnChange(p15, p16, p17) -- Line: 96
    -- upvalues: u4 (ref)
    return u4:OnChange({ "Values", p16 }, p17);
end;

function v5.Get(p18, p19, p20) -- Line: 101
    -- upvalues: u4 (ref)
    if not p18:IsLoaded() then
        p18._loadedSignal:Wait();
    end;

    local v21 = u4:Get({ "Values", p19 });

    if v21 == nil then
        return p20;
    end;

    return v21;
end;

function v5.GetInstant(p22, p23, p24) -- Line: 114
    -- upvalues: u4 (ref)
    local v25 = u4:Get({ "Values", p23 });

    if v25 == nil then
        return p24;
    end;

    return v25;
end;

function v5.Set(p26, u27, u28, u29) -- Line: 123
    -- upvalues: u3 (ref), u4 (ref), Overrides (copy), u1 (copy), MemoryStoreService (copy), u2 (copy), DataStoreService (copy), waitForBudget (copy)
    if u29 == u3 or (u29 == "all" or u29 == "local") then
        u4:Set({ "Values", u27 }, u28);
        u4:Set("LastChange", workspace:GetServerTimeNow());
    end;

    if u29 == "local" then
        if not Overrides[u3] then
            Overrides[u3] = {};
        end;

        Overrides[u3][u27] = u28;

        return true;
    end;

    local function transformData(p30) -- Line: 138
        -- upvalues: u28 (copy), u27 (copy), u29 (copy)
        local UnixTimestamp = DateTime.now().UnixTimestamp;
        local v31 = not (p30 and (typeof(p30) == "table" and typeof(p30.Values) == "table")) and {
            Values = {},
            LastUpdate = UnixTimestamp
        } or p30;

        if u28 ~= nil then
            local v32 = false;

            for _, v in v31.Values do
                if u27 == v[1] and u29 == v[3] then
                    v32 = true;
                    v[2] = u28;

                    if u29 == nil then
                        table.remove(v, 3);
                    else
                        v[3] = u29;
                    end;
                end;
            end;

            if not v32 then
                local v33 = { u27, u28 };

                if u29 ~= nil then
                    table.insert(v33, u29);
                end;

                table.insert(v31.Values, v33);
            end;

            v31.LastUpdate = DateTime.now().UnixTimestamp;

            return v31;
        end;

        for i = #v31.Values, 1, -1 do
            local v34 = v31.Values[i];

            if u27 == v34[1] and u29 == v34[3] then
                table.remove(v31.Values, i);
                break;
            end;

            local _ = i;
        end;

        v31.LastUpdate = UnixTimestamp;

        return v31;
    end;

    for i = 1, u1 do
        local success, result = pcall(function() -- Line: 207
            -- upvalues: MemoryStoreService (ref), i (copy)
            return MemoryStoreService:GetHashMap((`FFlags-{i}`));
        end);
        local v35;

        if success then
            local success2, result2 = pcall(function() -- Line: 216
                -- upvalues: result (copy), transformData (copy)
                return result:UpdateAsync("FFlags", transformData, 3888000);
            end);

            if success2 then
                v35 = i;
            else
                warn((`Failed to update HashMap FFlags-{i}/FFlags: {result2}`));
                v35 = i;
            end;
        else
            warn((`Failed to save HashMap FFlags-{i}/FFlags: {result}`));
            v35 = i;
        end;
    end;

    for i = 1, u2 do
        local success, result = pcall(function() -- Line: 231
            -- upvalues: DataStoreService (ref), i (copy)
            return DataStoreService:GetDataStore((`FFlags-{i}`));
        end);
        local v36;

        if success then
            if not waitForBudget(Enum.DataStoreRequestType.UpdateAsync, 30) then
                warn("No DataStore:UpdateAsync() request budget available");

                return false;
            end;

            local success2, result2 = pcall(function() -- Line: 246
                -- upvalues: result (copy), transformData (copy)
                return result:UpdateAsync("FFlags", transformData);
            end);

            if success2 then
                v36 = i;
            else
                warn((`Failed to update DataStore FFlags-{i}/FFlags: {result2}`));
                v36 = i;
            end;
        else
            warn((`Failed to save DataStore FFlags-{i}/FFlags: {result}`));
            v36 = i;
        end;
    end;

    return true;
end;

function v5._loadMemoryStore(p37, p38) -- Line: 259
    -- upvalues: Random_new_ret (copy), u1 (copy), MemoryStoreService (copy)
    local u39 = p38 or Random_new_ret:NextInteger(1, u1);
    local success, result = pcall(function() -- Line: 261
        -- upvalues: MemoryStoreService (ref), u39 (copy)
        return MemoryStoreService:GetHashMap((`FFlags-{u39}`));
    end);

    if not success then
        warn((`MemoryStoreService:GetHashMap() failed on 'FFlags-{u39}': {result}`));

        return false;
    end;

    local success2, result2 = pcall(function() -- Line: 270
        -- upvalues: result (copy)
        return result:GetAsync("FFlags");
    end);

    if not success2 then
        warn((`Failed to load HashMap FFlags-{u39}/FFlags: {result2}`));

        return false;
    end;

    if typeof(result2) ~= "table" or typeof(result2.Values) ~= "table" then
        warn((`Invalid data format in HashMap FFlags-{u39}/FFlags: {result2}`));
        ({
            LastUpdate = 0
        }).Values = {};

        return false;
    end;

    local UnixTimestamp = DateTime.now().UnixTimestamp;
    local v40;

    if typeof(result2.LastUpdate) == "number" then
        v40 = result2.LastUpdate;
    else
        v40 = UnixTimestamp;
    end;

    local _ = UnixTimestamp - v40 >= 2592000;

    return true, result2;
end;

function v5._loadDataStore(p41, p42) -- Line: 334
    -- upvalues: Random_new_ret (copy), u2 (copy), DataStoreService (copy), waitForBudget (copy)
    local u43 = p42 or Random_new_ret:NextInteger(1, u2);
    local success, result = pcall(function() -- Line: 336
        -- upvalues: DataStoreService (ref), u43 (copy)
        return DataStoreService:GetDataStore((`FFlags-{u43}`));
    end);

    if not success then
        warn((`DataStoreService:GetDataStore() failed on 'FFlags-{u43}': {result}`));

        return false;
    end;

    local DataStoreGetOptions = Instance.new("DataStoreGetOptions");
    DataStoreGetOptions.UseCache = false;

    if not waitForBudget(Enum.DataStoreRequestType.GetAsync) then
        warn("No DataStore:GetAsync() request budget available");

        return false;
    end;

    local success2, result2 = pcall(function() -- Line: 354
        -- upvalues: result (copy), DataStoreGetOptions (copy)
        return result:GetAsync("FFlags", DataStoreGetOptions);
    end);

    if success2 then
        if typeof(result2) ~= "table" or typeof(result2.Values) ~= "table" then
            warn((`Invalid data format in DataStore FFlags-{u43}/FFlags: {result2}`));
            result2 = {
                LastUpdate = 0,
                Values = {}
            };
        end;

        return true, result2;
    end;

    warn((`Failed to load DataStore FFlags-{u43}/FFlags: {result2}`));

    return false;
end;

function v5.Load(p44) -- Line: 376
    -- upvalues: RunService (copy), u3 (ref), u4 (ref), Replion (copy), Overrides (copy)
    local v45, v46;

    if RunService:IsStudio() then
        v45, v46 = p44:_loadDataStore();
    else
        v45, v46 = p44:_loadMemoryStore();
    end;

    if not v45 then
        local v47 = 0;

        while v47 < 3 and not v45 do
            warn((`Failed to load FFlags {RunService:IsStudio() and "DataStore" or "MemoryStore HashMap"}, retrying...`));
            v47 = v47 + 1;
            task.wait(v47 * 1);
            v45, v46 = p44:_loadMemoryStore();
        end;

        if not v45 then
            warn("All attempts to load FFlags MemoryStore HashMaps failed, loading DataStore instead");
            v45, v46 = p44:_loadDataStore();
        end;
    end;

    if not (v45 and v46) then
        warn("Failed to load FFlags: both MemoryStore and DataStore requests failed!");

        return false;
    end;

    local v48 = {};

    for _, v in v46.Values do
        local v49 = v[1];
        local v50 = v[2];
        local v51 = v[3] or "all";

        if v49 and (v51 ~= "all" or not v48[v49]) and (v51 == u3 or v51 == "all") then
            v48[v49] = v50;
        end;
    end;

    for i, _ in u4.Data.Values do
        if v48[i] == nil then
            v48[i] = Replion.None;
        end;
    end;

    if Overrides[u3] then
        for i, v in Overrides[u3] do
            v48[i] = v;
        end;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    u4:Update({
        Loaded = true,
        LastUpdate = ServerTimeNow,
        LastChange = ServerTimeNow,
        Values = v48
    });

    if not p44._loaded then
        p44._loaded = true;
        p44._loadedSignal:Fire(u4.Data);
    end;

    p44._updatedSignal:Fire(u4.Data);

    return true;
end;

function v5.Start(p52) -- Line: 458
    -- upvalues: Environments (copy), u3 (ref), RunService (copy), Random_new_ret (copy)
    for i, v in Environments do
        if v.UniverseIds and table.find(v.UniverseIds, game.GameId) then
            local v53;

            if RunService:IsStudio() and v.StudioEnvironment then
                v53 = v.StudioEnvironment;
            else
                v53 = i;
            end;

            u3 = v53;
        end;

        if not (v.UniverseIds and (#v.UniverseIds ~= 0 or u3)) then
            u3 = i;
        end;
    end;

    if not u3 then
        warn((`Failed to find matching Environment for UniverseId {game.GameId}`));

        return;
    end;

    local v54 = 0;

    while true do
        local ServerTimeNow = workspace:GetServerTimeNow();

        if v54 < ServerTimeNow then
            v54 = ServerTimeNow + 300 * Random_new_ret:NextNumber(0.7, 1.3);
            p52:Load();
        end;

        task.wait(1);
    end;
end;

u4 = Replion.Server.new({
    Channel = "FFlags",
    ReplicateTo = "All",
    Data = {
        Loaded = false,
        LastUpdate = 0,
        LastChange = 0,
        Values = {}
    }
});
task.spawn(v5.Start, v5);

return v5;