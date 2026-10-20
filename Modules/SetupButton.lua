-- Decompiled with Potassium's decompiler.

local Spring = require(game:GetService("ReplicatedStorage").Modules.Spring);

return function(u1: table) -- Line: 15
    -- upvalues: Spring (copy)
    if not u1 then
        return nil;
    end;

    local instance = u1.instance;

    if u1.scale and (typeof(u1.scale) ~= "Instance" or not u1.scale:IsA("UIScale")) then
        warn((`SetupButton: Provided scale is invalid. Received type {typeof(u1.scale)}`));

        return;
    end;

    local u2 = u1.scale or (instance:FindFirstChildOfClass("UIScale") or instance.Parent:FindFirstChildOfClass("UIScale")) or Instance.new("UIScale", instance);
    local Scale = u2.Scale;
    local u3 = u1.speed or 10;
    local u4 = u1.damping or 1;
    local u5 = u1.offset or 0.065;
    instance.MouseEnter:Connect(function() -- Line: 35
        -- upvalues: u1 (copy), Spring (ref), u2 (ref), u4 (copy), u3 (copy), Scale (copy), instance (copy), u5 (copy)
        if u1.legacy then
            Spring.target(u2, u4, u3, {
                Scale = Scale + (instance.Active and u5 or 0)
            });
        end;

        if u1.onhover then
            u1.onhover();
        end;
    end);
    instance.MouseLeave:Connect(function() -- Line: 42
        -- upvalues: u1 (copy), Spring (ref), u2 (ref), u4 (copy), u3 (copy), Scale (copy)
        if u1.legacy then
            Spring.target(u2, u4, u3, {
                Scale = Scale
            });
        end;

        if u1.onleave then
            u1.onleave();
        end;
    end);
    local v6 = instance:IsA("GuiButton") and instance and instance or nil;

    if not v6 then
        for _, descendant in instance:GetDescendants() do
            if descendant:IsA("GuiButton") then
                v6 = descendant;
                break;
            end;
        end;
    end;

    if v6 then
        if u1.legacy then
            v6.MouseButton1Down:Connect(function() -- Line: 68
                -- upvalues: Spring (ref), u2 (ref), u4 (copy), u3 (copy), Scale (copy), instance (copy), u5 (copy)
                Spring.target(u2, u4, u3, {
                    Scale = Scale - (instance.Active and u5 or 0)
                });
            end);
            v6.MouseButton1Up:Connect(function() -- Line: 72
                -- upvalues: Spring (ref), u2 (ref), u4 (copy), u3 (copy), Scale (copy), instance (copy), u5 (copy)
                Spring.target(u2, u4, u3, {
                    Scale = Scale + (instance.Active and u5 or 0)
                });
            end);
        end;

        v6.Activated:Connect(function() -- Line: 77
            -- upvalues: u1 (copy), instance (copy)
            if u1.onclick then
                u1.onclick(instance);
            end;
        end);
    end;

    return instance;
end;