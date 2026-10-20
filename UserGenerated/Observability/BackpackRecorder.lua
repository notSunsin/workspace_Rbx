-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local StarterGui = game:GetService("StarterGui");
local GuiService = game:GetService("GuiService");
local VRService = game:GetService("VRService");
local HttpService = game:GetService("HttpService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observability = require(ReplicatedStorage.UserGenerated.Observability);
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec);
local BackpackOrder = require(ReplicatedStorage.UserGenerated.Observability.BackpackOrder);
local u1 = {};
u1.__index = u1;

local function slotCount() -- Line: 20
    -- upvalues: VRService (copy), UserInputService (copy)
    if VRService.VREnabled then
        return 6;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    return UserInputService.TouchEnabled and (workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize.X < 1024) and 3 or 10;
end;

function u1.new(p2) -- Line: 26
    -- upvalues: BackpackOrder (copy), VRService (copy), UserInputService (copy), u1 (copy), Players (copy), StarterGui (copy), GuiService (copy), RunService (copy)
    local v3 = {
        NextTool = 0,
        StateDirty = true,
        Destroyed = false,
        Registry = p2,
        Connections = {},
        Containers = {},
        Tools = {},
        Dirty = {},
        Removed = {}
    };
    local v4;

    if VRService.VREnabled then
        v4 = 6;
    else
        local workspace_CurrentCamera = workspace.CurrentCamera;
        v4 = UserInputService.TouchEnabled and (workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize.X < 1024) and 3 or 10;
    end;

    v3.Order = BackpackOrder.new(v4);
    v3.FrameKeys = {};
    v3.FrameEquips = {};
    local u5 = setmetatable(v3, u1);
    local LocalPlayer = Players.LocalPlayer;

    local function connect(p6, p7) -- Line: 31
        -- upvalues: u5 (copy)
        table.insert(u5.Connections, p6:Connect(p7));
    end;

    local function invalidate() -- Line: 34
        -- upvalues: u5 (copy)
        u5.Order:Invalidate();
        u5.StateDirty = true;
        table.clear(u5.FrameKeys);
        table.clear(u5.FrameEquips);
    end;

    table.insert(u5.Connections, UserInputService.InputBegan:Connect(function(p8, p9) -- Line: 40
        -- upvalues: UserInputService (ref), u5 (copy), StarterGui (ref), GuiService (ref)
        if UserInputService:GetFocusedTextBox() then
            return;
        end;

        local UserInputType = p8.UserInputType;
        local KeyCode = p8.KeyCode;

        if KeyCode ~= Enum.KeyCode.Backquote and not (p9 and (UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch)) and KeyCode ~= Enum.KeyCode.ButtonSelect then
            if UserInputType == Enum.UserInputType.Keyboard and (StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) and not GuiService.MenuIsOpen) then
                local v10 = KeyCode.Value - Enum.KeyCode.Zero.Value;

                if v10 >= 0 and v10 <= 9 then
                    table.insert(u5.FrameKeys, v10 == 0 and 10 or v10);
                end;
            end;

            return;
        end;

        u5.Order:Invalidate();
        u5.StateDirty = true;
        table.clear(u5.FrameKeys);
        table.clear(u5.FrameEquips);
    end));
    table.insert(u5.Connections, RunService.PreRender:Connect(function() -- Line: 55
        -- upvalues: u5 (copy), LocalPlayer (copy)
        if #u5.FrameKeys == 1 and #u5.FrameEquips == 1 then
            local v11 = u5.FrameEquips[1];
            local v12 = u5.Tools[v11];

            if v12 and v11.Parent == LocalPlayer.Character then
                u5.Order:Recover(u5.FrameKeys[1], v12.Id);
                u5.StateDirty = true;
            end;
        end;

        table.clear(u5.FrameKeys);
        table.clear(u5.FrameEquips);
    end));
    table.insert(u5.Connections, StarterGui.CoreGuiChangedSignal:Connect(function(p13) -- Line: 68
        -- upvalues: u5 (copy)
        if p13 == Enum.CoreGuiType.Backpack or p13 == Enum.CoreGuiType.All then
            u5.Order:Invalidate();
            u5.StateDirty = true;
            table.clear(u5.FrameKeys);
            table.clear(u5.FrameEquips);
        end;
    end));
    table.insert(u5.Connections, LocalPlayer.CharacterAdded:Connect(function(p14) -- Line: 71
        -- upvalues: u5 (copy)
        u5.Order:Invalidate();
        u5.StateDirty = true;
        table.clear(u5.FrameKeys);
        table.clear(u5.FrameEquips);
        u5:_bind(p14);
    end));
    table.insert(u5.Connections, LocalPlayer.CharacterRemoving:Connect(function(p15) -- Line: 76
        -- upvalues: u5 (copy)
        u5:_unbind(p15);
        u5.Order:Invalidate();
        u5.StateDirty = true;
        table.clear(u5.FrameKeys);
        table.clear(u5.FrameEquips);
    end));
    table.insert(u5.Connections, LocalPlayer.ChildAdded:Connect(function(p16) -- Line: 77
        -- upvalues: u5 (copy)
        if p16:IsA("Backpack") then
            u5:_bind(p16);
        end;
    end));
    table.insert(u5.Connections, LocalPlayer.ChildRemoved:Connect(function(p17) -- Line: 78
        -- upvalues: u5 (copy)
        if u5.Containers[p17] then
            u5:_unbind(p17);
            u5.Order:Invalidate();
            u5.StateDirty = true;
            table.clear(u5.FrameKeys);
            table.clear(u5.FrameEquips);
        end;
    end));

    if LocalPlayer.Character then
        u5:_bind(LocalPlayer.Character);
    end;

    local v18 = LocalPlayer:FindFirstChildOfClass("Backpack");

    if v18 then
        u5:_bind(v18);
    end;

    table.clear(u5.FrameEquips);

    return u5;
end;

function u1._bind(u19, p20) -- Line: 87
    if u19.Containers[p20] then
        return;
    end;

    u19.Containers[p20] = { p20.ChildAdded:Connect(function(p21) -- Line: 90
            -- upvalues: u19 (copy)
            u19:_observe(p21);
        end), p20.ChildRemoved:Connect(function(p22) -- Line: 91
            -- upvalues: u19 (copy)
            if u19.Tools[p22] then
                u19.Dirty[p22] = true;
            end;
        end) };

    for _, child in p20:GetChildren() do
        u19:_observe(child);
    end;
end;

function u1._unbind(p23, p24) -- Line: 98
    local v25 = p23.Containers[p24];

    if not v25 then
        return;
    end;

    for _, v in v25 do
        v:Disconnect();
    end;

    p23.Containers[p24] = nil;

    for i in p23.Tools do
        if i.Parent == p24 then
            p23.Dirty[i] = true;
        end;
    end;
end;

function u1._observe(u26, u27) -- Line: 106
    -- upvalues: Players (copy)
    if not u27:IsA("Tool") then
        return;
    end;

    if not u26.Tools[u27] then
        u26.NextTool = u26.NextTool + 1;
        local v28 = {
            Id = u26.NextTool,
            Connections = {}
        };
        u26.Tools[u27] = v28;
        u26.Order:Add(v28.Id);

        for _, v in { "Name", "TextureId", "ToolTip" } do
            local Connections = v28.Connections;
            local PropertyChangedSignal = u27:GetPropertyChangedSignal(v);
            table.insert(Connections, PropertyChangedSignal:Connect(function() -- Line: 115
                -- upvalues: u26 (copy), u27 (copy)
                u26.Dirty[u27] = true;
            end));
        end;

        u26.StateDirty = true;
    end;

    if u27.Parent == Players.LocalPlayer.Character then
        table.insert(u26.FrameEquips, u27);
    end;

    u26.Dirty[u27] = true;
end;

function u1._write(p29, p30, p31, p32, p33, p34) -- Line: 123
    -- upvalues: Observability (copy), Codec (copy), HttpService (copy)
    local Registry = p29.Registry;
    local Stream = Registry.Stream;
    local W = Registry.Stream.W;
    local v35 = Registry.ClassPropsByName.Folder[p33];

    if p30 then
        local v36 = Registry.Clock();
        Stream:Time((math.max(v36, Registry.AddFloor)));
        W:u8(Observability.Op.Prop);
        Codec.varuint(W, p30);
    else
        p30 = Registry.NextId;
        Registry.NextId = Registry.NextId + 1;
        Registry:AddTime();
        Registry.Copies:WriteHead(W, p30, p31, Registry.ClassIndex.Folder, p32, false);
        W:u16(1);
    end;

    Codec.varuint(W, v35);
    Codec.writeValue(W, Observability.ValueType.String, HttpService:JSONEncode(p34));
    Stream:EndRecord();

    return p30;
end;

function u1.Flush(p37) -- Line: 144
    -- upvalues: VRService (copy), UserInputService (copy), BackpackOrder (copy), Observability (copy), Players (copy), Codec (copy)
    local v38;

    if VRService.VREnabled then
        v38 = 6;
    else
        local workspace_CurrentCamera = workspace.CurrentCamera;
        v38 = UserInputService.TouchEnabled and (workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize.X < 1024) and 3 or 10;
    end;

    if v38 ~= p37.Order.Count then
        p37.Order = BackpackOrder.new(v38);
        p37.Order:Invalidate();
        p37.StateDirty = true;
    end;

    if not p37.Root then
        p37.Root = p37:_write(nil, Observability.RootId.PlayerGui, "Backpack (best effort)", "UGBackpackState", {
            slots = p37.Order.Slots,
            guessed = p37.Order.Guessed
        });
    end;

    for i in p37.Dirty do
        local v39 = p37.Tools[i];

        if p37.Containers[i.Parent] then
            v39.StreamId = p37:_write(v39.StreamId, p37.Root, "Tool", "UGBackpackTool", {
                id = v39.Id,
                name = i.Name,
                texture = i.TextureId,
                tooltip = i.ToolTip,
                equipped = i.Parent == Players.LocalPlayer.Character
            });
        else
            if v39.StreamId then
                local Stream = p37.Registry.Stream;
                local v40 = p37.Registry.Clock();
                Stream:Time((math.max(v40, p37.Registry.AddFloor)));
                Stream.W:u8(Observability.Op.Remove);
                Codec.varuint(Stream.W, v39.StreamId);
                Stream:EndRecord();
                p37.Registry.Copies:Forget(v39.StreamId);
            end;

            for _, v in v39.Connections do
                v:Disconnect();
            end;

            p37.Tools[i] = nil;
            p37.Order:Remove(v39.Id);
            p37.StateDirty = true;
        end;
    end;

    table.clear(p37.Dirty);

    if p37.StateDirty then
        p37:_write(p37.Root, 0, "", "UGBackpackState", {
            slots = p37.Order.Slots,
            guessed = p37.Order.Guessed
        });
        p37.StateDirty = false;
    end;
end;

function u1.Destroy(p41) -- Line: 184
    p41.Destroyed = true;

    for _, v in p41.Connections do
        v:Disconnect();
    end;

    for _, v in p41.Containers do
        for _, v2 in v do
            v2:Disconnect();
        end;
    end;

    for _, v in p41.Tools do
        for _, v2 in v.Connections do
            v2:Disconnect();
        end;
    end;

    table.clear(p41.Tools);
    table.clear(p41.Dirty);
    table.clear(p41.Containers);
end;

return u1;