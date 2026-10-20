-- Decompiled with Potassium's decompiler.

local v1 = {};
local TweenService = game:GetService("TweenService");
local LocalPlayer = game.Players.LocalPlayer;

function v1.Setup() -- Line: 4
    -- upvalues: LocalPlayer (copy)
    LocalPlayer:SetAttribute("Core_FOV", 70);
end;

function v1.Change_FOV_CORE(p2) -- Line: 7
    -- upvalues: LocalPlayer (copy)
    if LocalPlayer and p2 then
        LocalPlayer:SetAttribute("Core_FOV", p2);
    end;
end;

function v1.Return_Core_FOV() -- Line: 12
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetAttribute("Core_FOV");
end;

function v1.Change_FOV(p3, p4) -- Line: 15
    -- upvalues: LocalPlayer (copy), TweenService (copy)
    if game.Workspace.CurrentCamera then
        if p3 == 70 then
            p3 = LocalPlayer:GetAttribute("Core_FOV");
        end;

        local TweenInfo_new_ret = TweenInfo.new((p4 == nil and 0.5 or p4) * (math.random(95, 105) * 0.01), Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
        local v5 = TweenService:Create(game.Workspace.CurrentCamera, TweenInfo_new_ret, {
            FieldOfView = p3
        });
        v5:Play();
        game.Debris:AddItem(v5, TweenInfo_new_ret.Time);
    end;
end;

return v1;