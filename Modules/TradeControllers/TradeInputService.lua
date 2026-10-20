-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
LocalPlayer.CharacterAdded:Connect(function(p2) -- Line: 6
    -- upvalues: u1 (ref)
    u1 = p2;
end);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local TradeRequestController = require(ReplicatedStorage.Modules.TradeControllers.TradeRequestController);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);

local function GetClosestCharacter() -- Line: 16
    -- upvalues: Players (copy), LocalPlayer (copy), TradeRequestController (copy), u1 (ref)
    local v3 = nil;
    local v4 = (1 / 0);
    local Players2 = Players:GetPlayers();
    local table_find_ret = table.find(Players2, LocalPlayer);

    if table_find_ret then
        table.remove(Players2, table_find_ret);
    end;

    for _, v in Players2 do
        local Character = v.Character;

        if Character and TradeRequestController:CanSendRequest(v) then
            local Magnitude = (Character:GetPivot().Position - u1:GetPivot().Position).Magnitude;

            if v4 > Magnitude and Magnitude < 8 then
                v3 = Character;
                v4 = Magnitude;
            end;
        end;
    end;

    return v3;
end;

local ProximityPrompt = Instance.new("ProximityPrompt");
ProximityPrompt.Exclusivity = Enum.ProximityPromptExclusivity.AlwaysShow;
ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E;
ProximityPrompt.RequiresLineOfSight = false;
ProximityPrompt.HoldDuration = 0.5;
ProximityPrompt.MaxActivationDistance = (1 / 0);
local u5 = nil;
ProximityPrompt.Triggered:Connect(function() -- Line: 62
    -- upvalues: u5 (ref), Players (copy), TradeRequestController (copy)
    if not u5 then
        return warn("No Closest");
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u5);

    if not PlayerFromCharacter then
        return warn("No player");
    end;

    TradeRequestController:SendRequest(PlayerFromCharacter);
end);
require(ReplicatedStorage.Data.DecimalNumberFormat);
task.spawn(function() -- Line: 71
    -- upvalues: u1 (ref), ProximityPrompt (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy), GetClosestCharacter (copy), u5 (ref)
    while true do
        while true do
            task.wait(0.5);
            local v6 = u1:FindFirstChildWhichIsA("Tool");

            if not v6 then
                break;
            end;

            if v6:GetAttribute(InventoryServiceEnums.ITEM_TYPE) == ItemTypeEnums["Trading Ticket"] then
                local v7 = GetClosestCharacter();
                u5 = v7;

                if v7 then
                    ProximityPrompt.ObjectText = v7.Name;
                    ProximityPrompt.ActionText = "Send Trade Request";
                    ProximityPrompt.Enabled = true;
                    ProximityPrompt.Parent = v7.PrimaryPart or v7:FindFirstChildWhichIsA("BasePart", true);
                else
                    ProximityPrompt.Enabled = false;
                end;
            else
                ProximityPrompt.Enabled = false;
            end;
        end;

        ProximityPrompt.Enabled = false;
    end;
end);

return {};