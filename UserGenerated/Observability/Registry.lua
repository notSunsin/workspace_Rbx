-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observability = require(ReplicatedStorage.UserGenerated.Observability);
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec);
local Copies = require(ReplicatedStorage.UserGenerated.Observability.Copies);
local Op = Observability.Op;
local ValueType = Observability.ValueType;
local _, v1 = xpcall(function() -- Line: 39
    return workspace[nil];
end, function() -- Line: 41
    return debug.info(2, "f");
end);
local u4 = type(v1) ~= "function" and function(p2, p3) -- Line: 45
    return p2[p3];
end or v1;
local table_freeze_ret = table.freeze({
    Marked = false,
    Include = true,
    Children = table.freeze({})
});

local function newFilterNode(p5: boolean) -- Line: 59
    return {
        Marked = false,
        Children = {},
        Include = p5
    };
end;

local function buildFilter(p6) -- Line: 64
    if p6.FilterType ~= "Include" and p6.FilterType ~= "Exclude" then
        return nil;
    end;

    local v7 = p6.FilterType == "Include";
    local v8 = {
        Marked = false,
        Children = {},
        Include = v7
    };

    for _, v in p6.Filter do
        if type(v) == "string" then
            local v9 = v8;

            for i in string.gmatch(v, "[^%.]+") do
                local v10 = v8.Children[i];

                if not v10 then
                    v10 = {
                        Marked = false,
                        Children = {},
                        Include = v7
                    };
                    v8.Children[i] = v10;
                end;

                v8 = v10;
            end;

            if v8 == v9 then
                v8 = v9;
            else
                v8.Marked = true;
                v8 = v9;
            end;
        end;
    end;

    if v7 or next(v8.Children) ~= nil then
        return v8;
    end;

    return nil;
end;

local u11 = {};
u11.__index = u11;
u11.BuildFilter = buildFilter;

function u11.new(p12: any, p13: any, p14: function) -- Line: 100
    -- upvalues: Observability (copy), ValueType (copy), Copies (copy), u11 (copy), Codec (copy)
    local v15 = {};

    for i, v in p12.Classes do
        v15[v] = i - 1;
    end;

    local v16 = {};
    local v17 = {};
    local v18 = {};
    local v19 = {};

    for i, v in p12.ClassProps do
        local v20 = i;
        local v21 = {};
        local v22 = {};
        local v23 = {};
        local v24 = {};

        for _, v2 in v do
            local v25 = p12.Props[v2 + 1];

            if v25 then
                local v26 = {
                    Id = v2,
                    Name = v25.Name,
                    Type = v25.Type
                };

                if Observability.PolledProperties[v25.Name] then
                    table.insert(v21, v26);
                else
                    table.insert(v23, v26);
                    v24[v25.Name] = v2;
                end;

                if v25.Type == ValueType.Ref then
                    table.insert(v22, v26);
                end;
            end;
        end;

        v16[v20] = v23;
        v17[v20] = v24;

        if #v21 > 0 then
            v18[v20] = v21;
        end;

        if #v22 > 0 then
            v19[v20] = v22;
        end;
    end;

    local v27 = {};

    for i, v in p12.Props do
        v27[i - 1] = v.Type;
    end;

    local v28 = {
        AddFloor = 0,
        FilterAny = false,
        Stream = p13,
        Clock = p14,
        NextId = Observability.FirstInstanceId,
        ClassIndex = v15,
        UnknownClassId = #p12.Classes,
        ClassProps = v16,
        ClassPropsByName = v17,
        ClassPolled = v18,
        ClassRefs = v19,
        PropTypes = v27,
        Ids = setmetatable({}, {
            __mode = "k"
        }),
        ById = setmetatable({}, {
            __mode = "v"
        }),
        ParentIds = setmetatable({}, {
            __mode = "k"
        }),
        Defaults = {},
        Copies = Copies.new(#p12.Classes),
        Resolvers = {},
        UntrackHandlers = {},
        FilterRoots = {},
        FilterNodes = setmetatable({}, {
            __mode = "k"
        }),
        FilteredSignals = setmetatable({}, {
            __mode = "k"
        }),
        Pins = {},
        PinCounts = setmetatable({}, {
            __mode = "k"
        }),
        StandIns = {}
    };
    local u29 = setmetatable(v28, u11);
    Codec.setRefLookup(function(p30: userdata) -- Line: 182
        -- upvalues: u29 (copy)
        return u29.Ids[p30];
    end);

    return u29;
end;

function u11.SetFilter(p31: table, p32: userdata, p33: any) -- Line: 189
    -- upvalues: buildFilter (copy), table_freeze_ret (copy)
    local v34 = buildFilter(p33);
    p31.FilterRoots[p32] = v34;

    if v34 then
        p31.FilterAny = true;
    end;

    local v35;

    if p32 == workspace then
        v35 = workspace:FindFirstChildOfClass("Terrain");
    else
        v35 = nil;
    end;

    if v35 and v34 then
        local Terrain = v34.Children.Terrain;

        if Terrain == nil then
            local v36;

            if v34.Include then
                v36 = table_freeze_ret;
            else
                v36 = nil;
            end;

            p31.FilterRoots[v35] = v36;

            return;
        end;

        if Terrain.Marked then
            local v37;

            if v34.Include then
                v37 = nil;
            else
                v37 = table_freeze_ret;
            end;

            p31.FilterRoots[v35] = v37;

            return;
        end;

        p31.FilterRoots[v35] = Terrain;
    end;
end;

function u11.FilterRoot(p38: table, p39: userdata) -- Line: 210
    return p38.FilterRoots[p39];
end;

function u11.MatchFilter(p40: table, p41: userdata, p42: userdata?) -- Line: 217
    -- upvalues: u4 (ref), table_freeze_ret (copy)
    if not p40.FilterAny then
        return false, false;
    end;

    if p42 then
        p42 = p40.FilterRoots[p42] or p40.FilterNodes[p42];
    end;

    local v43 = false;
    local v44 = nil;
    local v45;

    if p42 then
        v45 = p42.Children[u4(p41, "Name")];

        if p42.Include then
            if v45 == nil then
                v45 = v44;
                v43 = true;
            elseif v45.Marked then
                v45 = v44;
            end;
        elseif v45 then
            if v45.Marked then
                v45 = v44;
                v43 = true;
            end;
        else
            v45 = v44;
        end;
    else
        v45 = v44;
    end;

    if p40.Pins[p41] then
        v45 = nil;
        v43 = false;
    elseif v43 and p40.PinCounts[p41] then
        v45 = table_freeze_ret;
        v43 = false;
    end;

    local v46 = p40.FilterNodes[p41] ~= v45;
    p40.FilterNodes[p41] = v45;

    return v43, v46;
end;

function u11.WatchFiltered(u47: table, u48: userdata, u49: function) -- Line: 250
    if u47.FilteredSignals[u48] then
        return;
    end;

    u47.FilteredSignals[u48] = u48:GetPropertyChangedSignal("Name"):Connect(function() -- Line: 254
        -- upvalues: u47 (copy), u48 (copy), u49 (copy)
        local v50 = u47.FilteredSignals[u48];

        if v50 then
            v50:Disconnect();
            u47.FilteredSignals[u48] = nil;
        end;

        u49();
    end);
end;

function u11.Rematch(p51: table, p52: userdata, p53: userdata?, p54: table, p55: table) -- Line: 267
    local v56, v57 = p51:MatchFilter(p52, p53);

    if v56 then
        return true;
    end;

    if not v57 then
        return false;
    end;

    local v58 = { p52 };

    while #v58 > 0 do
        local table_remove_ret = table.remove(v58);
        local v59 = p54[table_remove_ret];

        if v59 then
            for i in v59 do
                local v60, v61 = p51:MatchFilter(i, table_remove_ret);

                if v60 then
                    table.insert(p55, i);
                elseif v61 then
                    table.insert(v58, i);
                end;
            end;
        end;
    end;

    return false;
end;

local function unpinChain(p62: any, p63: table) -- Line: 298
    local PinCounts = p62.PinCounts;

    for _, v in p63 do
        local v64 = (PinCounts[v] or 1) - 1;

        if v64 <= 0 then
            v64 = nil;
        end;

        PinCounts[v] = v64;
    end;
end;

function u11.Pin(p65: table, p66: userdata) -- Line: 308
    local v67 = p65.Pins[p66];

    if v67 then
        local PinCounts = p65.PinCounts;

        for _, v in v67 do
            local v68 = (PinCounts[v] or 1) - 1;

            if v68 <= 0 then
                v68 = nil;
            end;

            PinCounts[v] = v68;
        end;
    end;

    local PinCounts = p65.PinCounts;
    local Parent = p66.Parent;
    local v69 = {};

    while Parent and (Parent ~= workspace and Parent ~= game) do
        table.insert(v69, Parent);
        PinCounts[Parent] = (PinCounts[Parent] or 0) + 1;
        Parent = Parent.Parent;
    end;

    p65.Pins[p66] = v69;
    local table_clone_ret = table.clone(v69);
    table.insert(table_clone_ret, p66);

    if v67 then
        table.move(v67, 1, #v67, #table_clone_ret + 1, table_clone_ret);
    end;

    return table_clone_ret;
end;

function u11.Unpin(p70: table, p71: userdata) -- Line: 331
    local v72 = p70.Pins[p71];

    if not v72 then
        return {};
    end;

    local PinCounts = p70.PinCounts;

    for _, v in v72 do
        local v73 = (PinCounts[v] or 1) - 1;

        if v73 <= 0 then
            v73 = nil;
        end;

        PinCounts[v] = v73;
    end;

    p70.Pins[p71] = nil;
    local table_clone_ret = table.clone(v72);
    table.insert(table_clone_ret, p71);

    return table_clone_ret;
end;

function u11.AddResolver(p74: table, p75: function) -- Line: 343
    table.insert(p74.Resolvers, p75);
end;

function u11.OnUntracked(p76: table, p77: function) -- Line: 349
    table.insert(p76.UntrackHandlers, p77);
end;

function u11.NotifyUntracked(p78: table, p79: userdata) -- Line: 353
    for _, v in p78.UntrackHandlers do
        v(p79);
    end;
end;

function u11.Resolve(p80: table, p81: userdata, p82: number?) -- Line: 360
    local v83 = p80.Ids[p81];

    if v83 then
        return v83;
    end;

    for _, v in p80.Resolvers do
        local v84 = v(p81, p82);

        if v84 then
            return v84;
        end;
    end;

    return nil;
end;

function u11.ResolveRefs(p85: table, p86: userdata, p87: string, p88: number?) -- Line: 376
    -- upvalues: u4 (ref)
    local v89 = p85.ClassRefs[p87];

    if not v89 then
        return;
    end;

    for _, v in v89 do
        local success, result = pcall(u4, p86, v.Name);

        if success and typeof(result) == "Instance" then
            p85:Resolve(result, p88);
        end;
    end;
end;

function u11.Allocate(p90: table, p91: userdata, p92: number) -- Line: 389
    local NextId = p90.NextId;
    p90.NextId = p90.NextId + 1;
    p90.Ids[p91] = NextId;
    p90.ById[NextId] = p91;
    p90.ParentIds[p91] = p92;

    return NextId;
end;

function u11.Free(p93: table, p94: userdata) -- Line: 398
    local v95 = p93.Ids[p94];

    if v95 then
        p93.ById[v95] = nil;
        p93.Copies:Forget(v95);
    end;

    p93.Ids[p94] = nil;
    p93.ParentIds[p94] = nil;
end;

function u11.StandIn(p96: table, p97: userdata) -- Line: 411
    -- upvalues: Observability (copy)
    local Workspace = Observability.RootId.Workspace;

    if p97 == workspace then
        return Workspace;
    end;

    local v98 = p96.StandIns[p97];

    if v98 then
        return v98;
    end;

    local v99 = p96:Allocate(p97, Workspace);
    p96:AddTime(p96.Clock());
    local W = p96.Stream.W;
    p96.Copies:WriteHead(W, v99, Workspace, p96.UnknownClassId, p97.Name, false);
    W:u16(0);
    p96.Stream:EndRecord();
    p96.StandIns[p97] = v99;

    return v99;
end;

function u11.AddTime(p100: table, p101: number?) -- Line: 432
    local v102 = p101 or p100.Clock();
    local math_max_ret = math.max(v102, p100.AddFloor);
    p100.AddFloor = math_max_ret;
    p100.Stream:Time(math_max_ret);

    return math_max_ret;
end;

function u11.DefaultsFor(p103: table, p104: string) -- Line: 440
    -- upvalues: Op (copy), Codec (copy), u4 (ref), ValueType (copy)
    local v105 = p103.Defaults[p104];

    if v105 ~= nil then
        return v105 or nil;
    end;

    local v106 = p103.ClassIndex[p104];
    local v107 = p103.ClassProps[p104];
    local v108 = p103.ClassPolled[p104];
    local success, result = pcall(Instance.new, p104);

    if not (success and (v106 and (v107 or v108))) then
        if success then
            result:Destroy();
        end;

        p103.Defaults[p104] = false;

        return nil;
    end;

    local W = p103.Stream.W;
    W:u8(Op.Defaults);
    Codec.varuint(W, v106);
    local len = W.len;
    W:u16(0);
    local v109 = {};
    local v110 = 0;

    for _, v in { v107 or {}, v108 or {} } do
        for _, v2 in v do
            local success2, result2 = pcall(u4, result, v2.Name);

            if success2 and v2.Type ~= ValueType.Ref then
                v109[v2.Id] = result2;
                Codec.varuint(W, v2.Id);
                Codec.writeValue(W, v2.Type, result2);
                v110 = v110 + 1;
            end;
        end;
    end;

    W:patchU16(len, v110);
    p103.Stream:EndRecord();
    result:Destroy();
    p103.Defaults[p104] = v109;

    return v109;
end;

function u11.Destroy(p111) -- Line: 483
    -- upvalues: Codec (copy)
    table.clear(p111.Ids);
    table.clear(p111.ById);
    table.clear(p111.ParentIds);
    table.clear(p111.Resolvers);
    table.clear(p111.UntrackHandlers);

    for _, v in p111.FilteredSignals do
        v:Disconnect();
    end;

    table.clear(p111.FilteredSignals);
    table.clear(p111.FilterNodes);
    table.clear(p111.FilterRoots);
    table.clear(p111.Pins);
    table.clear(p111.PinCounts);
    table.clear(p111.StandIns);
    Codec.setRefLookup(function() -- Line: 498
        return nil;
    end);
end;

return u11;