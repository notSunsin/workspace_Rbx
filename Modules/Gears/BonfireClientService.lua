-- Decompiled with Potassium's decompiler.

game:GetService("HttpService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
require(ReplicatedStorage.Modules.CreateTagHandler);
require(ReplicatedStorage.Modules.GetPlayerFromFarm);
require(ReplicatedStorage.Modules.TwoPointCast);
require(ReplicatedStorage.Modules.GetFarmAncestor);
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);

return {
    GetBoost = function(p1: table, p2: userdata) -- Line: 27, Name: GetBoost
        -- upvalues: GetFarm (copy)
        local v3 = GetFarm(p2);

        if not v3 then
            return;
        end;

        local Important = v3:FindFirstChild("Important");

        if Important then
            Important = Important:FindFirstChild("Objects_Physical");
        end;

        if Important then
            local v4 = 0;
            local v5 = 0;

            for _, child in Important:GetChildren() do
                if child:HasTag("BonfireObject") then
                    local Attribute = child:GetAttribute("Lifetime");

                    if Attribute and Attribute > 0 then
                        local math_clamp_ret = math.clamp(Attribute / 300, 0, 1);
                        v4 = v4 + math_clamp_ret * 0.1;
                        v5 = v5 + math_clamp_ret * 0.5;
                    end;
                end;
            end;

            return (v5 ~= 0 or v4 ~= 0) and {
                Pet = v5,
                Cooking = v4
            } or nil;
        end;
    end
};