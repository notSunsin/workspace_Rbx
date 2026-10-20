-- Decompiled with Potassium's decompiler.

local ProximityPromptService = game:GetService("ProximityPromptService");
local v1 = {};
local u2 = {};
local u3 = {};

local function Toggle() -- Line: 14
    -- upvalues: u2 (copy), u3 (copy), ProximityPromptService (copy)
    local v4 = false;

    for _, v in ipairs(u2) do
        if not u3[v] or #u3[v] == 0 then
            v4 = true;
            break;
        end;
    end;

    ProximityPromptService.Enabled = not v4;
end;

function v1.AddDisabler(p5: table, p6: string) -- Line: 31
    -- upvalues: u2 (copy), Toggle (copy)
    if table.find(u2, p6) then
        return;
    end;

    table.insert(u2, p6);
    Toggle();
end;

function v1.RemoveDisabler(p7: table, p8: string) -- Line: 43
    -- upvalues: u2 (copy), Toggle (copy)
    local table_find_ret = table.find(u2, p8);

    if table_find_ret then
        table.remove(u2, table_find_ret);
        Toggle();
    end;
end;

function v1.AddTargetedOverride(p9: table, p10: string, p11: string) -- Line: 54
    -- upvalues: u3 (copy), Toggle (copy)
    if not u3[p10] then
        u3[p10] = {};
    end;

    if not table.find(u3[p10], p11) then
        table.insert(u3[p10], p11);
        Toggle();
    end;
end;

function v1.RemoveTargetedOverride(p12: table, p13: string, p14: string) -- Line: 68
    -- upvalues: u3 (copy), Toggle (copy)
    if not u3[p13] then
        return;
    end;

    local table_find_ret = table.find(u3[p13], p14);

    if table_find_ret then
        table.remove(u3[p13], table_find_ret);
        Toggle();
    end;
end;

return v1;