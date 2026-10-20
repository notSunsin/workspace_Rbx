-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Modules.UpdateService);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local EventRotationConfig = require(ReplicatedStorage.Modules.EventRotation.EventRotationConfig);
local u1 = {};
local u2 = nil;

local function GetEventRotationConfig() -- Line: 34
    -- upvalues: EventRotationConfig (copy)
    return EventRotationConfig;
end;

local function GetInitialTime() -- Line: 38
    return 1788035400;
end;

function u1.SetTestInitialTime(p3: table, p4: number?, p5: number?) -- Line: 55
    -- upvalues: RunService (copy), EventRotationConfig (copy), u2 (ref)
    if not RunService:IsStudio() and game.PlaceId ~= 140398800602847 then
        return;
    end;

    local v6 = EventRotationConfig;
    local ServerTimeNow = workspace:GetServerTimeNow();
    local _ = ServerTimeNow - 1788035400;
    local v7 = p4 or 8;
    local v8 = 0;

    for i = 1, math.min(v7, #v6) do
        if i == v7 then
            break;
        end;

        v8 = v8 + (v6[i].Duration or 604800);
        local _ = i;
    end;

    u2 = math.floor(1788035400 - (v8 + 1788035400 - ServerTimeNow)) + (p5 or 0);
end;

function u1.GetCurrentEvent(p9) -- Line: 83
    -- upvalues: EventRotationConfig (copy), NumberUtil (copy)
    local v10 = 1788035400;
    local v11 = EventRotationConfig;
    local v12 = v10;
    local v13 = 0;

    for _, v in v11 do
        v13 = v13 + (v.Duration or 604800);
    end;

    if v13 <= 0 then
        return nil, 0, 0;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    local v14 = ServerTimeNow - v10;

    if v14 > 0 then
        local v15 = math.floor(v14 / v13) - 1;
        v12 = v12 + math.max(0, v15) * v13;
    end;

    for i = 1, #v11 do
        local _ = i;

        for _, v in v11 do
            local v16 = v12 + (v.Duration or 604800);

            if v12 <= ServerTimeNow and ServerTimeNow < v16 then
                return v, v12, v16;
            end;

            v12 = v16;
        end;
    end;

    local math_round_ret = math.round(v10 - ServerTimeNow);

    if math_round_ret <= 10 then
        warn((`EventRotationUtils | No Event. Starting in {NumberUtil.compactFormat(math_round_ret)}`));
    else
        local _ = math_round_ret % 60 == 0;
    end;

    return nil, 0, 0;
end;

function u1.GetEventIDConfigIndex(p17: table, p18: string) -- Line: 128
    -- upvalues: EventRotationConfig (copy)
    for i, v in EventRotationConfig do
        if v.EventID == p18 then
            return i;
        end;
    end;

    return nil;
end;

function u1.GetPreviousEvent(p19: table, p20: string?) -- Line: 138
    -- upvalues: u1 (copy), EventRotationConfig (copy)
    if not p20 then
        local CurrentEvent = u1:GetCurrentEvent();

        if not CurrentEvent then
            return nil;
        end;

        p20 = CurrentEvent.EventID;
    end;

    local EventConfig = u1:GetEventConfig(p20);

    if not EventConfig then
        return nil;
    end;

    local EventIDConfigIndex = u1:GetEventIDConfigIndex(EventConfig.EventID);

    if not EventIDConfigIndex then
        return nil;
    end;

    local v21 = EventRotationConfig;
    local v22 = #v21;

    if EventIDConfigIndex - 1 ~= 0 then
        v22 = EventIDConfigIndex - 1;
    end;

    return v21[v22];
end;

function u1.GetNextEvent(p23: table, p24: string?) -- Line: 160
    -- upvalues: u1 (copy), EventRotationConfig (copy)
    if not p24 then
        local CurrentEvent = u1:GetCurrentEvent();

        if not CurrentEvent then
            return nil;
        end;

        p24 = CurrentEvent.EventID;
    end;

    local EventConfig = u1:GetEventConfig(p24);

    if not EventConfig then
        return nil;
    end;

    local EventIDConfigIndex = u1:GetEventIDConfigIndex(EventConfig.EventID);

    if not EventIDConfigIndex then
        return nil;
    end;

    local v25 = EventRotationConfig;

    return v25[#v25 < EventIDConfigIndex + 1 and 1 or EventIDConfigIndex + 1];
end;

function u1.GetPreviousEventSetID(p26: table, p27: string) -- Line: 182
    -- upvalues: u1 (copy)
    local EventConfig = u1:GetEventConfig(p27);

    if not EventConfig then
        warn((`No EventConfig: {p27}`));

        return nil;
    end;

    local EventSetIDs = u1:GetEventSetIDs();
    local table_find_ret = table.find(EventSetIDs, EventConfig.EventSet);

    if table_find_ret then
        local v28 = table_find_ret - 1;

        return EventSetIDs[v28 == 0 and #EventSetIDs or v28];
    end;

    warn((`No SetID: {EventConfig.EventSet}`));

    return nil;
end;

function u1.GetNextEventSetID(p29: table, p30: string) -- Line: 199
    -- upvalues: u1 (copy)
    local EventConfig = u1:GetEventConfig(p30);

    if not EventConfig then
        warn((`No EventConfig: {p30}`));

        return nil;
    end;

    local EventSetIDs = u1:GetEventSetIDs();
    local table_find_ret = table.find(EventSetIDs, EventConfig.EventSet);

    if table_find_ret then
        local v31 = table_find_ret + 1;

        return EventSetIDs[#EventSetIDs < v31 and 1 or v31];
    end;

    warn((`No SetID: {EventConfig.EventSet}`));

    return nil;
end;

function u1.GetEventSetIDs(p32) -- Line: 216
    -- upvalues: EventRotationConfig (copy)
    local v33 = {};

    for _, v in EventRotationConfig do
        if not table.find(v33, v.EventSet) then
            table.insert(v33, v.EventSet);
        end;
    end;

    return v33;
end;

function u1.GetEventConfig(p34: table, p35: string) -- Line: 226
    -- upvalues: EventRotationConfig (copy)
    for _, v in EventRotationConfig do
        if v.EventID == p35 then
            return v;
        end;
    end;

    return nil;
end;

function u1.GetEventSetConfigs(p36: table, p37: string) -- Line: 236
    -- upvalues: EventRotationConfig (copy)
    local v38 = {};

    for _, v in EventRotationConfig do
        if v.EventSet == p37 then
            table.insert(v38, v);
        end;
    end;

    return v38;
end;

function u1.GetEventInSetIndex(p39: table, p40: string, p41: string) -- Line: 247
    -- upvalues: u1 (copy)
    local EventSetConfigs = u1:GetEventSetConfigs(p41);

    if #EventSetConfigs == 0 then
        return nil;
    end;

    for i, v in EventSetConfigs do
        if v.EventID == p40 then
            return i;
        end;
    end;

    return nil;
end;

function u1.GetEventSetModels(p42: table, p43: string) -- Line: 260
    -- upvalues: EventRotationConfig (copy)
    local Interaction = workspace:WaitForChild("Interaction");

    if not Interaction then
        warn("Missing workspace.Interaction folder?");

        return {};
    end;

    local v44 = {};

    for _, v in EventRotationConfig do
        if v.EventSet == p43 then
            v44[v.EventID] = true;
        end;
    end;

    local v45 = {};

    for _, v in Interaction:QueryDescendants(".EventRotation") do
        local Attribute = v:GetAttribute("EventID");

        if Attribute and (v:IsA("Model") and v44[Attribute]) then
            table.insert(v45, v);
        end;
    end;

    return v45;
end;

function u1.GetEventIDModels(p46: table, p47: string) -- Line: 288
    local Interaction = workspace:WaitForChild("Interaction");

    if not Interaction then
        warn("Missing workspace.Interaction folder?");

        return {};
    end;

    local v48 = {};

    for _, v in Interaction:QueryDescendants(".EventRotation") do
        local Attribute = v:GetAttribute("EventID");

        if Attribute and Attribute == p47 then
            table.insert(v48, v);
        end;
    end;

    return v48;
end;

function u1.GetEventIDModelsWait(p49: table, p50: string, p51: number?) -- Line: 305
    -- upvalues: u1 (copy)
    local EventIDModels = u1:GetEventIDModels(p50);

    if #EventIDModels == 0 then
        local v52 = 0;

        while v52 <= (p51 or 120) do
            EventIDModels = u1:GetEventIDModels(p50);

            if #EventIDModels > 0 then
                return EventIDModels;
            end;

            v52 = v52 + task.wait();
        end;
    end;

    if #EventIDModels == 0 then
        error((`No event models found: {p50}`));
    end;

    return EventIDModels;
end;

function u1.GetTimeTillEventEnd(p53) -- Line: 326
    -- upvalues: u1 (copy)
    local CurrentEvent, _, v54 = u1:GetCurrentEvent();

    if CurrentEvent then
        return v54 - workspace:GetServerTimeNow();
    end;

    return nil;
end;

function u1.GetTimeTillEventID(p55: table, p56: string) -- Line: 335
    -- upvalues: u1 (copy), EventRotationConfig (copy)
    local CurrentEvent = u1:GetCurrentEvent();

    if not CurrentEvent then
        return nil;
    end;

    if CurrentEvent.EventID == p56 then
        return 0;
    end;

    local EventIDConfigIndex = u1:GetEventIDConfigIndex(p56);

    if not EventIDConfigIndex then
        return nil;
    end;

    local NextEvent = u1:GetNextEvent(CurrentEvent.EventID);

    if not NextEvent then
        return nil;
    end;

    local EventIDConfigIndex2 = u1:GetEventIDConfigIndex(NextEvent.EventID);

    if not EventIDConfigIndex2 then
        return nil;
    end;

    local v57 = u1:GetTimeTillEventEnd() or 0;
    local v58 = EventRotationConfig;

    while EventIDConfigIndex2 ~= EventIDConfigIndex do
        local v59 = v58[EventIDConfigIndex2];

        if v59.EventID == p56 then
            break;
        end;

        v57 = v57 + (v59.Duration or 604800);
        local v60 = EventIDConfigIndex2 + 1;
        EventIDConfigIndex2 = #v58 < v60 and 1 or v60;
    end;

    return v57;
end;

function u1.GetEventEpochs(p61: table, p62: string) -- Line: 374
    -- upvalues: u1 (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local CurrentEvent, _, v63 = u1:GetCurrentEvent();
    local EventConfig = u1:GetEventConfig(p62);

    if not (CurrentEvent and EventConfig) then
        return ServerTimeNow, ServerTimeNow;
    end;

    local EventSetConfigs = u1:GetEventSetConfigs(CurrentEvent.EventSet);
    local v64 = 0;

    for _, v in EventSetConfigs do
        if v.EventID == CurrentEvent.EventID then
            break;
        end;

        v64 = v64 + (v.Duration or 604800);
    end;

    local v65 = 0;

    for _, v in EventSetConfigs do
        if v.EventID == p62 then
            break;
        end;

        v65 = v65 + (v.Duration or 604800);
    end;

    local math_abs_ret = math.abs(v65 - ((CurrentEvent.Duration or 604800) - (v63 - ServerTimeNow) + v64));
    local v66 = ServerTimeNow - math_abs_ret;

    return v66, v66 + (EventConfig.Duration or 604800);
end;

return u1;