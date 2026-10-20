-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local debug_profilebegin = debug.profilebegin;
local debug_profileend = debug.profileend;
local CFrame_new = CFrame.new;
local CFrame_Angles = CFrame.Angles;
local math_rad = math.rad;
local Vector3_new_ret = Vector3.new();
local script_CameraShakeInstance = require(script.CameraShakeInstance);
local CameraShakeState = script_CameraShakeInstance.CameraShakeState;
u1.CameraShakeInstance = script_CameraShakeInstance;
u1.Presets = require(script.CameraShakePresets);

function u1.new(p2, p3) -- Line: 87
    -- upvalues: Vector3_new_ret (copy), u1 (copy)
    local v4 = type(p2) == "number";
    assert(v4, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)");
    local v5 = type(p3) == "function";
    assert(v5, "Callback must be a function");

    return setmetatable({
        _running = false,
        _renderName = "CameraShaker",
        _renderPriority = p2,
        _posAddShake = Vector3_new_ret,
        _rotAddShake = Vector3_new_ret,
        _camShakeInstances = {},
        _removeInstances = {},
        _callback = p3
    }, u1);
end;

function u1.Start(u6) -- Line: 108
    -- upvalues: debug_profilebegin (copy), debug_profileend (copy)
    if u6._running then
        return;
    end;

    u6._running = true;
    local _callback = u6._callback;
    game:GetService("RunService"):BindToRenderStep(u6._renderName, u6._renderPriority, function(p7) -- Line: 112
        -- upvalues: debug_profilebegin (ref), u6 (copy), debug_profileend (ref), _callback (copy)
        debug_profilebegin("CameraShakerUpdate");
        local v8 = u6:Update(p7);
        debug_profileend();
        _callback(v8);
    end);
end;

function u1.Stop(p9) -- Line: 121
    if not p9._running then
        return;
    end;

    game:GetService("RunService"):UnbindFromRenderStep(p9._renderName);
    p9._running = false;
end;

function u1.StopSustained(p10, p11) -- Line: 128
    for _, v in pairs(p10._camShakeInstances) do
        if v.fadeOutDuration == 0 then
            v:StartFadeOut(p11 or v.fadeInDuration);
        end;
    end;
end;

function u1.Update(p12, p13) -- Line: 137
    -- upvalues: Vector3_new_ret (copy), CameraShakeState (copy), CFrame_new (copy), CFrame_Angles (copy), math_rad (copy)
    local v14 = Vector3_new_ret;
    local v15 = Vector3_new_ret;
    local _camShakeInstances = p12._camShakeInstances;

    for i = 1, #_camShakeInstances do
        local v16 = _camShakeInstances[i];
        local State = v16:GetState();
        local v17;

        if State == CameraShakeState.Inactive and v16.DeleteOnInactive then
            p12._removeInstances[#p12._removeInstances + 1] = i;
            v17 = i;
        elseif State == CameraShakeState.Inactive then
            v17 = i;
        else
            local v18 = v16:UpdateShake(p13);
            v14 = v14 + v18 * v16.PositionInfluence;
            v15 = v15 + v18 * v16.RotationInfluence;
            v17 = i;
        end;
    end;

    for i = #p12._removeInstances, 1, -1 do
        table.remove(_camShakeInstances, p12._removeInstances[i]);
        p12._removeInstances[i] = nil;
        local _ = i;
    end;

    return CFrame_new(v14) * CFrame_Angles(0, math_rad(v15.Y), 0) * CFrame_Angles(math_rad(v15.X), 0, (math_rad(v15.Z)));
end;

function u1.Shake(p19, p20) -- Line: 174
    local v21;

    if type(p20) == "table" then
        v21 = p20._camShakeInstance;
    else
        v21 = false;
    end;

    assert(v21, "ShakeInstance must be of type CameraShakeInstance");
    p19._camShakeInstances[#p19._camShakeInstances + 1] = p20;

    return p20;
end;

function u1.ShakeSustain(p22, p23) -- Line: 181
    local v24;

    if type(p23) == "table" then
        v24 = p23._camShakeInstance;
    else
        v24 = false;
    end;

    assert(v24, "ShakeInstance must be of type CameraShakeInstance");
    p22._camShakeInstances[#p22._camShakeInstances + 1] = p23;
    p23:StartFadeIn(p23.fadeInDuration);

    return p23;
end;

function u1.ShakeOnce(p25, p26, p27, p28, p29, p30, p31) -- Line: 189
    -- upvalues: script_CameraShakeInstance (copy)
    local v32 = script_CameraShakeInstance.new(p26, p27, p28, p29);
    v32.PositionInfluence = typeof(p30) == "Vector3" and p30 and p30 or Vector3.new(0.15, 0.15, 0.15);
    v32.RotationInfluence = typeof(p31) == "Vector3" and p31 and p31 or Vector3.new(1, 1, 1);
    p25._camShakeInstances[#p25._camShakeInstances + 1] = v32;

    return v32;
end;

function u1.StartShake(p33, p34, p35, p36, p37, p38) -- Line: 198
    -- upvalues: script_CameraShakeInstance (copy)
    local v39 = script_CameraShakeInstance.new(p34, p35, p36);
    v39.PositionInfluence = typeof(p37) == "Vector3" and p37 and p37 or Vector3.new(0.15, 0.15, 0.15);
    v39.RotationInfluence = typeof(p38) == "Vector3" and p38 and p38 or Vector3.new(1, 1, 1);
    v39:StartFadeIn(p36);
    p33._camShakeInstances[#p33._camShakeInstances + 1] = v39;

    return v39;
end;

return u1;