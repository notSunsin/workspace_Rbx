-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local GuiService = game:GetService("GuiService");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
require(ReplicatedStorage.Modules.ItemNameFinder);
require(ReplicatedStorage.Modules.ItemImageFinder);
require(ReplicatedStorage.Modules.ItemRarityFinder);
require(ReplicatedStorage.Modules.ItemDescriptionFinder);
require(ReplicatedStorage.Modules.CommaFormatNumber);
local IsMouseOverUI = require(ReplicatedStorage.Modules.IsMouseOverUI);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local HoverFrame = PlayerGui:WaitForChild("TextHover").HoverFrame;
local DescLabel = HoverFrame.CanvasGroup.Main.Description.DescLabel;
local u1 = 0;
local u2 = 0;
local u3 = false;
local u4 = false;
local u5 = nil;
local u6 = false;
local u7 = nil;
local u8 = 0;
local u9 = nil;
local u10 = nil;

local function GetBestHover() -- Line: 49
    -- upvalues: UserInputService (copy), GuiService (copy), IsMouseOverUI (copy), PlayerGui (copy)
    local v11 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
    local v12 = nil;

    for _, v in IsMouseOverUI.GetGuiObjectsAtPosition(v11.X, v11.Y) do
        if v:IsDescendantOf(PlayerGui) and (v:HasTag("TextHoverTag") and (v11 - v.AbsolutePosition).Magnitude < (1 / 0)) then
            v12 = v;
        end;
    end;

    return v12;
end;

RunService.RenderStepped:Connect(function(p13: number) -- Line: 75
    -- upvalues: UserInputService (copy), GuiService (copy), HoverFrame (copy), GetBestHover (copy), u5 (ref), u1 (ref), u9 (ref), u10 (ref), TweenService (copy), u3 (ref), u2 (ref), u4 (ref), u7 (ref), u6 (ref), u8 (ref), DescLabel (copy)
    if UserInputService.TouchEnabled and UserInputService:GetLastInputType() == Enum.UserInputType.Touch then
        return;
    end;

    local v14 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
    HoverFrame.Position = UDim2.fromOffset(v14.X, v14.Y);
    local v15 = GetBestHover();

    if u5 and (v15 and u5 == v15) then
        u1 = math.clamp(u1 + p13, 0, 0.2);
    else
        u1 = 0;
    end;

    u5 = v15;

    if not UserInputService.TouchEnabled and v15 ~= u9 then
        if u9 and u10 then
            TweenService:Create(u9, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
                Size = u10
            }):Play();
        end;

        if v15 then
            u10 = v15.Size;
            TweenService:Create(v15, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
                Size = UDim2.new(v15.Size.X.Scale * 1.1, v15.Size.X.Offset, v15.Size.Y.Scale * 1.1, v15.Size.Y.Offset)
            }):Play();
        end;

        u9 = v15;
    end;

    u3 = u1 >= 0.2;

    if u3 then
        u2 = math.clamp(u2 + p13, 0, 1);
    end;

    u4 = u2 >= 1;

    if v15 then
        v15 = v15:GetAttribute("HoverText");
    end;

    if u7 == v15 and u3 == u6 then
        return;
    end;

    u8 = 0;
    u2 = 0;
    u6 = u3;
    u7 = v15;

    if v15 and #v15 > 0 then
        DescLabel.Text = `{v15}`;
    else
        DescLabel.Text = "Nothing to see here.";
    end;

    TweenService:Create(HoverFrame.CanvasGroup, TweenInfo.new(0.1), {
        GroupTransparency = u3 and 0 or 1
    }):Play();
end);

return {};