-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local u1 = {};
local u2 = false;

local function finite(p3) -- Line: 56
    local v4;

    if type(p3) == "number" and p3 == p3 then
        v4 = math.abs(p3) < (1 / 0);
    else
        v4 = false;
    end;

    return v4;
end;

local function slice() -- Line: 59
    local u5 = os.clock() + 0.003;

    return function() -- Line: 61
        -- upvalues: u5 (ref)
        if u5 <= os.clock() then
            task.wait();
            u5 = os.clock() + 0.003;
        end;
    end;
end;

function u1.Validate(p6, p7) -- Line: 69
    -- upvalues: HttpService (copy)
    local v8;

    if type(p6) == "string" then
        v8 = #p6 <= p7;
    else
        v8 = false;
    end;

    assert(v8, "capture_too_large_or_invalid");
    local v9 = HttpService:JSONDecode(p6);
    local v10;

    if type(v9) == "table" then
        v10 = v9.version == 1;
    else
        v10 = false;
    end;

    assert(v10, "unsupported_format");
    local u11 = os.clock() + 0.003;

    local function u12() -- Line: 61
        -- upvalues: u11 (ref)
        if u11 <= os.clock() then
            task.wait();
            u11 = os.clock() + 0.003;
        end;
    end;

    local v13 = {};
    local v14 = {};
    local v15 = {};
    local v16 = {};
    local v17 = {};

    local function array(p18) -- Line: 75
        -- upvalues: u12 (copy)
        local v19 = type(p18) == "table";
        assert(v19, "invalid_array");

        for i in pairs(p18) do
            local v20;

            if type(i) == "number" and (i % 1 == 0 and i >= 1) then
                v20 = i <= #p18;
            else
                v20 = false;
            end;

            assert(v20, "invalid_array");
            u12();
        end;
    end;

    local function dictionary(p21, p22) -- Line: 82
        -- upvalues: array (copy), u12 (copy)
        array(p21);

        for _, v in ipairs(p21) do
            local id = v.id;
            local v23;

            if type(id) == "number" and id == id then
                v23 = math.abs(id) < (1 / 0);
            else
                v23 = false;
            end;

            if v23 then
                if v.id >= 0 and v.id % 1 == 0 then
                    v23 = not p22[v.id];
                else
                    v23 = false;
                end;
            end;

            assert(v23, "invalid_id");
            p22[v.id] = v;
            u12();
        end;
    end;

    dictionary(v9.frames, v13);
    dictionary(v9.threads, v14);
    dictionary(v9.timers, v15);
    dictionary(v9.scopes, v16);
    dictionary(v9.memory_counters, v17);
    assert(v13[v9.anchor_frame_id], "invalid_anchor");
    local v24;

    if type(v9.complete) == "boolean" then
        v24 = type(v9.stitched) == "boolean";
    else
        v24 = false;
    end;

    assert(v24, "invalid_flags");
    local v25;

    if type(v9.labels) == "table" then
        v25 = type(v9.origins) == "table";
    else
        v25 = false;
    end;

    assert(v25, "invalid_labels_or_origins");
    local cpu = v9.origins.cpu;
    local v26;

    if type(cpu) == "number" and cpu == cpu then
        v26 = math.abs(cpu) < (1 / 0);
    else
        v26 = false;
    end;

    if v26 then
        local gpu = v9.origins.gpu;

        if type(gpu) == "number" and gpu == gpu then
            v26 = math.abs(gpu) < (1 / 0);
        else
            v26 = false;
        end;
    end;

    assert(v26, "invalid_origins");
    array(v9.labels);
    local v27 = {};

    for _, v in ipairs(v9.labels) do
        local v28;

        if type(v) == "string" then
            v28 = not v27[v];
        else
            v28 = false;
        end;

        assert(v28, "invalid_label");
        v27[v] = true;
        u12();
    end;

    local v29 = nil;

    for _, v in ipairs(v9.frames) do
        local absolute_id = v.absolute_id;
        local v30;

        if type(absolute_id) == "number" and absolute_id == absolute_id then
            v30 = math.abs(absolute_id) < (1 / 0);
        else
            v30 = false;
        end;

        if v30 then
            if v.absolute_id >= 0 then
                v30 = v.absolute_id % 1 == 0;
            else
                v30 = false;
            end;
        end;

        assert(v30, "invalid_absolute_frame_id");
        local v31 = v;

        for _, v2 in ipairs({ "cpu", "gpu" }) do
            local v32 = v31[v2 .. "_start_ms"];
            local v33;

            if type(v32) == "number" and v32 == v32 then
                v33 = math.abs(v32) < (1 / 0);
            else
                v33 = false;
            end;

            if v33 then
                local v34 = v31[v2 .. "_end_ms"];

                if type(v34) == "number" and v34 == v34 then
                    v33 = math.abs(v34) < (1 / 0);
                else
                    v33 = false;
                end;

                if v33 then
                    if v31[v2 .. "_end_ms"] >= v31[v2 .. "_start_ms"] then
                        local v35 = v31[v2 .. "_end_ms"] - v31[v2 .. "_start_ms"];

                        if type(v35) == "number" and v35 == v35 then
                            v33 = math.abs(v35) < (1 / 0);
                        else
                            v33 = false;
                        end;

                        if v33 then
                            v33 = not v29 or v31[v2 .. "_start_ms"] >= v29[v2 .. "_start_ms"];
                        end;
                    else
                        v33 = false;
                    end;
                end;
            end;

            assert(v33, "invalid_frame");
        end;

        local v36;

        if type(v31.incomplete) == "boolean" then
            v36 = type(v31.stitched) == "boolean";
        else
            v36 = false;
        end;

        assert(v36, "invalid_frame_flags");
        u12();
        v29 = v31;
    end;

    for _, v in ipairs(v9.threads) do
        local v37;

        if type(v.name) == "string" then
            v37 = type(v.is_gpu) == "boolean";
        else
            v37 = false;
        end;

        assert(v37, "invalid_thread");
        u12();
    end;

    for _, v in ipairs(v9.timers) do
        local v38;

        if type(v.name) == "string" then
            local group_id = v.group_id;

            if type(group_id) == "number" and group_id == group_id then
                v38 = math.abs(group_id) < (1 / 0);
            else
                v38 = false;
            end;

            if v38 then
                if v.group_id >= 0 and (v.group_id % 1 == 0 and (type(v.group_name) == "string" and (type(v.is_gpu) == "boolean" and type(v.color) == "string"))) then
                    v38 = string.match(v.color, "^#%x%x%x%x%x%x$") ~= nil;
                else
                    v38 = false;
                end;
            end;
        else
            v38 = false;
        end;

        assert(v38, "invalid_timer");
    end;

    local v39 = {};
    local v40 = {};

    for _, v in ipairs(v9.scopes) do
        local v41;

        if v.id > 0 then
            v41 = v14[v.thread_id] and v15[v.timer_id];
        else
            v41 = false;
        end;

        assert(v41, "invalid_reference");
        local start_ms = v.start_ms;
        local v42;

        if type(start_ms) == "number" and start_ms == start_ms then
            v42 = math.abs(start_ms) < (1 / 0);
        else
            v42 = false;
        end;

        if v42 then
            local duration_ms = v.duration_ms;

            if type(duration_ms) == "number" and duration_ms == duration_ms then
                v42 = math.abs(duration_ms) < (1 / 0);
            else
                v42 = false;
            end;

            if v42 then
                if v.duration_ms >= 0 then
                    local v43 = v.start_ms + v.duration_ms;

                    if type(v43) == "number" and v43 == v43 then
                        v42 = math.abs(v43) < (1 / 0);
                    else
                        v42 = false;
                    end;
                else
                    v42 = false;
                end;
            end;
        end;

        assert(v42, "invalid_timing");
        local v44;

        if type(v.incomplete_start) == "boolean" and type(v.incomplete_end) == "boolean" then
            v44 = type(v.stitched) == "boolean";
        else
            v44 = false;
        end;

        assert(v44, "invalid_scope_flags");
        array(v.labels);
        local v45 = v;
        local v46 = {};

        for _, v2 in ipairs(v.labels) do
            assert(v9.labels[v2], "invalid_label_reference");
            table.insert(v46, v9.labels[v2]);
            u12();
        end;

        local v47 = v16[v45.parent_id];

        if v45.parent_id == 0 then
            v47 = true;
        elseif v47 then
            if v47.id < v45.id and (v47.thread_id == v45.thread_id and v47.start_ms <= v45.start_ms + 1e-6) then
                v47 = v47.start_ms + v47.duration_ms + 1e-6 >= v45.start_ms + v45.duration_ms;
            else
                v47 = false;
            end;
        end;

        assert(v47, "invalid_nesting");
        local name = v15[v45.timer_id].name;
        local v48 = HttpService:JSONEncode({ name, v46 });
        local v49 = v40[v48];

        if v49 then
            v49.min_ms = math.min(v49.min_ms, v45.duration_ms);
            v49.max_ms = math.max(v49.max_ms, v45.duration_ms);
        else
            local v50 = {
                name = name,
                labels = v46,
                min_ms = v45.duration_ms,
                max_ms = v45.duration_ms
            };
            v40[v48] = v50;
            table.insert(v39, v50);
        end;

        u12();
    end;

    for _, v in ipairs(v9.memory_counters) do
        local v51;

        if type(v.name) == "string" and type(v.path) == "string" then
            v51 = type(v.is_leaf) == "boolean";
        else
            v51 = false;
        end;

        assert(v51, "invalid_counter");
        local v52;

        if v.parent_id == 0 then
            v52 = true;
        else
            v52 = v17[v.parent_id] and v.parent_id ~= v.id;
        end;

        assert(v52, "invalid_counter_parent");
        local v53 = v;
        local v54 = v53;
        local v55 = v53;
        v53 = v54;
        v55 = v54;
        local v56 = {};

        while v54 and v54.parent_id ~= 0 do
            assert(not v56[v54.id], "counter_cycle");
            v56[v54.id] = true;
            u12();
            v54 = v17[v54.parent_id];
        end;

        local v57;

        if v53.value == nil then
            v57 = true;
        else
            local value = v53.value;

            if type(value) == "number" and value == value then
                v57 = math.abs(value) < (1 / 0);
            else
                v57 = false;
            end;

            if v57 then
                local frame_id = v53.frame_id;

                if type(frame_id) == "number" and frame_id == frame_id then
                    v57 = math.abs(frame_id) < (1 / 0);
                else
                    v57 = false;
                end;

                if v57 then
                    if v53.frame_id >= 0 then
                        v57 = v53.frame_id % 1 == 0;
                    else
                        v57 = false;
                    end;
                end;
            end;
        end;

        assert(v57, "invalid_counter_sample");
        u12();
    end;

    local v58 = HttpService:JSONEncode(v39);
    assert(#v58 <= p7, "scope_index_too_large");

    return v9, v58;
end;

function u1.IsBusy() -- Line: 220
    -- upvalues: u2 (ref)
    return u2;
end;

function u1.Run(p59) -- Line: 223
    -- upvalues: u2 (ref)
    if u2 then
        return nil, "capture_busy";
    end;

    u2 = true;
    local v60, v61, v62 = pcall(p59);
    u2 = false;

    if v60 then
        return v61, v62;
    end;

    return nil, tostring(v61);
end;

function u1.CreateLabelReader(u63) -- Line: 236
    if type(u63.FetchLabelBufferRegions) ~= "function" or type(u63.ReadDataLocator) ~= "function" then
        return function() -- Line: 238
            error("labels_unavailable");
        end;
    end;

    local success, result = pcall(function() -- Line: 243
        -- upvalues: u63 (copy)
        return u63:FetchLabelBufferRegions();
    end);

    if not (success and (type(result) == "table" and #result ~= 0)) then
        return function() -- Line: 247
            error("labels_unavailable");
        end;
    end;

    table.sort(result, function(p64, p65) -- Line: 252
        return p64.StartOffset < p65.StartOffset;
    end);
    local u66 = {};
    local u67 = os.clock() + 0.003;

    local function u68() -- Line: 61
        -- upvalues: u67 (ref)
        if u67 <= os.clock() then
            task.wait();
            u67 = os.clock() + 0.003;
        end;
    end;

    return function(p69) -- Line: 258
        -- upvalues: u66 (copy), u68 (copy), result (copy), u63 (copy)
        local v70 = u66[p69];

        if v70 ~= nil then
            if v70 == false or not v70 then
                v70 = nil;
            end;

            return v70;
        end;

        local v71 = p69;
        local v72 = (1 / 0);
        local v73 = false;
        local v74 = {};

        while v72 > 0 do
            u68();
            local v75 = nil;

            for _, v in ipairs(result) do
                if v.StartOffset <= p69 and p69 < v.EndOffset then
                    v75 = v;
                    break;
                end;
            end;

            if not v75 then
                break;
            end;

            local math_min_ret = math.min(4096, v72, v75.EndOffset - p69);

            if math_min_ret <= 0 then
                break;
            end;

            local u76 = v75.BufferStartLocator + (p69 - v75.StartOffset);
            local success2, result2 = pcall(function() -- Line: 287
                -- upvalues: u63 (ref), u76 (copy), math_min_ret (copy)
                return u63:ReadDataLocator(u76, math_min_ret);
            end);

            if not (success2 and (type(result2) == "string" and #result2 ~= 0)) then
                break;
            end;

            local string_find_ret = string.find(result2, "\0", 1, true);

            if string_find_ret then
                local string_sub_ret = string.sub(result2, 1, string_find_ret - 1);
                table.insert(v74, string_sub_ret);
                v73 = true;
            end;

            table.insert(v74, result2);
            p69 = p69 + #result2;
            v72 = v72 - #result2;
        end;

        assert(v73, "incomplete_label");
        local table_concat_ret = table.concat(v74);

        if utf8.len(table_concat_ret) == nil then
            error("invalid_label_utf8");
        end;

        u66[v71] = table_concat_ret;

        return table_concat_ret;
    end;
end;

function u1.Export(u77, u78, u79, u80) -- Line: 317
    -- upvalues: u1 (copy), HttpService (copy)
    local u81 = {};
    local v147, v148, v149 = pcall(function() -- Line: 319
        -- upvalues: u77 (copy), u78 (copy), u81 (copy), u79 (copy), u1 (ref), HttpService (ref), u80 (copy)
        local u82 = os.clock() + 0.003;

        local function v83() -- Line: 61
            -- upvalues: u82 (ref)
            if u82 <= os.clock() then
                task.wait();
                u82 = os.clock() + 0.003;
            end;
        end;

        local u84 = u77.Session.OpenFromBuffer(u78);
        assert(u84, "snapshot_unavailable");
        table.insert(u81, u84);
        local v85 = u84:IsValid();
        assert(v85, "invalid_snapshot");
        local u86 = u84:FetchGlobalDesc();
        local FrameIdMin = u84:GetFrameIdMin();
        local FrameIdMax = u84:GetFrameIdMax();
        local v87;

        if FrameIdMin <= FrameIdMax then
            local v88;

            if FrameIdMin == 0 then
                v88 = FrameIdMax == 0;
            else
                v88 = false;
            end;

            v87 = not v88;
        else
            v87 = false;
        end;

        assert(v87, "no_frames");
        local u89 = u84:FetchFrameDesc(FrameIdMin);
        local u90 = {
            version = 1,
            complete = true,
            stitched = false,
            anchor_frame_id = u79 or FrameIdMax,
            origins = {
                cpu = u89.TickStartCpu,
                gpu = u89.TickStartGpu
            },
            frames = {},
            threads = {},
            timers = {},
            labels = {},
            scopes = {},
            memory_counters = {}
        };
        local v91 = {};
        local u92 = {};
        local u93 = {};
        local u94 = {};
        local v95 = {};

        for i = FrameIdMin, FrameIdMax do
            local v96 = u84:FetchFrameDesc(i);
            local v97 = {
                stitched = false,
                id = i,
                absolute_id = v96.FrameAbsoluteId,
                cpu_start_ms = (v96.TickStartCpu - u89.TickStartCpu) * u86.TickToMsCpu,
                cpu_end_ms = (v96.TickEndCpu - u89.TickStartCpu) * u86.TickToMsCpu,
                gpu_start_ms = (v96.TickStartGpu - u89.TickStartGpu) * u86.TickToMsGpu,
                gpu_end_ms = (v96.TickEndGpu - u89.TickStartGpu) * u86.TickToMsGpu,
                incomplete = v96.IsIncomplete == true
            };
            table.insert(u90.frames, v97);
            v91[i] = v97;

            if v97.incomplete then
                u90.complete = false;
            end;

            v83();
            local _ = i;
        end;

        assert(v91[u90.anchor_frame_id], "anchor_not_in_snapshot");
        local v98 = u1.CreateLabelReader(u84);
        local v99 = u84:CreateLogIterator();
        table.insert(u81, v99);
        v99:Configure({
            SkipEvents = true,
            EmitThreadFrameEnd = true
        });
        local State = v99:GetState();
        v99:RewindTo(FrameIdMin, FrameIdMax);
        local u100 = {};

        local function record(p101, p102, p103, p104, p105, p106) -- Line: 370
            -- upvalues: u94 (copy), u84 (copy), u90 (copy), u92 (copy), u89 (copy), u86 (copy), State (copy), u93 (copy), FrameIdMin (copy), u100 (copy)
            local v107 = u94[p102];

            if not v107 then
                local v108 = u84:FetchThreadDesc(p102);
                v107 = {
                    id = p102,
                    name = v108.ThreadName,
                    is_gpu = v108.IsGpu == true
                };
                u94[p102] = v107;
                table.insert(u90.threads, v107);
            end;

            if not u92[p101] then
                local v109 = u84:FetchTimerDesc(p101);
                local v110 = u84:FetchGroupDesc(v109.GroupId);
                local v111 = {
                    id = p101,
                    name = v109.TimerName,
                    group_id = v109.GroupId,
                    group_name = v110.GroupName,
                    is_gpu = v107.is_gpu,
                    color = string.format("#%06x", (bit32.band(v109.Color, 16777215)))
                };
                u92[p101] = v111;
                table.insert(u90.timers, v111);
            end;

            local is_gpu = v107.is_gpu;
            local v112;

            if is_gpu then
                v112 = u89.TickStartGpu;
            else
                v112 = u89.TickStartCpu;
            end;

            local v113;

            if is_gpu then
                v113 = u86.TickToMsGpu;
            else
                v113 = u86.TickToMsCpu;
            end;

            local v114 = u84:FetchFrameDesc(State:FrameId());
            local v115;

            if p103 then
                v115 = p103:EnterTimestampFrameLocal();
            elseif is_gpu then
                v115 = v114.TickStartGpu;
            else
                v115 = v114.TickStartCpu;
            end;

            local v116;

            if p103 then
                v116 = tostring(p102) .. ":" .. tostring(p103:EnterEntryLocator());
            else
                v116 = nil;
            end;

            local v117;

            if v116 then
                v117 = u93[v116];
            else
                v117 = v116;
            end;

            local v118 = (v115 - v112) * v113;
            local v119 = (p104 - v112) * v113;
            assert(v118 <= v119, "negative_scope_duration");

            if v117 then
                v117.duration_ms = math.max(v117.start_ms + v117.duration_ms, v119) - v117.start_ms;
                v117.incomplete_end = p106;
                v117.stitched = v117.stitched or State:IsFrameStitching();
            else
                v117 = {
                    parent_id = 0,
                    id = #u90.scopes + 1,
                    timer_id = p101,
                    thread_id = p102,
                    labels = {},
                    start_ms = v118,
                    duration_ms = v119 - v118,
                    incomplete_start = p103 == nil and true or p103:EnterFrameId() < FrameIdMin,
                    incomplete_end = p106,
                    stitched = State:IsFrameStitching(),
                    _depth = p105
                };
                table.insert(u90.scopes, v117);

                if v116 then
                    u93[v116] = v117;
                end;
            end;

            if v116 and u100[v116] then
                v117.labels = u100[v116];
            end;
        end;

        while v99:Step() do
            v83();

            if State:IsFrameStitching() then
                u90.stitched = true;
                v91[State:FrameId()].stitched = true;
            end;

            if State:ThreadStackIsOverflowed() or State:ThreadStackWasOverflowed() then
                error("scope_stack_overflow");
            end;

            if not State:IsFrameBoundary() then
                local v120 = State:ThreadId();
                local v121 = State:ThreadStackDepth();
                local ThreadStackState = v99:GetThreadStackState(v120);

                if State:IsLabel() and (v121 > 0 and not State:ThreadStackIsOverflowed()) then
                    local CurrentThreadStackElement = v99:GetCurrentThreadStackElement(v121 - 1);
                    local CurrentEntryWords, v122 = v99:GetCurrentEntryWords();

                    if CurrentThreadStackElement and (CurrentEntryWords and v122) then
                        local v123 = v98(CurrentEntryWords + bit32.band(v122, 65535) * 4294967296);

                        if v123 then
                            local v124 = v95[v123];

                            if not v124 then
                                v124 = #u90.labels + 1;
                                u90.labels[v124] = v123;
                                v95[v123] = v124;
                            end;

                            local v125 = tostring(v120) .. ":" .. tostring(CurrentThreadStackElement:EnterEntryLocator());
                            local v126 = u100[v125] or {};
                            u100[v125] = v126;
                            table.insert(v126, v124);
                        end;
                    end;
                elseif State:IsExit() and not State:ThreadStackWasOverflowed() then
                    local v127;

                    if State:ThreadStackIsUnderflowed() then
                        v127 = nil;
                    else
                        v127 = v99:GetCurrentThreadStackElement(v121);
                    end;

                    record(State:TimerId(), v120, v127, State:Timestamp(), ThreadStackState:DepthAbsolute(), false);
                elseif State:IsThreadFrameEnd() then
                    for i = v121 - 1, 0, -1 do
                        local CurrentThreadStackElement = v99:GetCurrentThreadStackElement(i);

                        if CurrentThreadStackElement then
                            record(CurrentThreadStackElement:EnterTimerId(), v120, CurrentThreadStackElement, State:Timestamp(), ThreadStackState:DepthAbsolute() - (v121 - i), true);
                        end;

                        v83();
                        local _ = i;
                    end;
                end;
            end;
        end;

        local function less(p128, p129) -- Line: 483
            if p128.thread_id ~= p129.thread_id then
                return p128.thread_id < p129.thread_id;
            end;

            if p128.start_ms ~= p129.start_ms then
                return p128.start_ms < p129.start_ms;
            end;

            if p128._depth == p129._depth then
                return p128.id < p129.id;
            end;

            return p128._depth < p129._depth;
        end;

        local scopes = u90.scopes;
        local table_create_ret = table.create(#u90.scopes);
        local v130 = 1;

        while true do
            if v130 >= #scopes then
                u90.scopes = scopes;
                local v131 = {};

                for i, v in ipairs(u90.scopes) do
                    local v132 = v;

                    while #v131 > 0 do
                        local v133 = v131[#v131];

                        if v133.thread_id == v132.thread_id and (v133._depth < v132._depth and v133.start_ms + v133.duration_ms + 1e-6 >= v132.start_ms + v132.duration_ms) then
                            break;
                        end;

                        table.remove(v131);
                    end;

                    v132.id = i;
                    v132.parent_id = #v131 <= 0 and 0 or v131[#v131].id;
                    table.insert(v131, v132);

                    if v132.incomplete_start or v132.incomplete_end then
                        u90.complete = false;
                    end;

                    v83();
                end;

                for _, v in ipairs(u90.scopes) do
                    v._depth = nil;
                end;

                local success, result = pcall(function() -- Line: 541
                    -- upvalues: u84 (copy)
                    return u84:CreateCounterIterator();
                end);

                if success then
                    success = result ~= nil;
                end;

                u90.memory_available = success;

                if u90.memory_available then
                    table.insert(u81, result);
                    local State2 = result:GetState();

                    while result:Step() do
                        local u134 = State2:CounterId();
                        local v135 = {};

                        for i = 0, State2:Level() do
                            local CounterName = u84:FetchCounterDesc(result:GetStackElement(i)).CounterName;
                            table.insert(v135, CounterName);
                            local _ = i;
                        end;

                        local v136 = {
                            id = u134,
                            parent_id = State2:Level() <= 0 and 0 or result:GetStackElement(State2:Level() - 1),
                            name = u84:FetchCounterDesc(u134).CounterName,
                            path = table.concat(v135, "/"),
                            is_leaf = State2:IsLeaf()
                        };
                        local success2, result2 = pcall(function() -- Line: 560
                            -- upvalues: u84 (copy), u134 (copy)
                            return u84:FetchLastCounterSample(u134);
                        end);

                        if success2 and result2 then
                            v136.value = result2.Value;
                            v136.frame_id = result2.FrameId;
                        end;

                        table.insert(u90.memory_counters, v136);
                        v83();
                    end;
                end;

                local v137 = HttpService:JSONEncode(u90);
                local _, v138 = u1.Validate(v137, u80);

                return v137, v138;
            end;

            for i = 1, #scopes, v130 * 2 do
                local math_min_ret = math.min(i + v130, #scopes + 1);
                local math_min_ret2 = math.min(i + v130 * 2, #scopes + 1);
                local v139 = i;
                local v140 = math_min_ret;
                local v141 = v139;
                local v142 = v139;
                v139 = v141;
                v142 = v141;

                for i2 = i, math_min_ret2 - 1 do
                    if v141 < math_min_ret then
                        if math_min_ret2 <= v140 then
                            table_create_ret[i2] = scopes[v141];
                            v141 = v141 + 1;
                        else
                            local v143 = scopes[v140];
                            local v144 = scopes[v141];
                            local v145;

                            if v143.thread_id == v144.thread_id then
                                if v143.start_ms == v144.start_ms then
                                    if v143._depth == v144._depth then
                                        v145 = v143.id < v144.id;
                                    else
                                        v145 = v143._depth < v144._depth;
                                    end;
                                else
                                    v145 = v143.start_ms < v144.start_ms;
                                end;
                            else
                                v145 = v143.thread_id < v144.thread_id;
                            end;

                            if v145 then
                                table_create_ret[i2] = scopes[v140];
                                v140 = v140 + 1;
                            else
                                table_create_ret[i2] = scopes[v141];
                                v141 = v141 + 1;
                            end;
                        end;
                    else
                        table_create_ret[i2] = scopes[v140];
                        v140 = v140 + 1;
                    end;

                    v83();
                    local _ = i2;
                end;
            end;

            v130 = v130 * 2;
            local v146 = table_create_ret;
            table_create_ret = scopes;
            scopes = v146;
        end;
    end);

    for i = #u81, 1, -1 do
        pcall(function() -- Line: 576
            -- upvalues: u81 (copy), i (copy)
            u81[i]:Dispose();
        end);
        local _ = i;
    end;

    if not v147 then
        error(v148, 0);
    end;

    return v148, v149;
end;

return u1;