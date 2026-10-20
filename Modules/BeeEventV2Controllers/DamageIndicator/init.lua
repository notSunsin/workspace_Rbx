-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local Spring = require(ReplicatedStorage.Modules.Spring);

return function(p1: table) -- Line: 8
    -- upvalues: Spring (copy), Debris (copy)
    if not p1.Position then
        return warn("DamageIndicator: Missing Position");
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Parent = workspace.Terrain;
    Attachment.WorldPosition = p1.Position;
    local u2 = script.DamageIndicatorGUI:Clone();
    u2.Parent = Attachment;

    if p1.scale then
        u2.Size = p1.scale;
    end;

    u2.Frame.DamageShadow.Text = p1.Text or "";
    u2.Frame.DamageShadow.Damage.Text = p1.Text or "";
    u2.Frame.DamageShadow.TextColor3 = p1.textColor and p1.textColor:Lerp(Color3.new(), 0.33) or u2.Frame.DamageShadow.TextColor3;
    u2.Frame.DamageShadow.Damage.TextColor3 = p1.textColor or u2.Frame.DamageShadow.Damage.TextColor3;
    u2.Frame.DamageShadow.Damage.TextStrokeColor3 = p1.textColor and p1.textColor:Lerp(Color3.new(), 0.5) or u2.Frame.DamageShadow.Damage.TextStrokeColor3;
    Spring.target(u2.Frame.UIScale, 0.9, 3, {
        Scale = 0.2 + math.random(25, 50) / 100
    });
    local target = Spring.target;
    local v3 = {};
    local math_random_ret = math.random(-5, 5);
    local math_random_ret2 = math.random(-3, 3);
    v3.StudsOffset = vector.create(math_random_ret, math_random_ret2, 0);
    target(u2, 1.5, 2, v3);
    task.delay(0.65, function() -- Line: 34
        -- upvalues: Spring (ref), u2 (copy)
        Spring.target(u2.Frame.DamageShadow, 0.9, 2.5, {
            TextTransparency = 1
        });
        Spring.target(u2.Frame.DamageShadow.Damage, 0.9, 2.5, {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        });
    end);
    Debris:AddItem(Attachment, 3);
end;