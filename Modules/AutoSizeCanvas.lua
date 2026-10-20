-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {};
require(ReplicatedStorage.Modules.CreateTagHandler)({
    Tag = "AutoSizeCanvas",

    OnInstanceAdded = function(u2) -- Line: 10, Name: OnInstanceAdded
        -- upvalues: u1 (copy)
        if not u2:IsA("ScrollingFrame") then
            warn("AutoSizeCanvas tag should only be applied to ScrollingFrames");

            return;
        end;

        local u3 = u2:FindFirstChildOfClass("UIListLayout");

        if not u3 then
            warn("No UIListLayout found in ScrollingFrame with AutoSizeCanvas tag");

            return;
        end;

        u2.CanvasSize = UDim2.new(0, 0, 0, u3.AbsoluteContentSize.Y);
        u1[u2] = u3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 23, Name: updateCanvasSize
            -- upvalues: u2 (copy), u3 (copy)
            u2.CanvasSize = UDim2.new(0, 0, 0, u3.AbsoluteContentSize.Y);
        end);
    end,

    OnInstanceRemoved = function(p4) -- Line: 32, Name: OnInstanceRemoved
        -- upvalues: u1 (copy)
        local v5 = u1[p4];

        if v5 then
            v5:Disconnect();
        end;
    end
});

return {};