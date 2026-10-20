-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.GetFarm);
local GetFarmAsync = require(ReplicatedStorage.Modules.GetFarmAsync);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
local LocalPlayer = Players.LocalPlayer;
local Tutorial_UI = LocalPlayer.PlayerGui.Tutorial_UI;
local Pointer = Tutorial_UI.Pointer;
local Focus = Tutorial_UI.Focus;

local function getTools() -- Line: 20
    -- upvalues: LocalPlayer (copy)
    local v1 = {};

    for _, child in LocalPlayer.Backpack:GetChildren() do
        if child:IsA("Tool") then
            table.insert(v1, child);
        end;
    end;

    local Character = LocalPlayer.Character;
    local v2;

    if Character then
        v2 = Character:FindFirstChildWhichIsA("Tool");
    else
        v2 = nil;
    end;

    if v2 then
        table.insert(v1, v2);
    end;

    return v1;
end;

local function hasSeed() -- Line: 36
    -- upvalues: getTools (copy)
    for _, v in getTools() do
        if string.find(v.Name, "Seed") then
            return true;
        end;
    end;

    return false;
end;

local u3 = nil;

local function focusObject(u4) -- Line: 120
    -- upvalues: u3 (ref), Focus (copy), FastTween (copy), RunService (copy)
    while u3 do
        task.wait();
    end;

    u3 = true;
    Focus.Visible = true;
    FastTween(Focus.UIStroke, TweenInfo.new(0.2), {
        Transparency = 0.3
    });
    local u8 = RunService.PreRender:Connect(function() -- Line: 130, Name: updatePosition
        -- upvalues: u4 (copy), Focus (ref)
        local v5, v6;

        if type(u4) == "function" then
            local v7 = u4();

            if v7 == nil then
                return;
            end;

            v5 = v7.Size;
            v6 = v7.Position + v5 * 0.5;
        else
            v5 = u4.AbsoluteSize;
            v6 = u4.AbsolutePosition + v5 * 0.5;
        end;

        Focus.Position = UDim2.fromOffset(v6.X, v6.Y);
        Focus.Size = UDim2.fromOffset(v5.X, v5.Y);
    end);

    return function() -- Line: 152
        -- upvalues: u8 (copy), u3 (ref), FastTween (ref), Focus (ref)
        if not u8.Connected then
            return;
        end;

        u8:Disconnect();
        u3 = false;
        FastTween(Focus.UIStroke, TweenInfo.new(0.2), {
            Transparency = 1
        }).Completed:Once(function() -- Line: 160
            -- upvalues: Focus (ref)
            Focus.Visible = false;
        end);
    end;
end;

local u9 = false;

return {
    getTools = getTools,
    hasSeed = hasSeed,

    waitForSeed = function() -- Line: 46, Name: waitForSeed
        -- upvalues: hasSeed (copy)
        while not hasSeed() do
            task.wait(0.1);
        end;

        return true;
    end,

    waitUntilSellableItem = function() -- Line: 56, Name: waitUntilSellableItem
        -- upvalues: getTools (copy)
        while true do
            for _, v in getTools() do
                if v:FindFirstChild("Item_String") then
                    return true;
                end;
            end;

            task.wait(0.1);
        end;
    end,

    waitUntilNoSellableItems = function() -- Line: 68, Name: waitUntilNoSellableItems
        -- upvalues: getTools (copy)
        while true do
            local v10 = false;

            for _, v in getTools() do
                if v:FindFirstChild("Item_String") then
                    v10 = true;
                end;
            end;

            if not v10 then
                return true;
            end;

            task.wait(0.1);
        end;
    end,

    waitForFarm = function() -- Line: 85, Name: waitForFarm
        -- upvalues: GetFarmAsync (copy), LocalPlayer (copy)
        return GetFarmAsync(LocalPlayer);
    end,

    waitUntilDistance = function(p11: vector, p12: number) -- Line: 97, Name: waitUntilDistance
        -- upvalues: LocalPlayer (copy)
        while not LocalPlayer.Character or LocalPlayer:DistanceFromCharacter(p11) > p12 do
            task.wait(0.1);
        end;
    end,

    waitUntilSeedEquipped = function() -- Line: 107, Name: waitUntilSeedEquipped
        -- upvalues: LocalPlayer (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy)
        while true do
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChildWhichIsA("Tool");
            end;

            if Character and Character:GetAttribute(InventoryServiceEnums.ITEM_TYPE) == ItemTypeEnums.Seed then
                return;
            end;

            task.wait(0.1);
        end;
    end,

    pointToUI = function(u13: function, p14: userdata?, p15: number?, p16: string?) -- Line: 168, Name: pointToUI
        -- upvalues: u9 (ref), Pointer (copy), Tutorial_UI (copy), FastTween (copy), RunService (copy)
        while u9 do
            task.wait();
        end;

        u9 = true;
        local u17 = false;

        local function updatePosition() -- Line: 177
            -- upvalues: u13 (copy), Pointer (ref)
            local v18 = u13(Pointer);

            if not v18 then
                return;
            end;

            Pointer.Position = UDim2.fromOffset(v18.X, v18.Y);
        end;

        Pointer.Image = p16 or "rbxassetid://7553620727";
        Pointer.Parent = p14 or Tutorial_UI;
        Pointer.UIScale.Scale = p15 or 1;
        Pointer.Visible = true;
        FastTween(Pointer, TweenInfo.new(0.3), {
            ImageTransparency = 0
        });
        local u19 = FastTween(Pointer.UIScale, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Scale = (p15 or 1) * 1.1
        });
        local u20 = RunService.PreRender:Connect(updatePosition);

        return function() -- Line: 200
            -- upvalues: u17 (ref), u9 (ref), u20 (copy), u19 (copy), FastTween (ref), Pointer (ref), Tutorial_UI (ref)
            if u17 then
                return;
            end;

            u17 = true;
            u9 = false;

            if u20 then
                u20:Disconnect();
            end;

            if u19 then
                u19:Cancel();
            end;

            FastTween(Pointer, TweenInfo.new(0.2), {
                ImageTransparency = 1
            });
            Pointer.Visible = false;
            Pointer.Parent = Tutorial_UI;
        end;
    end,

    focusObject = focusObject,

    getDistanceTo = function(p21: vector) -- Line: 89, Name: getDistanceTo
        -- upvalues: LocalPlayer (copy)
        return not LocalPlayer.Character and (1 / 0) or LocalPlayer:DistanceFromCharacter(p21);
    end
};