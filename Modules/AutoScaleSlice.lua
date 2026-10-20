-- Decompiled with Potassium's decompiler.

game:GetService("AssetService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {};
require(ReplicatedStorage.Modules.CreateTagHandler)({
    Tag = "AutoScaleSlice",

    OnInstanceAdded = function(u2: userdata) -- Line: 19, Name: OnInstanceAdded
        -- upvalues: u1 (copy)
        if not u2:IsA("ImageLabel") then
            return;
        end;

        local u3 = u2.SliceCenter.Min + u2.SliceCenter.Max;
        local v4 = u2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 28, Name: Update
            -- upvalues: u2 (copy), u3 (copy)
            if u2.ScaleType ~= Enum.ScaleType.Slice then
                return;
            end;

            local AbsoluteSize = u2.AbsoluteSize;
            u2.SliceScale = math.min(AbsoluteSize.X / u3.X, AbsoluteSize.Y / u3.Y);
        end);

        if u2.ScaleType == Enum.ScaleType.Slice then
            local AbsoluteSize = u2.AbsoluteSize;
            u2.SliceScale = math.min(AbsoluteSize.X / u3.X, AbsoluteSize.Y / u3.Y);
        end;

        u1[u2] = v4;
    end,

    OnInstanceRemoved = function(p5) -- Line: 46, Name: OnInstanceRemoved
        -- upvalues: u1 (copy)
        local v6 = u1[p5];

        if v6 then
            v6:Disconnect();
        end;
    end
});

return {};