-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("UserInputService");
game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local Mouse = LocalPlayer:GetMouse();
local u1 = {
    TradeItemHover = true,
    TouchGui = true
};

local function IsUIRendered(p2: userdata) -- Line: 22
    -- upvalues: u1 (copy)
    if not p2:IsA("GuiObject") then
        return false;
    end;

    local v3 = p2:FindFirstAncestorOfClass("ScreenGui");

    if not (v3 and v3.Enabled) then
        return false;
    end;

    if u1[v3.Name] then
        return false;
    end;

    local v4 = 0;
    local v5 = 0;

    while p2 do
        if p2:IsA("GuiObject") then
            if not p2.Visible then
                return false;
            end;

            if p2:IsA("CanvasGroup") and p2.GroupTransparency >= 0.999 then
                return false;
            end;

            v4 = v4 + 1;

            if p2:IsA("ImageLabel") or p2:IsA("ImageButton") then
                if p2.ImageTransparency >= 0.999 then
                    v5 = v5 + 1;
                end;
            elseif p2:IsA("TextLabel") or p2:IsA("TextButton") then
                if p2.BackgroundTransparency >= 1 then
                    v5 = v5 + 1;
                end;
            elseif p2.BackgroundTransparency >= 1 then
                v5 = v5 + 1;
            end;
        end;

        if not p2.Parent or (p2.Parent:IsA("Player") or p2.Parent:IsA("PlayerGui")) then
            break;
        end;

        p2 = p2.Parent;
    end;

    return v4 > v5;
end;

local u6 = 0;
RunService.Heartbeat:Connect(function() -- Line: 90
    -- upvalues: u6 (ref)
    u6 = u6 + 1;
end);
local u7 = -1;
local u8 = nil;
local u9 = nil;
local u10 = nil;

return setmetatable({
    GetGuiObjectsAtPosition = function(p11: number, p12: number) -- Line: 96, Name: getGuiObjectsAtPositionCached
        -- upvalues: u7 (ref), u6 (ref), u8 (ref), u9 (ref), u10 (ref), PlayerGui (copy)
        local math_round_ret = math.round(p11);
        local math_round_ret2 = math.round(p12);

        if u7 == u6 and (u8 == math_round_ret and (u9 == math_round_ret2 and u10)) then
            return u10;
        end;

        u10 = PlayerGui:GetGuiObjectsAtPosition(math_round_ret, math_round_ret2);
        u7 = u6;
        u8 = math_round_ret;
        u9 = math_round_ret2;

        return u10;
    end,

    IsMouseOverUI = function() -- Line: 106, Name: IsMouseOverUI
        -- upvalues: Mouse (copy), u7 (ref), u6 (ref), u8 (ref), u9 (ref), u10 (ref), PlayerGui (copy), IsUIRendered (copy)
        local Y = Mouse.Y;
        local math_round_ret = math.round(Mouse.X);
        local math_round_ret2 = math.round(Y);
        local v13, v14, v15;

        if u7 == u6 and (u8 == math_round_ret and (u9 == math_round_ret2 and u10)) then
            v13 = u10;
            v14 = nil;
            v15 = nil;
        else
            u10 = PlayerGui:GetGuiObjectsAtPosition(math_round_ret, math_round_ret2);
            u7 = u6;
            u8 = math_round_ret;
            u9 = math_round_ret2;
            v13 = u10;
            v14 = nil;
            v15 = nil;
        end;

        for _, v in v13, v14, v15 do
            if IsUIRendered(v) then
                return true;
            end;
        end;

        return false;
    end,

    IsUIRendered = IsUIRendered
}, {
    __call = function(p16, ...) -- Line: 124, Name: __call
        -- upvalues: Mouse (copy), u7 (ref), u6 (ref), u8 (ref), u9 (ref), u10 (ref), PlayerGui (copy), IsUIRendered (copy)
        local Y = Mouse.Y;
        local math_round_ret = math.round(Mouse.X);
        local math_round_ret2 = math.round(Y);
        local v17, v18, v19;

        if u7 == u6 and (u8 == math_round_ret and (u9 == math_round_ret2 and u10)) then
            v17 = u10;
            v18 = nil;
            v19 = nil;
        else
            u10 = PlayerGui:GetGuiObjectsAtPosition(math_round_ret, math_round_ret2);
            u7 = u6;
            u8 = math_round_ret;
            u9 = math_round_ret2;
            v17 = u10;
            v18 = nil;
            v19 = nil;
        end;

        for _, v in v17, v18, v19 do
            if IsUIRendered(v) then
                return true;
            end;
        end;

        return false;
    end
});