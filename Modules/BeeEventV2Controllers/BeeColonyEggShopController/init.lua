-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ContentProvider = game:GetService("ContentProvider");
local CollectionService = game:GetService("CollectionService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local BeeEggRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEggRegistry);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local RaycastClickDetectorService = require(ReplicatedStorage.Modules.RaycastClickDetectorService);
require(ReplicatedStorage.Modules.GeneralTargettingService);
local Trove = require(ReplicatedStorage.Modules.Trove);
local script_Config = require(script.Config);
local EggInfoFader = require(ReplicatedStorage.Modules.BeeEventV2Controllers.EggInfoFader);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local BeeEggs = ReplicatedStorage.Assets.Models.BeeEggs;
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(140, 140, 140);
local TweenInfo_new_ret = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

local function preloadModel(p1: userdata) -- Line: 50
    -- upvalues: ContentProvider (copy)
    local v2 = {};

    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("UnionOperation") or (descendant:IsA("MeshPart") or descendant:IsA("SpecialMesh")) then
            table.insert(v2, descendant);
        end;
    end;

    ContentProvider:PreloadAsync(v2);
end;

local u3 = 0;
local u4 = {
    HoverHighlight = nil,
    HoveredShopHitbox = nil,
    MagnitudeShopHitbox = nil,
    ActiveShopHitbox = nil,
    RightTriggerConnection = nil,
    RightTriggerEndedConn = nil,
    RightTriggerHeld = false,
    States = {},
    ShopInfos = {}
};

for _, child in BeeEggs:GetChildren() do
    if child:IsA("Model") then
        preloadModel(child);
    end;
end;

local LastInputType = UserInputService:GetLastInputType();

local function GetInputScreenPosition(p5: userdata) -- Line: 70
    -- upvalues: UserInputService (copy)
    if p5.UserInputType == Enum.UserInputType.Touch then
        return Vector2.new(p5.Position.X, p5.Position.Y);
    end;

    local MouseLocation = UserInputService:GetMouseLocation();

    return Vector2.new(MouseLocation.X, MouseLocation.Y);
end;

local function IsGuiObjectShown(p6: userdata) -- Line: 79
    -- upvalues: PlayerGui (copy)
    while p6 and p6 ~= PlayerGui do
        if p6:IsA("GuiObject") and not p6.Visible then
            return false;
        end;

        if p6:IsA("LayerCollector") and not p6.Enabled then
            return false;
        end;

        p6 = p6.Parent;
    end;

    return true;
end;

local function IsGuiButtonOrTextBox(p7: userdata) -- Line: 97
    -- upvalues: PlayerGui (copy)
    while p7 and p7 ~= PlayerGui do
        if p7:IsA("GuiButton") or p7:IsA("TextBox") then
            return true;
        end;

        p7 = p7.Parent;
    end;

    return false;
end;

local function IsPositionOverBlockingGui(p8) -- Line: 111
    -- upvalues: PlayerGui (copy), IsGuiObjectShown (copy), IsGuiButtonOrTextBox (copy)
    for _, v in PlayerGui:GetGuiObjectsAtPosition(p8.X, p8.Y) do
        if v:IsDescendantOf(PlayerGui) and (IsGuiObjectShown(v) and IsGuiButtonOrTextBox(v)) then
            return true;
        end;
    end;

    return false;
end;

local function UpdateWorldClickBlock(p9: userdata, p10: boolean) -- Line: 131
    -- upvalues: IsPositionOverBlockingGui (copy), GetInputScreenPosition (copy), u3 (ref)
    if p9.UserInputType ~= Enum.UserInputType.MouseButton1 and p9.UserInputType ~= Enum.UserInputType.Touch then
        return;
    end;

    if p10 or IsPositionOverBlockingGui(GetInputScreenPosition(p9)) then
        u3 = os.clock() + 0.35;

        return;
    end;

    u3 = 0;
end;

local function ShouldBlockWorldClick() -- Line: 143
    -- upvalues: u3 (ref)
    return os.clock() <= u3;
end;

local function GetInputVerb() -- Line: 147
    -- upvalues: LastInputType (ref)
    return LastInputType.Name:find("Gamepad") and "L2" or (LastInputType == Enum.UserInputType.Touch and "Tap" or "Click");
end;

UserInputService.LastInputTypeChanged:Connect(function(p11) -- Line: 159
    -- upvalues: LastInputType (ref), u4 (copy)
    LastInputType = p11;

    for _, v in u4.ShopInfos do
        if v.EggInfo then
            local Action = v.EggInfo:FindFirstChild("Action");

            if Action then
                Action.Text = `[{LastInputType.Name:find("Gamepad") and "L2" or (LastInputType == Enum.UserInputType.Touch and "Tap" or "Click")} To Purchase]`;
            end;
        end;
    end;
end);

local function PurchaseActiveShopEgg() -- Line: 170
    -- upvalues: u4 (copy)
    local ActiveShopHitbox = u4.ActiveShopHitbox;

    if not ActiveShopHitbox then
        return;
    end;

    local v12 = u4.ShopInfos[ActiveShopHitbox];

    if not (v12 and v12.Purchase) then
        return;
    end;

    v12.Purchase();
end;

local function StartRightTriggerListener() -- Line: 180
    -- upvalues: u4 (copy), UserInputService (copy)
    if u4.RightTriggerConnection then
        return;
    end;

    u4.RightTriggerConnection = UserInputService.InputBegan:Connect(function(p13, p14) -- Line: 183
        -- upvalues: u4 (ref)
        if p14 then
            return;
        end;

        if p13.KeyCode ~= Enum.KeyCode.ButtonL2 then
            return;
        end;

        if not u4.ActiveShopHitbox then
            return;
        end;

        if not (u4.HoverHighlight and u4.HoverHighlight.Adornee) then
            return;
        end;

        local ActiveShopHitbox = u4.ActiveShopHitbox;

        if not ActiveShopHitbox then
            return;
        end;

        local v15 = u4.ShopInfos[ActiveShopHitbox];

        if v15 then
            if not v15.Purchase then
                return;
            end;

            v15.Purchase();
        end;
    end);
end;

local function StopRightTriggerListener() -- Line: 193
    -- upvalues: u4 (copy)
    if u4.RightTriggerConnection then
        u4.RightTriggerConnection:Disconnect();
        u4.RightTriggerConnection = nil;
    end;

    u4.RightTriggerHeld = false;
end;

local u16 = nil;
local u17 = false;

local function TweenHighlightColor(p18) -- Line: 205
    -- upvalues: u4 (copy), u16 (ref), TweenService (copy), TweenInfo_new_ret (copy)
    if not u4.HoverHighlight then
        return;
    end;

    if u16 then
        u16:Cancel();
    end;

    u16 = TweenService:Create(u4.HoverHighlight, TweenInfo_new_ret, {
        OutlineColor = p18
    });
    u16:Play();
end;

UserInputService.InputBegan:Connect(function(p19, p20) -- Line: 212
    -- upvalues: UpdateWorldClickBlock (copy), u3 (ref), u4 (copy), u17 (ref), TweenHighlightColor (copy), Color3_fromRGB_ret2 (copy)
    UpdateWorldClickBlock(p19, p20);

    if p20 then
        return;
    end;

    if p19.UserInputType ~= Enum.UserInputType.MouseButton1 then
        return;
    end;

    if os.clock() <= u3 then
        return;
    end;

    if not (u4.HoverHighlight and u4.HoverHighlight.Adornee) then
        return;
    end;

    u17 = true;
    TweenHighlightColor(Color3_fromRGB_ret2);
end);
UserInputService.InputEnded:Connect(function(p21) -- Line: 223
    -- upvalues: u17 (ref), TweenHighlightColor (copy), Color3_fromRGB_ret (copy)
    if p21.UserInputType ~= Enum.UserInputType.MouseButton1 then
        return;
    end;

    if not u17 then
        return;
    end;

    u17 = false;
    TweenHighlightColor(Color3_fromRGB_ret);
end);

local function SetActiveShopHitbox(p22: userdata?) -- Line: 230
    -- upvalues: u4 (copy), EggInfoFader (copy), u17 (ref), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), UserInputService (copy)
    if u4.ActiveShopHitbox == p22 then
        return;
    end;

    if u4.ActiveShopHitbox and u4.ShopInfos[u4.ActiveShopHitbox] then
        EggInfoFader.Hide(u4.ShopInfos[u4.ActiveShopHitbox].EggInfo);
    end;

    u4.ActiveShopHitbox = p22;

    if not (p22 and u4.ShopInfos[p22]) then
        if u4.HoverHighlight then
            u4.HoverHighlight.Adornee = nil;

            if u4.RightTriggerConnection then
                u4.RightTriggerConnection:Disconnect();
                u4.RightTriggerConnection = nil;
            end;

            u4.RightTriggerHeld = false;
        end;

        return;
    end;

    local v23 = u4.ShopInfos[p22];
    EggInfoFader.Show(v23.EggInfo);

    if u4.HoverHighlight then
        local v24;

        if u17 then
            v24 = Color3_fromRGB_ret2;
        else
            v24 = Color3_fromRGB_ret;
        end;

        u4.HoverHighlight.OutlineColor = v24;
        u4.HoverHighlight.Adornee = v23.EggModel;
    end;

    if u4.RightTriggerConnection then
        return;
    end;

    u4.RightTriggerConnection = UserInputService.InputBegan:Connect(function(p25, p26) -- Line: 183
        -- upvalues: u4 (ref)
        if p26 then
            return;
        end;

        if p25.KeyCode ~= Enum.KeyCode.ButtonL2 then
            return;
        end;

        if not u4.ActiveShopHitbox then
            return;
        end;

        if not (u4.HoverHighlight and u4.HoverHighlight.Adornee) then
            return;
        end;

        local ActiveShopHitbox = u4.ActiveShopHitbox;

        if not ActiveShopHitbox then
            return;
        end;

        local v27 = u4.ShopInfos[ActiveShopHitbox];

        if v27 then
            if not v27.Purchase then
                return;
            end;

            v27.Purchase();
        end;
    end);
end;

local function RefreshActiveShopHitbox() -- Line: 257
    -- upvalues: SetActiveShopHitbox (copy), u4 (copy)
    SetActiveShopHitbox(u4.HoveredShopHitbox or u4.MagnitudeShopHitbox);
end;

local function GetClosestShopHitbox() -- Line: 261
    -- upvalues: LocalPlayer (copy), u4 (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return nil;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and HumanoidRootPart:IsA("BasePart")) then
        return nil;
    end;

    local v28 = 16;
    local v29 = nil;

    for i in u4.ShopInfos do
        if i:IsDescendantOf(workspace) then
            local Magnitude = (HumanoidRootPart.Position - i.Position).Magnitude;

            if Magnitude <= v28 then
                v29 = i;
                v28 = Magnitude;
            end;
        end;
    end;

    return v29;
end;

local function RegisterShopHitbox(p30: userdata, p31: userdata, p32: userdata, p33: function) -- Line: 290
    -- upvalues: u4 (copy)
    u4.ShopInfos[p30] = {
        EggInfo = p31,
        EggModel = p32,
        Purchase = p33
    };
    p31.Enabled = false;
end;

local function UnregisterShopHitbox(p34: userdata) -- Line: 300
    -- upvalues: u4 (copy), EggInfoFader (copy), SetActiveShopHitbox (copy)
    if u4.HoveredShopHitbox == p34 then
        u4.HoveredShopHitbox = nil;
    end;

    if u4.MagnitudeShopHitbox == p34 then
        u4.MagnitudeShopHitbox = nil;
    end;

    u4.ShopInfos[p34] = nil;

    if u4.ActiveShopHitbox == p34 then
        if u4.ActiveShopHitbox == nil then
            return;
        end;

        if u4.ActiveShopHitbox and u4.ShopInfos[u4.ActiveShopHitbox] then
            EggInfoFader.Hide(u4.ShopInfos[u4.ActiveShopHitbox].EggInfo);
        end;

        u4.ActiveShopHitbox = nil;

        if u4.HoverHighlight then
            u4.HoverHighlight.Adornee = nil;

            if u4.RightTriggerConnection then
                u4.RightTriggerConnection:Disconnect();
                u4.RightTriggerConnection = nil;
            end;

            u4.RightTriggerHeld = false;
        end;
    else
        SetActiveShopHitbox(u4.HoveredShopHitbox or u4.MagnitudeShopHitbox);
    end;
end;

local u35 = {};

local function TweenGlow(u36: userdata, p37) -- Line: 320
    -- upvalues: u35 (copy), TweenService (copy)
    local Misc = u36:FindFirstChild("Misc");

    if Misc then
        Misc = Misc:FindFirstChild("Glow");
    end;

    if not Misc then
        return;
    end;

    local v38 = u35[u36];

    if v38 then
        v38:Cancel();
        u35[u36] = nil;
    end;

    local u39 = TweenService:Create(Misc, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Color = p37
    });
    u35[u36] = u39;
    u39.Completed:Once(function() -- Line: 337
        -- upvalues: u35 (ref), u36 (copy), u39 (copy)
        if u35[u36] == u39 then
            u35[u36] = nil;
        end;
    end);
    u39:Play();
end;

local function FadeGlowToBlack(p40: userdata) -- Line: 346
    -- upvalues: TweenGlow (copy)
    TweenGlow(p40, Color3.fromRGB(0, 0, 0));
end;

local function FadeGlowToEntryColor(p41: userdata, p42: string) -- Line: 350
    -- upvalues: BeeEggRegistry (copy), TweenGlow (copy)
    local v43 = BeeEggRegistry.Entries[p42];

    if v43 then
        TweenGlow(p41, v43.Color);

        return;
    end;

    warn((`No BeeEggRegistry entry for {p42}`));
    TweenGlow(p41, Color3.fromRGB(0, 0, 0));
end;

local function SpringScale(u44: userdata, p45: number, p46: any) -- Line: 361
    -- upvalues: TweenService (copy)
    local u47 = p46:Add(Instance.new("NumberValue"));
    u47.Value = u44:GetScale();
    u47.Parent = u44;
    p46:Add(u47:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 366
        -- upvalues: u44 (copy), u47 (copy)
        u44:ScaleTo((math.max(u47.Value, 0.001)));
    end));
    p46:Add(TweenService:Create(u47, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Value = p45
    })):Play();

    return u47;
end;

local function RemoveEggFromNode(u48: userdata, u49: function) -- Line: 376
    -- upvalues: u4 (copy), EggInfoFader (copy), SetActiveShopHitbox (copy), TweenService (copy)
    local Hitbox = u48:FindFirstChild("Hitbox");

    if Hitbox and Hitbox:IsA("BasePart") then
        Hitbox.CanQuery = false;

        if u4.HoveredShopHitbox == Hitbox then
            u4.HoveredShopHitbox = nil;
        end;

        if u4.MagnitudeShopHitbox == Hitbox then
            u4.MagnitudeShopHitbox = nil;
        end;

        u4.ShopInfos[Hitbox] = nil;

        if u4.ActiveShopHitbox == Hitbox then
            if u4.ActiveShopHitbox ~= nil then
                if u4.ActiveShopHitbox and u4.ShopInfos[u4.ActiveShopHitbox] then
                    EggInfoFader.Hide(u4.ShopInfos[u4.ActiveShopHitbox].EggInfo);
                end;

                u4.ActiveShopHitbox = nil;

                if u4.HoverHighlight then
                    u4.HoverHighlight.Adornee = nil;

                    if u4.RightTriggerConnection then
                        u4.RightTriggerConnection:Disconnect();
                        u4.RightTriggerConnection = nil;
                    end;

                    u4.RightTriggerHeld = false;
                end;
            end;
        else
            SetActiveShopHitbox(u4.HoveredShopHitbox or u4.MagnitudeShopHitbox);
        end;
    end;

    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = u48:GetScale();
    NumberValue.Parent = u48;
    local u50 = NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 387
        -- upvalues: u48 (copy), NumberValue (copy)
        if u48.Parent then
            u48:ScaleTo((math.max(NumberValue.Value, 0.001)));
        end;
    end);
    local v51 = TweenService:Create(NumberValue, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Value = 0.001
    });
    v51:Play();
    v51.Completed:Connect(function() -- Line: 396
        -- upvalues: u50 (copy), NumberValue (copy), u48 (copy), u49 (copy)
        u50:Disconnect();
        NumberValue:Destroy();

        if u48.Parent then
            u48:Destroy();
        end;

        u49();
    end);
end;

local function SpawnEggInNode(u52: number, u53: userdata, u54: string, p55: table, u56: any, u57: any) -- Line: 408
    -- upvalues: BeeEggs (copy), BeeEggRegistry (copy), LastInputType (ref), Comma_Module (copy), CollectionService (copy), RaycastClickDetectorService (copy), u4 (copy), SetActiveShopHitbox (copy), ReplicatedStorage (copy), TweenGlow (copy), RemoveEggFromNode (copy), u3 (ref), UserInputService (copy), ConfirmationPromptController (copy), SpringScale (copy)
    local v58 = u53:FindFirstChild("Holder", true) or u53:WaitForChild("Holder", 10);

    if not v58 then
        warn("No holder found in node", u53.Name);

        return;
    end;

    local v59 = BeeEggs:FindFirstChild(u54);

    if v59 then
        local v60 = BeeEggRegistry.Entries[u54];
        local u61 = u56:Add(v59:Clone());
        u61.Name = "EggModel";
        u61:SetAttribute("EggName", u54);
        u61:SetAttribute("Bought", false);

        for _, v in u61:QueryDescendants("BasePart") do
            v.Anchored = true;
            v.CanCollide = true;
        end;

        local v62 = u61:FindFirstChildOfClass("ProximityPrompt");

        if v62 then
            v62:Destroy();
        end;

        local BoundingBox, v63 = u61:GetBoundingBox();
        local Part = Instance.new("Part");
        Part.Name = "Hitbox";
        Part.Size = v63 * 1.025;
        Part.CFrame = BoundingBox;
        Part.Transparency = 1;
        Part.CanCollide = false;
        Part.Anchored = true;
        Part.Parent = u61;

        if not v60 then
            warn((`Couldn't find entry for {u54}!!`));
        end;

        local v64 = script.EggInfo:Clone();
        v64.Item.Text = u54;
        v64.Action.Text = `[{LastInputType.Name:find("Gamepad") and "L2" or (LastInputType == Enum.UserInputType.Touch and "Tap" or "Click")} To Purchase]`;

        if v60 and v60.Color then
            v64.Item.TextColor3 = v60.Color;
        end;

        v64.Price.Label.Visible = true;
        v64.Price.Detail.Visible = false;

        if v60 and v60.Price then
            v64.Price.Label.Text = Comma_Module.Comma((`{v60.Price}`));
        else
            v64.Price.Visible = false;
        end;

        v64.Enabled = false;
        v64.Parent = Part;
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterDescendantsInstances = CollectionService:GetTagged("BeeSwarmEggShop");
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
        local v65 = RaycastClickDetectorService.bind(Part, {
            MaxDistance = 50,
            params = RaycastParams_new_ret
        });
        v65.MouseHoverEnter:Connect(function() -- Line: 479
            -- upvalues: u4 (ref), Part (copy), SetActiveShopHitbox (ref)
            u4.HoveredShopHitbox = Part;
            SetActiveShopHitbox(u4.HoveredShopHitbox or u4.MagnitudeShopHitbox);
        end);
        v65.MouseHoverLeave:Connect(function() -- Line: 484
            -- upvalues: u4 (ref), Part (copy), SetActiveShopHitbox (ref)
            if u4.HoveredShopHitbox == Part then
                u4.HoveredShopHitbox = nil;
                SetActiveShopHitbox(u4.HoveredShopHitbox or u4.MagnitudeShopHitbox);
            end;
        end);

        local function DoPurchase() -- Line: 491
            -- upvalues: u61 (copy), ReplicatedStorage (ref), u54 (copy), u57 (copy), u52 (copy), u53 (copy), TweenGlow (ref), u56 (copy), RemoveEggFromNode (ref)
            if u61:GetAttribute("Bought") or u61:GetAttribute("Buying") then
                return;
            end;

            u61:SetAttribute("Buying", true);

            if not ReplicatedStorage.GameEvents.BeeColonyEggShopService.BuyBeeEggStock:InvokeServer(u54) then
                u61:SetAttribute("Buying", false);

                return;
            end;

            if not u57.BoughtOutNodes then
                u57.BoughtOutNodes = {};
            end;

            u57.BoughtOutNodes[u52] = true;
            u61:SetAttribute("Bought", true);
            TweenGlow(u53, Color3.fromRGB(0, 0, 0));

            if u57.NodeTroves[u52] == u56 then
                u57.NodeTroves[u52] = nil;
                u57.NodeEggs[u52] = nil;
            end;

            RemoveEggFromNode(u61, function() -- Line: 515
                -- upvalues: u56 (ref)
                u56:Clean();
            end);
        end;

        local function PurchaseThisEgg() -- Line: 520
            -- upvalues: u61 (copy), u3 (ref), UserInputService (ref), BeeEggRegistry (ref), u54 (copy), Comma_Module (ref), ConfirmationPromptController (ref), DoPurchase (copy)
            if u61:GetAttribute("Bought") or u61:GetAttribute("Buying") then
                return;
            end;

            if os.clock() <= u3 then
                return;
            end;

            if UserInputService.PreferredInput ~= Enum.PreferredInput.Touch then
                DoPurchase();

                return;
            end;

            local v66 = BeeEggRegistry.Entries[u54];
            ConfirmationPromptController:Open({
                Title = "Purchase Bee Egg",
                Footer = "This action cannot be undone.",
                ConfirmText = "Buy",
                RejectText = "Cancel",
                Header = u54,
                Middle = `Are you sure you want to buy this egg for {not (v66 and v66.Price) and "?" or Comma_Module.Comma((tostring(v66.Price)))} Honey Coins?`
            }, {
                ConfirmCallback = function() -- Line: 538, Name: ConfirmCallback
                    -- upvalues: u61 (ref), DoPurchase (ref)
                    if u61:GetAttribute("Bought") or u61:GetAttribute("Buying") then
                        return;
                    end;

                    DoPurchase();
                end
            });
        end;

        v65.MouseClick:Connect(function() -- Line: 548
            -- upvalues: LastInputType (ref), PurchaseThisEgg (copy)
            if LastInputType.Name:find("Gamepad") then
                return;
            end;

            PurchaseThisEgg();
        end);
        local Scale = u61:GetScale();
        u61:ScaleTo(0.001);
        u61:PivotTo(v58:GetPivot() * CFrame.Angles(3.141592653589793, 0, 0));
        u61.Parent = u53;
        u4.ShopInfos[Part] = {
            EggInfo = v64,
            EggModel = u61,
            Purchase = PurchaseThisEgg
        };
        v64.Enabled = false;
        SpringScale(u61, Scale, u56);
        local v67 = BeeEggRegistry.Entries[u54];

        if v67 then
            TweenGlow(u53, v67.Color);

            return u61;
        end;

        warn((`No BeeEggRegistry entry for {u54}`));
        TweenGlow(u53, Color3.fromRGB(0, 0, 0));

        return u61;
    end;

    warn("No egg model found for:", u54);
end;

local function UpdateShopDisplay(p68: userdata, p69: table, p70: any) -- Line: 567
    -- upvalues: DataService (copy), TweenGlow (copy), RemoveEggFromNode (copy), SpawnEggInNode (copy)
    if not p70.NodeTroves then
        p70.NodeTroves = {};
    end;

    if not p70.NodeEggs then
        p70.NodeEggs = {};
    end;

    if not p70.BoughtOutNodes then
        p70.BoughtOutNodes = {};
    end;

    local Data = DataService:GetData();
    local v71 = Data and Data.BeeEggShopStock and Data.BeeEggShopStock.Egg;

    if p70.LastShopSeed ~= v71 then
        p70.LastShopSeed = v71;
        table.clear(p70.BoughtOutNodes);
    end;

    local v72 = {};

    for i, v in p69 do
        local v73 = i;

        for i2 = 1, v.Stock do
            table.insert(v72, v73);
            local _ = i2;
        end;
    end;

    local function ShuffleWithSeed(p74: table, p75: number) -- Line: 587
        local Random_new_ret = Random.new(p75);

        for i = #p74, 2, -1 do
            local v76 = Random_new_ret:NextInteger(1, i);
            local v77 = p74[i];
            p74[i] = p74[v76];
            p74[v76] = v77;
            local _ = i;
        end;
    end;

    if v71 then
        ShuffleWithSeed(v72, v71);
    end;

    local v78 = 1;

    for i = 1, 6 do
        local v79 = p68:FindFirstChild((tostring(i)));
        local v80;

        if v79 then
            local v81 = p70.NodeEggs[i];
            local v82;

            if p70.BoughtOutNodes[i] then
                v82 = nil;
            else
                v82 = v72[v78];
                v78 = v78 + 1;
            end;

            if v82 then
                if v81 == v82 then
                    v80 = i;
                else
                    if p70.NodeTroves[i] then
                        local u83 = p70.NodeTroves[i];
                        local EggModel = v79:FindFirstChild("EggModel");
                        TweenGlow(v79, Color3.fromRGB(0, 0, 0));

                        if EggModel then
                            RemoveEggFromNode(EggModel, function() -- Line: 630
                                -- upvalues: u83 (copy)
                                u83:Clean();
                            end);
                        else
                            u83:Clean();
                        end;

                        p70.NodeTroves[i] = nil;
                        p70.NodeEggs[i] = nil;
                    end;

                    if v82 then
                        local v84 = p70.Trove:Extend();
                        p70.NodeTroves[i] = v84;
                        p70.NodeEggs[i] = v82;
                        SpawnEggInNode(i, v79, v82, p69[v82], v84, p70);
                        v80 = i;
                    else
                        TweenGlow(v79, Color3.fromRGB(0, 0, 0));
                        v80 = i;
                    end;
                end;
            else
                TweenGlow(v79, Color3.fromRGB(0, 0, 0));
                v80 = i;
            end;
        else
            v80 = i;
        end;
    end;
end;

function u4.Start() -- Line: 652
    -- upvalues: u4 (copy), SetActiveShopHitbox (copy), LocalPlayer (copy), RunService (copy), GetClosestShopHitbox (copy), CreateTagHandler (copy), Trove (copy), Color3_fromRGB_ret (copy), ReplicatedStorage (copy), DataService (copy), UpdateShopDisplay (copy), script_Config (copy)
    task.spawn(function() -- Line: 653
        -- upvalues: u4 (ref), SetActiveShopHitbox (ref), LocalPlayer (ref)
        local function onChildAdded(p85: userdata) -- Line: 654
            -- upvalues: u4 (ref), SetActiveShopHitbox (ref)
            if not p85:IsA("Tool") then
                return;
            end;

            if not (u4.HoverHighlight and u4.HoverHighlight.Parent) then
                return;
            end;

            u4.HoverHighlight.Adornee = nil;
            SetActiveShopHitbox(u4.HoveredShopHitbox or u4.MagnitudeShopHitbox);
        end;

        if LocalPlayer.Character then
            LocalPlayer.Character.ChildAdded:Connect(onChildAdded);
        end;

        LocalPlayer.CharacterAdded:Connect(function(p86) -- Line: 665
            -- upvalues: onChildAdded (copy)
            p86.ChildAdded:Connect(onChildAdded);
        end);
    end);
    RunService.Heartbeat:Connect(function() -- Line: 670
        -- upvalues: GetClosestShopHitbox (ref), u4 (ref), SetActiveShopHitbox (ref)
        local v87 = GetClosestShopHitbox();

        if u4.MagnitudeShopHitbox ~= v87 then
            u4.MagnitudeShopHitbox = v87;
            SetActiveShopHitbox(u4.HoveredShopHitbox or u4.MagnitudeShopHitbox);
        end;
    end);
    CreateTagHandler({
        Tag = "BeeSwarmEggShop",

        OnInstanceAdded = function(u88: userdata) -- Line: 682, Name: OnInstanceAdded
            -- upvalues: Trove (ref), u4 (ref), Color3_fromRGB_ret (ref), ReplicatedStorage (ref), DataService (ref), UpdateShopDisplay (ref), script_Config (ref)
            local v89 = Trove.new();
            local u90 = {
                Trove = v89,
                NodeTroves = {},
                NodeEggs = {}
            };
            u4.States[u88] = {
                Trove = v89,
                State = u90
            };
            v89:Add(function() -- Line: 687
                -- upvalues: u4 (ref), u88 (copy)
                u4.States[u88] = nil;

                if not next(u4.States) and u4.HoverHighlight then
                    u4.HoverHighlight:Destroy();
                    u4.HoverHighlight = nil;
                end;
            end);

            if not u4.HoverHighlight then
                local Highlight = Instance.new("Highlight");
                Highlight.Name = "BeeColonyEggShopController";
                Highlight.FillTransparency = 1;
                Highlight.OutlineColor = Color3_fromRGB_ret;
                Highlight.Adornee = nil;
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.Parent = ReplicatedStorage;
                u4.HoverHighlight = Highlight;
            end;

            local Nodes = u88:WaitForChild("Nodes");
            local Data = DataService:GetData();
            UpdateShopDisplay(Nodes, Data and (Data.BeeEggShopStock and Data.BeeEggShopStock.Stocks) or {}, u90);
            local PathSignal = DataService:GetPathSignal("BeeEggShopStock/Stocks");

            if PathSignal then
                v89:Add(PathSignal:Connect(function() -- Line: 714
                    -- upvalues: DataService (ref), UpdateShopDisplay (ref), Nodes (copy), u90 (copy)
                    local Data2 = DataService:GetData();
                    UpdateShopDisplay(Nodes, Data2 and (Data2.BeeEggShopStock and Data2.BeeEggShopStock.Stocks) or {}, u90);
                end));
            end;

            local RestockSign = u88:FindFirstChild("RestockSign");

            if RestockSign then
                RestockSign = RestockSign:FindFirstChild("Sign_Part");
            end;

            if RestockSign then
                RestockSign = RestockSign:FindFirstChild("RestockTimer");
            end;

            if RestockSign then
                RestockSign = RestockSign:FindFirstChild("label");
            end;

            if RestockSign then
                local function formatTime(p91: number) -- Line: 727
                    local math_floor_ret = math.floor(p91);
                    local math_max_ret = math.max(0, math_floor_ret);

                    if math_max_ret < 60 then
                        return `{math_max_ret}s`;
                    end;

                    return string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60);
                end;

                local function getSecondsUntilRestock() -- Line: 735
                    -- upvalues: DataService (ref), script_Config (ref)
                    local UnixTimestamp = DateTime.now().UnixTimestamp;
                    local Data2 = DataService:GetData();

                    if Data2 then
                        Data2 = Data2.BeeEggShopStock;
                    end;

                    if Data2 then
                        local ForcedEggEndTimestamp = Data2.ForcedEggEndTimestamp;

                        if ForcedEggEndTimestamp and UnixTimestamp < ForcedEggEndTimestamp then
                            return ForcedEggEndTimestamp - UnixTimestamp;
                        end;
                    end;

                    local RefreshTime = script_Config.RefreshTime;

                    return RefreshTime - UnixTimestamp % RefreshTime;
                end;

                v89:Add(task.spawn(function() -- Line: 751
                    -- upvalues: DataService (ref), script_Config (ref), RestockSign (copy)
                    while true do
                        local UnixTimestamp = DateTime.now().UnixTimestamp;
                        local Data2 = DataService:GetData();

                        if Data2 then
                            Data2 = Data2.BeeEggShopStock;
                        end;

                        local v92, v93;

                        if Data2 then
                            local ForcedEggEndTimestamp = Data2.ForcedEggEndTimestamp;

                            if ForcedEggEndTimestamp and UnixTimestamp < ForcedEggEndTimestamp then
                                v92 = ForcedEggEndTimestamp - UnixTimestamp;
                            else
                                v93 = script_Config.RefreshTime;
                                v92 = v93 - UnixTimestamp % v93;
                            end;
                        else
                            v93 = script_Config.RefreshTime;
                            v92 = v93 - UnixTimestamp % v93;
                        end;

                        local math_floor_ret = math.floor(v92);
                        local math_max_ret = math.max(0, math_floor_ret);
                        local v94;

                        if math_max_ret < 60 then
                            v94 = `{math_max_ret}s`;
                        else
                            v94 = string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60);
                        end;

                        RestockSign.Text = `Restock: {v94}`;
                        task.wait(1);
                    end;
                end));
            end;
        end,

        OnInstanceRemoved = function(p95: userdata) -- Line: 761, Name: OnInstanceRemoved
            -- upvalues: u4 (ref)
            local v96 = u4.States[p95];

            if v96 then
                v96.Trove:Clean();
            end;
        end
    });
end;

task.spawn(u4.Start);

return u4;