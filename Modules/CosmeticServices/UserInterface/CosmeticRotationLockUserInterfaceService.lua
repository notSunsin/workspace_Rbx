-- Decompiled with Potassium's decompiler.

local ICON_INSERTION_POINT = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("CosmeticUI"):WaitForChild("ActionMenu"):WaitForChild("ICON_INSERTION_POINT");
local u1 = {
    Active = false
};
local Color3_fromRGB_ret = Color3.fromRGB(98, 255, 93);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 93, 93);

function u1.Toggle(p2) -- Line: 16
    -- upvalues: ICON_INSERTION_POINT (copy), u1 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    xpcall(function() -- Line: 17
        -- upvalues: ICON_INSERTION_POINT (ref), u1 (ref), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref)
        local IMAGE_ICON = ICON_INSERTION_POINT:WaitForChild("RotateLock", 3):FindFirstChild("IMAGE_ICON", 3);
        u1.Active = not u1.Active;
        IMAGE_ICON.ImageColor3 = u1.Active and Color3_fromRGB_ret or Color3_fromRGB_ret2;
    end, warn);

    return u1.Active;
end;

function u1.GetCurrentColor(p3) -- Line: 27
    -- upvalues: u1 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    return u1.Active and Color3_fromRGB_ret or Color3_fromRGB_ret2;
end;

return u1;