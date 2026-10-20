-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local Hud_UI = PlayerGui.Hud_UI;
local StarterPack_UI = PlayerGui.StarterPack_UI;
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local u7 = {
    _createVariant1 = function(p1) -- Line: 19, Name: _createVariant1
        -- upvalues: GuiController (copy), StarterPack_UI (copy), Hud_UI (copy), DevProductIds (copy), MarketController (copy), DataService (copy), NumberUtil (copy)
        local StateForGui = GuiController:GetStateForGui(StarterPack_UI);
        local Variant1 = StarterPack_UI.Frame.Variant1;
        Hud_UI.SideBtns.StarterPack.Button.Label.Text = "Starter Pack";
        Hud_UI.SideBtns.StarterPack.Button.PepperPack.Visible = false;
        Variant1.Buy.Activated:Connect(function() -- Line: 26
            -- upvalues: DevProductIds (ref), MarketController (ref)
            MarketController:PromptPurchase(DevProductIds.StarterPackVariant1.PurchaseID, Enum.InfoType.Product);
        end);
        Variant1.Close.Activated:Connect(function() -- Line: 31
            -- upvalues: GuiController (ref), StarterPack_UI (ref)
            GuiController:Close(StarterPack_UI);
        end);

        local function updateTimer() -- Line: 35
            -- upvalues: DataService (ref), NumberUtil (ref), Variant1 (copy), Hud_UI (ref), StateForGui (copy), GuiController (ref), StarterPack_UI (ref)
            local Data = DataService:GetData();

            if not Data then
                return;
            end;

            local Timer = Data.StarterPack.Timer;

            if Timer then
                local v2 = NumberUtil.compactFormat(Timer);
                Variant1.Timer.Text = `{v2} Left`;
                Hud_UI.SideBtns.StarterPack.Button.Timer.Text = `{v2} Left`;
            end;

            local v3;

            if Timer then
                v3 = Timer > 0;
            else
                v3 = Timer;
            end;

            Hud_UI.SideBtns.StarterPack.Visible = v3;

            if Timer and (Timer <= 0 and StateForGui.Visible:Get()) then
                GuiController:Close(StarterPack_UI);
            end;
        end;

        task.spawn(updateTimer);
        assert(DataService:GetPathSignal("StarterPack/@")):Connect(updateTimer);
    end,

    _createVariant2 = function(p4) -- Line: 59, Name: _createVariant2
        -- upvalues: DataService (copy), Hud_UI (copy), GuiController (copy), StarterPack_UI (copy), DevProductIds (copy), MarketController (copy), TimeHelper (copy), NumberUtil (copy)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        Hud_UI.SideBtns.StarterPack.Button.Label.Text = "Pepper Pack";
        Hud_UI.SideBtns.StarterPack.Button.PepperPack.Visible = true;
        local StateForGui = GuiController:GetStateForGui(StarterPack_UI);
        local Variant2 = StarterPack_UI.Frame.Variant2;
        Variant2.Buy.Activated:Connect(function() -- Line: 71
            -- upvalues: DevProductIds (ref), MarketController (ref)
            MarketController:PromptPurchase(DevProductIds.StarterPackVariant2.PurchaseID, Enum.InfoType.Product);
        end);
        Variant2.Close.Activated:Connect(function() -- Line: 76
            -- upvalues: GuiController (ref), StarterPack_UI (ref)
            GuiController:Close(StarterPack_UI);
        end);
        local _ = Data.StarterPack.Timer;

        local function v6() -- Line: 83
            -- upvalues: Data (copy), Variant2 (copy), TimeHelper (ref), Hud_UI (ref), NumberUtil (ref), StateForGui (copy), GuiController (ref), StarterPack_UI (ref)
            local Timer = Data.StarterPack.Timer;

            if Timer then
                Variant2.Timer.Text = `Expires in {TimeHelper:GenerateTextFromTime(Timer, false)}`;
                Variant2.Prog.Fill.Size = UDim2.fromScale(Timer / 420, 1);
                Hud_UI.SideBtns.StarterPack.Button.Timer.Text = `{NumberUtil.compactFormat(Timer)} Left`;
            end;

            local v5;

            if Timer then
                v5 = Timer > 0;
            else
                v5 = Timer;
            end;

            Hud_UI.SideBtns.StarterPack.Visible = v5;

            if Timer and (Timer <= 0 and StateForGui.Visible:Get()) then
                GuiController:Close(StarterPack_UI);
            end;
        end;

        task.spawn(v6);
        assert(DataService:GetPathSignal("StarterPack/@")):Connect(v6);
    end
};

function u7.Start(p8) -- Line: 108
    -- upvalues: GuiController (copy), StarterPack_UI (copy), LocalPlayer (copy), Players (copy), Hud_UI (copy), u7 (copy)
    GuiController:UsePopupAnims(StarterPack_UI);

    while LocalPlayer:GetAttribute("AB_StarterPack") == nil and LocalPlayer:IsDescendantOf(Players) do
        LocalPlayer:GetAttributeChangedSignal("AB_StarterPack"):Wait();
    end;

    if not LocalPlayer:IsDescendantOf(Players) then
        return;
    end;

    local v9 = LocalPlayer:GetAttribute("AB_StarterPack") or "Variant1";

    for _, child in StarterPack_UI.Frame:GetChildren() do
        if child:IsA("GuiObject") then
            child.Visible = child.Name == v9;
        end;
    end;

    Hud_UI.SideBtns.StarterPack.Button.Activated:Connect(function() -- Line: 129
        -- upvalues: GuiController (ref), StarterPack_UI (ref)
        GuiController:Open(StarterPack_UI);
    end);
    Hud_UI.SideBtns.StarterPack.Button.PepperPack.Activated:Connect(function() -- Line: 133
        -- upvalues: GuiController (ref), StarterPack_UI (ref)
        GuiController:Open(StarterPack_UI);
    end);

    if v9 == "Variant1" then
        u7:_createVariant1();

        return;
    end;

    u7:_createVariant2();
end;

task.spawn(u7.Start, u7);

return u7;