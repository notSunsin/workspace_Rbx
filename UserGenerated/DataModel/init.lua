-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local script_Encode = require(script.Encode);
local script_Reflection = require(script.Reflection);
local _, v1 = xpcall(function() -- Line: 49
    return workspace[nil];
end, function() -- Line: 51
    return debug.info(2, "f");
end);
local u4 = type(v1) ~= "function" and function(p2, p3) -- Line: 55
    return p2[p3];
end or v1;
local u5 = { "Workspace", "Players", "Lighting", "MaterialService", "ReplicatedFirst", "ReplicatedStorage", "SoundService", "StarterGui", "StarterPack", "StarterPlayer", "Teams", "TextChatService" };
local u6 = { "ServerScriptService", "ServerStorage" };

local function encodeId(p7: number) -- Line: 92
    local v8 = {};

    repeat
        v8[#v8 + 1] = string.char(p7 % 256);
        p7 = p7 // 256;
    until p7 == 0;

    return table.concat(v8);
end;

return {
    capture = function(p9: any, p10: number?) -- Line: 103, Name: capture
        -- upvalues: encodeId (copy), u5 (copy), RunService (copy), u6 (copy), script_Encode (copy), u4 (ref), script_Reflection (copy)
        local v11 = p9 or {};
        local v12 = v11.properties == true;
        local v13 = v11.yielding ~= false;
        local v14 = ((not p10 or p10 <= 0) and 0.016666666666666666 or p10) * 0.33;
        local v15 = os.clock() + 30;
        local u16 = {};
        local u17 = {};

        local function classIdx(p18: string) -- Line: 114
            -- upvalues: u17 (copy), u16 (copy)
            local v19 = u17[p18];

            if v19 then
                return v19;
            end;

            local v20 = #u16;
            u16[v20 + 1] = p18;
            u17[p18] = v20;

            return v20;
        end;

        local u21 = {};
        local u22 = {};

        local function propIdx(p23: string) -- Line: 127
            -- upvalues: u22 (copy), u21 (copy)
            local v24 = u22[p23];

            if v24 then
                return v24;
            end;

            local v25 = #u21;
            u21[v25 + 1] = p23;
            u22[p23] = v25;

            return v25;
        end;

        local u26 = {};
        local u27 = 0;
        local u28 = {};

        local function assign(p29: userdata) -- Line: 144
            -- upvalues: u26 (copy), u27 (ref), encodeId (ref), u28 (copy)
            local v30 = u26[p29];

            if v30 then
                return v30;
            end;

            u27 = u27 + 1;
            local v31 = encodeId(u27);
            u26[p29] = v31;
            u28[#u28 + 1] = p29;

            return v31;
        end;

        local v32 = game;

        if not u26[v32] then
            u27 = u27 + 1;
            u26[v32] = encodeId(u27);
            u28[#u28 + 1] = v32;
        end;

        local table_clone_ret = table.clone(u5);

        if RunService:IsServer() then
            for _, v in u6 do
                table.insert(table_clone_ret, v);
            end;
        end;

        for _, v in table_clone_ret do
            local success, result = pcall(function() -- Line: 165
                -- upvalues: v (copy)
                return game:GetService(v);
            end);

            if success and result then
                if not u26[result] then
                    u27 = u27 + 1;
                    u26[result] = encodeId(u27);
                    u28[#u28 + 1] = result;
                end;

                local success2, result2 = pcall(function() -- Line: 172
                    -- upvalues: result (copy)
                    return result:GetDescendants();
                end);

                if success2 and result2 then
                    for _, v2 in result2 do
                        if not u26[v2] then
                            u27 = u27 + 1;
                            u26[v2] = encodeId(u27);
                            u28[#u28 + 1] = v2;
                        end;
                    end;
                end;
            end;
        end;

        local v33 = script_Encode.newWriter(262144);
        v33:u8(68);
        v33:u8(1);
        v33:u8(v12 and 1 or 0);
        local os_clock_ret = os.clock();
        local v34 = 0;
        local v35 = false;

        for _, v in u28 do
            local v36, v37, v38, v39, v40, v41, v42, v43, v44, v45, v46, v47, v48, v49;

            if v == game then
                v36 = "";
                v37, v38 = pcall(u4, v, "ClassName");

                if v37 and type(v38) == "string" then
                    v39, v40 = pcall(u4, v, "Name");

                    if v39 then
                        if type(v40) ~= "string" then
                            v40 = v38;
                        end;
                    else
                        v40 = v38;
                    end;

                    v33:strU8(u26[v]);
                    v33:strU8(v36);
                    v41 = u17[v38];

                    if not v41 then
                        v41 = #u16;
                        u16[v41 + 1] = v38;
                        u17[v38] = v41;
                    end;

                    v33:u16(v41);
                    v33:strU16(v40);

                    if v12 then
                        v42 = script_Reflection.getReadProperties(v38);
                        v43 = v33.len;
                        v33:u16(0);
                        v44 = v;
                        v45 = 0;

                        for _, v2 in v42 do
                            v46, v47 = pcall(u4, v44, v2);

                            if v46 then
                                v48 = u22[v2];

                                if not v48 then
                                    v48 = #u21;
                                    u21[v48 + 1] = v2;
                                    u22[v2] = v48;
                                end;

                                v33:u16(v48);
                                script_Encode.writeValue(v33, v47);
                                v45 = v45 + 1;
                            end;
                        end;

                        v33:patchU16(v43, v45);
                    end;

                    v34 = v34 + 1;

                    if v33.len >= 50331648 then
                        v35 = true;
                        break;
                    end;

                    if v13 and v34 >= 20 then
                        v49 = os.clock();

                        if v15 <= v49 then
                            return {
                                TimedOut = true
                            };
                        end;

                        if v14 <= v49 - os_clock_ret then
                            task.wait();
                            os_clock_ret = os.clock();
                            v34 = 0;
                        end;
                    end;
                end;
            end;

            local success, result = pcall(u4, v, "Parent");

            if success and result ~= nil then
                v36 = u26[result] or "";

                if v36 ~= "" then
                    v37, v38 = pcall(u4, v, "ClassName");

                    if v37 and type(v38) == "string" then
                        v39, v40 = pcall(u4, v, "Name");

                        if v39 then
                            if type(v40) ~= "string" then
                                v40 = v38;
                            end;
                        else
                            v40 = v38;
                        end;

                        v33:strU8(u26[v]);
                        v33:strU8(v36);
                        v41 = u17[v38];

                        if not v41 then
                            v41 = #u16;
                            u16[v41 + 1] = v38;
                            u17[v38] = v41;
                        end;

                        v33:u16(v41);
                        v33:strU16(v40);

                        if v12 then
                            v42 = script_Reflection.getReadProperties(v38);
                            v43 = v33.len;
                            v33:u16(0);
                            v44 = v;
                            v45 = 0;

                            for _, v2 in v42 do
                                v46, v47 = pcall(u4, v44, v2);

                                if v46 then
                                    v48 = u22[v2];

                                    if not v48 then
                                        v48 = #u21;
                                        u21[v48 + 1] = v2;
                                        u22[v2] = v48;
                                    end;

                                    v33:u16(v48);
                                    script_Encode.writeValue(v33, v47);
                                    v45 = v45 + 1;
                                end;
                            end;

                            v33:patchU16(v43, v45);
                        end;

                        v34 = v34 + 1;

                        if v33.len >= 50331648 then
                            v35 = true;
                            break;
                        end;

                        if v13 and v34 >= 20 then
                            v49 = os.clock();

                            if v15 <= v49 then
                                return {
                                    TimedOut = true
                                };
                            end;

                            if v14 <= v49 - os_clock_ret then
                                task.wait();
                                os_clock_ret = os.clock();
                                v34 = 0;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        return {
            Buffer = v33:finish(),
            Classes = u16,
            Props = u21,
            Truncated = v35
        };
    end
};