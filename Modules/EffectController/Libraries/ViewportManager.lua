-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local os_clock = os.clock;
local u1 = { "Accessory", "Shirt", "Pants", "BodyColors", "Humanoid" };
local u2 = {};
u2.__index = u2;

function u2.new(p3: table?) -- Line: 70
    -- upvalues: u2 (copy)
    if p3 and p3.Object then
        local u4 = setmetatable(p3, u2);
        u4.RenderPriority = u4.RenderPriority or Enum.RenderPriority.Camera.Value + 1;
        u4.RenderedProperties = u4.RenderedProperties or { "CFrame" };

        if typeof(u4.RenderPriority) == "EnumItem" then
            u4.RenderPriority = u4.RenderPriority.Value;
        end;

        u4.Object.Destroying:Once(function() -- Line: 84
            -- upvalues: u4 (copy)
            u4:Destroy();
        end);

        return u4;
    end;

    error(("Incorrect type of instance given (%s). Can only track BaseParts, Models or Characters"):format(p3 and p3.Object or "nil"));
end;

function u2.Update(p5: table, p6: userdata, u7: userdata) -- Line: 96
    if p5._renderframe and p5._renderframe:FindFirstChild("Root") then
        for i = 1, #p5.RenderedProperties do
            local u8 = p5.RenderedProperties[i];
            local v9;

            if pcall(function() -- Line: 106
                -- upvalues: u7 (copy), u8 (copy)
                return u7[u8] ~= nil;
            end) then
                p6[u8] = u7[u8];
                v9 = i;
            else
                v9 = i;
            end;
        end;

        return;
    end;

    error(("WorldModel \'Root\' not found under viewportframe: %s"):format((tostring(p5._renderframe))));
end;

function u2.Start(u10: table, u11: boolean?) -- Line: 121
    -- upvalues: Players (copy), HttpService (copy), u1 (copy)
    if u10._active then
        return;
    end;

    if not u10.Object:IsDescendantOf(workspace) then
        error(("Object: %s is not a descendant of workspace."):format((tostring(u10.Object))));

        return;
    end;

    local LocalPlayer = Players.LocalPlayer;
    local Parent = u10.Parent;
    u10._active = true;
    u10._connection_id = HttpService:GenerateGUID(false);

    if not u10.Parent then
        Parent = LocalPlayer.PlayerGui:FindFirstChild("ViewportManagerScreenGUI") or Instance.new("ScreenGui");
        Parent.Name = "ViewportManagerScreenGUI";
        Parent.IgnoreGuiInset = true;
        Parent.Parent = LocalPlayer.PlayerGui;
        Parent.Destroying:Once(function() -- Line: 144
            -- upvalues: u10 (copy)
            u10:Destroy();
        end);
    end;

    u10._renderframe = Instance.new("ViewportFrame");
    u10._renderframe.Size = UDim2.fromScale(1, 1);
    u10._renderframe.BackgroundTransparency = 1;
    u10._renderframe.LightDirection = Vector3.new(1, -1, -1);
    u10._renderframe.Ambient = Color3.fromRGB(138, 138, 138);
    u10._renderframe.LightColor = Color3.new(1, 1, 1);
    u10._renderframe.CurrentCamera = workspace.CurrentCamera;
    u10._renderframe.Name = `VFM{u10._connection_id}`;
    u10._renderframe.Parent = Parent;
    u10._renderframe.ZIndex = u10.ZIndex or u10._renderframe.ZIndex;

    if u10._renderframe:FindFirstChildOfClass("WorldModel") then
        u10._renderframe:FindFirstChildOfClass("WorldModel").Name = "Root";
    else
        local WorldModel = Instance.new("WorldModel");
        WorldModel.Parent = u10._renderframe;
        WorldModel.Name = "Root";
    end;

    u10._connections = {};
    u10._viewportobject = Instance.new("Model");
    u10._viewportobject.Parent = u10._renderframe.Root;
    u10._viewportobject.Name = "";

    if not u10.Object:IsA("Model") then
        if u10.Object:IsA("BasePart") then
            local v12 = u10.Object:Clone();
            v12.CFrame = u10.Object.CFrame;
            v12.Anchored = true;
            v12.Parent = u10._viewportobject;
            u10:AddConnection(v12, u10.Object, u11);
        end;

        return;
    end;

    local Humanoid = u10.Object:FindFirstChild("Humanoid");
    local Children = u10.Object:GetChildren();

    local function u16(p13: any, p14: userdata?) -- Line: 184
        -- upvalues: u10 (copy), u16 (ref), u11 (copy)
        for _, v in p13 do
            if u10.GetModelDescendants and v:IsA("Model") then
                local Model = Instance.new("Model");
                local _viewportobject = u10._viewportobject;
                Model.Name = v.Name;
                Model.Parent = _viewportobject;
                u16(v:GetChildren(), Model);
            end;

            if v:IsA("BasePart") then
                local v15 = v:Clone();
                v15.CFrame = v.CFrame;
                v15.Anchored = true;
                v15.Parent = p14 or u10._viewportobject;
                u10:AddConnection(v15, v, u11);
            end;
        end;
    end;

    u16(Children);

    if Humanoid then
        Humanoid.Died:Once(function() -- Line: 206
            -- upvalues: u10 (copy)
            u10:Destroy();
        end);

        for _, v in Children do
            if table.find(u1, v.ClassName) then
                local v17 = v:Clone();
                v17.Parent = u10._viewportobject;

                if v:IsA("Accessory") and v:FindFirstChild("Handle") then
                    u10:AddConnection(v17.Handle, v.Handle, u11);
                end;
            end;
        end;
    end;
end;

function u2.AddConnection(u18: table, u19: userdata, u20: userdata, p21: boolean?) -- Line: 242
    -- upvalues: os_clock (copy), HttpService (copy), RunService (copy)
    if p21 then
        u18:Update(u19, u20);

        return;
    end;

    local u22 = os_clock();
    local u23 = `{HttpService:GenerateGUID(false):sub(1, 7)}{u18._connection_id}`;
    RunService:BindToRenderStep(u23, u18.RenderPriority, function(p24) -- Line: 251
        -- upvalues: u19 (copy), u20 (copy), u18 (copy), u23 (copy), RunService (ref), os_clock (ref), u22 (ref)
        if not (u19 and u20) then
            local table_find_ret = table.find(u18._connections, u23);

            if table_find_ret then
                RunService:UnbindFromRenderStep(u23);
                table.remove(u18._connections, table_find_ret);
            end;

            return;
        end;

        if u18.Framerate and os_clock() - u22 < 1 / u18.Framerate then
            return;
        end;

        u22 = os_clock();
        u18:Update(u19, u20);
    end);
    table.insert(u18._connections, u23);
end;

function u2.PlayOnce(p25: table, p26: table) -- Line: 275
    if not p26 then
        return;
    end;

    p25:Start(true);
    task.spawn(p25.PlayFade, p25, p26);
end;

function u2.PlayFade(p27: table, p28: table) -- Line: 287
    -- upvalues: TweenService (copy)
    if not (p28 and p27._renderframe) then
        return;
    end;

    if p28.StopTracking then
        p27:Stop();
    end;

    local v29 = p28.Time or 0.5;
    local v30 = p28.Ease or "Linear";
    local _renderframe = p27._renderframe;

    if p28.StopTracking then
        p27._renderframe = nil;
    end;

    local v31 = TweenService:Create(_renderframe, TweenInfo.new(v29, Enum.EasingStyle[v30]), {
        ImageTransparency = 1
    });
    v31:Play();
    v31.Completed:Wait();
    v31:Destroy();
    _renderframe:Destroy();
end;

function u2.Destroy(p32: table, p33: table) -- Line: 316
    if not p32._active then
        return;
    end;

    p32:PlayFade(p33);
    p32:Stop();

    if p32._renderframe then
        p32._renderframe:Destroy();
    end;

    for i in p32 do
        p32[i] = nil;
    end;
end;

function u2.Stop(p34) -- Line: 337
    -- upvalues: RunService (copy)
    p34._active = false;

    if p34._connections then
        for _, v in p34._connections do
            RunService:UnbindFromRenderStep(v);
        end;

        p34._connections = nil;
    end;
end;

return RunService:IsServer() and {} or u2;