-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
local v1 = {};

local function RoundToDP(p2: number, p3: number) -- Line: 18
    return math.round(p2 * 10 ^ p3) / 10 ^ p3;
end;

function v1.GetBoost(p4: table, p5: userdata) -- Line: 22
    -- upvalues: GetFarm (copy)
    local v6 = GetFarm(p5);

    if not v6 then
        return;
    end;

    local Important = v6:FindFirstChild("Important");

    if Important then
        Important = Important:FindFirstChild("Objects_Physical");
    end;

    if Important then
        local v7 = 0;
        local v8 = 0;

        for _, child in Important:GetChildren() do
            if child:HasTag("YuleLogObject") then
                local Attribute = child:GetAttribute("Lifetime");

                if Attribute and Attribute > 0 then
                    local math_clamp_ret = math.clamp(Attribute / 720, 0, 1);
                    v7 = v7 + math_clamp_ret * 0.2;
                    v8 = v8 + math_clamp_ret * 6;
                end;
            end;
        end;

        return (v8 ~= 0 or v7 ~= 0) and {
            Pet = v8,
            Cooking = v7
        } or nil;
    end;
end;

return v1;