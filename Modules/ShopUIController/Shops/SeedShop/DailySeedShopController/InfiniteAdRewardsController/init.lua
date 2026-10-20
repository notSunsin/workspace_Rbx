-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AdService = game:GetService("AdService");
local Players = game:GetService("Players");
local DataService = require(ReplicatedStorage.Modules.DataService);
local EventInfinitePackData = require(ReplicatedStorage.Data.EventInfinitePackData);
require(ReplicatedStorage.Data.InfinitePackData);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
require(ReplicatedStorage.Modules.UseDynamicPrices);
require(ReplicatedStorage.Modules.MarketController);
require(ReplicatedStorage.Comma_Module);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local ImageCycle = require(ReplicatedStorage.Modules.GardenGuideModules.ImageCycle);
local InfinitePackDataAdRewards1 = require(ReplicatedStorage.Data.InfinitePackDataAdRewards1);
local InfinitePackDataAdRewards1_B = require(ReplicatedStorage.Data.InfinitePackDataAdRewards1_B);
local AdRewardsClaim = ReplicatedStorage.GameEvents.InfinitePack.AdRewardsClaim;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local LogEvent = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("AdRewardEvents"):WaitForChild("LogEvent");
local Daily = PlayerGui:WaitForChild("Seed_Shop"):WaitForChild("Daily");
local u1 = game.GameId == 7436755782 and 822732857916245 or 881866492201934;
local u2 = {};
local u3 = false;
local u4 = false;
local u5 = false;
local u6 = {
    Enum.AdAvailabilityResult.PlayerIneligible,
    Enum.AdAvailabilityResult.DeviceIneligible,
    Enum.AdAvailabilityResult.PublisherIneligible,
    Enum.AdAvailabilityResult.ExperienceIneligible
};

local function getRewardPack() -- Line: 53
    -- upvalues: LocalPlayer (copy), InfinitePackDataAdRewards1 (copy), InfinitePackDataAdRewards1_B (copy)
    if LocalPlayer:GetAttribute("AB_rewarded_video_ad_DailyDealsInf") == true then
        return InfinitePackDataAdRewards1;
    end;

    return InfinitePackDataAdRewards1_B;
end;

local function getRewardPackSuffix() -- Line: 61
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetAttribute("AB_rewarded_video_ad_DailyDealsInf") == true and "_A" or "_B";
end;

local function isIneligible(p7) -- Line: 69
    -- upvalues: u6 (copy)
    for _, v in ipairs(u6) do
        if p7 == v then
            return true;
        end;
    end;

    return false;
end;

local function Darken(p8, p9: number) -- Line: 79
    local v10, v11, v12 = p8:ToHSV();

    return Color3.fromHSV(v10, v11, (math.clamp(v12 / p9, 0, 1)));
end;

function checkForAds()
    -- upvalues: u5 (ref), AdService (copy), u3 (ref), u6 (copy), u4 (ref)
    if u5 then
        return;
    end;

    local success, result = pcall(function() -- Line: 89
        -- upvalues: AdService (ref)
        return AdService:GetAdAvailabilityNowAsync(Enum.AdFormat.RewardedVideo);
    end);

    if success and result.AdAvailabilityResult == Enum.AdAvailabilityResult.IsAvailable then
        u3 = true;
    else
        u3 = false;
    end;

    local AdAvailabilityResult = result.AdAvailabilityResult;
    local v13 = false;

    for _, v in ipairs(u6) do
        if AdAvailabilityResult == v then
            v13 = true;
            break;
        end;
    end;

    if v13 then
        u4 = false;

        return;
    end;

    u4 = true;
    print("(Daily Deals) Eligible for Daily Deals Ad Services");
end;

local function InitialiseInfinitePack(p14: string) -- Line: 107
    -- upvalues: Daily (copy), LocalPlayer (copy), LogEvent (copy), DataService (copy), InfinitePackDataAdRewards1 (copy), InfinitePackDataAdRewards1_B (copy), Players (copy), FastTween (copy), u5 (ref), u3 (ref), u4 (ref), ReplicatedStorage (copy), ItemImageFinder (copy), ItemNameFinder (copy), GiveServiceCommon (copy), AdService (copy), u1 (copy), AdRewardsClaim (copy), NumberUtil (copy), EventInfinitePackData (copy), ImageCycle (copy)
    local InfiniteAdRewards = Daily.ScrollingFrame.InfiniteAdRewards;
    InfiniteAdRewards.Visible = true;
    LogEvent:FireServer({
        value = 1,
        eventName = "DailyAdRewardScrollerRegistered" .. (LocalPlayer:GetAttribute("AB_rewarded_video_ad_DailyDealsInf") == true and "_A" or "_B"),
        fields = {
            playerId = LocalPlayer.UserId,
            playerName = LocalPlayer.Name
        }
    });
    local Holder = InfiniteAdRewards.INF.Holder;
    local Template = Holder.Template;
    local u15 = nil;
    local NumberValue = Instance.new("NumberValue");

    local function updatePosition(p16: userdata, p17: number) -- Line: 131
        p16.Position = UDim2.fromScale((p17 - 1) * 0.38, 0);
    end;

    local function generate() -- Line: 135
        -- upvalues: DataService (ref), LocalPlayer (ref), InfinitePackDataAdRewards1 (ref), InfinitePackDataAdRewards1_B (ref), Players (ref), FastTween (ref), NumberValue (copy), Holder (copy), Template (copy), u5 (ref), u3 (ref), u4 (ref), LogEvent (ref), ReplicatedStorage (ref), ItemImageFinder (ref), ItemNameFinder (ref), GiveServiceCommon (ref), AdService (ref), u1 (ref)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        local u18;

        if LocalPlayer:GetAttribute("AB_rewarded_video_ad_DailyDealsInf") == true then
            u18 = InfinitePackDataAdRewards1;
        else
            u18 = InfinitePackDataAdRewards1_B;
        end;

        local Depth = Data.InfinitePack_AdRewards2.Depth;
        local RewardsAsync = u18.GetRewardsAsync(Players.LocalPlayer, Data.InfinitePack_AdRewards2.Day, Depth + 5);
        FastTween(NumberValue, TweenInfo.new(0.2), {
            Value = Depth
        });

        for _, child in Holder:GetChildren() do
            local v19 = tonumber(child.Name);

            if v19 and v19 <= Depth then
                task.delay(0.2, function() -- Line: 157
                    -- upvalues: child (copy)
                    child:Destroy();
                end);
            end;
        end;

        for i = math.max(#RewardsAsync - 5 + 1, 1), #RewardsAsync do
            local v20 = RewardsAsync[i];
            local u21 = Holder:FindFirstChild((tostring(i)));

            if not u21 then
                u21 = Template:Clone();
                u21.Name = tostring(i);
                u21.Position = UDim2.fromScale((i - 1) * 0.38, 0);
                u21.LayoutOrder = i;
                u21.ZIndex = #RewardsAsync - i;
                u21.Position = UDim2.fromScale((i - 1) * 0.38, 0);
                u21.Visible = true;
                u21.CLAIM_BUTTON.SENSOR.Activated:Connect(function() -- Line: 181
                    -- upvalues: u5 (ref), Data (ref), DataService (ref), i (copy), u3 (ref), u4 (ref), LocalPlayer (ref), LogEvent (ref), ReplicatedStorage (ref)
                    if u5 == true then
                        return;
                    end;

                    Data = DataService:GetData();

                    if Data.InfinitePack_AdRewards2.Depth + 1 ~= i then
                        return;
                    end;

                    checkForAds();

                    if u3 and u4 then
                        u3 = false;
                        u5 = true;
                        LogEvent:FireServer({
                            value = 1,
                            eventName = "InfiniteAdRewardsClaimAttempt" .. (LocalPlayer:GetAttribute("AB_rewarded_video_ad_DailyDealsInf") == true and "_A" or "_B"),
                            fields = {
                                playerId = LocalPlayer.UserId,
                                playerName = LocalPlayer.Name,
                                slotIndex = i,
                                totalClaimsBefore = Data.InfinitePack_AdRewards2.Depth
                            }
                        });
                        ReplicatedStorage.GameEvents.InfinitePack.AdRewardsClaim:FireServer();
                    end;
                end);

                if v20 then
                    local v22 = v20.Rewards[1];
                    u21.IMAGE_CONTAINER.ITEM_IMAGE.Image = ItemImageFinder(v22.RewardName, v22.Type);
                    local v23 = `{ItemNameFinder(v22.RewardName, v22.Type) or v22.RewardName}{v22.Amount <= 1 and "" or ` x{v22.Amount}`}`;
                    u21.IMAGE_CONTAINER.RewardName.Text = v23;
                    local RarityColor = GiveServiceCommon:GetRarityColor({
                        Type = v22.Type,
                        Value = v22.RewardName or "Normal",
                        Quantity = v22.Amount or 1
                    });
                    local v24 = RarityColor or Color3.fromRGB(127, 127, 127);
                    local IMAGE_CONTAINER = u21.IMAGE_CONTAINER;
                    local v25, v26, v27 = RarityColor:ToHSV();
                    IMAGE_CONTAINER.BackgroundColor3 = Color3.fromHSV(v25, v26, (math.clamp(v27 / 1.3, 0, 1)));
                    local RewardName = u21.IMAGE_CONTAINER.RewardName;
                    local v28, v29, v30 = v24:ToHSV();
                    RewardName.TextStrokeColor3 = Color3.fromHSV(v28, v29, (math.clamp(v30 / 3, 0, 1)));
                end;

                u21.Parent = Holder;
                local task_spawn_ret = task.spawn(function() -- Line: 239
                    -- upvalues: u18 (copy), u21 (copy)
                    local _ = u18.FallbackPrices[0];
                    u21.CLAIM_BUTTON.CLAIM.Text = "Watch";
                    u21.CLAIM_BUTTON.CLAIM_BUTTON.Text = "Watch";
                end);
                u21.Destroying:Once(function() -- Line: 265
                    -- upvalues: task_spawn_ret (copy)
                    if coroutine.status(task_spawn_ret) == "suspended" then
                        pcall(task.cancel, task_spawn_ret);
                    end;
                end);
            end;

            u21.ZIndex = #RewardsAsync - i;

            if i == Data.InfinitePack_AdRewards2.Depth + 1 then
                u21.CLAIM_BUTTON.Visible = true;
                u21.CLAIM_BUTTON_DISABLED.Visible = false;
                pcall(function() -- Line: 282
                    -- upvalues: AdService (ref), u21 (ref), u1 (ref)
                    AdService:RegisterAdOpportunityAsync(u21.CLAIM_BUTTON.SENSOR, u1);
                end);
            else
                u21.CLAIM_BUTTON.Visible = false;
                u21.CLAIM_BUTTON_DISABLED.Visible = true;
            end;

            local _ = i;
        end;
    end;

    local function updatePadding() -- Line: 292
        -- upvalues: Holder (copy), NumberValue (copy)
        Holder.Position = UDim2.fromScale(-0.38 * NumberValue.Value, 0);
    end;

    local u31 = nil;

    local function updateOffsets() -- Line: 297
        -- upvalues: u31 (ref), Holder (copy), NumberValue (copy)
        if u31 and coroutine.status(u31) == "suspended" then
            task.cancel(u31);
        end;

        u31 = task.delay(0.1, function() -- Line: 302
            -- upvalues: Holder (ref), NumberValue (ref), u31 (ref)
            Holder.Position = UDim2.fromScale(-0.38 * NumberValue.Value, 0);

            for _, child in Holder:GetChildren() do
                local v32 = tonumber(child.Name);

                if v32 then
                    child.Position = UDim2.fromScale((v32 - 1) * 0.38, 0);
                end;
            end;

            u31 = nil;
        end);
    end;

    local function reconcile() -- Line: 316
        -- upvalues: DataService (ref), u15 (ref), Holder (copy), generate (copy)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        local Day = Data.InfinitePack_AdRewards2.Day;

        if u15 == Day then
            return;
        end;

        for _, child in Holder:GetChildren() do
            if child:IsA("GuiObject") and tonumber(child.Name) then
                child:Destroy();
            end;
        end;

        u15 = Day;
        generate();
    end;

    NumberValue.Changed:Connect(updatePadding);
    task.spawn(updatePadding);
    Holder:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateOffsets);
    task.spawn(updateOffsets);
    task.spawn(function() -- Line: 344
        -- upvalues: reconcile (copy), DataService (ref), generate (copy)
        task.spawn(reconcile);
        assert(DataService:GetPathSignal("InfinitePack_AdRewards2/@")):Connect(function() -- Line: 347
            -- upvalues: reconcile (ref), generate (ref)
            reconcile();
            generate();
        end);
    end);
    AdRewardsClaim.OnClientEvent:Connect(function(p33: boolean, p34: number?) -- Line: 353
        -- upvalues: DataService (ref), LocalPlayer (ref), InfinitePackDataAdRewards1 (ref), InfinitePackDataAdRewards1_B (ref), Players (ref), LogEvent (ref), u5 (ref)
        if p33 then
            print("Infinite Ad Reward claim success");
            local Data = DataService:GetData();

            if not Data then
                return;
            end;

            local v35;

            if LocalPlayer:GetAttribute("AB_rewarded_video_ad_DailyDealsInf") == true then
                v35 = InfinitePackDataAdRewards1;
            else
                v35 = InfinitePackDataAdRewards1_B;
            end;

            local v36 = p34 or Data.InfinitePack_AdRewards2.Depth;
            local RewardsAsync = v35.GetRewardsAsync(Players.LocalPlayer, Data.InfinitePack_AdRewards2.Day, v36);

            if RewardsAsync then
                RewardsAsync = RewardsAsync[#RewardsAsync];
            end;

            local v37 = RewardsAsync and RewardsAsync.Rewards and RewardsAsync.Rewards[1];
            LogEvent:FireServer({
                value = 1,
                eventName = "InfiniteAdRewardsClaimResult" .. (LocalPlayer:GetAttribute("AB_rewarded_video_ad_DailyDealsInf") == true and "_A" or "_B"),
                fields = {
                    wasSuccessful = true,
                    playerId = LocalPlayer.UserId,
                    playerName = LocalPlayer.Name,
                    slotIndex = v36,
                    totalClaimsAfter = v36,
                    itemName = v37 and v37.RewardName or nil
                }
            });
        else
            print("Infinite Ad Reward claim failed");
            local Data = DataService:GetData();
            local v38 = Data and Data.InfinitePack_AdRewards2.Depth or nil;
            LogEvent:FireServer({
                value = 1,
                eventName = "InfiniteAdRewardsClaimResult" .. (LocalPlayer:GetAttribute("AB_rewarded_video_ad_DailyDealsInf") == true and "_A" or "_B"),
                fields = {
                    wasSuccessful = false,
                    playerId = LocalPlayer.UserId,
                    playerName = LocalPlayer.Name,
                    totalClaimsAfter = v38
                }
            });
        end;

        wait(1);
        u5 = false;
    end);
    task.spawn(function() -- Line: 413
        -- upvalues: NumberUtil (ref), InfiniteAdRewards (copy), u3 (ref), u4 (ref)
        local v39 = 0;

        while true do
            local ServerTimeNow = workspace:GetServerTimeNow();
            local v40 = NumberUtil.compactFormat((ServerTimeNow // 86400 + 1) * 86400 - ServerTimeNow);
            InfiniteAdRewards.Header.Timer.Text = v40;
            InfiniteAdRewards.Header.Timer.TimerShadow.Text = v40;
            task.wait(1);
            v39 = v39 + 1;

            if v39 >= 20 and (u3 == false and u4 == true) then
                checkForAds();
                v39 = 0;
            end;

            if u4 == false then
                InfiniteAdRewards.Visible = false;

                return;
            end;
        end;
    end);
    local AdPackRewards = InfiniteAdRewards.PossibleRewardsContainer:FindFirstChild("AdPackRewards");
    local REWARD_IMAGE = AdPackRewards.REWARD_IMAGE;
    AdPackRewards.Visible = false;
    local v41 = {};
    local v42;

    if LocalPlayer:GetAttribute("AB_rewarded_video_ad_DailyDealsInf") == true then
        v42 = InfinitePackDataAdRewards1;
    else
        v42 = InfinitePackDataAdRewards1_B;
    end;

    local Rewards = v42.Rewards;

    if p14 ~= "DEFAULT" then
        Rewards = EventInfinitePackData.Rewards;
    end;

    if not Rewards then
        warn("Current Infinite Pack Type [packRewards] does not exist!");

        return;
    end;

    for _, v in Rewards.Free do
        if v.Type then
            if REWARD_IMAGE then
                table.insert(v41, {
                    Type = v.Type,
                    Value = v.RewardName or "Normal",
                    Quantity = v.Amount or 1
                });
            end;
        else
            warn("No reward type");
        end;
    end;

    for _, v in Rewards.Paid do
        if v.Type then
            if REWARD_IMAGE then
                table.insert(v41, {
                    Type = v.Type,
                    Value = v.RewardName or "Normal",
                    Quantity = v.Amount or 1
                });
            end;
        else
            warn("No reward type");
        end;
    end;

    ImageCycle.CycleRewardImages(REWARD_IMAGE, AdPackRewards.ITEM_NAME.REWARD_NAME, AdPackRewards.ITEM_NAME.REWARD_NAME_SHADOW, AdPackRewards, v41);
    AdPackRewards.Visible = true;
end;

function u2.Start(p43) -- Line: 504
    -- upvalues: u4 (ref), InitialiseInfinitePack (copy)
    checkForAds();

    if u4 then
        InitialiseInfinitePack("DEFAULT");

        return;
    end;

    warn("Daily Infinite Ad Rewards not started: player is not eligible for AdService");
end;

task.spawn(function() -- Line: 515
    -- upvalues: u2 (copy)
    if script.RobloxAdServiceTesting.Value ~= true then
        print("Daily Infinite Ad Rewards Controller Disabled");

        return;
    end;

    wait(35);
    u2:Start();
end);

return u2;