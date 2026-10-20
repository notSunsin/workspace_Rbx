-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = require(game.ReplicatedStorage.Modules.WeightedTable).new();

function v1.AddSkybox(p3, p4) -- Line: 7
    -- upvalues: u2 (copy)
    u2:Add(p3, p4 or 0);
end;

function v1.UpdateSkybox(p5, p6) -- Line: 12
    -- upvalues: u2 (copy)
    u2:SetWeight(p5, p6);
end;

local u7 = nil;

local function checkSkyboxes() -- Line: 18
    -- upvalues: u2 (copy), u7 (ref)
    local HighestObject, _ = u2:GetHighestObject();

    if u7 then
        u7.Parent = script;
    end;

    u7 = HighestObject;
    u7.Parent = game.Lighting;
end;

v1.AddSkybox(game.Lighting.Cartoon, 1);
u2.OnUpdate:Connect(checkSkyboxes);
local HighestObject, _ = u2:GetHighestObject();

if u7 then
    u7.Parent = script;
end;

u7 = HighestObject;
u7.Parent = game.Lighting;

return v1;