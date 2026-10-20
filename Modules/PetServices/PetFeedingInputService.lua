-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local FoodService = require(ReplicatedStorage.Modules.FoodService);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
require(ReplicatedStorage.Modules.InventoryService);
local DecimalNumberFormat = require(ReplicatedStorage.Data.DecimalNumberFormat);
local MINIMUM_DISTANCE_FOR_FEEDING = PetRegistry.PetConfig.PET_FEEDING_CONFIG.MINIMUM_DISTANCE_FOR_FEEDING;
local u2 = nil;
local u3 = {};
local TweenInfo_new_ret = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0);
local u4 = nil;
local u5 = nil;
local u6 = nil;

local function SetUpProxPrompt() -- Line: 32
    -- upvalues: u5 (ref), u6 (ref), u2 (ref), ActivePetsService (copy)
    u5 = Instance.new("Part");
    u5.Name = "FeedPetProxPart";
    u5.CanCollide = false;
    u5.CanQuery = false;
    u5.Anchored = true;
    u5.Transparency = 1;
    u5.Parent = workspace;
    u6 = Instance.new("ProximityPrompt");
    u6.Name = "FEED_PET_PROX";
    u6.Exclusivity = Enum.ProximityPromptExclusivity.AlwaysShow;
    u6.KeyboardKeyCode = Enum.KeyCode.F;
    u6.RequiresLineOfSight = false;
    u6.HoldDuration = 0.5;
    u6.MaxActivationDistance = (1 / 0);
    u6.Parent = u5;
    u6.Style = Enum.ProximityPromptStyle.Custom;
    u6:SetAttribute("Theme", "ShadowedPrompt");
    u6.Triggered:Connect(function() -- Line: 52
        -- upvalues: u2 (ref), ActivePetsService (ref)
        if not u2 then
            return;
        end;

        ActivePetsService:Feed(u2);
    end);
end;

local function ResetProximityPrompt() -- Line: 61
    -- upvalues: u6 (ref), u4 (ref), u5 (ref)
    u6.Enabled = false;

    if u4 and u4.PlaybackState == Enum.PlaybackState.Playing then
        u4.Completed:Wait();
    end;

    u5.CFrame = CFrame.new(100, 5000, 100);
end;

local function GetClosestPetModel() -- Line: 70
    -- upvalues: ActivePetsService (copy), LocalPlayer (copy), u1 (copy), MINIMUM_DISTANCE_FOR_FEEDING (copy)
    local v7 = (1 / 0);
    local v8 = nil;
    local v9 = nil;

    for i, v in ActivePetsService:GetClientPetState(LocalPlayer.Name) do
        local Asset = v.Asset;

        if Asset then
            local v10 = Asset:FindFirstChildWhichIsA("Model", true);

            if v10 then
                local Magnitude = (v10:GetPivot().Position - u1:GetPivot().Position).Magnitude;

                if v7 > Magnitude and MINIMUM_DISTANCE_FOR_FEEDING > Magnitude then
                    v9 = i;
                    v8 = v10;
                    v7 = Magnitude;
                end;
            end;
        end;
    end;

    for i, v in ActivePetsService.ClientServerPetState do
        local Asset = v.Asset;

        if Asset then
            local v11 = Asset:FindFirstChildWhichIsA("Model", true);

            if v11 then
                local Magnitude = (v11:GetPivot().Position - u1:GetPivot().Position).Magnitude;

                if v7 > Magnitude and MINIMUM_DISTANCE_FOR_FEEDING > Magnitude then
                    v9 = i;
                    v8 = v11;
                    v7 = Magnitude;
                end;
            end;
        end;
    end;

    return v9, v8;
end;

local function CurrentToolMatchID(p12: string) -- Line: 111
    -- upvalues: u1 (copy), InventoryServiceEnums (copy)
    local v13 = u1:FindFirstChildWhichIsA("Tool");

    if v13 then
        return v13:GetAttribute(InventoryServiceEnums.ITEM_UUID) == p12;
    end;

    return false;
end;

local function OnToolEquip(p14: userdata, p15: string) -- Line: 126
    -- upvalues: u1 (copy), InventoryServiceEnums (copy), GetClosestPetModel (copy), u6 (ref), u4 (ref), u5 (ref), ActivePetsService (copy), LocalPlayer (copy), u2 (ref), PetUtilities (copy), ReplicatedStorage (copy), FoodService (copy), TweenService (copy), TweenInfo_new_ret (copy), DecimalNumberFormat (copy)
    while true do
        while true do
            local v16 = u1:FindFirstChildWhichIsA("Tool");
            local v17;

            if v16 then
                v17 = v16:GetAttribute(InventoryServiceEnums.ITEM_UUID) == p15;
            else
                v17 = false;
            end;

            if not v17 then
                u6.Enabled = false;

                if u4 and u4.PlaybackState == Enum.PlaybackState.Playing then
                    u4.Completed:Wait();
                end;

                u5.CFrame = CFrame.new(100, 5000, 100);

                return;
            end;

            task.wait(0.05);
            local v18, v19 = GetClosestPetModel();

            if not v19 then
                break;
            end;

            local v20 = ActivePetsService.ClientServerPetState[v18] ~= nil;
            local v21, v22, v23, v24;

            if v20 then
                local ServerPetData = ActivePetsService:GetServerPetData(v18);

                if ServerPetData then
                    v21 = ServerPetData.PetType;
                    u2 = v18;
                    v22 = 0;

                    if p14:HasTag("FruitTool") then
                        ActivePetsService:GetPetDataFromPetObject(v19.Parent);
                        v22 = PetUtilities:GetFruitWorthPercentageForAnimal(v21, p14) * 100;
                    elseif p14:HasTag("FoodTool") then
                        v23 = p14:GetAttribute(InventoryServiceEnums.ITEM_UUID);
                        v24 = require(ReplicatedStorage.Modules.DataService):GetData().InventoryData[v23];

                        if v24 then
                            v22 = FoodService:CalculateFoodValue(v23, v24);
                        end;
                    end;

                    u4 = TweenService:Create(u5, TweenInfo_new_ret, {
                        CFrame = v19:GetPivot()
                    });
                    u4:Play();
                    u6.ObjectText = v21;

                    if v20 then
                        u6.ActionText = "FEED!";
                    else
                        u6.ActionText = `Feed ({DecimalNumberFormat(v22)}%) {p14.Name}`;
                    end;

                    u6.Enabled = true;
                else
                    u6.Enabled = false;

                    if u4 and u4.PlaybackState == Enum.PlaybackState.Playing then
                        u4.Completed:Wait();
                    end;

                    u5.CFrame = CFrame.new(100, 5000, 100);
                end;
            else
                local PetData = ActivePetsService:GetPetData(LocalPlayer.Name, v18);

                if PetData then
                    v21 = PetData.PetType;
                    u2 = v18;
                    v22 = 0;

                    if p14:HasTag("FruitTool") then
                        ActivePetsService:GetPetDataFromPetObject(v19.Parent);
                        v22 = PetUtilities:GetFruitWorthPercentageForAnimal(v21, p14) * 100;
                    elseif p14:HasTag("FoodTool") then
                        v23 = p14:GetAttribute(InventoryServiceEnums.ITEM_UUID);
                        v24 = require(ReplicatedStorage.Modules.DataService):GetData().InventoryData[v23];

                        if v24 then
                            v22 = FoodService:CalculateFoodValue(v23, v24);
                        end;
                    end;

                    u4 = TweenService:Create(u5, TweenInfo_new_ret, {
                        CFrame = v19:GetPivot()
                    });
                    u4:Play();
                    u6.ObjectText = v21;

                    if v20 then
                        u6.ActionText = "FEED!";
                    else
                        u6.ActionText = `Feed ({DecimalNumberFormat(v22)}%) {p14.Name}`;
                    end;

                    u6.Enabled = true;
                end;

                u6.Enabled = false;

                if u4 and u4.PlaybackState == Enum.PlaybackState.Playing then
                    u4.Completed:Wait();
                end;

                u5.CFrame = CFrame.new(100, 5000, 100);
            end;
        end;

        u6.Enabled = false;

        if u4 and u4.PlaybackState == Enum.PlaybackState.Playing then
            u4.Completed:Wait();
        end;

        u5.CFrame = CFrame.new(100, 5000, 100);
    end;
end;

local function WatchForToolEquip(p25: userdata) -- Line: 204
    -- upvalues: u6 (ref), u4 (ref), u5 (ref), InventoryServiceEnums (copy), u3 (copy), OnToolEquip (copy)
    local function preConnections(u26: userdata) -- Line: 205
        -- upvalues: u6 (ref), u4 (ref), u5 (ref), InventoryServiceEnums (ref), u3 (ref), OnToolEquip (ref)
        if not (u26:HasTag("FruitTool") or u26:HasTag("FoodTool")) then
            u6.Enabled = false;

            if u4 and u4.PlaybackState == Enum.PlaybackState.Playing then
                u4.Completed:Wait();
            end;

            u5.CFrame = CFrame.new(100, 5000, 100);

            return;
        end;

        local Attribute = u26:GetAttribute(InventoryServiceEnums.ITEM_UUID);

        if u3[Attribute] then
            return;
        end;

        local u27 = u26.Equipped:Connect(function() -- Line: 218
            -- upvalues: OnToolEquip (ref), u26 (copy), Attribute (copy)
            task.spawn(OnToolEquip, u26, Attribute);
        end);
        local u28 = u26.Unequipped:Connect(function() -- Line: 223
            -- upvalues: u6 (ref), u4 (ref), u5 (ref)
            u6.Enabled = false;

            if u4 and u4.PlaybackState == Enum.PlaybackState.Playing then
                u4.Completed:Wait();
            end;

            u5.CFrame = CFrame.new(100, 5000, 100);
        end);
        u3[Attribute] = { u27, u28 };
        u26.Destroying:Once(function() -- Line: 232
            -- upvalues: u3 (ref), Attribute (copy), u27 (ref), u28 (ref), u6 (ref), u4 (ref), u5 (ref)
            u3[Attribute] = nil;
            u27:Disconnect();
            u28:Disconnect();
            u6.Enabled = false;

            if u4 and u4.PlaybackState == Enum.PlaybackState.Playing then
                u4.Completed:Wait();
            end;

            u5.CFrame = CFrame.new(100, 5000, 100);
        end);
    end;

    for _, child in p25:GetChildren() do
        if child:IsA("Tool") then
            preConnections(child);
        end;
    end;

    p25.ChildAdded:Connect(function(p29) -- Line: 248
        -- upvalues: preConnections (copy)
        if p29:IsA("Tool") then
            preConnections(p29);
        end;
    end);
end;

task.spawn(function() -- Line: 255
    -- upvalues: SetUpProxPrompt (copy), u6 (ref), u4 (ref), u5 (ref), WatchForToolEquip (copy), u1 (copy)
    SetUpProxPrompt();
    u6.Enabled = false;

    if u4 and u4.PlaybackState == Enum.PlaybackState.Playing then
        u4.Completed:Wait();
    end;

    u5.CFrame = CFrame.new(100, 5000, 100);
    WatchForToolEquip(u1);
end);

return {};