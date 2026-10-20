-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GGStaticData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
require(script.Parent.VListTypes);
local TradeItemHoverController = require(ReplicatedStorage.Modules.TradeControllers.TradeItemHoverController);
local _ = ReplicatedStorage.Data.TradePlaza.IndexTemplates.ItemTemplate;
local RarityColorMap = GGStaticData.RarityColorMap;
local AnimatedColors = GGStaticData.AnimatedColors;
local u6 = {
    ToggleGGCellUI = function(p1, p2, p3) -- Line: 17, Name: ToggleGGCellUI
        local _ = p1.OBTAINED_IMAGE;
        local NewBanner = p1.NewBanner;
        local Cover = p1.Cover;
        local Mastery = p1.Mastery;
        local Attribute = p1:GetAttribute("Seen");
        p1.ITEM_NAME.Visible = Attribute;
        p1.ITEM_NAME_SHADOW.Visible = Attribute;
        Cover.Visible = not Attribute;
        local ITEM_IMAGE = p1.ITEM_IMAGE;
        local v4;

        if Attribute then
            v4 = Color3.fromRGB(255, 255, 255);
        else
            v4 = Color3.fromRGB(0, 0, 0);
        end;

        ITEM_IMAGE.ImageColor3 = v4;
        Mastery.Image = p1:GetAttribute("Mastered") and "rbxassetid://140518329666464" or "rbxassetid://99302990527020";
        local v5;

        if Attribute then
            v5 = p3.DataType == "Plant";
        else
            v5 = Attribute;
        end;

        Mastery.Visible = v5;

        if Attribute then
            NewBanner.Visible = p1:GetAttribute("New");

            return;
        end;

        NewBanner.Visible = false;
    end
};

function u6.RenderCell(p7, p8, p9) -- Line: 46
    -- upvalues: RarityColorMap (copy), AnimatedColors (copy), TradeItemHoverController (copy), u6 (copy)
    local DisplayName = p8.DisplayName;
    local Rarity = p8.Rarity;
    local New = p8.New;
    local Seen = p8.Seen;
    local Source = p8.Source;
    local Mastered = p8.Mastered;
    local Traits = p8.Traits;
    local Color = p8.Color;
    local ImageId = p8.ImageId;
    local RAPValue = p8.RAPValue;
    local Item = p8.Item;
    p7:SetAttribute("Name", DisplayName);
    p7:SetAttribute("Rarity", Rarity);
    p7:SetAttribute("ImageId", ImageId);
    p7:SetAttribute("RAPValue", RAPValue);
    p7:SetAttribute("DetailsId", DisplayName);
    p7:SetAttribute("New", New);
    p7:SetAttribute("Seen", Seen);
    p7:SetAttribute("Event", Source);
    p7:SetAttribute("Mastered", Mastered);
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

    if Traits then
        p7:SetAttribute("Traits", (Traits:gsub("<[^>]->", "")));
    end;

    if Color then
        p7.BackgroundColor3 = Color3.fromRGB(133, 82, 51):Lerp(p8.Color, 0.75);
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

    if p9 then
        if p9.DataType then
            u6.ToggleGGCellUI(p7, p8, p9);

            return;
        end;

        if p7:FindFirstChild("OBTAINED_IMAGE") then
            p7.OBTAINED_IMAGE:Destroy();
            p7.NewBanner:Destroy();
            p7.Cover:Destroy();
            p7.Mastery:Destroy();
        end;
    end;
end;

return u6;