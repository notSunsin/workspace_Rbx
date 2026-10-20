-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local v1 = {
    Type = "CompressPollen"
};

local function fmt(p2: number) -- Line: 10
    if p2 < 10 then
        return string.format("%.1f", p2);
    end;

    local math_floor_ret = math.floor(p2 + 0.5);

    return tostring(math_floor_ret);
end;

function v1.Display(p3, p4, p5) -- Line: 15
    local v6 = {
        Description = "Submit pollinated honey plants to the Honey Compressor."
    };
    local v7;

    if p5 >= 10 then
        local math_floor_ret = math.floor(p5 + 0.5);
        v7 = tostring(math_floor_ret);
    else
        v7 = string.format("%.1f", p5);
    end;

    v6.Title = `Compress {v7}kg of pollinated plants`;
    local v8;

    if p4 >= 10 then
        local math_floor_ret = math.floor(p4 + 0.5);
        v8 = tostring(math_floor_ret);
    else
        v8 = string.format("%.1f", p4);
    end;

    local v9;

    if p5 >= 10 then
        local math_floor_ret = math.floor(p5 + 0.5);
        v9 = tostring(math_floor_ret);
    else
        v9 = string.format("%.1f", p5);
    end;

    v6.Bar = `{v8}/{v9}kg`;

    return v6;
end;

function v1.Use(p10, p11) -- Line: 23
    local table_clone_ret = table.clone(p11);
    table_clone_ret.Type = p10.Type;

    return table_clone_ret;
end;

return v1;