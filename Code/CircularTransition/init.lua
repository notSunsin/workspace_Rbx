-- Decompiled with Potassium's decompiler.

local u1 = {
    In = UDim2.new(0.0008, 0, 0.0008, 0),
    Out = UDim2.new(3, 0, 3, 0)
};

function TweenGUI(p2, p3)
    -- upvalues: u1 (copy)
    if p2 == "Close" then
        p3:TweenSize(u1.In, Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.5);

        return;
    end;

    if p2 == "Open" then
        p3:TweenSize(u1.Out, Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.5);
    end;
end;

local u4 = setmetatable({}, {
    __tostring = function() -- Line: 28, Name: __tostring
        return "CircularTransition";
    end
});
u4.__index = u4;

function u4.new(...) -- Line: 33
    -- upvalues: u4 (ref)
    local v5 = setmetatable({}, u4);

    return v5:constructor(...) or v5;
end;

function u4.constructor(p6, ...) -- Line: 38
    p6.screenGUI = script.Transition:Clone();
    p6.State = "";
    p6.screenGUI.Parent = game.Players.LocalPlayer.PlayerGui;
    p6.screenGUI.Enabled = false;
    TweenGUI("Open", p6.screenGUI.Main);
    wait(1);
    p6.State = 0;
end;

function u4.Close(p7) -- Line: 51
    if p7.State ~= 1 then
        p7.State = 1;
        p7.screenGUI.Enabled = true;
        TweenGUI("Close", p7.screenGUI.Main);
        p7.State = 0;
    end;
end;

function u4.Open(u8) -- Line: 62
    if u8.State ~= 1 then
        u8.State = 1;
        task.spawn(function() -- Line: 66
            -- upvalues: u8 (copy)
            TweenGUI("Open", u8.screenGUI.Main);
            task.wait(0.5);
            u8.screenGUI.Enabled = false;
        end);
        u8.State = 0;
    end;
end;

function u4.Play(p9: table, p10: number) -- Line: 76
    if p9.State ~= 1 then
        p9.State = 1;
        TweenGUI("Close", p9.screenGUI.Main);
        wait((not p10 or p10 <= 0.5) and 0.6 or p10);
        TweenGUI("Open", p9.screenGUI.Main);
        p9.State = 0;
    end;
end;

function u4.SetColor(p11: table, p12) -- Line: 93
    for _, descendant in pairs(p11.screenGUI:GetDescendants()) do
        if descendant:IsA("Frame") then
            descendant.BackgroundColor3 = p12;
        elseif descendant:IsA("ImageLabel") then
            descendant.ImageColor3 = p12;
        end;
    end;
end;

function u4.getScreenGui(p13) -- Line: 103
    return p13.screenGUI;
end;

return u4;