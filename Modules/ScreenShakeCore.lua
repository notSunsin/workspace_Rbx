-- Decompiled with Potassium's decompiler.

local v1 = {};
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = game.Players.LocalPlayer;
local u2 = false;
local u3 = nil;
local u4 = Vector3.new(0, 0, 0);
local u5 = 0;
local u6 = 0;
v1.RootPart = nil;
v1.Humanoid = nil;

function lerp(p7, p8, p9)
    return p7 + (p8 - p7) * p9;
end;

local function UpdateCamera() -- Line: 37
    -- upvalues: u4 (ref), u5 (ref), workspace_CurrentCamera (copy)
    local v10 = CFrame.new(u4) * CFrame.Angles(0, 0, (math.rad(u5)));
    local v11 = workspace_CurrentCamera;
    v11.CFrame = v11.CFrame * v10;
end;

local function CreateLoop() -- Line: 42
    -- upvalues: u6 (ref), u2 (ref), RunService (copy), UpdateCamera (copy)
    u6 = u6 + 1;

    if u6 <= 1 then
        u2 = true;
        RunService:BindToRenderStep("ScreenShake", Enum.RenderPriority.Camera.Value + 1, UpdateCamera);
    end;
end;

local function EndLoop() -- Line: 50
    -- upvalues: u6 (ref), u2 (ref), RunService (copy), u4 (ref), u5 (ref), workspace_CurrentCamera (copy)
    u6 = u6 - 1;

    if u6 <= 0 then
        if u2 == true then
            RunService:UnbindFromRenderStep("ScreenShake");
            local v12 = CFrame.new(u4) * CFrame.Angles(0, 0, (math.rad(u5)));
            local v13 = workspace_CurrentCamera;
            v13.CFrame = v13.CFrame * v12;
        end;

        u2 = false;
    end;
end;

function v1.ScreenShake(p14, u15, u16, u17, u18, u19, u20) -- Line: 68
    -- upvalues: u3 (ref), TweenService (copy), u6 (ref), u2 (ref), RunService (copy), UpdateCamera (copy), u5 (ref), u4 (ref), workspace_CurrentCamera (copy), LocalPlayer (copy)
    task.spawn(function() -- Line: 97
        -- upvalues: u15 (copy), u16 (copy), u17 (ref), u18 (copy), u3 (ref), TweenService (ref), u20 (copy), u19 (ref), u6 (ref), u2 (ref), RunService (ref), UpdateCamera (ref), u5 (ref), u4 (ref), workspace_CurrentCamera (ref), LocalPlayer (ref)
        if u15 == "Normal" then
            if u16[1] == "Tilt" then
                local NumberValue = Instance.new("NumberValue");
                NumberValue.Value = 0;
                local v21 = u17;
                task.spawn(function() -- Line: 103
                    -- upvalues: u18 (ref), u16 (ref), u3 (ref), TweenService (ref), NumberValue (copy)
                    u3 = TweenService:Create(NumberValue, TweenInfo.new(u18 / u16[2], Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                        Value = 1
                    }):Play();
                    task.wait(u18 / u16[2]);
                    local v22 = false;

                    for i = 1, u16[2] do
                        if v22 == false then
                            v22 = true;
                            u3 = TweenService:Create(NumberValue, TweenInfo.new(u18 / u16[2], Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                Value = -1
                            }):Play();
                        else
                            v22 = false;
                            u3 = TweenService:Create(NumberValue, TweenInfo.new(u18 / u16[2], Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                Value = 1
                            }):Play();
                        end;

                        task.wait(u18 / u16[2]);
                        local _ = i;
                    end;
                end);
                local v23 = tick() + u18;

                if u20 == nil then
                    u6 = u6 + 1;

                    if u6 <= 1 then
                        u2 = true;
                        RunService:BindToRenderStep("ScreenShake", Enum.RenderPriority.Camera.Value + 1, UpdateCamera);
                    end;

                    while v23 - tick() > 0 do
                        RunService.RenderStepped:Wait();
                        u17 = v21 * NumberValue.Value;
                        u5 = u17 * u19 * (v23 - tick());
                    end;

                    u6 = u6 - 1;

                    if u6 <= 0 then
                        if u2 == true then
                            RunService:UnbindFromRenderStep("ScreenShake");
                            local v24 = CFrame.new(u4) * CFrame.Angles(0, 0, (math.rad(u5)));
                            local v25 = workspace_CurrentCamera;
                            v25.CFrame = v25.CFrame * v24;
                        end;

                        u2 = false;
                    end;
                else
                    u19 = u19 * (1 - (u20[1] - u20[2]).Magnitude / u20[3]);

                    if u19 <= 0 then
                        return;
                    end;

                    u6 = u6 + 1;

                    if u6 <= 1 then
                        u2 = true;
                        RunService:BindToRenderStep("ScreenShake", Enum.RenderPriority.Camera.Value + 1, UpdateCamera);
                    end;

                    while v23 - tick() > 0 do
                        RunService.RenderStepped:Wait();
                        u17 = v21 * NumberValue.Value;
                        u5 = u17 * u19 * (v23 - tick());
                    end;

                    u6 = u6 - 1;

                    if u6 <= 0 then
                        if u2 == true then
                            RunService:UnbindFromRenderStep("ScreenShake");
                            local v26 = CFrame.new(u4) * CFrame.Angles(0, 0, (math.rad(u5)));
                            local v27 = workspace_CurrentCamera;
                            v27.CFrame = v27.CFrame * v26;
                        end;

                        u2 = false;
                    end;
                end;

                if NumberValue then
                    NumberValue:Destroy();
                end;
            elseif u16[1] == "Vector" then
                local v28 = tick() + u18;

                if u20 == nil then
                    local v29 = math.random(-u17, u17) * u19 * (v28 - tick());
                    local v30 = math.random(-u17, u17) * u19 * (v28 - tick());
                    local v31 = math.random(-u17, u17) * u19 * (v28 - tick());
                    u6 = u6 + 1;

                    if u6 <= 1 then
                        u2 = true;
                        RunService:BindToRenderStep("ScreenShake", Enum.RenderPriority.Camera.Value + 1, UpdateCamera);
                    end;

                    while v28 - tick() > 0 do
                        RunService.RenderStepped:Wait();
                        u4 = Vector3.new(v29, v30, v31);
                        v29 = lerp(v29, math.random(-u17, u17) * u19 * (v28 - tick()), 0.75);
                        v30 = lerp(v30, math.random(-u17, u17) * u19 * (v28 - tick()), 0.75);
                        v31 = lerp(v31, math.random(-u17, u17) * u19 * (v28 - tick()), 0.75);
                    end;

                    u6 = u6 - 1;

                    if u6 <= 0 then
                        if u2 == true then
                            RunService:UnbindFromRenderStep("ScreenShake");
                            local v32 = CFrame.new(u4) * CFrame.Angles(0, 0, (math.rad(u5)));
                            local v33 = workspace_CurrentCamera;
                            v33.CFrame = v33.CFrame * v32;
                        end;

                        u2 = false;
                    end;
                else
                    u19 = u19 * (1 - (u20[1] - u20[2]).Magnitude / u20[3]);

                    if u19 <= 0 then
                        return;
                    end;

                    local v34 = math.random(-u17, u17) * u19 * (v28 - tick());
                    local v35 = math.random(-u17, u17) * u19 * (v28 - tick());
                    local v36 = math.random(-u17, u17) * u19 * (v28 - tick());
                    u6 = u6 + 1;

                    if u6 <= 1 then
                        u2 = true;
                        RunService:BindToRenderStep("ScreenShake", Enum.RenderPriority.Camera.Value + 1, UpdateCamera);
                    end;

                    while v28 - tick() > 0 do
                        RunService.RenderStepped:Wait();
                        u4 = Vector3.new(v34, v35, v36);
                        v34 = lerp(v34, math.random(-u17, u17) * u19 * (v28 - tick()), 0.75);
                        v35 = lerp(v35, math.random(-u17, u17) * u19 * (v28 - tick()), 0.75);
                        v36 = lerp(v36, math.random(-u17, u17) * u19 * (v28 - tick()), 0.75);
                    end;

                    u6 = u6 - 1;

                    if u6 <= 0 then
                        if u2 == true then
                            RunService:UnbindFromRenderStep("ScreenShake");
                            local v37 = CFrame.new(u4) * CFrame.Angles(0, 0, (math.rad(u5)));
                            local v38 = workspace_CurrentCamera;
                            v38.CFrame = v38.CFrame * v37;
                        end;

                        u2 = false;
                    end;
                end;
            end;
        elseif u15 == "Constant" then
            if u16[1] == "Tilt" then
                if u20 == nil then
                    local BoolValue = Instance.new("BoolValue");
                    BoolValue.Name = u16[2];
                    BoolValue.Parent = LocalPlayer;
                    local u39 = nil;
                    local u40 = false;
                    u39 = BoolValue:GetPropertyChangedSignal("Parent"):Connect(function() -- Line: 233
                        -- upvalues: u5 (ref), u40 (ref), BoolValue (ref), u39 (ref)
                        u5 = 0;
                        u40 = true;
                        BoolValue = nil;

                        if u39 then
                            u39:Disconnect();
                        end;
                    end);
                    local NumberValue = Instance.new("NumberValue");
                    NumberValue.Value = 0;
                    local v41 = u17;
                    task.spawn(function() -- Line: 242
                        -- upvalues: u18 (ref), u3 (ref), TweenService (ref), NumberValue (copy)
                        u3 = TweenService:Create(NumberValue, TweenInfo.new(u18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                            Value = 1
                        }):Play();
                        task.wait(u18);
                        local v42 = false;

                        while true do
                            if v42 == false then
                                v42 = true;
                                u3 = TweenService:Create(NumberValue, TweenInfo.new(u18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                    Value = -1
                                }):Play();
                            else
                                v42 = false;
                                u3 = TweenService:Create(NumberValue, TweenInfo.new(u18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                    Value = 1
                                }):Play();
                            end;

                            task.wait(u18);
                        end;
                    end);
                    u6 = u6 + 1;

                    if u6 <= 1 then
                        u2 = true;
                        RunService:BindToRenderStep("ScreenShake", Enum.RenderPriority.Camera.Value + 1, UpdateCamera);
                    end;

                    while u40 ~= true do
                        RunService.RenderStepped:Wait();
                        u17 = v41 * NumberValue.Value;
                        u5 = u17 * u19;
                    end;

                    u5 = 0;
                    u6 = u6 - 1;

                    if u6 <= 0 then
                        if u2 == true then
                            RunService:UnbindFromRenderStep("ScreenShake");
                            local v43 = CFrame.new(u4) * CFrame.Angles(0, 0, (math.rad(u5)));
                            local v44 = workspace_CurrentCamera;
                            v44.CFrame = v44.CFrame * v43;
                        end;

                        u2 = false;
                    end;

                    return;
                end;

                local _ = u19 * (1 - (u20[1].Position - u20[2].Position).Magnitude / u20[3]);
                local BoolValue = Instance.new("BoolValue");
                BoolValue.Name = u16[2];
                BoolValue.Parent = LocalPlayer;
                local u45 = nil;
                local u46 = false;
                u45 = BoolValue:GetPropertyChangedSignal("Parent"):Connect(function() -- Line: 190
                    -- upvalues: u5 (ref), u46 (ref), BoolValue (ref), u45 (ref)
                    u5 = 0;
                    u46 = true;
                    BoolValue = nil;

                    if u45 then
                        u45:Disconnect();
                    end;
                end);
                local NumberValue = Instance.new("NumberValue");
                NumberValue.Value = 0;
                local v47 = u17;
                task.spawn(function() -- Line: 199
                    -- upvalues: u18 (ref), u3 (ref), TweenService (ref), NumberValue (copy)
                    u3 = TweenService:Create(NumberValue, TweenInfo.new(u18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                        Value = 1
                    }):Play();
                    task.wait(u18);
                    local v48 = false;

                    while true do
                        if v48 == false then
                            v48 = true;
                            u3 = TweenService:Create(NumberValue, TweenInfo.new(u18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                Value = -1
                            }):Play();
                        else
                            v48 = false;
                            u3 = TweenService:Create(NumberValue, TweenInfo.new(u18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                                Value = 1
                            }):Play();
                        end;

                        task.wait(u18);
                    end;
                end);
                u6 = u6 + 1;

                if u6 <= 1 then
                    u2 = true;
                    RunService:BindToRenderStep("ScreenShake", Enum.RenderPriority.Camera.Value + 1, UpdateCamera);
                end;

                while true do
                    local v49 = u19 * (1 - (u20[1].Position - u20[2].Position).Magnitude / u20[3]);

                    if u46 == true or (u20[1] == nil or u20[2] == nil) then
                        break;
                    end;

                    RunService.RenderStepped:Wait();

                    if v49 > 0 then
                        u17 = v47 * NumberValue.Value;
                        u5 = u17 * v49;
                    end;
                end;

                u5 = 0;
                u6 = u6 - 1;

                if u6 <= 0 then
                    if u2 == true then
                        RunService:UnbindFromRenderStep("ScreenShake");
                        local v50 = CFrame.new(u4) * CFrame.Angles(0, 0, (math.rad(u5)));
                        local v51 = workspace_CurrentCamera;
                        v51.CFrame = v51.CFrame * v50;
                    end;

                    u2 = false;
                end;

                return;
            end;

            if u16[1] == "Vector" then
                if u20 ~= nil then
                    local v52 = u19 * (1 - (u20[1].Position - u20[2].Position).Magnitude / u20[3]);
                    local BoolValue = Instance.new("BoolValue");
                    BoolValue.Name = u16[2];
                    BoolValue.Parent = LocalPlayer;
                    local u53 = nil;
                    local u54 = false;
                    u53 = BoolValue:GetPropertyChangedSignal("Parent"):Connect(function() -- Line: 275
                        -- upvalues: u4 (ref), u54 (ref), BoolValue (ref), u53 (ref)
                        u4 = Vector3.new(0, 0, 0);
                        u54 = true;
                        BoolValue = nil;

                        if u53 then
                            u53:Disconnect();
                        end;
                    end);
                    local v55 = math.random(-u17, u17) * v52;
                    local v56 = math.random(-u17, u17) * v52;
                    local v57 = math.random(-u17, u17) * v52;
                    u6 = u6 + 1;

                    if u6 <= 1 then
                        u2 = true;
                        RunService:BindToRenderStep("ScreenShake", Enum.RenderPriority.Camera.Value + 1, UpdateCamera);
                    end;

                    while u54 ~= true and (u20[1] ~= nil and u20[2] ~= nil) do
                        local v58 = u19 * (1 - (u20[1].Position - u20[2].Position).Magnitude / u20[3]);
                        RunService.RenderStepped:Wait();

                        if v58 > 0 then
                            u4 = Vector3.new(v55, v56, v57);
                            v55 = lerp(v55, math.random(-u17, u17) * v58, 0.75);
                            v56 = lerp(v56, math.random(-u17, u17) * v58, 0.75);
                            v57 = lerp(v57, math.random(-u17, u17) * v58, 0.75);
                        end;
                    end;

                    u4 = Vector3.new(0, 0, 0);
                    u6 = u6 - 1;

                    if u6 <= 0 then
                        if u2 == true then
                            RunService:UnbindFromRenderStep("ScreenShake");
                            local v59 = CFrame.new(u4) * CFrame.Angles(0, 0, (math.rad(u5)));
                            local v60 = workspace_CurrentCamera;
                            v60.CFrame = v60.CFrame * v59;
                        end;

                        u2 = false;
                    end;

                    return;
                end;

                local BoolValue = Instance.new("BoolValue");
                BoolValue.Name = u16[2];
                BoolValue.Parent = LocalPlayer;
                local u61 = nil;
                local u62 = false;
                u61 = BoolValue:GetPropertyChangedSignal("Parent"):Connect(function() -- Line: 300
                    -- upvalues: u4 (ref), u62 (ref), BoolValue (ref), u61 (ref)
                    u4 = Vector3.new(0, 0, 0);
                    u62 = true;
                    BoolValue = nil;

                    if u61 then
                        u61:Disconnect();
                    end;
                end);
                local v63 = math.random(-u17, u17) * u19;
                local v64 = math.random(-u17, u17) * u19;
                local v65 = math.random(-u17, u17) * u19;
                u6 = u6 + 1;

                if u6 <= 1 then
                    u2 = true;
                    RunService:BindToRenderStep("ScreenShake", Enum.RenderPriority.Camera.Value + 1, UpdateCamera);
                end;

                while u62 ~= true do
                    RunService.RenderStepped:Wait();
                    u4 = Vector3.new(v63, v64, v65);
                    v63 = lerp(v63, math.random(-u17, u17) * u19, 0.75);
                    v64 = lerp(v64, math.random(-u17, u17) * u19, 0.75);
                    v65 = lerp(v65, math.random(-u17, u17) * u19, 0.75);
                end;

                u4 = Vector3.new(0, 0, 0);
                u6 = u6 - 1;

                if u6 <= 0 then
                    if u2 == true then
                        RunService:UnbindFromRenderStep("ScreenShake");
                        local v66 = CFrame.new(u4) * CFrame.Angles(0, 0, (math.rad(u5)));
                        local v67 = workspace_CurrentCamera;
                        v67.CFrame = v67.CFrame * v66;
                    end;

                    u2 = false;
                end;
            end;
        end;
    end);
end;

return v1;