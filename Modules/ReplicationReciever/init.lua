-- Decompiled with Potassium's decompiler.

local DataStream2 = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("DataStream2");
local _ = script.Parent;
require(script:WaitForChild("Signal"));
local PathSignalClass = require(script:WaitForChild("PathSignalClass"));
local DeepClone = require(script:WaitForChild("DeepClone"));
local u1 = {};
local u2 = {};
u2.__index = u2;

function u2.new(p3: string) -- Line: 41
    -- upvalues: u2 (copy)
    local v4 = setmetatable({}, u2);
    v4.Name = p3;

    return v4;
end;

function u2.GetChannelData(p5) -- Line: 47
    -- upvalues: u1 (copy)
    return u1[p5.Name];
end;

function u2.GetChannelDataAsync(p6: any, p7: number?) -- Line: 52
    local ChannelData = p6:GetChannelData();

    if not ChannelData then
        local v8 = 0;
        local v9 = p7 or (1 / 0);

        repeat
            v8 = v8 + task.wait();
            ChannelData = p6:GetChannelData();

            if v9 <= v8 then
                return ChannelData;
            end;
        until ChannelData;
    end;

    return ChannelData;
end;

function u2.GetData(p10) -- Line: 72
    -- upvalues: u1 (copy)
    local v11 = u1[p10.Name];

    if v11 then
        return v11.Table;
    end;
end;

function u2.Destroy(p12) -- Line: 77
    -- upvalues: u1 (copy)
    u1[p12.Name] = nil;
end;

function u2.GetDataAsync(p13: any, p14: number?) -- Line: 81
    return p13:GetChannelDataAsync(p14).Table;
end;

function u2.GetPathSignal(p15: any, p16: string) -- Line: 86
    local ChannelDataAsync = p15:GetChannelDataAsync();

    if ChannelDataAsync then
        return ChannelDataAsync:GetPathSignal(p16);
    end;
end;

local u32 = {
    InitData = function(p17, p18) -- Line: 93
        -- upvalues: u1 (copy), PathSignalClass (copy)
        if not (p17 and p18) then
            return;
        end;

        u1[p17] = PathSignalClass.new(p18);
    end,

    UpdateData = function(p19, p20) -- Line: 97
        -- upvalues: u1 (copy), DeepClone (copy)
        local u21 = u1[p19];

        if not u21 then
            return;
        end;

        for _, v in p20 do
            task.spawn(function() -- Line: 101
                -- upvalues: u21 (copy), v (copy), DeepClone (ref)
                local Table = u21:GetTable();
                local v22 = v[2];
                local v23 = v[1]:split("/");

                if #v23 < 1 then
                    return;
                end;

                table.remove(v23, 1);
                local table_concat_ret = table.concat(v23, "/", 1, #v23);
                local table_concat_ret2 = table.concat(v23, "/", 1, #v23 == 1 and 1 or #v23 - 1);
                local v24 = Table[v23[#v23]];
                local v25 = nil;

                for i, v2 in v23 do
                    local v26 = tonumber(v2) or v2;

                    if v25 then
                        v25 = `{v25}/{v26}`;
                    else
                        v25 = v26;
                    end;

                    local v27 = u21:FindPathSignal((`{v25}/@`));

                    if v27 then
                        v27:Fire(v26, v22, table_concat_ret, v24);
                    end;

                    if i == #v23 then
                        if type(v22) == "table" and type(Table[v26]) == "table" then
                            Table[v26] = DeepClone(v22);
                        else
                            Table[v26] = v22;
                        end;

                        local v28 = u21:FindPathSignal((`{table_concat_ret2}`));

                        if v28 then
                            v28:Fire(v26, v22, v24, table_concat_ret2);
                        end;

                        local v29 = u21:FindPathSignal((`{table_concat_ret2}/*`));

                        if v29 then
                            v29:Fire(v26, v22, v24, table_concat_ret);
                        end;

                        local v30 = u21:FindPathSignal((`{table_concat_ret2}/{v26}`));

                        if v30 then
                            v30:Fire();

                            return;
                        end;

                        break;
                    end;

                    local v31 = Table[v26] or {};
                    Table[v26] = v31;

                    if v26 == #v23 - 1 then
                        Table = v31;
                    else
                        Table = v31;
                    end;
                end;
            end);
        end;
    end
};
DataStream2.OnClientEvent:Connect(function(...) -- Line: 171
    -- upvalues: u32 (copy)
    local v33 = { ... };
    local v34 = v33[1];
    table.remove(v33, 1);
    local v35 = u32[v34];

    if not v35 then
        return;
    end;

    v35(unpack(v33));
end);

return u2;