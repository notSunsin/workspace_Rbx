-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observability = require(ReplicatedStorage.UserGenerated.Observability);
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec);
local Op = Observability.Op;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 65
    -- upvalues: u1 (copy)
    local v3 = {
        Destroyed = false,
        Registry = p2,
        Stream = p2.Stream,
        Clock = p2.Clock,
        ClassId = p2.ClassIndex.AnimationTrack,
        Props = p2.ClassProps.AnimationTrack or {},
        PropIds = p2.ClassPropsByName.AnimationTrack or {},
        Tracks = {},
        Animators = setmetatable({}, {
            __mode = "k"
        })
    };

    return setmetatable(v3, u1);
end;

function u1.Watch(u4: table, u5: userdata) -- Line: 82
    if u4.ClassId == nil or u4.PropIds.TimePosition == nil then
        return;
    end;

    if u4.Destroyed or u4.Animators[u5] then
        return;
    end;

    u4.Animators[u5] = u5.AnimationPlayed:Connect(function(p6) -- Line: 90
        -- upvalues: u4 (copy), u5 (copy)
        u4:_started(u5, p6);
    end);

    for _, v in u5:GetPlayingAnimationTracks() do
        u4:_started(u5, v);
    end;
end;

function u1._started(u7: table, p8: userdata, p9: userdata) -- Line: 98
    local Parent = p8.Parent;

    if u7.Destroyed or (u7.Tracks[p9] or Parent == nil) then
        return;
    end;

    local v10 = u7.Clock();
    local Animation = p9.Animation;
    local u11 = {
        Id = nil,
        Ended = nil,
        Owner = Parent,
        AddAt = v10,
        AnimationId = not Animation and "" or Animation.AnimationId,
        Priority = p9.Priority,
        Looped = p9.Looped,
        Speed = p9.Speed,
        Weight = p9.WeightCurrent,
        Position = p9.TimePosition,
        PositionTime = v10,
        PollTime = v10,
        Connections = {}
    };

    local function ended() -- Line: 120
        -- upvalues: u11 (copy), u7 (copy)
        u11.Ended = u11.Ended or u7.Clock();
    end;

    u11.Connections = { p9.Ended:Connect(ended), p9.Destroying:Connect(ended) };
    u7.Tracks[p9] = u11;
end;

function u1._writeProp(p12: table, p13: number, p14: string, p15: any, p16: number, p17: number?) -- Line: 129
    -- upvalues: Op (copy), Codec (copy)
    local v18 = p12.PropIds[p14];

    if v18 == nil then
        return;
    end;

    local Stream = p12.Stream;
    Stream:Time(p16);
    local W = Stream.W;

    if p17 then
        W:u8(Op.PropLerp);
        Codec.varuint(W, p13);
        Codec.varuint(W, v18);
        local math_round_ret = math.round(p17 / 10);
        W:u8((math.clamp(math_round_ret, 1, 255)));
    else
        W:u8(Op.Prop);
        Codec.varuint(W, p13);
        Codec.varuint(W, v18);
    end;

    Codec.writeValue(W, p12.Registry.PropTypes[v18], p15);
    Stream:EndRecord();
end;

function u1._add(p19: table, p20: userdata, p21: table) -- Line: 152
    -- upvalues: Codec (copy)
    local Registry = p19.Registry;
    local v22 = Registry:Resolve(p21.Owner, p21.AddAt);

    if v22 == nil then
        return false;
    end;

    local v23 = Registry:Allocate(p20, v22);
    p21.Id = v23;
    local v24 = Registry:AddTime(p21.AddAt);
    p21.Position = p21.Position + (v24 - p21.PositionTime) / 1000 * p21.Speed;
    p21.PositionTime = v24;
    p21.PollTime = v24;
    local v25 = {
        AnimationId = p21.AnimationId,
        Priority = p21.Priority,
        Looped = p21.Looped,
        Speed = p21.Speed,
        WeightCurrent = p21.Weight,
        TimePosition = p21.Position
    };
    local W = p19.Stream.W;
    Registry.Copies:WriteHead(W, v23, v22, p19.ClassId, p20.Name, false);
    W:u16(#p19.Props);

    for _, v in p19.Props do
        Codec.varuint(W, v.Id);
        Codec.writeValue(W, v.Type, v25[v.Name]);
    end;

    p19.Stream:EndRecord();

    return true;
end;

function u1._poll(p26: table, p27: userdata, p28: table, p29: number) -- Line: 186
    local Id = p28.Id;
    local Priority = p27.Priority;

    if Priority ~= p28.Priority then
        p28.Priority = Priority;
        p26:_writeProp(Id, "Priority", Priority, p29);
    end;

    local Speed = p27.Speed;
    local Looped = p27.Looped;
    local TimePosition = p27.TimePosition;
    local Length = p27.Length;
    local v30;

    if Looped == p28.Looped then
        v30 = false;
    else
        p28.Looped = Looped;
        p26:_writeProp(Id, "Looped", Looped, p29);
        v30 = true;
    end;

    if math.abs(Speed - p28.Speed) > 0.001 then
        p26:_writeProp(Id, "Speed", Speed, p29);
        v30 = true;
    end;

    if not v30 then
        local v31 = p28.Position + (p29 - p28.PositionTime) / 1000 * p28.Speed;
        local v32 = TimePosition - v31;

        if Length > 0 then
            if Looped then
                v32 = (v32 + Length / 2) % Length - Length / 2;
            else
                v32 = Length <= v31 and Length - 0.05 <= TimePosition and 0 or v32;
            end;
        end;

        v30 = math.abs(v32) > 0.05;
    end;

    p28.Speed = Speed;

    if v30 then
        p28.Position = TimePosition;
        p28.PositionTime = p29;
        p26:_writeProp(Id, "TimePosition", TimePosition, p29);
    end;

    local WeightCurrent = p27.WeightCurrent;

    if math.abs(WeightCurrent - p28.Weight) > 0.02 or (WeightCurrent == 0 and true or WeightCurrent == 1) and WeightCurrent ~= p28.Weight then
        p28.Weight = WeightCurrent;
        local v33 = p29 - p28.PollTime;

        if v33 <= 0 or v33 > 300 then
            v33 = nil;
        end;

        p26:_writeProp(Id, "WeightCurrent", WeightCurrent, p29, v33);
    end;

    p28.PollTime = p29;
end;

function u1._forget(p34: table, p35: userdata, p36: table) -- Line: 238
    for _, v in p36.Connections do
        v:Disconnect();
    end;

    p34.Tracks[p35] = nil;

    if p36.Id then
        p34.Registry:Free(p35);
    end;
end;

function u1.Flush(p37) -- Line: 250
    -- upvalues: Op (copy), Codec (copy)
    local v38 = p37.Clock();
    local Ids = p37.Registry.Ids;

    for i, v in p37.Tracks do
        local Id = v.Id;

        if Id and Ids[v.Owner] == nil then
            p37.Registry:Free(i);
            v.Id = nil;
            v.AddAt = v38;
            v.Position = i.TimePosition;
            v.PositionTime = v38;
            Id = nil;
        end;

        if v.Ended or v.Owner:IsDescendantOf(game) then
            if not (v.Ended or (i.IsPlaying or i.WeightCurrent > 0)) then
                v.Ended = v38;
            end;
        else
            v.Ended = v38;
        end;

        if v.Ended then
            if Id then
                local Stream = p37.Stream;
                Stream:Time((math.max(v.Ended, v.PollTime)));
                local W = Stream.W;
                W:u8(Op.Remove);
                Codec.varuint(W, Id);
                Stream:EndRecord();
            end;

            p37:_forget(i, v);
        elseif Id then
            p37:_poll(i, v, v38);
        elseif not p37:_add(i, v) then
            v.AddAt = v38;
            v.Position = i.TimePosition;
            v.PositionTime = v38;
        end;
    end;
end;

function u1.Destroy(p39) -- Line: 293
    p39.Destroyed = true;

    for _, v in p39.Animators do
        v:Disconnect();
    end;

    table.clear(p39.Animators);

    for _, v in p39.Tracks do
        for _, v2 in v.Connections do
            v2:Disconnect();
        end;
    end;

    table.clear(p39.Tracks);
end;

return u1;