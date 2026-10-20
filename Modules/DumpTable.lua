-- Decompiled with Potassium's decompiler.

function dump(p1)
    local u2 = {
        ["\7"] = "\\a",
        ["\8"] = "\\b",
        ["\f"] = "\\f",
        ["\n"] = "\\n",
        ["\r"] = "\\r",
        ["\t"] = "\\t",
        ["\11"] = "\\v",
        ["\0"] = "\\0"
    };
    local u3 = {
        ["and"] = true,
        ["break"] = true,
        ["do"] = true,
        ["else"] = true,
        ["elseif"] = true,
        ["end"] = true,
        ["false"] = true,
        ["for"] = true,
        ["function"] = true,
        ["if"] = true,
        ["in"] = true,
        ["local"] = true,
        ["nil"] = true,
        ["not"] = true,
        ["or"] = true,
        ["repeat"] = true,
        ["return"] = true,
        ["then"] = true,
        ["true"] = true,
        ["until"] = true,
        ["while"] = true,
        continue = true
    };
    local u4 = {
        [DockWidgetPluginGuiInfo.new] = "DockWidgetPluginGuiInfo.new",
        [warn] = "warn",
        [CFrame.fromMatrix] = "CFrame.fromMatrix",
        [CFrame.fromAxisAngle] = "CFrame.fromAxisAngle",
        [CFrame.fromOrientation] = "CFrame.fromOrientation",
        [CFrame.fromEulerAnglesXYZ] = "CFrame.fromEulerAnglesXYZ",
        [CFrame.Angles] = "CFrame.Angles",
        [CFrame.fromEulerAnglesYXZ] = "CFrame.fromEulerAnglesYXZ",
        [CFrame.new] = "CFrame.new",
        [gcinfo] = "gcinfo",
        [os.clock] = "os.clock",
        [os.difftime] = "os.difftime",
        [os.time] = "os.time",
        [os.date] = "os.date",
        [tick] = "tick",
        [bit32.band] = "bit32.band",
        [bit32.extract] = "bit32.extract",
        [bit32.bor] = "bit32.bor",
        [bit32.bnot] = "bit32.bnot",
        [bit32.arshift] = "bit32.arshift",
        [bit32.rshift] = "bit32.rshift",
        [bit32.rrotate] = "bit32.rrotate",
        [bit32.replace] = "bit32.replace",
        [bit32.lshift] = "bit32.lshift",
        [bit32.lrotate] = "bit32.lrotate",
        [bit32.btest] = "bit32.btest",
        [bit32.bxor] = "bit32.bxor",
        [pairs] = "pairs",
        [NumberSequence.new] = "NumberSequence.new",
        [assert] = "assert",
        [tonumber] = "tonumber",
        [Color3.fromHSV] = "Color3.fromHSV",
        [Color3.toHSV] = "Color3.toHSV",
        [Color3.fromRGB] = "Color3.fromRGB",
        [Color3.new] = "Color3.new",
        [Delay] = "Delay",
        [Stats] = "Stats",
        [UserSettings] = "UserSettings",
        [coroutine.resume] = "coroutine.resume",
        [coroutine.yield] = "coroutine.yield",
        [coroutine.running] = "coroutine.running",
        [coroutine.status] = "coroutine.status",
        [coroutine.wrap] = "coroutine.wrap",
        [coroutine.create] = "coroutine.create",
        [coroutine.isyieldable] = "coroutine.isyieldable",
        [NumberRange.new] = "NumberRange.new",
        [PhysicalProperties.new] = "PhysicalProperties.new",
        [PluginManager] = "PluginManager",
        [Ray.new] = "Ray.new",
        [NumberSequenceKeypoint.new] = "NumberSequenceKeypoint.new",
        [Version] = "Version",
        [Vector2.new] = "Vector2.new",
        [Instance.new] = "Instance.new",
        [delay] = "delay",
        [spawn] = "spawn",
        [unpack] = "unpack",
        [string.split] = "string.split",
        [string.match] = "string.match",
        [string.gmatch] = "string.gmatch",
        [string.upper] = "string.upper",
        [string.gsub] = "string.gsub",
        [string.format] = "string.format",
        [string.lower] = "string.lower",
        [string.sub] = "string.sub",
        [string.pack] = "string.pack",
        [string.rep] = "string.rep",
        [string.char] = "string.char",
        [string.packsize] = "string.packsize",
        [string.reverse] = "string.reverse",
        [string.byte] = "string.byte",
        [string.unpack] = "string.unpack",
        [string.len] = "string.len",
        [string.find] = "string.find",
        [CellId.new] = "CellId.new",
        [ypcall] = "ypcall",
        [version] = "version",
        [print] = "print",
        [stats] = "stats",
        [printidentity] = "printidentity",
        [settings] = "settings",
        [UDim2.fromOffset] = "UDim2.fromOffset",
        [UDim2.fromScale] = "UDim2.fromScale",
        [UDim2.new] = "UDim2.new",
        [table.pack] = "table.pack",
        [table.move] = "table.move",
        [table.insert] = "table.insert",
        [table.getn] = "table.getn",
        [table.foreachi] = "table.foreachi",
        [table.maxn] = "table.maxn",
        [table.foreach] = "table.foreach",
        [table.concat] = "table.concat",
        [table.unpack] = "table.unpack",
        [table.find] = "table.find",
        [table.create] = "table.create",
        [table.sort] = "table.sort",
        [table.remove] = "table.remove",
        [TweenInfo.new] = "TweenInfo.new",
        [loadstring] = "loadstring",
        [require] = "require",
        [Vector3.FromNormalId] = "Vector3.FromNormalId",
        [Vector3.FromAxis] = "Vector3.FromAxis",
        [Vector3.fromAxis] = "Vector3.fromAxis",
        [Vector3.fromNormalId] = "Vector3.fromNormalId",
        [Vector3.new] = "Vector3.new",
        [Vector3int16.new] = "Vector3int16.new",
        [setmetatable] = "setmetatable",
        [next] = "next",
        [Wait] = "Wait",
        [wait] = "wait",
        [ipairs] = "ipairs",
        [elapsedTime] = "elapsedTime",
        [time] = "time",
        [rawequal] = "rawequal",
        [Vector2int16.new] = "Vector2int16.new",
        [collectgarbage] = "collectgarbage",
        [newproxy] = "newproxy",
        [Spawn] = "Spawn",
        [PluginDrag.new] = "PluginDrag.new",
        [Region3.new] = "Region3.new",
        [utf8.offset] = "utf8.offset",
        [utf8.codepoint] = "utf8.codepoint",
        [utf8.nfdnormalize] = "utf8.nfdnormalize",
        [utf8.char] = "utf8.char",
        [utf8.codes] = "utf8.codes",
        [utf8.len] = "utf8.len",
        [utf8.graphemes] = "utf8.graphemes",
        [utf8.nfcnormalize] = "utf8.nfcnormalize",
        [xpcall] = "xpcall",
        [tostring] = "tostring",
        [rawset] = "rawset",
        [PathWaypoint.new] = "PathWaypoint.new",
        [DateTime.fromUnixTimestamp] = "DateTime.fromUnixTimestamp",
        [DateTime.now] = "DateTime.now",
        [DateTime.fromIsoDate] = "DateTime.fromIsoDate",
        [DateTime.fromUnixTimestampMillis] = "DateTime.fromUnixTimestampMillis",
        [DateTime.fromLocalTime] = "DateTime.fromLocalTime",
        [DateTime.fromUniversalTime] = "DateTime.fromUniversalTime",
        [Random.new] = "Random.new",
        [typeof] = "typeof",
        [RaycastParams.new] = "RaycastParams.new",
        [math.log] = "math.log",
        [math.ldexp] = "math.ldexp",
        [math.rad] = "math.rad",
        [math.cosh] = "math.cosh",
        [math.random] = "math.random",
        [math.frexp] = "math.frexp",
        [math.tanh] = "math.tanh",
        [math.floor] = "math.floor",
        [math.max] = "math.max",
        [math.sqrt] = "math.sqrt",
        [math.modf] = "math.modf",
        [math.pow] = "math.pow",
        [math.atan] = "math.atan",
        [math.tan] = "math.tan",
        [math.cos] = "math.cos",
        [math.sign] = "math.sign",
        [math.clamp] = "math.clamp",
        [math.log10] = "math.log10",
        [math.noise] = "math.noise",
        [math.acos] = "math.acos",
        [math.abs] = "math.abs",
        [math.sinh] = "math.sinh",
        [math.asin] = "math.asin",
        [math.min] = "math.min",
        [math.deg] = "math.deg",
        [math.fmod] = "math.fmod",
        [math.randomseed] = "math.randomseed",
        [math.atan2] = "math.atan2",
        [math.ceil] = "math.ceil",
        [math.sin] = "math.sin",
        [math.exp] = "math.exp",
        [getfenv] = "getfenv",
        [pcall] = "pcall",
        [ColorSequenceKeypoint.new] = "ColorSequenceKeypoint.new",
        [ColorSequence.new] = "ColorSequence.new",
        [type] = "type",
        [Region3int16.new] = "Region3int16.new",
        [ElapsedTime] = "ElapsedTime",
        [select] = "select",
        [getmetatable] = "getmetatable",
        [rawget] = "rawget",
        [Faces.new] = "Faces.new",
        [Rect.new] = "Rect.new",
        [BrickColor.Blue] = "BrickColor.Blue",
        [BrickColor.White] = "BrickColor.White",
        [BrickColor.Yellow] = "BrickColor.Yellow",
        [BrickColor.Red] = "BrickColor.Red",
        [BrickColor.Gray] = "BrickColor.Gray",
        [BrickColor.palette] = "BrickColor.palette",
        [BrickColor.New] = "BrickColor.New",
        [BrickColor.Black] = "BrickColor.Black",
        [BrickColor.Green] = "BrickColor.Green",
        [BrickColor.Random] = "BrickColor.Random",
        [BrickColor.DarkGray] = "BrickColor.DarkGray",
        [BrickColor.random] = "BrickColor.random",
        [BrickColor.new] = "BrickColor.new",
        [setfenv] = "setfenv",
        [UDim.new] = "UDim.new",
        [Axes.new] = "Axes.new",
        [error] = "error",
        [debug.traceback] = "debug.traceback",
        [debug.profileend] = "debug.profileend",
        [debug.profilebegin] = "debug.profilebegin"
    };

    local function GetHierarchy(p5) -- Line: 6
        -- upvalues: u2 (copy), u3 (copy)
        local v6 = p5;
        local v7 = 1;
        local v8 = {};

        while p5 do
            p5 = p5.Parent;
            v7 = v7 + 1;
        end;

        local v9 = 0;

        while v6 do
            v9 = v9 + 1;
            local string_gsub_ret = string.gsub(v6.Name, "[%c%z]", u2);
            local v10 = v6 == game and "game" or string_gsub_ret;

            if u3[v10] or not string.match(v10, "^[_%a][_%w]*$") then
                v10 = "[\"" .. v10 .. "\"]";
            elseif v9 ~= v7 - 1 then
                v10 = "." .. v10;
            end;

            v8[v7 - v9] = v10;
            v6 = v6.Parent;
        end;

        return table.concat(v8);
    end;

    local function SerializeType(p11, p12) -- Line: 37
        -- upvalues: u2 (copy), GetHierarchy (copy), u4 (copy)
        if p12 == "string" then
            return string.format("\"%s\"", string.gsub(p11, "[%c%z]", u2));
        end;

        if p12 == "Instance" then
            return GetHierarchy(p11);
        end;

        if type(p11) ~= p12 then
            return p12 .. ".new(" .. tostring(p11) .. ")";
        end;

        if p12 == "function" then
            return u4[p11] or "\'[Unknown " .. (pcall(setfenv, p11, getfenv(p11)) and "Lua" or "C") .. " " .. tostring(p11) .. "]\'";
        end;

        if p12 == "userdata" then
            local v13 = getmetatable(p11) and true or false;

            return "newproxy(" .. tostring(v13) .. ")";
        end;

        if p12 == "thread" then
            return "\'" .. tostring(p11) .. ", status: " .. coroutine.status(p11) .. "\'";
        end;

        return tostring(p11);
    end;

    local function TableToString(p14, p15, p16, p17) -- Line: 55
        -- upvalues: u2 (copy), u3 (copy), TableToString (copy), SerializeType (copy)
        local v18 = p15 or {};
        local v19 = v18[p14];

        if v19 then
            return (v19[1] == p16[1] - 1 and "\'[Cyclic Parent " or "\'[Cyclic ") .. tostring(p14) .. ", path: " .. v19[2] .. "]\'";
        end;

        local v20 = p17 or "ROOT";
        local v21 = p16 or { 0, v20 };
        local v22 = v21[1] + 1;
        v21[1] = v22;
        v21[2] = v20;
        v18[p14] = v21;
        local string_rep_ret = string.rep("    ", v22);
        local string_rep_ret2 = string.rep("    ", v22 - 1);
        local v23 = "\n" .. string_rep_ret;
        local v24 = 1;
        local v25 = "{";
        local v26 = true;
        local v27 = true;

        for i, v in next, p14 do
            v27 = false;

            if v24 == i then
                v24 = v24 + 1;
            else
                v26 = false;
            end;

            local v28 = typeof(i);
            local v29 = typeof(v);
            local v30 = false;
            local v31;

            if v28 == "string" then
                v31 = string.gsub(i, "[%c%z]", u2);

                if u3[v31] or not string.match(v31, "^[_%a][_%w]*$") then
                    v31 = string.format("[\"%s\"]", v31);
                    v30 = true;
                end;
            else
                v31 = "[" .. (v28 == "table" and string.gsub(TableToString(i, v18, { v22, v20 }), "^%s*(.-)%s*$", "%1") or SerializeType(i, v28)) .. "]";
                v30 = true;
            end;

            local v32 = v29 == "table" and TableToString(v, v18, { v22, v20 }, v20 .. (v30 and "" or ".") .. v31) or SerializeType(v, v29);
            v25 = v25 .. v23 .. (v26 and v32 and v32 or v31 .. " = " .. v32) .. ",";
        end;

        return v27 and v25 .. "}" or string.sub(v25, 1, -2) .. "\n" .. string_rep_ret2 .. "}";
    end;

    return TableToString(p1);
end;

return dump;