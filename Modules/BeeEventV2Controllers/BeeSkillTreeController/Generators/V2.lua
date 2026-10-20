-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local DataService = require(ReplicatedStorage.Modules.DataService);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local Spring = require(ReplicatedStorage.Modules.Spring);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local PurchaseUpgrade = ReplicatedStorage.GameEvents.BeeSkillTreeService.PurchaseUpgrade;
local PurchaseCombatUpgrade = ReplicatedStorage.GameEvents.BeeSkillTreeService.PurchaseCombatUpgrade;
local Config = require(script.Parent.Parent.Config);
local UPGRADE_CONFIG = Config.UPGRADE_CONFIG;
local PAGE_NODES = Config.PAGE_NODES;
local SUB_TREE_CONFIGS = Config.SUB_TREE_CONFIGS;
local SUB_TREE_ORIGIN = Config.SUB_TREE_ORIGIN;
local v1 = {};
v1.__index = v1;
local Node = script.Parent.Parent.Node;
local u2 = {
    Vector2.new(1, 0),
    Vector2.new(0.5, 1),
    Vector2.new(-0.5, 1),
    Vector2.new(-1, 0),
    Vector2.new(-0.5, -1),
    Vector2.new(0.5, -1)
};

local function Emit(p3: userdata) -- Line: 34
    for _, v in p3:QueryDescendants("ParticleEmitter") do
        v:Emit(v:GetAttribute("EmitCount") or 1);
    end;
end;

local function hexDistance(p4, p5, p6, p7) -- Line: 40
    return (math.abs(p4 - p6) + math.abs(p4 - p6 + p5 - p7) + math.abs(p5 - p7)) / 2;
end;

local Vector2_new_ret = Vector2.new(5.095199966430664, 4.527950119972229);

local function hexToWorld(p8: vector, p9: number, p10: number) -- Line: 46
    -- upvalues: Vector2_new_ret (copy)
    return Vector3.new(p8.X + p9 * Vector2_new_ret.X, p8.Y, p8.Z + p10 * Vector2_new_ret.Y);
end;

local function darken(p11, p12: number) -- Line: 50
    return Color3.new(p11.R * p12, p11.G * p12, p11.B * p12);
end;

local function brightenWhiten(p13, p14: number, p15: number) -- Line: 54
    local v16 = p13.G + (1 - p13.G) * p15;
    local v17 = p13.B + (1 - p13.B) * p15;

    return Color3.new(math.min((p13.R + (1 - p13.R) * p15) * p14, 1), math.min(v16 * p14, 1), (math.min(v17 * p14, 1)));
end;

local u18 = {};

local function pickColor() -- Line: 64
    -- upvalues: u18 (ref)
    local v19 = 0;

    while true do
        local math_random_ret = math.random();
        local v20 = false;

        for _, v in u18 do
            local math_abs_ret = math.abs(math_random_ret - v);

            if math.min(math_abs_ret, 1 - math_abs_ret) < 0.15 then
                v20 = true;
            end;
        end;

        v19 = v19 + 1;

        if not v20 or v19 > 100 then
            table.insert(u18, math_random_ret);

            return Color3.fromHSV(math_random_ret, 0.7, 0.9);
        end;
    end;
end;

local function toRoman(p21: number) -- Line: 84
    return ({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[p21] or tostring(p21);
end;

local function formatLabel(p22: string, p23: number, p24: string?) -- Line: 89
    return (p24 or p22:gsub("(%u)", function(p25) -- Line: 90
        return " " .. p25;
    end):gsub("^ ", "")) .. "<br/>" .. (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[p23] or tostring(p23));
end;

local function posKey(p26, p27) -- Line: 96
    return math.round(p26 * 10) .. "," .. math.round(p27 * 10);
end;

local function applyPanelState(p28: any, p29: boolean) -- Line: 105
    local Background = p28.Surface:FindFirstChild("Background");

    if Background then
        local Hidden = Background:FindFirstChild("Hidden");
        local Revealed = Background:FindFirstChild("Revealed");

        if Hidden then
            Hidden.Visible = not p29;
        end;

        if Revealed then
            Revealed.Visible = p29;
        end;
    end;

    local Hidden = p28.Surface:FindFirstChild("Hidden");
    local Revealed = p28.Surface:FindFirstChild("Revealed");

    if Hidden then
        Hidden.Visible = not p29;
    end;

    if Revealed then
        Revealed.Visible = p29;
    end;
end;

local function applyNodeColor(p30: any, p31) -- Line: 120
    -- upvalues: brightenWhiten (copy)
    local Background = p30.Surface:FindFirstChild("Background");

    if Background then
        local Revealed = Background:FindFirstChild("Revealed");
        local v32 = Revealed and Revealed:FindFirstChild("Background");

        if v32 then
            v32.ImageColor3 = p31;
        end;
    end;

    local Revealed = p30.Surface:FindFirstChild("Revealed");
    local v33 = Revealed and Revealed:FindFirstChild("Glow");

    if v33 then
        v33.ImageColor3 = brightenWhiten(p31, 1.35, 0.4);
    end;
end;

local function applyPageNodeStyle(u34: any, p35) -- Line: 141
    -- upvalues: applyNodeColor (copy), applyPanelState (copy), Spring (copy)
    applyNodeColor(u34, p35);
    applyPanelState(u34, true);
    local Revealed = u34.Surface:FindFirstChild("Revealed");
    local u36 = Revealed and Revealed:FindFirstChild("Glow");

    if u36 then
        task.spawn(function() -- Line: 148
            -- upvalues: u34 (copy), Spring (ref), u36 (copy)
            local v37 = 0;

            while u34.Parent do
                v37 = v37 + task.wait(0.05);
                local v38 = (math.sin(v37 * 2.5) + 1) * 0.5;
                Spring.target(u36, 0.3, 4, {
                    ImageTransparency = v38 * 0.5 + 0.2
                });
            end;
        end);
    end;
end;

local function applyBackNodeStyle(p39) -- Line: 162
    -- upvalues: applyPanelState (copy), applyNodeColor (copy)
    applyPanelState(p39, true);
    applyNodeColor(p39, Color3.fromRGB(120, 120, 140));
end;

function v1.generate(p40: number, u41: vector, p42: table, u43: function, u44: function, u45: table?) -- Line: 167
    -- upvalues: u18 (ref), u2 (copy), applyPanelState (copy), Spring (copy), applyNodeColor (copy), NumberUtil (copy), DataService (copy), applyPageNodeStyle (copy), PurchaseCombatUpgrade (copy), PurchaseUpgrade (copy), Emit (copy), SoundService (copy), UPGRADE_CONFIG (copy), SUB_TREE_CONFIGS (copy), Node (copy), Vector2_new_ret (copy), pickColor (copy), formatLabel (copy), PAGE_NODES (copy), UpdateService (copy), SUB_TREE_ORIGIN (copy)
    local u46 = workspace:FindFirstChild("SkillTree") or Instance.new("Folder");
    u46.Name = "SkillTree";
    u46.Parent = workspace;
    math.randomseed(p40);
    u18 = {};
    local v47 = #u2;
    local v48 = {};
    local u49 = {};
    local u50 = {};
    local u51 = nil;

    for _, v in p42 do
        if v.IsOrigin then
            u51 = v;
        else
            table.insert(v48, v);
        end;
    end;

    local function u54(u52, p53) -- Line: 206
        -- upvalues: applyPanelState (ref), u46 (copy), Spring (ref)
        if u52.state ~= "hidden" then
            return;
        end;

        u52.state = "adjacent";
        local node = u52.node;
        applyPanelState(node, false);
        node.Parent = u46;
        task.delay(p53 or 0, function() -- Line: 214
            -- upvalues: u52 (copy), Spring (ref), node (copy)
            if u52.state ~= "adjacent" then
                return;
            end;

            Spring.target(node, 1, 3, {
                Size = Vector3.new(4.632, 0.107, 5.327),
                Color = Color3.fromRGB(80, 80, 80)
            });
            local Idle = node:FindFirstChild("Idle");

            for _, v in Idle and Idle:GetChildren() or {} do
                if v:IsA("ParticleEmitter") then
                    v.Enabled = false;
                end;
            end;

            local Highlight = node:FindFirstChild("Highlight");

            if Highlight then
                Spring.target(Highlight, 1, 3, {
                    Color = Color3.fromRGB(30, 30, 30)
                });
            end;
        end);
    end;

    local function u62(u55, p56) -- Line: 237
        -- upvalues: applyNodeColor (ref), applyPanelState (ref), Spring (ref), u46 (copy), u2 (ref), u49 (copy), u54 (ref), u43 (copy), NumberUtil (ref), DataService (ref), applyPageNodeStyle (ref)
        if u55.state ~= "adjacent" and u55.state ~= "hidden" then
            return;
        end;

        u55.state = "revealed";
        local node = u55.node;
        local v57 = node:FindFirstChildOfClass("ClickDetector");

        if v57 then
            v57:Destroy();
        end;

        applyNodeColor(node, u55.color);
        applyPanelState(node, true);
        local Idle = node:FindFirstChild("Idle");

        for _, v in Idle and Idle:GetChildren() or {} do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;

        local Revealed = node.Surface:FindFirstChild("Revealed");

        if Revealed then
            local Icon = Revealed:FindFirstChild("Icon");
            local Name = Revealed:FindFirstChild("Name");

            if Icon then
                Icon.Image = u55.icon;
                Spring.target(Icon, 1, 3, {
                    Size = u55.iconSize
                });
            end;

            if Name then
                if u55.isPageNode or (u55.isBackNode or u55.isAbilityNode) then
                    Name.Text = u55.label;
                elseif u55.levels > 1 then
                    Name.Text = u55.label .. "<br/>(0/" .. u55.levels .. ")";
                else
                    Name.Text = u55.label .. "<br/>(0/1)";
                end;
            end;
        end;

        node.Color = u55.color;
        local Highlight = node:FindFirstChild("Highlight");

        if Highlight then
            local color = u55.color;
            Highlight.Color = Color3.new(color.R * 0.25, color.G * 0.25, color.B * 0.25);
        end;

        task.delay(p56 or 0, function() -- Line: 277
            -- upvalues: Spring (ref), node (copy), u55 (copy)
            Spring.stop(node, "Color");
            Spring.stop(node, "Size");
            Spring.target(node, 1, 3, {
                Size = Vector3.new(4.632, 0.107, 5.327),
                Color = u55.color
            });
        end);
        node.Parent = u46;

        for _, v in u2 do
            local v58 = u55.r + v.Y;
            local v59 = u49[math.round((u55.q + v.X) * 10) .. "," .. math.round(v58 * 10)];

            if v59 and v59.state == "hidden" then
                u54(v59, (p56 or 0) + 0.1);
            end;
        end;

        local ClickDetector = Instance.new("ClickDetector");
        ClickDetector.CursorIcon = "rbxasset://textures/Cursors/KeyboardMouse/ArrowCursor.png";
        ClickDetector.MaxActivationDistance = 1000;
        ClickDetector.Parent = node;

        if u43 then
            u43(u55);
        end;

        local u60;

        if Revealed then
            u60 = Revealed:FindFirstChild("PriceLabel");
        else
            u60 = Revealed;
        end;

        if Revealed then
            Revealed = Revealed:FindFirstChild("CurrencyIcon");
        end;

        if u60 then
            if u55.isPageNode or u55.isBackNode then
                u60.Visible = false;
            else
                u60.Visible = true;
                u60.Text = NumberUtil.FormatCompactPrice(u55.cost);
            end;
        end;

        if Revealed then
            Revealed.Visible = not (u55.isPageNode or u55.isBackNode);
        end;

        local function updateAffordability() -- Line: 315
            -- upvalues: DataService (ref), u60 (copy), u55 (copy)
            local Data = DataService:GetData();
            local v61 = Data and (Data.SpecialCurrency and Data.SpecialCurrency.HoneyCoins) or 0;

            if u60 then
                u60.TextColor3 = u55.cost <= v61 and Color3.new(1, 1, 1) or Color3.fromRGB(255, 60, 60);
            end;
        end;

        updateAffordability();

        if u55.isPageNode then
            applyPageNodeStyle(node, u55.color);
        elseif u55.isAbilityNode then
            applyPageNodeStyle(node, u55.color);
        end;

        u55.priceConn = DataService:GetPathSignal("SpecialCurrency/HoneyCoins"):Connect(updateAffordability);
    end;

    local function u67(p63, p64, p65) -- Line: 335
        -- upvalues: Spring (ref), applyNodeColor (ref), applyPanelState (ref), u46 (copy)
        p63.state = "purchased";
        local node = p63.node;

        if not node:FindFirstChildOfClass("ClickDetector") then
            local ClickDetector = Instance.new("ClickDetector");
            ClickDetector.CursorIcon = "rbxasset://textures/Cursors/KeyboardMouse/ArrowCursor.png";
            ClickDetector.MaxActivationDistance = 1000;
            ClickDetector.Parent = node;
        end;

        Spring.stop(node, "Color");
        Spring.stop(node, "Size");
        node.Color = p63.color;
        local Highlight = node:FindFirstChild("Highlight");

        if Highlight then
            local color = p63.color;
            Highlight.Color = Color3.new(color.R * 0.25, color.G * 0.25, color.B * 0.25);
        end;

        applyNodeColor(node, p63.color);
        applyPanelState(node, true);
        local Revealed = node.Surface:FindFirstChild("Revealed");

        if Revealed then
            local Icon = Revealed:FindFirstChild("Icon");
            local Name = Revealed:FindFirstChild("Name");
            local PriceLabel = Revealed:FindFirstChild("PriceLabel");
            local CurrencyIcon = Revealed:FindFirstChild("CurrencyIcon");

            if Icon then
                Icon.Image = p63.icon;
                Icon.Size = p63.iconSize;
            end;

            if Name then
                Name.Text = p63.label;
            end;

            if PriceLabel then
                PriceLabel.Visible = false;
            end;

            if CurrencyIcon then
                CurrencyIcon.Visible = false;
            end;
        end;

        node.Parent = u46;

        if p64 then
            node.Size = Vector3.new(0, 0, 0);
            local v66 = math.sqrt(p63.q ^ 2 + p63.r ^ 2) * 0.15;
            task.delay(p65 or v66, function() -- Line: 373
                -- upvalues: Spring (ref), node (copy)
                Spring.target(node, 1, 3, {
                    Size = Vector3.new(4.632, 0.107, 5.327)
                });
                local Idle = node:FindFirstChild("Idle");

                for _, v in Idle and Idle:GetChildren() or {} do
                    if v:IsA("ParticleEmitter") then
                        v.Enabled = true;
                    end;
                end;
            end);

            return;
        end;

        Spring.target(node, 1, 3, {
            Size = Vector3.new(4.632, 0.107, 5.327),
            Color = p63.color
        });
        local Idle = node:FindFirstChild("Idle");

        for _, v in Idle and Idle:GetChildren() or {} do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;
    end;

    local function u81(u68) -- Line: 391
        -- upvalues: PurchaseCombatUpgrade (ref), u45 (copy), PurchaseUpgrade (ref), u67 (ref), Emit (ref), u49 (copy), Spring (ref), u2 (ref), u62 (ref), SoundService (ref), u44 (copy), DataService (ref), UPGRADE_CONFIG (ref), SUB_TREE_CONFIGS (ref), NumberUtil (ref)
        if u68.isPageNode or u68.isBackNode then
            return;
        end;

        if u68.state ~= "revealed" then
            return;
        end;

        local v69;

        if u68.isAbilityNode then
            v69 = PurchaseCombatUpgrade:InvokeServer(u45.subTreeName, u68.abilityName, 1);
        elseif u45 and (u45.isSubTree and u45.subTreeName) then
            v69 = PurchaseCombatUpgrade:InvokeServer(u45.subTreeName, u68.upgradeName, u68.tier);
        else
            v69 = PurchaseUpgrade:InvokeServer(u68.upgradeName, u68.tier);
        end;

        if not v69 or v69 == false then
            return;
        end;

        u68.progress = v69.progress;
        u68.levels = v69.levels;
        local Revealed = u68.node.Surface:FindFirstChild("Revealed");
        local v70;

        if Revealed then
            v70 = Revealed:FindFirstChild("Name");
        else
            v70 = Revealed;
        end;

        if not v69.tierComplete then
            if v70 then
                v70.Text = u68.label .. "<br/>(" .. u68.progress .. "/" .. u68.levels .. ")";
            end;

            if u44 then
                u44(u68);
            end;

            local Data = DataService:GetData();
            local v71 = Data and (Data.SpecialCurrency and Data.SpecialCurrency.HoneyCoins) or 0;

            if Revealed then
                Revealed = Revealed:FindFirstChild("PriceLabel");
            end;

            if Revealed then
                local v72 = UPGRADE_CONFIG[u68.upgradeName] or u45 and (u45.subTreeName and SUB_TREE_CONFIGS[u45.subTreeName]) and SUB_TREE_CONFIGS[u45.subTreeName][u68.upgradeName];
                local v73 = v72 and (v72.CostPerTier[u68.tier] or 0) or 0;
                local v74 = u68.progress == 0 and v73 and v73 or math.round(v73 * (v72 and v72.CostScalePerTier and (v72.CostScalePerTier[u68.tier] or 1) or 1));
                u68.cost = v74;
                Revealed.Text = NumberUtil.FormatCompactPrice(v74);
                Revealed.TextColor3 = v74 <= v71 and Color3.new(1, 1, 1) or Color3.fromRGB(255, 60, 60);
            end;

            return;
        end;

        u67(u68);

        if u68.priceConn then
            pcall(u68.priceConn.Disconnect, u68.priceConn);
            u68.priceConn = nil;
        end;

        Emit(u68.node.Upgrade);
        local Position = u68.node.Position;
        local UpVector = u68.node.CFrame.UpVector;

        for _, v in u49 do
            if v ~= u68 then
                local q = u68.q;
                local r = u68.r;
                local q2 = v.q;
                local r2 = v.r;
                local v75 = (math.abs(q - q2) + math.abs(q - q2 + r - r2) + math.abs(r - r2)) / 2 * 0.14;
                task.delay(v75, function() -- Line: 430
                    -- upvalues: v (copy), Position (copy), UpVector (copy), u68 (copy), Spring (ref)
                    if not (v.node and v.node.Parent) then
                        return;
                    end;

                    local originalCFrame = v.originalCFrame;
                    local Position2 = originalCFrame.Position;
                    local v76 = Position2 - Position;
                    local v77;

                    if v76.Magnitude > 0.001 then
                        local v78 = v76.Unit:Cross(UpVector);

                        if v78.Magnitude > 0.001 then
                            v77 = v78.Unit;
                        else
                            v77 = u68.node.CFrame.LookVector;
                        end;
                    else
                        v77 = u68.node.CFrame.LookVector;
                    end;

                    Spring.stop(v.node, "Size");
                    Spring.stop(v.node, "CFrame");
                    v.node.Size = Vector3.new(5.3268, 0.12305, 6.12605);
                    local CFrame_fromAxisAngle_ret = CFrame.fromAxisAngle(v77, 2.9670597283903604);
                    v.node.CFrame = CFrame_fromAxisAngle_ret * (originalCFrame - Position2) + Position2;
                    Spring.target(v.node, 0.65, 1.4, {
                        Size = Vector3.new(4.632, 0.107, 5.327)
                    });
                    Spring.target(v.node, 0.7, 1.4, {
                        CFrame = originalCFrame
                    });
                end);
            end;
        end;

        for _, v in u2 do
            local v79 = u68.r + v.Y;
            local v80 = u49[math.round((u68.q + v.X) * 10) .. "," .. math.round(v79 * 10)];

            if v80 and (v80.state == "hidden" or v80.state == "adjacent") then
                u62(v80);
                SoundService.SkillTreeSounds.Flip:Play();
            end;
        end;
    end;

    local function placeNode(p82, p83, p84, p85, p86, p87, p88, p89, p90) -- Line: 487
        -- upvalues: u49 (copy), Node (ref), u41 (copy), Vector2_new_ret (ref), applyPanelState (ref), UPGRADE_CONFIG (ref), u45 (copy), SUB_TREE_CONFIGS (ref), u81 (ref), u50 (copy)
        local v91 = math.round(p82 * 10) .. "," .. math.round(p83 * 10);

        if u49[v91] then
            warn("[SkillTree] Collision at", v91, "for", p88, p89, "existing:", u49[v91].upgradeName, u49[v91].tier);

            return nil;
        end;

        local v92 = Node:Clone();
        v92.Size = Vector3.new(0, 0, 0);
        local v93 = u41;
        v92.CFrame = CFrame.new((Vector3.new(v93.X + p82 * Vector2_new_ret.X, v93.Y, v93.Z + p83 * Vector2_new_ret.Y)));
        v92.Color = p84;
        local Highlight = v92:FindFirstChild("Highlight");

        if Highlight then
            Highlight.Color = Color3.new(p84.R * 0.25, p84.G * 0.25, p84.B * 0.25);
        end;

        applyPanelState(v92, false);
        local Revealed = v92.Surface:FindFirstChild("Revealed");

        if Revealed then
            local PriceLabel = Revealed:FindFirstChild("PriceLabel");
            local CurrencyIcon = Revealed:FindFirstChild("CurrencyIcon");

            if PriceLabel then
                PriceLabel.Visible = false;
            end;

            if CurrencyIcon then
                CurrencyIcon.Visible = false;
            end;
        end;

        v92.Parent = nil;

        if Revealed then
            Revealed = Revealed:FindFirstChild("Icon");
        end;

        local v94 = Revealed and Revealed.Size or UDim2.fromScale(0.8, 0.8);
        local v95 = UPGRADE_CONFIG[p88];

        if not v95 and (u45 and u45.subTreeName) then
            v95 = SUB_TREE_CONFIGS[u45.subTreeName];

            if v95 then
                v95 = v95[p88];
            end;
        end;

        local v97 = {
            state = "hidden",
            progress = 0,
            node = v92,
            q = p82,
            r = p83,
            color = p84,
            icon = p85,
            label = p86,
            description = p90,
            iconSize = v94,
            upgradeName = p88,
            tier = p89,
            delay = p87,
            cost = v95 and v95.CostPerTier and (v95.CostPerTier[p89] or 0) or 0,
            levels = v95 and (v95.LevelsPerTier and v95.LevelsPerTier[p89] or 1) or 1,

            purchase = function(p96) -- Line: 538, Name: purchase
                -- upvalues: u81 (ref)
                u81(p96);
            end
        };
        local v98 = u41;
        v97.originalCFrame = CFrame.new((Vector3.new(v98.X + p82 * Vector2_new_ret.X, v98.Y, v98.Z + p83 * Vector2_new_ret.Y)));
        u49[v91] = v97;
        table.insert(u50, v97);

        return v97;
    end;

    local v99 = {};

    for i = 1, v47 do
        table.insert(v99, i);
        local _ = i;
    end;

    local v100 = pickColor();
    local u101 = placeNode(0, 0, v100, u51.Icon, formatLabel(u51.Name, 1, u51.DisplayName), 0, u51.Name, 1, u51.Description);

    if u51.Tiers > 1 then
        local table_remove_ret = table.remove(v99, math.random(#v99));
        local v102 = u2[table_remove_ret];
        local v103 = u2[(table_remove_ret - 2) % v47 + 1];
        local X = v102.X;
        local Y = v102.Y;

        for i = 2, u51.Tiers do
            local v104 = i % 2 == 0 and v102 and v102 or v103;
            placeNode(X, Y, v100, u51.Icon, formatLabel(u51.Name, i, u51.DisplayName), math.sqrt(X ^ 2 + Y ^ 2) * 0.15, u51.Name, i, u51.Description);
            X = X + v104.X;
            Y = Y + v104.Y;
            local _ = i;
        end;
    end;

    for _, v in v48 do
        if #v99 <= 0 then
            warn("[SkillTree] No available directions left for group:", v.Name);
            break;
        end;

        local v105 = pickColor();
        local table_remove_ret = table.remove(v99, math.random(#v99));
        local v106 = u2[table_remove_ret];
        local v107 = u2[(table_remove_ret - 2) % v47 + 1];
        local X = v106.X;
        local Y = v106.Y;
        local v108 = v;

        for i = 1, v.Tiers do
            local v109 = i % 2 == 1 and v106 and v106 or v107;
            placeNode(X, Y, v105, v108.Icon, formatLabel(v108.Name, i, v108.DisplayName), math.sqrt(X ^ 2 + Y ^ 2) * 0.15, v108.Name, i, v108.Description);
            X = X + v109.X;
            Y = Y + v109.Y;
            local _ = i;
        end;
    end;

    local v110 = script.Parent.Parent.Background:Clone();
    v110:PivotTo(CFrame.new(workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -35).Position) * CFrame.Angles(1.5707963267948966, 3.141592653589793, -1.5707963267948966));
    v110.Parent = workspace.SkillTree;

    if not (u45 and u45.isSubTree) then
        for i, v in PAGE_NODES do
            if not (v.UpdateGate and UpdateService:IsHiddenFromUpdate(v.UpdateGate)) then
                local AttachTo = v.AttachTo;
                local v111 = nil;
                local v112, v113;

                if AttachTo == "__origin__" then
                    v111 = u101;
                    v112 = i;
                    v113 = v;
                else
                    v112 = i;
                    v113 = v;

                    for _, v2 in u50 do
                        if v2.upgradeName == AttachTo and (not v111 or v2.tier > v111.tier) then
                            v111 = v2;
                        end;
                    end;
                end;

                if v111 then
                    local v114 = nil;
                    local v115 = nil;

                    if AttachTo == "__origin__" then
                        for i2 = #v99, 1, -1 do
                            local v116 = u2[v99[i2]];
                            local v117 = u101.r + v116.Y;

                            if not u49[math.round((u101.q + v116.X) * 10) .. "," .. math.round(v117 * 10)] then
                                v114 = v116.X;
                                v115 = v116.Y;
                                table.remove(v99, i2);
                                break;
                            end;

                            local _ = i2;
                        end;

                        if not v114 then
                            for _, v2 in u2 do
                                local v118 = u101.r + v2.Y;

                                if not u49[math.round((u101.q + v2.X) * 10) .. "," .. math.round(v118 * 10)] then
                                    v114 = v2.X;
                                    v115 = v2.Y;
                                    break;
                                end;
                            end;
                        end;
                    elseif v111.tier > 1 then
                        local v119 = nil;

                        for _, v2 in u50 do
                            if v2.upgradeName == AttachTo and v2.tier == v111.tier - 1 then
                                v119 = v2;
                                break;
                            end;
                        end;

                        if v119 then
                            v114 = v111.q - v119.q;
                            v115 = v111.r - v119.r;
                        end;
                    end;

                    if not v114 then
                        for _, v2 in u2 do
                            local v120 = v111.r + v2.Y;

                            if not u49[math.round((v111.q + v2.X) * 10) .. "," .. math.round(v120 * 10)] then
                                v114 = v2.X;
                                v115 = v2.Y;
                                break;
                            end;
                        end;
                    end;

                    if v114 then
                        local v121 = v111.q + v114;
                        local v122 = v111.r + v115;

                        if not u49[math.round(v121 * 10) .. "," .. math.round(v122 * 10)] then
                            local v123 = placeNode(v121, v122, v113.Color or Color3.fromRGB(230, 160, 40), v113.Icon, v113.Label, math.sqrt(v121 ^ 2 + v122 ^ 2) * 0.15, "__page__" .. v112, 1, v113.Description);
                            v123.isPageNode = true;
                            v123.pageName = v112;
                            v123.requiresTier = v113.RequiresTier or 1;
                            v123.attachUpgrade = AttachTo;
                        end;
                    end;
                end;
            end;
        end;
    end;

    if u45 and (u45.isSubTree and u45.subTreeName) then
        local v124 = SUB_TREE_CONFIGS[u45.subTreeName];
        local v125 = v124 and v124.BeeAbilities;

        if v125 and v125.BranchCaps then
            local Color3_fromRGB_ret = Color3.fromRGB(255, 80, 200);

            for _, v in v125.BranchCaps do
                local v126 = v;
                local v127 = nil;

                for _, v2 in u50 do
                    if v2.upgradeName == v126.AttachTo and (not v127 or v2.tier > v127.tier) then
                        v127 = v2;
                    end;
                end;

                if v127 then
                    local v128 = nil;
                    local v129 = nil;

                    if v127.tier > 1 then
                        local v130 = nil;

                        for _, v2 in u50 do
                            if v2.upgradeName == v126.AttachTo and v2.tier == v127.tier - 1 then
                                v130 = v2;
                                break;
                            end;
                        end;

                        if v130 then
                            v128 = v127.q - v130.q;
                            v129 = v127.r - v130.r;
                        end;
                    end;

                    if not v128 then
                        for _, v2 in u2 do
                            local v131 = v127.r + v2.Y;

                            if not u49[math.round((v127.q + v2.X) * 10) .. "," .. math.round(v131 * 10)] then
                                v128 = v2.X;
                                v129 = v2.Y;
                                break;
                            end;
                        end;
                    end;

                    if v128 then
                        local v132 = v127.q + v128;
                        local v133 = v127.r + v129;

                        if not u49[math.round(v132 * 10) .. "," .. math.round(v133 * 10)] then
                            local v134 = v126.Name or v126.AttachTo .. "Ability";
                            local v135 = v126.DisplayName or (v126.TierName or v134);
                            local v136 = placeNode(v132, v133, Color3_fromRGB_ret, v126.Icon or v125.Icon, v135, math.sqrt(v132 ^ 2 + v133 ^ 2) * 0.15, v134, 1, v126.Description or v125.Description);
                            v136.isAbilityNode = true;
                            v136.abilityName = v134;
                            v136.displayName = v135;
                            v136.attachTo = v126.AttachTo;
                            v136.abilityCost = v126.Cost;
                            v136.cost = v126.Cost;
                        end;
                    end;
                end;
            end;
        end;
    end;

    local u137 = nil;

    if u45 and (u45.isSubTree and u45.subTreeName) then
        local v138 = SUB_TREE_ORIGIN[u45.subTreeName];

        if v138 and u101.upgradeName == "__back__" then
            u101.isBackNode = true;
            u101.icon = v138.Icon;
            u101.label = v138.Label;
            u101.description = v138.Description;
            u137 = u101;
        end;
    end;

    task.spawn(function() -- Line: 786
        -- upvalues: DataService (ref), u101 (copy), u62 (ref), u45 (copy), u50 (copy), SoundService (ref), u67 (ref), u51 (ref), PAGE_NODES (ref), SUB_TREE_CONFIGS (ref), u137 (ref), applyPanelState (ref), applyNodeColor (ref)
        local Data = DataService:GetData();

        if not Data then
            u101.state = "adjacent";
            u62(u101);

            return;
        end;

        local v139;

        if u45 and (u45.isSubTree and u45.subTreeName) then
            v139 = Data.BeeEventData and Data.BeeEventData.CombatSkillTree or {};
        else
            v139 = Data.BeeEventData and Data.BeeEventData.BeeSkillTree or {};
        end;

        local table_clone_ret = table.clone(u50);
        table.sort(table_clone_ret, function(p140, p141) -- Line: 802
            return p140.tier < p141.tier;
        end);
        local u142 = 0.75 / math.max(#table_clone_ret - 1, 1);

        local function spawnSound(p143, u144) -- Line: 809
            -- upvalues: SoundService (ref), u142 (copy)
            task.delay(p143, function() -- Line: 810
                -- upvalues: SoundService (ref), u144 (copy), u142 (ref)
                if not workspace:FindFirstChild("SkillTree") then
                    return;
                end;

                local v145 = SoundService.SkillTreeSounds.Reveal:Clone();
                v145.PitchShiftSoundEffect.Octave = 0.75 + u144 * u142;
                v145.Parent = SoundService;
                v145:Play();
                game:GetService("Debris"):AddItem(v145, 2);
            end);
        end;

        local u146 = 0;

        for _, v in table_clone_ret do
            if not (v.isPageNode or (v.isBackNode or (v.isAbilityNode or (v139[v.upgradeName] or 0) < v.tier))) then
                u67(v, true, u146 * 0.1);
                task.delay(u146 * 0.1, function() -- Line: 810
                    -- upvalues: SoundService (ref), u146 (copy), u142 (copy)
                    if not workspace:FindFirstChild("SkillTree") then
                        return;
                    end;

                    local v147 = SoundService.SkillTreeSounds.Reveal:Clone();
                    v147.PitchShiftSoundEffect.Octave = 0.75 + u146 * u142;
                    v147.Parent = SoundService;
                    v147:Play();
                    game:GetService("Debris"):AddItem(v147, 2);
                end);
                u146 = u146 + 1;
            end;
        end;

        local v148 = v139[u51.Name] or 0;

        for _, v in table_clone_ret do
            if not (v.isPageNode or (v.isBackNode or v.isAbilityNode)) then
                local v149 = v139[v.upgradeName] or 0;

                if v.tier == v149 + 1 and (v.state == "hidden" or v.state == "adjacent") then
                    if u45 and u45.isSubTree or (v.upgradeName == u51.Name or (v.tier ~= 1 or v148 ~= 0)) and (v.upgradeName == u51.Name or (v148 > 0 or v149 > 0)) then
                        u62(v, u146 * 0.1);
                        task.delay(u146 * 0.1, function() -- Line: 810
                            -- upvalues: SoundService (ref), u146 (copy), u142 (copy)
                            if not workspace:FindFirstChild("SkillTree") then
                                return;
                            end;

                            local v150 = SoundService.SkillTreeSounds.Reveal:Clone();
                            v150.PitchShiftSoundEffect.Octave = 0.75 + u146 * u142;
                            v150.Parent = SoundService;
                            v150:Play();
                            game:GetService("Debris"):AddItem(v150, 2);
                        end);
                        u146 = u146 + 1;
                    end;
                end;
            end;
        end;

        if not (u45 and u45.isSubTree or v139[u51.Name] and v139[u51.Name] ~= 0) then
            u101.state = "adjacent";
            u62(u101, 0);
        end;

        for _, v in table_clone_ret do
            if v.state == "revealed" then
                local math_clamp_ret = math.clamp(v139[v.upgradeName .. "_" .. v.tier] or 0, 0, v.levels);

                if math_clamp_ret > 0 and v.state == "revealed" then
                    v.progress = math_clamp_ret;
                    local Revealed = v.node.Surface:FindFirstChild("Revealed");

                    if Revealed then
                        Revealed = Revealed:FindFirstChild("Name");
                    end;

                    if Revealed then
                        Revealed.Text = v.label .. "<br/>(" .. math_clamp_ret .. "/" .. v.levels .. ")";
                    end;
                end;
            end;
        end;

        if not (u45 and u45.isSubTree) then
            for _, v in table_clone_ret do
                if v.isPageNode then
                    local v151 = PAGE_NODES[v.pageName];

                    if v151 then
                        local v152 = v151.RequiresUpgrade or v151.AttachTo;

                        if v152 == "__origin__" then
                            v152 = u51.Name;
                        end;

                        if (v139[v152] or 0) >= (v.requiresTier or 1) and (v.state == "hidden" or v.state == "adjacent") then
                            v.state = "adjacent";
                            local v153 = math.sqrt(v.q ^ 2 + v.r ^ 2) * 0.15;
                            u62(v, v153);
                            task.delay(v153, function() -- Line: 810
                                -- upvalues: SoundService (ref), u146 (copy), u142 (copy)
                                if not workspace:FindFirstChild("SkillTree") then
                                    return;
                                end;

                                local v154 = SoundService.SkillTreeSounds.Reveal:Clone();
                                v154.PitchShiftSoundEffect.Octave = 0.75 + u146 * u142;
                                v154.Parent = SoundService;
                                v154:Play();
                                game:GetService("Debris"):AddItem(v154, 2);
                            end);
                            u146 = u146 + 1;
                        end;
                    end;
                end;
            end;
        end;

        if u45 and (u45.isSubTree and u45.subTreeName) then
            local v155 = SUB_TREE_CONFIGS[u45.subTreeName];
            local v156;

            if v155 then
                v156 = v155.BeeAbilities;
            else
                v156 = v155;
            end;

            if v156 and v156.BranchCaps then
                for _, v in v156.BranchCaps do
                    local v157 = v;
                    local v158 = nil;

                    for _, v2 in u50 do
                        if v2.isAbilityNode and v2.attachTo == v157.AttachTo then
                            v158 = v2;
                            break;
                        end;
                    end;

                    if v158 then
                        local v159 = v155[v157.AttachTo];
                        local v160 = v159 and v159.MaxTier or 0;
                        local v161 = v139[v157.AttachTo] or 0;

                        if v139[v157.Name or v157.AttachTo .. "Ability"] == 1 then
                            if v158.state == "hidden" or v158.state == "adjacent" then
                                u67(v158, true, u146 * 0.1);
                                u146 = u146 + 1;
                            end;
                        elseif v160 <= v161 and (v158.state == "hidden" or v158.state == "adjacent") then
                            v158.state = "adjacent";
                            u62(v158, u146 * 0.1);
                            u146 = u146 + 1;
                        end;
                    end;
                end;
            end;
        end;

        if u137 then
            u137.color = Color3.fromRGB(120, 120, 140);
            u137.state = "adjacent";
            u62(u137);
            local node = u137.node;
            applyPanelState(node, true);
            applyNodeColor(node, Color3.fromRGB(120, 120, 140));
            local v162 = u137.node:FindFirstChildOfClass("ClickDetector");

            if v162 then
                v162:Destroy();
            end;

            local ClickDetector = Instance.new("ClickDetector");
            ClickDetector.CursorIcon = "rbxasset://textures/Cursors/KeyboardMouse/ArrowCursor.png";
            ClickDetector.MaxActivationDistance = 1000;
            ClickDetector.Parent = u137.node;
            ClickDetector.MouseClick:Connect(function() -- Line: 955
                -- upvalues: u45 (ref)
                if u45 and u45.onBackClicked then
                    u45.onBackClicked();
                end;
            end);

            function u137.purchase() -- Line: 961
                -- upvalues: u45 (ref)
                if u45 and u45.onBackClicked then
                    u45.onBackClicked();
                end;
            end;
        end;
    end);

    return u50, u49;
end;

return v1;