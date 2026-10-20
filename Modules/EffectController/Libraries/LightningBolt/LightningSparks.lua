-- Decompiled with Potassium's decompiler.

local script_Parent = require(script.Parent);
local u1 = {};
local Random_new_ret = Random.new();
local u2 = {};
u2.__index = u2;

function u2.new(p3, p4) -- Line: 11
    -- upvalues: u2 (copy), u1 (copy)
    local v5 = setmetatable({}, u2);
    v5.Enabled = true;
    v5.LightningBolt = p3;
    v5.MaxSparkCount = p4 or 10;
    v5.MinSpeed = 4;
    v5.MaxSpeed = 6;
    v5.MinDistance = 3;
    v5.MaxDistance = 6;
    v5.MinPartsPerSpark = 8;
    v5.MaxPartsPerSpark = 10;
    v5.SparksN = 0;
    v5.SlotTable = {};
    v5.RefIndex = #u1 + 1;
    u1[v5.RefIndex] = v5;

    return v5;
end;

function u2.Destroy(p6) -- Line: 34
    -- upvalues: u1 (copy)
    u1[p6.RefIndex] = nil;

    for i, v in pairs(p6.SlotTable) do
        if v.Parts[1].Parent == nil then
            p6.SlotTable[i] = nil;
        end;
    end;
end;

function RandomVectorOffset(p7, p8)
    -- upvalues: Random_new_ret (copy)
    local v9 = CFrame.lookAt(Vector3.new(), p7) * CFrame.Angles(0, 0, Random_new_ret:NextNumber(0, 6.283185307179586));
    local CFrame_Angles = CFrame.Angles;
    local v10 = Random_new_ret:NextNumber(math.cos(p8), 1);

    return (v9 * CFrame_Angles(math.acos(v10), 0, 0)).LookVector;
end;

game:GetService("RunService").Heartbeat:Connect(function() -- Line: 50
    -- upvalues: u1 (copy), Random_new_ret (copy), script_Parent (copy)
    for _, v in pairs(u1) do
        local v11;

        if v.Enabled == true and v.SparksN < v.MaxSparkCount then
            local LightningBolt = v.LightningBolt;

            if LightningBolt.Parts[1].Parent == nil then
                v:Destroy();

                return;
            end;

            local Parts = LightningBolt.Parts;
            local v12 = #Parts;
            v11 = v;
            local v13 = {};

            for i = 1, #Parts do
                local v14;

                if Parts[i].Transparency < 0.3 then
                    v13[#v13 + 1] = (i - 0.5) / v12;
                    v14 = i;
                else
                    v14 = i;
                end;
            end;

            local v15, v16;

            if #v13 == 0 then
                v15 = nil;
                v16 = nil;
            else
                v15 = math.ceil(v13[1] * v11.MaxSparkCount);
                v16 = math.ceil(v13[#v13] * v11.MaxSparkCount);
            end;

            for i = 1, Random_new_ret:NextInteger(1, v11.MaxSparkCount - v11.SparksN) do
                if #v13 == 0 then
                    break;
                end;

                local _ = i;
                local v17 = {};

                for i2 = v15, v16 do
                    local v18;

                    if v11.SlotTable[i2] == nil then
                        v17[#v17 + 1] = i2;
                        v18 = i2;
                    else
                        v18 = i2;
                    end;
                end;

                if #v17 ~= 0 then
                    local v19 = v17[Random_new_ret:NextInteger(1, #v17)];
                    local v20 = Random_new_ret:NextNumber(-0.5, 0.5);
                    local v21 = (v19 - 0.5 + v20) / v11.MaxSparkCount;
                    local v22 = 10;
                    local v23 = 1;

                    for i2 = 1, #v13 do
                        local math_abs_ret = math.abs(v13[i2] - v21);
                        local v24;

                        if math_abs_ret < v22 then
                            v23 = math.floor(v13[i2] * v12 + 0.5 + 0.5);
                            v22 = math_abs_ret;
                            v24 = i2;
                        else
                            v24 = i2;
                        end;
                    end;

                    local v25 = Parts[v23];
                    local v26 = {};
                    local v27 = {};
                    v26.WorldPosition = v25.Position + v20 * v25.CFrame.RightVector * v25.Size.X;
                    v27.WorldPosition = v26.WorldPosition + RandomVectorOffset(v25.CFrame.RightVector, 0.7853981633974483) * Random_new_ret:NextNumber(v11.MinDistance, v11.MaxDistance);
                    v26.WorldAxis = (v27.WorldPosition - v26.WorldPosition).Unit;
                    v27.WorldAxis = v26.WorldAxis;
                    local v28 = script_Parent.new(v26, v27, Random_new_ret:NextInteger(v11.MinPartsPerSpark, v11.MaxPartsPerSpark));
                    v28.MinRadius = 0;
                    v28.MaxRadius = 0.8;
                    v28.AnimationSpeed = 0;
                    v28.Thickness = v25.Size.Y / 2;
                    v28.MinThicknessMultiplier = 1;
                    v28.MaxThicknessMultiplier = 1;
                    v28.PulseLength = 0.5;
                    v28.PulseSpeed = Random_new_ret:NextNumber(v11.MinSpeed, v11.MaxSpeed);
                    v28.FadeLength = 0.25;
                    local Color3_toHSV_ret, _, v29 = Color3.toHSV(v25.Color);
                    v28.Color = Color3.fromHSV(Color3_toHSV_ret, 0.5, v29);
                    v11.SlotTable[v19] = v28;
                end;
            end;
        else
            v11 = v;
        end;

        local v30 = 0;

        for i, v2 in pairs(v11.SlotTable) do
            if v2.Parts[1].Parent == nil then
                v11.SlotTable[i] = nil;
            else
                v30 = v30 + 1;
            end;
        end;

        v11.SparksN = v30;
    end;
end);

return u2;