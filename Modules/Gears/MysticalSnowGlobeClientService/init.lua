-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local MysticalSnowGlobeConfigData = require(game.ReplicatedStorage.Data.Gears.MysticalSnowGlobeConfigData);
local CreateTagHandler = require(game.ReplicatedStorage.Modules.CreateTagHandler);
local DataService = require(game.ReplicatedStorage.Modules.DataService);
local NumberUtil = require(game.ReplicatedStorage.Modules.NumberUtil);
require(game.ReplicatedStorage.Comma_Module);
local script_ProxAtt = script.ProxAtt;
local TryUsePlaceableGear = game.ReplicatedStorage.GameEvents.TryUsePlaceableGear;
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = {};

local function Cleanup(p3: userdata) -- Line: 23
    -- upvalues: u1 (copy), u2 (copy)
    if u1[p3] then
        u1[p3]:Disconnect();
        u1[p3] = nil;
    end;

    if u2[p3] then
        u2[p3]:Destroy();
        u2[p3] = nil;
    end;
end;

local function UpdateProximityPromptText() -- Line: 35
    -- upvalues: DataService (copy), u2 (copy), MysticalSnowGlobeConfigData (copy), NumberUtil (copy)
    local TimesUsed = DataService:GetData().GearUseData.SnowGlobe.TimesUsed;

    for _, v in u2 do
        local v4 = v:FindFirstChildWhichIsA("ProximityPrompt");

        if v4 then
            local v5;

            if TimesUsed > 0 then
                local Cost = MysticalSnowGlobeConfigData:GetCost(TimesUsed);
                v5 = `{NumberUtil.DisplaySheckles(Cost)}`;
            else
                v5 = "FREE";
            end;

            v4.ActionText = v5;
        end;
    end;
end;

CreateTagHandler({
    Tag = "MysticalSnowGlobeObject",

    OnInstanceAdded = function(u6: userdata) -- Line: 56, Name: OnInstanceAdded
        -- upvalues: u1 (copy), u2 (copy), Players (copy), LocalPlayer (copy), script_ProxAtt (copy), TryUsePlaceableGear (copy), UpdateProximityPromptText (copy)
        if u1[u6] then
            u1[u6]:Disconnect();
            u1[u6] = nil;
        end;

        if u2[u6] then
            u2[u6]:Destroy();
            u2[u6] = nil;
        end;

        task.defer(function() -- Line: 60
            -- upvalues: u6 (copy), Players (ref), LocalPlayer (ref), script_ProxAtt (ref), u2 (ref), u1 (ref), TryUsePlaceableGear (ref), UpdateProximityPromptText (ref)
            local Attribute = u6:GetAttribute("OWNER");

            if not Attribute then
                return;
            end;

            local v7 = Players:FindFirstChild(Attribute);

            if not v7 then
                return;
            end;

            if LocalPlayer ~= v7 then
                return;
            end;

            local v8 = script_ProxAtt:Clone();
            v8.Parent = u6:FindFirstChild("Orb") or u6.PrimaryPart;
            u2[u6] = v8;
            u1[u6] = v8:FindFirstChild("ProximityPrompt").Triggered:Connect(function(p9: userdata) -- Line: 77
                -- upvalues: LocalPlayer (ref), TryUsePlaceableGear (ref), u6 (ref)
                if p9 ~= LocalPlayer then
                    return;
                end;

                TryUsePlaceableGear:FireServer(u6);
            end);
            UpdateProximityPromptText();
        end);
    end,

    OnInstanceRemoved = function(p10: userdata) -- Line: 87, Name: OnInstanceRemoved
        -- upvalues: u1 (copy), u2 (copy)
        if u1[p10] then
            u1[p10]:Disconnect();
            u1[p10] = nil;
        end;

        if u2[p10] then
            u2[p10]:Destroy();
            u2[p10] = nil;
        end;
    end
});
DataService:GetPathSignal("GearUseData/SnowGlobe/@"):Connect(UpdateProximityPromptText);

return {};