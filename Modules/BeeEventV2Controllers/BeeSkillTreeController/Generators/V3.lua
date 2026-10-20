-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Spring = require(ReplicatedStorage.Modules.Spring);
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
local Vector2_new_ret = Vector2.new(5.095199966430664, 4.527950119972229);

local function hexToWorld(p3: vector, p4: number, p5: number) -- Line: 21
    -- upvalues: Vector2_new_ret (copy)
    return Vector3.new(p3.X + p4 * Vector2_new_ret.X, p3.Y, p3.Z + p5 * Vector2_new_ret.Y);
end;

local function darken(p6, p7: number) -- Line: 25
    return Color3.new(p6.R * p7, p6.G * p7, p6.B * p7);
end;

local u8 = {};

local function pickColor() -- Line: 32
    -- upvalues: u8 (ref)
    local v9 = 0;

    while true do
        local math_random_ret = math.random();
        local v10 = false;

        for _, v in u8 do
            local math_abs_ret = math.abs(math_random_ret - v);

            if math.min(math_abs_ret, 1 - math_abs_ret) < 0.15 then
                v10 = true;
            end;
        end;

        v9 = v9 + 1;

        if not v10 or v9 > 100 then
            table.insert(u8, math_random_ret);

            return Color3.fromHSV(math_random_ret, 0.6, 0.9);
        end;
    end;
end;

local function formatLabel(p11: string) -- Line: 52
    return p11:gsub("(%u)", function(p12) -- Line: 53
        return " " .. p12;
    end):gsub("^ ", "");
end;

local function posKey(p13, p14) -- Line: 58
    return math.round(p13 * 10) .. "," .. math.round(p14 * 10);
end;

function v1.generate(p15: number, u16: vector, p17: table) -- Line: 67
    -- upvalues: u8 (ref), u2 (copy), Spring (copy), Node (copy), Vector2_new_ret (copy), pickColor (copy)
    local u18 = workspace:FindFirstChild("SkillTree") or Instance.new("Folder");
    u18.Name = "SkillTree";
    u18.Parent = workspace;
    math.randomseed(p15);
    u8 = {};
    local v19 = #u2;
    local v20 = {};
    local u21 = {};
    local u22 = {};
    local v23 = nil;

    for _, v in p17 do
        if v.IsOrigin then
            v23 = v;
        else
            table.insert(v20, v);
        end;
    end;

    local u24 = nil;
    local u25 = nil;

    local function revealAdjacents(p26) -- Line: 93
        -- upvalues: u2 (ref), u21 (copy), u25 (ref)
        for _, v in u2 do
            local v27 = p26.r + v.Y;
            local v28 = u21[math.round((p26.q + v.X) * 10) .. "," .. math.round(v27 * 10)];

            if v28 and v28.state == "hidden" then
                u25(v28);
            end;
        end;
    end;

    u25 = function(p29) -- Line: 102
        -- upvalues: Spring (ref), u18 (copy)
        if p29.state ~= "hidden" then
            return;
        end;

        p29.state = "adjacent";
        local node = p29.node;
        Spring.target(node, 1, 3, {
            Size = Vector3.new(4.632, 0.107, 5.327),
            Color = Color3.fromRGB(80, 80, 80)
        });
        local Highlight = node:FindFirstChild("Highlight");

        if Highlight then
            Spring.target(Highlight, 1, 3, {
                Color = Color3.fromRGB(30, 30, 30)
            });
        end;

        node.Surface.Icon.Image = "";
        node.Surface.Icon.Size = UDim2.fromScale(0, 0);
        node.Surface.Label.Text = "???";
        node.Surface.Label.Position = UDim2.fromScale(0.5, 0.5);
        node.Surface.Label.AnchorPoint = Vector2.new(0.5, 0.5);
        node.Parent = u18;
    end;

    local function u32(u30) -- Line: 117
        -- upvalues: Spring (ref), u18 (copy), revealAdjacents (copy), u24 (ref)
        if u30.state ~= "adjacent" and u30.state ~= "hidden" then
            return;
        end;

        u30.state = "revealed";
        local node = u30.node;
        local v31 = node:FindFirstChildOfClass("ClickDetector");

        if v31 then
            v31:Destroy();
        end;

        node.Color = u30.color;
        local Highlight = node:FindFirstChild("Highlight");

        if Highlight then
            local color = u30.color;
            Highlight.Color = Color3.new(color.R * 0.25, color.G * 0.25, color.B * 0.25);
        end;

        node.Surface.Icon.Image = u30.icon;
        node.Surface.Icon.Size = UDim2.fromScale(0, 0);
        node.Surface.Label.Position = u30.labelPosition;
        node.Surface.Label.AnchorPoint = u30.labelAnchorPoint;
        node.Surface.Label.Text = u30.displayName .. "<br/>(0/" .. u30.tiers .. ")";
        Spring.target(node.Surface.Icon, 1, 3, {
            Size = u30.iconSize
        });
        node.Parent = u18;
        Spring.target(node, 1, 3, {
            Size = Vector3.new(4.632, 0.107, 5.327),
            Color = u30.color
        });
        revealAdjacents(u30);
        local ClickDetector = Instance.new("ClickDetector");
        ClickDetector.CursorIcon = "rbxasset://textures/Cursors/KeyboardMouse/ArrowCursor.png";
        ClickDetector.MaxActivationDistance = 1000;
        ClickDetector.Parent = node;
        ClickDetector.MouseClick:Connect(function() -- Line: 139
            -- upvalues: u24 (ref), u30 (copy)
            u24(u30);
        end);
    end;

    u24 = function(p33) -- Line: 144
        -- upvalues: u2 (ref), u21 (copy), u32 (ref), u25 (ref)
        if p33.state == "hidden" or (p33.state == "adjacent" or p33.state == "maxed") then
            return;
        end;

        p33.current = p33.current + 1;
        local node = p33.node;

        if p33.current < p33.tiers then
            node.Surface.Label.Text = p33.displayName .. "<br/>(" .. p33.current .. "/" .. p33.tiers .. ")";

            return;
        end;

        p33.state = "maxed";
        local v34 = node:FindFirstChildOfClass("ClickDetector");

        if v34 then
            v34:Destroy();
        end;

        node.Surface.Label.Text = p33.displayName .. "<br/>[MAX]";

        for _, v in u2 do
            local v35 = p33.r + v.Y;
            local v36 = u21[math.round((p33.q + v.X) * 10) .. "," .. math.round(v35 * 10)];

            if v36 then
                if v36.state == "adjacent" then
                    u32(v36);
                elseif v36.state == "hidden" then
                    u25(v36);
                end;
            end;
        end;
    end;

    local function placeNode(p37, p38, p39, p40, p41, p42) -- Line: 168
        -- upvalues: Node (ref), u16 (copy), Vector2_new_ret (ref), u21 (copy), u22 (copy)
        local v43 = Node:Clone();
        v43.Size = Vector3.new(0, 0, 0);
        local v44 = u16;
        v43.CFrame = CFrame.new((Vector3.new(v44.X + p37 * Vector2_new_ret.X, v44.Y, v44.Z + p38 * Vector2_new_ret.Y)));
        v43.Color = p39;
        local Highlight = v43:FindFirstChild("Highlight");

        if Highlight then
            Highlight.Color = Color3.new(p39.R * 0.25, p39.G * 0.25, p39.B * 0.25);
        end;

        v43.Surface.Icon.Image = p40;
        v43.Surface.Label.Text = p41;
        v43.Parent = nil;
        local v45 = {
            current = 0,
            state = "hidden",
            node = v43,
            q = p37,
            r = p38,
            color = p39,
            icon = p40,
            displayName = p41,
            tiers = p42,
            iconSize = v43.Surface.Icon.Size,
            labelPosition = v43.Surface.Label.Position,
            labelAnchorPoint = v43.Surface.Label.AnchorPoint
        };
        u21[math.round(p37 * 10) .. "," .. math.round(p38 * 10)] = v45;
        table.insert(u22, v45);

        return v45;
    end;

    local v46 = {};

    for i = 1, v19 do
        table.insert(v46, i);
        local _ = i;
    end;

    local v48 = placeNode(0, 0, pickColor(), v23.Icon, v23.Name:gsub("(%u)", function(p47) -- Line: 53
        return " " .. p47;
    end):gsub("^ ", ""), v23.Tiers);
    local table_remove_ret = table.remove(v46, math.random(#v46));
    local v49 = u2[table_remove_ret];
    local v50 = u2[(table_remove_ret - 2) % v19 + 1];
    local X = v49.X;
    local Y = v49.Y;

    for i = 2, v23.Tiers do
        X = X + v49.X;
        Y = Y + v50.Y;
        local _ = i;
    end;

    for _, v in v20 do
        local v51 = pickColor();
        local table_remove_ret2 = table.remove(v46, math.random(#v46));
        local v52 = u2[table_remove_ret2];
        local _ = u2[(table_remove_ret2 - 2) % v19 + 1];
        placeNode(v52.X, v52.Y, v51, v.Icon, v.Name:gsub("(%u)", function(p53) -- Line: 53
            return " " .. p53;
        end):gsub("^ ", ""), v.Tiers);
    end;

    v48.state = "adjacent";
    u32(v48);

    return u22, u21;
end;

return v1;