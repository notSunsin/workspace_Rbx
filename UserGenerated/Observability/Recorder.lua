-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observability = require(ReplicatedStorage.UserGenerated.Observability);
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec);
local Copies = require(ReplicatedStorage.UserGenerated.Observability.Copies);
local Relevance = require(ReplicatedStorage.UserGenerated.Observability.Relevance);
local Sequences = require(ReplicatedStorage.UserGenerated.Observability.Sequences);
local Styles = require(ReplicatedStorage.UserGenerated.Observability.Styles);
local Op = Observability.Op;
local ValueType = Observability.ValueType;
local ShownBy = Relevance.ShownBy;
local _, v1 = xpcall(function() -- Line: 81
    return workspace[nil];
end, function() -- Line: 83
    return debug.info(2, "f");
end);
local u4 = type(v1) ~= "function" and function(p2, p3) -- Line: 87
    return p2[p3];
end or v1;
local u5 = {
    Image = true,
    ImageTransparency = true
};
local u6 = {
    [ValueType.ColorSequence] = 250,
    [ValueType.NumberSequence] = 250
};
local u7 = {
    BackgroundTransparency = true,
    TextTransparency = true,
    TextStrokeTransparency = true,
    ImageTransparency = true,
    GroupTransparency = true,
    Transparency = true,
    BackgroundColor3 = true,
    TextColor3 = true,
    ImageColor3 = true,
    Color = true,
    Visible = true
};
local u8 = {
    [ValueType.Float32] = true,
    [ValueType.Float64] = true,
    [ValueType.UDim] = true,
    [ValueType.UDim2] = true,
    [ValueType.Vector2] = true,
    [ValueType.Vector3] = true,
    [ValueType.Color3] = true,
    [ValueType.Rect] = true,
    [ValueType.NumberRange] = true,
    [ValueType.ColorSequence] = true,
    [ValueType.NumberSequence] = true
};
local u9 = {
    TextLabel = true,
    TextButton = true
};

local function readProp(p10: userdata, p11: string, p12: string) -- Line: 157
    -- upvalues: u9 (copy), u4 (ref), Styles (copy)
    if p12 == "Text" and u9[p11] then
        return pcall(u4, p10, "LocalizedText");
    end;

    return Styles.Read(p10, p12);
end;

local function isExcluded(p13: userdata) -- Line: 182
    return p13:IsA("PVInstance") or (p13:FindFirstAncestorWhichIsA("PVInstance") ~= nil and true or p13:FindFirstAncestorWhichIsA("ViewportFrame") ~= nil);
end;

local function isWorldGui(p14: userdata) -- Line: 188
    return p14:IsA("BillboardGui") or p14:IsA("SurfaceGui");
end;

local u15 = {};
u15.__index = u15;

function u15.new(p16: any, p17: boolean, p18: boolean) -- Line: 197
    -- upvalues: Players (copy), Codec (copy), u15 (copy)
    local v19 = {
        PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui"),
        Registry = p16,
        RecordPlayerGui = p17,
        WorldGuis = p18,
        Stream = p16.Stream,
        ValueScratch = Codec.newWriter(256),
        Clock = p16.Clock,
        ClassIndex = p16.ClassIndex,
        UnknownClassId = p16.UnknownClassId,
        ClassProps = p16.ClassProps,
        ClassPropsByName = p16.ClassPropsByName,
        ClassPolled = p16.ClassPolled,
        PropTypes = p16.PropTypes,
        Ids = p16.Ids,
        ById = p16.ById,
        ParentIds = p16.ParentIds,
        Signals = setmetatable({}, {
            __mode = "k"
        }),
        Kids = setmetatable({}, {
            __mode = "k"
        }),
        Pending = {},
        PendingTime = {},
        PolledValues = setmetatable({}, {
            __mode = "k"
        }),
        Polling = setmetatable({}, {
            __mode = "k"
        }),
        PollNext = setmetatable({}, {
            __mode = "k"
        }),
        PollGap = setmetatable({}, {
            __mode = "k"
        }),
        PollSeen = setmetatable({}, {
            __mode = "k"
        }),
        PollHeld = setmetatable({}, {
            __mode = "k"
        }),
        Held = setmetatable({}, {
            __mode = "k"
        }),
        LastSent = setmetatable({}, {
            __mode = "k"
        }),
        Animating = setmetatable({}, {
            __mode = "k"
        }),
        SeqStates = setmetatable({}, {
            __mode = "k"
        }),
        SeqHolders = setmetatable({}, {
            __mode = "v"
        }),
        SentUDim2 = setmetatable({}, {
            __mode = "k"
        }),
        Defaults = p16.Defaults,
        DeferredParent = setmetatable({}, {
            __mode = "k"
        }),
        DeferredKids = setmetatable({}, {
            __mode = "k"
        }),
        DeferredSignals = setmetatable({}, {
            __mode = "k"
        }),
        WaitingRefs = setmetatable({}, {
            __mode = "k"
        }),
        OnChanged = setmetatable({}, {
            __mode = "k"
        }),
        StyledChecks = setmetatable({}, {
            __mode = "k"
        }),
        RicherRoots = setmetatable({}, {
            __mode = "k"
        }),
        RicherSignals = setmetatable({}, {
            __mode = "k"
        }),
        RicherQueued = setmetatable({}, {
            __mode = "k"
        }),
        DirtyStructure = {},
        DirtyName = {},
        DirtyProps = {},
        DirtyFirst = {},
        RecheckSubtree = {},
        RecheckChildren = {},
        Memo = nil,
        Connections = {},
        Destroyed = false
    };
    local u20 = setmetatable(v19, u15);
    local v21 = {};

    for _, v in p16.ClassProps do
        for _, v2 in v do
            v21[v2.Id] = v2;
        end;
    end;

    u20.PropEntries = v21;
    p16:AddResolver(function(p22: userdata, p23: number?) -- Line: 296
        -- upvalues: u20 (copy)
        return u20:_track(p22, p23);
    end);
    p16:OnUntracked(function(p24: userdata) -- Line: 300
        -- upvalues: u20 (copy)
        local v25 = u20.Kids[p24];

        if v25 then
            for i in v25 do
                u20:_untrackTree(i, p24);
            end;
        end;

        u20:_undeferKids(p24);
    end);

    return u20;
end;

function u15._inDomain(p26: table, p27: userdata) -- Line: 314
    if p27:IsDescendantOf(p26.PlayerGui) then
        local RecordPlayerGui = p26.RecordPlayerGui;

        if RecordPlayerGui then
            local v28 = p27:IsA("PVInstance") or (p27:FindFirstAncestorWhichIsA("PVInstance") ~= nil and true or p27:FindFirstAncestorWhichIsA("ViewportFrame") ~= nil);
            RecordPlayerGui = not v28;
        end;

        return RecordPlayerGui;
    end;

    if not p26.WorldGuis then
        return false;
    end;

    local v29;

    if p27:IsA("BillboardGui") or p27:IsA("SurfaceGui") then
        v29 = p27;
    else
        v29 = p27:FindFirstAncestorWhichIsA("LayerCollector");
    end;

    local v30;

    if v29 == nil then
        v30 = false;
    else
        v30 = (v29:IsA("BillboardGui") or v29:IsA("SurfaceGui")) and (not p27:IsA("PVInstance") and v29:IsDescendantOf(workspace)) and p27:FindFirstAncestorWhichIsA("ViewportFrame") == nil;
    end;

    return v30;
end;

local function kidsOf(p31: any, p32: userdata) -- Line: 329
    local v33 = p31.Kids[p32];

    if not v33 then
        v33 = setmetatable({}, {
            __mode = "k"
        });
        p31.Kids[p32] = v33;
    end;

    return v33;
end;

function u15._watchChildren(u34: table, p35: userdata, p36: table) -- Line: 339
    local function mark(p37: userdata) -- Line: 340
        -- upvalues: u34 (copy)
        u34.DirtyStructure[p37] = u34.Clock();
    end;

    table.insert(p36, p35.ChildAdded:Connect(mark));
    table.insert(p36, p35.ChildRemoved:Connect(mark));
end;

function u15._queueChildren(p38: table, p39: userdata, p40: number) -- Line: 349
    local Children = p39:GetChildren();
    local Pending = p38.Pending;
    local PendingTime = p38.PendingTime;

    for i = #Children, 1, -1 do
        table.insert(Pending, Children[i]);
        table.insert(PendingTime, p40);
        local _ = i;
    end;
end;

function u15._drain(p41: table, p42: number?) -- Line: 360
    -- upvalues: Relevance (copy)
    local Pending = p41.Pending;
    local PendingTime = p41.PendingTime;

    if #Pending == 0 then
        return true;
    end;

    local v43 = p41.Memo == nil;
    local v44;

    if v43 then
        p41.Memo = Relevance.NewMemo();
        v44 = true;
    else
        v44 = true;
    end;

    while #Pending > 0 do
        if p42 and p42 <= os.clock() then
            v44 = false;
            break;
        end;

        p41:_track(table.remove(Pending), (table.remove(PendingTime)));
    end;

    if v43 then
        p41.Memo = nil;
    end;

    return v44;
end;

function u15._parentId(p45: table, p46: userdata, p47: number?) -- Line: 386
    -- upvalues: u4 (ref)
    local v48 = u4(p46, "Parent");

    if v48 == p45.PlayerGui then
        return 0;
    end;

    if v48 == nil then
        return nil;
    end;

    return p45.Ids[v48] or p45.Registry:Resolve(v48, p47);
end;

function u15._track(u49: table, u50: userdata, p51: number?) -- Line: 401
    -- upvalues: u4 (ref), Observability (copy), Relevance (copy), kidsOf (copy), ShownBy (copy), u9 (copy), Styles (copy), Sequences (copy), ValueType (copy), Copies (copy), Codec (copy), u5 (copy)
    local v52 = u49.Ids[u50];

    if v52 then
        return v52;
    end;

    local v53 = u4(u50, "ClassName");

    if v53 == "StyleLink" then
        local v54 = u4(u50, "Parent");

        if v54 and (u49.Signals[v54] and u4(v54, "ClassName") == "TextLabel") then
            u49:_refreshRicher(v54);
        end;

        return nil;
    end;

    if not (u49.ClassProps[v53] or (u49.ClassPolled[v53] or v53 == "Folder")) then
        return nil;
    end;

    if Observability.IsAudio(u50) then
        return nil;
    end;

    if not u49:_inDomain(u50) then
        return nil;
    end;

    local v55 = u49:_parentId(u50, p51);

    if v55 == nil then
        return nil;
    end;

    local v56 = u4(u50, "Parent");

    if u49.Registry:MatchFilter(u50, v56) then
        u49:_watchFiltered(u50);

        return nil;
    end;

    u49:_markRicher(u50, false);
    local Memo = u49.Memo;
    local v57 = Relevance.IsHidden(u50, u49.PlayerGui, Memo);

    if v57 and Relevance.SubtreeHidden(u50, u49.PlayerGui) then
        if u49.DeferredParent[u50] ~= v56 or u49.DeferredSignals[u50] ~= nil ~= Relevance.HidesSubtree(u50) then
            u49:_undefer(u50);
            u49:_defer(u50, v56);
        end;

        return nil;
    end;

    u49:_undefer(u50);
    u49.Registry:ResolveRefs(u50, v53, p51);

    if u49.Ids[u50] then
        return u49.Ids[u50];
    end;

    local v58 = u49.Registry:Allocate(u50, v55);
    kidsOf(u49, v56)[u50] = true;
    local v59 = u49.Registry:AddTime(p51);
    local v60 = u49.WaitingRefs[u50];

    if v60 then
        u49.WaitingRefs[u50] = nil;

        for i, v in v60 do
            if u49.Ids[i] then
                local v61 = i;

                for i2 in v do
                    u49:_markDirty(v61, i2, v59);
                end;
            end;
        end;
    end;

    local v62 = u49.Registry:DefaultsFor(v53);
    local v63;

    if v57 then
        v63 = nil;
    else
        v63 = Relevance.Suppressed(u50, Memo);
    end;

    local W = u49.Stream.W;
    local v64, v65 = u49.Registry.Copies:WriteHead(W, v58, v55, u49.ClassIndex[v53] or u49.UnknownClassId, u4(u50, "Name"), not v57);
    local Ids = u49.Ids;
    local v66 = nil;
    local v67 = u49.ClassProps[v53];
    local u68 = u49.ClassPolled[v53];
    local len = W.len;
    W:u16(0);
    local v69 = 0;

    if v67 then
        for _, v in v67 do
            local Name = v.Name;

            if not v57 or ShownBy[Name] then
                if v63 and v63[Name] then
                    v66 = v66 or {};
                    v66[v.Id] = true;
                else
                    local v70, v71;

                    if Name == "Text" and u9[v53] then
                        v70, v71 = pcall(u4, u50, "LocalizedText");
                    else
                        v70, v71 = Styles.Read(u50, Name);
                    end;

                    if v70 then
                        if Sequences.Types[v.Type] then
                            u49:_setSequence(u50, v.Id, Sequences.keypoints(v.Type, v71), v59);
                        end;

                        local v72;

                        if v.Type == ValueType.Ref then
                            local refValue = Copies.refValue;
                            local v73;

                            if typeof(v71) == "Instance" then
                                v73 = Ids[v71];
                            else
                                v73 = nil;
                            end;

                            v72 = refValue(v73, v58);
                        else
                            v72 = v71;
                        end;

                        if v.Type == ValueType.Ref and (typeof(v71) == "Instance" and not Ids[v71]) then
                            u49:_waitRef(v71, u50, v.Id);
                        end;

                        if Copies.differs(v64, v65, v62, v.Id, v71, v72) then
                            Codec.varuint(W, v.Id);
                            Codec.writeValue(W, v.Type, v71);
                            v69 = v69 + 1;
                        end;
                    end;
                end;
            end;
        end;
    end;

    if u68 then
        local v74 = {};

        for _, v in u68 do
            local v75, v76 = Styles.Read(u50, v.Name);

            if v75 then
                v74[v.Id] = v76;

                if Copies.differs(v64, v65, v62, v.Id, v76, v76) then
                    Codec.varuint(W, v.Id);
                    Codec.writeValue(W, v.Type, v76);
                    v69 = v69 + 1;
                end;
            end;
        end;

        u49.PolledValues[u50] = v74;

        if v57 or v63 and v63.IsLoaded then
            u49.PollHeld[u50] = true;
        else
            u49:_armPoll(u50);
        end;
    end;

    W:patchU16(len, v69);
    u49.Stream:EndRecord();

    if v57 then
        u49.Held[u50] = true;
    elseif v66 then
        u49.Held[u50] = v66;
    end;

    local u77 = Relevance.IsLayout(u50);

    if u77 and u50.Parent then
        u49.RecheckChildren[u50.Parent] = v59;
    end;

    local u78 = u49.ClassPropsByName[v53];
    local u79 = (u50:IsA("BillboardGui") or u50:IsA("SurfaceGui")) and not u50:IsDescendantOf(u49.PlayerGui);
    local v80 = {};
    u49.Signals[u50] = v80;

    if v53 ~= "ViewportFrame" then
        u49:_watchChildren(u50, v80);
        u49:_queueChildren(u50, v59);
    end;

    local function changed(p81: string) -- Line: 565
        -- upvalues: u49 (copy), u50 (copy), u79 (copy), u78 (copy), ShownBy (ref), u68 (copy), u5 (ref), u77 (copy)
        if p81 ~= "Name" then
            if p81 == "Parent" and u79 then
                u49.DirtyStructure[u50] = u49.Clock();

                return;
            end;

            if u78 then
                local v82 = p81 == "LocalizedText" and "Text" or p81;
                local v83 = u78[v82];

                if v83 and (not ShownBy[v82] and u49.Held[u50] == true) then
                    if u68 and (u5[v82] and not u49.Polling[u50]) then
                        u49.PollHeld[u50] = true;

                        return;
                    end;
                elseif v83 then
                    local v84 = u49.Clock();
                    local v85 = u49.DirtyProps[u50];

                    if not v85 then
                        v85 = {};
                        u49.DirtyProps[u50] = v85;
                    end;

                    v85[v83] = v84;
                    local v86 = u49.DirtyFirst[u50];

                    if not v86 then
                        v86 = {};
                        u49.DirtyFirst[u50] = v86;
                    end;

                    if v86[v83] == nil then
                        v86[v83] = v84;
                    end;

                    if u68 and u5[v82] then
                        u49:_armPoll(u50);
                    end;

                    if ShownBy[v82] then
                        u49.RecheckSubtree[u50] = v84;

                        return;
                    end;

                    if u77 and (v82 == "SortOrder" and u50.Parent) then
                        u49.RecheckChildren[u50.Parent] = v84;
                    end;
                end;
            end;

            return;
        end;

        u49.DirtyName[u50] = u49.Clock();

        if u49.Registry.FilterAny then
            u49.DirtyStructure[u50] = u49.Clock();
        end;

        u49:_renamedRicher(u50);
    end;

    table.insert(v80, u50.Changed:Connect(changed));
    u49.OnChanged[u50] = changed;
    u49:_watchStyled(u50, v53, true);

    return v58;
end;

function u15._watchStyled(u87: table, u88: userdata, u89: string, p90: boolean) -- Line: 627
    -- upvalues: Styles (copy), u9 (copy), u4 (ref)
    local v91 = u87.StyledChecks[u88];

    if v91 then
        return v91;
    end;

    local u92 = Styles.Affected[u88];
    local u93 = u87.OnChanged[u88];
    local v94 = u87.Signals[u88];

    if not (u92 and (u93 and v94)) then
        return nil;
    end;

    local u95 = {};

    if p90 then
        for i in u92 do
            local v96, v97;

            if i == "Text" and u9[u89] then
                v96, v97 = pcall(u4, u88, "LocalizedText");
            else
                v96, v97 = Styles.Read(u88, i);
            end;

            if v96 then
                u95[i] = v97;
            end;
        end;
    end;

    local function check() -- Line: 647
        -- upvalues: u92 (copy), u88 (copy), u89 (copy), u9 (ref), u4 (ref), Styles (ref), u95 (copy), u93 (copy)
        for i in u92 do
            local v98 = u88;
            local v99, v100;

            if i == "Text" and u9[u89] then
                v99, v100 = pcall(u4, v98, "LocalizedText");
            else
                v99, v100 = Styles.Read(v98, i);
            end;

            if v99 and v100 ~= u95[i] then
                u95[i] = v100;
                u93(i);
            end;
        end;
    end;

    u87.StyledChecks[u88] = check;
    table.insert(v94, u88.StyledPropertiesChanged:Connect(function() -- Line: 659
        -- upvalues: u87 (copy), u88 (copy), check (copy)
        u87:_markRicher(u88, false);
        check();
    end));

    return check;
end;

function u15._richerRoot(p101: table, p102: userdata) -- Line: 669
    -- upvalues: u4 (ref)
    local RicherRoots = p101.RicherRoots;

    if next(RicherRoots) == nil then
        return nil, nil;
    end;

    local v103 = u4(p102, "Parent");

    for i = 1, 3 do
        if v103 == nil then
            return nil, nil;
        end;

        local v104 = RicherRoots[v103];

        if v104 then
            if v104.Depth < i then
                return nil, nil;
            end;

            return v103, v104;
        end;

        v103 = u4(v103, "Parent");
        local _ = i;
    end;

    return nil, nil;
end;

function u15._markRicher(p105: table, p106: userdata, p107: boolean) -- Line: 693
    -- upvalues: Styles (copy)
    local v108, v109 = p105:_richerRoot(p106);

    if v108 and (Styles.MarkRicher(p106, v108, v109, p105.ClassPropsByName) and p107) then
        p105:_restyle(p106);
    end;
end;

function u15._restyle(p110: table, p111: userdata) -- Line: 702
    -- upvalues: u4 (ref)
    local v112 = p110:_watchStyled(p111, u4(p111, "ClassName"), false);

    if v112 then
        v112();
    end;
end;

function u15._markRicherBelow(p113: table, p114: userdata, p115: userdata, p116: any, p117: number) -- Line: 710
    -- upvalues: Styles (copy)
    local v118 = p113.Kids[p114];

    if not v118 then
        return;
    end;

    for i in v118 do
        if Styles.MarkRicher(i, p115, p116, p113.ClassPropsByName) then
            p113:_restyle(i);
        end;

        if p117 > 1 then
            p113:_markRicherBelow(i, p115, p116, p117 - 1);
        end;
    end;
end;

function u15._renamedRicher(p119: table, p120: userdata) -- Line: 727
    local v121, v122 = p119:_richerRoot(p120);

    if not v121 then
        return;
    end;

    p119:_markRicher(p120, true);
    p119:_markRicherBelow(p120, v121, v122, 2);
end;

function u15._refreshRicher(u123: table, u124: userdata) -- Line: 739
    -- upvalues: Styles (copy)
    local v125 = u123.RicherSignals[u124];

    if v125 then
        for _, v in v125 do
            v:Disconnect();
        end;
    end;

    local v126 = {};
    u123.RicherSignals[u124] = v126;

    local function again() -- Line: 748
        -- upvalues: u123 (copy), u124 (copy)
        u123:_queueRicher(u124);
    end;

    local v127 = u124:FindFirstChildWhichIsA("StyleLink");
    local v128;

    if v127 then
        local PropertyChangedSignal = v127:GetPropertyChangedSignal("StyleSheet");
        table.insert(v126, PropertyChangedSignal:Connect(again));
        table.insert(v126, v127.AncestryChanged:Connect(again));
        local StyleSheet = v127.StyleSheet;

        if StyleSheet then
            table.insert(v126, StyleSheet.DescendantAdded:Connect(again));
        end;

        local v129;
        v128, v129 = Styles.Richer(v127);

        for _, v in v129 do
            local PropertyChangedSignal2 = v:GetPropertyChangedSignal("Selector");
            table.insert(v126, PropertyChangedSignal2:Connect(again));
        end;
    else
        v128 = nil;
    end;

    u123.RicherRoots[u124] = v128;

    if v128 then
        u123:_markRicherBelow(u124, u124, v128, v128.Depth);
    end;
end;

function u15._queueRicher(u130: table, u131: userdata) -- Line: 774
    if u130.RicherQueued[u131] then
        return;
    end;

    u130.RicherQueued[u131] = true;
    task.defer(function() -- Line: 779
        -- upvalues: u130 (copy), u131 (copy)
        u130.RicherQueued[u131] = nil;

        if not u130.Destroyed and u130.Signals[u131] then
            u130:_refreshRicher(u131);
        end;
    end);
end;

function u15._stopRicher(p132: table, p133: userdata) -- Line: 787
    p132.RicherRoots[p133] = nil;
    p132.RicherQueued[p133] = nil;
    local v134 = p132.RicherSignals[p133];

    if v134 then
        for _, v in v134 do
            v:Disconnect();
        end;

        p132.RicherSignals[p133] = nil;
    end;
end;

function u15._watchFiltered(u135: table, u136: userdata) -- Line: 800
    u135.Registry:WatchFiltered(u136, function() -- Line: 801
        -- upvalues: u135 (copy), u136 (copy)
        if not u135.Destroyed then
            u135.DirtyStructure[u136] = u135.Clock();
        end;
    end);
end;

function u15._defer(u137: table, u138: userdata, p139: userdata) -- Line: 811
    -- upvalues: Relevance (copy), Styles (copy)
    u137.DeferredParent[u138] = p139;
    local v140 = u137.DeferredKids[p139];

    if not v140 then
        v140 = setmetatable({}, {
            __mode = "k"
        });
        u137.DeferredKids[p139] = v140;
    end;

    v140[u138] = true;

    if not Relevance.HidesSubtree(u138) then
        return;
    end;

    local v141 = Styles.Affected[u138];
    local v142 = {};

    local function retry() -- Line: 822
        -- upvalues: u137 (copy), u138 (copy)
        if not u137.Destroyed then
            u137.DirtyStructure[u138] = u137.Clock();
        end;
    end;

    for _, v in Relevance.ShownByOf(u138) do
        local PropertyChangedSignal = u138:GetPropertyChangedSignal(v);
        table.insert(v142, PropertyChangedSignal:Connect(retry));

        if v141 and v141[v] then
            table.insert(v142, u138.StyledPropertiesChanged:Connect(retry));
            v141 = nil;
        end;
    end;

    u137.DeferredSignals[u138] = v142;
end;

function u15._undefer(p143: table, p144: userdata) -- Line: 839
    local v145 = p143.DeferredParent[p144];

    if v145 == nil then
        return;
    end;

    p143.DeferredParent[p144] = nil;
    local v146 = p143.DeferredKids[v145];

    if v146 then
        v146[p144] = nil;
    end;

    local v147 = p143.DeferredSignals[p144];

    if v147 then
        for _, v in v147 do
            v:Disconnect();
        end;

        p143.DeferredSignals[p144] = nil;
    end;
end;

function u15._undeferKids(p148: table, p149: userdata) -- Line: 858
    local v150 = p148.DeferredKids[p149];

    if v150 then
        for i in v150 do
            p148:_undefer(i);
        end;

        p148.DeferredKids[p149] = nil;
    end;
end;

function u15._waitRef(p151: table, p152: userdata, p153: userdata, p154: number) -- Line: 869
    local v155 = p151.WaitingRefs[p152];

    if not v155 then
        v155 = setmetatable({}, {
            __mode = "k"
        });
        p151.WaitingRefs[p152] = v155;
    end;

    local v156 = v155[p153];

    if not v156 then
        v156 = {};
        v155[p153] = v156;
    end;

    v156[p154] = true;
end;

function u15._markDirty(p157: table, p158: userdata, p159: number, p160: number) -- Line: 883
    local v161 = p157.DirtyProps[p158];

    if not v161 then
        v161 = {};
        p157.DirtyProps[p158] = v161;
    end;

    v161[p159] = p160;
end;

function u15._armPoll(p162: table, p163: userdata) -- Line: 893
    p162.Polling[p163] = os.clock() + 0.5;
    p162.PollNext[p163] = nil;
    p162.PollGap[p163] = nil;
    p162.PollSeen[p163] = nil;
    p162.PollHeld[p163] = nil;
end;

function u15._stopPoll(p164: table, p165: userdata) -- Line: 901
    p164.Polling[p165] = nil;
    p164.PollNext[p165] = nil;
    p164.PollGap[p165] = nil;
    p164.PollSeen[p165] = nil;
end;

function u15._untrack(p166: table, p167: userdata) -- Line: 908
    p166.Registry:Free(p167);
    p166:_undeferKids(p167);
    p166.DirtyProps[p167] = nil;
    p166.DirtyFirst[p167] = nil;
    p166.DirtyName[p167] = nil;
    p166.PolledValues[p167] = nil;
    p166:_stopPoll(p167);
    p166.PollHeld[p167] = nil;
    p166.Held[p167] = nil;
    p166.LastSent[p167] = nil;
    p166.Animating[p167] = nil;
    p166.SentUDim2[p167] = nil;
    p166.OnChanged[p167] = nil;
    p166.StyledChecks[p167] = nil;
    p166:_stopRicher(p167);
    local v168 = p166.SeqStates[p167];

    if v168 then
        for _, v in v168 do
            if p166.SeqHolders[v.Key] == p167 then
                p166.SeqHolders[v.Key] = nil;
            end;
        end;

        p166.SeqStates[p167] = nil;
    end;

    local v169 = p166.Signals[p167];

    if v169 then
        for _, v in v169 do
            v:Disconnect();
        end;

        p166.Signals[p167] = nil;
    end;
end;

function u15._untrackTree(p170: table, p171: userdata, p172: userdata?) -- Line: 944
    local v173;

    if p172 then
        local v174 = p170.Kids[p172];

        if v174 then
            v174[p171] = nil;
            v173 = { p171 };
        else
            v173 = { p171 };
        end;
    else
        v173 = { p171 };
    end;

    while #v173 > 0 do
        local table_remove_ret = table.remove(v173);
        local v175 = p170.Kids[table_remove_ret];

        if v175 then
            for i in v175 do
                table.insert(v173, i);
            end;

            p170.Kids[table_remove_ret] = nil;
        end;

        p170:_untrack(table_remove_ret);
    end;
end;

function u15._setSequence(p176: table, p177: userdata, p178: number, p179: any, p180: number) -- Line: 965
    -- upvalues: Sequences (copy)
    local v181 = p176.SeqStates[p177];

    if not v181 then
        v181 = {};
        p176.SeqStates[p177] = v181;
    end;

    local v182 = v181[p178];

    if v182 and p176.SeqHolders[v182.Key] == p177 then
        p176.SeqHolders[v182.Key] = nil;
    end;

    local v183 = `{p178}:{Sequences.key(p179)}`;
    v181[p178] = {
        Keypoints = p179,
        Key = v183,
        Time = p180
    };
    p176.SeqHolders[v183] = p177;
end;

function u15._writeSequence(p184: table, p185: table) -- Line: 983
    -- upvalues: Sequences (copy), Op (copy), Codec (copy)
    local Inst = p185.Inst;
    local Id = p185.Id;
    local PropId = p185.PropId;
    local Type = p185.Type;
    local T = p185.T;
    local v186 = Sequences.keypoints(Type, p185.Value);
    local v187;

    if p185.LerpMs then
        local math_round_ret = math.round(p185.LerpMs / 10);
        v187 = math.clamp(math_round_ret, 1, 255);
    else
        v187 = 0;
    end;

    local Stream = p184.Stream;
    Stream:Time(T);
    local W = Stream.W;
    local v188 = p184.SeqStates[Inst];

    if v188 then
        v188 = v188[PropId];
    end;

    local v189, v190;

    if v188 then
        v189, v190 = Sequences.findShift(v188.Keypoints, v186, Type);
    else
        v189 = nil;
        v190 = nil;
    end;

    if v189 and v190 then
        Sequences.writeShift(W, Id, PropId, v187, Type, v189, v190);
        Stream:EndRecord();
        p184:_setSequence(Inst, PropId, v190, T);

        return;
    end;

    local v191 = p184.SeqHolders[`{PropId}:{Sequences.key(v186)}`];
    local v192;

    if v191 then
        if v191 == Inst then
            v192 = false;
        else
            v192 = p184.Ids[v191];
        end;
    else
        v192 = v191;
    end;

    local v193;

    if v192 then
        v193 = p184.SeqStates[v191];
    else
        v193 = v192;
    end;

    if v193 then
        v193 = v193[PropId];
    end;

    if v192 and (v193 and v193.Time <= T) then
        Sequences.writeCopy(W, Id, PropId, v187, v192);
        Stream:EndRecord();
        p184:_setSequence(Inst, PropId, v193.Keypoints, T);

        return;
    end;

    if p185.LerpMs then
        W:u8(Op.PropLerp);
        Codec.varuint(W, Id);
        Codec.varuint(W, PropId);
        W:u8(v187);
    else
        W:u8(Op.Prop);
        Codec.varuint(W, Id);
        Codec.varuint(W, PropId);
    end;

    Codec.writeValue(W, Type, p185.Value);
    Stream:EndRecord();
    p184:_setSequence(Inst, PropId, v186, T);
end;

function u15._layoutMoved(p194: table, p195: userdata, p196: number?, p197: number) -- Line: 1032
    -- upvalues: Relevance (copy)
    if not Relevance.IsLayout(p195) then
        return;
    end;

    if p196 then
        p196 = p194.ById[p196];
    end;

    if p196 then
        p194.RecheckChildren[p196] = p197;
    end;

    if p195.Parent then
        p194.RecheckChildren[p195.Parent] = p197;
    end;
end;

function u15.IdOf(p198: table, p199: userdata?) -- Line: 1045
    if p199 == nil then
        return nil;
    end;

    return p198.Ids[p199] or p198:_track(p199);
end;

function u15.StartWorld(p200) -- Line: 1055
    -- upvalues: u4 (ref)
    p200.WorldGuis = true;
    local v201 = p200.Clock();
    local ClassRefs = p200.Registry.ClassRefs;

    for i in p200.Signals do
        local v202 = ClassRefs[u4(i, "ClassName")];

        if v202 then
            local v203 = i;

            for _, v in v202 do
                local success, result = pcall(u4, v203, v.Name);

                if success and (typeof(result) == "Instance" and not p200.Ids[result]) then
                    local v204 = p200.DirtyProps[v203];

                    if not v204 then
                        v204 = {};
                        p200.DirtyProps[v203] = v204;
                    end;

                    v204[v.Id] = v201;
                end;
            end;
        end;
    end;
end;

function u15.Snapshot(p205) -- Line: 1082
    if not p205.RecordPlayerGui then
        return;
    end;

    local PlayerGui = p205.PlayerGui;
    p205:_watchChildren(PlayerGui, p205.Connections);
    p205:_queueChildren(PlayerGui, p205.Clock());

    while not p205:_drain(os.clock() + 0.002) do
        task.wait();

        if p205.Destroyed then
            return;
        end;
    end;
end;

function u15.Flush(u206) -- Line: 1098
    -- upvalues: Relevance (copy), u4 (ref), Op (copy), Codec (copy), kidsOf (copy), ShownBy (copy), u6 (copy), u9 (copy), Styles (copy), u8 (copy), Sequences (copy), ValueType (copy), u7 (copy)
    local Stream = u206.Stream;
    local _ = Stream.W;
    local Ids = u206.Ids;
    local PlayerGui = u206.PlayerGui;
    local v207 = u206.Clock();
    local v208 = Relevance.NewMemo();
    u206.Memo = v208;
    local DirtyStructure = u206.DirtyStructure;
    u206.DirtyStructure = {};
    local Signals = u206.Signals;
    local Registry = u206.Registry;
    local DeferredParent = u206.DeferredParent;
    local v209 = {};
    local v210 = {};
    local v211 = {};

    for i in DirtyStructure do
        local v212 = DeferredParent[i];

        if v212 and v212 ~= u4(i, "Parent") then
            u206:_undefer(i);
        end;

        local v213 = Ids[i];

        if v213 and Signals[i] then
            local v214 = u4(i, "Parent");

            if v214 ~= nil and (v214 == PlayerGui or Ids[v214]) and u206:_inDomain(i) then
                if Registry.FilterAny then
                    local v215 = {};

                    if Registry:Rematch(i, v214, u206.Kids, v215) then
                        table.insert(v215, i);
                    end;

                    local v216 = i;

                    for _, v in v215 do
                        v211[v] = DirtyStructure[v216];
                    end;
                end;
            else
                v209[v213] = true;
                table.insert(v210, i);
            end;
        end;
    end;

    for i in v211 do
        v209[Ids[i]] = true;
        table.insert(v210, i);
        u206:_watchFiltered(i);
    end;

    for _, v in v210 do
        local v217 = Ids[v];

        if v217 then
            local v218 = u206.ParentIds[v];
            local v219 = DirtyStructure[v] or v211[v];

            if not v209[v218] then
                Stream:Time(v219);
                local W = Stream.W;
                W:u8(Op.Remove);
                Codec.varuint(W, v217);
                Stream:EndRecord();
            end;

            u206:_layoutMoved(v, v218, v219);
            local v220;

            if v218 == 0 then
                v220 = PlayerGui;
            else
                v220 = u206.ById[v218];
            end;

            u206:_untrackTree(v, v220);
        end;
    end;

    local v221 = {};

    for i in DirtyStructure do
        if (not Ids[i] or Signals[i]) and u206:_inDomain(i) then
            table.insert(v221, i);
        end;
    end;

    table.sort(v221, function(p222, p223) -- Line: 1173
        -- upvalues: DirtyStructure (copy)
        return DirtyStructure[p222] < DirtyStructure[p223];
    end);
    local v224 = os.clock() + 0.002;
    u206:_drain(v224);
    local v225 = {};

    for _, v in v221 do
        local v226 = DirtyStructure[v];
        local v227 = Ids[v];

        if v227 then
            local v228 = u206:_parentId(v, v226);
            u206:_drain(v224);
            local v229 = u206.ParentIds[v];

            if v228 ~= nil and v228 ~= v229 then
                u206.ParentIds[v] = v228;
                local v230;

                if v229 == 0 then
                    v230 = PlayerGui;
                else
                    v230 = u206.ById[v229];
                end;

                if v230 then
                    v230 = u206.Kids[v230];
                end;

                if v230 then
                    v230[v] = nil;
                end;

                kidsOf(u206, u4(v, "Parent"))[v] = true;
                Stream:Time((math.max(v226, u206.Registry.AddFloor)));
                local W = Stream.W;
                W:u8(Op.Reparent);
                Codec.varuint(W, v227);
                Codec.varuint(W, v228);
                Stream:EndRecord();
                u206.RecheckSubtree[v] = v226;
                u206:_layoutMoved(v, v229, v226);
            end;
        else
            if u206:_track(v, v226) then
                v225[v] = true;
            end;

            u206:_drain(v224);
        end;
    end;

    local DirtyName = u206.DirtyName;
    u206.DirtyName = {};

    for i, v in DirtyName do
        local v231 = Ids[i];

        if v231 and not v225[i] then
            Stream:Time(v);
            local W = Stream.W;
            W:u8(Op.Rename);
            Codec.varuint(W, v231);
            Codec.str(W, i.Name);
            Stream:EndRecord();
        end;
    end;

    local Held = u206.Held;
    local PollHeld = u206.PollHeld;
    local PollSeen = u206.PollSeen;
    local u232 = {};
    local Kids = u206.Kids;
    local DeferredKids = u206.DeferredKids;
    local Pending = u206.Pending;
    local PendingTime = u206.PendingTime;
    local RecheckSubtree = u206.RecheckSubtree;
    u206.RecheckSubtree = {};
    local v233 = {};

    local function recheck(p234: userdata, p235: number) -- Line: 1232
        -- upvalues: PollHeld (copy), u206 (copy), PollSeen (copy), Held (copy), Ids (copy), u232 (copy)
        if PollHeld[p234] then
            u206:_armPoll(p234);
        else
            PollSeen[p234] = nil;
        end;

        if Held[p234] and Ids[p234] then
            if not u206.DirtyProps[p234] then
                u206.DirtyProps[p234] = {};
            end;

            u232[p234] = math.max(u232[p234] or 0, p235);
        end;
    end;

    for i, v in RecheckSubtree do
        if u4(i, "Parent") then
            table.insert(v233, i);
            local v236 = v;

            while #v233 > 0 do
                local table_remove_ret = table.remove(v233);
                recheck(table_remove_ret, v236);

                if not Relevance.HidesSubtree(table_remove_ret) then
                    local v237 = Kids[table_remove_ret];

                    if v237 then
                        for i2 in v237 do
                            table.insert(v233, i2);
                        end;
                    end;

                    local v238 = DeferredKids[table_remove_ret];

                    if v238 then
                        for i2 in v238 do
                            table.insert(Pending, i2);
                            table.insert(PendingTime, v236);
                        end;
                    end;
                end;
            end;
        end;
    end;

    local RecheckChildren = u206.RecheckChildren;
    u206.RecheckChildren = {};

    for i, v in RecheckChildren do
        local v239 = v;

        for _, child in i:GetChildren() do
            recheck(child, v239);
        end;
    end;

    local DirtyProps = u206.DirtyProps;
    u206.DirtyProps = {};
    local DirtyFirst = u206.DirtyFirst;
    u206.DirtyFirst = {};
    local PropTypes = u206.PropTypes;
    local ClassProps = u206.ClassProps;
    local LastSent = u206.LastSent;
    local Animating = u206.Animating;
    local SentUDim2 = u206.SentUDim2;
    local PropEntries = u206.PropEntries;
    local ValueScratch = u206.ValueScratch;
    local v240 = {};
    local v241 = {};
    local v242 = {};
    local v243 = {};

    for i, v in DirtyProps do
        local v244 = Ids[i];

        if v244 and not v225[i] then
            local v245 = u4(i, "ClassName");
            local v246 = ClassProps[v245];

            if v246 then
                local v247 = Held[i];
                local v248 = v247 == true;
                local v249;

                if type(v247) == "table" then
                    v249 = v247;
                else
                    v249 = nil;
                end;

                local v250 = Relevance.IsHidden(i, PlayerGui, v208);
                local v251;

                if v250 then
                    v251 = nil;
                else
                    v251 = Relevance.Suppressed(i, v208);
                end;

                local v252 = u206.Defaults[v245] or nil;
                local v253 = DirtyFirst[i];
                local v254 = Animating[i];
                local v255 = nil;
                local v256 = u232[i];
                local v257, v258;

                if v256 then
                    v257 = i;
                    v258 = v;
                else
                    v257 = i;
                    v258 = v;

                    for _, v2 in v do
                        v256 = math.max(v256 or 0, v2);
                    end;
                end;

                local v259;

                if v247 == nil then
                    table.clear(v243);

                    for i2 in v258 do
                        table.insert(v243, PropEntries[i2]);
                    end;

                    v259 = v243;
                else
                    v259 = v243;
                    v243 = v246;
                end;

                for _, v2 in v243 do
                    local Id = v2.Id;
                    local Name = v2.Name;
                    local v260 = v258[Id];
                    local v261 = v260 ~= nil;
                    local v262;

                    if v248 then
                        v262 = not ShownBy[Name];
                    elseif v249 == nil then
                        v262 = false;
                    else
                        v262 = v249[Id] == true;
                    end;

                    if v261 or v262 then
                        if v250 and not ShownBy[Name] or v251 and v251[Name] then
                            if not (v248 and v250) then
                                v249 = v249 or {};
                                v249[Id] = true;
                            end;
                        else
                            local v263 = u6[v2.Type];
                            local v264;

                            if v263 then
                                v264 = LastSent[v257];
                            else
                                v264 = v263;
                            end;

                            if v261 and (v264 and (v264[Id] and v207 - v264[Id] < v263)) then
                                v255 = v255 or {};
                                v255[Id] = true;
                            else
                                local v265, v266;

                                if Name == "Text" and u9[v245] then
                                    v265, v266 = pcall(u4, v257, "LocalizedText");
                                else
                                    v265, v266 = Styles.Read(v257, Name);
                                end;

                                if v265 then
                                    if v249 then
                                        v249[Id] = nil;
                                    end;

                                    if not v248 or (v261 or (not v252 or v252[Id] ~= v266)) then
                                        local v267 = v260 or v207;

                                        if v262 then
                                            v267 = math.max(v267, v256 or v207);
                                        end;

                                        local v268 = nil;

                                        if v261 and (not v262 and u8[v2.Type]) then
                                            local v269;

                                            if v254 then
                                                v269 = v254[Id];
                                            else
                                                v269 = v254;
                                            end;

                                            local v270;

                                            if v253 then
                                                v270 = v253[Id];
                                            else
                                                v270 = v253;
                                            end;

                                            if v269 and v267 - v269 <= 300 + (v263 or 0) then
                                                v268 = v267 - v269;
                                            elseif v270 and v270 < v267 then
                                                v268 = v267 - v270 + 16.666666666666668;
                                            end;
                                        end;

                                        if Sequences.Types[v2.Type] then
                                            table.insert(v240, {
                                                Inst = v257,
                                                Id = v244,
                                                PropId = Id,
                                                Type = v2.Type,
                                                Value = v266,
                                                LerpMs = v268,
                                                T = v267,
                                                Index = #v240 + 1
                                            });
                                        else
                                            if v2.Type == ValueType.Ref and (typeof(v266) == "Instance" and not u206.Registry:Resolve(v266, v267)) then
                                                u206:_waitRef(v266, v257, Id);
                                            end;

                                            local v271 = 15;

                                            if v2.Type == ValueType.UDim2 then
                                                local v272 = SentUDim2[v257];

                                                if typeof(v266) == "UDim2" then
                                                    local v273;

                                                    if v272 then
                                                        v273 = v272[Id];
                                                    else
                                                        v273 = v272;
                                                    end;

                                                    if v273 then
                                                        v271 = Codec.udim2Mask(v273, v266);
                                                    end;

                                                    if not v272 then
                                                        v272 = {};
                                                        SentUDim2[v257] = v272;
                                                    end;

                                                    v272[Id] = v266;
                                                elseif v272 then
                                                    v272[Id] = nil;
                                                end;
                                            end;

                                            local v274;

                                            if v268 then
                                                local math_round_ret = math.round(v268 / 10);
                                                v274 = math.clamp(math_round_ret, 1, 255);
                                            else
                                                v274 = 0;
                                            end;

                                            if v271 == 15 and (u7[Name] and v2.Type ~= ValueType.UDim2) then
                                                ValueScratch.len = 0;
                                                Codec.writeValue(ValueScratch, PropTypes[Id], v266);
                                                local buffer_readstring_ret = buffer.readstring(ValueScratch.buf, 0, ValueScratch.len);
                                                local v275 = `{Id}:{v274}:{math.floor(v267)}:{buffer_readstring_ret}`;
                                                local v276 = v241[v275];

                                                if v276 then
                                                    table.insert(v276.Ids, v244);
                                                else
                                                    local v277 = {
                                                        PropId = Id,
                                                        LerpUnits = v274,
                                                        T = v267,
                                                        Encoded = buffer_readstring_ret,
                                                        Ids = { v244 }
                                                    };
                                                    v241[v275] = v277;
                                                    table.insert(v242, v277);
                                                end;
                                            elseif v271 ~= 0 then
                                                Stream:Time(v267);
                                                local W = Stream.W;

                                                if v271 == 15 then
                                                    if v268 then
                                                        W:u8(Op.PropLerp);
                                                        Codec.varuint(W, v244);
                                                        Codec.varuint(W, Id);
                                                        W:u8(v274);
                                                    else
                                                        W:u8(Op.Prop);
                                                        Codec.varuint(W, v244);
                                                        Codec.varuint(W, Id);
                                                    end;

                                                    Codec.writeValue(W, PropTypes[Id], v266);
                                                else
                                                    W:u8(Op.UDim2Part);
                                                    Codec.varuint(W, v244);
                                                    Codec.varuint(W, Id);
                                                    W:u8(v274);
                                                    Codec.udim2Part(W, v271, v266);
                                                end;

                                                Stream:EndRecord();
                                            end;
                                        end;

                                        if v268 then
                                            v254 = v254 or {};
                                            v254[Id] = v267;
                                            Animating[v257] = v254;
                                        elseif v254 then
                                            v254[Id] = nil;
                                        end;

                                        if v263 then
                                            local v278 = v264 or {};
                                            v278[Id] = v207;
                                            LastSent[v257] = v278;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;

                if not (v248 and v250) then
                    if not (v249 and next(v249)) then
                        v249 = nil;
                    end;

                    Held[v257] = v249;
                end;

                if v255 then
                    local v279 = u206.DirtyProps[v257];

                    if not v279 then
                        v279 = {};
                        u206.DirtyProps[v257] = v279;
                    end;

                    local v280 = u206.DirtyFirst[v257];

                    if not v280 then
                        v280 = {};
                        u206.DirtyFirst[v257] = v280;
                    end;

                    for i2 in v255 do
                        v279[i2] = math.max(v279[i2] or 0, v258[i2]);
                        local v281;

                        if v253 then
                            v281 = v253[i2];
                        else
                            v281 = v253;
                        end;

                        if v281 then
                            v280[i2] = math.min(v280[i2] or v281, v281);
                        end;
                    end;

                    v243 = v259;
                else
                    v243 = v259;
                end;
            end;
        end;
    end;

    for _, v in v242 do
        local Ids2 = v.Ids;
        Stream:Time(v.T);
        local W = Stream.W;
        local v282;

        if #Ids2 == 1 then
            local v283;

            if v.LerpUnits > 0 then
                v283 = Op.PropLerp;
            else
                v283 = Op.Prop;
            end;

            W:u8(v283);
            Codec.varuint(W, Ids2[1]);
            Codec.varuint(W, v.PropId);

            if v.LerpUnits > 0 then
                W:u8(v.LerpUnits);
                v282 = v;
            else
                v282 = v;
            end;
        else
            table.sort(Ids2);
            W:u8(Op.PropMany);
            Codec.varuint(W, v.PropId);
            W:u8(v.LerpUnits);
            Codec.varuint(W, #Ids2);
            v282 = v;
            local v284 = 0;

            for _, v2 in Ids2 do
                Codec.varuint(W, v2 - v284);
                v284 = v2;
            end;
        end;

        local Encoded = v282.Encoded;
        W:_ensure(#Encoded);
        buffer.writestring(W.buf, W.len, Encoded);
        W.len = W.len + #Encoded;
        Stream:EndRecord();
    end;

    table.sort(v240, function(p285, p286) -- Line: 1539
        if p285.T == p286.T then
            return p285.Index < p286.Index;
        end;

        return p285.T < p286.T;
    end);

    for _, v in v240 do
        u206:_writeSequence(v);
    end;

    local Polling = u206.Polling;
    local PollNext = u206.PollNext;
    local PollGap = u206.PollGap;
    local PollSeen2 = u206.PollSeen;
    local PolledValues = u206.PolledValues;
    local ClassPolled = u206.ClassPolled;
    local os_clock_ret = os.clock();
    Stream:Time(v207);

    for i, v in Polling do
        local v287 = PollNext[i];

        if not v287 or os_clock_ret >= v287 then
            local v288 = Ids[i];
            local v289 = PolledValues[i];
            local v290 = ClassPolled[u4(i, "ClassName")];

            if v288 and (v289 and v290) then
                local v291 = os_clock_ret < v;
                local v292 = i;
                local v293 = false;

                for _, v2 in v290 do
                    local v294, v295 = Styles.Read(v292, v2.Name);

                    if v294 then
                        if v295 ~= v289[v2.Id] then
                            v289[v2.Id] = v295;
                            local W = Stream.W;
                            W:u8(Op.Prop);
                            Codec.varuint(W, v288);
                            Codec.varuint(W, v2.Id);
                            Codec.writeValue(W, PropTypes[v2.Id], v295);
                            Stream:EndRecord();
                        end;

                        if not v295 then
                            v293 = true;
                        end;
                    end;
                end;

                if v293 then
                    local v296 = PollSeen2[v292];
                    local v297;

                    if v296 and v296 > os_clock_ret then
                        if not v291 then
                            v297 = math.min((PollGap[v292] or 0.05) * 2, 1);
                            PollGap[v292] = v297;
                            PollNext[v292] = os_clock_ret + v297 * (0.75 + math.random() * 0.5);
                        end;
                    else
                        if not Relevance.PolledUnseen(v292, PlayerGui, v208) then
                            PollSeen2[v292] = os_clock_ret + 5;

                            if not v291 then
                                v297 = math.min((PollGap[v292] or 0.05) * 2, 1);
                                PollGap[v292] = v297;
                                PollNext[v292] = os_clock_ret + v297 * (0.75 + math.random() * 0.5);
                            end;
                        end;

                        u206:_stopPoll(v292);
                        u206.PollHeld[v292] = true;
                    end;
                elseif not v291 then
                    u206:_stopPoll(v292);
                end;
            else
                u206:_stopPoll(i);
            end;
        end;
    end;

    u206.Memo = nil;
end;

function u15.Destroy(p298) -- Line: 1618
    p298.Destroyed = true;

    for _, v in p298.Connections do
        v:Disconnect();
    end;

    table.clear(p298.Connections);

    for _, v in p298.Signals do
        for _, v2 in v do
            v2:Disconnect();
        end;
    end;

    table.clear(p298.Signals);

    for _, v in p298.DeferredSignals do
        for _, v2 in v do
            v2:Disconnect();
        end;
    end;

    table.clear(p298.DeferredSignals);

    for _, v in p298.RicherSignals do
        for _, v2 in v do
            v2:Disconnect();
        end;
    end;

    table.clear(p298.RicherSignals);
    table.clear(p298.RicherRoots);
    table.clear(p298.RicherQueued);
    table.clear(p298.OnChanged);
    table.clear(p298.StyledChecks);
    table.clear(p298.DeferredParent);
    table.clear(p298.DeferredKids);
    table.clear(p298.WaitingRefs);
    table.clear(p298.Kids);
    table.clear(p298.Pending);
    table.clear(p298.PendingTime);
    table.clear(p298.Ids);
    table.clear(p298.ById);
    table.clear(p298.ParentIds);
    table.clear(p298.PolledValues);
    table.clear(p298.Polling);
    table.clear(p298.PollNext);
    table.clear(p298.PollGap);
    table.clear(p298.PollSeen);
    table.clear(p298.PollHeld);
    table.clear(p298.Held);
    table.clear(p298.LastSent);
    table.clear(p298.Animating);
    table.clear(p298.SeqStates);
    table.clear(p298.SeqHolders);
    table.clear(p298.SentUDim2);
    p298.DirtyStructure = {};
    p298.DirtyName = {};
    p298.DirtyProps = {};
    p298.DirtyFirst = {};
    p298.RecheckSubtree = {};
    p298.RecheckChildren = {};
end;

return u15;