-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local GuiService = game:GetService("GuiService");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Modules.TradeControllers.TradingController);
local TradeUIItemRenderers = require(ReplicatedStorage.Modules.TradeControllers.TradingUserInterfaceController.TradeUIItemRenderers);
local IsMouseOverUI = require(ReplicatedStorage.Modules.IsMouseOverUI);
local PlayerGui = Players.LocalPlayer.PlayerGui;
PlayerGui:WaitForChild("TradingUI");
local TradeItemHover = PlayerGui:WaitForChild("TradeItemHover").TradeItemHover;
local v1 = {};
local Stats = TradeItemHover.CanvasGroup.Main.Stats;
local u2 = 0;
local u3 = 0;
local u4 = false;
local u5 = false;
local u6 = nil;
local u7 = false;
local u8 = 0;
local u9 = {};

local function GetBestHover() -- Line: 41
    -- upvalues: UserInputService (copy), GuiService (copy), IsMouseOverUI (copy), PlayerGui (copy)
    local v10 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
    local v11 = nil;

    for _, v in IsMouseOverUI.GetGuiObjectsAtPosition(v10.X, v10.Y) do
        if v:IsDescendantOf(PlayerGui) and (v:HasTag("TradingUserInterfaceTargetable") and (v10 - v.AbsolutePosition).Magnitude < (1 / 0)) then
            v11 = v;
        end;
    end;

    return v11;
end;

function v1.AddItemToData(p12, p13, p14) -- Line: 68
    -- upvalues: u9 (ref)
    u9[p13] = p14;
end;

function v1.ClearItemsData(p15) -- Line: 72
    -- upvalues: u9 (ref)
    table.clear(u9);
    u9 = {};
end;

RunService.RenderStepped:Connect(function(p16) -- Line: 77
    -- upvalues: u9 (ref), UserInputService (copy), GuiService (copy), TradeItemHover (copy), GetBestHover (copy), u2 (ref), u6 (ref), u4 (ref), u3 (ref), u5 (ref), Stats (copy), u8 (ref), TweenService (copy), u7 (ref), TradeUIItemRenderers (copy)
    if next(u9) == nil then
        return;
    end;

    local v17 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
    TradeItemHover.Position = UDim2.fromOffset(v17.X, v17.Y);
    local v18 = GetBestHover();
    u2 = (u6 ~= v18 or v18 == nil) and 0 or math.clamp(u2 + p16, 0, 0.2);
    u6 = v18;
    u4 = u2 >= 0.2;

    if u4 then
        u3 = math.clamp(u3 + p16, 0, 1);
    end;

    u5 = u3 >= 1;

    if Stats.AbsoluteCanvasSize.Y >= Stats.AbsoluteWindowSize.Y and u5 then
        u8 = u8 + Stats.AbsoluteCanvasSize.Y / 25 * p16;
        local v19 = u8 % Stats.AbsoluteCanvasSize.Y;
        TweenService:Create(Stats, TweenInfo.new(0.1), {
            CanvasPosition = Vector2.new(0, v19)
        }):Play();
    end;

    if u4 == u7 then
        return;
    end;

    u8 = 0;
    u3 = 0;
    u7 = u4;
    TradeUIItemRenderers.CleanUpAllSegments();

    if v18 then
        v18 = v18:GetAttribute("UUID");
    end;

    local v20 = u9[v18];
    local v21 = v20 and TradeUIItemRenderers.ItemRenderers[v20.type];

    if v21 then
        v21(v20);
        local _ = #Stats:GetChildren() <= 2;
    end;

    TweenService:Create(TradeItemHover.CanvasGroup, TweenInfo.new(0.1), {
        GroupTransparency = u4 and 0 or 1
    }):Play();
end);

return v1;