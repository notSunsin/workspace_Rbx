-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = {};
local u5 = 0;

local function StripRich(p6: string) -- Line: 23
    return p6:gsub("<.->", "");
end;

local function ByLengthDesc(p7: string, p8: string) -- Line: 27
    return #p7 > #p8;
end;

local function Build() -- Line: 31
    -- upvalues: u2 (ref), u3 (ref), ReplicatedStorage (copy), ByLengthDesc (copy)
    if u2 then
        return;
    end;

    local v9 = {};
    local v10 = {};
    u2 = v9;
    u3 = v10;
    local success, result = pcall(require, ReplicatedStorage.Data.PetRegistry.PetList);
    local success2, result2 = pcall(require, ReplicatedStorage.Data.SeedData);
    local success3, result3 = pcall(require, ReplicatedStorage.Data.PetRegistry.PetEggs);
    local v11 = {};

    if success and type(result) == "table" then
        for i in result do
            if type(i) == "string" and #i > 0 then
                v11[i] = true;
                table.insert(v9, i);
            end;
        end;
    else
        warn("[PetNotificationFilter] Failed to load PetList:", result);
    end;

    for _, v in { success2 and result2, success3 and result3 } do
        if type(v) == "table" then
            for i in v do
                if type(i) == "string" and (#i > 0 and not v11[i]) then
                    table.insert(v10, i);
                end;
            end;
        end;
    end;

    table.sort(v9, ByLengthDesc);
    table.sort(v10, ByLengthDesc);
end;

local function LongestLeadingName(p12: table, p13: string) -- Line: 68
    for _, v in p12 do
        if p13:sub(1, #v) == v and not p13:sub(#v + 1, #v + 1):match("%w") then
            return #v;
        end;
    end;

    return 0;
end;

function v1.IsPetNotification(p14: table, p15: string) -- Line: 77
    -- upvalues: u4 (copy), Build (copy), LongestLeadingName (copy), u2 (ref), u3 (ref), u5 (ref)
    if type(p15) ~= "string" or p15 == "" then
        return false;
    end;

    local v16 = u4[p15];

    if v16 ~= nil then
        return v16;
    end;

    Build();
    local v17 = p15:gsub("<.->", "");
    local v18 = v17:find("%w");
    local v19 = not v18 and "" or v17:sub(v18);

    for _, v in { "Your ", "The " } do
        if v19:sub(1, #v) == v then
            v19 = v19:sub(#v + 1);
            break;
        end;
    end;

    local v20 = LongestLeadingName(u2, v19);
    local v21;

    if v20 > 0 then
        v21 = LongestLeadingName(u3, v19) < v20;
    else
        v21 = false;
    end;

    if u5 >= 500 then
        table.clear(u4);
        u5 = 0;
    end;

    u4[p15] = v21;
    u5 = u5 + 1;

    return v21;
end;

return v1;