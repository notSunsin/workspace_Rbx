-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local RebirthUnlocksSharedService = require(ReplicatedStorage.Modules.RebirthUnlocksSharedService);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local UseDynamicPrices = require(ReplicatedStorage.Modules.UseDynamicPrices);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local GetFarmAsync = require(ReplicatedStorage.Modules.GetFarmAsync);
local DataService = require(ReplicatedStorage.Modules.DataService);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.Observers);
local Expansions = require(ReplicatedStorage.Data.Expansions);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local Trove = require(ReplicatedStorage.Modules.Trove);
local u5 = {
    GetNextExpansions = function(p1) -- Line: 22, Name: GetNextExpansions
        -- upvalues: DataService (copy), UpdateService (copy), Expansions (copy)
        local Data = DataService:GetData();

        if not Data then
            return {};
        end;

        if UpdateService:IsHiddenFromUpdate("Expansions") then
            return {};
        end;

        local Unlocked = Data.ExpansionsData.Unlocked;
        local v2 = {};

        for i, v in Expansions do
            if not table.find(Unlocked, i) then
                local Requires = v.Requires;
                local v3 = true;
                local v4;

                if Requires then
                    v4 = i;

                    for _, v5 in Requires do
                        if not table.find(Unlocked, v5) then
                            v3 = false;
                            break;
                        end;
                    end;
                else
                    v4 = i;
                end;

                if v3 then
                    table.insert(v2, v4);
                end;
            end;
        end;

        return v2;
    end
};

function u5.Start(p6) -- Line: 59
    -- upvalues: GetFarmAsync (copy), LocalPlayer (copy), DataService (copy), UpdateService (copy), u5 (copy), Expansions (copy), ReplicatedStorage (copy), Trove (copy), MarketController (copy), NumberUtil (copy), UseDynamicPrices (copy), Comma_Module (copy), RebirthUnlocksSharedService (copy)
    local u7 = GetFarmAsync(LocalPlayer);

    if not u7 then
        return;
    end;

    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local function IsEventSlot() -- Line: 70
        -- upvalues: Data (copy)
        local v8 = Data.SaveSlots.AllSlots[Data.SaveSlots and Data.SaveSlots.SelectedSlot];

        return v8 and (v8.IsEasterSlot or (v8.IsBeeSlot or v8.IsHalloweenSlot)) and true or false;
    end;

    local u9 = {};

    local function updateSigns() -- Line: 87
        -- upvalues: Data (copy), UpdateService (ref), u7 (copy), u5 (ref), u9 (copy), Expansions (ref), ReplicatedStorage (ref), Trove (ref), MarketController (ref), NumberUtil (ref), UseDynamicPrices (ref), Comma_Module (ref), RebirthUnlocksSharedService (ref), LocalPlayer (ref)
        if not Data.ExpansionsData.CanSeeExpansions then
            return;
        end;

        if UpdateService:IsHiddenFromUpdate("Expansions") then
            return;
        end;

        local Pivot = u7.Center_Point:GetPivot();
        local NextExpansions = u5:GetNextExpansions();
        local v10 = Data.SaveSlots.AllSlots[Data.SaveSlots and Data.SaveSlots.SelectedSlot];

        if v10 and (v10.IsEasterSlot or (v10.IsBeeSlot or v10.IsHalloweenSlot)) and true or false then
            for i, v in u9 do
                v.Trove:Destroy();
                u9[i] = nil;
            end;

            return;
        end;

        for i, v in table.clone(u9) do
            if not table.find(NextExpansions, i) then
                v.Trove:Destroy();
                u9[i] = nil;
            end;
        end;

        for _, v in NextExpansions do
            if not u9[v] then
                local u11 = Expansions[v];
                local v12 = ReplicatedStorage.Assets.Expansions.Models:FindFirstChild((tostring(v)));
                local v13;

                if v12 then
                    v13 = v12:FindFirstChild("Expand");
                else
                    v13 = v12;
                end;

                if v13 then
                    local v14 = v12:GetPivot():ToObjectSpace(v13:GetPivot());
                    local v15 = Trove.new();
                    local u16 = v15:Clone(ReplicatedStorage.Assets.Expansions.ExpandSign);
                    u9[v] = {
                        Model = u16,
                        Trove = v15
                    };
                    u16.Name = "ExpansionSign";
                    u16:PivotTo(Pivot:ToWorldSpace(v14));
                    u16.Parent = u7;
                    v15:Add(u16.ProximityPrompt.Triggered:Connect(function(p17) -- Line: 145
                        -- upvalues: u11 (copy), Data (ref), v (copy), ReplicatedStorage (ref)
                        if u11.Timer then
                            local v18 = nil;

                            for _, v2 in Data.ExpansionsData.ExpansionTimers do
                                if v2.Expansion == v then
                                    v18 = v2;
                                end;
                            end;

                            if v18 and workspace:GetServerTimeNow() < v18.Timer then
                                ReplicatedStorage.GameEvents.Expansions.SkipTimer:FireServer(v);

                                return;
                            end;
                        end;

                        ReplicatedStorage.GameEvents.Expansions.Expand:FireServer(v);
                    end));
                    local u19 = true;
                    v15:Add(function() -- Line: 165
                        -- upvalues: u19 (ref)
                        u19 = false;
                    end);
                    local u20 = nil;
                    local TextLabel = u16.SurfaceGui.TextLabel;
                    v15:Add(task.spawn(function() -- Line: 172
                        -- upvalues: u19 (ref), Data (ref), v (copy), u20 (ref), TextLabel (copy), u16 (copy), MarketController (ref), u11 (copy), NumberUtil (ref), UseDynamicPrices (ref), Comma_Module (ref), RebirthUnlocksSharedService (ref), LocalPlayer (ref)
                        while u19 do
                            local v21 = nil;

                            for _, v2 in Data.ExpansionsData.ExpansionTimers do
                                if v2.Expansion == v then
                                    v21 = v2;
                                end;
                            end;

                            local v22 = (v21 and v21.Timer or 0) - workspace:GetServerTimeNow();

                            if v22 <= 0 then
                                if u20 ~= true then
                                    u20 = true;
                                    TextLabel.Text = "Expand Garden";
                                    u16.ProximityPrompt.ActionText = "Expand";
                                    MarketController:RemovePriceLabel(u16.ProximityPrompt);

                                    if u11.Price then
                                        u16.ProximityPrompt.ObjectText = NumberUtil.DisplaySheckles(u11.Price);
                                    elseif u11.ProductId then
                                        if UseDynamicPrices or u11.ProductFallbackPrice == nil then
                                            if not UseDynamicPrices then
                                                warn((`{u16.ProximityPrompt:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                                            end;

                                            MarketController:SetPriceLabel(u16.ProximityPrompt, u11.ProductId, ":robux::value:");
                                        else
                                            u16.ProximityPrompt.ObjectText = `{utf8.char(57346)}{Comma_Module.Comma(u11.ProductFallbackPrice)}`;
                                        end;
                                    end;
                                end;
                            elseif v22 > 0 then
                                if u20 ~= false then
                                    u20 = false;
                                    u16.ProximityPrompt.ActionText = "Skip Timer";
                                    MarketController:RemovePriceLabel(u16.ProximityPrompt);

                                    if u11.TimerProductId then
                                        if UseDynamicPrices or u11.TimerFallbackPrice == nil then
                                            if not UseDynamicPrices then
                                                warn((`{u16.ProximityPrompt:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                                            end;

                                            MarketController:SetPriceLabel(u16.ProximityPrompt, u11.TimerProductId, ":robux::value:");
                                        else
                                            u16.ProximityPrompt.ObjectText = `{utf8.char(57346)}{Comma_Module.Comma(u11.TimerFallbackPrice)}`;
                                        end;
                                    elseif u11.Price then
                                        u16.ProximityPrompt.ObjectText = "";
                                    end;
                                end;

                                TextLabel.Text = `Expand in\n{NumberUtil.compactFormat(v22)}`;
                            end;

                            local LockedFrame = u16.SurfaceGui.LockedFrame;
                            local UnlockInfo = LockedFrame.UnlockInfo;
                            local v23 = `GARDEN_SIZE_EXPANSION_{v}`;

                            if RebirthUnlocksSharedService:HasUnlockedFeature(LocalPlayer, v23) then
                                u16.ProximityPrompt.Enabled = true;
                                LockedFrame.Visible = false;
                            else
                                u16.ProximityPrompt.Enabled = false;
                                LockedFrame.Visible = true;
                                UnlockInfo.Text = `Ascensions Required: {RebirthUnlocksSharedService:GetRemainingRebirthsNeededForFeature(LocalPlayer, v23)}`;
                            end;

                            task.wait(1);
                        end;
                    end));
                end;
            end;
        end;
    end;

    xpcall(updateSigns, warn);
    assert(DataService:GetPathSignal("ExpansionsData/@")):Connect(updateSigns);
    assert(DataService:GetPathSignal("SaveSlots/SelectedSlot")):Connect(updateSigns);
    task.spawn(function() -- Line: 256
        -- upvalues: UpdateService (ref), updateSigns (copy)
        while UpdateService:IsHiddenFromUpdate("Expansions") do
            task.wait(1);
        end;

        updateSigns();
    end);
end;

task.spawn(u5.Start, u5);

return u5;