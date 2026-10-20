-- Decompiled with Potassium's decompiler.

game:GetService("Players");
game:GetService("ServerScriptService");
local TradeWorldController = require(game.ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local u1 = {};

local function RegisterFarm(u2) -- Line: 13
    -- upvalues: u1 (copy)
    if u2:GetAttribute("CommunityGarden") then
        return;
    end;

    local Important = u2:FindFirstChild("Important");

    if not Important then
        warn(u2, "doesn\'t have important attached?");

        return;
    end;

    local Data = Important:FindFirstChild("Data");

    if not Data then
        return;
    end;

    u1[Data.Owner.Value] = u2;
    local Value = Data.Owner.Value;
    Data.Owner.Changed:Connect(function(p3) -- Line: 31
        -- upvalues: u1 (ref), Value (ref), u2 (copy)
        u1[Value] = nil;
        u1[p3] = u2;
        Value = p3;
    end);
end;

for _, v in require(game.ReplicatedStorage.Modules.GetFarmsAsync)() do
    RegisterFarm(v);
end;

workspace.Farm.ChildAdded:Connect(RegisterFarm);

local function GetFarm_Legacy(p4) -- Line: 45
    -- upvalues: TradeWorldController (copy)
    if TradeWorldController:IsInWorld() then
        return nil;
    end;

    if not p4 then
        return;
    end;

    for _, child in workspace.Farm:GetChildren() do
        local Important = child:FindFirstChild("Important");

        if Important then
            local Data = Important:FindFirstChild("Data");

            if Data and Data.Owner.Value == p4.Name then
                return child;
            end;
        end;
    end;
end;

return function(p5) -- Line: 57, Name: GetFarm
    -- upvalues: TradeWorldController (copy), u1 (copy), GetFarm_Legacy (copy)
    if TradeWorldController:IsInWorld() then
        return nil;
    end;

    if p5 then
        if u1[p5.Name] then
            return u1[p5.Name];
        end;

        return GetFarm_Legacy(p5);
    end;
end;