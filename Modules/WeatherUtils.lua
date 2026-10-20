-- Decompiled with Potassium's decompiler.

local v1 = {};
local HttpService = game:GetService("HttpService");

function v1.IsThisWeatherRunning(p2: string) -- Line: 6
    -- upvalues: HttpService (copy)
    local Attribute = workspace:GetAttribute("CurrentWeatherEvents");

    if not Attribute then
        return false;
    end;

    local v3 = HttpService:JSONDecode(Attribute);

    return table.find(v3, p2) ~= nil;
end;

function v1.GetCurrentWeathers() -- Line: 16
    -- upvalues: HttpService (copy)
    local Attribute = workspace:GetAttribute("CurrentWeatherEvents");

    if Attribute then
        return HttpService:JSONDecode(Attribute);
    end;

    return nil;
end;

return v1;