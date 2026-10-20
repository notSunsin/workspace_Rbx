-- Decompiled with Potassium's decompiler.

local u1 = {};
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local CosmeticMutableStats = require(ReplicatedStorage.Data.CosmeticRegistry.CosmeticMutableStats);
local CosmeticUpgradeService = require(ReplicatedStorage.Modules.CosmeticServices.CosmeticUpgradeService);
require(ReplicatedStorage.Modules.CosmeticServices.CosmeticService);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local UseDynamicPrices = require(ReplicatedStorage.Modules.UseDynamicPrices);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local CosmeticProducts = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Shop_UI").Frame:WaitForChild("ScrollingFrame"):WaitForChild("CosmeticProducts");
local List = CosmeticProducts.List;
local Template = List.Template;

function u1.GenerateCosmeticUpgrades(p2) -- Line: 28
    -- upvalues: CosmeticMutableStats (copy), Template (copy), NumberUtil (copy), CosmeticUpgradeService (copy), UseDynamicPrices (copy), MarketController (copy), Comma_Module (copy), TweenService (copy), DataService (copy), List (copy), CosmeticProducts (copy)
    local v3 = false;

    for i, v in CosmeticMutableStats do
        if v.UpgradeData.Enabled then
            v3 = true;
            local v4 = Template:Clone();
            v4.Visible = true;
            local SHECKLES_TEXT = v4:FindFirstChild("SHECKLES_TEXT", true);
            local ROBUX_TEXT = v4:FindFirstChild("ROBUX_TEXT", true);
            local EXTRA_TEXT = v4:FindFirstChild("EXTRA_TEXT", true);
            local UPGRADE_TEXT = v4:FindFirstChild("UPGRADE_TEXT", true);
            local INCREMENT_TEXT = v4:FindFirstChild("INCREMENT_TEXT", true);
            local u5 = false;

            local function UpdateData() -- Line: 45
                -- upvalues: NumberUtil (ref), CosmeticUpgradeService (ref), i (copy), v (copy), SHECKLES_TEXT (copy), EXTRA_TEXT (copy), UPGRADE_TEXT (copy), INCREMENT_TEXT (copy), u5 (ref), ROBUX_TEXT (copy), UseDynamicPrices (ref), MarketController (ref), Comma_Module (ref), TweenService (ref)
                local v6 = NumberUtil.DisplaySheckles(CosmeticUpgradeService:GetUpgradePrice(i, CosmeticUpgradeService:GetUpgradeLevel(i)));
                local FallbackPrice = v.UpgradeData.FallbackPrice;
                SHECKLES_TEXT.Text = `{v6}`;
                local UpgradeLevel = CosmeticUpgradeService:GetUpgradeLevel(i);
                local MaxUpgrade = v.UpgradeData.MaxUpgrade;
                EXTRA_TEXT.Text = `{UpgradeLevel}/{MaxUpgrade} Extra!`;
                UPGRADE_TEXT.Text = v.Text;
                INCREMENT_TEXT.Text = `+{v.UpgradeData.Increment}`;
                u5 = MaxUpgrade <= UpgradeLevel;
                SHECKLES_TEXT.Visible = not u5;

                if u5 then
                    ROBUX_TEXT.Text = "MAX";
                elseif UseDynamicPrices or FallbackPrice == nil then
                    if not UseDynamicPrices then
                        warn((`{ROBUX_TEXT:GetFullName()} is using Dynamic Pricing because there is no Fallback Price set`));
                    end;

                    MarketController:SetPriceLabel(ROBUX_TEXT, v.UpgradeData.ProductId, ":robux: :value:");
                else
                    ROBUX_TEXT.Text = `{utf8.char(57346)} {Comma_Module.Comma(FallbackPrice)}`;
                end;

                local TweenInfo_new_ret = TweenInfo.new(0.4);
                local v7 = {};
                local v8;

                if u5 then
                    v8 = UDim2.fromScale(0.65, 0.9);
                else
                    v8 = UDim2.fromScale(0.5, 0.9);
                end;

                v7.Size = v8;
                TweenService:Create(ROBUX_TEXT, TweenInfo_new_ret, v7):Play();
            end;

            v4.LayoutOrder = v.LayoutOrder;
            UpdateData();
            DataService:GetPathSignal((`CosmeticData/MutableStats/{i}`)):Connect(function() -- Line: 85
                -- upvalues: UpdateData (copy)
                UpdateData();
            end);
            SHECKLES_TEXT.MouseButton1Click:Connect(function() -- Line: 89
                -- upvalues: u5 (ref), UpdateData (copy), CosmeticUpgradeService (ref), i (copy)
                if u5 then
                    return;
                end;

                UpdateData();
                CosmeticUpgradeService:Upgrade(i);
            end);
            ROBUX_TEXT.MouseButton1Click:Connect(function() -- Line: 95
                -- upvalues: u5 (ref), UpdateData (copy), MarketController (ref), v (copy)
                if u5 then
                    return;
                end;

                UpdateData();
                MarketController:PromptPurchase(v.UpgradeData.ProductId, Enum.InfoType.Product);
            end);
            v4.Parent = List;
        end;
    end;

    CosmeticProducts.Visible = v3;
end;

task.delay(1, function() -- Line: 107
    -- upvalues: u1 (copy)
    u1:GenerateCosmeticUpgrades();
end);

return u1;