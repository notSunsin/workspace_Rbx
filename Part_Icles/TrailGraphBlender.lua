-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);

return {
    CollectStates = function(p1) -- Line: 17, Name: CollectStates
        local v2 = {};
        local v3 = {};
        local v4 = {};

        if not p1 then
            return v2, v3, v4;
        end;

        for _, child in pairs(p1:GetChildren()) do
            if child:IsA("Configuration") then
                local Attribute = child:GetAttribute("Time");

                if Attribute == nil then
                    local v5 = tonumber(string.match(child.Name, "%d+"));
                    Attribute = v5 and v5 - 1 or 0;
                end;

                local Attribute2 = child:GetAttribute("Width");

                if Attribute2 and typeof(Attribute2) == "NumberSequence" then
                    table.insert(v2, {
                        Time = Attribute,
                        Graph = Attribute2
                    });
                end;

                local Attribute3 = child:GetAttribute("Transparency");

                if Attribute3 and typeof(Attribute3) == "NumberSequence" then
                    table.insert(v3, {
                        Time = Attribute,
                        Graph = Attribute3
                    });
                end;

                local Attribute4 = child:GetAttribute("Color");

                if Attribute4 and typeof(Attribute4) == "ColorSequence" then
                    table.insert(v4, {
                        Time = Attribute,
                        Graph = Attribute4
                    });
                end;
            end;
        end;

        for _, v in ipairs({ v2, v3, v4 }) do
            table.sort(v, function(p6, p7) -- Line: 44
                return p6.Time < p7.Time;
            end);

            if #v > 1 and v[#v].Time > 1 then
                local Time = v[#v].Time;

                if Time > 0 then
                    for _, v5 in ipairs(v) do
                        v5.Time = v5.Time / Time;
                    end;
                end;
            end;
        end;

        return v2, v3, v4;
    end,

    PrecomputeMergedTimes = Graph.PrecomputeMergedTimes,
    PrecomputeMergedColorTimes = Graph.PrecomputeMergedColorTimes,
    LerpGraphFast = Graph.LerpGraphFast,
    LerpColorGraphFast = Graph.LerpColorGraphFast
};