-- Decompiled with Potassium's decompiler.

local Stringify = require(game.ReplicatedStorage.UserGenerated.Strings.Stringify);
local DeepEquals = require(game.ReplicatedStorage.UserGenerated.Collections.DeepEquals);

local function StripErrorSource(p1) -- Line: 35
    local v2 = tostring(p1);
    local string_match_ret, v3 = string.match(v2, "^(.*:%d+): (.+)$");

    if string_match_ret then
        v2 = v3 or v2;
    end;

    return v2;
end;

local function ToString(p4) -- Line: 45
    -- upvalues: Stringify (copy)
    return Stringify.Pretty(p4, {
        Pretty = false,
        IndentChar = "",
        IndentSize = 0
    });
end;

return table.freeze({
    IsEqual = function(p5, p6) -- Line: 21, Name: Equals
        return rawequal(p5, p6) and true or not (type(p5) == "table" and type(p6) == "table" or (p5 == p5 or p6 == p6));
    end,

    ErrorUnsafe = function(p7: any, p8: function, ...) -- Line: 57, Name: ErrorUnsafe
        local u9 = nil;
        local table_pack_ret = table.pack(xpcall(p8, function(p10) -- Line: 59
            -- upvalues: u9 (ref)
            u9 = p10;
        end, ...));

        if table_pack_ret[1] then
            error("ExpectedError", 2);
        end;

        if u9 ~= p7 then
            error(`ExpectedError Mismatch: {string.format("%q", (tostring(u9)))}`, 2);
        end;

        return table.unpack(table_pack_ret, 2);
    end,

    Error = function(p11: any, p12: function, ...) -- Line: 72, Name: Error
        -- upvalues: Stringify (copy)
        local u13 = nil;
        local table_pack_ret = table.pack(xpcall(p12, function(p14) -- Line: 74
            -- upvalues: u13 (ref)
            u13 = p14;
        end, ...));

        if table_pack_ret[1] then
            error(`ExpectedError({Stringify.Pretty(p11, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })})`, 2);
        end;

        if type(u13) == "string" then
            local v15 = tostring(u13);
            local string_match_ret, v16 = string.match(v15, "^(.*:%d+): (.+)$");

            if string_match_ret then
                v15 = v16 or v15;
            end;

            u13 = v15;
        end;

        if p11 ~= u13 then
            error(`ExpectedError({Stringify.Pretty(p11, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })}): {Stringify.Pretty(u13, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })}`, 2);
        end;

        return table.unpack(table_pack_ret, 2);
    end,

    Equal = function(p17, p18) -- Line: 90, Name: Equal
        -- upvalues: Stringify (copy)
        if not rawequal(p17, p18) and (type(p17) == "table" and type(p18) == "table" or (p17 == p17 or p18 == p18)) then
            error(`Equal({Stringify.Pretty(p17, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })}, {Stringify.Pretty(p18, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })})`, 2);
        end;
    end,

    DeepEqual = function(p19, p20) -- Line: 96, Name: DeepEqual
        -- upvalues: DeepEquals (copy), Stringify (copy)
        if not DeepEquals(p19, p20) then
            error(`DeepEqual({Stringify.Pretty(p19, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })}, {Stringify.Pretty(p20, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })})`, 2);
        end;
    end,

    FuzzyEqual = function(p21: number, p22: number, p23: number?) -- Line: 102, Name: FuzzyEqual
        if (p23 or 0.001) < math.abs(p21 - p22) then
            error(`FuzzyEqual({tostring(p21)}, {tostring(p22)}): {math.abs(p21 - p22)}`, 2);
        end;
    end,

    ColorEqual = function(p24, p25, p26: number?) -- Line: 109, Name: ColorEqual
        -- upvalues: Stringify (copy)
        local v27 = Vector3.new(p24.R, p24.G, p24.B) * 255;

        if (p26 or 0.001) < (Vector3.new(p25.R, p25.G, p25.B) * 255 - v27).Magnitude then
            error(`ColorEqual({Stringify.Pretty(p24, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })}, {Stringify.Pretty(p25, {
                Pretty = false,
                IndentChar = "",
                IndentSize = 0
            })})`, 2);
        end;
    end
});