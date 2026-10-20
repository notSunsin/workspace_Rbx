-- Decompiled with Potassium's decompiler.

local ContextActionService = game:GetService("ContextActionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GamepadService = game:GetService("GamepadService");
game:GetService("SoundService");
local Players = game:GetService("Players");
game:GetService("StarterGui");
local CollectionService = game:GetService("CollectionService");
local Signal = require(ReplicatedStorage.Modules.Signal);
require(ReplicatedStorage.Modules.FastTween);
local Frame_Popup_Module = require(ReplicatedStorage.Frame_Popup_Module);
local ClickOffClose = require(ReplicatedStorage.Modules.ClickOffClose);
local UITypes = require(ReplicatedStorage.Types.UITypes);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};

local function createStateValue(p6) -- Line: 53
    -- upvalues: Signal (copy)
    local u7 = Signal.new();
    local u8 = {
        _value = p6,
        _signal = u7
    };

    function u8.Get(p9) -- Line: 60
        -- upvalues: u8 (copy)
        return u8._value;
    end;

    function u8.Set(p10, p11) -- Line: 64
        -- upvalues: u8 (copy), u7 (copy)
        local _value = u8._value;
        u8._value = p11;
        u7:Fire(p11, _value);
    end;

    function u8.Listen(p12, p13) -- Line: 70
        -- upvalues: u7 (copy)
        return u7:Connect(p13);
    end;

    function u8.Observe(p14, p15) -- Line: 74
        -- upvalues: u8 (copy)
        local u16 = u8:Listen(p15);
        task.spawn(p15, p14:Get(), nil);

        return function() -- Line: 77
            -- upvalues: u16 (copy)
            u16:Disconnect();
        end;
    end;

    return u8;
end;

local function FetchUIGroupMembers(p17) -- Line: 85
    -- upvalues: CollectionService (copy), UITypes (copy)
    return CollectionService:GetTagged(UITypes.UIGROUP_TAG_PREFIX .. p17);
end;

local function FetchUIGroupHiders(p18) -- Line: 89
    -- upvalues: CollectionService (copy)
    return CollectionService:GetTagged("UIHidesGroup_" .. p18);
end;

local function IsAnyHiderActive(p19) -- Line: 96
    -- upvalues: CollectionService (copy), PlayerGui (copy)
    for _, v in CollectionService:GetTagged("UIHidesGroup_" .. p19) do
        if v:IsDescendantOf(PlayerGui) then
            if v:IsA("ScreenGui") then
                if v.Enabled then
                    return true;
                end;
            elseif v:IsA("GuiObject") and v.Visible then
                return true;
            end;
        end;
    end;

    return false;
end;

function GetStateForLayer(p20: string)
    -- upvalues: u2 (copy), createStateValue (copy)
    local v21 = u2[p20];

    if not v21 then
        v21 = {
            Gui = createStateValue(nil)
        };
        u2[p20] = v21;
    end;

    return v21;
end;

function GetLayerForGui(p22: userdata)
    return p22:GetAttribute("Layer") or "Menu";
end;

function u5.GetStateForGui(p23: table, p24: userdata) -- Line: 126
    -- upvalues: u1 (copy), createStateValue (copy)
    local v25 = u1[p24];

    if not v25 then
        v25 = {
            Visible = createStateValue(false),
            ChangeEnabled = createStateValue(true),
            CloseKeybinds = createStateValue({ Enum.KeyCode.ButtonB })
        };
        u1[p24] = v25;
    end;

    return v25;
end;

function u5.GetAllOpenGuis(p26) -- Line: 141
    -- upvalues: u2 (copy)
    local v27 = {};

    for _, v in u2 do
        local v28 = v.Gui:Get();

        if v28 then
            table.insert(v27, v28);
        end;
    end;

    return v27;
end;

function u5.Close(p29: table, p30: userdata) -- Line: 152
    -- upvalues: u5 (copy), GamepadService (copy), ClickOffClose (copy)
    local v31 = GetLayerForGui(p30);
    local v32 = GetStateForLayer(v31);
    local v33 = v32.Gui:Get();

    if v33 and v33 ~= p30 then
        return;
    end;

    local StateForGui = u5:GetStateForGui(p30);
    StateForGui.Visible:Set(false);
    v32.Gui:Set(nil);

    if StateForGui.ChangeEnabled:Get() then
        p30.Enabled = false;
        GamepadService:DisableGamepadCursor();
    end;

    ClickOffClose.RemoveGui(p30);
    u5:ShowHUD();
end;

function u5.Open(p34: table, p35: userdata) -- Line: 179
    -- upvalues: u5 (copy), GamepadService (copy), ClickOffClose (copy)
    local v36 = GetLayerForGui(p35);
    local v37 = GetStateForLayer(v36);
    local v38 = v37.Gui:Get();

    if v38 == p35 then
        return;
    end;

    if v38 then
        u5:Close(v38);
    end;

    local StateForGui = u5:GetStateForGui(p35);
    StateForGui.Visible:Set(true);
    v37.Gui:Set(p35);

    if StateForGui.ChangeEnabled:Get() then
        p35.Enabled = true;
        GamepadService:EnableGamepadCursor(p35:FindFirstChildWhichIsA("GuiObject", true));
    end;

    ClickOffClose.AddGui(p35);
end;

function u5.Toggle(p39: table, p40: userdata) -- Line: 202
    -- upvalues: u5 (copy)
    local StateForGui = u5:GetStateForGui(p40);

    if StateForGui.Visible:Get() then
        u5:Close(p40);
    else
        u5:Open(p40);
    end;

    return StateForGui.Visible:Get();
end;

function u5.UsePopupAnims(p41: table, u42: userdata) -- Line: 212
    -- upvalues: u5 (copy), Frame_Popup_Module (copy)
    if not (u42:FindFirstChild("Main") or (u42:FindFirstChild("Frame") or u42:FindFirstChild("MainFrame") or (u42:FindFirstChildWhichIsA("Frame") or u42:FindFirstChildWhichIsA("ImageLabel")))) then
        error((`No root frame found for {u42:GetFullName()}`));

        return;
    end;

    u42.Enabled = false;
    local StateForGui = u5:GetStateForGui(u42);
    StateForGui.ChangeEnabled:Set(true);
    StateForGui.Visible:Observe(function(p43) -- Line: 223
        -- upvalues: Frame_Popup_Module (ref), u42 (copy)
        if p43 then
            Frame_Popup_Module.Show(u42);

            return;
        end;

        Frame_Popup_Module.Hide(u42);
    end);
end;

local function SetMobileControlsVisible(p44: boolean) -- Line: 234
    -- upvalues: PlayerGui (copy)
    local TouchGui = PlayerGui:FindFirstChild("TouchGui");

    if TouchGui and TouchGui:IsA("ScreenGui") then
        TouchGui.Enabled = p44;
    end;
end;

function u5.SetUIGroupVisibility(p45: table, p46: any, p47: boolean) -- Line: 241
    -- upvalues: u3 (copy), UITypes (copy), PlayerGui (copy)
    for _, v in u3[p46] do
        v.Enabled = p47;
    end;

    if p46 == UITypes.UIGroups.HUD then
        local TouchGui = PlayerGui:FindFirstChild("TouchGui");

        if TouchGui and TouchGui:IsA("ScreenGui") then
            TouchGui.Enabled = p47;
        end;
    end;
end;

function u5.ShowHUD(p48) -- Line: 251
    -- upvalues: LocalPlayer (copy), u5 (copy), UITypes (copy), IsAnyHiderActive (copy)
    if LocalPlayer:GetAttribute("InWaspWaveSurvival") then
        return;
    end;

    u5:SetUIGroupVisibility(UITypes.UIGroups.HUD, not IsAnyHiderActive(UITypes.UIGroups.HUD));
end;

function u5.HideHUD(p49) -- Line: 257
    -- upvalues: LocalPlayer (copy), u5 (copy), UITypes (copy)
    if LocalPlayer:GetAttribute("InWaspWaveSurvival") then
        return;
    end;

    u5:SetUIGroupVisibility(UITypes.UIGroups.HUD, false);
end;

local function InitUIGroup(p50) -- Line: 263
    -- upvalues: u3 (copy), CollectionService (copy), UITypes (copy)
    u3[p50] = CollectionService:GetTagged(UITypes.UIGROUP_TAG_PREFIX .. p50);
end;

local function InitUIGroups() -- Line: 267
    -- upvalues: UITypes (copy), u3 (copy), CollectionService (copy), PlayerGui (copy)
    for _, v in UITypes.UIGROUPS_TRACKED do
        u3[v] = CollectionService:GetTagged(UITypes.UIGROUP_TAG_PREFIX .. v);
    end;

    local BackpackGui = PlayerGui:WaitForChild("BackpackGui", 10);

    if BackpackGui then
        table.insert(u3[UITypes.UIGroups.HUD], BackpackGui);
    end;
end;

local function InitUIGroupHiders() -- Line: 285
    -- upvalues: u4 (copy), UITypes (copy), CollectionService (copy), u5 (copy), IsAnyHiderActive (copy)
    for _, v in u4 do
        v:Disconnect();
    end;

    table.clear(u4);

    for _, v in UITypes.UIGROUPS_TRACKED do
        local u51 = v;

        for _, v2 in CollectionService:GetTagged("UIHidesGroup_" .. v) do
            if v2:IsA("ScreenGui") then
                local v52 = v2:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 295
                    -- upvalues: u5 (ref), u51 (copy), IsAnyHiderActive (ref)
                    u5:SetUIGroupVisibility(u51, not IsAnyHiderActive(u51));
                end);
                table.insert(u4, v52);
            elseif v2:IsA("GuiObject") then
                local v53 = v2:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 300
                    -- upvalues: u5 (ref), u51 (copy), IsAnyHiderActive (ref)
                    u5:SetUIGroupVisibility(u51, not IsAnyHiderActive(u51));
                end);
                table.insert(u4, v53);
            end;
        end;
    end;
end;

function u5.Start(p54) -- Line: 309
    -- upvalues: InitUIGroups (copy), InitUIGroupHiders (copy), u5 (copy), ContextActionService (copy)
    InitUIGroups();
    InitUIGroupHiders();
    local v55 = GetStateForLayer("Menu");
    local u56 = nil;
    v55.Gui:Observe(function(u57: userdata?) -- Line: 316
        -- upvalues: u56 (ref), u5 (ref), ContextActionService (ref)
        if u56 then
            task.spawn(u56);
        end;

        if u57 then
            local u62 = u5:GetStateForGui(u57).CloseKeybinds:Observe(function(p58: table) -- Line: 323
                -- upvalues: ContextActionService (ref), u5 (ref), u57 (copy)
                ContextActionService:UnbindAction("UICloseButton");
                ContextActionService:BindAction("UICloseButton", function(p59: any, p60: any, p61: userdata) -- Line: 326
                    -- upvalues: u5 (ref), u57 (ref)
                    if p60 ~= Enum.UserInputState.End then
                        return Enum.ContextActionResult.Pass;
                    end;

                    u5:Close(u57);

                    return Enum.ContextActionResult.Sink;
                end, false, table.unpack(p58));
            end);

            u56 = function() -- Line: 336
                -- upvalues: u62 (copy), ContextActionService (ref)
                u62();
                ContextActionService:UnbindAction("UICloseButton");
            end;
        end;
    end);
end;

task.spawn(u5.Start, u5);

return u5;