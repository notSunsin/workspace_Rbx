-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TeleportService = game:GetService("TeleportService");
require(ReplicatedStorage.Data.EnumRegistry.ReversedItemTypeEnums);
require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local TradeBoothListingController = require(ReplicatedStorage.Modules.TradeBoothControllers.TradeBoothListingController);
require(ReplicatedStorage.Modules.TradeBoothControllers.TradeBoothBuyItemController);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local GGStaticData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
local TeleportUIController = require(ReplicatedStorage.Modules.TeleportUIController);
local ReplicationReciever = require(ReplicatedStorage.Modules.ReplicationReciever);
local ItemRarityFinder = require(ReplicatedStorage.Modules.ItemRarityFinder);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local TradeBoothsData = require(ReplicatedStorage.Data.TradeBoothsData);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.Notification);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local Observers = require(ReplicatedStorage.Modules.Observers);
require(ReplicatedStorage.Data.TradeData);
require(ReplicatedStorage.Modules.Signal);
local Trove = require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.InventoryService);
require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
require(ReplicatedStorage.Modules.MutationHandler);
local SelectiveAssetReplication = require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local TradeBoothSkinUIController = require(ReplicatedStorage.Modules.TradeBoothControllers.TradeBoothSkinUIController);
local TradeBoothSkinRegistry = require(ReplicatedStorage.Data.TradeBoothSkinRegistry);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
require(ReplicatedStorage.Modules.TradeTokens.TokenRAPUtil);
local _ = PetRegistry.PetList;
local LocalPlayer = Players.LocalPlayer;
local TradeEvents = ReplicatedStorage.GameEvents.TradeEvents;
local RemoveBooth = ReplicatedStorage.GameEvents.TradeEvents.Booths.RemoveBooth;
local u1 = {};
local Booths = ReplicationReciever.new("Booths");
local u2 = {};
local u3 = {};
local u4 = {};
local v5 = {};
local u6 = nil;
local u7 = false;
local u8 = { {
        distanceRatio = 0.25,
        updateRate = 60
    }, {
        distanceRatio = 0.5,
        updateRate = 30
    }, {
        distanceRatio = 0.8,
        updateRate = 20
    }, {
        distanceRatio = 1,
        updateRate = 15
    } };
local u9 = {};
local u10 = nil;

local function EaseInOutQuad(p11: number) -- Line: 95
    if p11 < 0.5 then
        return p11 * 2 * p11;
    end;

    local v12 = 1 - p11;

    return 1 - v12 * 2 * v12;
end;

local function BuildPadCache(p13) -- Line: 104
    local v14 = {};

    for _, descendant in p13:GetDescendants() do
        if descendant:HasTag("TradePad") then
            local Attribute = descendant:GetAttribute("Index");

            if type(Attribute) == "string" then
                Attribute = tonumber(Attribute);
            end;

            if Attribute then
                v14[Attribute] = descendant;
            end;
        end;
    end;

    return v14;
end;

local function GetCachedPad(p15: any, p16: number) -- Line: 120
    -- upvalues: u4 (copy), BuildPadCache (copy)
    local v17 = u4[p15];

    if not v17 then
        v17 = BuildPadCache(p15);
        u4[p15] = v17;
    end;

    return v17[p16];
end;

local function ClearPadCache(p18) -- Line: 129
    -- upvalues: u4 (copy)
    u4[p18] = nil;
end;

local function StartFloatingHeartbeat() -- Line: 134
    -- upvalues: u10 (ref), RunService (copy), u9 (copy), u4 (copy), BuildPadCache (copy), u8 (copy)
    if u10 then
        return;
    end;

    u10 = RunService.Heartbeat:Connect(function(p19: number) -- Line: 139
        -- upvalues: u9 (ref), u4 (ref), BuildPadCache (ref), u8 (ref), u10 (ref)
        local v20 = tick();

        for i = #u9, 1, -1 do
            local v21 = u9[i];
            local v22;

            if v21.ItemModel and v21.ItemModel.Parent ~= nil then
                if v20 - v21.LastDistanceCheckTime > 0.25 then
                    v21.LastDistanceCheckTime = v20;
                    local workspace_CurrentCamera = workspace.CurrentCamera;
                    local v23 = false;
                    local v24 = 0;

                    if workspace_CurrentCamera then
                        local BoothInstance = v21.BoothInstance;
                        local PadIndex = v21.PadIndex;
                        local v25 = u4[BoothInstance];

                        if not v25 then
                            v25 = BuildPadCache(BoothInstance);
                            u4[BoothInstance] = v25;
                        end;

                        local v26 = v25[PadIndex];

                        if v26 then
                            local Position = v26:GetPivot().Position;
                            local Magnitude = (workspace_CurrentCamera.CFrame.Position - Position).Magnitude;
                            v23 = Magnitude <= 55;
                            local v27 = Magnitude / 55;
                            v22 = i;

                            for i2, v in ipairs(u8) do
                                if v27 <= v.distanceRatio then
                                    v24 = i2 - 1;
                                    break;
                                end;
                            end;
                        else
                            v22 = i;
                        end;
                    else
                        v22 = i;
                    end;

                    v21.IsNear = v23;
                    v21.DistanceTier = v24;
                else
                    v22 = i;
                end;

                if v21.IsNear then
                    local v28 = (v21.DistanceTier <= 0 or v21.DistanceTier > #u8) and 0 or 1 / u8[v21.DistanceTier + 1].updateRate;
                    local math_min_ret = math.min(v20 - v21.LastUpdateTime, 0.1);

                    if v28 <= 0 or math_min_ret >= v28 then
                        v21.LastUpdateTime = v20;
                        v21.Phase = v21.Phase + 0.6 * math_min_ret;
                        v21.Phase = v21.Phase % 1;
                        local v29;

                        if v21.Phase < 0.5 then
                            v29 = v21.Phase * 2;
                        else
                            v29 = (1 - v21.Phase) * 2;
                        end;

                        local v30;

                        if v29 < 0.5 then
                            v30 = v29 * 2 * v29;
                        else
                            local v31 = 1 - v29;
                            v30 = 1 - v31 * 2 * v31;
                        end;

                        local v32 = v21.BaseCenterPos + Vector3.new(0, v30 * 0.4, 0);
                        v21.SpinX = v21.SpinX + 0.17453292519943295 * math_min_ret;
                        v21.SpinY = v21.SpinY + 0.4363323129985824 * math_min_ret;
                        v21.SpinZ = v21.SpinZ + 0.2617993877991494 * math_min_ret;
                        local CFrame_Angles_ret = CFrame.Angles(v21.SpinX, v21.SpinY, v21.SpinZ);
                        local v33 = CFrame.new(v32) * v21.RotationOnly * CFrame_Angles_ret;
                        v21.ItemModel:PivotTo(v33);
                    end;
                end;
            else
                table.remove(u9, i);
                v22 = i;
            end;
        end;

        if #u9 == 0 and u10 then
            u10:Disconnect();
            u10 = nil;
        end;
    end);
end;

local function RemoveFromFloatingItems(p34: userdata) -- Line: 228
    -- upvalues: u9 (copy)
    for i = #u9, 1, -1 do
        local v35;

        if u9[i].ItemModel == p34 then
            table.remove(u9, i);
            v35 = i;
        else
            v35 = i;
        end;
    end;
end;

local function SetupFloatingDisplay(u36: userdata, p37: userdata, p38: number, p39: any) -- Line: 237
    -- upvalues: RemoveFromFloatingItems (copy), u9 (copy), u10 (ref), RunService (copy), u4 (copy), BuildPadCache (copy), u8 (copy)
    RemoveFromFloatingItems(u36);
    local u40 = nil;
    local u41 = nil;

    if not pcall(function() -- Line: 248
        -- upvalues: u40 (ref), u41 (ref), u36 (copy)
        local BoundingBox, v42 = u36:GetBoundingBox();
        u40 = BoundingBox;
        u41 = v42;
    end) then
        warn("SetupFloatingDisplay: Failed to get bounding box for", u36:GetFullName());
        u40 = CFrame.new();
        u41 = Vector3.new(2, 2, 2);
    end;

    local Position = p37:GetPivot().Position;
    local v43 = u40 - u40.Position;
    local Vector3_new_ret = Vector3.new(Position.X, Position.Y + p37.Size.Y / 2 + 0.1 + u41.Y / 2, Position.Z);
    u36:PivotTo(CFrame.new(Vector3_new_ret) * v43);
    local v44 = tick();
    table.insert(u9, {
        Phase = 0,
        SpinX = 0,
        SpinY = 0,
        SpinZ = 0,
        IsNear = false,
        DistanceTier = 0,
        ItemModel = u36,
        PadIndex = p38,
        BaseCenterPos = Vector3_new_ret,
        RotationOnly = v43,
        LastDistanceCheckTime = v44,
        LastUpdateTime = v44,
        BoothInstance = p39
    });

    if not u10 then
        u10 = RunService.Heartbeat:Connect(function(p45: number) -- Line: 139
            -- upvalues: u9 (ref), u4 (ref), BuildPadCache (ref), u8 (ref), u10 (ref)
            local v46 = tick();

            for i = #u9, 1, -1 do
                local v47 = u9[i];
                local v48;

                if v47.ItemModel and v47.ItemModel.Parent ~= nil then
                    if v46 - v47.LastDistanceCheckTime > 0.25 then
                        v47.LastDistanceCheckTime = v46;
                        local workspace_CurrentCamera = workspace.CurrentCamera;
                        local v49 = false;
                        local v50 = 0;

                        if workspace_CurrentCamera then
                            local BoothInstance = v47.BoothInstance;
                            local PadIndex = v47.PadIndex;
                            local v51 = u4[BoothInstance];

                            if not v51 then
                                v51 = BuildPadCache(BoothInstance);
                                u4[BoothInstance] = v51;
                            end;

                            local v52 = v51[PadIndex];

                            if v52 then
                                local Position2 = v52:GetPivot().Position;
                                local Magnitude = (workspace_CurrentCamera.CFrame.Position - Position2).Magnitude;
                                v49 = Magnitude <= 55;
                                local v53 = Magnitude / 55;
                                v48 = i;

                                for i2, v in ipairs(u8) do
                                    if v53 <= v.distanceRatio then
                                        v50 = i2 - 1;
                                        break;
                                    end;
                                end;
                            else
                                v48 = i;
                            end;
                        else
                            v48 = i;
                        end;

                        v47.IsNear = v49;
                        v47.DistanceTier = v50;
                    else
                        v48 = i;
                    end;

                    if v47.IsNear then
                        local v54 = (v47.DistanceTier <= 0 or v47.DistanceTier > #u8) and 0 or 1 / u8[v47.DistanceTier + 1].updateRate;
                        local math_min_ret = math.min(v46 - v47.LastUpdateTime, 0.1);

                        if v54 <= 0 or math_min_ret >= v54 then
                            v47.LastUpdateTime = v46;
                            v47.Phase = v47.Phase + 0.6 * math_min_ret;
                            v47.Phase = v47.Phase % 1;
                            local v55;

                            if v47.Phase < 0.5 then
                                v55 = v47.Phase * 2;
                            else
                                v55 = (1 - v47.Phase) * 2;
                            end;

                            local v56;

                            if v55 < 0.5 then
                                v56 = v55 * 2 * v55;
                            else
                                local v57 = 1 - v55;
                                v56 = 1 - v57 * 2 * v57;
                            end;

                            local v58 = v47.BaseCenterPos + Vector3.new(0, v56 * 0.4, 0);
                            v47.SpinX = v47.SpinX + 0.17453292519943295 * math_min_ret;
                            v47.SpinY = v47.SpinY + 0.4363323129985824 * math_min_ret;
                            v47.SpinZ = v47.SpinZ + 0.2617993877991494 * math_min_ret;
                            local CFrame_Angles_ret = CFrame.Angles(v47.SpinX, v47.SpinY, v47.SpinZ);
                            local v59 = CFrame.new(v58) * v47.RotationOnly * CFrame_Angles_ret;
                            v47.ItemModel:PivotTo(v59);
                        end;
                    end;
                else
                    table.remove(u9, i);
                    v48 = i;
                end;
            end;

            if #u9 == 0 and u10 then
                u10:Disconnect();
                u10 = nil;
            end;
        end);
    end;
end;

local function UpdatePadPriceGui(p60: userdata, p61: number?, p62: boolean) -- Line: 295
    -- upvalues: u3 (copy), NumberUtil (copy)
    local v63 = u3[p60];

    if not v63 then
        v63 = script.PriceGUI:Clone();
        v63.Parent = p60;
        u3[p60] = v63;
    end;

    v63.Enabled = p62;

    if p62 and p61 then
        v63.Frame.Price.Amount.Text = NumberUtil.Comma(p61);
    end;
end;

local function ClearPadPriceGui(p64: userdata) -- Line: 311
    -- upvalues: u3 (copy)
    local v65 = u3[p64];

    if v65 then
        v65.Enabled = false;
    end;
end;

local function ClearFloatingItemsForParent(p66: userdata) -- Line: 318
    -- upvalues: u9 (copy)
    for i = #u9, 1, -1 do
        local v67 = u9[i];
        local v68;

        if v67.ItemModel and v67.ItemModel:IsDescendantOf(p66) then
            table.remove(u9, i);
            v68 = i;
        else
            v68 = i;
        end;
    end;
end;

local function getPlayerSpawnCFrameForBooth(p69) -- Line: 327
    return CFrame.new((p69:GetPivot() * CFrame.new(0, 12, 5)).Position);
end;

local function GetItemUUIDSearchKeys(p70: string) -- Line: 331
    local v71 = { p70 };
    local string_gsub_ret = string.gsub(p70, "[{}]", "");

    if string_gsub_ret == p70 then
        table.insert(v71, "{" .. p70 .. "}");

        return v71;
    end;

    table.insert(v71, string_gsub_ret);

    return v71;
end;

local function FindPhysicalBoothWithItemUUID(p72: string) -- Line: 344
    -- upvalues: GetItemUUIDSearchKeys (copy)
    local TradeWorld = workspace:FindFirstChild("TradeWorld");

    if TradeWorld then
        TradeWorld = TradeWorld:FindFirstChild("Booths");
    end;

    if not TradeWorld then
        return nil;
    end;

    for _, child in TradeWorld:GetChildren() do
        local DynamicInstances = child:FindFirstChild("DynamicInstances");

        if DynamicInstances then
            local v73 = child;

            for _, v in GetItemUUIDSearchKeys(p72) do
                if DynamicInstances:FindFirstChild(v) then
                    print((`[TradeBoothController] Found physical booth with target item. Booth={v73.Name} ItemUUID={v}`));

                    return v73;
                end;
            end;
        end;
    end;

    return nil;
end;

local function ReadFoundBoothTeleportData(p74) -- Line: 369
    -- upvalues: u6 (ref)
    if typeof(p74) ~= "table" then
        return;
    end;

    if p74.SpawnInFrontOfFoundBooth ~= true then
        return;
    end;

    if typeof(p74.TargetItemUUID) ~= "string" then
        warn("[TradeBoothController] Missing TargetItemUUID in found booth teleport data");

        return;
    end;

    u6 = p74.TargetItemUUID;
    print((`[TradeBoothController] Found booth teleport requested. TargetItemUUID={u6}`));
end;

local function TryTeleportToFoundBooth() -- Line: 388
    -- upvalues: u7 (ref), u6 (ref), FindPhysicalBoothWithItemUUID (copy), TeleportUIController (copy)
    if u7 then
        return;
    end;

    if not u6 then
        return;
    end;

    local v75 = FindPhysicalBoothWithItemUUID(u6);

    if not v75 then
        return;
    end;

    u7 = true;
    local Name = v75.Name;
    u6 = nil;
    TeleportUIController:Move(CFrame.new((v75:GetPivot() * CFrame.new(0, 12, 5)).Position), "Booth");
    print((`[TradeBoothController] Teleported to found seller booth: {Name}`));
end;

local function StartFoundBoothRetry() -- Line: 411
    -- upvalues: u7 (ref), TryTeleportToFoundBooth (copy), u6 (ref)
    for i = 1, 40 do
        if u7 then
            return;
        end;

        TryTeleportToFoundBooth();

        if u7 then
            return;
        end;

        task.wait(0.25);
        local _ = i;
    end;

    if u6 then
        warn((`[TradeBoothController] Could not find physical booth with TargetItemUUID={u6}`));
    end;
end;

function v5.TeleportToBooth(p76) -- Line: 431
    -- upvalues: TradeWorldController (copy), Booths (copy), TradeBoothsData (copy), LocalPlayer (copy), TeleportUIController (copy), u2 (copy)
    if not TradeWorldController:IsInWorld() then
        return;
    end;

    local Data = Booths:GetData();

    if not Data then
        return;
    end;

    local v77 = Data.Players[TradeBoothsData.getPlayerId(LocalPlayer)];

    if not v77 then
        return;
    end;

    if v77.Booth then
        TeleportUIController:Move(CFrame.new((u2[v77.Booth]:GetPivot() * CFrame.new(0, 12, 5)).Position), "Booth");

        return;
    end;

    for i, v in u2 do
        local v78 = Data.Booths[i];

        if v78 and not v78.Owner then
            TeleportUIController:Move(CFrame.new((v:GetPivot() * CFrame.new(0, 12, 5)).Position), "Booth");

            return;
        end;
    end;
end;

local function GetFittingScale(p79: vector, p80: vector) -- Line: 465
    return math.min(p80.X / p79.X, p80.Y / p79.Y, p80.Z / p79.Z);
end;

local function setupItemDisplay(u81: userdata, p82: userdata, p83: number, p84: any) -- Line: 472
    -- upvalues: SetupFloatingDisplay (copy)
    if not (u81 and u81.Parent) then
        warn("setupItemDisplay: Invalid item instance or no parent");

        return;
    end;

    local success, result = pcall(function() -- Line: 478
        -- upvalues: u81 (copy)
        return u81:GetExtentsSize();
    end);

    if not success then
        warn("setupItemDisplay: Failed to get extents size for", u81:GetFullName());
        local v85, _, v86 = pcall(function() -- Line: 485
            -- upvalues: u81 (copy)
            if u81:IsA("Model") then
                return u81:GetBoundingBox();
            end;

            if u81:IsA("Tool") and u81.Handle then
                return u81.Handle.CFrame, u81.Handle.Size;
            end;
        end);
        result = v85 and v86 and v86 or Vector3.new(2, 2, 2);
    end;

    local u87 = 1;
    pcall(function() -- Line: 501
        -- upvalues: u87 (ref), u81 (copy)
        u87 = math.max(1, u81:GetScale());
    end);
    local v88 = Vector3.new(2.5, 2.5, 2.5) * u87;
    local math_min_ret = math.min(v88.X / result.X, v88.Y / result.Y, v88.Z / result.Z);
    pcall(function() -- Line: 505
        -- upvalues: u81 (copy), math_min_ret (copy)
        if u81.GetScale and (math_min_ret < u81:GetScale() and u81.ScaleTo) then
            u81:ScaleTo(math_min_ret);
        end;
    end);

    if u81.Parent then
        SetupFloatingDisplay(u81, p82, p83, p84);

        return;
    end;

    warn("setupItemDisplay: Item was destroyed before floating could be set up");
end;

function v5.GetPlayerBoothData(p89: table, p90: userdata) -- Line: 522
    -- upvalues: TradeWorldController (copy), Booths (copy), TradeBoothsData (copy)
    if not TradeWorldController:IsInWorld() then
        return nil;
    end;

    local Data = Booths:GetData();

    if Data then
        return Data.Players[TradeBoothsData.getPlayerId(p90)] or nil;
    end;

    return nil;
end;

function v5.Start(p91) -- Line: 540
    -- upvalues: TradeWorldController (copy), Booths (copy), TeleportService (copy), u6 (ref), StartFoundBoothRetry (copy), Observers (copy), Trove (copy), u2 (copy), TryTeleportToFoundBooth (copy), u4 (copy), BuildPadCache (copy), TradeBoothSkinRegistry (copy), TradeBoothsData (copy), LocalPlayer (copy), TradeBoothSkinUIController (copy), RemoveBooth (copy), TradeEvents (copy), ConfirmationPromptController (copy), TradeBoothListingController (copy), GuiController (copy), RemoveFromFloatingItems (copy), u3 (copy), ItemImageFinder (copy), ItemRarityFinder (copy), GGStaticData (copy), ItemNameFinder (copy), NumberUtil (copy), setupItemDisplay (copy), u1 (copy), SelectiveAssetReplication (copy), ClearFloatingItemsForParent (copy)
    if not TradeWorldController:IsInWorld() then
        return;
    end;

    local DataAsync = Booths:GetDataAsync();
    local LocalPlayerTeleportData = TeleportService:GetLocalPlayerTeleportData();

    if typeof(LocalPlayerTeleportData) == "table" and LocalPlayerTeleportData.SpawnInFrontOfFoundBooth == true then
        if typeof(LocalPlayerTeleportData.TargetItemUUID) == "string" then
            u6 = LocalPlayerTeleportData.TargetItemUUID;
            print((`[TradeBoothController] Found booth teleport requested. TargetItemUUID={u6}`));
        else
            warn("[TradeBoothController] Missing TargetItemUUID in found booth teleport data");
        end;
    end;

    if u6 then
        task.spawn(StartFoundBoothRetry);
    end;

    Observers.observeTag("TradeBooth", function(u92) -- Line: 556
        -- upvalues: Trove (ref), u2 (ref), TryTeleportToFoundBooth (ref), u4 (ref), DataAsync (copy), BuildPadCache (ref), TradeBoothSkinRegistry (ref), TradeBoothsData (ref), LocalPlayer (ref), TradeBoothSkinUIController (ref), RemoveBooth (ref), TradeEvents (ref), ConfirmationPromptController (ref), TradeBoothListingController (ref), GuiController (ref), RemoveFromFloatingItems (ref), u3 (ref), ItemImageFinder (ref), ItemRarityFinder (ref), GGStaticData (ref), ItemNameFinder (ref), NumberUtil (ref), setupItemDisplay (ref), u1 (ref), Booths (ref), SelectiveAssetReplication (ref), ClearFloatingItemsForParent (ref)
        local Name = u92.Name;
        local v93 = Trove.new();
        u2[Name] = u92;
        TryTeleportToFoundBooth();
        v93:Add(function() -- Line: 561
            -- upvalues: u2 (ref), Name (copy), u92 (copy), u4 (ref)
            u2[Name] = nil;
            u4[u92] = nil;
        end);
        local u94 = nil;
        local u95 = nil;
        local u96 = v93:Extend();
        local u97 = v93:Extend();
        local u98 = v93:Extend();
        local u99 = v93:Extend();
        local u100 = "-1";
        local u101 = nil;
        local u102 = nil;
        local u103 = {};

        local function getOwnerId() -- Line: 578
            -- upvalues: DataAsync (ref), Name (copy)
            local v104 = DataAsync.Booths[Name];

            if v104 then
                v104 = v104.Owner;
            end;

            return v104;
        end;

        local function getSkinId() -- Line: 583
            -- upvalues: DataAsync (ref), Name (copy)
            local v105 = DataAsync.Booths[Name];

            if v105 then
                v105 = v105.Skin;
            end;

            return v105;
        end;

        local function findTradePads() -- Line: 588
            -- upvalues: u4 (ref), u92 (copy), BuildPadCache (ref)
            local v106 = u4[u92];

            if v106 then
                return v106;
            end;

            local v107 = BuildPadCache(u92);
            u4[u92] = v107;

            return v107;
        end;

        local function findItemsFolder() -- Line: 601
            -- upvalues: u92 (copy)
            return u92:FindFirstChild("DynamicInstances");
        end;

        local u108 = nil;

        local function initializeBooth() -- Line: 607
            -- upvalues: u96 (copy), u92 (copy), u94 (ref), DataAsync (ref), Name (copy), TradeBoothSkinRegistry (ref), u95 (ref), TradeBoothsData (ref), LocalPlayer (ref), TradeBoothSkinUIController (ref), RemoveBooth (ref), TradeEvents (ref), ConfirmationPromptController (ref), TradeBoothListingController (ref), GuiController (ref)
            u96:Clean();

            for _, descendant in u92:GetDescendants() do
                if descendant:HasTag("TradeBoothSign") then
                    u94 = descendant;
                    break;
                end;
            end;

            if not u94 then
                warn("No TradeBoothSign found on booth");

                return;
            end;

            local v109 = DataAsync.Booths[Name];

            if v109 then
                v109 = v109.Skin;
            end;

            local v110 = TradeBoothSkinRegistry[v109 or "Default"];
            local v111 = v110 and v110.ProxPromptOffset or Vector3.new(0, 0, 0);
            local v112 = u96:Add(Instance.new("Attachment"));
            v112.Position = Vector3.new(-5, -6, 0) + v111;
            v112.Parent = u94;
            u95 = u96:Add(Instance.new("ProximityPrompt"));
            u95.Name = "ProximityPrompt";
            u95.ActionText = "Claim";
            u95.MaxActivationDistance = 8;
            u95.ObjectText = "Booth";
            u95.RequiresLineOfSight = false;
            u95.Style = Enum.ProximityPromptStyle.Custom;
            u95.Parent = v112;
            u95:SetAttribute("Theme", "ShadowedPrompt");
            u96:Add(u95.Triggered:Connect(function(p113: userdata) -- Line: 640
                -- upvalues: DataAsync (ref), Name (ref), TradeBoothsData (ref), LocalPlayer (ref), TradeBoothSkinUIController (ref), RemoveBooth (ref), TradeEvents (ref), u92 (ref), ConfirmationPromptController (ref), TradeBoothListingController (ref), GuiController (ref)
                local v114 = DataAsync.Booths[Name];

                if v114 then
                    v114 = v114.Owner;
                end;

                local _ = v114 == TradeBoothsData.getPlayerId(LocalPlayer);

                if v114 == nil then
                    local v115 = DataAsync.Players[TradeBoothsData.getPlayerId(LocalPlayer)];

                    if v115 and v115.Booth then
                        ConfirmationPromptController:Open({
                            Title = "Claim Booth",
                            Header = "Do you want to claim this booth?",
                            Middle = "This will remove your claim on your current booth.",
                            Footer = ""
                        }, {
                            ConfirmCallback = function() -- Line: 654, Name: ConfirmCallback
                                -- upvalues: TradeBoothSkinUIController (ref), RemoveBooth (ref), TradeEvents (ref), u92 (ref)
                                if TradeBoothSkinUIController:Prompt():Wait() then
                                    RemoveBooth:FireServer();
                                    task.wait(0.2);
                                    TradeEvents.Booths.ClaimBooth:FireServer(u92);
                                end;
                            end
                        });

                        return;
                    end;

                    if TradeBoothSkinUIController:Prompt():Wait() then
                        TradeEvents.Booths.ClaimBooth:FireServer(u92);
                    end;
                else
                    TradeBoothListingController:SetBooth(Name);
                    GuiController:Open(LocalPlayer.PlayerGui.TradeBooth);
                end;
            end));
        end;

        local function updateItems() -- Line: 678
            -- upvalues: DataAsync (ref), Name (copy), u103 (ref), RemoveFromFloatingItems (ref), u98 (copy), u4 (ref), u92 (copy), BuildPadCache (ref), u3 (ref), u102 (ref), ItemImageFinder (ref), ItemRarityFinder (ref), GGStaticData (ref), ItemNameFinder (ref), NumberUtil (ref), setupItemDisplay (ref)
            local v116 = DataAsync.Booths[Name];

            if v116 then
                v116 = v116.Owner;
            end;

            if not v116 then
                for _, v in u103 do
                    RemoveFromFloatingItems(v.instance);

                    if v.instance:IsA("BasePart") and v.instance.Name == "SkinGUI" then
                        u98:Remove(v.instance);
                        v.instance:Destroy();
                    end;
                end;

                u103 = {};
                local v117 = u4[u92];

                if not v117 then
                    v117 = BuildPadCache(u92);
                    u4[u92] = v117;
                end;

                for _, v in v117 do
                    local v118 = u3[v];

                    if v118 then
                        v118.Enabled = false;
                    end;
                end;

                return;
            end;

            local u119 = DataAsync.Players[v116];

            if not (u119 and u119.Listings) then
                for _, v in u103 do
                    RemoveFromFloatingItems(v.instance);

                    if v.instance:IsA("BasePart") and v.instance.Name == "SkinGUI" then
                        u98:Remove(v.instance);
                        v.instance:Destroy();
                    end;
                end;

                u103 = {};
                local v120 = u4[u92];

                if not v120 then
                    v120 = BuildPadCache(u92);
                    u4[u92] = v120;
                end;

                for _, v in v120 do
                    local v121 = u3[v];

                    if v121 then
                        v121.Enabled = false;
                    end;
                end;

                return;
            end;

            u102 = u92:FindFirstChild("DynamicInstances");

            if not u102 then
                return;
            end;

            local v122 = {};

            for i in u119.Listings do
                table.insert(v122, i);
            end;

            table.sort(v122, function(p123, p124) -- Line: 729
                -- upvalues: u119 (copy)
                local Price = u119.Listings[p123].Price;
                local Price2 = u119.Listings[p124].Price;

                if Price == Price2 then
                    return p123 < p124;
                end;

                return Price2 < Price;
            end);
            local v125 = u4[u92];

            if not v125 then
                v125 = BuildPadCache(u92);
                u4[u92] = v125;
            end;

            local v126 = {};

            for i = 1, 4 do
                local v127 = v122[i];

                if not v127 then
                    break;
                end;

                local v128 = u119.Listings[v127];
                local v129;

                if v128 then
                    local v130 = u119.Items[v128.ItemId];

                    if v130 then
                        local v131 = v125[i];

                        if v131 then
                            local v132 = v130.Name or (v130.ItemName or v130.PetType or (v130.SkinID or ""));

                            if (v130.PetType and "Pet" or (v130.ItemName and "Holdable" or "TradeBoothSkin")) == "TradeBoothSkin" then
                                local v133 = u103[v128.ItemId];

                                if v133 and (v133.instance and (v133.instance.Parent and v133.instance:IsA("BasePart"))) then
                                    local instance = v133.instance;
                                    instance:PivotTo(v131:GetPivot() * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(-(instance.Size.Y + 0.5) / 2, 0, 0));
                                    v126[v128.ItemId] = {
                                        padIndex = i,
                                        instance = instance
                                    };
                                else
                                    local v134 = u98:Clone(script.SkinGUI);
                                    local BillboardGui = v134.BillboardGui;
                                    BillboardGui.Frame.ImageButton.Image = ItemImageFinder(v132, v128.ItemType);
                                    local v135 = ItemRarityFinder(v132, v128.ItemType);

                                    if v135 then
                                        v135 = GGStaticData.RarityColorMap[v135];
                                    end;

                                    BillboardGui.Frame.TextLabel.Text = ItemNameFinder(v132, v128.ItemType);
                                    BillboardGui.Frame.TextLabel.TextColor3 = v135 or Color3.new(1, 1, 1);
                                    BillboardGui.Frame.Price.Amount.Text = NumberUtil.Comma(v128.Price);
                                    v134.Parent = v131;
                                    v134:PivotTo(v131:GetPivot() * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(-(v134.Size.Y + 0.3) / 2, 0, 0));
                                    v126[v128.ItemId] = {
                                        padIndex = i,
                                        instance = v134
                                    };
                                end;

                                local Price = v128.Price;
                                local v136 = u3[v131];

                                if not v136 then
                                    v136 = script.PriceGUI:Clone();
                                    v136.Parent = v131;
                                    u3[v131] = v136;
                                end;

                                v136.Enabled = true;

                                if Price then
                                    v136.Frame.Price.Amount.Text = NumberUtil.Comma(Price);
                                    v129 = i;
                                else
                                    v129 = i;
                                end;
                            else
                                u102:FindFirstChild(v128.ItemId);
                                v129 = i;
                                local v137 = 0;
                                local v138;

                                repeat
                                    v138 = u102:FindFirstChild(v128.ItemId);
                                    v137 = v137 + task.wait();
                                until v137 >= 5 or v138 ~= nil;

                                if v138 then
                                    if not v138:IsDescendantOf(workspace) then
                                        task.wait(0.1);
                                    end;

                                    if v138.Parent then
                                        local v139 = u103[v128.ItemId];

                                        if not v139 or v139.padIndex ~= v129 then
                                            if v139 then
                                                RemoveFromFloatingItems(v139.instance);
                                            end;

                                            setupItemDisplay(v138, v131, v129, u92);
                                        end;

                                        v126[v128.ItemId] = {
                                            padIndex = v129,
                                            instance = v138
                                        };
                                        local Price = v128.Price;
                                        local v140 = u3[v131];

                                        if not v140 then
                                            v140 = script.PriceGUI:Clone();
                                            v140.Parent = v131;
                                            u3[v131] = v140;
                                        end;

                                        v140.Enabled = true;

                                        if Price then
                                            v140.Frame.Price.Amount.Text = NumberUtil.Comma(Price);
                                        end;
                                    end;
                                else
                                    warn("TradeBoothController: Item instance not found for ID:", v128.ItemId, v132);
                                end;
                            end;
                        else
                            warn("No TradePad found for index", i);
                            v129 = i;
                        end;
                    else
                        v129 = i;
                    end;
                else
                    v129 = i;
                end;
            end;

            for i, v in u103 do
                if not v126[i] then
                    if v.instance:IsA("BasePart") and v.instance.Name == "SkinGUI" then
                        u98:Remove(v.instance);
                        v.instance:Destroy();
                    else
                        RemoveFromFloatingItems(v.instance);
                    end;

                    local v141 = v125[v.padIndex];

                    if v141 then
                        local v142 = u3[v141];

                        if v142 then
                            v142.Enabled = false;
                        end;
                    end;
                end;
            end;

            for i = 1, 4 do
                local v143 = v125[i];
                local v144;

                if v143 then
                    v144 = i;
                    local v145 = false;

                    for _, v in v126 do
                        if v.padIndex == v144 then
                            v145 = true;
                            break;
                        end;
                    end;

                    if not v145 then
                        local v146 = u3[v143];

                        if v146 then
                            v146.Enabled = false;
                        end;
                    end;
                else
                    v144 = i;
                end;
            end;

            u103 = v126;
        end;

        local function observeItemsFolder() -- Line: 892
            -- upvalues: u99 (copy), u108 (ref), u92 (copy), updateItems (copy)
            u99:Clean();
            u108 = nil;
            local DynamicInstances = u92:FindFirstChild("DynamicInstances");

            if not DynamicInstances then
                return;
            end;

            u108 = u99:Add(DynamicInstances.ChildAdded:Connect(function(p147) -- Line: 901
                -- upvalues: updateItems (ref)
                if not p147.Parent then
                    return;
                end;

                task.wait(0.1);
                updateItems();
            end));
            u99:Add(DynamicInstances.ChildRemoved:Connect(function(p148) -- Line: 910
                -- upvalues: updateItems (ref)
                task.wait(0.1);
                updateItems();
            end));
            updateItems();
        end;

        local function updateBooth() -- Line: 918
            -- upvalues: DataAsync (ref), Name (copy), u1 (ref), u97 (copy), u100 (ref), u95 (ref), TradeBoothsData (ref), LocalPlayer (ref), Booths (ref), updateItems (copy), observeItemsFolder (copy), u94 (ref)
            local v149 = DataAsync.Booths[Name];

            if v149 then
                v149 = v149.Owner;
            end;

            u1[Name] = v149;
            u97:Clean();
            u100 = v149;

            if u95 then
                if v149 == nil then
                    u95.ActionText = "Claim";
                elseif v149 == TradeBoothsData.getPlayerId(LocalPlayer) then
                    u95.ActionText = "Edit";
                else
                    u95.ActionText = "View";
                end;
            end;

            local v150 = v149 and Booths:GetPathSignal((`Players/{v149}/@`));

            if v150 then
                u97:Add(v150:Connect(updateItems));
            end;

            observeItemsFolder();

            if v149 then
                v149 = TradeBoothsData.getPlayerById(v149);
            end;

            if u94 then
                if v149 then
                    u94.SurfaceGui.TextLabel.Text = `@{v149.Name}'s Booth`;

                    return;
                end;

                u94.SurfaceGui.TextLabel.Text = "Unclaimed Booth";
            end;
        end;

        local function updateSkin() -- Line: 954
            -- upvalues: DataAsync (ref), Name (copy), u101 (ref), SelectiveAssetReplication (ref), u103 (ref), u98 (copy), ClearFloatingItemsForParent (ref), u92 (copy), u4 (ref), initializeBooth (copy), updateBooth (copy)
            local v151 = DataAsync.Booths[Name];

            if v151 then
                v151 = v151.Skin;
            end;

            local v152 = DataAsync.Booths[Name];

            if v152 then
                v152 = v152.Owner;
            end;

            local v153 = v152 == nil and "Default" or v151;

            if v153 == u101 then
                return;
            end;

            u101 = v153;
            local AssetAsync = SelectiveAssetReplication:GetAssetAsync("TradeBoothSkins", v153 or "Default");

            if not AssetAsync then
                error("INVALID SKIN");
            end;

            for _, v in u103 do
                if v.instance:IsA("BasePart") and v.instance.Name == "SkinGUI" then
                    u98:Remove(v.instance);
                    v.instance:Destroy();
                end;
            end;

            u103 = {};
            ClearFloatingItemsForParent(u92);
            u4[u92] = nil;
            local DynamicInstances = u92:FindFirstChild("DynamicInstances");

            for _, child in u92:GetChildren() do
                if child.Name ~= "DynamicInstances" then
                    child:Destroy();
                end;
            end;

            local v154 = AssetAsync:Clone();
            v154:PivotTo(u92:GetPivot());
            v154.Parent = u92;

            if DynamicInstances and DynamicInstances.Parent == nil then
                DynamicInstances.Parent = u92;
            end;

            initializeBooth();
            updateBooth();
        end;

        local PathSignal = Booths:GetPathSignal((`Booths/{Name}/Owner`));

        if PathSignal then
            v93:Add(PathSignal:Connect(updateBooth));
        end;

        local PathSignal2 = Booths:GetPathSignal((`Booths/{Name}/Skin`));

        if PathSignal2 then
            v93:Add(PathSignal2:Connect(updateSkin));
        end;

        updateSkin();

        return v93:WrapClean();
    end);
end;

task.spawn(v5.Start, v5);

return v5;