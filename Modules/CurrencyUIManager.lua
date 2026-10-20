-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SaveSlotController = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);
require(ReplicatedStorage.Modules.UpdateService);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local LocalPlayer = Players.LocalPlayer;
assert(LocalPlayer, "LocalPlayer not found");
local CurrencyUI = LocalPlayer.PlayerGui:WaitForChild("CurrencyUI");
local v1 = {};

local function GetTaggedParts(p2: string) -- Line: 21
    -- upvalues: CollectionService (copy)
    local v3 = {};

    for _, v in CollectionService:GetTagged(p2) do
        if v:IsA("BasePart") and v:IsDescendantOf(workspace) then
            table.insert(v3, v);
        end;
    end;

    return v3;
end;

local function IsPointInsidePart(p4: userdata, p5: vector) -- Line: 32
    local v6 = p4.CFrame:PointToObjectSpace(p5);
    local v7 = p4.Size * 0.5;
    local v8;

    if math.abs(v6.X) <= v7.X then
        v8 = math.abs(v6.Z) <= v7.Z;
    else
        v8 = false;
    end;

    return v8;
end;

local function IsPlayerInBounds(p9: string) -- Line: 40
    -- upvalues: LocalPlayer (copy), GetTaggedParts (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return false;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and HumanoidRootPart:IsA("BasePart")) then
        return false;
    end;

    local v10 = GetTaggedParts(p9);

    if #v10 <= 0 then
        return false;
    end;

    for _, v in v10 do
        local v11 = v.CFrame:PointToObjectSpace(HumanoidRootPart.Position);
        local v12 = v.Size * 0.5;
        local v13;

        if math.abs(v11.X) <= v12.X then
            v13 = math.abs(v11.Z) <= v12.Z;
        else
            v13 = false;
        end;

        if v13 then
            return true;
        end;
    end;

    return false;
end;

local function IsVisible(p14: string, p15: string?, p16: string?, p17: function?) -- Line: 59
    -- upvalues: LocalPlayer (copy), TradeWorldController (copy), IsPlayerInBounds (copy), EventRotationController (copy)
    if LocalPlayer:GetAttribute("UpdatingCurrency") == p14 then
        return true;
    end;

    if TradeWorldController:IsInWorld() then
        return false;
    end;

    if p15 and not IsPlayerInBounds(p15) then
        return false;
    end;

    if p16 then
        local LoadedEvent = EventRotationController:GetLoadedEvent();

        if not LoadedEvent then
            return false;
        end;

        if LoadedEvent.EventSet ~= p16 then
            return false;
        end;
    end;

    return not p17 and true or p17();
end;

function v1.GetCurrencyUI(p18: table, p19: string) -- Line: 84
    -- upvalues: CurrencyUI (copy)
    return CurrencyUI.CurrencyHolder:FindFirstChild(p19);
end;

function v1.Start(p20) -- Line: 88
    -- upvalues: CurrencyUI (copy), LocalPlayer (copy), Players (copy), IsPlayerInBounds (copy), TradeWorldController (copy), DataService (copy), SaveSlotController (copy), EventRotationController (copy)
    task.spawn(function() -- Line: 89
        -- upvalues: CurrencyUI (ref), LocalPlayer (ref), Players (ref), IsPlayerInBounds (ref), TradeWorldController (ref), DataService (ref), SaveSlotController (ref), EventRotationController (ref)
        local CurrencyHolder = CurrencyUI.CurrencyHolder;

        for _, child in CurrencyHolder:GetChildren() do
            if child:IsA("Frame") and (child.Name ~= "FriendBoost" and child.Name ~= "TradeTokens") then
                child.Visible = false;
            end;
        end;

        CurrencyUI.Enabled = true;

        while LocalPlayer:IsDescendantOf(Players) do
            task.wait(0.1);
            local u21 = IsPlayerInBounds("ShecklesCurrencyPart");
            local u22 = IsPlayerInBounds("GardenCoinCurrencyPart");
            local Sheckles = CurrencyHolder.Sheckles;

            local function v23() -- Line: 108
                -- upvalues: CurrencyHolder (copy)
                return not (CurrencyHolder.HoneyCoins.Visible or CurrencyHolder.ChocCoins.Visible);
            end;

            local v24;

            if LocalPlayer:GetAttribute("UpdatingCurrency") == "Sheckles" then
                v24 = true;
            elseif TradeWorldController:IsInWorld() then
                v24 = false;
            elseif v23 then
                v24 = not (CurrencyHolder.HoneyCoins.Visible or CurrencyHolder.ChocCoins.Visible);
            else
                v24 = true;
            end;

            Sheckles.Visible = v24;
            local GardenCoins = CurrencyHolder.GardenCoins;

            local function v25() -- Line: 112
                -- upvalues: DataService (ref), u22 (copy)
                return u22 and DataService:GetData().GardenCoinShopStats.UnlockedGardenCoins;
            end;

            local v26;

            if LocalPlayer:GetAttribute("UpdatingCurrency") == "GardenCoins" then
                v26 = true;
            elseif TradeWorldController:IsInWorld() or not IsPlayerInBounds("GardenCoinCurrencyPart") then
                v26 = false;
            else
                v26 = not v25 and true or u22 and DataService:GetData().GardenCoinShopStats.UnlockedGardenCoins;
            end;

            GardenCoins.Visible = v26;
            local HoneyCoins = CurrencyHolder.HoneyCoins;

            local function v30() -- Line: 117
                -- upvalues: IsPlayerInBounds (ref), SaveSlotController (ref), u22 (copy)
                local v27 = IsPlayerInBounds("BeeEventBounds") or IsPlayerInBounds("BeeEventSpecialCurrencyZone");
                local v28 = SaveSlotController:GetCurrentSaveSlot().IsBeeSlot or false;
                local v29 = not u22;

                if v29 then
                    if not v28 then
                        v27 = v28;
                    end;
                else
                    v27 = v29;
                end;

                return v27;
            end;

            local v31;

            if LocalPlayer:GetAttribute("UpdatingCurrency") == "HoneyCoins" then
                v31 = true;
            elseif TradeWorldController:IsInWorld() then
                v31 = false;
            elseif v30 then
                v31 = IsPlayerInBounds("BeeEventBounds") or IsPlayerInBounds("BeeEventSpecialCurrencyZone");
                local v32 = SaveSlotController:GetCurrentSaveSlot().IsBeeSlot or false;
                local v33 = not u22;

                if v33 then
                    if not v32 then
                        v31 = v32;
                    end;
                else
                    v31 = v33;
                end;
            else
                v31 = true;
            end;

            HoneyCoins.Visible = v31;
            CurrencyHolder.RoyalJelly.Visible = CurrencyHolder.HoneyCoins.Visible;
            local ChocCoins = CurrencyHolder.ChocCoins;

            local function v35() -- Line: 124
                -- upvalues: SaveSlotController (ref), u21 (copy), CurrencyHolder (copy)
                local v34 = (SaveSlotController:GetCurrentSaveSlot().IsEasterSlot or false) and not u21 and not CurrencyHolder.HoneyCoins.Visible;

                return v34;
            end;

            local v36;

            if LocalPlayer:GetAttribute("UpdatingCurrency") == "ChocCoins" then
                v36 = true;
            elseif TradeWorldController:IsInWorld() or not IsPlayerInBounds("EasterEventBounds") then
                v36 = false;
            elseif v35 then
                v36 = (SaveSlotController:GetCurrentSaveSlot().IsEasterSlot or false) and not u21 and not CurrencyHolder.HoneyCoins.Visible;
            else
                v36 = true;
            end;

            ChocCoins.Visible = v36;
            local TideTokens = CurrencyHolder.TideTokens;
            local v37;

            if LocalPlayer:GetAttribute("UpdatingCurrency") == "TideTokens" then
                v37 = true;
            elseif TradeWorldController:IsInWorld() then
                v37 = false;
            else
                local LoadedEvent = EventRotationController:GetLoadedEvent();

                if LoadedEvent then
                    v37 = LoadedEvent.EventSet == "Summer2026Event";
                else
                    v37 = false;
                end;
            end;

            TideTokens.Visible = v37;
            local MoonCoins = CurrencyHolder.MoonCoins;
            local v38;

            if LocalPlayer:GetAttribute("UpdatingCurrency") == "MoonCoins" then
                v38 = true;
            elseif TradeWorldController:IsInWorld() then
                v38 = false;
            else
                local LoadedEvent = EventRotationController:GetLoadedEvent();

                if LoadedEvent then
                    v38 = LoadedEvent.EventSet == "HarvestMoonEvent";
                else
                    v38 = false;
                end;
            end;

            MoonCoins.Visible = v38;
            local Chi = CurrencyHolder.Chi;
            local v39;

            if LocalPlayer:GetAttribute("UpdatingCurrency") == "Chi" then
                v39 = true;
            elseif TradeWorldController:IsInWorld() then
                v39 = false;
            else
                local LoadedEvent = EventRotationController:GetLoadedEvent();

                if LoadedEvent then
                    v39 = LoadedEvent.EventSet == "ZenEvent";
                else
                    v39 = false;
                end;
            end;

            Chi.Visible = v39;
            local Fairy = CurrencyHolder.Fairy;
            local v40;

            if LocalPlayer:GetAttribute("UpdatingCurrency") == "FairyPoints" then
                v40 = true;
            elseif TradeWorldController:IsInWorld() or not IsPlayerInBounds("FairyPointsUIOverlap") then
                v40 = false;
            else
                local LoadedEvent = EventRotationController:GetLoadedEvent();

                if LoadedEvent then
                    v40 = LoadedEvent.EventSet == "FairyEvent";
                else
                    v40 = false;
                end;
            end;

            Fairy.Visible = v40;
            CurrencyHolder.CandyCorn.Visible = EventRotationController:IsInEvent("Halloween2026Event");
        end;
    end);
end;

task.spawn(v1.Start, v1);

return v1;