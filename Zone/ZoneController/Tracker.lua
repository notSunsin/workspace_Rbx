-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local _ = game:GetService("RunService").Heartbeat;
local Signal = require(script.Parent.Parent.Signal);
local Janitor = require(script.Parent.Parent.Janitor);
local u1 = {};
u1.__index = u1;
local u2 = {};
u1.trackers = u2;
u1.itemAdded = Signal.new();
u1.itemRemoved = Signal.new();
u1.bodyPartsToIgnore = {
    UpperTorso = true,
    LowerTorso = true,
    Torso = true,
    LeftHand = true,
    RightHand = true,
    LeftFoot = true,
    RightFoot = true
};

function u1.getCombinedTotalVolumes() -- Line: 35
    -- upvalues: u2 (copy)
    local v3 = 0;

    for i, _ in pairs(u2) do
        v3 = v3 + i.totalVolume;
    end;

    return v3;
end;

function u1.getCharacterSize(p4) -- Line: 43
    local v5;

    if p4 then
        v5 = p4:FindFirstChild("Head");
    else
        v5 = p4;
    end;

    if p4 then
        p4 = p4:FindFirstChild("HumanoidRootPart");
    end;

    if not (p4 and v5) then
        return nil;
    end;

    if not v5:IsA("BasePart") then
        v5 = p4;
    end;

    local Y = v5.Size.Y;
    local Size = p4.Size;

    return Size * Vector3.new(2, 2, 1) + Vector3.new(0, Y, 0), p4.CFrame * CFrame.new(0, Y / 2 - Size.Y / 2, 0);
end;

function u1.new(p6) -- Line: 60
    -- upvalues: u1 (copy), Janitor (copy), Players (copy), u2 (copy)
    local u7 = {};
    setmetatable(u7, u1);
    u7.name = p6;
    u7.totalVolume = 0;
    u7.parts = {};
    u7.partToItem = {};
    u7.items = {};
    u7.whitelistParams = nil;
    u7.characters = {};
    u7.baseParts = {};
    u7.exitDetections = {};
    u7.janitor = Janitor.new();

    if p6 == "player" then
        local function updatePlayerCharacters() -- Line: 76
            -- upvalues: Players (ref), u7 (copy)
            local v8 = {};

            for _, v in pairs(Players:GetPlayers()) do
                local Character = v.Character;

                if Character then
                    v8[Character] = true;
                end;
            end;

            u7.characters = v8;
        end;

        local function playerAdded(p9) -- Line: 87
            -- upvalues: updatePlayerCharacters (copy), u7 (copy)
            local function charAdded(p10) -- Line: 88
                -- upvalues: updatePlayerCharacters (ref), u7 (ref)
                local Humanoid = p10:WaitForChild("Humanoid", 3);

                if Humanoid then
                    updatePlayerCharacters();
                    u7:update();

                    for _, child in pairs(Humanoid:GetChildren()) do
                        if child:IsA("NumberValue") then
                            child.Changed:Connect(function() -- Line: 95
                                -- upvalues: u7 (ref)
                                u7:update();
                            end);
                        end;
                    end;
                end;
            end;

            if p9.Character then
                charAdded(p9.Character);
            end;

            p9.CharacterAdded:Connect(charAdded);
            p9.CharacterRemoving:Connect(function(p11) -- Line: 106
                -- upvalues: u7 (ref)
                u7.exitDetections[p11] = nil;
            end);
        end;

        Players.PlayerAdded:Connect(playerAdded);

        for _, v in pairs(Players:GetPlayers()) do
            playerAdded(v);
        end;

        Players.PlayerRemoving:Connect(function(p12) -- Line: 116
            -- upvalues: updatePlayerCharacters (copy), u7 (copy)
            updatePlayerCharacters();
            u7:update();
        end);
    elseif p6 == "item" then
        local function updateItem(p13, p14) -- Line: 123
            -- upvalues: u7 (copy)
            if p13.isCharacter then
                u7.characters[p13.item] = p14;
            elseif p13.isBasePart then
                u7.baseParts[p13.item] = p14;
            end;

            u7:update();
        end;

        u1.itemAdded:Connect(function(p15) -- Line: 131
            -- upvalues: u7 (copy)
            if p15.isCharacter then
                u7.characters[p15.item] = true;
            elseif p15.isBasePart then
                u7.baseParts[p15.item] = true;
            end;

            u7:update();
        end);
        u1.itemRemoved:Connect(function(p16) -- Line: 134
            -- upvalues: u7 (copy)
            u7.exitDetections[p16.item] = nil;

            if p16.isCharacter then
                u7.characters[p16.item] = nil;
            elseif p16.isBasePart then
                u7.baseParts[p16.item] = nil;
            end;

            u7:update();
        end);
    end;

    u2[u7] = true;
    task.defer(u7.update, u7);

    return u7;
end;

function u1._preventMultiFrameUpdates(u17, u18, ...) -- Line: 148
    u17._preventMultiDetails = u17._preventMultiDetails or {};
    local u19 = u17._preventMultiDetails[u18];

    if not u19 then
        u19 = {
            calling = false,
            callsThisFrame = 0,
            updatedThisFrame = false
        };
        u17._preventMultiDetails[u18] = u19;
    end;

    u19.callsThisFrame = u19.callsThisFrame + 1;

    if u19.callsThisFrame ~= 1 then
        return true;
    end;

    local table_pack_ret = table.pack(...);
    task.defer(function() -- Line: 165
        -- upvalues: u19 (ref), u17 (copy), u18 (copy), table_pack_ret (copy)
        local callsThisFrame = u19.callsThisFrame;
        u19.callsThisFrame = 0;

        if callsThisFrame > 1 then
            u17[u18](u17, unpack(table_pack_ret));
        end;
    end);

    return false;
end;

function u1.update(u20) -- Line: 177
    -- upvalues: u1 (copy), Janitor (copy)
    if u20:_preventMultiFrameUpdates("update") then
        return;
    end;

    u20.totalVolume = 0;
    u20.parts = {};
    u20.partToItem = {};
    u20.items = {};

    for i, _ in pairs(u20.characters) do
        local CharacterSize = u1.getCharacterSize(i);

        if CharacterSize then
            u20.totalVolume = u20.totalVolume + CharacterSize.X * CharacterSize.Y * CharacterSize.Z;
            local u21 = u20.janitor:add(Janitor.new(), "destroy", "trackCharacterParts-" .. u20.name);

            local function updateTrackerOnParentChanged(u22) -- Line: 198
                -- upvalues: u21 (ref), u20 (copy)
                u21:add(u22.AncestryChanged:Connect(function() -- Line: 199
                    -- upvalues: u22 (copy), u21 (ref), u20 (ref)
                    if not (u22:IsDescendantOf(game) or (u22.Parent ~= nil or u21 == nil)) then
                        u21:destroy();
                        u21 = nil;
                        u20:update();
                    end;
                end), "Disconnect");
            end;

            local u23 = i;

            for _, child in pairs(i:GetChildren()) do
                if child:IsA("BasePart") and not u1.bodyPartsToIgnore[child.Name] then
                    u20.partToItem[child] = u23;
                    table.insert(u20.parts, child);
                    u21:add(child.AncestryChanged:Connect(function() -- Line: 199
                        -- upvalues: child (copy), u21 (ref), u20 (copy)
                        if not (child:IsDescendantOf(game) or (child.Parent ~= nil or u21 == nil)) then
                            u21:destroy();
                            u21 = nil;
                            u20:update();
                        end;
                    end), "Disconnect");
                end;
            end;

            u21:add(u23.AncestryChanged:Connect(function() -- Line: 199
                -- upvalues: u23 (copy), u21 (ref), u20 (copy)
                if not (u23:IsDescendantOf(game) or (u23.Parent ~= nil or u21 == nil)) then
                    u21:destroy();
                    u21 = nil;
                    u20:update();
                end;
            end), "Disconnect");
            table.insert(u20.items, u23);
        end;
    end;

    for i, _ in pairs(u20.baseParts) do
        local Size = i.Size;
        u20.totalVolume = u20.totalVolume + Size.X * Size.Y * Size.Z;
        u20.partToItem[i] = i;
        table.insert(u20.parts, i);
        table.insert(u20.items, i);
    end;

    u20.whitelistParams = OverlapParams.new();
    u20.whitelistParams.FilterType = Enum.RaycastFilterType.Whitelist;
    u20.whitelistParams.MaxParts = #u20.parts;
    u20.whitelistParams.FilterDescendantsInstances = u20.parts;
end;

return u1;