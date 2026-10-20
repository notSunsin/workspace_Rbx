-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
require(ReplicatedStorage.UserGenerated.Observability);
local Registry = require(ReplicatedStorage.UserGenerated.Observability.Registry);

local function qualityLevel() -- Line: 49
    -- upvalues: UserInputService (copy)
    local success, result = pcall(function() -- Line: 50
        return settings().Rendering.QualityLevel;
    end);

    if success and (typeof(result) == "EnumItem" and result.Value >= 1) then
        return math.min(result.Value, 21);
    end;

    local success2, result2 = pcall(function() -- Line: 56
        return UserSettings():GetService("UserGameSettings").SavedQualityLevel;
    end);

    return not (success2 and (typeof(result2) == "EnumItem" and result2.Value >= 1)) and (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and 7 or 17) or 21 - math.floor((10 - result2.Value) * 21 / 10);
end;

local function emissionScale() -- Line: 68
    -- upvalues: qualityLevel (copy)
    local v1 = qualityLevel() / 21;

    return math.max(0.1, v1);
end;

local function newWatch() -- Line: 92
    return {
        Connections = {},
        Kids = {},
        Names = {}
    };
end;

local function inPlayerCharacter(p2: userdata) -- Line: 96
    -- upvalues: Players (copy)
    local Parent = p2.Parent;

    while Parent and Parent ~= workspace do
        if Parent:IsA("Model") and Players:GetPlayerFromCharacter(Parent) then
            return true;
        end;

        Parent = Parent.Parent;
    end;

    return false;
end;

local function isRecorded(p3: table) -- Line: 107
    return p3.Forced or p3.Scoped and p3.Qualified;
end;

local u4 = {};
u4.__index = u4;

function u4.new(p5: any, p6: function) -- Line: 114
    -- upvalues: Registry (copy), u4 (copy), qualityLevel (copy)
    local v7;

    if p5 == nil then
        v7 = false;
    else
        v7 = p5.Enabled == true;
    end;

    local v8 = {
        World = nil,
        Walking = nil,
        WalkIndex = 0,
        Destroyed = false,
        Clock = p6,
        Enabled = v7
    };
    local v9;

    if v7 then
        v9 = Registry.BuildFilter(p5);
    else
        v9 = nil;
    end;

    v8.Filter = v9;
    v8.Entries = {};
    v8.Emits = {};
    v8.Pending = {};
    v8.Watches = {};
    v8.Characters = {};
    v8.Connections = {};
    local u10 = setmetatable(v8, u4);
    pcall(function() -- Line: 134
        -- upvalues: u10 (copy), qualityLevel (ref)
        local UserGameSettings = UserSettings():GetService("UserGameSettings");
        local Connections = u10.Connections;
        local PropertyChangedSignal = UserGameSettings:GetPropertyChangedSignal("SavedQualityLevel");
        table.insert(Connections, PropertyChangedSignal:Connect(function() -- Line: 138
            -- upvalues: u10 (ref), qualityLevel (ref)
            if u10.World then
                local World = u10.World;
                local v11 = qualityLevel() / 21;
                World:SetEmissionScale((math.max(0.1, v11)));
            end;
        end));
    end);
    u10:_watchCharacters();

    if v7 then
        u10:_discover();
    end;

    return u10;
end;

function u4._watchCharacters(u12) -- Line: 153
    -- upvalues: Players (copy)
    local function added(p13: userdata) -- Line: 154
        -- upvalues: u12 (copy)
        if u12.Destroyed or u12.Characters[p13] then
            return;
        end;

        u12.Characters[p13] = u12:_scope(p13);
    end;

    local function removing(p14: userdata) -- Line: 160
        -- upvalues: u12 (copy)
        local v15 = u12.Characters[p14];

        if not v15 then
            return;
        end;

        u12.Characters[p14] = nil;

        for _, v in v15.Connections do
            v:Disconnect();
        end;
    end;

    table.insert(u12.Connections, Players.PlayerAdded:Connect(function(p16: userdata) -- Line: 170, Name: watchPlayer
        -- upvalues: u12 (copy), added (copy), removing (copy)
        table.insert(u12.Connections, p16.CharacterAdded:Connect(added));
        table.insert(u12.Connections, p16.CharacterRemoving:Connect(removing));

        if p16.Character then
            local Character = p16.Character;

            if not u12.Destroyed then
                if u12.Characters[Character] then
                    return;
                end;

                u12.Characters[Character] = u12:_scope(Character);
            end;
        end;
    end));

    for _, v in Players:GetPlayers() do
        table.insert(u12.Connections, v.CharacterAdded:Connect(added));
        table.insert(u12.Connections, v.CharacterRemoving:Connect(removing));

        if v.Character then
            local Character = v.Character;

            if not u12.Destroyed then
                if not u12.Characters[Character] then
                    u12.Characters[Character] = u12:_scope(Character);
                end;
            end;
        end;
    end;
end;

function u4._inScope(p17: table, p18: userdata) -- Line: 185
    -- upvalues: inPlayerCharacter (copy)
    if not p18:IsDescendantOf(workspace) then
        return false;
    end;

    if inPlayerCharacter(p18) then
        return true;
    end;

    if not p17.Enabled then
        return false;
    end;

    local Filter = p17.Filter;

    if not Filter then
        return true;
    end;

    local v19 = {};

    while p18 and p18 ~= workspace do
        table.insert(v19, p18.Name);
        p18 = p18.Parent;
    end;

    local v20 = Filter;

    for i = #v19, 1, -1 do
        Filter = Filter.Children[v19[i]];

        if Filter == nil then
            return not v20.Include;
        end;

        if Filter.Marked then
            return v20.Include;
        end;

        local _ = i;
    end;

    return not v20.Include;
end;

function u4._qualifies(p21: table, p22: userdata) -- Line: 219
    return p22.Enabled and p22.Rate > 0;
end;

function u4._update(u23: table, u24: userdata) -- Line: 224
    local v25 = u23.Entries[u24];

    if not v25 or u23.Destroyed then
        return;
    end;

    local v26 = v25.Forced or v25.Scoped and v25.Qualified;

    if v25.Forced and not u24:IsDescendantOf(workspace) then
        v25.Forced = false;
    end;

    v25.Scoped = u23:_inScope(u24);

    if v25.Scoped and not v25.Qualified then
        if u23:_qualifies(u24) then
            v25.Qualified = true;
        elseif not v25.Waiting then
            local function changed() -- Line: 238
                -- upvalues: u23 (copy), u24 (copy)
                u23:_update(u24);
            end;

            v25.Waiting = { u24:GetPropertyChangedSignal("Enabled"):Connect(changed), u24:GetPropertyChangedSignal("Rate"):Connect(changed) };
        end;
    end;

    if v25.Waiting and (v25.Qualified or not v25.Scoped) then
        for _, v in v25.Waiting do
            v:Disconnect();
        end;

        v25.Waiting = nil;
    end;

    if not v25.Scoped then
        v25.Qualified = false;
    end;

    local World = u23.World;

    if v25.Forced or v25.Scoped and v25.Qualified then
        if World then
            World:AddParticle(u24);
        end;
    elseif v26 and World then
        World:RemoveParticle(u24);
    end;

    if not (v25.Scoped or v25.Forced) then
        v25.Moved:Disconnect();
        u23.Entries[u24] = nil;
    end;
end;

function u4._entry(u27: table, u28: userdata) -- Line: 275
    local v29 = u27.Entries[u28];

    if v29 then
        return v29;
    end;

    local v30 = {
        Scoped = false,
        Forced = false,
        Qualified = false,
        Waiting = nil,
        Moved = u28.AncestryChanged:Connect(function() -- Line: 284
            -- upvalues: u27 (copy), u28 (copy)
            u27:_update(u28);
        end)
    };
    u27.Entries[u28] = v30;

    return v30;
end;

function u4._consider(p31: table, p32: userdata) -- Line: 293
    if p31.Destroyed or (not p32:IsA("ParticleEmitter") or p31.Entries[p32]) then
        return;
    end;

    if not p31:_inScope(p32) then
        return;
    end;

    p31:_entry(p32);
    p31:_update(p32);
end;

function u4._recheckAll(p33) -- Line: 305
    local v34 = {};

    for i in p33.Entries do
        table.insert(v34, i);
    end;

    for _, v in v34 do
        p33:_update(v);
    end;
end;

function u4._scope(u35: table, p36: userdata) -- Line: 316
    -- upvalues: newWatch (copy)
    local v37 = newWatch();
    table.insert(v37.Connections, p36.DescendantAdded:Connect(function(p38) -- Line: 320
        -- upvalues: u35 (copy)
        u35:_consider(p38);
    end));
    u35:_consider(p36);
    table.insert(u35.Pending, p36);

    return v37;
end;

function u4._closeWatch(p39: table, p40: userdata) -- Line: 329
    local v41 = p39.Watches[p40];

    if not v41 then
        return;
    end;

    p39.Watches[p40] = nil;

    for _, v in v41.Connections do
        v:Disconnect();
    end;

    for _, v in v41.Names do
        v:Disconnect();
    end;

    for i in v41.Kids do
        p39:_closeWatch(i);
    end;
end;

function u4._watchPath(u42: table, p43: userdata, u44: any) -- Line: 348
    -- upvalues: newWatch (copy)
    if next(u44.Children) == nil then
        return;
    end;

    local u45 = newWatch();
    u42.Watches[p43] = u45;

    local function check(p46: userdata) -- Line: 354
        -- upvalues: u45 (copy), u42 (copy), u44 (copy)
        if u45.Kids[p46] then
            u45.Kids[p46] = nil;
            u42:_closeWatch(p46);
            u42:_recheckAll();
        end;

        local v47 = u44.Children[p46.Name];

        if v47 == nil or u42.Destroyed then
            return;
        end;

        u45.Kids[p46] = true;

        if v47.Marked then
            u42.Watches[p46] = u42:_scope(p46);

            return;
        end;

        u42:_watchPath(p46, v47);
    end;

    table.insert(u45.Connections, p43.ChildAdded:Connect(function(u48) -- Line: 373
        -- upvalues: u45 (copy), check (copy)
        if u45.Names[u48] then
            return;
        end;

        u45.Names[u48] = u48:GetPropertyChangedSignal("Name"):Connect(function() -- Line: 377
            -- upvalues: check (ref), u48 (copy)
            check(u48);
        end);
        check(u48);
    end));
    table.insert(u45.Connections, p43.ChildRemoved:Connect(function(p49) -- Line: 385
        -- upvalues: u45 (copy), u42 (copy)
        local v50 = u45.Names[p49];

        if v50 then
            v50:Disconnect();
            u45.Names[p49] = nil;
        end;

        if u45.Kids[p49] then
            u45.Kids[p49] = nil;
            u42:_closeWatch(p49);
        end;
    end));

    for _, child in p43:GetChildren() do
        u45.Names[child] = child:GetPropertyChangedSignal("Name"):Connect(function() -- Line: 398
            -- upvalues: check (copy), child (copy)
            check(child);
        end);
        check(child);
    end;
end;

function u4._discover(u51) -- Line: 405
    local Filter = u51.Filter;

    if Filter and Filter.Include then
        u51:_watchPath(workspace, Filter);

        return;
    end;

    table.insert(u51.Connections, workspace.DescendantAdded:Connect(function(p52) -- Line: 414
        -- upvalues: u51 (copy)
        u51:_consider(p52);
    end));

    for _, child in workspace:GetChildren() do
        table.insert(u51.Pending, child);
    end;
end;

function u4._walk(p53: table, p54: number) -- Line: 425
    while os.clock() < p54 do
        local Walking = p53.Walking;

        if Walking then
            local WalkIndex = p53.WalkIndex;
            local v55 = #Walking;

            while WalkIndex < v55 and os.clock() < p54 do
                WalkIndex = WalkIndex + 1;
                local v56 = Walking[WalkIndex];

                if v56:IsA("ParticleEmitter") then
                    p53:_consider(v56);
                end;
            end;

            p53.WalkIndex = WalkIndex;

            if WalkIndex < v55 then
                return;
            end;

            p53.Walking = nil;
        end;

        local table_remove_ret = table.remove(p53.Pending);

        if table_remove_ret == nil then
            return;
        end;

        if table_remove_ret.Parent ~= nil then
            p53:_consider(table_remove_ret);
            p53.Walking = table_remove_ret:GetDescendants();
            p53.WalkIndex = 0;
        end;
    end;
end;

function u4.Emit(p57: table, p58: userdata, p59: number) -- Line: 457
    if p57.Destroyed or #p57.Emits >= 1024 then
        return;
    end;

    local Emits = p57.Emits;
    local v60 = {
        Emitter = p58,
        Count = p59,
        T = p57.Clock()
    };
    table.insert(Emits, v60);
end;

function u4.Bind(p61, p62) -- Line: 465
    -- upvalues: qualityLevel (copy)
    p61.World = p62;
    local v63 = qualityLevel() / 21;
    p62:SetEmissionScale((math.max(0.1, v63)));

    for i, v in p61.Entries do
        if v.Forced or v.Scoped and v.Qualified then
            p62:AddParticle(i);
        end;
    end;
end;

function u4.Unbind(p64) -- Line: 476
    p64.World = nil;
end;

function u4.Flush(p65) -- Line: 482
    if p65.Destroyed then
        return;
    end;

    p65:_walk(os.clock() + 0.0005);
    local World = p65.World;

    if not World or #p65.Emits == 0 then
        return;
    end;

    local Emits = p65.Emits;
    p65.Emits = {};

    for _, v in Emits do
        local Emitter = v.Emitter;

        if Emitter.Parent ~= nil then
            World:WriteEmit(Emitter, v.Count, v.T);

            if World.Particles[Emitter] then
                local v66 = p65:_entry(Emitter);

                if not v66.Forced then
                    v66.Forced = true;
                    p65:_update(Emitter);
                end;
            end;
        end;
    end;
end;

function u4.Destroy(p67) -- Line: 510
    p67.Destroyed = true;
    p67.World = nil;

    for _, v in p67.Connections do
        v:Disconnect();
    end;

    table.clear(p67.Connections);

    for i in p67.Watches do
        p67:_closeWatch(i);
    end;

    for _, v in p67.Characters do
        for _, v2 in v.Connections do
            v2:Disconnect();
        end;
    end;

    table.clear(p67.Characters);

    for _, v in p67.Entries do
        v.Moved:Disconnect();

        if v.Waiting then
            for _, v2 in v.Waiting do
                v2:Disconnect();
            end;
        end;
    end;

    table.clear(p67.Entries);
    table.clear(p67.Emits);
    table.clear(p67.Pending);
    p67.Walking = nil;
end;

return u4;