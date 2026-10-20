-- Decompiled with Potassium's decompiler.

local v1 = {};
local Field_Of_View_Module = require(game.ReplicatedStorage.Field_Of_View_Module);
local Blur_Module = require(game.ReplicatedStorage.Blur_Module);
local u2 = {};

function v1.Show(p3) -- Line: 6
    -- upvalues: u2 (copy), Field_Of_View_Module (copy), Blur_Module (copy)
    if table.find(u2, p3) == nil then
        table.insert(u2, p3);
    end;

    Field_Of_View_Module.Change_FOV(60, 0.3);
    Blur_Module.Blur(15, 0.1);
end;

function v1.Hide(p4) -- Line: 17
    -- upvalues: u2 (copy), Field_Of_View_Module (copy), Blur_Module (copy)
    local table_find_ret = table.find(u2, p4);

    if table_find_ret then
        table.remove(u2, table_find_ret);
    end;

    if #u2 == 0 then
        Field_Of_View_Module.Change_FOV_CORE(70, 0.3);
        Field_Of_View_Module.Change_FOV(70, 0.3);
        Blur_Module.Blur(0, 0.3);
    end;
end;

function v1.Can() -- Line: 32
    -- upvalues: u2 (copy)
    return #u2 == 0;
end;

return v1;