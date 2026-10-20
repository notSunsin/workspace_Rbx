-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GGStaticData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
local TradeItemHoverController = require(ReplicatedStorage.Modules.TradeControllers.TradeItemHoverController);
local TokenRAPController = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
require(ReplicatedStorage.Data.TradeData);
require(ReplicatedStorage.Modules.GardenGuideModules.VirtualListGridCellCreator.VListTypes);
local PlayClickSound = require(ReplicatedStorage.Modules.PlayClickSound);
local TokenRAPChartController = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPChartController);
local TradeFindSellerController = require(ReplicatedStorage.Modules.TradeControllers.TradeFindSellerController);
local ItemTemplate = ReplicatedStorage.Data.TradePlaza.IndexTemplates.ItemTemplate;
local RarityColorMap = GGStaticData.RarityColorMap;
local AnimatedColors = GGStaticData.AnimatedColors;
local Sections = Players.LocalPlayer.PlayerGui:WaitForChild("TradePlazaIndex").Frame.Sections;
local ItemsList = Sections.ItemsList;
local RAPHistory = Sections.RAPHistory;
local u1 = nil;
local u10 = {
    ToggleGGCellUI = function(p2, p3, p4) -- Line: 36, Name: ToggleGGCellUI
        local _ = p2.OBTAINED_IMAGE;
        local NewBanner = p2.NewBanner;
        local Cover = p2.Cover;
        local Mastery = p2.Mastery;
        local Attribute = p2:GetAttribute("Seen");
        p2.ITEM_NAME.Visible = Attribute;
        p2.ITEM_NAME_SHADOW.Visible = Attribute;
        Cover.Visible = not Attribute;
        local ITEM_IMAGE = p2.ITEM_IMAGE;
        local v5;

        if Attribute then
            v5 = Color3.fromRGB(255, 255, 255);
        else
            v5 = Color3.fromRGB(0, 0, 0);
        end;

        ITEM_IMAGE.ImageColor3 = v5;
        Mastery.Image = p2:GetAttribute("Mastered") and "rbxassetid://140518329666464" or "rbxassetid://99302990527020";
        local v6;

        if Attribute then
            v6 = p4.DataType == "Plant";
        else
            v6 = Attribute;
        end;

        Mastery.Visible = v6;

        if Attribute then
            NewBanner.Visible = p2:GetAttribute("New");

            return;
        end;

        NewBanner.Visible = false;
    end,

    RenderCell = function(p7, p8, p9) -- Line: 66, Name: RenderCell
        -- upvalues: RarityColorMap (copy), AnimatedColors (copy), TradeItemHoverController (copy)
        local DisplayName = p8.DisplayName;
        local Rarity = p8.Rarity;
        local ImageId = p8.ImageId;
        local RAPValue = p8.RAPValue;
        local Item = p8.Item;
        p7:SetAttribute("Name", DisplayName);
        p7:SetAttribute("Rarity", Rarity);
        p7:SetAttribute("ImageId", ImageId);
        p7:SetAttribute("RAPValue", RAPValue);
        p7.ITEM_NAME.Text = DisplayName;
        p7.ITEM_NAME_SHADOW.Text = DisplayName;
        p7.ITEM_IMAGE.Image = ImageId;
        p7.Name = DisplayName;

        if Rarity then
            if RarityColorMap[Rarity] then
                if AnimatedColors[Rarity] then
                    AnimatedColors[Rarity](p7);
                else
                    p7.BackgroundColor3 = Color3.fromRGB(133, 82, 51):Lerp(RarityColorMap[Rarity], 0.75);
                end;
            else
                p7.BackgroundColor3 = Color3.fromRGB(80, 80, 80);
            end;
        else
            p7.BackgroundColor3 = Color3.fromRGB(80, 80, 80);
        end;

        if Item then
            local id = p8.Item.id;
            local type = p8.Item.type;
            p7:SetAttribute("ItemID", id);
            p7:SetAttribute("ItemType", type);
            p7:SetAttribute("UUID", id);
            p7:AddTag("TradingUserInterfaceTargetable");
            TradeItemHoverController:AddItemToData(id, p8.Item);
        end;
    end
};

local function CreateRAPHistory(p11) -- Line: 108
    -- upvalues: Sections (copy), RAPHistory (copy), u1 (ref), RarityColorMap (copy), TokenRAPChartController (copy), PlayClickSound (copy), TradeFindSellerController (copy), ItemsList (copy)
    local Attribute = p11:GetAttribute("Name");
    local Attribute2 = p11:GetAttribute("ImageId");
    local Attribute3 = p11:GetAttribute("Rarity");
    local Attribute4 = p11:GetAttribute("ItemID");
    local Attribute5 = p11:GetAttribute("ItemType");
    local u12 = Sections:FindFirstChild((`{Attribute4}RAPHistory`)) or RAPHistory:Clone();
    u1 = u12;
    u12.Name = `{Attribute4}RAPHistory`;
    u12:SetAttribute("CurrentItem", Attribute);
    u12:SetAttribute("CurrentItemType", Attribute5);
    u12.Title.Text = `{Attribute}`;
    u12.ItemImg.Image = Attribute2;
    local RarityArea = u12.RarityArea;
    local v13;

    if Attribute3 then
        v13 = RarityColorMap[Attribute3];
    else
        v13 = Color3.fromRGB();
    end;

    RarityArea.BackgroundColor3 = v13;
    RarityArea.TextLabel.Text = not Attribute3 and "No Rarity" or `{Attribute3}`;
    local _ = u12.Price.Amount;
    TokenRAPChartController:Show(Attribute5, Attribute4, u12);
    u12.Parent = Sections;
    local u14 = u12.FindSellers.Activated:Connect(function() -- Line: 156
        -- upvalues: PlayClickSound (ref), u12 (ref), TradeFindSellerController (ref)
        PlayClickSound();
        local Attribute6 = u12:GetAttribute("CurrentItem");
        local Attribute7 = u12:GetAttribute("CurrentItemType");

        if Attribute6 and Attribute7 then
            TradeFindSellerController:Prompt(Attribute7, Attribute6);

            return;
        end;

        warn((`No current item attribute set: {Attribute6}`));
    end);
    local u15 = u12.Back.Activated:Connect(function() -- Line: 172
        -- upvalues: PlayClickSound (ref), u12 (ref), u1 (ref), ItemsList (ref)
        PlayClickSound();
        u12:Destroy();
        u1 = nil;
        ItemsList.Visible = true;
    end);
    u12.Destroying:Once(function() -- Line: 179
        -- upvalues: u15 (ref), u14 (ref)
        if u15 then
            u15:Disconnect();
        end;

        if u14 then
            u14:Disconnect();
        end;
    end);

    return u12;
end;

function u10.RemakeGridCell(p16, p17, p18, p19) -- Line: 192
    -- upvalues: TokenRAPController (copy), u10 (copy)
    local v20 = {
        DisplayName = p18.data.ItemName or "Unknown",
        Rarity = p18.data.Rarity,
        ImageId = p18.data.ImageId or "rbxassetid://6937742258",
        Item = p18,
        RAPValue = TokenRAPController:GetRAPById(p18.type, p18.id) or 0
    };
    u10.RenderCell(p16, v20, p19);
end;

function u10.CreateGridCell(p21: userdata, p22: any, p23: string, p24: any) -- Line: 206
    -- upvalues: ItemTemplate (copy), u10 (copy), PlayClickSound (copy), u1 (ref), CreateRAPHistory (copy), ItemsList (copy)
    local u25 = p24.ExistingCell or ItemTemplate:Clone();
    u10.RemakeGridCell(u25, p21, p22, p24);
    local u26 = u25.SENSOR.Activated:Connect(function() -- Line: 234
        -- upvalues: PlayClickSound (ref), u1 (ref), CreateRAPHistory (ref), u25 (copy), ItemsList (ref)
        PlayClickSound();

        if u1 then
            return;
        end;

        CreateRAPHistory(u25).Visible = true;
        ItemsList.Visible = false;
    end);
    u25.Destroying:Once(function() -- Line: 243
        -- upvalues: u26 (ref)
        if u26 then
            u26:Disconnect();
            u26 = nil;
        end;
    end);

    return u25;
end;

return u10;