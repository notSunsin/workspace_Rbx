-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = {};

function v1.add(p3, p4) -- Line: 4
    -- upvalues: u2 (ref)
    table.insert(u2, p4);
end;

function v1.remove(p5, p6) -- Line: 8
    -- upvalues: u2 (ref)
    for i, v in ipairs(u2) do
        if v == p6 then
            if i ~= #u2 then
                u2[i] = u2[#u2];
            end;

            u2[#u2] = nil;

            return;
        end;
    end;
end;

function v1.updateAllCameras(p7) -- Line: 21
    -- upvalues: u2 (ref)
    for _, v in ipairs(u2) do
        v:updateCamera();
    end;
end;

function v1.getActiveCracks(p8) -- Line: 27
    -- upvalues: u2 (ref)
    return u2;
end;

function v1.clearAll(p9) -- Line: 31
    -- upvalues: u2 (ref)
    for i = #u2, 1, -1 do
        u2[i]:Destroy();
        local _ = i;
    end;

    u2 = {};
end;

return v1;