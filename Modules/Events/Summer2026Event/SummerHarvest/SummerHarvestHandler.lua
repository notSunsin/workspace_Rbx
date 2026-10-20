-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local ContentProvider = game:GetService("ContentProvider");
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local Config = GameConfigController:GetConfig("SummerHarvestConfig");
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local CosmeticCrateOddsController = require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
local PetEggOddsController = require(ReplicatedStorage.Modules.PetEggOddsController);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local Trove = require(ReplicatedStorage.Modules.Trove);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Comma_Module);
local u1 = Trove.new();
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local SummerHarvestRemoteEvent = GameEvents.SummerHarvestRemoteEvent;
local SummerHarvestRewardRemoteEvent = GameEvents.SummerHarvestRewardRemoteEvent;
local SummerHarvestSubmitRemoteEvent = GameEvents.SummerHarvestSubmitRemoteEvent;
local SummerRewards_UI = Players.LocalPlayer.PlayerGui:WaitForChild("SummerRewards_UI");
local u2 = game.Workspace:FindFirstChildOfClass("Terrain");
local u3 = {};
local u4 = {};
local u5 = 0;
local u9 = {
    Crate = function(p6: string) -- Line: 42
        -- upvalues: CosmeticCrateOddsController (copy), SummerRewards_UI (copy)
        CosmeticCrateOddsController:Open(p6, SummerRewards_UI);
    end,

    ["Seed Pack"] = function(p7: string) -- Line: 45
        -- upvalues: SeedPackOddsController (copy), SummerRewards_UI (copy)
        SeedPackOddsController:Open(p7, SummerRewards_UI);
    end,

    Egg = function(p8: string) -- Line: 48
        -- upvalues: PetEggOddsController (copy), SummerRewards_UI (copy)
        PetEggOddsController:Open(p8, SummerRewards_UI);
    end
};
local u10 = false;
local u11 = false;
local u12 = 0;
local u13 = false;

local function Week2Active() -- Line: 63
    -- upvalues: u13 (ref)
    u13 = workspace:GetServerTimeNow() >= 1783801800;

    return u13;
end;

local function IsRewardAvailable(p14) -- Line: 70
    -- upvalues: u13 (ref)
    return (not p14.Week2 or u13) and true or false;
end;

local function buildRewardTrack() -- Line: 80
    -- upvalues: SummerRewards_UI (copy), Config (ref), u13 (ref), ItemImageFinder (copy), u9 (copy), ItemInfoHover (copy)
    local RewardScrollingFrame = SummerRewards_UI.Frame.RewardTrack.Holder.RewardScrollingFrame;

    for _, v in Config.RewardData do
        if (not v.Week2 or u13) and true or false then
            local ItemName = v.ItemName;
            local ItemType = v.ItemType;
            local v15 = v.ItemAmount or 1;

            if not RewardScrollingFrame:FindFirstChild((`{ItemType}_{ItemName}`)) then
                local v16 = RewardScrollingFrame.UIGridLayout.REWARDTRACK_TEMPLATE:Clone();
                local Frame = v16.Frame;
                Frame.ITEM_IMAGE.Image = ItemImageFinder(ItemName, ItemType);
                Frame.PointAmount.Text = "";
                Frame.Count.Text = v15 <= 1 and "" or "+" .. (v.ItemAmountFacingName or v15);

                if v.Week2 then
                    Frame.Chance.Text = "";
                else
                    Frame.Chance.Text = "";
                end;

                if u9[v.ItemType] then
                    Frame.OddsButton.Activated:Connect(function() -- Line: 113
                        -- upvalues: u9 (ref), ItemType (copy), ItemName (copy)
                        if u9[ItemType] then
                            u9[ItemType](ItemName);
                        end;
                    end);
                    Frame.OddsButton.Visible = true;
                end;

                local u17 = `SummerHarvestReward_{v.SummerPointsRequired}_{v.ItemType}_{v.ItemName}`;
                pcall(function() -- Line: 127
                    -- upvalues: ItemInfoHover (ref), u17 (copy), v (copy)
                    ItemInfoHover:AddItemFromRewardWithQuantity(u17, {
                        Value = v.ItemName,
                        Type = v.ItemType,
                        Quantity = v.ItemAmount or 1
                    });
                end);
                Frame:SetAttribute("UUID", u17);
                Frame:AddTag("ItemInfoHoverTag");
                v16.Name = `{ItemType}_{ItemName}`;
                v16.LayoutOrder = -v.SummerPointsRequired;
                v16.Parent = RewardScrollingFrame;
            end;
        end;
    end;
end;

function u3.Start(p18) -- Line: 144
    -- upvalues: GuiController (copy), SummerRewards_UI (copy), buildRewardTrack (copy), CollectionService (copy), u11 (ref), Config (ref), u4 (copy), u5 (ref), u13 (ref), ItemNameFinder (copy), ItemImageFinder (copy), ContentProvider (copy), SummerHarvestRemoteEvent (copy), u1 (copy), u12 (ref), u10 (ref), GameConfigController (copy), SummerHarvestSubmitRemoteEvent (copy), SummerHarvestRewardRemoteEvent (copy), CountDictionary (copy), u2 (copy)
    GuiController:UsePopupAnims(SummerRewards_UI);
    task.spawn(buildRewardTrack);
    local u19 = CollectionService:GetTagged("SummerHarvestModel")[1];
    local RewardSign = u19:WaitForChild("RewardSign");
    local RewardFrame = RewardSign:WaitForChild("RewardCycle"):WaitForChild("Attachment"):WaitForChild("BillboardGui"):WaitForChild("RewardFrame");
    local ITEM_IMAGE = RewardFrame:WaitForChild("ITEM_IMAGE");
    local Title = RewardFrame:WaitForChild("Title");
    local ChangesMade = u19:WaitForChild("ChangesMade");
    local u20 = CollectionService:GetTagged("SummerHarvestCart")[1];

    if not u20 then
        error("SummerHarvestHandler: Cannot find SummerHarvestCart");

        return;
    end;

    local u21 = {};

    for _, descendant in u20:WaitForChild("FruitLoad"):GetDescendants() do
        if descendant:IsA("Model") then
            u21[descendant.Name] = descendant;
        end;
    end;

    local Pivot = u20:GetPivot();
    local u22 = {};
    local u23 = Vector3.new(0, 0, 0);

    for i, v in u21 do
        local v24 = {};

        for _, descendant in v:GetDescendants() do
            if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                table.insert(v24, descendant);
            end;
        end;

        u22[i] = v24;
    end;

    for _, v in u22 do
        for _, v2 in v do
            v2.Transparency = 1;
            v2.CanCollide = false;
        end;
    end;

    local function AdjustSummerHarvestPoints() -- Line: 196
        -- upvalues: RewardSign (copy), u11 (ref), Config (ref)
        local v25 = workspace:GetAttribute("SummerHarvestPoints") or 0;
        local PointTextLabel = RewardSign:FindFirstChild("PointTextLabel", true);
        local RewardTextLabel = RewardSign:FindFirstChild("RewardTextLabel", true);

        if not (PointTextLabel and RewardTextLabel) then
            return;
        end;

        PointTextLabel.Text = `Harvest Points {math.floor(v25)}`;

        if not u11 then
            RewardTextLabel.Text = "Submit to get rewards!";

            return;
        end;

        for _, v in Config.REWARD_SIGN_THRESHOLDS do
            if v.Points <= v25 then
                RewardTextLabel.Text = v.Label;

                return;
            end;
        end;

        RewardTextLabel.Text = "No rewards yet!";
    end;

    local function buildRewardPreviewIcons() -- Line: 221
        -- upvalues: u4 (ref), u5 (ref), ITEM_IMAGE (copy), Config (ref), u13 (ref), ItemNameFinder (ref), ItemImageFinder (ref), RewardFrame (copy), ContentProvider (ref)
        for _, v in u4 do
            v:Destroy();
        end;

        table.clear(u4);
        u5 = 0;
        ITEM_IMAGE.Visible = false;

        for _, v in Config.RewardData or {} do
            if (not v.Week2 or u13) and true or false then
                local _ = v.Display or false;
                local ItemName = v.ItemName;
                local ItemType = v.ItemType;
                local _ = v.ItemAmount or 1;

                if v.Display ~= nil then
                    local v26 = ITEM_IMAGE:Clone();
                    v26.Name = "RewardPreviewIcon";
                    v26.Visible = false;
                    v26:SetAttribute("DisplayName", (ItemNameFinder(tostring(ItemName), ItemType)));
                    v26:SetAttribute("RewardValue", ItemName);
                    local v27 = tostring(ItemName);
                    local success, result = pcall(ItemImageFinder, v27, ItemType);

                    if success and result then
                        v26.Image = result;
                    end;

                    v26.Parent = RewardFrame;
                    table.insert(u4, v26);
                end;
            end;
        end;

        if #u4 > 0 then
            task.spawn(function() -- Line: 261
                -- upvalues: ContentProvider (ref), u4 (ref)
                pcall(function() -- Line: 262
                    -- upvalues: ContentProvider (ref), u4 (ref)
                    ContentProvider:PreloadAsync(u4);
                end);
            end);
        end;
    end;

    local function advanceRewardPreview() -- Line: 268
        -- upvalues: u4 (ref), u5 (ref), Title (copy)
        if #u4 == 0 then
            return;
        end;

        if u4[u5] then
            u4[u5].Visible = false;
        end;

        u5 = u5 + 1;

        if u5 > #u4 then
            u5 = 1;
        end;

        local v28 = u4[u5];
        v28.Visible = true;
        Title.Text = `{v28:GetAttribute("DisplayName")}`;
    end;

    local function ShakeCart(p29: number) -- Line: 286
        -- upvalues: u23 (ref), u20 (copy), Pivot (copy)
        local v30 = p29 or 0.2;
        local v31 = math.random(-100, 100) / 100 * v30;
        local v32 = math.random(-100, 100) / 100 * v30;
        u23 = Vector3.new(v31, v32);
        u20:PivotTo(Pivot + u23);
    end;

    u1:Add((u20:WaitForChild("PromptPart"):WaitForChild("SummerHarvestProxPrompt").Triggered:Connect(function() -- Line: 298
        -- upvalues: SummerHarvestRemoteEvent (ref)
        SummerHarvestRemoteEvent:FireServer("SubmitHeldPlant");
    end)));
    u1:Add((SummerRewards_UI.Frame.Exit.EXIT_BUTTON.Activated:Connect(function() -- Line: 305
        -- upvalues: GuiController (ref), SummerRewards_UI (ref)
        GuiController:Close(SummerRewards_UI);
    end)));

    if workspace:GetAttribute("SummerHarvest") then
        local PointTextLabel = RewardSign:FindFirstChild("PointTextLabel", true);
        local RewardTextLabel = RewardSign:FindFirstChild("RewardTextLabel", true);

        if PointTextLabel then
            PointTextLabel.Text = "Harvest Points 0";
        end;

        if RewardTextLabel then
            RewardTextLabel.Text = "NO REWARDS";
        end;

        ChangesMade.Parent = u19;
    else
        u11 = false;
        u12 = 0;
        AdjustSummerHarvestPoints();
        ChangesMade.Parent = script;
    end;

    u1:Add((task.spawn(function() -- Line: 325
        -- upvalues: u10 (ref), u23 (ref), u20 (copy), Pivot (copy)
        while true do
            repeat
                task.wait(0.1);
            until u10;

            local v33 = 0.1 or 0.2;
            local v34 = math.random(-100, 100) / 100 * v33;
            local v35 = math.random(-100, 100) / 100 * v33;
            u23 = Vector3.new(v34, v35);
            u20:PivotTo(Pivot + u23);
        end;
    end)));
    u1:Add((task.spawn(function() -- Line: 336
        -- upvalues: buildRewardPreviewIcons (copy), u4 (ref), u5 (ref), Title (copy), Config (ref)
        buildRewardPreviewIcons();

        if #u4 ~= 0 then
            if u4[u5] then
                u4[u5].Visible = false;
            end;

            u5 = u5 + 1;

            if u5 > #u4 then
                u5 = 1;
            end;

            local v36 = u4[u5];
            v36.Visible = true;
            Title.Text = `{v36:GetAttribute("DisplayName")}`;
        end;

        while true do
            repeat
                task.wait((math.max(Config.REWARD_CYCLE_INTERVAL or 5, 0.1)));
            until #u4 ~= 0;

            if u4[u5] then
                u4[u5].Visible = false;
            end;

            u5 = u5 + 1;

            if u5 > #u4 then
                u5 = 1;
            end;

            local v37 = u4[u5];
            v37.Visible = true;
            Title.Text = `{v37:GetAttribute("DisplayName")}`;
        end;
    end)));
    u1:Add((workspace:GetAttributeChangedSignal("SummerHarvestPoints"):Connect(function() -- Line: 350
        -- upvalues: AdjustSummerHarvestPoints (copy)
        AdjustSummerHarvestPoints();
    end)));
    u1:Add((workspace:GetAttributeChangedSignal("SummerHarvest"):Connect(function() -- Line: 356
        -- upvalues: RewardSign (copy), ChangesMade (copy), u19 (copy), u11 (ref), u12 (ref), AdjustSummerHarvestPoints (copy)
        if not workspace:GetAttribute("SummerHarvest") then
            u11 = false;
            u12 = 0;
            AdjustSummerHarvestPoints();
            ChangesMade.Parent = script;

            return;
        end;

        local PointTextLabel = RewardSign:FindFirstChild("PointTextLabel", true);
        local RewardTextLabel = RewardSign:FindFirstChild("RewardTextLabel", true);

        if PointTextLabel then
            PointTextLabel.Text = "Harvest Points 0";
        end;

        if RewardTextLabel then
            RewardTextLabel.Text = "NO REWARDS";
        end;

        ChangesMade.Parent = u19;
    end)));
    u1:Add((workspace:GetAttributeChangedSignal("SummerHarvestConfig"):Connect(function() -- Line: 375
        -- upvalues: Config (ref), GameConfigController (ref), buildRewardPreviewIcons (copy), buildRewardTrack (ref)
        Config = GameConfigController:GetConfig("SummerHarvestConfig");
        buildRewardPreviewIcons();
        buildRewardTrack();
    end)));
    u1:Add((SummerHarvestSubmitRemoteEvent.OnClientEvent:Connect(function(p38) -- Line: 383
        -- upvalues: u11 (ref), u12 (ref), u22 (copy), AdjustSummerHarvestPoints (copy)
        local v39 = u11 == false;
        u11 = true;

        for i = 1, p38 or 1 do
            u12 = u12 + 1;
            local v40 = u22[`{u12}`];
            local v41;

            if v40 then
                v41 = i;

                for _, v in v40 do
                    v.Transparency = 0;
                    v.CanCollide = true;
                end;
            else
                v41 = i;
            end;
        end;

        if v39 then
            AdjustSummerHarvestPoints();
        end;
    end)));
    u1:Add((SummerHarvestRewardRemoteEvent.OnClientEvent:Connect(function(u42: number) -- Line: 409
        -- upvalues: u10 (ref), CountDictionary (ref), u21 (copy), u22 (copy), u2 (ref), RewardSign (copy)
        u10 = true;
        task.spawn(function() -- Line: 411
            -- upvalues: CountDictionary (ref), u21 (ref), u42 (copy), u22 (ref), u2 (ref)
            local v43 = CountDictionary(u21);
            local v44 = v43 > 0 and (u42 / v43 or 0) or 0;

            for i = v43, 1, -1 do
                local v45 = u22[`{i}`];
                local v46;

                if v45 then
                    v46 = i;
                    local v47 = false;

                    for _, v in v45 do
                        if v.Transparency ~= 1 then
                            v.Transparency = 1;
                            v.CanCollide = false;
                            v47 = true;
                        end;
                    end;

                    if v47 then
                        local v48 = u2.PopEffect:Clone();
                        v48.Parent = workspace.Terrain;
                        v48.CFrame = CFrame.new(u21[`{v46}`]:GetPivot().Position);

                        for _, child in v48:GetChildren() do
                            child:Emit(1);
                        end;

                        game.Debris:AddItem(v48, 2);
                        task.wait(v44);
                    end;
                else
                    v46 = i;
                end;
            end;
        end);
        task.wait(u42);
        u10 = false;
        local PointTextLabel = RewardSign:FindFirstChild("PointTextLabel", true);
        local RewardTextLabel = RewardSign:FindFirstChild("RewardTextLabel", true);

        if PointTextLabel then
            PointTextLabel.Text = "Harvest Points 0";
        end;

        if RewardTextLabel then
            RewardTextLabel.Text = "NO REWARDS";
        end;
    end)));
end;

local u49 = false;
EventRotationController.EventUpdated:Connect(function(p50: string, p51: string) -- Line: 452, Name: OnEventUpdated
    -- upvalues: u1 (copy), u49 (ref), u3 (copy)
    if p51 ~= "Summer2026Event" then
        u1:Clean();
        u49 = false;

        return;
    end;

    if u49 then
        return;
    end;

    u49 = true;
    u1:Clean();
    task.spawn(u3.Start, u3);
end);

return u3;