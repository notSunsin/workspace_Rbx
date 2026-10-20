-- Decompiled with Potassium's decompiler.

local u1 = {
    Color3.new(0.9921568627450981, 0.1607843137254902, 0.2627450980392157),
    Color3.new(0.00392156862745098, 0.6352941176470588, 1),
    Color3.new(0.00784313725490196, 0.7215686274509804, 0.3411764705882353),
    BrickColor.new("Bright violet").Color,
    BrickColor.new("Bright orange").Color,
    BrickColor.new("Bright yellow").Color,
    BrickColor.new("Light reddish violet").Color,
    BrickColor.new("Brick yellow").Color
};

local function GetNameValue(p2) -- Line: 13
    local v3 = 0;

    for i = 1, #p2 do
        local string_sub_ret = string.sub(p2, i, i);
        local string_byte_ret = string.byte(string_sub_ret);
        local v4 = #p2 - i + 1;

        if #p2 % 2 == 1 then
            v4 = v4 - 1;
        end;

        if v4 % 4 >= 2 then
            string_byte_ret = -string_byte_ret;
        end;

        v3 = v3 + string_byte_ret;
        local _ = i;
    end;

    return v3;
end;

return function(p5: string) -- Line: 30, Name: ComputeNameColor
    -- upvalues: u1 (copy), GetNameValue (copy)
    return u1[(GetNameValue(p5) + 0) % #u1 + 1];
end;