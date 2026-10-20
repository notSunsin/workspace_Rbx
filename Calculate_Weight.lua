-- Decompiled with Potassium's decompiler.

local v1 = {};
local Item_Module = require(game.ReplicatedStorage.Item_Module);

function v1.Calculate_Weight(p2, p3) -- Line: 4
    -- upvalues: Item_Module (copy)
    local Random_new_ret = Random.new(p2);
    local v4 = Item_Module.Return_Data(p3);

    if not v4 then
        return nil, nil;
    end;

    local v5 = Random_new_ret:NextInteger(700, 1400) * 0.001;

    if v4[4] ~= 0 and Random_new_ret:NextInteger(1, v4[4]) == 1 then
        v5 = v5 * Random_new_ret:NextInteger(3, 4);
    end;

    return v4[2] * v5, v5;
end;

return v1;