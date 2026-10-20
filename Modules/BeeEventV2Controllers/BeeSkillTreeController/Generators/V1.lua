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

local function hexToWorld(p3: vector, p4: number, p5: number) -- Line: 23
    -- upvalues: Vector2_new_ret (copy)
    return Vector3.new(p3.X + p4 * Vector2_new_ret.X, p3.Y, p3.Z + p5 * Vector2_new_ret.Y);
end;

local function darken(p6, p7: number) -- Line: 27
    return Color3.new(p6.R * p7, p6.G * p7, p6.B * p7);
end;

local u8 = {};

local function pickColor() -- Line: 34
    -- upvalues: u8 (copy)
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

local function toRoman(p11: number) -- Line: 54
    return ({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[p11] or tostring(p11);
end;

local function placeNode(p12, p13, p14, p15, p16, p17, p18) -- Line: 59
    -- upvalues: Node (copy), Vector2_new_ret (copy), Spring (copy)
    local u19 = Node:Clone();
    u19.Size = Vector3.new(0, 0, 0);
    u19.CFrame = CFrame.new((Vector3.new(p12.X + p13 * Vector2_new_ret.X, p12.Y, p12.Z + p14 * Vector2_new_ret.Y)));
    u19.Color = p15;
    local Highlight = u19:FindFirstChild("Highlight");

    if Highlight then
        Highlight.Color = Color3.new(p15.R * 0.25, p15.G * 0.25, p15.B * 0.25);
    end;

    u19.Surface.Icon.Image = p16;
    u19.Surface.Label.Text = p17;
    u19.Parent = Folder;
    task.delay(p18, function() -- Line: 71
        -- upvalues: Spring (ref), u19 (copy)
        Spring.target(u19, 1, 3, {
            Size = Vector3.new(4.632, 0.107, 5.327)
        });
    end);

    return u19;
end;

local function formatLabel(p20: string, p21: number) -- Line: 77
    return p20:gsub("(%u)", function(p22) -- Line: 78
        return " " .. p22;
    end):gsub("^ ", "") .. "<br/>" .. (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[p21] or tostring(p21));
end;

function v1.generate(p23: number, p24: vector, p25: table) -- Line: 84
    -- upvalues: u2 (copy), pickColor (copy), placeNode (copy)
    local v26 = workspace:FindFirstChild("SkillTree") or Instance.new("Folder");
    v26.Name = "SkillTree";
    v26.Parent = workspace;
    math.randomseed(p23);
    local v27 = #u2;
    local v28 = {};
    local v29 = nil;
    local v30 = {};

    for _, v in p25 do
        if v.IsOrigin then
            v29 = v;
        else
            table.insert(v28, v);
        end;
    end;

    local v31 = pickColor();
    local v33 = placeNode(p24, 0, 0, v31, v29.Icon, v29.Name:gsub("(%u)", function(p32) -- Line: 78
        return " " .. p32;
    end):gsub("^ ", "") .. "<br/>" .. (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[1] or tostring(1)), 0);
    v33.Name = v29.Name .. "_I";
    table.insert(v30, v33);
    local v34 = {};

    for i = 1, v27 do
        table.insert(v34, i);
        local _ = i;
    end;

    local table_remove_ret = table.remove(v34, math.random(#v34));
    local v35 = u2[table_remove_ret];
    local v36 = u2[(table_remove_ret - 2) % v27 + 1];
    local X = v35.X;
    local Y = v35.Y;

    for i = 2, v29.Tiers do
        local v37 = i % 2 == 0 and v35 and v35 or v36;
        local v39 = placeNode(p24, X, Y, v31, v29.Icon, v29.Name:gsub("(%u)", function(p38) -- Line: 78
            return " " .. p38;
        end):gsub("^ ", "") .. "<br/>" .. (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[i] or tostring(i)), math.sqrt(X ^ 2 + Y ^ 2) * 0.15);
        v39.Name = v29.Name .. "_" .. (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[i] or tostring(i));
        table.insert(v30, v39);
        X = X + v37.X;
        Y = Y + v37.Y;
        local _ = i;
    end;

    for _, v in v28 do
        local v40 = pickColor();
        local table_remove_ret2 = table.remove(v34, math.random(#v34));
        local v41 = u2[table_remove_ret2];
        local v42 = u2[(table_remove_ret2 - 2) % v27 + 1];
        local X2 = v41.X;
        local Y2 = v41.Y;
        local v43 = v;

        for i = 1, v.Tiers do
            local v44 = i % 2 == 1 and v41 and v41 or v42;
            local v46 = placeNode(p24, X2, Y2, v40, v43.Icon, v43.Name:gsub("(%u)", function(p45) -- Line: 78
                return " " .. p45;
            end):gsub("^ ", "") .. "<br/>" .. (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[i] or tostring(i)), math.sqrt(X2 ^ 2 + Y2 ^ 2) * 0.15);
            v46.Name = v43.Name .. "_" .. (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[i] or tostring(i));
            table.insert(v30, v46);
            X2 = X2 + v44.X;
            Y2 = Y2 + v44.Y;
            local _ = i;
        end;
    end;

    return v30;
end;

return v1;