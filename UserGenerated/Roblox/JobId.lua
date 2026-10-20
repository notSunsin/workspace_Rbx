-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local game_JobId = game.JobId;

if #game_JobId ~= 0 and game_JobId ~= "00000000-0000-0000-0000-000000000000" then
    return game_JobId;
end;

assert(RunService:IsStudio());

if not RunService:IsServer() then
    local v1;

    while true do
        v1 = script:GetAttribute("Studio");

        if type(v1) == "string" then
            break;
        end;

        task.wait();
    end;

    return v1;
end;

local v2 = HttpService:GenerateGUID(false):lower();
script:SetAttribute("Studio", v2);

return v2;