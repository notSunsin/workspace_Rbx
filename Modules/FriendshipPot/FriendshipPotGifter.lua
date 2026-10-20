-- Decompiled with Potassium's decompiler.

local v1 = {};
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");
local FriendshipPotToolService_RE = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("FriendshipPotToolService_RE");
local Notification = require(ReplicatedStorage.Modules.Notification);
local FriendsAPI = require(ReplicatedStorage.Modules.FriendsAPI);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
local LocalPlayer = Players.LocalPlayer;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = false;
local Part = Instance.new("Part");
Part.Size = Vector3.new(1, 1, 1);
Part.Transparency = 1;
Part.Anchored = false;
Part.CanCollide = false;
Part.CanQuery = false;
Part.Massless = true;
Part.RootPriority = -1;
Part.Parent = workspace;
local Weld = Instance.new("Weld");
Weld.Part0 = Part;
Weld.Parent = Part;
local ProximityPrompt = Instance.new("ProximityPrompt");
ProximityPrompt.Exclusivity = Enum.ProximityPromptExclusivity.OnePerButton;
ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E;
ProximityPrompt.RequiresLineOfSight = false;
ProximityPrompt.HoldDuration = 0.5;
ProximityPrompt.MaxActivationDistance = 15;
ProximityPrompt.ObjectText = "Friendship Pot";
ProximityPrompt.Parent = Part;
ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
ProximityPrompt:SetAttribute("Theme", "ShadowedPrompt");
local u6 = nil;
local u7 = nil;

local function GetClosestCharacter() -- Line: 54
    -- upvalues: LocalPlayer (copy), Players (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return nil;
    end;

    local v8 = (1 / 0);
    local v9 = nil;

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer then
            local Character2 = v.Character;

            if Character2 then
                local Magnitude = (Character2:GetPivot().Position - Character:GetPivot().Position).Magnitude;

                if v8 > Magnitude and Magnitude < 15 then
                    v9 = Character2;
                    v8 = Magnitude;
                end;
            end;
        end;
    end;

    return v9;
end;

local function UpdateProximityPrompt() -- Line: 78
    -- upvalues: u5 (ref), GetClosestCharacter (copy), u6 (ref), Part (copy), Weld (copy), ProximityPrompt (copy)
    local v10;

    if u5 then
        v10 = GetClosestCharacter();
    else
        v10 = nil;
    end;

    if u6 ~= v10 then
        u6 = v10;
        local v11;

        if v10 == nil then
            v11 = script;
        else
            v11 = workspace;
        end;

        Part.Parent = v11;
        local v12;

        if v10 then
            v12 = v10.PrimaryPart;
        else
            v12 = nil;
        end;

        Weld.Part1 = v12;
        ProximityPrompt.ActionText = not v10 and "" or `Link/Share with {v10.Name}`;
    end;
end;

local function Cleanup() -- Line: 89
    -- upvalues: u2 (ref), u3 (ref), u4 (ref), u5 (ref), GetClosestCharacter (copy), u6 (ref), Part (copy), Weld (copy), ProximityPrompt (copy)
    if u2 then
        u2:Disconnect();
        u2 = nil;
    end;

    if u3 then
        u3:Disconnect();
        u3 = nil;
    end;

    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    u5 = false;
    local v13;

    if u5 then
        v13 = GetClosestCharacter();
    else
        v13 = nil;
    end;

    if u6 ~= v13 then
        u6 = v13;
        local v14;

        if v13 == nil then
            v14 = script;
        else
            v14 = workspace;
        end;

        Part.Parent = v14;
        local v15;

        if v13 then
            v15 = v13.PrimaryPart;
        else
            v15 = nil;
        end;

        Weld.Part1 = v15;
        ProximityPrompt.ActionText = not v13 and "" or `Link/Share with {v13.Name}`;
    end;
end;

local function UpdateCharacter(p16: userdata) -- Line: 109
    -- upvalues: u2 (ref), u3 (ref), u4 (ref), u5 (ref), GetClosestCharacter (copy), u6 (ref), Part (copy), Weld (copy), ProximityPrompt (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy), Notification (copy), u7 (ref)
    if u2 then
        u2:Disconnect();
        u2 = nil;
    end;

    if u3 then
        u3:Disconnect();
        u3 = nil;
    end;

    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    u5 = false;
    local v17;

    if u5 then
        v17 = GetClosestCharacter();
    else
        v17 = nil;
    end;

    if u6 ~= v17 then
        u6 = v17;
        local v18;

        if v17 == nil then
            v18 = script;
        else
            v18 = workspace;
        end;

        Part.Parent = v18;
        local v19;

        if v17 then
            v19 = v17.PrimaryPart;
        else
            v19 = nil;
        end;

        Weld.Part1 = v19;
        ProximityPrompt.ActionText = not v17 and "" or `Link/Share with {v17.Name}`;
    end;

    u2 = p16.ChildAdded:Connect(function(p20: userdata) -- Line: 112
        -- upvalues: InventoryServiceEnums (ref), ItemTypeEnums (ref), Notification (ref), u7 (ref), u5 (ref), GetClosestCharacter (ref), u6 (ref), Part (ref), Weld (ref), ProximityPrompt (ref)
        if not p20:IsA("Tool") then
            return;
        end;

        if p20:GetAttribute(InventoryServiceEnums.ITEM_TYPE) ~= ItemTypeEnums.FriendshipPot then
            return;
        end;

        if p20:GetAttribute(InventoryServiceEnums.LinkedPlayerID) then
            Notification:CreateNotification("Place your pot in your garden");

            return;
        end;

        u7 = p20;
        u5 = true;
        local v21;

        if u5 then
            v21 = GetClosestCharacter();
        else
            v21 = nil;
        end;

        if u6 ~= v21 then
            u6 = v21;
            local v22;

            if v21 == nil then
                v22 = script;
            else
                v22 = workspace;
            end;

            Part.Parent = v22;
            local v23;

            if v21 then
                v23 = v21.PrimaryPart;
            else
                v23 = nil;
            end;

            Weld.Part1 = v23;
            ProximityPrompt.ActionText = not v21 and "" or `Link/Share with {v21.Name}`;
        end;

        Notification:CreateNotification("Link your pot with a friend");
    end);
    u3 = p16.ChildRemoved:Connect(function(p24: userdata) -- Line: 127
        -- upvalues: InventoryServiceEnums (ref), ItemTypeEnums (ref), u7 (ref), u5 (ref), GetClosestCharacter (ref), u6 (ref), Part (ref), Weld (ref), ProximityPrompt (ref)
        if not p24:IsA("Tool") then
            return;
        end;

        if p24:GetAttribute(InventoryServiceEnums.ITEM_TYPE) ~= ItemTypeEnums.FriendshipPot then
            return;
        end;

        if p24:GetAttribute(InventoryServiceEnums.LinkedPlayerID) then
            return;
        end;

        u7 = nil;
        u5 = false;
        local v25;

        if u5 then
            v25 = GetClosestCharacter();
        else
            v25 = nil;
        end;

        if u6 ~= v25 then
            u6 = v25;
            local v26;

            if v25 == nil then
                v26 = script;
            else
                v26 = workspace;
            end;

            Part.Parent = v26;
            local v27;

            if v25 then
                v27 = v25.PrimaryPart;
            else
                v27 = nil;
            end;

            Weld.Part1 = v27;
            ProximityPrompt.ActionText = not v25 and "" or `Link/Share with {v25.Name}`;
        end;
    end);
    u5 = false;
    local v28;

    if u5 then
        v28 = GetClosestCharacter();
    else
        v28 = nil;
    end;

    if u6 ~= v28 then
        u6 = v28;
        local v29;

        if v28 == nil then
            v29 = script;
        else
            v29 = workspace;
        end;

        Part.Parent = v29;
        local v30;

        if v28 then
            v30 = v28.PrimaryPart;
        else
            v30 = nil;
        end;

        Weld.Part1 = v30;
        ProximityPrompt.ActionText = not v28 and "" or `Link/Share with {v28.Name}`;
    end;
end;

LocalPlayer.CharacterAdded:Connect(UpdateCharacter);
LocalPlayer.CharacterRemoving:Connect(Cleanup);

if LocalPlayer.Character then
    task.spawn(UpdateCharacter, LocalPlayer.Character);
end;

local u31 = 0;
RunService.PostSimulation:Connect(function(p32) -- Line: 149
    -- upvalues: u5 (ref), u31 (ref), GetClosestCharacter (copy), u6 (ref), Part (copy), Weld (copy), ProximityPrompt (copy)
    if not u5 then
        return;
    end;

    u31 = u31 + p32;

    if u31 < 0.1 then
        return;
    end;

    u31 = 0;
    local v33;

    if u5 then
        v33 = GetClosestCharacter();
    else
        v33 = nil;
    end;

    if u6 ~= v33 then
        u6 = v33;
        local v34;

        if v33 == nil then
            v34 = script;
        else
            v34 = workspace;
        end;

        Part.Parent = v34;
        local v35;

        if v33 then
            v35 = v33.PrimaryPart;
        else
            v35 = nil;
        end;

        Weld.Part1 = v35;
        ProximityPrompt.ActionText = not v33 and "" or `Link/Share with {v33.Name}`;
    end;
end);
ProximityPrompt.Triggered:Connect(function() -- Line: 163
    -- upvalues: u7 (ref), Players (copy), u6 (ref), FriendsAPI (copy), LocalPlayer (copy), StarterGui (copy), FriendshipPotToolService_RE (copy), InventoryServiceEnums (copy), Notification (copy)
    if not u7 then
        return;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u6);

    if not PlayerFromCharacter then
        return warn("No ReceiverPlayer");
    end;

    if not FriendsAPI:IsFriendsWithImmediate(LocalPlayer, PlayerFromCharacter) then
        pcall(function() -- Line: 168
            -- upvalues: StarterGui (ref), PlayerFromCharacter (copy)
            StarterGui:SetCore("PromptSendFriendRequest", PlayerFromCharacter);
        end);

        return;
    end;

    FriendshipPotToolService_RE:FireServer("BeginTrade", PlayerFromCharacter, u7:GetAttribute(InventoryServiceEnums.ITEM_UUID));
    Notification:CreateNotification("Link request sent!");
end);

return v1;