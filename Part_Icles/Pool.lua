-- Decompiled with Potassium's decompiler.

local PoolHide = require(script.Parent.PoolHide);
local u1 = {};

local function _getPoolFolder() -- Line: 15
    local Part_IclesPooled = workspace.Terrain:FindFirstChild("Part_IclesPooled");

    if Part_IclesPooled then
        return Part_IclesPooled;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "Part_IclesPooled";
    Folder.Archivable = false;
    Folder.Parent = workspace.Terrain;

    return Folder;
end;

u1._pools = setmetatable({}, {
    __mode = "k"
});
u1._totalSize = 0;
u1._lastSweepAt = 0;
u1._lastReportAt = 0;
u1.MAX_POOL_TOTAL = 2048;
u1.TTL = 5;
u1.SWEEP_INTERVAL = 2;
u1.REPORT_INTERVAL = 0;
u1.MIN_CAP = 8;
u1.CAP_SAFETY = 1.25;

local function estimateCap(p2) -- Line: 39
    -- upvalues: u1 (copy)
    local v3 = math.max(p2 or 0, 0) * u1.TTL * u1.CAP_SAFETY;

    return math.ceil(v3) + u1.MIN_CAP;
end;

local function getOrInitPool(p4) -- Line: 44
    -- upvalues: u1 (copy)
    local v5 = u1._pools[p4];

    if v5 then
        return v5;
    end;

    local v6 = {
        peakSize = 0,
        hits = 0,
        misses = 0,
        evictions = 0,
        entries = {},
        gen = p4:GetAttribute("_PoolGen") or 0,
        cap = u1.MIN_CAP
    };
    u1._pools[p4] = v6;

    return v6;
end;

local function destroyEntry(u7) -- Line: 58
    if u7 and u7.instance then
        pcall(function() -- Line: 60
            -- upvalues: u7 (copy)
            u7.instance:Destroy();
        end);
    end;
end;

local function discardAllEntries(p8) -- Line: 64
    -- upvalues: u1 (copy)
    for i = 1, #p8.entries do
        local u9 = p8.entries[i];
        local v10;

        if u9 and u9.instance then
            pcall(function() -- Line: 60
                -- upvalues: u9 (copy)
                u9.instance:Destroy();
            end);
            v10 = i;
        else
            v10 = i;
        end;
    end;

    u1._totalSize = math.max(0, u1._totalSize - #p8.entries);
    p8.entries = {};
end;

function u1.acquire(p11, p12) -- Line: 71
    -- upvalues: getOrInitPool (copy), discardAllEntries (copy), u1 (copy), PoolHide (copy)
    if not p11 then
        return nil;
    end;

    local v13 = getOrInitPool(p11);
    local v14 = p11:GetAttribute("_PoolGen") or 0;

    if v14 ~= v13.gen then
        discardAllEntries(v13);
        v13.gen = v14;
    end;

    while #v13.entries > 0 do
        local table_remove_ret = table.remove(v13.entries);
        u1._totalSize = math.max(0, u1._totalSize - 1);
        local instance = table_remove_ret.instance;

        if instance and instance.Parent then
            PoolHide.show(instance, p12);
            v13.hits = v13.hits + 1;

            return instance;
        end;
    end;

    v13.misses = v13.misses + 1;

    return nil;
end;

function u1.release(u15, p16, p17, p18) -- Line: 95
    -- upvalues: getOrInitPool (copy), u1 (copy), PoolHide (copy)
    if not (u15 and p16) then
        return;
    end;

    if not u15.Parent then
        return;
    end;

    local v19 = getOrInitPool(p16);

    if p18 then
        local v20 = math.max(p18 or 0, 0) * u1.TTL * u1.CAP_SAFETY;
        v19.cap = math.ceil(v20) + u1.MIN_CAP;
    end;

    if u1._totalSize >= u1.MAX_POOL_TOTAL then
        pcall(function() -- Line: 101
            -- upvalues: u15 (copy)
            u15:Destroy();
        end);

        return;
    end;

    while #v19.entries >= v19.cap do
        local table_remove_ret = table.remove(v19.entries, 1);
        u1._totalSize = math.max(0, u1._totalSize - 1);

        if table_remove_ret and table_remove_ret.instance then
            pcall(function() -- Line: 60
                -- upvalues: table_remove_ret (copy)
                table_remove_ret.instance:Destroy();
            end);
        end;

        v19.evictions = v19.evictions + 1;
    end;

    PoolHide.hide(u15, p17);
    pcall(function() -- Line: 114
        -- upvalues: u15 (copy)
        local Part_IclesPooled = workspace.Terrain:FindFirstChild("Part_IclesPooled");

        if not Part_IclesPooled then
            Part_IclesPooled = Instance.new("Folder");
            Part_IclesPooled.Name = "Part_IclesPooled";
            Part_IclesPooled.Archivable = false;
            Part_IclesPooled.Parent = workspace.Terrain;
        end;

        u15.Parent = Part_IclesPooled;
    end);
    v19.entries[#v19.entries + 1] = {
        instance = u15,
        pooledAt = os.clock()
    };
    local v21 = u1;
    v21._totalSize = v21._totalSize + 1;

    if #v19.entries > v19.peakSize then
        v19.peakSize = #v19.entries;
    end;
end;

function u1.tickSweep(p22) -- Line: 121
    -- upvalues: u1 (copy)
    if p22 - u1._lastSweepAt < u1.SWEEP_INTERVAL then
        return;
    end;

    u1._lastSweepAt = p22;
    local v23 = 64;
    local v24 = nil;

    for i, v in pairs(u1._pools) do
        local v25 = i;
        local v26 = v;
        local v27 = 1;

        while v27 <= #v26.entries and v23 > 0 do
            local u28 = v26.entries[v27];
            local instance = u28.instance;

            if p22 - u28.pooledAt > u1.TTL and true or not (instance and instance.Parent) then
                if u28 and u28.instance then
                    pcall(function() -- Line: 60
                        -- upvalues: u28 (copy)
                        u28.instance:Destroy();
                    end);
                end;

                local v29 = #v26.entries;

                if v27 < v29 then
                    v26.entries[v27] = v26.entries[v29];
                end;

                v26.entries[v29] = nil;
                u1._totalSize = math.max(0, u1._totalSize - 1);
                v26.evictions = v26.evictions + 1;
                v23 = v23 - 1;
            else
                v27 = v27 + 1;
            end;
        end;

        if #v26.entries == 0 and not (v25 and v25.Parent) then
            v24 = v24 or {};
            v24[#v24 + 1] = v25;
        end;
    end;

    if v24 then
        for _, v in ipairs(v24) do
            u1._pools[v] = nil;
        end;
    end;
end;

function u1.bumpGen(u30) -- Line: 162
    if not u30 then
        return;
    end;

    local u31 = u30:GetAttribute("_PoolGen") or 0;
    pcall(function() -- Line: 165
        -- upvalues: u30 (copy), u31 (copy)
        u30:SetAttribute("_PoolGen", u31 + 1);
    end);
end;

function u1.flushSource(p32) -- Line: 169
    -- upvalues: u1 (copy), discardAllEntries (copy)
    local v33 = u1._pools[p32];

    if not v33 then
        return;
    end;

    discardAllEntries(v33);
    u1._pools[p32] = nil;
end;

function u1.flushAll() -- Line: 177
    -- upvalues: u1 (copy), discardAllEntries (copy)
    for _, v in pairs(u1._pools) do
        discardAllEntries(v);
    end;

    u1._pools = setmetatable({}, {
        __mode = "k"
    });
    u1._totalSize = 0;
end;

function u1.tickReport(p34) -- Line: 186
    -- upvalues: u1 (copy)
    if u1.REPORT_INTERVAL <= 0 then
        return;
    end;

    if p34 - u1._lastReportAt < u1.REPORT_INTERVAL then
        return;
    end;

    u1._lastReportAt = p34;
    local v35 = 0;
    local v36 = 0;
    local v37 = 0;
    local v38 = 0;
    local v39 = 0;
    local v40 = 0;

    for _ in pairs(u1._pools) do
        v35 = v35 + 1;
    end;

    for _, v in pairs(u1._pools) do
        v36 = v36 + #v.entries;
        v37 = v37 + v.hits;
        v38 = v38 + v.misses;
        v39 = v39 + v.evictions;

        if v40 < v.peakSize then
            v40 = v.peakSize;
        end;
    end;

    print(string.format("[Part-Icles Pool] sources=%d entries=%d/%d peak=%d hits=%d misses=%d (%.1f%% hit) evictions=%d", v35, v36, u1.MAX_POOL_TOTAL, v40, v37, v38, v37 + v38 > 0 and (v37 / (v37 + v38) * 100 or 0) or 0, v39));
end;

function u1.acquireOrClone(p41, p42, p43) -- Line: 209
    -- upvalues: u1 (copy)
    local v44;

    if p43 == false then
        v44 = p41:Clone();
    else
        v44 = u1.acquire(p41, p42) or p41:Clone();
    end;

    v44:SetAttribute("_PartIcleEmit", true);

    return v44;
end;

local function copyBare(p45, p46, p47) -- Line: 223
    -- upvalues: copyBare (copy)
    local v48 = p46 or {};
    local Instance_fromExisting_ret = Instance.fromExisting(p45);
    v48[p45] = Instance_fromExisting_ret;

    for _, child in ipairs(p45:GetChildren()) do
        if not child:GetAttribute("Transformed") then
            copyBare(child, v48, false).Parent = Instance_fromExisting_ret;
        end;
    end;

    if p47 == nil or p47 then
        for i, v in pairs(v48) do
            if i:IsA("Trail") or i:IsA("Beam") then
                local Attachment0 = i.Attachment0;
                local Attachment1 = i.Attachment1;

                if Attachment0 and v48[Attachment0] then
                    v.Attachment0 = v48[Attachment0];
                end;

                if Attachment1 and v48[Attachment1] then
                    v.Attachment1 = v48[Attachment1];
                end;
            end;
        end;
    end;

    return Instance_fromExisting_ret, v48;
end;

u1.copyBare = copyBare;
u1._cloneMaps = setmetatable({}, {
    __mode = "k"
});

function u1.acquireOrCopyBare(p49, p50, p51) -- Line: 252
    -- upvalues: copyBare (copy), u1 (copy)
    local v52, v53;

    if p51 == false then
        v52, v53 = copyBare(p49);
    else
        v52 = u1.acquire(p49, p50);

        if v52 then
            v53 = u1._cloneMaps[v52];
        else
            v52, v53 = copyBare(p49);
        end;
    end;

    if v53 then
        u1._cloneMaps[v52] = v53;
    end;

    v52:SetAttribute("_PartIcleEmit", true);

    return v52;
end;

function u1.restoreTrails(u54, u55) -- Line: 274
    -- upvalues: PoolHide (copy)
    task.delay(0, function() -- Line: 275
        -- upvalues: u54 (copy), PoolHide (ref), u55 (copy)
        if not (u54 and u54.Parent) then
            return;
        end;

        PoolHide.restoreTrails(u54, u55);
    end);
end;

function u1.tick(p56) -- Line: 282
    -- upvalues: u1 (copy)
    u1.tickSweep(p56);
    u1.tickReport(p56);
end;

function u1.stats() -- Line: 287
    -- upvalues: u1 (copy)
    local v57 = {
        totalSize = u1._totalSize,
        sources = {}
    };

    for i, v in pairs(u1._pools) do
        v57.sources[i] = {
            size = #v.entries,
            peakSize = v.peakSize,
            cap = v.cap,
            gen = v.gen,
            hits = v.hits,
            misses = v.misses,
            evictions = v.evictions
        };
    end;

    return v57;
end;

return u1;