-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local GuiService = game:GetService("GuiService");
local TweenService = game:GetService("TweenService");
local script_ItemInfoRenderers = require(script.ItemInfoRenderers);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemRarityFinder = require(ReplicatedStorage.Modules.ItemRarityFinder);
local ItemDescriptionFinder = require(ReplicatedStorage.Modules.ItemDescriptionFinder);
local CommaFormatNumber = require(ReplicatedStorage.Modules.CommaFormatNumber);
local IsMouseOverUI = require(ReplicatedStorage.Modules.IsMouseOverUI);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local ItemHoverFrame = PlayerGui:WaitForChild("ItemHover").ItemHoverFrame;
local DetailsSFrame = ItemHoverFrame.CanvasGroup.Main.DetailsSFrame;
local DetailsSFrame2 = ItemHoverFrame.CanvasGroup.Main.DescDetails.DetailsSFrame;
local u1 = 0;
local u2 = 0;
local u3 = false;
local u4 = false;
local u5 = nil;
local u6 = false;
local u7 = nil;
local u8 = 0;
local u9 = nil;
local u10 = {};
local u11 = {};

local function GetBestHover() -- Line: 53
    -- upvalues: UserInputService (copy), GuiService (copy), IsMouseOverUI (copy), PlayerGui (copy)
    local v12 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
    local v13 = (1 / 0);
    local v14 = nil;

    for _, v in IsMouseOverUI.GetGuiObjectsAtPosition(v12.X, v12.Y) do
        if v:IsDescendantOf(PlayerGui) and v:HasTag("ItemInfoHoverTag") then
            local Magnitude = (v12 - (v.AbsolutePosition + v.AbsoluteSize / 2)).Magnitude;

            if v13 > Magnitude then
                v14 = v;
                v13 = Magnitude;
            end;
        end;
    end;

    return v14;
end;

local function NormalizeItemData(p15: string, p16: string) -- Line: 79
    local v17 = p15:match("^Egg/(.+)$");

    if v17 then
        return v17, "Egg";
    end;

    return p15, p16;
end;

local function ensureSeedSuffix(p18: string) -- Line: 88
    local v19 = p18:match("^%s*(.-)%s*$");

    if v19:lower():match("%sseed$") then
        return v19;
    end;

    return `{v19} Seed`;
end;

function u11.AddItemToData(p20: table, p21: string, p22: any) -- Line: 103
    -- upvalues: u10 (ref)
    u10[p21] = p22;
end;

function u11.RemoveItemFromData(p23: table, p24: string) -- Line: 108
    -- upvalues: u10 (ref)
    if u10[p24] then
        u10[p24] = nil;
    end;
end;

function u11.ClearItemsData(p25) -- Line: 115
    -- upvalues: u10 (ref)
    table.clear(u10);
    u10 = {};
end;

function u11.AddRewardTable(p26: table, p27: string, p28: table) -- Line: 120
    -- upvalues: u11 (copy), ItemNameFinder (copy), ItemDescriptionFinder (copy), ItemImageFinder (copy), ItemRarityFinder (copy)
    for _, v in p28 do
        if v.Type and v.Value then
            local v29 = tostring(v.Value);
            local Type = v.Type;
            local v30 = v29:match("^Egg/(.+)$");

            if v30 then
                Type = "Egg";
            else
                v30 = v29;
            end;

            u11:AddItemToData(`{p27}_{v.Type}_{v.Value}`, {
                DescriptionOnly = true,
                DisplayName = ItemNameFinder(v30, Type),
                Description = ItemDescriptionFinder(v30, Type),
                ItemImage = ItemImageFinder(v30, Type),
                Properties = {
                    Rarity = v.RarityOverride or ItemRarityFinder(v30, Type)
                }
            });
        else
            warn((`ItemInfoHover | {p27} has given a nil reward table entry!`));
        end;
    end;
end;

function u11.RemoveRewardTable(p31: table, p32: string, p33: table?) -- Line: 143
    -- upvalues: u11 (copy), u10 (ref)
    if p33 then
        for _, v in p33 do
            u11:RemoveItemFromData((`{p32}_{v.Type}_{v.Value}`));
        end;

        return;
    end;

    for i, _ in u10 do
        if string.find(i, p32) then
            u11:RemoveItemFromData(i);
        end;
    end;
end;

function u11.AddItemFromRewardWithQuantity(p34: table, p35: string, p36: any) -- Line: 164
    -- upvalues: ItemNameFinder (copy), CommaFormatNumber (copy), u11 (copy), ItemDescriptionFinder (copy), ItemImageFinder (copy), ItemRarityFinder (copy)
    local v37 = tostring(p36.Value);
    local Type = p36.Type;
    local v38 = v37:match("^Egg/(.+)$");

    if v38 then
        Type = "Egg";
    else
        v38 = v37;
    end;

    local v39 = tonumber(p36.Quantity) or 1;
    local v40 = ItemNameFinder(v38, Type);

    if Type == "Seed" then
        v40 = v40:match("^%s*(.-)%s*$");

        if not v40:lower():match("%sseed$") then
            v40 = `{v40} Seed`;
        end;
    end;

    if v39 > 0 then
        v40 = `{v40} x{CommaFormatNumber(v39)}`;
    end;

    u11:AddItemToData(p35, {
        DescriptionOnly = true,
        DisplayName = v40,
        Description = ItemDescriptionFinder(v38, Type),
        ItemImage = ItemImageFinder(v38, Type),
        Properties = {
            Rarity = p36.RarityOverride or ItemRarityFinder(v38, Type),
            Quantity = v39
        }
    });
end;

local function GetScaleTarget(p41: userdata) -- Line: 188
    local CanvasGroup = p41:FindFirstChild("CanvasGroup", true);

    if CanvasGroup and CanvasGroup:IsA("GuiObject") then
        return CanvasGroup;
    end;

    local ShopItem_Image = p41:FindFirstChild("ShopItem_Image", true);

    if ShopItem_Image and ShopItem_Image:IsA("GuiObject") then
        return ShopItem_Image;
    end;

    return p41:FindFirstChildWhichIsA("ImageLabel", true) or p41;
end;

RunService.RenderStepped:Connect(function(p42: number) -- Line: 206
    -- upvalues: UserInputService (copy), GuiService (copy), ItemHoverFrame (copy), GetBestHover (copy), u5 (ref), u1 (ref), u9 (ref), GetScaleTarget (copy), TweenService (copy), u3 (ref), u2 (ref), u4 (ref), DetailsSFrame (copy), u8 (ref), DetailsSFrame2 (copy), u7 (ref), u6 (ref), script_ItemInfoRenderers (copy), u10 (ref)
    if UserInputService.TouchEnabled and UserInputService:GetLastInputType() == Enum.UserInputType.Touch then
        return;
    end;

    local v43 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
    ItemHoverFrame.Position = UDim2.fromOffset(v43.X, v43.Y);
    local v44 = GetBestHover();

    if u5 and (v44 and u5 == v44) then
        u1 = math.clamp(u1 + p42, 0, 0.2);
    else
        u1 = 0;
    end;

    u5 = v44;

    if not UserInputService.TouchEnabled and v44 ~= u9 then
        if u9 then
            local ItemInfoHoverScale = GetScaleTarget(u9):FindFirstChild("ItemInfoHoverScale");

            if ItemInfoHoverScale and ItemInfoHoverScale:IsA("UIScale") then
                TweenService:Create(ItemInfoHoverScale, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
                    Scale = 1
                }):Play();
            end;
        end;

        if v44 and not v44:GetAttribute("NoScale") then
            local v45 = GetScaleTarget(v44);
            local ItemInfoHoverScale = v45:FindFirstChild("ItemInfoHoverScale");

            if not ItemInfoHoverScale then
                ItemInfoHoverScale = Instance.new("UIScale");
                ItemInfoHoverScale.Name = "ItemInfoHoverScale";
                ItemInfoHoverScale.Scale = 1;
                ItemInfoHoverScale.Parent = v45;
            end;

            if ItemInfoHoverScale and ItemInfoHoverScale:IsA("UIScale") then
                TweenService:Create(ItemInfoHoverScale, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
                    Scale = 1.2
                }):Play();
            end;
        end;

        u9 = v44;
    end;

    u3 = u1 >= 0.2;

    if u3 then
        u2 = math.clamp(u2 + p42, 0, 1);
    end;

    u4 = u2 >= 1;

    if DetailsSFrame.AbsoluteCanvasSize.Y >= DetailsSFrame.AbsoluteWindowSize.Y and u4 then
        u8 = u8 + DetailsSFrame.AbsoluteCanvasSize.Y / 25 * p42;
        local v46 = u8 % DetailsSFrame.AbsoluteCanvasSize.Y;
        TweenService:Create(DetailsSFrame, TweenInfo.new(0.1), {
            CanvasPosition = Vector2.new(0, v46)
        }):Play();
        TweenService:Create(DetailsSFrame2, TweenInfo.new(0.1), {
            CanvasPosition = Vector2.new(0, v46)
        }):Play();
    end;

    if v44 then
        v44 = v44:GetAttribute("UUID");
    end;

    if u7 == v44 and u3 == u6 then
        return;
    end;

    u8 = 0;
    u2 = 0;
    u6 = u3;
    u7 = v44;
    script_ItemInfoRenderers:CleanupAllSegments();
    local v47 = u10[v44];

    if v47 then
        script_ItemInfoRenderers:RenderInfo(v47);
    end;

    TweenService:Create(ItemHoverFrame.CanvasGroup, TweenInfo.new(0.1), {
        GroupTransparency = u3 and 0 or 1
    }):Play();
end);

return u11;