-- Decompiled with Potassium's decompiler.

local ContextActionService = game:GetService("ContextActionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local GamepadService = game:GetService("GamepadService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local BeeSkillTreeUI = PlayerGui:WaitForChild("BeeSkillTreeUI");
PlayerGui:WaitForChild("BackpackGui");
PlayerGui:WaitForChild("Teleport_UI");
local SoundService = game:GetService("SoundService");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Spring = require(ReplicatedStorage.Modules.Spring);
local script_Config = require(script.Config);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local CurrencyUIManager = require(ReplicatedStorage.Modules.CurrencyUIManager);
local v1 = {};
local u2 = {
    DragResistance = 0.5,
    DragBounds = 15,
    ZoomLimit = NumberRange.new(-14.4, 15)
};

local function IsMobileTouch() -- Line: 29
    -- upvalues: UserInputService (copy)
    return UserInputService.TouchEnabled and not UserInputService.MouseEnabled;
end;

local V2 = require(script.Generators.V2);
local SkillTreeSounds = SoundService:WaitForChild("SkillTreeSounds");
PlayerGui:WaitForChild("Honey_UI"):WaitForChild("Frame");
local CurrencyUI = CurrencyUIManager:GetCurrencyUI("HoneyCoins");
local Controls = require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local UDim2_fromScale_ret = UDim2.fromScale(0.45, 0.95);
local u3 = {
    {
        Name = "BeeCapacity",
        Icon = "rbxassetid://124630016104719",
        IsOrigin = true,
        Description = "Increases the maximum number of bees you can have.",
        Tiers = script_Config.UPGRADE_CONFIG.BeeCapacity.MaxTier
    },
    {
        Name = "BeeSpeed",
        Icon = "rbxassetid://128750030198922",
        Description = "Increases the speed at which your bees fly.",
        Tiers = script_Config.UPGRADE_CONFIG.BeeSpeed.MaxTier
    },
    {
        Name = "CompressorCapacity",
        Icon = "rbxassetid://103724535075252",
        Description = "Increases how much honey your compressor can hold.",
        Tiers = script_Config.UPGRADE_CONFIG.CompressorCapacity.MaxTier
    },
    {
        Name = "CompressorSpeed",
        Icon = "rbxassetid://96122069254577",
        Description = "Increases how fast your compressor processes honey.",
        Tiers = script_Config.UPGRADE_CONFIG.CompressorSpeed.MaxTier
    },
    {
        Name = "PollinationAmount",
        Icon = "rbxassetid://104381156132379",
        Description = "Increases the amount of honey coins receieved.",
        DisplayName = "Extra Honey Coins",
        Tiers = script_Config.UPGRADE_CONFIG.PollinationAmount.MaxTier
    }
};
local Position = CurrencyUI.Position;
local u4 = CurrencyUI:FindFirstChildOfClass("UIScale");
local u5 = u4 and (u4.Scale or 1) or 1;

local function SetHoneyCurrencyForSkillTree(p6: boolean) -- Line: 56
    -- upvalues: u4 (ref), u5 (copy), CurrencyUI (copy), UDim2_fromScale_ret (copy), Position (copy)
    if not u4 then
        u4 = Instance.new("UIScale");
        u4.Name = "BeeSkillTreeCurrencyScale";
        u4.Scale = u5;
        u4.Parent = CurrencyUI;
    end;

    if p6 then
        CurrencyUI.Position = UDim2_fromScale_ret;
        u4.Scale = 1.4;

        return;
    end;

    CurrencyUI.Position = Position;
    u4.Scale = u5;
end;

local function ScaleNode(p7: userdata) -- Line: 73
    if p7:GetAttribute("BeeSkillTreeScaled") then
        return;
    end;

    p7:SetAttribute("BeeSkillTreeScaled", true);

    if p7:IsA("Model") then
        p7:ScaleTo(p7:GetScale() * 1);

        return;
    end;

    if p7:IsA("BasePart") then
        p7.Size = p7.Size * 1;
    end;
end;

local function ScaleNodes(p8) -- Line: 87
    -- upvalues: ScaleNode (copy)
    if not p8 then
        return;
    end;

    for _, v in p8 do
        if v.node then
            ScaleNode(v.node);
        end;
    end;
end;

function v1.Start() -- Line: 97
    -- upvalues: BeeSkillTreeUI (copy), GuiController (copy), Spring (copy), DataService (copy), SoundService (copy), ReplicatedStorage (copy), script_Config (copy), V2 (copy), ScaleNode (copy), UserInputService (copy), SetupButton (copy), u2 (copy), u3 (copy), Controls (copy), ContextActionService (copy), u4 (ref), u5 (copy), CurrencyUI (copy), Position (copy), PlayerGui (copy), LocalPlayer (copy), UDim2_fromScale_ret (copy), SkillTreeSounds (copy), RunService (copy), UpdateService (copy), GamepadService (copy)
    local u9 = {};

    local function getCurrentNav() -- Line: 100
        -- upvalues: u9 (copy)
        return u9[#u9];
    end;

    local function destroyTopTree() -- Line: 104
        -- upvalues: u9 (copy)
        local v10 = u9[#u9];

        if not v10 then
            return;
        end;

        for _, v in v10.registry do
            if v.node and v.node.Parent then
                v.node:Destroy();
            end;
        end;

        if v10.folder and v10.folder.Parent then
            v10.folder:Destroy();
        end;

        u9[#u9] = nil;
    end;

    local u11 = false;
    local u12 = false;
    BeeSkillTreeUI.Enabled = false;
    local StateForGui = GuiController:GetStateForGui(BeeSkillTreeUI);
    StateForGui.ChangeEnabled:Set(true);
    local u13 = nil;
    local u14 = nil;
    local u15 = false;
    local u16 = nil;
    local u17 = nil;
    local u18 = 0;
    local u19 = 0.025;
    local u20 = 1;
    local u21 = nil;
    local u22 = 0;
    local Vector2_new_ret = Vector2.new(0, 0);
    local u23 = 0;
    local u24 = false;
    local u25 = nil;
    local u26 = nil;
    local CFrame_Angles_ret = CFrame.Angles(-1.5707963267948966, 0, 1.5707963267948966);
    local u27 = nil;
    local u28 = CFrame.new(500, -4.5, 0) * CFrame_Angles_ret;

    local function resetTreeCamera(p29: boolean?) -- Line: 148
        -- upvalues: u11 (ref), u12 (ref), u15 (ref), u18 (ref), u27 (ref), Vector2_new_ret (ref), Spring (ref), u28 (copy)
        u11 = false;
        u12 = false;
        u15 = false;
        u18 = 0;
        u27 = nil;
        Vector2_new_ret = Vector2.new(0, 0);
        Spring.stop(workspace.CurrentCamera, "CFrame");

        if p29 then
            workspace.CurrentCamera.CFrame = u28;

            return;
        end;

        Spring.target(workspace.CurrentCamera, 0.8, 4, {
            CFrame = u28
        });
    end;

    local Upgrade = BeeSkillTreeUI:WaitForChild("Upgrade");
    local Upgrade2 = Upgrade:WaitForChild("Main"):WaitForChild("Upgrade");
    local Label = Upgrade2:WaitForChild("Claim"):WaitForChild("Folder"):WaitForChild("Label");
    local Title = Upgrade:WaitForChild("Main"):WaitForChild("Title");
    local UpgradeText = Upgrade:WaitForChild("Main"):WaitForChild("UpgradeText");
    local Icon = Upgrade:WaitForChild("Main"):WaitForChild("Icon");
    local Description = Upgrade:WaitForChild("Main"):WaitForChild("Description");
    local u30 = nil;
    local u31 = nil;
    local u32 = Upgrade:FindFirstChildOfClass("UIScale");

    if not u32 then
        u32 = Instance.new("UIScale");
        u32.Parent = Upgrade;
    end;

    local AbsoluteSize = Upgrade.AbsoluteSize;
    u32.Scale = 0;

    local function hideUpgradeFrame() -- Line: 187
        -- upvalues: u30 (ref), u31 (ref), Spring (ref), u32 (ref), Upgrade (copy)
        u30 = nil;

        if u31 then
            u31:Disconnect();
            u31 = nil;
        end;

        Spring.stop(u32, "Scale");
        Spring.target(u32, 0.85, 7, {
            Scale = 0
        });
        task.delay(0.4, function() -- Line: 195
            -- upvalues: u30 (ref), Upgrade (ref)
            if not u30 then
                Upgrade.Visible = false;
            end;
        end);
    end;

    local u33 = nil;

    local function showUpgradeFrame(u34) -- Line: 204
        -- upvalues: u30 (ref), Upgrade2 (copy), Title (copy), Icon (copy), Description (copy), UpgradeText (copy), Label (copy), u33 (ref), Spring (ref), u32 (ref), Upgrade (copy), DataService (ref), u31 (ref)
        u30 = u34;
        local v35 = u34.state == "purchased";
        Upgrade2.Visible = not v35;
        Title.Text = u34.label:gsub("<br/>.*", "");
        Icon.Image = u34.icon;
        Description.Text = u34.description or "";

        if u34.levels and u34.levels > 1 then
            UpgradeText.Text = `LVL: {u34.tier - 1} -> {u34.tier} ({u34.progress or 0}/{u34.levels})`;
        else
            UpgradeText.Text = `LVL: {u34.tier - 1} -> {u34.tier}`;
        end;

        if v35 then
            UpgradeText.Text = "Purchased";
            Label.Text = "";
        elseif u34.isPageNode then
            UpgradeText.Text = "Opens: " .. (u34.pageName or "Sub-tree");
            Label.Text = "Free";
            Label.TextColor3 = Color3.new(0.4, 1, 0.6);
        elseif u34.isBackNode then
            UpgradeText.Text = "Navigate back";
            Label.Text = "←";
            Label.TextColor3 = Color3.new(1, 1, 1);
        end;

        u33();
        Spring.stop(u32, "Scale");
        u32.Scale = 0;
        Upgrade.Visible = true;
        Spring.target(u32, 0.55, 6, {
            Scale = 1
        });

        local function updateAffordability() -- Line: 240
            -- upvalues: u34 (copy), Label (ref), DataService (ref)
            if u34.state == "purchased" then
                Label.Text = "";

                return;
            end;

            local Data = DataService:GetData();
            Label.TextColor3 = (Data and (Data.SpecialCurrency and Data.SpecialCurrency.HoneyCoins) or 0) >= u34.cost and Color3.new(1, 1, 1) or Color3.fromRGB(255, 60, 60);
        end;

        updateAffordability();

        if u31 then
            u31:Disconnect();
        end;

        u31 = DataService:GetPathSignal("SpecialCurrency/HoneyCoins"):Connect(updateAffordability);
    end;

    u33 = function() -- Line: 256
        -- upvalues: u30 (ref), hideUpgradeFrame (copy), Upgrade (copy), u32 (ref), AbsoluteSize (ref)
        if not (u30 and (u30.node and u30.node.Parent)) then
            hideUpgradeFrame();

            return;
        end;

        local node = u30.node;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local Position2 = node.Position;
        local v36, v37 = workspace_CurrentCamera:WorldToViewportPoint(Position2);

        if not v37 then
            Upgrade.Visible = false;

            return;
        end;

        Upgrade.Visible = true;
        local ViewportSize = workspace_CurrentCamera.ViewportSize;

        if u32.Scale >= 0.99 then
            AbsoluteSize = Upgrade.AbsoluteSize;
        end;

        local X = AbsoluteSize.X;
        local Y = AbsoluteSize.Y;
        local v38 = workspace_CurrentCamera:WorldToViewportPoint(Position2 + Vector3.new(node.Size.X * 0.5, 0, 0));
        local v39 = workspace_CurrentCamera:WorldToViewportPoint(Position2 + Vector3.new(0, 0, node.Size.Z * 0.5));
        local math_abs_ret = math.abs(v38.X - v36.X);
        local math_abs_ret2 = math.abs(v39.X - v36.X);
        local math_abs_ret3 = math.abs(v38.Y - v36.Y);
        local math_abs_ret4 = math.abs(v39.Y - v36.Y);
        local math_max_ret = math.max(math_abs_ret, math_abs_ret2, math_abs_ret3, math_abs_ret4, 30);
        local X2 = v36.X;
        local Y2 = v36.Y;
        local math_max_ret2 = math.max(ViewportSize.X - X - 16, 16);
        local math_max_ret3 = math.max(ViewportSize.Y - Y - 16, 16);
        local v40 = {
            {
                primary = "x",
                x = X2 - math_max_ret - 12 - X,
                y = Y2 - Y * 0.5
            },
            {
                primary = "x",
                x = X2 + math_max_ret + 12,
                y = Y2 - Y * 0.5
            },
            {
                primary = "y",
                x = X2 - X * 0.5,
                y = Y2 - math_max_ret - 12 - Y
            },
            {
                primary = "y",
                x = X2 - X * 0.5,
                y = Y2 + math_max_ret + 12
            }
        };
        local v41 = nil;
        local v42 = nil;

        for _, v in v40 do
            local v43;

            if v.primary == "x" then
                if v.x >= 16 then
                    v43 = v.x <= math_max_ret2;
                else
                    v43 = false;
                end;
            elseif v.y >= 16 then
                v43 = v.y <= math_max_ret3;
            else
                v43 = false;
            end;

            if v43 then
                v41 = math.clamp(v.x, 16, math_max_ret2);
                v42 = math.clamp(v.y, 16, math_max_ret3);
                break;
            end;
        end;

        if not v41 then
            local v44 = v40[1];
            v41 = math.clamp(v44.x, 16, math_max_ret2);
            v42 = math.clamp(v44.y, 16, math_max_ret3);
        end;

        local AnchorPoint = Upgrade.AnchorPoint;
        Upgrade.Position = UDim2.fromOffset(v41 + X * AnchorPoint.X, v42 + Y * AnchorPoint.Y);
    end;

    local u45 = nil;

    local function u48(u46) -- Line: 335
        -- upvalues: SoundService (ref), u45 (ref)
        local node = u46.node;
        local v47 = node:FindFirstChildOfClass("ClickDetector");

        if v47 then
            v47:Destroy();
            local ClickDetector = Instance.new("ClickDetector");
            ClickDetector.CursorIcon = "rbxasset://textures/Cursors/KeyboardMouse/ArrowCursor.png";
            ClickDetector.MaxActivationDistance = 1000;
            ClickDetector.Parent = node;
            ClickDetector.MouseClick:Connect(function() -- Line: 344
                -- upvalues: u46 (copy), SoundService (ref), u45 (ref)
                if u46.state ~= "revealed" then
                    return;
                end;

                SoundService.SkillTreeSounds.Click:Play();

                if u46.isPageNode then
                    u45(u46.pageName);

                    return;
                end;

                u46:purchase();
            end);
        end;
    end;

    u45 = function(p49: string) -- Line: 356
        -- upvalues: hideUpgradeFrame (copy), SoundService (ref), ReplicatedStorage (ref), script_Config (ref), u11 (ref), u12 (ref), u15 (ref), u18 (ref), u27 (ref), Vector2_new_ret (ref), Spring (ref), u28 (copy), V2 (ref), u48 (ref), u30 (ref), showUpgradeFrame (copy), destroyTopTree (copy), u14 (ref), u9 (copy), ScaleNode (ref)
        hideUpgradeFrame();
        SoundService.SkillTreeSounds.Open:Play();
        local SkillTree = workspace:FindFirstChild("SkillTree");

        if SkillTree then
            SkillTree.Name = "SkillTree_Main";
            SkillTree.Parent = ReplicatedStorage;
        end;

        local v50 = script_Config.PAGE_NODES[p49];

        if not v50 then
            return;
        end;

        local SubTree = v50.SubTree;
        local v51 = script_Config.SUB_TREE_CONFIGS[SubTree];

        if not v51 then
            return;
        end;

        local v52 = {
            {
                Name = "__back__",
                Tiers = 1,
                IsOrigin = true,
                Icon = script_Config.SUB_TREE_ORIGIN[SubTree].Icon,
                Description = script_Config.SUB_TREE_ORIGIN[SubTree].Description,
                DisplayName = script_Config.SUB_TREE_ORIGIN[SubTree].Label
            }
        };
        local Order = v51.Order;

        if Order then
            for _, v in Order do
                local v53 = v51[v];

                if v53 and v53.MaxTier then
                    table.insert(v52, {
                        IsOrigin = false,
                        Name = v,
                        Tiers = v53.MaxTier,
                        Icon = v53.Icon,
                        Description = v53.Description,
                        DisplayName = v53.DisplayName
                    });
                end;
            end;
        else
            for i, v in v51 do
                if type(v) == "table" and v.MaxTier then
                    table.insert(v52, {
                        IsOrigin = false,
                        Name = i,
                        Tiers = v.MaxTier,
                        Icon = v.Icon,
                        Description = v.Description,
                        DisplayName = v.DisplayName
                    });
                end;
            end;

            table.sort(v52, function(p54, p55) -- Line: 409
                return p54.Name < p55.Name;
            end);
        end;

        if v52[1] then
            v52[1].IsOrigin = true;
        end;

        u11 = false;
        u12 = false;
        u15 = false;
        u18 = 0;
        u27 = nil;
        Vector2_new_ret = Vector2.new(0, 0);
        Spring.stop(workspace.CurrentCamera, "CFrame");
        workspace.CurrentCamera.CFrame = u28;
        local _, v59 = V2.generate(tonumber(SubTree:byte(1)) * 1000 + 42, (workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -25)).Position, v52, function(p56) -- Line: 422
            -- upvalues: u48 (ref)
            u48(p56);
        end, function(p57) -- Line: 423
            -- upvalues: u30 (ref), showUpgradeFrame (ref)
            if u30 == p57 then
                showUpgradeFrame(p57);
            end;
        end, {
            isSubTree = true,
            subTreeName = SubTree,

            onPageNodeClicked = function(p58) -- Line: 429, Name: onPageNodeClicked
            end,

            onBackClicked = function() -- Line: 430, Name: onBackClicked
                -- upvalues: hideUpgradeFrame (ref), destroyTopTree (ref), ReplicatedStorage (ref), u11 (ref), u12 (ref), u15 (ref), u18 (ref), u27 (ref), Vector2_new_ret (ref), Spring (ref), u28 (ref), SoundService (ref), u14 (ref), u9 (ref)
                hideUpgradeFrame();
                destroyTopTree();
                local SkillTree_Main = ReplicatedStorage:FindFirstChild("SkillTree_Main");

                if SkillTree_Main then
                    SkillTree_Main.Name = "SkillTree";
                    SkillTree_Main.Parent = workspace;
                end;

                u11 = false;
                u12 = false;
                u15 = false;
                u18 = 0;
                u27 = nil;
                Vector2_new_ret = Vector2.new(0, 0);
                Spring.stop(workspace.CurrentCamera, "CFrame");
                workspace.CurrentCamera.CFrame = u28;
                SoundService.SkillTreeSounds.Open:Play();
                u14 = u9[#u9] and u9[#u9].registry or nil;
            end
        });

        if v59 then
            for _, v in v59 do
                if v.node then
                    ScaleNode(v.node);
                end;
            end;
        end;

        local v60 = {
            registry = v59,
            folder = workspace:FindFirstChild("SkillTree"),
            subTreeName = SubTree
        };
        table.insert(u9, v60);
        u14 = v59;
    end;

    Upgrade2.Active = false;
    local Claim = Upgrade2:FindFirstChild("Claim");

    if Claim then
        if Claim:IsA("GuiObject") then
            Claim.BackgroundTransparency = 1;
        end;

        if Claim:IsA("ImageLabel") or Claim:IsA("ImageButton") then
            Claim.ImageTransparency = 1;
        end;

        for _, child in Claim:GetChildren() do
            if child.Name ~= "Folder" then
                if child:IsA("UIStroke") then
                    child.Enabled = false;
                elseif child:IsA("ImageLabel") or child:IsA("ImageButton") then
                    child.ImageTransparency = 1;
                    child.BackgroundTransparency = 1;
                elseif child:IsA("GuiObject") then
                    child.BackgroundTransparency = 1;
                end;
            end;
        end;
    end;

    local u61 = nil;
    local u62 = nil;
    local u63 = false;

    local function cancelTouchHold() -- Line: 493
        -- upvalues: u62 (ref), u63 (ref), hideUpgradeFrame (copy), u61 (ref)
        if u62 then
            pcall(task.cancel, u62);
            u62 = nil;
        end;

        if u63 then
            hideUpgradeFrame();
            u63 = false;
        end;

        u61 = nil;
    end;

    UserInputService.InputBegan:Connect(function(p64, p65) -- Line: 505
        -- upvalues: StateForGui (copy), u14 (ref), u62 (ref), u63 (ref), hideUpgradeFrame (copy), u61 (ref), showUpgradeFrame (copy)
        if p65 then
            return;
        end;

        if p64.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        if not StateForGui.Visible:Get() then
            return;
        end;

        local SkillTree = workspace:FindFirstChild("SkillTree");

        if not (SkillTree and u14) then
            return;
        end;

        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
        RaycastParams_new_ret.FilterDescendantsInstances = { SkillTree };
        local v66 = workspace.CurrentCamera:ViewportPointToRay(p64.Position.X, p64.Position.Y);
        local v67 = workspace:Raycast(v66.Origin, v66.Direction * 100, RaycastParams_new_ret);

        if not (v67 and v67.Instance) then
            return;
        end;

        local Instance2 = v67.Instance;

        while Instance2 and not Instance2:FindFirstChildOfClass("ClickDetector") do
            Instance2 = Instance2.Parent;

            if Instance2 == SkillTree or Instance2 == workspace then
                Instance2 = nil;
                break;
            end;
        end;

        if not Instance2 then
            return;
        end;

        for _, v in u14 do
            if v.node == Instance2 and v.state == "revealed" then
                if u62 then
                    pcall(task.cancel, u62);
                    u62 = nil;
                end;

                if u63 then
                    hideUpgradeFrame();
                    u63 = false;
                end;

                u61 = nil;
                u61 = v;
                u62 = task.delay(0.35, function() -- Line: 533
                    -- upvalues: u61 (ref), v (copy), showUpgradeFrame (ref), u63 (ref), u62 (ref)
                    if u61 == v then
                        showUpgradeFrame(v);
                        u63 = true;
                    end;

                    u62 = nil;
                end);

                return;
            end;
        end;
    end);
    UserInputService.InputEnded:Connect(function(p68) -- Line: 545
        -- upvalues: u62 (ref), u63 (ref), hideUpgradeFrame (copy), u61 (ref)
        if p68.UserInputType == Enum.UserInputType.Touch then
            if u62 then
                pcall(task.cancel, u62);
                u62 = nil;
            end;

            if u63 then
                hideUpgradeFrame();
                u63 = false;
            end;

            u61 = nil;
        end;
    end);
    SetupButton({
        instance = BeeSkillTreeUI.CloseButton,

        onclick = function() -- Line: 553, Name: onclick
            -- upvalues: hideUpgradeFrame (copy), u9 (copy), destroyTopTree (copy), ReplicatedStorage (ref), u14 (ref), GuiController (ref), BeeSkillTreeUI (ref)
            hideUpgradeFrame();

            while #u9 > 0 do
                destroyTopTree();
            end;

            local SkillTree_Main = ReplicatedStorage:FindFirstChild("SkillTree_Main");

            if SkillTree_Main then
                SkillTree_Main:Destroy();
            end;

            u14 = nil;
            GuiController:Close(BeeSkillTreeUI);
        end
    });
    BeeSkillTreeUI.CloseButton.Active = true;
    BeeSkillTreeUI.CloseButton.Selectable = true;
    local Highlight = Instance.new("Highlight");
    Highlight.Name = "SkillTreeHighlight";
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = ReplicatedStorage;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    local u69 = nil;
    local u70 = {};

    local function softClampZoom(p71: number) -- Line: 582
        -- upvalues: u2 (ref)
        local Min = u2.ZoomLimit.Min;
        local Max = u2.ZoomLimit.Max;

        if p71 < Min then
            return Min + math.max((p71 - Min) * 0.18, -4);
        end;

        if Max < p71 then
            return Max + math.min((p71 - Max) * 0.12, 4);
        end;

        return p71;
    end;

    local function buildMainTree() -- Line: 595
        -- upvalues: V2 (ref), u3 (ref), u48 (ref), u30 (ref), showUpgradeFrame (copy), u45 (ref), u14 (ref), u9 (copy), ScaleNode (ref)
        local _, v75 = V2.generate(67683, (workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -25)).Position, u3, function(p72) -- Line: 600
            -- upvalues: u48 (ref)
            u48(p72);
        end, function(p73) -- Line: 601
            -- upvalues: u30 (ref), showUpgradeFrame (ref)
            if u30 == p73 then
                showUpgradeFrame(p73);
            end;
        end, {
            isSubTree = false,

            onPageNodeClicked = function(p74) -- Line: 606, Name: onPageNodeClicked
                -- upvalues: u45 (ref)
                u45(p74);
            end
        });
        u14 = v75;
        local v76 = {
            registry = v75,
            folder = workspace:FindFirstChild("SkillTree")
        };
        table.insert(u9, v76);
        local v77 = u14;

        if not v77 then
            return;
        end;

        for _, v in v77 do
            if v.node then
                ScaleNode(v.node);
            end;
        end;
    end;

    StateForGui.Visible:Observe(function(p78: boolean) -- Line: 614
        -- upvalues: Highlight (copy), hideUpgradeFrame (copy), u69 (ref), Controls (ref), u11 (ref), u12 (ref), u15 (ref), ContextActionService (ref), Spring (ref), BeeSkillTreeUI (ref), u70 (ref), u4 (ref), u5 (ref), CurrencyUI (ref), Position (ref), PlayerGui (ref), LocalPlayer (ref), UDim2_fromScale_ret (ref), SkillTreeSounds (ref), RunService (ref), u2 (ref), CFrame_Angles_ret (copy), UserInputService (ref), u30 (ref), u33 (ref), RaycastParams_new_ret (copy), u14 (ref), DataService (ref), showUpgradeFrame (copy), u13 (ref), u18 (ref), u27 (ref), Vector2_new_ret (ref), u28 (copy), buildMainTree (copy), u9 (copy), destroyTopTree (copy), ReplicatedStorage (ref)
        Highlight.Adornee = nil;
        Highlight.OutlineTransparency = 1;
        hideUpgradeFrame();

        if u69 then
            u69:Disconnect();
            u69 = nil;
        end;

        Controls[`{p78 and "Dis" or "En"}able`](Controls);

        if p78 then
            if LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:UnequipTools();
            end;

            u70 = {};

            for _, child in game.Players.LocalPlayer.PlayerGui:GetChildren() do
                if child:IsA("LayerCollector") then
                    u70[child] = child.Enabled;

                    if child.Name == "HoneyCoinCurrency_UI" then
                        if not u4 then
                            u4 = Instance.new("UIScale");
                            u4.Name = "BeeSkillTreeCurrencyScale";
                            u4.Scale = u5;
                            u4.Parent = CurrencyUI;
                        end;

                        CurrencyUI.Position = UDim2_fromScale_ret;
                        u4.Scale = 1.4;
                    elseif child.Name ~= "RoyalJellyCurrency_UI" then
                        child.Enabled = false;
                    end;
                end;
            end;

            SkillTreeSounds.Open:Play();
            ContextActionService:BindActionAtPriority("SkillTreeZoom", function(p79, p80, p81) -- Line: 680
                -- upvalues: u12 (ref), u11 (ref)
                if p81.KeyCode == Enum.KeyCode.ButtonL1 then
                    u12 = p80 == Enum.UserInputState.Begin;
                elseif p81.KeyCode == Enum.KeyCode.ButtonR1 then
                    u11 = p80 == Enum.UserInputState.Begin;
                end;

                return Enum.ContextActionResult.Sink;
            end, false, 9999, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
            Spring.target(BeeSkillTreeUI.CloseButton, 0.8, 3, {
                Position = UDim2.fromScale(0.95, 0.133)
            });
            u69 = RunService.RenderStepped:Connect(function(p82) -- Line: 690
                -- upvalues: u11 (ref), u12 (ref), u2 (ref), CFrame_Angles_ret (ref), UserInputService (ref), u30 (ref), u33 (ref), Highlight (ref), RaycastParams_new_ret (ref), Spring (ref), SkillTreeSounds (ref), u14 (ref), DataService (ref), showUpgradeFrame (ref), hideUpgradeFrame (ref)
                if u11 or u12 then
                    local workspace_CurrentCamera = workspace.CurrentCamera;
                    local Position2 = workspace_CurrentCamera.CFrame.Position;
                    local v83 = 0;

                    if u11 then
                        v83 = v83 - 1;
                    end;

                    if u12 then
                        v83 = v83 + 1;
                    end;

                    local v84 = Position2.Y + v83 * 22 * p82;
                    local Min = u2.ZoomLimit.Min;
                    local Max = u2.ZoomLimit.Max;

                    if v84 < Min then
                        v84 = Min + math.max((v84 - Min) * 0.18, -4);
                    elseif Max < v84 then
                        v84 = Max + math.min((v84 - Max) * 0.12, 4);
                    end;

                    workspace_CurrentCamera.CFrame = CFrame.new(Position2.X, v84, Position2.Z) * CFrame_Angles_ret;
                end;

                for _, v in UserInputService:GetGamepadState(Enum.UserInputType.Gamepad1) do
                    if v.KeyCode == Enum.KeyCode.Thumbstick1 then
                        local X = v.Position.X;
                        local Y = v.Position.Y;

                        if math.abs(X) > 0.15 or math.abs(Y) > 0.15 then
                            local workspace_CurrentCamera = workspace.CurrentCamera;
                            local Position2 = workspace_CurrentCamera.CFrame.Position;
                            local DragBounds = u2.DragBounds;

                            local function softClamp(p85) -- Line: 719
                                -- upvalues: DragBounds (copy)
                                if DragBounds < p85 then
                                    return DragBounds + (p85 - DragBounds) * 0.2;
                                end;

                                if p85 < -DragBounds then
                                    return -DragBounds + (p85 + DragBounds) * 0.2;
                                end;

                                return p85;
                            end;

                            local v86 = Position2.X - 500 - Y * 0.15;
                            local v87 = Position2.Z - X * 0.15;

                            if DragBounds < v86 then
                                v86 = DragBounds + (v86 - DragBounds) * 0.2;
                            elseif v86 < -DragBounds then
                                v86 = -DragBounds + (v86 + DragBounds) * 0.2;
                            end;

                            if DragBounds < v87 then
                                v87 = DragBounds + (v87 - DragBounds) * 0.2;
                            elseif v87 < -DragBounds then
                                v87 = -DragBounds + (v87 + DragBounds) * 0.2;
                            end;

                            workspace_CurrentCamera.CFrame = CFrame.new(v86 + 500, Position2.Y, v87) * CFrame_Angles_ret;
                        end;
                    end;
                end;

                if u30 then
                    u33();
                end;

                local SkillTree = workspace:FindFirstChild("SkillTree");

                if not SkillTree then
                    Highlight.Adornee = nil;

                    return;
                end;

                if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
                    if Highlight.Adornee then
                        Highlight.Adornee = nil;
                        Highlight.OutlineTransparency = 1;
                    end;

                    return;
                end;

                RaycastParams_new_ret.FilterDescendantsInstances = { SkillTree };
                local MouseLocation = UserInputService:GetMouseLocation();
                local v88 = workspace.CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y);
                local v89 = workspace:Raycast(v88.Origin, v88.Direction * 100, RaycastParams_new_ret);

                if not (v89 and v89.Instance) then
                    Highlight.Adornee = nil;
                    Highlight.OutlineTransparency = 1;

                    if u30 then
                        hideUpgradeFrame();
                    end;

                    return;
                end;

                local Instance2 = v89.Instance;

                while Instance2 and not Instance2:FindFirstChildOfClass("ClickDetector") do
                    Instance2 = Instance2.Parent;

                    if Instance2 == SkillTree or Instance2 == workspace then
                        Instance2 = nil;
                        break;
                    end;
                end;

                if Instance2 then
                    if Highlight.Adornee ~= Instance2 then
                        Highlight.Adornee = Instance2;
                        Spring.stop(Highlight, "OutlineTransparency");
                        Highlight.OutlineTransparency = 1;
                        Spring.target(Highlight, 1, 3, {
                            OutlineTransparency = 0
                        });
                        SkillTreeSounds.Hover:Play();
                    end;

                    local v90 = u14;

                    if v90 then
                        v90 = nil;

                        for _, v in u14 do
                            if v.node == Instance2 then
                                v90 = v;
                                break;
                            end;
                        end;
                    end;

                    if v90 and (v90.state == "revealed" or v90.state == "purchased") then
                        local Data = DataService:GetData();
                        Highlight.OutlineColor = (v90.state == "purchased" or v90.isPageNode or (v90.isBackNode or (Data and (Data.SpecialCurrency and Data.SpecialCurrency.HoneyCoins) or 0) >= v90.cost)) and Color3.new(1, 1, 1) or Color3.fromRGB(255, 60, 60);

                        if u30 ~= v90 then
                            showUpgradeFrame(v90);
                        end;
                    else
                        Highlight.OutlineColor = Color3.new(1, 1, 1);

                        if u30 then
                            hideUpgradeFrame();
                        end;
                    end;
                else
                    Highlight.Adornee = nil;
                    Highlight.OutlineTransparency = 1;

                    if u30 then
                        hideUpgradeFrame();
                    end;
                end;
            end);
        else
            u11 = false;
            u12 = false;
            u15 = false;
            ContextActionService:UnbindAction("SkillTreeZoom");
            Spring.stop(workspace.CurrentCamera, "CFrame");
            Spring.stop(BeeSkillTreeUI.CloseButton, "Position");
            BeeSkillTreeUI.CloseButton.Position = UDim2.fromScale(1.1, 0.133);

            for i, v in u70 do
                if i:IsDescendantOf(game.Players.LocalPlayer) then
                    i.Enabled = v;
                end;
            end;

            if not u4 then
                u4 = Instance.new("UIScale");
                u4.Name = "BeeSkillTreeCurrencyScale";
                u4.Scale = u5;
                u4.Parent = CurrencyUI;
            end;

            CurrencyUI.Position = Position;
            u4.Scale = u5;
            task.spawn(function() -- Line: 643
                -- upvalues: PlayerGui (ref)
                PlayerGui.Bottom_UI.Enabled = true;
                PlayerGui.GearHover_UI.Enabled = true;
                PlayerGui.Gift_Notification.Enabled = true;
                PlayerGui.Hud_UI.Enabled = true;
                PlayerGui.PetUI.Enabled = true;
                PlayerGui.PickupTally.Enabled = true;
                PlayerGui.PlantHover_UI.Enabled = true;
                PlayerGui.Pop_Effect.Enabled = true;
                PlayerGui.Rejoin_UI.Enabled = true;
                PlayerGui.Teleport_UI.Enabled = true;
                PlayerGui.Top_Notification.Enabled = true;
                PlayerGui.Tutorial_UI.Enabled = true;
                PlayerGui.BackpackGui.Enabled = true;

                if PlayerGui:FindFirstChild("TouchGui") then
                    PlayerGui.TouchGui.Enabled = true;
                end;
            end);
        end;

        workspace.CurrentCamera.CameraType = p78 and Enum.CameraType.Scriptable or Enum.CameraType.Custom;

        if not p78 then
            if u13 then
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position) * u13;

                while #u9 > 0 do
                    destroyTopTree();
                end;

                local SkillTree_Main = ReplicatedStorage:FindFirstChild("SkillTree_Main");

                if SkillTree_Main then
                    SkillTree_Main:Destroy();
                end;

                u14 = nil;
            end;

            return;
        end;

        u13 = workspace.CurrentCamera.CFrame.Rotation;
        u11 = false;
        u12 = false;
        u15 = false;
        u18 = 0;
        u27 = nil;
        Vector2_new_ret = Vector2.new(0, 0);
        Spring.stop(workspace.CurrentCamera, "CFrame");
        workspace.CurrentCamera.CFrame = u28;
        buildMainTree();
    end);
    UpdateService.OnUpdated:Connect(function() -- Line: 828
        -- upvalues: StateForGui (copy), hideUpgradeFrame (copy), u9 (copy), destroyTopTree (copy), ReplicatedStorage (ref), u14 (ref), u11 (ref), u12 (ref), u15 (ref), u18 (ref), u27 (ref), Vector2_new_ret (ref), Spring (ref), u28 (copy), buildMainTree (copy)
        if not StateForGui.Visible:Get() then
            return;
        end;

        hideUpgradeFrame();

        while #u9 > 0 do
            destroyTopTree();
        end;

        local SkillTree_Main = ReplicatedStorage:FindFirstChild("SkillTree_Main");

        if SkillTree_Main then
            SkillTree_Main:Destroy();
        end;

        u14 = nil;
        u11 = false;
        u12 = false;
        u15 = false;
        u18 = 0;
        u27 = nil;
        Vector2_new_ret = Vector2.new(0, 0);
        Spring.stop(workspace.CurrentCamera, "CFrame");
        workspace.CurrentCamera.CFrame = u28;
        buildMainTree();
    end);
    local u91 = {
        [Enum.UserInputType.Gamepad1] = true,
        [Enum.UserInputType.Gamepad2] = true,
        [Enum.UserInputType.Gamepad3] = true,
        [Enum.UserInputType.Gamepad4] = true
    };
    UserInputService.InputChanged:Connect(function(p92) -- Line: 846
        -- upvalues: StateForGui (copy), u15 (ref), u2 (ref), Spring (ref), CFrame_Angles_ret (copy), u23 (ref), u18 (ref), u16 (ref), u19 (ref), u20 (ref), u17 (ref), u22 (ref), u21 (ref), Vector2_new_ret (ref)
        if not StateForGui.Visible:Get() then
            return;
        end;

        if p92.UserInputType ~= Enum.UserInputType.MouseWheel then
            if u15 and (u18 < 2 and (p92.UserInputType == Enum.UserInputType.MouseMovement or p92.UserInputType == Enum.UserInputType.Touch)) then
                local v93 = p92.Position - u16;
                local v94 = u19 * u20;
                local v95 = u17.X - 500 - v93.Y * v94;
                local v96 = u17.Z + v93.X * v94;
                local os_clock_ret = os.clock();
                local v97 = os_clock_ret - u22;

                if u21 and v97 > 0 then
                    local v98 = p92.Position - u21;
                    Vector2_new_ret = Vector2_new_ret:Lerp(Vector2.new(v98.X, v98.Y) / v97, (math.clamp(v97 * 30, 0, 1)));
                end;

                u21 = p92.Position;
                u22 = os_clock_ret;
                local DragBounds = u2.DragBounds;

                local function _(p99) -- Line: 893
                    -- upvalues: DragBounds (copy)
                    if DragBounds < p99 then
                        return DragBounds + (p99 - DragBounds) * 0.2;
                    end;

                    if p99 < -DragBounds then
                        return -DragBounds + (p99 + DragBounds) * 0.2;
                    end;

                    return p99;
                end;

                if DragBounds < v95 then
                    v95 = DragBounds + (v95 - DragBounds) * 0.2;
                elseif v95 < -DragBounds then
                    v95 = -DragBounds + (v95 + DragBounds) * 0.2;
                end;

                if DragBounds < v96 then
                    v96 = DragBounds + (v96 - DragBounds) * 0.2;
                elseif v96 < -DragBounds then
                    v96 = -DragBounds + (v96 + DragBounds) * 0.2;
                end;

                workspace.CurrentCamera.CFrame = CFrame.new(v95 + 500, workspace.CurrentCamera.CFrame.Position.Y, v96) * CFrame_Angles_ret;
            end;

            return;
        end;

        if u15 then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;
        local Min = u2.ZoomLimit.Min;
        local Max = u2.ZoomLimit.Max;
        local Y = workspace_CurrentCamera.CFrame.Position.Y;
        local v100 = -p92.Position.Z * 3.5;
        local v101;

        if Y < Min and v100 < 0 or Max < Y and v100 > 0 then
            v101 = Y + v100 * (Max < Y and v100 > 0 and 0.12 or 0.18);
        else
            v101 = Y + v100;

            if v101 < Min then
                v101 = Min + (v101 - Min) * 0.18;
            end;

            if Max < v101 then
                v101 = Max + (v101 - Max) * 0.12;
            end;
        end;

        local math_clamp_ret = math.clamp(v101, Min - 4, Max + 4);
        Spring.target(workspace_CurrentCamera, 0.9, 6, {
            CFrame = CFrame.new(workspace_CurrentCamera.CFrame.Position.X, math_clamp_ret, workspace_CurrentCamera.CFrame.Position.Z) * CFrame_Angles_ret
        });
        u23 = os.clock();
        local u102 = u23;
        task.delay(0.2, function() -- Line: 868
            -- upvalues: u23 (ref), u102 (copy), workspace_CurrentCamera (copy), u2 (ref), Spring (ref), CFrame_Angles_ret (ref)
            if u23 ~= u102 then
                return;
            end;

            local Position2 = workspace_CurrentCamera.CFrame.Position;
            local math_clamp_ret2 = math.clamp(Position2.Y, u2.ZoomLimit.Min, u2.ZoomLimit.Max);

            if math_clamp_ret2 ~= Position2.Y then
                Spring.target(workspace_CurrentCamera, 0.95, 4, {
                    CFrame = CFrame.new(Position2.X, math_clamp_ret2, Position2.Z) * CFrame_Angles_ret
                });
            end;
        end);
    end);
    UserInputService.TouchPinch:Connect(function(p103, p104, p105, p106) -- Line: 910
        -- upvalues: StateForGui (copy), u15 (ref), u27 (ref), u2 (ref), Spring (ref), CFrame_Angles_ret (copy)
        if not StateForGui.Visible:Get() then
            return;
        end;

        if p106 ~= Enum.UserInputState.Begin then
            if p106 == Enum.UserInputState.End or p106 == Enum.UserInputState.Cancel then
                local workspace_CurrentCamera = workspace.CurrentCamera;
                local Position2 = workspace_CurrentCamera.CFrame.Position;
                local math_clamp_ret = math.clamp(Position2.Y, u2.ZoomLimit.Min, u2.ZoomLimit.Max);

                if math_clamp_ret ~= Position2.Y then
                    Spring.target(workspace_CurrentCamera, 0.9, 5, {
                        CFrame = CFrame.new(Position2.X, math_clamp_ret, Position2.Z) * CFrame_Angles_ret
                    });

                    return;
                end;
            else
                local workspace_CurrentCamera = workspace.CurrentCamera;
                local v107 = u27 - (p104 - 1) * 28;
                local Min = u2.ZoomLimit.Min;
                local Max = u2.ZoomLimit.Max;

                if v107 < Min then
                    v107 = Min + math.max((v107 - Min) * 0.18, -4);
                elseif Max < v107 then
                    v107 = Max + math.min((v107 - Max) * 0.12, 4);
                end;

                Spring.target(workspace_CurrentCamera, 0.8, 8, {
                    CFrame = CFrame.new(workspace_CurrentCamera.CFrame.Position.X, v107, workspace_CurrentCamera.CFrame.Position.Z) * CFrame_Angles_ret
                });
            end;

            return;
        end;

        u15 = false;
        u27 = workspace.CurrentCamera.CFrame.Position.Y;
    end);
    UserInputService.InputBegan:Connect(function(p108, p109) -- Line: 930
        -- upvalues: u18 (ref), StateForGui (copy), u15 (ref), u16 (ref), u17 (ref), u25 (ref), u30 (ref), u24 (ref), UserInputService (ref), u26 (ref), PlayerGui (ref), Upgrade (copy), u19 (ref), u2 (ref), u20 (ref), u21 (ref), u22 (ref), Vector2_new_ret (ref), Spring (ref)
        if p108.UserInputType == Enum.UserInputType.Touch then
            u18 = u18 + 1;
        end;

        if p108.UserInputType == Enum.UserInputType.MouseButton1 or p108.UserInputType == Enum.UserInputType.Touch then
            if not StateForGui.Visible:Get() then
                return;
            end;

            if u18 > 1 then
                u15 = false;

                return;
            end;

            u15 = true;
            u16 = p108.Position;
            u17 = workspace.CurrentCamera.CFrame.Position;
            u25 = u30;
            u24 = false;
            local MouseLocation = UserInputService:GetMouseLocation();
            u26 = MouseLocation;

            if u30 then
                for _, v in PlayerGui:GetGuiObjectsAtPosition(MouseLocation.X, MouseLocation.Y) do
                    if v == Upgrade or v:IsDescendantOf(Upgrade) then
                        u24 = true;
                        break;
                    end;
                end;
            end;

            u19 = p108.UserInputType == Enum.UserInputType.Touch and 0.1 or 0.045;
            local ZoomLimit = u2.ZoomLimit;
            u20 = math.clamp((workspace.CurrentCamera.CFrame.Position.Y - ZoomLimit.Min) / (ZoomLimit.Max - ZoomLimit.Min), 0, 1) * 1.3 + 0.5;
            u21 = p108.Position;
            u22 = os.clock();
            Vector2_new_ret = Vector2.new(0, 0);
            Spring.stop(workspace.CurrentCamera, "CFrame");
        end;
    end);
    UserInputService.InputEnded:Connect(function(p110) -- Line: 973
        -- upvalues: u18 (ref), u15 (ref), StateForGui (copy), u2 (ref), u22 (ref), Vector2_new_ret (ref), u19 (ref), u20 (ref), Spring (ref), CFrame_Angles_ret (copy)
        if p110.UserInputType == Enum.UserInputType.Touch then
            u18 = math.max(u18 - 1, 0);
        end;

        if p110.UserInputType ~= Enum.UserInputType.MouseButton1 and p110.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        local v111 = u15;
        u15 = false;

        if not StateForGui.Visible:Get() then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;
        local Position2 = workspace_CurrentCamera.CFrame.Position;
        local DragBounds = u2.DragBounds;
        local X = Position2.X;
        local Z = Position2.Z;

        if v111 then
            if os.clock() - u22 > 0.06 then
                Vector2_new_ret = Vector2.new(0, 0);
            end;

            local v112 = u19 * u20;
            X = Position2.X - Vector2_new_ret.Y * v112 * 0.1;
            Z = Position2.Z + Vector2_new_ret.X * v112 * 0.1;
        end;

        local v113 = math.clamp(X - 500, -DragBounds, DragBounds) + 500;
        local math_clamp_ret = math.clamp(Z, -DragBounds, DragBounds);

        if v113 ~= Position2.X or math_clamp_ret ~= Position2.Z then
            Spring.target(workspace_CurrentCamera, 0.9, 5, {
                CFrame = CFrame.new(v113, Position2.Y, math_clamp_ret) * CFrame_Angles_ret
            });
        end;
    end);

    local function getKeyImage(u114) -- Line: 1009
        -- upvalues: UserInputService (ref)
        local success, result = pcall(function() -- Line: 1010
            -- upvalues: UserInputService (ref), u114 (copy)
            return UserInputService:GetImageForKeyCode(u114);
        end);

        return not (success and (typeof(result) == "string" and result ~= "")) and "" or result;
    end;

    local function isGamepad() -- Line: 1017
        -- upvalues: UserInputService (ref)
        return UserInputService.PreferredInput == Enum.PreferredInput.Gamepad;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "ConsoleLegend";
    Frame.AnchorPoint = Vector2.new(1, 1);
    Frame.Position = UDim2.new(1, -24, 1, -24);
    Frame.AutomaticSize = Enum.AutomaticSize.XY;
    Frame.Size = UDim2.fromOffset(0, 0);
    Frame.BackgroundTransparency = 1;
    Frame.Visible = false;
    Frame.Parent = BeeSkillTreeUI;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Vertical;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    UIListLayout.Padding = UDim.new(0, 6);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Parent = Frame;
    local u115 = {};

    for i, v in {
        {
            action = "Move between nodes",
            keyCode = Enum.KeyCode.Thumbstick1
        },
        {
            action = "Confirm purchase",
            keyCode = Enum.KeyCode.ButtonX
        },
        {
            action = "Back",
            keyCode = Enum.KeyCode.ButtonB
        },
        {
            action = "Zoom out",
            keyCode = Enum.KeyCode.ButtonL1
        },
        {
            action = "Zoom in",
            keyCode = Enum.KeyCode.ButtonR1
        }
    } do
        local Frame2 = Instance.new("Frame");
        Frame2.LayoutOrder = i;
        Frame2.AutomaticSize = Enum.AutomaticSize.X;
        Frame2.Size = UDim2.fromOffset(0, 36);
        Frame2.BackgroundTransparency = 1;
        Frame2.Parent = Frame;
        local UIListLayout2 = Instance.new("UIListLayout");
        UIListLayout2.FillDirection = Enum.FillDirection.Horizontal;
        UIListLayout2.VerticalAlignment = Enum.VerticalAlignment.Center;
        UIListLayout2.Padding = UDim.new(0, 6);
        UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout2.Parent = Frame2;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.LayoutOrder = 1;
        ImageLabel.Size = UDim2.fromOffset(32, 32);
        ImageLabel.BackgroundTransparency = 1;
        local keyCode = v.keyCode;
        local success, result = pcall(function() -- Line: 1010
            -- upvalues: UserInputService (ref), keyCode (copy)
            return UserInputService:GetImageForKeyCode(keyCode);
        end);
        ImageLabel.Image = not (success and (typeof(result) == "string" and result ~= "")) and "" or result;
        ImageLabel.Parent = Frame2;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.LayoutOrder = 2;
        TextLabel.AutomaticSize = Enum.AutomaticSize.X;
        TextLabel.Size = UDim2.fromOffset(0, 32);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Text = v.action;
        TextLabel.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold);
        TextLabel.TextSize = 20;
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3.fromRGB(0, 0, 0);
        UIStroke.Thickness = 2;
        UIStroke.Parent = TextLabel;
        TextLabel.Parent = Frame2;
        u115[v.keyCode] = ImageLabel;
    end;

    local function refreshLegend() -- Line: 1091
        -- upvalues: StateForGui (copy), UserInputService (ref), Frame (copy), u115 (copy), GamepadService (ref)
        local v116 = StateForGui.Visible:Get() and UserInputService.PreferredInput == Enum.PreferredInput.Gamepad;
        Frame.Visible = v116;

        if not v116 then
            GamepadService:DisableGamepadCursor();

            return;
        end;

        for i, v in u115 do
            local success, result = pcall(function() -- Line: 1010
                -- upvalues: UserInputService (ref), i (copy)
                return UserInputService:GetImageForKeyCode(i);
            end);
            v.Image = not (success and (typeof(result) == "string" and result ~= "")) and "" or result;
        end;

        task.defer(function() -- Line: 1101
            -- upvalues: StateForGui (ref), UserInputService (ref), GamepadService (ref)
            if StateForGui.Visible:Get() and UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
                GamepadService:EnableGamepadCursor(nil);
            end;
        end);
    end;

    StateForGui.Visible:Listen(refreshLegend);
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(refreshLegend);
    refreshLegend();
    UserInputService.InputBegan:Connect(function(p117, p118) -- Line: 1119
        -- upvalues: StateForGui (copy), u91 (copy), UserInputService (ref), PlayerGui (ref), u14 (ref), SkillTreeSounds (ref)
        if p118 then
            return;
        end;

        if not StateForGui.Visible:Get() then
            return;
        end;

        if not u91[p117.UserInputType] then
            return;
        end;

        if p117.KeyCode ~= Enum.KeyCode.ButtonX then
            return;
        end;

        local MouseLocation = UserInputService:GetMouseLocation();
        PlayerGui:GetGuiObjectsAtPosition(MouseLocation.X, MouseLocation.Y);
        local SkillTree = workspace:FindFirstChild("SkillTree");

        if SkillTree and u14 then
            local RaycastParams_new_ret2 = RaycastParams.new();
            RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Include;
            RaycastParams_new_ret2.FilterDescendantsInstances = { SkillTree };
            local v119 = workspace.CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y);
            local v120 = workspace:Raycast(v119.Origin, v119.Direction * 100, RaycastParams_new_ret2);

            if v120 and v120.Instance then
                local Instance2 = v120.Instance;

                while Instance2 and not Instance2:FindFirstChildOfClass("ClickDetector") do
                    Instance2 = Instance2.Parent;

                    if Instance2 == SkillTree or Instance2 == workspace then
                        Instance2 = nil;
                        break;
                    end;
                end;

                if Instance2 then
                    for _, v in u14 do
                        if v.node == Instance2 then
                            if v.state == "revealed" then
                                SkillTreeSounds.Click:Play();
                                v:purchase();
                            end;

                            return;
                        end;
                    end;
                end;
            end;
        end;
    end);
end;

task.spawn(v1.Start);

return v1;