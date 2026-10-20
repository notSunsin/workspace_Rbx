-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Observability = require(ReplicatedStorage.UserGenerated.Observability);
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec);
local Op = Observability.Op;
local PointerKind = Observability.PointerKind;
local PointerState = Observability.PointerState;
local u1 = {
    [Enum.KeyCode.Thumbstick1] = true,
    [Enum.KeyCode.Thumbstick2] = true,
    [Enum.KeyCode.Unknown] = true
};
local u2 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true
};

local function insetArea(p3) -- Line: 53
    -- upvalues: GuiService (copy)
    local success, result = pcall(GuiService.GetInsetArea, GuiService, p3);

    if success then
        return result;
    end;

    return nil;
end;

local u4 = {};
u4.__index = u4;

function u4.new(p5: function) -- Line: 61
    -- upvalues: u4 (copy), UserInputService (copy), PointerKind (copy), PointerState (copy), u2 (copy), GuiService (copy)
    local v6 = {
        NextTouchId = 1,
        Selected = nil,
        SelectedDirty = false,
        LastViewport = "",
        Origin = nil,
        LastVirtualCursor = nil,
        Clock = p5,
        Events = {},
        Keys = {},
        Held = {},
        LastMove = {},
        PendingMove = {},
        TouchIds = setmetatable({}, {
            __mode = "k"
        }),
        Connections = {}
    };
    local u7 = setmetatable(v6, u4);

    local function connect(p8: userdata, p9: function) -- Line: 81
        -- upvalues: u7 (copy)
        table.insert(u7.Connections, p8:Connect(p9));
    end;

    table.insert(u7.Connections, UserInputService.InputBegan:Connect(function(p10: userdata) -- Line: 85
        -- upvalues: u7 (copy), PointerKind (ref), PointerState (ref), u2 (ref)
        local UserInputType = p10.UserInputType;

        if UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.MouseButton2 then
            u7:_pointer(PointerKind.Mouse, UserInputType == Enum.UserInputType.MouseButton1 and 1 or 2, PointerState.Down, nil);

            return;
        end;

        if UserInputType == Enum.UserInputType.Keyboard or u2[UserInputType] then
            u7:_key(p10.KeyCode, true);
        end;
    end));
    table.insert(u7.Connections, UserInputService.InputEnded:Connect(function(p11: userdata) -- Line: 93
        -- upvalues: u7 (copy), PointerKind (ref), PointerState (ref), u2 (ref)
        local UserInputType = p11.UserInputType;

        if UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.MouseButton2 then
            u7:_pointer(PointerKind.Mouse, UserInputType == Enum.UserInputType.MouseButton1 and 1 or 2, PointerState.Up, nil);

            return;
        end;

        if UserInputType == Enum.UserInputType.Keyboard or u2[UserInputType] then
            u7:_key(p11.KeyCode, false);
        end;
    end));
    table.insert(u7.Connections, UserInputService.WindowFocusReleased:Connect(function() -- Line: 102
        -- upvalues: u7 (copy)
        u7:_releaseHeld();
    end));
    table.insert(u7.Connections, UserInputService.InputChanged:Connect(function(p12: userdata) -- Line: 105
        -- upvalues: u7 (copy), PointerKind (ref), PointerState (ref)
        if p12.UserInputType == Enum.UserInputType.MouseMovement then
            u7:_pointer(PointerKind.Mouse, 0, PointerState.Move, nil);
        end;
    end));
    table.insert(u7.Connections, UserInputService.TouchStarted:Connect(function(p13: userdata) -- Line: 110
        -- upvalues: u7 (copy), PointerKind (ref), PointerState (ref)
        local NextTouchId = u7.NextTouchId;
        u7.NextTouchId = NextTouchId % 255 + 1;
        u7.TouchIds[p13] = NextTouchId;
        u7:_pointer(PointerKind.Touch, NextTouchId, PointerState.Down, p13.Position);
    end));
    table.insert(u7.Connections, UserInputService.TouchMoved:Connect(function(p14: userdata) -- Line: 116
        -- upvalues: u7 (copy), PointerKind (ref), PointerState (ref)
        local v15 = u7.TouchIds[p14];

        if v15 then
            u7:_pointer(PointerKind.Touch, v15, PointerState.Move, p14.Position);
        end;
    end));
    table.insert(u7.Connections, UserInputService.TouchEnded:Connect(function(p16: userdata) -- Line: 122
        -- upvalues: u7 (copy), PointerKind (ref), PointerState (ref)
        local v17 = u7.TouchIds[p16];

        if v17 then
            u7.TouchIds[p16] = nil;
            u7:_pointer(PointerKind.Touch, v17, PointerState.Up, p16.Position);
        end;
    end));
    local PropertyChangedSignal = GuiService:GetPropertyChangedSignal("SelectedObject");
    table.insert(u7.Connections, PropertyChangedSignal:Connect(function() -- Line: 129
        -- upvalues: u7 (copy), GuiService (ref)
        u7.Selected = GuiService.SelectedObject;
        u7.SelectedDirty = true;
    end));

    return u7;
end;

function u4._pointer(p18: table, p19: number, p20: number, p21: number, p22: vector?) -- Line: 138
    -- upvalues: GuiService (copy), UserInputService (copy), PointerState (copy)
    local v23 = p18.Clock();
    local v24, v25;

    if p22 then
        local v26 = p18.Origin or GuiService:GetGuiInset();
        v24 = p22.X + v26.X;
        v25 = p22.Y + v26.Y;
    else
        local MouseLocation = UserInputService:GetMouseLocation();
        v24 = MouseLocation.X;
        v25 = MouseLocation.Y;
    end;

    local v27 = {
        Ms = v23,
        Kind = p19,
        PointerId = p20,
        State = p21,
        X = v24,
        Y = v25
    };
    local v28 = `{p19}:{p20}`;

    if p21 == PointerState.Move then
        local v29 = p18.LastMove[v28];

        if v29 and v23 - v29 < 33.333333333333336 then
            p18.PendingMove[v28] = v27;

            return;
        end;

        p18.LastMove[v28] = v23;
    end;

    p18.PendingMove[v28] = nil;
    table.insert(p18.Events, v27);
end;

function u4._key(p30: table, p31: any, p32: boolean) -- Line: 163
    -- upvalues: u1 (copy), UserInputService (copy)
    if u1[p31] then
        return;
    end;

    local Value = p31.Value;

    if p32 then
        if p30.Held[Value] or UserInputService:GetFocusedTextBox() then
            return;
        end;

        p30.Held[Value] = true;
    else
        if not p30.Held[Value] then
            return;
        end;

        p30.Held[Value] = nil;
    end;

    local Keys = p30.Keys;
    local v33 = {
        Ms = p30.Clock(),
        Code = Value,
        Down = p32
    };
    table.insert(Keys, v33);
end;

function u4._releaseHeld(p34) -- Line: 182
    local v35 = p34.Clock();

    for i in p34.Held do
        table.insert(p34.Keys, {
            Down = false,
            Ms = v35,
            Code = i
        });
    end;

    table.clear(p34.Held);
end;

function u4._sampleVirtualCursor(p36) -- Line: 190
    -- upvalues: u2 (copy), UserInputService (copy), PointerKind (copy), PointerState (copy)
    if not u2[UserInputService:GetLastInputType()] then
        p36.LastVirtualCursor = nil;

        return;
    end;

    local MouseLocation = UserInputService:GetMouseLocation();

    if p36.LastVirtualCursor ~= MouseLocation then
        p36.LastVirtualCursor = MouseLocation;
        local Events = p36.Events;
        local v37 = {
            PointerId = 0,
            Ms = p36.Clock(),
            Kind = PointerKind.VirtualCursor,
            State = PointerState.Move,
            X = MouseLocation.X,
            Y = MouseLocation.Y
        };
        table.insert(Events, v37);
    end;
end;

function u4.WriteViewport(p38: table, p39: any, p40: boolean?) -- Line: 210
    -- upvalues: GuiService (copy), Op (copy), Codec (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return;
    end;

    local ViewportSize = workspace_CurrentCamera.ViewportSize;
    local GuiInset, v41 = GuiService:GetGuiInset();
    local success, result = pcall(GuiService.GetInsetArea, GuiService, Enum.ScreenInsets.None);

    if not success then
        result = nil;
    end;

    local success2, result2 = pcall(GuiService.GetInsetArea, GuiService, Enum.ScreenInsets.DeviceSafeInsets);

    if not success2 then
        result2 = nil;
    end;

    local success3, result3 = pcall(GuiService.GetInsetArea, GuiService, Enum.ScreenInsets.TopbarSafeInsets);

    if not success3 then
        result3 = nil;
    end;

    local v42 = result and (result2 and result3) and {
        result2.Min.X - result.Min.X,
        result2.Min.Y - result.Min.Y,
        result.Max.X - result2.Max.X,
        result.Max.Y - result2.Max.Y,
        result3.Min.X - result2.Min.X,
        result3.Min.Y - result2.Min.Y,
        result2.Max.X - result3.Max.X,
        result2.Max.Y - result3.Max.Y
    } or nil;
    local v43;

    if result then
        v43 = -result.Min;
    else
        v43 = nil;
    end;

    p38.Origin = v43;
    local v44 = `{ViewportSize.X},{ViewportSize.Y},{GuiInset.X},{GuiInset.Y},{v41.X},{v41.Y}` .. (not v42 and "" or "," .. table.concat(v42, ","));

    if not p40 and v44 == p38.LastViewport then
        return;
    end;

    p38.LastViewport = v44;
    local W = p39.W;
    W:u8(Op.Viewport);
    local math_round_ret = math.round(ViewportSize.X);
    W:u16((math.clamp(math_round_ret, 0, 65535)));
    local math_round_ret2 = math.round(ViewportSize.Y);
    W:u16((math.clamp(math_round_ret2, 0, 65535)));
    Codec.i16(W, GuiInset.X);
    Codec.i16(W, GuiInset.Y);
    Codec.i16(W, v41.X);
    Codec.i16(W, v41.Y);
    p39:EndRecord();

    if v42 then
        W:u8(Op.SafeArea);

        for _, v in v42 do
            Codec.i16(W, v);
        end;

        p39:EndRecord();
    end;
end;

function u4.Flush(p45: table, p46: any, p47: function) -- Line: 258
    -- upvalues: Op (copy), Codec (copy)
    p45:_sampleVirtualCursor();
    local Events = p45.Events;
    p45.Events = {};

    for i, v in p45.PendingMove do
        p45.LastMove[i] = v.Ms;
        table.insert(Events, v);
    end;

    table.clear(p45.PendingMove);

    for _, v in Events do
        p46:Time(v.Ms);
        local W = p46.W;
        W:u8(Op.Pointer);
        W:u8(v.Kind);
        W:u8(v.PointerId);
        W:u8(v.State);
        Codec.i16(W, v.X);
        Codec.i16(W, v.Y);
        p46:EndRecord();
    end;

    local Keys = p45.Keys;

    if #Keys > 0 then
        p45.Keys = {};

        for _, v in Keys do
            p46:Time(v.Ms);
            local W = p46.W;
            local v48;

            if v.Down then
                v48 = Op.KeyDown;
            else
                v48 = Op.KeyUp;
            end;

            W:u8(v48);
            Codec.varuint(W, v.Code);
            p46:EndRecord();
        end;
    end;

    p46:Time(p45.Clock());
    p45:WriteViewport(p46);

    if p45.SelectedDirty then
        p45.SelectedDirty = false;
        local v49 = p47(p45.Selected);
        local W = p46.W;
        W:u8(Op.Selected);
        Codec.varuint(W, not v49 and 0 or v49 + 1);
        p46:EndRecord();
    end;
end;

function u4.Destroy(p50) -- Line: 301
    for _, v in p50.Connections do
        v:Disconnect();
    end;

    table.clear(p50.Connections);
    p50.Events = {};
    p50.Keys = {};
    table.clear(p50.Held);
    p50.Selected = nil;
end;

return u4;