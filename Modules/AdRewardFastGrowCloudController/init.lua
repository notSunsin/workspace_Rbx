-- Decompiled with Potassium's decompiler.

if script.RobloxAdServiceTesting.Value ~= false then
    local ReplicatedStorage = game:GetService("ReplicatedStorage");
    local AdService = game:GetService("AdService");
    local Players = game:GetService("Players");
    local Workspace = game:GetService("Workspace");
    local LocalPlayer = Players.LocalPlayer;
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    require(ReplicatedStorage.Data.AdRewardsWateringCanRewards);
    local FastTween = require(ReplicatedStorage.Modules.FastTween);
    local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
    local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
    local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
    local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
    require(ReplicatedStorage.Modules.GardenGuideModules.ImageCycle);
    local GuiController = require(ReplicatedStorage.Modules.GuiController);
    local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
    local AdRewardsWateringCan = GameEvents:WaitForChild("AdRewardsWateringCan");
    local AdRewardEvents = GameEvents:WaitForChild("AdRewardEvents");
    local WateringCanDataRefreshed = AdRewardsWateringCan:WaitForChild("WateringCanDataRefreshed");
    local WateringCanGetData = AdRewardsWateringCan:WaitForChild("WateringCanGetData");
    local WateringCanClaim = AdRewardsWateringCan:WaitForChild("WateringCanClaim");
    local WateringCanClaimResult = AdRewardsWateringCan:WaitForChild("WateringCanClaimResult");
    local LogEvent = AdRewardEvents:WaitForChild("LogEvent");
    local _Roblox_Ad_Services_Team_WaterPot = PlayerGui:WaitForChild("_Roblox_Ad_Services_Team_WaterPot");
    local Main = _Roblox_Ad_Services_Team_WaterPot:WaitForChild("Main");
    local INF = Main:WaitForChild("INF");
    local Timer = Main:WaitForChild("Frame"):WaitForChild("Timer");
    local ExitButton = Main:WaitForChild("Frame"):WaitForChild("ExitButton");
    local waterpot_holder = _Roblox_Ad_Services_Team_WaterPot:WaitForChild("waterpot_holder");
    local WateringCan = waterpot_holder:WaitForChild("WateringCan");
    local WateringCanInv = waterpot_holder:WaitForChild("WateringCanInv");
    local u1 = {};
    local u2 = false;
    local u3 = false;
    local u4 = false;
    local u5 = nil;
    local u6 = nil;
    local u7 = 0;
    local u8 = {
        Enum.AdAvailabilityResult.PlayerIneligible,
        Enum.AdAvailabilityResult.DeviceIneligible,
        Enum.AdAvailabilityResult.PublisherIneligible,
        Enum.AdAvailabilityResult.ExperienceIneligible
    };

    local function isIneligible(p9) -- Line: 87
        -- upvalues: u8 (copy)
        for _, v in ipairs(u8) do
            if p9 == v then
                print("Ineligible For Ad Service: ", p9);

                return true;
            end;
        end;

        return false;
    end;

    local function checkForAds() -- Line: 98
        -- upvalues: u4 (ref), AdService (copy), u2 (ref), u7 (ref), WateringCan (copy), WateringCanInv (copy), u3 (ref), isIneligible (copy), waterpot_holder (copy), PlayerGui (copy)
        if u4 then
            return;
        end;

        local success, result = pcall(function() -- Line: 105
            -- upvalues: AdService (ref)
            return AdService:GetAdAvailabilityNowAsync(Enum.AdFormat.RewardedVideo);
        end);

        if success and result.AdAvailabilityResult == Enum.AdAvailabilityResult.IsAvailable then
            u2 = true;

            if u7 < 4 then
                WateringCan.Visible = true;
                WateringCanInv.Visible = false;
            else
                WateringCan.Visible = false;
                print("No watering cans remaining this period.");
            end;
        else
            u2 = false;

            if u3 == true then
                WateringCan.Visible = false;
            end;
        end;

        if not (success and isIneligible(result.AdAvailabilityResult)) then
            if success then
                u3 = true;
                waterpot_holder.Visible = true;
                waterpot_holder.Parent = PlayerGui.Teleport_UI;
                print("(Water Pot) Eligible for Water Can Ad Services");
            end;

            return;
        end;

        u3 = false;
        waterpot_holder.Visible = false;
        print("Ineligible for Water Can Ad Services");
    end;

    local function Darken(p10, p11: number) -- Line: 159
        local v12, v13, v14 = p10:ToHSV();

        return Color3.fromHSV(v12, v13, (math.clamp(v14 / p11, 0, 1)));
    end;

    local function formatCountdown(p15: number) -- Line: 164
        -- upvalues: NumberUtil (copy)
        return NumberUtil.compactFormat((math.max(0, p15)));
    end;

    local function InitialiseWateringCanPack() -- Line: 172
        -- upvalues: INF (copy), GuiController (copy), _Roblox_Ad_Services_Team_WaterPot (copy), LocalPlayer (copy), LogEvent (copy), u7 (ref), u2 (ref), AdService (copy), u5 (ref), FastTween (copy), u4 (ref), checkForAds (copy), u3 (ref), WateringCanClaim (copy), ItemImageFinder (copy), ItemNameFinder (copy), GiveServiceCommon (copy), u6 (ref), Workspace (copy), NumberUtil (copy), Timer (copy), WateringCanDataRefreshed (copy), WateringCanClaimResult (copy), ExitButton (copy), WateringCan (copy), WateringCanInv (copy), Main (copy)
        local Holder = INF.Holder;
        local Template = Holder.Template;
        GuiController:UsePopupAnims(_Roblox_Ad_Services_Team_WaterPot);
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 0;
        LogEvent:FireServer({
            eventName = "WateringCanRegistered",
            value = 1,
            fields = {
                playerId = LocalPlayer.UserId,
                playerName = LocalPlayer.Name
            }
        });

        local function clearTemplates() -- Line: 194
            -- upvalues: Holder (copy)
            for _, child in Holder:GetChildren() do
                if child:IsA("GuiObject") and tonumber(child.Name) then
                    child:Destroy();
                end;
            end;
        end;

        local function updateClaimVisuals() -- Line: 204
            -- upvalues: Holder (copy), u7 (ref), u2 (ref), AdService (ref)
            for _, child in Holder:GetChildren() do
                local v16 = tonumber(child.Name);

                if v16 then
                    local CLAIM_BUTTON = child:FindFirstChild("CLAIM_BUTTON");
                    local CLAIM_BUTTON_DISABLED = child:FindFirstChild("CLAIM_BUTTON_DISABLED");
                    local CLAIM_BUTTON_LOCKED = child:FindFirstChild("CLAIM_BUTTON_LOCKED");

                    if CLAIM_BUTTON then
                        CLAIM_BUTTON.Visible = false;

                        if CLAIM_BUTTON:FindFirstChild("SENSOR") then
                            CLAIM_BUTTON.SENSOR.Active = false;
                        end;
                    end;

                    if CLAIM_BUTTON_DISABLED then
                        CLAIM_BUTTON_DISABLED.Visible = false;

                        if CLAIM_BUTTON_DISABLED:FindFirstChild("SENSOR") then
                            CLAIM_BUTTON_DISABLED.SENSOR.Active = false;
                        end;
                    end;

                    if CLAIM_BUTTON_LOCKED then
                        CLAIM_BUTTON_LOCKED.Visible = false;

                        if CLAIM_BUTTON_LOCKED:FindFirstChild("SENSOR") then
                            CLAIM_BUTTON_LOCKED.SENSOR.Active = false;
                        end;
                    end;

                    if v16 <= u7 then
                        if CLAIM_BUTTON_DISABLED then
                            CLAIM_BUTTON_DISABLED.Visible = true;
                        end;
                    elseif u7 < 4 and (v16 == u7 + 1 and u2 == true) then
                        if CLAIM_BUTTON then
                            CLAIM_BUTTON.Visible = true;

                            if CLAIM_BUTTON:FindFirstChild("SENSOR") then
                                CLAIM_BUTTON.SENSOR.Active = true;
                                local _, _ = pcall(function() -- Line: 249
                                    -- upvalues: AdService (ref), CLAIM_BUTTON (copy)
                                    AdService:RegisterAdOpportunityAsync(CLAIM_BUTTON.SENSOR, 680725949261319);
                                end);
                            end;
                        end;
                    elseif CLAIM_BUTTON_LOCKED then
                        CLAIM_BUTTON_LOCKED.Visible = true;
                    end;
                end;
            end;
        end;

        local function buildFromSnapshot() -- Line: 266
            -- upvalues: u5 (ref), FastTween (ref), NumberValue (copy), u7 (ref), clearTemplates (copy), Template (copy), u4 (ref), checkForAds (ref), u2 (ref), u3 (ref), LocalPlayer (ref), LogEvent (ref), WateringCanClaim (ref), ItemImageFinder (ref), ItemNameFinder (ref), GiveServiceCommon (ref), Holder (copy), updateClaimVisuals (copy)
            if not u5 then
                return;
            end;

            local v17 = u5.Rewards or {};

            if type(v17) ~= "table" then
                return;
            end;

            FastTween(NumberValue, TweenInfo.new(0.2), {
                Value = u7
            });
            clearTemplates();
            local math_min_ret = math.min(4, #v17);

            for i = 1, math_min_ret do
                local v18 = v17[i];
                local v19;

                if v18 then
                    local v20 = Template:Clone();
                    v20.Name = tostring(i);
                    v20.LayoutOrder = i;
                    v20.ZIndex = math_min_ret - i;
                    v20.Visible = true;

                    if v20:FindFirstChild("CLAIM_BUTTON") then
                        v20.CLAIM_BUTTON.Visible = false;
                    end;

                    if v20:FindFirstChild("CLAIM_BUTTON_DISABLED") then
                        v20.CLAIM_BUTTON_DISABLED.Visible = false;
                    end;

                    if v20:FindFirstChild("CLAIM_BUTTON_LOCKED") then
                        v20.CLAIM_BUTTON_LOCKED.Visible = false;
                    end;

                    if i == 4 then
                        v20.Arrow.Visible = false;
                    end;

                    v20.CLAIM_BUTTON.SENSOR.Activated:Connect(function() -- Line: 321
                        -- upvalues: u4 (ref), u7 (ref), i (copy), checkForAds (ref), u2 (ref), u3 (ref), LocalPlayer (ref), LogEvent (ref), WateringCanClaim (ref)
                        if u4 == true then
                            return;
                        end;

                        if u7 >= 4 then
                            print("No watering cans remaining this period.");

                            return;
                        end;

                        if u7 + 1 ~= i then
                            return;
                        end;

                        checkForAds();

                        if u2 and u3 then
                            u2 = false;
                            u4 = true;
                            LogEvent:FireServer({
                                eventName = "WateringCanClaimAttempt",
                                value = 1,
                                fields = {
                                    playerId = LocalPlayer.UserId,
                                    playerName = LocalPlayer.Name,
                                    slotIndex = i,
                                    totalClaimsBefore = u7
                                }
                            });
                            WateringCanClaim:FireServer();
                        end;
                    end);
                    local v21 = v18.Rewards and v18.Rewards[1];

                    if v21 then
                        v20.IMAGE_CONTAINER.ITEM_IMAGE.Image = ItemImageFinder(v21.RewardName, v21.Type);
                        local v22 = `{ItemNameFinder(v21.RewardName, v21.Type) or v21.RewardName}{v21.Amount <= 1 and "" or ` x{v21.Amount}`}`;
                        v20.IMAGE_CONTAINER.RewardName.Text = v22;
                        local RarityColor = GiveServiceCommon:GetRarityColor({
                            Type = v21.Type,
                            Value = v21.RewardName or "Normal",
                            Quantity = v21.Amount or 1
                        });
                        local v23 = RarityColor or Color3.fromRGB(127, 127, 127);
                        local v24 = RarityColor or Color3.fromRGB(127, 127, 127);
                        local IMAGE_CONTAINER = v20.IMAGE_CONTAINER;
                        local v25, v26, v27 = v24:ToHSV();
                        IMAGE_CONTAINER.BackgroundColor3 = Color3.fromHSV(v25, v26, (math.clamp(v27 / 1.3, 0, 1)));
                        local RewardName = v20.IMAGE_CONTAINER.RewardName;
                        local v28, v29, v30 = v23:ToHSV();
                        RewardName.TextStrokeColor3 = Color3.fromHSV(v28, v29, (math.clamp(v30 / 3, 0, 1)));
                    end;

                    v20.CLAIM_BUTTON.CLAIM.Text = "Watch";
                    v20.CLAIM_BUTTON.CLAIM_BUTTON.Text = "Watch";
                    v20.Parent = Holder;
                    v19 = i;
                else
                    v19 = i;
                end;
            end;

            updateClaimVisuals();
        end;

        task.spawn(function() -- Line: 404
            -- upvalues: u6 (ref), Workspace (ref), NumberUtil (ref), Timer (ref), u2 (ref), u3 (ref), checkForAds (ref), updateClaimVisuals (copy)
            task.spawn(function() -- Line: 409
                -- upvalues: u6 (ref), Workspace (ref), NumberUtil (ref), Timer (ref)
                while true do
                    repeat
                        wait(1);
                    until u6;

                    local v31 = u6 - Workspace:GetServerTimeNow();
                    local math_max_ret = math.max(0, v31);
                    Timer.Text = "Refresh in: " .. NumberUtil.compactFormat((math.max(0, math_max_ret)));
                end;
            end);
            local v32 = 0;

            while true do
                while true do
                    task.wait(3);
                    v32 = v32 + 1;

                    if not u2 then
                        break;
                    end;

                    wait(5);
                end;

                if v32 >= 10 and (u2 == false and u3 == true) then
                    checkForAds();
                    updateClaimVisuals();

                    if u3 == false then
                        return;
                    end;

                    v32 = 0;
                end;
            end;
        end);
        checkForAds();
        print("Ad Service Checked");
        updateClaimVisuals();
        WateringCanDataRefreshed.OnClientEvent:Connect(function(p33, p34, p35) -- Line: 468
            -- upvalues: u5 (ref), u6 (ref), u7 (ref), u4 (ref), buildFromSnapshot (copy), checkForAds (ref)
            u5 = p33;
            u6 = p34;
            u7 = p35 or 0;
            math.max(0, 4 - u7);
            u4 = false;
            buildFromSnapshot();
            checkForAds();
        end);
        WateringCanClaimResult.OnClientEvent:Connect(function(p36: boolean, p37: number, p38: number) -- Line: 485
            -- upvalues: u7 (ref), u4 (ref), u5 (ref), LocalPlayer (ref), LogEvent (ref), checkForAds (ref), updateClaimVisuals (copy)
            u7 = p37 or u7;
            u4 = false;

            if p36 then
                print("Claim Success");
                local v39 = u5 and u5.Rewards and u5.Rewards[p37];
                local v40 = v39 and v39.Rewards and v39.Rewards[1];
                LogEvent:FireServer({
                    eventName = "WateringCanClaimResult",
                    value = 1,
                    fields = {
                        wasSuccessful = true,
                        playerId = LocalPlayer.UserId,
                        playerName = LocalPlayer.Name,
                        slotIndex = p37,
                        totalClaimsAfter = p37,
                        itemName = v40 and v40.RewardName or nil
                    }
                });
            else
                print("Claim failed");
                LogEvent:FireServer({
                    eventName = "WateringCanClaimResult",
                    value = 1,
                    fields = {
                        wasSuccessful = false,
                        playerId = LocalPlayer.UserId,
                        playerName = LocalPlayer.Name,
                        totalClaimsAfter = p37 or u7
                    }
                });
            end;

            checkForAds();
            updateClaimVisuals();
        end);
        ExitButton.MouseButton1Up:Connect(function() -- Line: 554
            -- upvalues: GuiController (ref), _Roblox_Ad_Services_Team_WaterPot (ref)
            GuiController:Toggle(_Roblox_Ad_Services_Team_WaterPot);
        end);
        WateringCan.MouseButton1Up:Connect(function() -- Line: 559
            -- upvalues: GuiController (ref), _Roblox_Ad_Services_Team_WaterPot (ref)
            GuiController:Toggle(_Roblox_Ad_Services_Team_WaterPot);
        end);
        WateringCanInv.MouseButton1Up:Connect(function() -- Line: 564
            -- upvalues: Main (ref)
            Main.Visible = not Main.Visible;
        end);
    end;

    function u1.Start(p41) -- Line: 575
        -- upvalues: WateringCanGetData (copy), u5 (ref), u6 (ref), u7 (ref), InitialiseWateringCanPack (copy)
        local v42, v43, v44, v45 = pcall(function() -- Line: 578
            -- upvalues: WateringCanGetData (ref)
            return WateringCanGetData:InvokeServer();
        end);

        if v42 then
            u5 = v43;
            u6 = v44;
            u7 = v45 or 0;
            math.max(0, 4 - u7);
        else
            warn("WateringCanGetData failed:", v43);
        end;

        InitialiseWateringCanPack();
    end;

    task.spawn(function() -- Line: 602
        -- upvalues: LocalPlayer (copy), u1 (copy)
        game:GetService("RunService");
        wait(35);
        print("Roblox Ad Services Team - Watering Can Testing");

        if LocalPlayer:GetAttribute("AB_rewarded_video_ad_WateringCan") == true then
            u1:Start();

            return;
        end;

        warn("Watering Can UI not started: AB_rewarded_video_ad_WateringCan is not enabled for this player");
    end);

    return u1;
end;