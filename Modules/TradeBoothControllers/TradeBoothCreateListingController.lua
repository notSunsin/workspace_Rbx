-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Data.EnumRegistry.ReversedItemTypeEnums);
require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
require(ReplicatedStorage.Modules.TradeBoothControllers.TradeBoothInventoryController);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
require(ReplicatedStorage.Modules.ReplicationReciever);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local TradeBoothsData = require(ReplicatedStorage.Data.TradeBoothsData);
require(ReplicatedStorage.Data.TradeTokenData);
require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Modules.Observers);
require(ReplicatedStorage.Data.TradeData);
require(ReplicatedStorage.Modules.Signal);
require(ReplicatedStorage.Modules.Trove);
local TradeUIStaticData = require(ReplicatedStorage.Modules.TradeControllers.TradingUserInterfaceController.TradeUIStaticData);
local GGStaticData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
local TokenRAPController = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
local ItemRarityFinder = require(ReplicatedStorage.Modules.ItemRarityFinder);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.ConfirmationPromptController);
local Calculate_Weight = require(ReplicatedStorage.Calculate_Weight);
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local LocalPlayer = Players.LocalPlayer;
local TradeBoothCreateListing = LocalPlayer.PlayerGui:WaitForChild("TradeBoothCreateListing");
local TradeBoothInventory = LocalPlayer.PlayerGui:WaitForChild("TradeBoothInventory");
local TradeEvents = ReplicatedStorage.GameEvents.TradeEvents;
local u1 = nil;
local u2 = nil;
local v3 = {};
local u4 = nil;

function v3.PromptListItem(p5: table, u6: any, p7: userdata?) -- Line: 47
    -- upvalues: TradeWorldController (copy), TradeBoothInventory (copy), u4 (ref), TradeBoothCreateListing (copy), NumberUtil (copy), TradeBoothsData (copy), ItemNameFinder (copy), ItemImageFinder (copy), TokenRAPController (copy), ItemRarityFinder (copy), PetUtilities (copy), Calculate_Weight (copy), u1 (ref), u2 (ref), GGStaticData (copy)
    if not TradeWorldController:IsInWorld() then
        return false;
    end;

    if not p7 then
        return false;
    end;

    local RightSideFrame = TradeBoothInventory.Frame.RightSide.RightSideFrame;
    local table_clone_ret = table.clone(u6);
    u4 = table_clone_ret;
    local TextBox = RightSideFrame.Tokens.TextBox;
    local Amount = RightSideFrame.RAPValue.Amount;
    local Amount2 = TradeBoothCreateListing.Frame.Tokens.Amount;
    local Amount3 = TradeBoothCreateListing.Frame.Receive.Amount;
    local ITEM_IMAGE = TradeBoothCreateListing.Frame.Item.ITEM_IMAGE;
    local ITEM_NAME = TradeBoothCreateListing.Frame.Item.ITEM_NAME;
    local u8 = u6.data.Name or (u6.data.ItemName or u6.data.PetType or (u6.data.SkinID or "Unknown"));

    local function updateRAP(p9: number) -- Line: 81
        -- upvalues: u4 (ref), table_clone_ret (copy), Amount2 (copy), NumberUtil (ref), Amount3 (copy), TradeBoothsData (ref), ITEM_NAME (copy), ItemNameFinder (ref), u8 (copy), u6 (copy), ITEM_IMAGE (copy), ItemImageFinder (ref), TextBox (copy), Amount (copy)
        if u4 ~= table_clone_ret then
            return nil;
        end;

        table_clone_ret.listingPrice = p9;
        Amount2.Text = `{NumberUtil.FormatCompactPrice(table_clone_ret.listingPrice)}`;
        local FormatCompactPrice = NumberUtil.FormatCompactPrice;
        local v10 = TradeBoothsData.applyFee(table_clone_ret.listingPrice);
        Amount3.Text = `{FormatCompactPrice((math.floor(v10)))}`;
        ITEM_NAME.Text = `{ItemNameFinder(u8, u6.type)}`;
        ITEM_IMAGE.Image = ItemImageFinder(u8, u6.type);
        TextBox.PlaceholderText = NumberUtil.FormatCompactPrice(table_clone_ret.listingPrice);
        Amount.Text = `{NumberUtil.FormatCompactPrice(table_clone_ret.listingPrice)}`;
        TextBox.Text = "";

        return nil;
    end;

    local v11 = TokenRAPController:GetRAP(u6.type, u6.data) or 1;
    updateRAP(v11);

    if not v11 then
        task.defer(function() -- Line: 101
            -- upvalues: updateRAP (copy), TokenRAPController (ref), u6 (copy)
            updateRAP(TokenRAPController:GetRAPAsync(u6.type, u6.data) or 1);

            return nil;
        end);
    end;

    local Receive = RightSideFrame.Receive;
    Receive.Visible = true;
    local Amount4 = Receive.Amount;
    local FormatCompactPrice = NumberUtil.FormatCompactPrice;
    local v12 = TradeBoothsData.applyFee(table_clone_ret.listingPrice);
    Amount4.Text = `{FormatCompactPrice((math.floor(v12)))}`;
    ItemNameFinder(u8, u6.type);
    local v13 = ItemRarityFinder(u8, u6.type);
    local v14 = nil;

    if u6.data.PetType then
        v14 = string.format("%0.2fkg", PetUtilities:CalculateWeight(u6.data.PetData.BaseWeight, u6.data.PetData.Level));
    elseif u6.data.ItemName then
        v14 = string.format("%0.2fkg", (Calculate_Weight.Calculate_Weight(u6.data.Seed, u6.data.ItemName) or 0) * (u6.data.WeightMultiplier or 1));
    end;

    RightSideFrame.Desc.Text = `Weight: {v14 or "N/A"}\nRarity: {v13 or "N/A"}`;
    u1 = table_clone_ret;
    u2 = p7;
    local Item = RightSideFrame.Item;
    local ITEM_IMAGE2 = Item.ITEM_IMAGE;
    Item.ITEM_NAME.Text = ItemNameFinder(u8, u6.type);
    ITEM_IMAGE2.Image = ItemImageFinder(u8, u6.type);
    Item:SetAttribute("Rarity", v13);
    TradeBoothCreateListing.Frame.Item:SetAttribute("Rarity", v13);
    local v15 = GGStaticData.RarityColorMap[v13];

    if v15 then
        local v16 = GGStaticData.AnimatedColors[v13];

        if v16 then
            v16(Item);
            v16(TradeBoothCreateListing.Frame.Item);
        else
            Item.BackgroundColor3 = Color3.fromRGB(133, 82, 51):Lerp(v15, 0.75);
            TradeBoothCreateListing.Frame.Item.BackgroundColor3 = Color3.fromRGB(133, 82, 51):Lerp(v15, 0.75);
        end;
    else
        Item.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3);
        TradeBoothCreateListing.Frame.Item.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3);
    end;

    RightSideFrame.Visible = true;

    return true;
end;

function v3.Start(p17) -- Line: 158
    -- upvalues: TradeWorldController (copy), GuiController (copy), TradeBoothCreateListing (copy), u1 (ref), TradeBoothInventory (copy), TradeUIStaticData (copy), NumberUtil (copy), TradeBoothsData (copy), u2 (ref), TradeEvents (copy)
    if not TradeWorldController:IsInWorld() then
        return;
    end;

    GuiController:UsePopupAnims(TradeBoothCreateListing);
    GuiController:GetStateForGui(TradeBoothCreateListing).Visible:Listen(function(p18: boolean) -- Line: 165
        -- upvalues: u1 (ref)
        if p18 then
            return;
        end;

        if u1 then
            u1 = nil;
        end;
    end);
    local TextBox = TradeBoothInventory.Frame.RightSide.RightSideFrame.Tokens.TextBox;
    local Receive = TradeBoothInventory.Frame.RightSide.RightSideFrame.Receive;
    local Amount = TradeBoothCreateListing.Frame.Tokens.Amount;
    local Amount2 = TradeBoothCreateListing.Frame.Receive.Amount;

    local function updatePriceFromInput() -- Line: 180
        -- upvalues: u1 (ref), TradeUIStaticData (ref), TextBox (copy), NumberUtil (ref), Amount (copy), Receive (copy), TradeBoothsData (ref), Amount2 (copy)
        if not u1 then
            return;
        end;

        local Suffixes = TradeUIStaticData.Suffixes;
        local string_upper_ret = string.upper(TextBox.Text);

        if string_upper_ret == "" then
            string_upper_ret = TextBox.PlaceholderText;
        end;

        for i = #Suffixes, 1, -1 do
            local v19 = string.match(string_upper_ret, (`^([%d%.,]*)[{Suffixes[i]}]$`)) or "";
            local v20 = tonumber(v19);

            if v20 then
                string_upper_ret = tostring(v20 * 1000 ^ (#Suffixes - i + 1));
                break;
            end;

            local _ = i;
        end;

        local string_gsub_ret = string.gsub(string_upper_ret, "%D+", "");
        local v21 = tonumber(string_gsub_ret) or 1;
        local v22 = math.clamp(v21, 1, 100000000) or 1;
        u1.listingPrice = v22;
        TextBox.PlaceholderText = NumberUtil.Comma(v22);
        TextBox.Text = "";
        Amount.Text = `{NumberUtil.Comma(v22)}`;
        Receive.Visible = true;
        local Amount3 = Receive.Amount;
        local Comma = NumberUtil.Comma;
        local v23 = TradeBoothsData.applyFee(v22);
        Amount3.Text = `{Comma((math.floor(v23)))}`;
        local Comma2 = NumberUtil.Comma;
        local v24 = TradeBoothsData.applyFee(v22);
        Amount2.Text = `{Comma2((math.floor(v24)))}`;
    end;

    TextBox.FocusLost:Connect(function() -- Line: 213
        -- upvalues: updatePriceFromInput (copy)
        updatePriceFromInput();
    end);
    TradeBoothInventory.Frame.RightSide.RightSideFrame.Sell.Activated:Connect(function() -- Line: 217
        -- upvalues: u1 (ref), GuiController (ref), TradeBoothInventory (ref), TradeBoothCreateListing (ref)
        if u1 then
            GuiController:Close(TradeBoothInventory);
            GuiController:Open(TradeBoothCreateListing);

            return;
        end;

        GuiController:Close(TradeBoothInventory);
        TradeBoothInventory.Frame.RightSide.RightSideFrame.Visible = false;
    end);
    TradeBoothCreateListing.Frame.Options.Yes.Activated:Connect(function() -- Line: 235
        -- upvalues: u2 (ref), u1 (ref), GuiController (ref), TradeBoothCreateListing (ref), TradeEvents (ref)
        if u2 then
            u2 = nil;
        end;

        if u1 then
            if TradeEvents.Booths.CreateListing:InvokeServer(u1.type, u1.id, u1.listingPrice) then
                GuiController:Close(TradeBoothCreateListing);
            end;

            return;
        end;

        GuiController:Close(TradeBoothCreateListing);
    end);
    TradeBoothCreateListing.Frame.Close.Activated:Connect(function() -- Line: 253
        -- upvalues: GuiController (ref), TradeBoothCreateListing (ref), u1 (ref), u2 (ref)
        GuiController:Close(TradeBoothCreateListing);
        u1 = nil;

        if u2 then
            GuiController:Open(u2);
            u2 = nil;
        end;
    end);
    TradeBoothCreateListing.Frame.Options.No.Activated:Connect(function() -- Line: 263
        -- upvalues: GuiController (ref), TradeBoothCreateListing (ref), u1 (ref), u2 (ref)
        GuiController:Close(TradeBoothCreateListing);
        u1 = nil;

        if u2 then
            GuiController:Open(u2);
            u2 = nil;
        end;
    end);
end;

task.spawn(v3.Start, v3);

return v3;