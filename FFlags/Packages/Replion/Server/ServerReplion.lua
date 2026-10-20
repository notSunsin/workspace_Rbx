-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Network = require(script.Parent.Parent.Internal.Network);
local Signal = require(script.Parent.Parent.Parent.Signal);
local Utils = require(script.Parent.Parent.Internal.Utils);
local Signals = require(script.Parent.Parent.Internal.Signals);
require(script.Parent.Parent.Internal.Types);
local Freeze = require(script.Parent.Parent.Parent.Freeze);
local u1 = 0;
local u2 = {};
local u3 = {};
u3.__index = u3;

function u3.new(p4: table) -- Line: 153
    -- upvalues: u1 (ref), u2 (copy), Signal (copy), Signals (copy), u3 (copy), Network (copy)
    local v5 = type(p4.Channel) == "string";
    local v6 = `"Channel" expected string, got {type(p4.Channel)}`;
    assert(v5, v6);
    assert(p4.ReplicateTo, "ReplicateTo is required!");
    local ReplicateTo = p4.ReplicateTo;
    local v7;

    if u1 + 1 > 65535 or #u2 >= 16 then
        v7 = table.remove(u2, 1);
    else
        u1 = u1 + 1;
        v7 = u1;
    end;

    assert(v7, "No available ID!");
    local v8 = `ID limit reached! You already have {65535} ServerReplions!`;
    assert(v7 <= 65535, v8);
    local v9 = {
        Data = p4.Data,
        Channel = p4.Channel,
        Tags = not p4.Tags and {} or p4.Tags,
        ReplicateTo = ReplicateTo,
        DisableAutoDestroy = p4.DisableAutoDestroy,
        _id = v7,
        _packedId = utf8.char(v7),
        _beforeDestroy = Signal.new(),
        _signals = Signals.new(),
        _replicateToChanged = Signal.new()
    };
    local v10 = setmetatable(v9, u3);
    Network.sendTo(ReplicateTo, "Added", v10:_serialize());

    return v10;
end;

function u3.__tostring(p11) -- Line: 191
    local Channel = p11.Channel;
    local ReplicateTo = p11.ReplicateTo;

    if type(ReplicateTo) == "table" then
        local v12 = {};

        for i, v in ReplicateTo do
            v12[i] = v.Name;
        end;

        ReplicateTo = table.concat(v12, ", ");
    elseif typeof(ReplicateTo) == "Instance" then
        ReplicateTo = ReplicateTo.Name;
    end;

    return `Replion<{Channel}:{ReplicateTo}>`;
end;

function u3._serialize(p13) -- Line: 219
    return {
        p13._packedId,
        p13.Channel,
        p13.Data,
        p13.ReplicateTo,
        p13.Tags
    };
end;

function u3.BeforeDestroy(p14, p15) -- Line: 233
    return p14._beforeDestroy:Connect(p15);
end;

function u3.OnDataChange(p16, p17) -- Line: 244
    return p16._signals:Connect("onDataChange", "__root", p17);
end;

function u3.OnChange(p18, p19, p20) -- Line: 256
    return p18._signals:Connect("onChange", p19, p20);
end;

function u3.OnArrayInsert(p21, p22, p23) -- Line: 268
    return p21._signals:Connect("onArrayInsert", p22, p23);
end;

function u3.OnArrayRemove(p24, p25, p26) -- Line: 280
    return p24._signals:Connect("onArrayRemove", p25, p26);
end;

function u3.OnDescendantChange(p27, p28, p29) -- Line: 292
    return p27._signals:Connect("onDescendantChange", p28, p29);
end;

function u3.SetReplicateTo(p30, p31) -- Line: 301
    -- upvalues: Players (copy), Network (copy)
    local v32;

    if p31 == "All" or type(p31) == "table" then
        v32 = true;
    elseif typeof(p31) == "Instance" then
        v32 = p31:IsA("Player");
    else
        v32 = false;
    end;

    assert(v32, "ReplicateTo must be a Player, a table of Players or \"All\"");
    local ReplicateTo = p30.ReplicateTo;

    if ReplicateTo == p31 then
        return;
    end;

    local v33;

    if ReplicateTo == "All" then
        v33 = Players:GetPlayers();
    else
        v33 = type(ReplicateTo) ~= "table" and { ReplicateTo } or ReplicateTo;
    end;

    local v34;

    if p31 == "All" then
        v34 = Players:GetPlayers();
    else
        v34 = type(p31) ~= "table" and { p31 } or p31;
    end;

    for _, v in v33 do
        if not table.find(v34, v) then
            Network.sendTo(v, "Removed", p30._packedId);
        end;
    end;

    for _, v in v34 do
        if not table.find(v33, v) then
            Network.sendTo(v, "Added", p30:_serialize());
        end;
    end;

    p30.ReplicateTo = p31;
    p30._replicateToChanged:Fire(p31, ReplicateTo);
    Network.sendTo(p31, "UpdateReplicateTo", p30._packedId, p31);
end;

function u3.Set(p35, p36, p37) -- Line: 361
    -- upvalues: Utils (copy), Freeze (copy), Network (copy)
    local PathTable = Utils.getPathTable(p36);
    local In = Freeze.Dictionary.getIn(p35.Data, PathTable);

    if In and Freeze.Dictionary.equals(In, p37) then
        if _G.__DEV__ and (type(In) == "table" and In == p37) then
            local debug_info_ret, v38 = debug.info(2, "sl");
            local PathString = Utils.getPathString(p36);
            warn(`Warning: Skipping Replion:Set('{PathString}') due to identical table references.\n` .. `Consider using Replion:Update('{PathString}') at {debug_info_ret}:{v38} instead.`);
        end;

        return In;
    end;

    if _G.__DEV__ and (type(In) == "table" and type(p37) == "table") then
        local v39 = Freeze.Dictionary.keys(In);
        local v40 = Freeze.Dictionary.keys(p37);

        if Freeze.List.equals(v39, v40) then
            local debug_info_ret, v41 = debug.info(2, "sl");
            local PathString = Utils.getPathString(p36);
            local v44 = Freeze.Dictionary.filter(p37, function(p42, p43) -- Line: 390
                -- upvalues: Freeze (ref), In (copy)
                return not Freeze.Dictionary.equals(In[p43], p42);
            end);

            if Freeze.Dictionary.count(v44) ~= Freeze.Dictionary.count(p37) then
                local v45 = "";

                for i, v in v44 do
                    v45 = v45 .. `\n\t{i} = {v},`;
                end;

                warn("Warning: Sending a table with identical keys but different values to the client.\n" .. `Consider using Replion:Update('{PathString}', \{{v45}\n}) at {debug_info_ret}:{v41} for optimized updates.`);
            end;
        end;
    end;

    local v46 = Freeze.Dictionary.setIn(p35.Data, PathTable, p37);
    local Data = p35.Data;
    p35.Data = v46;
    p35._signals:FireEvent("onDataChange", "__root", v46, PathTable);
    p35._signals:FireChange(p36, v46, Data);
    Network.sendTo(p35.ReplicateTo, "Set", p35._packedId, p36, p37);

    return p37;
end;

function u3.Update(p47, p48, p49) -- Line: 452
    -- upvalues: Utils (copy), Freeze (copy), Network (copy)
    local v50;

    if p49 then
        v50 = Utils.getPathTable(p48);
    else
        v50 = nil;
    end;

    local u51;

    if v50 then
        u51 = Freeze.Dictionary.getIn(p47.Data, v50);
    else
        u51 = p47.Data;
    end;

    local v54 = Freeze.Dictionary.filter(p49 or p48, function(p52, p53) -- Line: 456
        -- upvalues: u51 (copy), Freeze (ref)
        return not u51 and true or not Freeze.Dictionary.equals(u51[p53], p52);
    end);

    if Freeze.isEmpty(v54) then
        return;
    end;

    local Data = p47.Data;

    if v50 then
        local v55 = Freeze.Dictionary.mergeIn(p47.Data, v50, v54);
        p47.Data = v55;
        p47._signals:FireEvent("onDataChange", "__root", v55, v50);

        for i, v in v54 do
            local v56 = Freeze.List.push(v50, i);
            local In = Freeze.Dictionary.getIn(Data, v56);
            p47._signals:FireEvent("onChange", v56, Utils.getValue(v), In);
        end;

        p47._signals:FireChange(p48, v55, Data);
    else
        local v57 = Freeze.Dictionary.merge(p47.Data, v54);
        p47.Data = v57;
        p47._signals:FireEvent("onDataChange", "__root", v57, {});

        for i, v in v54 do
            p47._signals:FireEvent("onChange", i, Utils.getValue(v), Data[i]);
        end;
    end;

    local table_maxn_ret = table.maxn(v54);
    local u58 = nil;

    if table_maxn_ret > 0 then
        local v59 = 0;

        for i in v54 do
            v59 = v59 + 1;

            if i ~= v59 then
                u58 = true;
                break;
            end;
        end;

        u58 = u58 or v59 ~= table_maxn_ret;

        if _G.__DEV__ and u58 then
            local debug_info_ret, v60 = debug.info(2, "sl");
            warn("Warning: You\'re trying to send an unordered array to the client, RemotesEvents can\'t send unordered arrays.\n" .. "The array will be transformed into a dictionary to be sent to the client.\n" .. `at {debug_info_ret}:{v60}`);
        end;
    end;

    local v63 = Freeze.Dictionary.map(v54, function(p61, p62) -- Line: 526
        -- upvalues: Freeze (ref), Utils (ref), u58 (ref)
        if p61 == Freeze.None then
            p61 = Utils.SerializedNone;
        end;

        if u58 then
            return p61, tostring(p62);
        end;

        return p61, p62;
    end);

    if v50 then
        Network.sendTo(p47.ReplicateTo, "Update", p47._packedId, p48, v63, u58);
    else
        Network.sendTo(p47.ReplicateTo, "Update", p47._packedId, v63, nil, u58);
    end;
end;

function u3.Increase(p64, p65, p66) -- Line: 547
    -- upvalues: Utils (copy)
    local v67 = type(p66) == "number";
    local v68 = `"amount" expected number, got {type(p66)}`;
    assert(v67, v68);
    local Expect = p64:GetExpect(p65, (`"{Utils.getPathString(p65)}" is not a valid path!`));

    if p66 == 0 then
        return Expect;
    end;

    if not _G.__DEV__ or type(Expect) == "number" then
        return p64:Set(p65, Expect + p66);
    end;

    local debug_info_ret, v69 = debug.info(2, "sl");
    warn(`Warning: Attempt to increase non-numeric value at "{Utils.getPathString(p65)}"\n` .. `Check if the path is correct at {debug_info_ret}:{v69}.`);

    return Expect;
end;

function u3.Decrease(p70, p71, p72) -- Line: 579
    return p70:Increase(p71, -p72);
end;

function u3.Insert(p73, p74, p75, p76) -- Line: 609
    -- upvalues: Utils (copy), Freeze (copy), Network (copy)
    local PathTable = Utils.getPathTable(p74);
    local Expect = p73:GetExpect(p74, (`"{Utils.getPathString(p74)}" is not a valid path!`));
    local v77 = p76 or #Expect + 1;
    local v78 = Freeze.List.insert(Expect, v77, p75);
    local Data = p73.Data;
    local v79 = Freeze.Dictionary.setIn(p73.Data, PathTable, v78);
    p73.Data = v79;
    p73._signals:FireEvent("onDataChange", "__root", v79, PathTable);
    p73._signals:FireEvent("onArrayInsert", PathTable, v77, p75);
    p73._signals:FireChange(PathTable, v79, Data);
    Network.sendTo(p73.ReplicateTo, "ArrayUpdate", p73._packedId, "i", p74, p75, p76);
end;

function u3.Remove(p80, p81, p82) -- Line: 655
    -- upvalues: Utils (copy), Freeze (copy), Network (copy)
    local PathTable = Utils.getPathTable(p81);
    local Expect = p80:GetExpect(p81, (`"{Utils.getPathString(p81)}" is not a valid path!`));
    local v83 = p82 or #Expect;
    local v84 = Expect[v83];
    local v85 = Freeze.List.remove(Expect, v83);
    local Data = p80.Data;
    local v86 = Freeze.Dictionary.setIn(p80.Data, PathTable, v85);
    p80.Data = v86;
    p80._signals:FireEvent("onDataChange", "__root", v86, PathTable);
    p80._signals:FireEvent("onArrayRemove", p81, v83, v84);
    p80._signals:FireChange(p81, v86, Data);
    Network.sendTo(p80.ReplicateTo, "ArrayUpdate", p80._packedId, "r", p81, p82);

    return v84;
end;

function u3.Clear(p87, p88) -- Line: 703
    -- upvalues: Utils (copy), Freeze (copy), Network (copy)
    local Expect = p87:GetExpect(p88, (`"{Utils.getPathString(p88)}" is not a valid path!`));

    if Freeze.isEmpty(Expect) then
        return;
    end;

    local PathTable = Utils.getPathTable(p88);
    local Data = p87.Data;
    local v89 = Freeze.Dictionary.setIn(p87.Data, PathTable, {});
    p87.Data = v89;
    p87._signals:FireEvent("onDataChange", "__root", v89, PathTable);
    p87._signals:FireChange(p88, v89, Data);
    Network.sendTo(p87.ReplicateTo, "ArrayUpdate", p87._packedId, "c", p88);
end;

function u3.Find(p90, p91, p92) -- Line: 747
    local v93 = p90:Get(p91);

    if not v93 then
        return;
    end;

    local table_find_ret = table.find(v93, p92);

    if table_find_ret then
        return table_find_ret, p92;
    end;
end;

function u3.Get(p94, p95) -- Line: 770
    -- upvalues: Freeze (copy), Utils (copy)
    assert(p95, "Path is required!");
    local In = Freeze.Dictionary.getIn(p94.Data, Utils.getPathTable(p95));

    if _G.__DEV__ and In == nil then
        local PathTable = Utils.getPathTable(p95);

        for i, v in PathTable do
            if type(v) == "string" then
                local v96 = Utils.trimString(v);

                if v96 ~= v then
                    local v97 = Freeze.List.set(PathTable, i, v96);

                    if Freeze.Dictionary.getIn(p94.Data, v97) then
                        local debug_info_ret, v98 = debug.info(2, "sl");
                        warn(`Warning: the path "{Utils.getPathString(p95)}" has a key with leading or trailing whitespaces.\n` .. `This is likely a mistake, consider using "{Utils.getPathString(v97)}" at {debug_info_ret}:{v98} instead.`);
                    end;
                end;
            end;
        end;
    end;

    return In;
end;

function u3.GetExpect(p99, p100, p101) -- Line: 818
    -- upvalues: Utils (copy)
    assert(p100, "Path is required!");
    local v102 = p101 or `"{Utils.getPathString(p100)}" is not a valid path!`;
    local v103 = p99:Get(p100);

    if v103 == nil then
        error(v102);
    end;

    return v103;
end;

function u3.Destroy(p104) -- Line: 835
    -- upvalues: Network (copy), u2 (copy)
    if p104.Destroyed then
        return;
    end;

    p104._beforeDestroy:Fire();
    p104._beforeDestroy:DisconnectAll();
    p104._replicateToChanged:Destroy();
    p104._signals:Destroy();
    p104.Destroyed = true;
    Network.sendTo(p104.ReplicateTo, "Removed", p104._packedId);
    table.insert(u2, p104._id);
end;

return u3;