-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
ReplicatedStorage:WaitForChild("Modules");
local DataStream = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("DataStream");
local class = require(script:WaitForChild("class"));
local Signal = require(script:WaitForChild("Signal"));
local TableListener = require(script:WaitForChild("TableListener"));
local DeepClone = require(script:WaitForChild("DeepClone"));
local u1 = {};
local u2 = {};
DataStream.OnClientEvent:Connect(function(...) -- Line: 17
    -- upvalues: u1 (copy), TableListener (copy), DeepClone (copy), u2 (copy)
    local v3 = { ... };
    local v4 = v3[1];

    if v4 ~= "InitData" then
        if v4 == "UpdateData" then
            local u5 = v3[2];
            local u6 = u1[u5];

            if not u6 then
                return;
            end;

            for _, v in v3[3] do
                task.spawn(function() -- Line: 40
                    -- upvalues: u6 (copy), v (copy), DeepClone (ref), u2 (ref), u5 (copy)
                    local Table = u6:GetTable();
                    local v7 = v[2];
                    local v8 = v[1]:split("/");

                    if #v8 < 1 then
                        return;
                    end;

                    table.remove(v8, 1);
                    local table_concat_ret = table.concat(v8, "/", 1, #v8);
                    local table_concat_ret2 = table.concat(v8, "/", 1, #v8 == 1 and 1 or #v8 - 1);
                    local v9 = nil;

                    for i, v2 in v8 do
                        local v10 = tonumber(v2) or v2;

                        if v9 then
                            v9 = `{v9}/{v10}`;
                        else
                            v9 = v10;
                        end;

                        local v11 = u6:FindPathSignal((`{v9}/@`));

                        if v11 then
                            v11:Fire(v10, v7, table_concat_ret);
                        end;

                        if i == #v8 then
                            local v12 = Table[v10];

                            if type(v7) == "table" and type(Table[v10]) == "table" then
                                Table[v10] = DeepClone(v7);
                            else
                                Table[v10] = v7;
                            end;

                            local v13 = u6:FindPathSignal((`{table_concat_ret2}`));

                            if v13 then
                                v13:Fire(v10, v7, v12, table_concat_ret2);
                            end;

                            local v14 = u6:FindPathSignal((`{table_concat_ret2}/*`));

                            if v14 then
                                v14:Fire(v10, v7, v12, table_concat_ret);
                            end;

                            local v15 = u2[u5];

                            if v15 then
                                v15.GlobalChanged:Fire(v10, v7, v12, table_concat_ret);
                            end;

                            local v16 = u6:FindPathSignal((`{table_concat_ret2}/{v10}`));

                            if v16 then
                                v16:Fire();

                                return;
                            end;

                            break;
                        end;

                        local v17 = Table[v10] or {};
                        Table[v10] = v17;

                        if v10 == #v8 - 1 then
                            Table = v17;
                        else
                            Table = v17;
                        end;
                    end;
                end);
            end;
        end;

        return;
    end;

    local v18 = v3[2];
    local v19 = v3[3];

    if not (v18 and v19) then
        return;
    end;

    u1[v18] = TableListener.new(v19);
end);
local v22 = class({
    Data = nil,

    Constructor = function(p20, p21) -- Line: 121, Name: Constructor
        -- upvalues: Signal (copy), DataStream (copy), u2 (copy)
        p20.Name = p21;
        p20.GlobalChanged = Signal.new();
        DataStream:FireServer("InitData");
        u2[p21] = p20;
    end
});

function v22.GetData(p23) -- Line: 132
    -- upvalues: u1 (copy)
    return u1[p23.Name];
end;

function v22.YieldUntilData(p24, p25) -- Line: 137
    local os_clock_ret = os.clock();
    local v26 = p25 or (1 / 0);
    local v27;

    while true do
        v27 = p24:GetData();

        if v27 or v26 <= os.clock() - os_clock_ret then
            break;
        end;

        task.wait();
    end;

    return v27;
end;

function v22.GetPathSignal(p28, p29) -- Line: 150
    local v30 = p28:YieldUntilData();

    if v30 then
        return v30:GetPathSignal(p29);
    end;
end;

return v22;