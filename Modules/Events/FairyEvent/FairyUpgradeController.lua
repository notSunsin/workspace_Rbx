-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local FairyUpgradesData = require(ReplicatedStorage.Data.Events.FairyEvent.FairyUpgradesData);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local Item_Module = require(ReplicatedStorage.Item_Module);
local Spr = require(ReplicatedStorage.Code.Spr);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local Trove = require(ReplicatedStorage.Modules.Trove);
local u1 = Trove.new();
local Upgrade = ReplicatedStorage.GameEvents.Events.FairyEvent.Upgrade;
local FairyEventUpgrade_UI = Players.LocalPlayer.PlayerGui:WaitForChild("Events"):WaitForChild("FairyEvent"):WaitForChild("FairyEventUpgrade_UI");
local ScrollingFrame = FairyEventUpgrade_UI.Frame.Main.Holder.ScrollingFrame;
local u2 = {
    Common = 1,
    Uncommon = 2,
    Rare = 3,
    Legendary = 4,
    Mythical = 5,
    Divine = 6,
    Prismatic = 7,
    Transcendent = 8
};
local u3 = Trove.new();
local u4 = {};

local function GetTitle(p5: string) -- Line: 42
    -- upvalues: DataService (copy), FairyUpgradesData (copy), u2 (copy), Item_Module (copy)
    local Data = DataService:GetData();
    local v6 = FairyUpgradesData[p5];

    if p5 ~= "Fairy Quality" then
        return v6.Title or p5;
    end;

    if Data then
        Data = v6.Upgrades[Data.FairyEvent.Upgrades[p5] or 0];
    end;

    local v7;

    if Data then
        v7 = Data.Value;
    else
        v7 = FairyUpgradesData[p5].Default or 0;
    end;

    local v8 = "Common";

    for i, v in u2 do
        if v7 == v then
            v8 = i;
            break;
        end;
    end;

    local v9 = Item_Module.Return_Rarity_Data(v8);

    return `{v6.Title or p5} (Can target <font color="#{v9[2]:ToHex()}">{v8}</font> plants)`;
end;

function u4.Draw(p10) -- Line: 65
    -- upvalues: u3 (copy), DataService (copy), FairyUpgradesData (copy), ScrollingFrame (copy), GetTitle (copy), Comma_Module (copy), SetupButton (copy), Upgrade (copy), Spr (copy)
    u3:Clean();
    local Data = DataService:GetData();

    for i, v in FairyUpgradesData do
        local v11 = u3:Clone(ScrollingFrame.UIListLayout.TEMPLATE);
        v11.Name = i;
        local Main = v11.Main;
        local v12 = Data and (Data.FairyEvent.Upgrades[i] or 0) or 0;
        local v13 = GetTitle(i);
        Main.Header.TITLE.Text = v13;
        Main.Header.TITLE_SHADOW.Text = v13:gsub("<.->", "");
        local v14 = v.Upgrades[v12];
        local v15 = v.Upgrades[v12 + 1];
        local v16 = v.Display(v14 and v14.Value or (v.Default or 0));
        Main.Header.Display.VALUE.Text = v16;
        Main.Header.Display.VALUE_SHADOW.Text = v16;
        local v17 = v15 and Comma_Module.Comma((`{v15.Price}`)) or "MAX";
        Main.BUY_BUTTON.UPGRADE_PRICE.Text = v17;
        Main.BUY_BUTTON.UPGRADE_PRICE_SHADOW.Text = v17;
        Main.Bar.UIGradient.Offset = Vector2.new(math.lerp(-0.1, 0.9, v12 / #v.Upgrades) + 0.01, 0);
        local u18 = i;
        local v19 = v;

        for i2 = 1, #v.Upgrades do
            local v20 = u3:Clone(Main.Bar.UIListLayout.TEMPLATE);
            v20.Name = tostring(i2);
            v20.Size = UDim2.fromScale(1 / #v19.Upgrades - Main.Bar.UIListLayout.Padding.Scale, 1);
            local v21;

            if i2 <= v12 then
                v21 = Color3.fromRGB(48, 148, 128);
            else
                v21 = Color3.fromRGB(43, 13, 0);
            end;

            local v22;

            if i2 <= v12 then
                v22 = Color3.fromRGB(64, 202, 176);
            else
                v22 = Color3.fromRGB(133, 82, 51);
            end;

            v20.BackgroundColor3 = v22;

            for _, child in v20.Detail:GetChildren() do
                if child.Name == "Vignette" then
                    child.BackgroundColor3 = v21;
                end;
            end;

            v20.Detail.StrokeCorrection.UIStroke.Transparency = i2 <= v12 and 0 or 1;
            v20.Parent = Main.Bar;
        end;

        v11.Parent = ScrollingFrame;
        SetupButton({
            instance = Main.BUY_BUTTON.SENSOR,

            onclick = function() -- Line: 113, Name: onclick
                -- upvalues: Upgrade (ref), u18 (copy)
                Upgrade:FireServer(u18);
            end
        });
    end;

    local function UpdateDisplay() -- Line: 122
        -- upvalues: FairyUpgradesData (ref), ScrollingFrame (ref), Data (copy), GetTitle (ref), Comma_Module (ref), Spr (ref)
        for i, v in FairyUpgradesData do
            local v23 = ScrollingFrame:FindFirstChild(i);

            if v23 then
                local v24 = Data.FairyEvent.Upgrades[i] or 0;
                local Main = v23.Main;
                local v25 = v.Upgrades[v24];
                local v26 = v.Upgrades[v24 + 1];
                local v27 = GetTitle(i);
                Main.Header.TITLE.Text = v27;
                Main.Header.TITLE_SHADOW.Text = v27:gsub("<.->", "");
                local v28 = v.Display(v25 and v25.Value or (v.Default or 0));
                Main.Header.Display.VALUE.Text = v28;
                Main.Header.Display.VALUE_SHADOW.Text = v28;
                local v29 = v26 and Comma_Module.Comma((`{v26.Price}`)) or "MAX";
                Main.BUY_BUTTON.UPGRADE_PRICE.Text = v29;
                Main.BUY_BUTTON.UPGRADE_PRICE_SHADOW.Text = v29;
                Spr.target(Main.Bar.UIGradient, 1, 3, {
                    Offset = Vector2.new(math.lerp(-0.1, 0.9, v24 / #v.Upgrades) + 0.01, 0)
                });

                for i2 = 1, #v.Upgrades do
                    local v30 = Main.Bar:FindFirstChild((tostring(i2)));
                    local v31;

                    if i2 <= v24 then
                        v31 = Color3.fromRGB(48, 148, 128);
                    else
                        v31 = Color3.fromRGB(43, 13, 0);
                    end;

                    local target = Spr.target;
                    local v32 = {};
                    local v33;

                    if i2 <= v24 then
                        v33 = Color3.fromRGB(64, 202, 176);
                    else
                        v33 = Color3.fromRGB(133, 82, 51);
                    end;

                    v32.BackgroundColor3 = v33;
                    target(v30, 1, 3, v32);

                    for _, child in v30.Detail:GetChildren() do
                        if child.Name == "Vignette" then
                            Spr.target(child, 1, 3, {
                                BackgroundColor3 = v31
                            });
                        end;
                    end;

                    Spr.target(v30.Detail.StrokeCorrection.UIStroke, 1, 3, {
                        Transparency = i2 <= v24 and 0 or 1
                    });
                end;
            end;
        end;
    end;

    u3:Add(DataService:GetPathSignal("FairyEvent/Upgrades/@"):Connect(UpdateDisplay));
end;

function u4.Start(p34) -- Line: 174
    -- upvalues: GuiController (copy), FairyEventUpgrade_UI (copy), SetupButton (copy), u4 (copy), EventRotationController (copy), FairyUpgradesData (copy), u1 (copy)
    GuiController:UsePopupAnims(FairyEventUpgrade_UI);
    SetupButton({
        offset = 0.1,
        instance = FairyEventUpgrade_UI.Frame.Main.Header.Exit.SENSOR,

        onclick = function() -- Line: 180, Name: onclick
            -- upvalues: GuiController (ref), FairyEventUpgrade_UI (ref)
            GuiController:Close(FairyEventUpgrade_UI);
        end
    });
    u4:Draw();

    if EventRotationController:IsPastEventIDIndex(2) then
        local Upgrades = FairyUpgradesData["Loose Fairy Spawn Amount"].Upgrades;
        u1:Add(task.spawn(function() -- Line: 189
            -- upvalues: FairyUpgradesData (ref), Upgrades (copy), u4 (ref)
            while FairyUpgradesData["Loose Fairy Spawn Amount"].Upgrades == Upgrades do
                task.wait(1);
            end;

            u4:Draw();
        end));
    end;
end;

EventRotationClientBinder:Bind({
    EventSet = "FairyEvent",
    Script = script,

    OnStart = function() -- Line: 202, Name: OnStart
        -- upvalues: u4 (copy)
        task.spawn(u4.Start, u4);
    end,

    OnStop = function() -- Line: 203, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u4;