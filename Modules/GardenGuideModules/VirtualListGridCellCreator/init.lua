-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GGStaticData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
require(ReplicatedStorage.Modules.TradePlaza.TradePlazaUtils);
require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
require(ReplicatedStorage.Modules.TradeTokens.TokenRAPUtil);
require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.TradeControllers.TradeItemHoverController);
require(ReplicatedStorage.Modules.TradeTokens.TokenRAPChartController);
local TokenRAPController = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
require(ReplicatedStorage.Data.TradeData);
local script_VListDataProcessors = require(script.VListDataProcessors);
local script_VListCellRenderers = require(script.VListCellRenderers);
local script_VListCellFunctionality = require(script.VListCellFunctionality);
require(script.VListTypes);
local _ = Players.LocalPlayer.PlayerGui.TradeBoothInventory;
local ItemTemplate = ReplicatedStorage.Data.TradePlaza.IndexTemplates.ItemTemplate;
local _ = GGStaticData.RarityColorMap;
local _ = GGStaticData.AnimatedColors;
local u1 = {};

return {
    CreateGridCell = function(u2: any, p3: userdata, u4: string, u5: any) -- Line: 35, Name: CreateGridCell
        -- upvalues: script_VListDataProcessors (copy), ItemTemplate (copy), script_VListCellRenderers (copy), TokenRAPController (copy), u1 (copy), script_VListCellFunctionality (copy)
        local v6 = script_VListDataProcessors[u4];

        if v6 then
            local u7 = v6(u2);
            local u8 = u5.ExistingCell or ItemTemplate:Clone();
            script_VListCellRenderers.RenderCell(u8, u7, u5);
            local u9;

            if u7.RAPValue and u7.RAPValue ~= 0 or u4 == "GardenGuide" then
                u9 = nil;
            else
                local RAPById = TokenRAPController:GetRAPById(u2.type, u2.id);
                u9 = task.defer(function() -- Line: 58
                    -- upvalues: RAPById (ref), TokenRAPController (ref), u2 (copy), u8 (copy)
                    while not RAPById do
                        RAPById = TokenRAPController:GetRAPByIdAsync(u2.type, u2.id);
                        task.wait(0.5);
                    end;

                    if RAPById and u8:IsDescendantOf(game) then
                        u8:SetAttribute("RAPValue", RAPById);
                    end;

                    return nil;
                end);
            end;

            if not u1[u8] then
                u1[u8] = u8.SENSOR.Activated:Connect(function() -- Line: 73
                    -- upvalues: script_VListCellFunctionality (ref), u4 (copy), u8 (copy), u7 (copy), u5 (copy)
                    script_VListCellFunctionality[u4](u8, u7, u5);
                end);
                u8.Destroying:Once(function() -- Line: 78
                    -- upvalues: u9 (ref), u1 (ref), u8 (copy)
                    if u9 then
                        task.cancel(u9);
                    end;

                    u1[u8]:Disconnect();
                    u1[u8] = nil;
                end);
            end;

            return u8;
        end;

        warn((`No processor for {u4}`));
    end
};