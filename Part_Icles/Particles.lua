-- Decompiled with Potassium's decompiler.

local Range = require(script.Parent.Range);
local u1 = {};

local function parseDuration(p2) -- Line: 9
    -- upvalues: Range (copy)
    if p2 == nil then
        return nil;
    end;

    if typeof(p2) == "number" then
        return p2;
    end;

    local v3 = {};

    for i in tostring(p2):gmatch("[^,]+") do
        local v4 = tonumber(i:match("^%s*(.-)%s*$"));

        if v4 then
            table.insert(v3, v4);
        end;
    end;

    if #v3 == 0 then
        return nil;
    end;

    if #v3 == 1 then
        return v3[1];
    end;

    local math_min_ret = math.min(v3[1], v3[2]);
    local math_max_ret = math.max(v3[1], v3[2]);

    return Range.RandomValueFromRange(NumberRange.new(math_min_ret, math_max_ret));
end;

u1.parseDuration = parseDuration;

local function _hasTransformedAncestor(p5, p6) -- Line: 23
    local Parent = p5.Parent;

    while Parent and Parent ~= p6 do
        if Parent:GetAttribute("Transformed") then
            return true;
        end;

        Parent = Parent.Parent;
    end;

    return false;
end;

local function _alive(p7) -- Line: 33
    return not p7 or p7();
end;

local function _bumpCancelGen(u8) -- Line: 47
    local u9 = (u8:GetAttribute("_PartIcleNativeEmitGen") or 0) + 1;
    pcall(function() -- Line: 49
        -- upvalues: u8 (copy), u9 (copy)
        u8:SetAttribute("_PartIcleNativeEmitGen", u9);
    end);

    return u9;
end;

local function _readDurationGen(p10) -- Line: 56
    return p10:GetAttribute("_PartIcleNativeDurationGen") or 0;
end;

local function _bumpDurationGen(u11) -- Line: 59
    local u12 = (u11:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
    pcall(function() -- Line: 61
        -- upvalues: u11 (copy), u12 (copy)
        u11:SetAttribute("_PartIcleNativeDurationGen", u12);
    end);

    return u12;
end;

local function _durationGenStillCurrent(p13, p14) -- Line: 64
    local v15;

    if p13.Parent == nil then
        v15 = false;
    else
        v15 = (p13:GetAttribute("_PartIcleNativeDurationGen") or 0) == p14;
    end;

    return v15;
end;

function u1.SetEnabledForDuration(u16, p17) -- Line: 70
    local u18 = (u16:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
    pcall(function() -- Line: 61
        -- upvalues: u16 (copy), u18 (copy)
        u16:SetAttribute("_PartIcleNativeDurationGen", u18);
    end);
    u16.Enabled = true;
    task.delay(p17, function() -- Line: 73
        -- upvalues: u16 (copy), u18 (copy)
        local v19 = u16;
        local v20 = u18;
        local v21;

        if v19.Parent == nil then
            v21 = false;
        else
            v21 = (v19:GetAttribute("_PartIcleNativeDurationGen") or 0) == v20;
        end;

        if v21 then
            u16.Enabled = false;
        end;
    end);
end;

function u1.ReadNativeGen(p22) -- Line: 44
    return p22:GetAttribute("_PartIcleNativeEmitGen") or 0;
end;

function u1.IsNativeGenCurrent(p23, p24) -- Line: 52
    local v25;

    if p23.Parent == nil then
        v25 = false;
    else
        v25 = (p23:GetAttribute("_PartIcleNativeEmitGen") or 0) == p24;
    end;

    return v25;
end;

function u1.CancelNative(u26) -- Line: 86
    local u27 = (u26:GetAttribute("_PartIcleNativeEmitGen") or 0) + 1;
    pcall(function() -- Line: 49
        -- upvalues: u26 (copy), u27 (copy)
        u26:SetAttribute("_PartIcleNativeEmitGen", u27);
    end);
    local u28 = (u26:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
    pcall(function() -- Line: 61
        -- upvalues: u26 (copy), u28 (copy)
        u26:SetAttribute("_PartIcleNativeDurationGen", u28);
    end);
    pcall(function() -- Line: 89
        -- upvalues: u26 (copy)
        u26.Enabled = false;
    end);
end;

function u1.EnableEmit(p29, u30) -- Line: 94
    -- upvalues: _hasTransformedAncestor (copy), parseDuration (copy)
    for _, descendant in p29:GetDescendants() do
        if not _hasTransformedAncestor(descendant, p29) then
            local u31, u32, u33, v34, u35, v36;

            if descendant:IsA("ParticleEmitter") then
                local u37 = descendant:GetAttribute("EmitCount") or 1;
                local v38 = descendant:GetAttribute("EmitDelay") or 0;
                local u39 = descendant:GetAttribute("EmitDuration") or 0;

                if u37 > 0 or u39 > 0 then
                    local u40 = descendant:GetAttribute("_PartIcleNativeEmitGen") or 0;

                    local function doEmit() -- Line: 103
                        -- upvalues: u30 (copy), descendant (copy), u40 (copy), u37 (copy), u39 (copy)
                        local v41 = u30;

                        if not v41 or v41() then
                            local v42 = descendant;
                            local v43 = u40;
                            local v44;

                            if v42.Parent == nil then
                                v44 = false;
                            else
                                v44 = (v42:GetAttribute("_PartIcleNativeEmitGen") or 0) == v43;
                            end;

                            if v44 then
                                if u37 > 0 then
                                    descendant:Emit(u37);
                                end;

                                if u39 > 0 then
                                    local u45 = descendant;
                                    local u46 = (u45:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
                                    pcall(function() -- Line: 61
                                        -- upvalues: u45 (copy), u46 (copy)
                                        u45:SetAttribute("_PartIcleNativeDurationGen", u46);
                                    end);
                                    descendant.Enabled = true;
                                    task.delay(u39, function() -- Line: 111
                                        -- upvalues: descendant (ref), u46 (copy)
                                        local v47 = descendant;
                                        local v48 = u46;
                                        local v49;

                                        if v47.Parent == nil then
                                            v49 = false;
                                        else
                                            v49 = (v47:GetAttribute("_PartIcleNativeDurationGen") or 0) == v48;
                                        end;

                                        if v49 then
                                            descendant.Enabled = false;
                                        end;
                                    end);
                                end;
                            end;
                        end;
                    end;

                    if v38 > 0 then
                        task.delay(v38, doEmit);
                    else
                        doEmit();
                    end;

                    if descendant:IsA("Trail") and not descendant:GetAttribute("Transformed") then
                        u31 = parseDuration(descendant:GetAttribute("EmitDuration"));

                        if u31 and u31 > 0 then
                            u32 = descendant:GetAttribute("_PartIcleNativeEmitGen") or 0;
                            task.delay(descendant:GetAttribute("EmitDelay") or 0.001, function() -- Line: 126
                                -- upvalues: u30 (copy), descendant (copy), u32 (copy), u31 (copy)
                                local v50 = u30;

                                if not v50 or v50() then
                                    local v51 = descendant;
                                    local v52 = u32;
                                    local v53;

                                    if v51.Parent == nil then
                                        v53 = false;
                                    else
                                        v53 = (v51:GetAttribute("_PartIcleNativeEmitGen") or 0) == v52;
                                    end;

                                    if v53 then
                                        local u54 = descendant;
                                        local u55 = (u54:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
                                        pcall(function() -- Line: 61
                                            -- upvalues: u54 (copy), u55 (copy)
                                            u54:SetAttribute("_PartIcleNativeDurationGen", u55);
                                        end);
                                        descendant.Enabled = true;
                                        task.delay(u31, function() -- Line: 130
                                            -- upvalues: descendant (ref), u55 (copy)
                                            local v56 = descendant;
                                            local v57 = u55;
                                            local v58;

                                            if v56.Parent == nil then
                                                v58 = false;
                                            else
                                                v58 = (v56:GetAttribute("_PartIcleNativeDurationGen") or 0) == v57;
                                            end;

                                            if v58 then
                                                descendant.Enabled = false;
                                            end;
                                        end);
                                    end;
                                end;
                            end);
                        end;
                    end;

                    if descendant:IsA("Beam") and not descendant:GetAttribute("Transformed") then
                        u33 = tonumber(descendant:GetAttribute("EmitDuration")) or 0;
                        v34 = tonumber(descendant:GetAttribute("EmitDelay")) or 0;

                        if u33 > 0 then
                            u35 = descendant:GetAttribute("_PartIcleNativeEmitGen") or 0;

                            v36 = function() -- Line: 144, Name: doEmit
                                -- upvalues: u30 (copy), descendant (copy), u35 (copy), u33 (copy)
                                local v59 = u30;

                                if not v59 or v59() then
                                    local v60 = descendant;
                                    local v61 = u35;
                                    local v62;

                                    if v60.Parent == nil then
                                        v62 = false;
                                    else
                                        v62 = (v60:GetAttribute("_PartIcleNativeEmitGen") or 0) == v61;
                                    end;

                                    if v62 then
                                        local u63 = descendant;
                                        local u64 = (u63:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
                                        pcall(function() -- Line: 61
                                            -- upvalues: u63 (copy), u64 (copy)
                                            u63:SetAttribute("_PartIcleNativeDurationGen", u64);
                                        end);
                                        descendant.Enabled = true;
                                        task.delay(u33, function() -- Line: 148
                                            -- upvalues: descendant (ref), u64 (copy)
                                            local v65 = descendant;
                                            local v66 = u64;
                                            local v67;

                                            if v65.Parent == nil then
                                                v67 = false;
                                            else
                                                v67 = (v65:GetAttribute("_PartIcleNativeDurationGen") or 0) == v66;
                                            end;

                                            if v67 then
                                                descendant.Enabled = false;
                                            end;
                                        end);
                                    end;
                                end;
                            end;

                            if v34 > 0 then
                                task.delay(v34, v36);
                            else
                                v36();
                            end;
                        end;
                    end;
                end;
            else
                if descendant:IsA("Trail") and not descendant:GetAttribute("Transformed") then
                    u31 = parseDuration(descendant:GetAttribute("EmitDuration"));

                    if u31 and u31 > 0 then
                        u32 = descendant:GetAttribute("_PartIcleNativeEmitGen") or 0;
                        task.delay(descendant:GetAttribute("EmitDelay") or 0.001, function() -- Line: 126
                            -- upvalues: u30 (copy), descendant (copy), u32 (copy), u31 (copy)
                            local v50 = u30;

                            if not v50 or v50() then
                                local v51 = descendant;
                                local v52 = u32;
                                local v53;

                                if v51.Parent == nil then
                                    v53 = false;
                                else
                                    v53 = (v51:GetAttribute("_PartIcleNativeEmitGen") or 0) == v52;
                                end;

                                if v53 then
                                    local u54 = descendant;
                                    local u55 = (u54:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
                                    pcall(function() -- Line: 61
                                        -- upvalues: u54 (copy), u55 (copy)
                                        u54:SetAttribute("_PartIcleNativeDurationGen", u55);
                                    end);
                                    descendant.Enabled = true;
                                    task.delay(u31, function() -- Line: 130
                                        -- upvalues: descendant (ref), u55 (copy)
                                        local v56 = descendant;
                                        local v57 = u55;
                                        local v58;

                                        if v56.Parent == nil then
                                            v58 = false;
                                        else
                                            v58 = (v56:GetAttribute("_PartIcleNativeDurationGen") or 0) == v57;
                                        end;

                                        if v58 then
                                            descendant.Enabled = false;
                                        end;
                                    end);
                                end;
                            end;
                        end);
                    end;
                end;

                if descendant:IsA("Beam") and not descendant:GetAttribute("Transformed") then
                    u33 = tonumber(descendant:GetAttribute("EmitDuration")) or 0;
                    v34 = tonumber(descendant:GetAttribute("EmitDelay")) or 0;

                    if u33 > 0 then
                        u35 = descendant:GetAttribute("_PartIcleNativeEmitGen") or 0;

                        v36 = function() -- Line: 144, Name: doEmit
                            -- upvalues: u30 (copy), descendant (copy), u35 (copy), u33 (copy)
                            local v59 = u30;

                            if not v59 or v59() then
                                local v60 = descendant;
                                local v61 = u35;
                                local v62;

                                if v60.Parent == nil then
                                    v62 = false;
                                else
                                    v62 = (v60:GetAttribute("_PartIcleNativeEmitGen") or 0) == v61;
                                end;

                                if v62 then
                                    local u63 = descendant;
                                    local u64 = (u63:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
                                    pcall(function() -- Line: 61
                                        -- upvalues: u63 (copy), u64 (copy)
                                        u63:SetAttribute("_PartIcleNativeDurationGen", u64);
                                    end);
                                    descendant.Enabled = true;
                                    task.delay(u33, function() -- Line: 148
                                        -- upvalues: descendant (ref), u64 (copy)
                                        local v65 = descendant;
                                        local v66 = u64;
                                        local v67;

                                        if v65.Parent == nil then
                                            v67 = false;
                                        else
                                            v67 = (v65:GetAttribute("_PartIcleNativeDurationGen") or 0) == v66;
                                        end;

                                        if v67 then
                                            descendant.Enabled = false;
                                        end;
                                    end);
                                end;
                            end;
                        end;

                        if v34 > 0 then
                            task.delay(v34, v36);
                        else
                            v36();
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

function u1.EnableEmitSingle(u68: userdata, u69: any) -- Line: 158
    -- upvalues: parseDuration (copy)
    if u68:IsA("Trail") then
        local u70 = parseDuration(u68:GetAttribute("EmitDuration"));

        if u70 and u70 > 0 then
            local u71 = u68:GetAttribute("_PartIcleNativeEmitGen") or 0;
            local v72 = u68:GetAttribute("EmitDelay") or 0;

            local function doEnable() -- Line: 164
                -- upvalues: u69 (copy), u68 (copy), u71 (copy), u70 (copy)
                local v73 = u69;

                if not v73 or v73() then
                    local v74 = u68;
                    local v75 = u71;
                    local v76;

                    if v74.Parent == nil then
                        v76 = false;
                    else
                        v76 = (v74:GetAttribute("_PartIcleNativeEmitGen") or 0) == v75;
                    end;

                    if v76 then
                        local u77 = u68;
                        local u78 = (u77:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
                        pcall(function() -- Line: 61
                            -- upvalues: u77 (copy), u78 (copy)
                            u77:SetAttribute("_PartIcleNativeDurationGen", u78);
                        end);
                        u68.Enabled = true;
                        task.delay(u70, function() -- Line: 168
                            -- upvalues: u68 (ref), u78 (copy)
                            local v79 = u68;
                            local v80 = u78;
                            local v81;

                            if v79.Parent == nil then
                                v81 = false;
                            else
                                v81 = (v79:GetAttribute("_PartIcleNativeDurationGen") or 0) == v80;
                            end;

                            if v81 then
                                u68.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end;

            if v72 > 0 then
                task.delay(v72, doEnable);
            else
                doEnable();
            end;
        end;
    end;

    if u68:IsA("ParticleEmitter") then
        local u82 = u68:GetAttribute("EmitCount") or 1;
        local v83 = u68:GetAttribute("EmitDelay") or 0;
        local u84 = u68:GetAttribute("EmitDuration") or 0;

        if u82 <= 0 and u84 <= 0 then
            return;
        end;

        local u85 = u68:GetAttribute("_PartIcleNativeEmitGen") or 0;

        local function v95() -- Line: 186
            -- upvalues: u69 (copy), u68 (copy), u85 (copy), u82 (copy), u84 (copy)
            local v86 = u69;

            if not v86 or v86() then
                local v87 = u68;
                local v88 = u85;
                local v89;

                if v87.Parent == nil then
                    v89 = false;
                else
                    v89 = (v87:GetAttribute("_PartIcleNativeEmitGen") or 0) == v88;
                end;

                if v89 then
                    if u82 > 0 then
                        u68:Emit(u82);
                    end;

                    if u84 > 0 then
                        local u90 = u68;
                        local u91 = (u90:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1;
                        pcall(function() -- Line: 61
                            -- upvalues: u90 (copy), u91 (copy)
                            u90:SetAttribute("_PartIcleNativeDurationGen", u91);
                        end);
                        u68.Enabled = true;
                        task.delay(u84, function() -- Line: 192
                            -- upvalues: u68 (ref), u91 (copy)
                            local v92 = u68;
                            local v93 = u91;
                            local v94;

                            if v92.Parent == nil then
                                v94 = false;
                            else
                                v94 = (v92:GetAttribute("_PartIcleNativeDurationGen") or 0) == v93;
                            end;

                            if v94 then
                                u68.Enabled = false;
                            end;
                        end);
                    end;
                end;
            end;
        end;

        if v83 > 0 then
            task.delay(v83, v95);

            return;
        end;

        v95();
    end;
end;

function u1.EnableEmitChildrenAndRepeatForAttachments(p96, p97) -- Line: 201
    -- upvalues: u1 (copy)
    for _, child in p96:GetChildren() do
        u1.EnableEmitSingle(child, p97);

        if child:IsA("Attachment") then
            u1.EnableEmitChildrenAndRepeatForAttachments(child, p97);
        end;
    end;
end;

return u1;