-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local script_TweenFunctions = require(script.TweenFunctions);
local script_Lerps = require(script.Lerps);
local v1 = {};
local u2 = {
    Heartbeat = true,
    Stepped = true,
    RenderStepped = true
};

if not RunService:IsClient() then
    u2.RenderStepped = nil;
end;

local u3 = {
    FabricAccelerate = {
        In = script_TweenFunctions.InFabricAccelerate,
        Out = script_TweenFunctions.OutFabricAccelerate,
        InOut = script_TweenFunctions.InOutFabricAccelerate,
        OutIn = script_TweenFunctions.OutInFabricAccelerate
    },
    UWPAccelerate = {
        In = script_TweenFunctions.InUWPAccelerate,
        Out = script_TweenFunctions.OutUWPAccelerate,
        InOut = script_TweenFunctions.InOutUWPAccelerate,
        OutIn = script_TweenFunctions.OutInUWPAccelerate
    },
    Circ = {
        In = script_TweenFunctions.InCirc,
        Out = script_TweenFunctions.OutCirc,
        InOut = script_TweenFunctions.InOutCirc,
        OutIn = script_TweenFunctions.OutInCirc
    },
    RevBack = {
        In = script_TweenFunctions.InRevBack,
        Out = script_TweenFunctions.OutRevBack,
        InOut = script_TweenFunctions.InOutRevBack,
        OutIn = script_TweenFunctions.OutInRevBack
    },
    Spring = {
        In = script_TweenFunctions.InSpring,
        Out = script_TweenFunctions.OutSpring,
        InOut = script_TweenFunctions.InOutSpring,
        OutIn = script_TweenFunctions.OutInSpring
    },
    Standard = {
        In = script_TweenFunctions.InStandard,
        Out = script_TweenFunctions.OutStandard,
        InOut = script_TweenFunctions.InOutStandard,
        OutIn = script_TweenFunctions.OutInStandard
    },
    StandardExpressive = {
        In = script_TweenFunctions.InStandardExpressive,
        Out = script_TweenFunctions.OutStandardExpressive,
        InOut = script_TweenFunctions.InOutStandardExpressive,
        OutIn = script_TweenFunctions.OutInStandardExpressive
    },
    Linear = {
        In = script_TweenFunctions.InLinear,
        Out = script_TweenFunctions.OutLinear,
        InOut = script_TweenFunctions.InOutLinear,
        OutIn = script_TweenFunctions.OutInLinear
    },
    ExitProductive = {
        In = script_TweenFunctions.InExitProductive,
        Out = script_TweenFunctions.OutExitProductive,
        InOut = script_TweenFunctions.InOutExitProductive,
        OutIn = script_TweenFunctions.OutInExitProductive
    },
    Deceleration = {
        In = script_TweenFunctions.InDeceleration,
        Out = script_TweenFunctions.OutDeceleration,
        InOut = script_TweenFunctions.InOutDeceleration,
        OutIn = script_TweenFunctions.OutInDeceleration
    },
    Smoother = {
        In = script_TweenFunctions.InSmoother,
        Out = script_TweenFunctions.OutSmoother,
        InOut = script_TweenFunctions.InOutSmoother,
        OutIn = script_TweenFunctions.OutInSmoother
    },
    FabricStandard = {
        In = script_TweenFunctions.InFabricStandard,
        Out = script_TweenFunctions.OutFabricStandard,
        InOut = script_TweenFunctions.InOutFabricStandard,
        OutIn = script_TweenFunctions.OutInFabricStandard
    },
    RidiculousWiggle = {
        In = script_TweenFunctions.InRidiculousWiggle,
        Out = script_TweenFunctions.OutRidiculousWiggle,
        InOut = script_TweenFunctions.InOutRidiculousWiggle,
        OutIn = script_TweenFunctions.OutInRidiculousWiggle
    },
    MozillaCurve = {
        In = script_TweenFunctions.InMozillaCurve,
        Out = script_TweenFunctions.OutMozillaCurve,
        InOut = script_TweenFunctions.InOutMozillaCurve,
        OutIn = script_TweenFunctions.OutInMozillaCurve
    },
    Expo = {
        In = script_TweenFunctions.InExpo,
        Out = script_TweenFunctions.OutExpo,
        InOut = script_TweenFunctions.InOutExpo,
        OutIn = script_TweenFunctions.OutInExpo
    },
    Sine = {
        In = script_TweenFunctions.InSine,
        Out = script_TweenFunctions.OutSine,
        InOut = script_TweenFunctions.InOutSine,
        OutIn = script_TweenFunctions.OutInSine
    },
    Cubic = {
        In = script_TweenFunctions.InCubic,
        Out = script_TweenFunctions.OutCubic,
        InOut = script_TweenFunctions.InOutCubic,
        OutIn = script_TweenFunctions.OutInCubic
    },
    EntranceExpressive = {
        In = script_TweenFunctions.InEntranceExpressive,
        Out = script_TweenFunctions.OutEntranceExpressive,
        InOut = script_TweenFunctions.InOutEntranceExpressive,
        OutIn = script_TweenFunctions.OutInEntranceExpressive
    },
    Elastic = {
        In = script_TweenFunctions.InElastic,
        Out = script_TweenFunctions.OutElastic,
        InOut = script_TweenFunctions.InOutElastic,
        OutIn = script_TweenFunctions.OutInElastic
    },
    Quint = {
        In = script_TweenFunctions.InQuint,
        Out = script_TweenFunctions.OutQuint,
        InOut = script_TweenFunctions.InOutQuint,
        OutIn = script_TweenFunctions.OutInQuint
    },
    EntranceProductive = {
        In = script_TweenFunctions.InEntranceProductive,
        Out = script_TweenFunctions.OutEntranceProductive,
        InOut = script_TweenFunctions.InOutEntranceProductive,
        OutIn = script_TweenFunctions.OutInEntranceProductive
    },
    Bounce = {
        In = script_TweenFunctions.InBounce,
        Out = script_TweenFunctions.OutBounce,
        InOut = script_TweenFunctions.InOutBounce,
        OutIn = script_TweenFunctions.OutInBounce
    },
    Smooth = {
        In = script_TweenFunctions.InSmooth,
        Out = script_TweenFunctions.OutSmooth,
        InOut = script_TweenFunctions.InOutSmooth,
        OutIn = script_TweenFunctions.OutInSmooth
    },
    Back = {
        In = script_TweenFunctions.InBack,
        Out = script_TweenFunctions.OutBack,
        InOut = script_TweenFunctions.InOutBack,
        OutIn = script_TweenFunctions.OutInBack
    },
    Quart = {
        In = script_TweenFunctions.InQuart,
        Out = script_TweenFunctions.OutQuart,
        InOut = script_TweenFunctions.InOutQuart,
        OutIn = script_TweenFunctions.OutInQuart
    },
    StandardProductive = {
        In = script_TweenFunctions.InStandardProductive,
        Out = script_TweenFunctions.OutStandardProductive,
        InOut = script_TweenFunctions.InOutStandardProductive,
        OutIn = script_TweenFunctions.OutInStandardProductive
    },
    Quad = {
        In = script_TweenFunctions.InQuad,
        Out = script_TweenFunctions.OutQuad,
        InOut = script_TweenFunctions.InOutQuad,
        OutIn = script_TweenFunctions.OutInQuad
    },
    FabricDecelerate = {
        In = script_TweenFunctions.InFabricDecelerate,
        Out = script_TweenFunctions.OutFabricDecelerate,
        InOut = script_TweenFunctions.InOutFabricDecelerate,
        OutIn = script_TweenFunctions.OutInFabricDecelerate
    },
    Acceleration = {
        In = script_TweenFunctions.InAcceleration,
        Out = script_TweenFunctions.OutAcceleration,
        InOut = script_TweenFunctions.InOutAcceleration,
        OutIn = script_TweenFunctions.OutInAcceleration
    },
    SoftSpring = {
        In = script_TweenFunctions.InSoftSpring,
        Out = script_TweenFunctions.OutSoftSpring,
        InOut = script_TweenFunctions.InOutSoftSpring,
        OutIn = script_TweenFunctions.OutInSoftSpring
    },
    ExitExpressive = {
        In = script_TweenFunctions.InExitExpressive,
        Out = script_TweenFunctions.OutExitExpressive,
        InOut = script_TweenFunctions.InOutExitExpressive,
        OutIn = script_TweenFunctions.OutInExitExpressive
    },
    Sharp = {
        In = script_TweenFunctions.InSharp,
        Out = script_TweenFunctions.OutSharp,
        InOut = script_TweenFunctions.InOutSharp,
        OutIn = script_TweenFunctions.OutInSharp
    }
};

function v1.Create(p4, u5, p6) -- Line: 315
    -- upvalues: u2 (copy), RunService (copy), u3 (copy), script_Lerps (copy)
    if not u5 or typeof(u5) ~= "Instance" then
        return warn("Invalid object to tween:", u5);
    end;

    local u7 = type(p6) == "table" and (p6 or {}) or {};
    local u8 = u2[u7.StepType] and RunService[u7.StepType] or RunService.Stepped;
    local u9 = u3[u7.EasingStyle or "Quad"][u7.EasingDirection or "In"];
    local v10 = type(u7.Time) == "number" and (u7.Time or 1) or 1;
    local math_max_ret = math.max(v10, 0.001);
    local v11 = type(u7.Goal) == "table" and (u7.Goal or {}) or {};
    local u12;

    if type(u7.DelayTime) == "number" and u7.DelayTime > 0.027 then
        u12 = u7.DelayTime;
    else
        u12 = false;
    end;

    local u13 = (type(u7.RepeatCount) == "number" and (math.max(u7.RepeatCount, -1) or 0) or 0) + 1;
    local u14 = {};

    for i, v in pairs(v11) do
        u14[i] = script_Lerps[typeof(v)](u5[i], v);
    end;

    local BindableEvent = Instance.new("BindableEvent");
    local BindableEvent2 = Instance.new("BindableEvent");
    local BindableEvent3 = Instance.new("BindableEvent");
    local u15 = nil;
    local os_clock_ret = os.clock();
    local u16 = 0;
    local u17 = {
        Instance = u5,
        PlaybackState = Enum.PlaybackState.Begin,
        Completed = BindableEvent.Event,
        Resumed = BindableEvent3.Event,
        Stopped = BindableEvent2.Event
    };

    function u17.Destroy() -- Line: 353
        -- upvalues: u15 (ref), BindableEvent (copy), BindableEvent2 (copy), BindableEvent3 (copy), u17 (ref)
        if u15 then
            u15:Disconnect();
            u15 = nil;
        end;

        BindableEvent:Destroy();
        BindableEvent2:Destroy();
        BindableEvent3:Destroy();
        u17 = {};
    end;

    local u18 = false;
    local u19 = 0;

    local function Play(p20, u21) -- Line: 369
        -- upvalues: u15 (ref), u13 (copy), u17 (ref), BindableEvent (copy), u18 (ref), u19 (ref), u12 (copy), os_clock_ret (ref), u16 (ref), u8 (copy), math_max_ret (copy), u14 (copy), u5 (copy), Play (copy), u7 (ref), u9 (copy)
        if u15 then
            u15:Disconnect();
            u15 = nil;
        end;

        local u22 = p20 or 1;

        if u13 ~= 0 and u13 < u22 then
            u17.PlaybackState = Enum.PlaybackState.Completed;
            BindableEvent:Fire();
            u18 = false;
            u19 = 1;

            return;
        end;

        u19 = u22;

        if u21 then
            u18 = true;
        end;

        if u12 then
            u17.PlaybackState = Enum.PlaybackState.Delayed;
            task.wait(u12);
        end;

        os_clock_ret = os.clock() - u16;
        u15 = u8:Connect(function() -- Line: 399
            -- upvalues: u16 (ref), os_clock_ret (ref), math_max_ret (ref), u21 (copy), u14 (ref), u5 (ref), u15 (ref), Play (ref), u22 (ref), u7 (ref), u9 (ref)
            u16 = os.clock() - os_clock_ret;

            if math_max_ret > u16 then
                local v23 = u9(u21 and 1 - u16 / math_max_ret or u16 / math_max_ret);
                local math_clamp_ret = math.clamp(v23, 0, 1);

                for i, v in pairs(u14) do
                    u5[i] = v(math_clamp_ret);
                end;

                return;
            end;

            if u21 then
                for i, v in pairs(u14) do
                    u5[i] = v(0);
                end;
            else
                for i, v in pairs(u14) do
                    u5[i] = v(1);
                end;
            end;

            u15:Disconnect();
            u15 = nil;

            if u21 then
                u16 = 0;
                Play(u22 + 1, false);

                return;
            end;

            if u7.Reverses then
                u16 = 0;
                Play(u22, true);

                return;
            end;

            u16 = 0;
            Play(u22 + 1, false);
        end);
        u17.PlaybackState = Enum.PlaybackState.Playing;
    end;

    function u17.Play() -- Line: 439
        -- upvalues: u16 (ref), Play (copy)
        u16 = 0;
        Play(1, false);
    end;

    function u17.Stop() -- Line: 444
        -- upvalues: u15 (ref), u17 (ref), BindableEvent2 (copy)
        if u15 then
            u15:Disconnect();
            u15 = nil;
            u17.PlaybackState = Enum.PlaybackState.Cancelled;
            BindableEvent2:Fire();
        end;
    end;

    function u17.Resume() -- Line: 453
        -- upvalues: Play (copy), u19 (ref), u18 (ref), BindableEvent3 (copy)
        Play(u19, u18);
        BindableEvent3:Fire();
    end;

    return u17;
end;

return v1;