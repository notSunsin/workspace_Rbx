-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 13
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);
local CosmeticActionUserInterfaceService = require(ReplicatedStorage.Modules.CosmeticServices.UserInterface.CosmeticActionUserInterfaceService);
local CosmeticInventoryUserInterfaceService = require(ReplicatedStorage.Modules.CosmeticServices.UserInterface.CosmeticInventoryUserInterfaceService);
local GetMouseToWorld = require(ReplicatedStorage.Modules.GetMouseToWorld);
local GetFarmAsync = require(ReplicatedStorage.Modules.GetFarmAsync);
local GetUIElementWithTag = require(ReplicatedStorage.Modules.GetUIElementWithTag);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
local CosmeticHover = LocalPlayer.PlayerGui.CosmeticUI.CosmeticHover;
local u1 = GetFarmAsync(LocalPlayer);
local Highlight = Instance.new("Highlight");
Highlight.FillTransparency = 1;
local u2 = nil;
local u3 = nil;

local function TargettingInputBegan() -- Line: 36
    -- upvalues: u3 (ref), TweenService (copy), Highlight (copy)
    if not u3 then
        return;
    end;

    TweenService:Create(Highlight, TweenInfo.new(0.2), {
        OutlineTransparency = 0.8
    }):Play();
end;

local function TargettingInputEnded() -- Line: 45
    -- upvalues: u3 (ref), UserInputService (copy), CosmeticActionUserInterfaceService (copy), TweenService (copy), Highlight (copy)
    if not u3 then
        if UserInputService.TouchEnabled then
            CosmeticActionUserInterfaceService:Toggle(false);
        end;

        return;
    end;

    TweenService:Create(Highlight, TweenInfo.new(0.2), {
        OutlineTransparency = 0
    }):Play();

    if CosmeticActionUserInterfaceService.Target == u3 then
        CosmeticActionUserInterfaceService:Toggle(true);

        return;
    end;

    if CosmeticActionUserInterfaceService.Target ~= nil then
        CosmeticActionUserInterfaceService:Toggle(false);
    end;

    task.delay(0.1, function() -- Line: 68
        -- upvalues: CosmeticActionUserInterfaceService (ref), u3 (ref)
        CosmeticActionUserInterfaceService:SetTarget(u3);
        CosmeticActionUserInterfaceService:Toggle(true);
    end);
end;

local u5 = {
    [Enum.UserInputType.Touch] = { function(p4: userdata) -- Line: 76
            -- upvalues: TargettingInputBegan (copy)
            TargettingInputBegan();
        end },
    [Enum.UserInputType.MouseButton1] = { function() -- Line: 81
            -- upvalues: TargettingInputBegan (copy)
            TargettingInputBegan();
        end },
    [Enum.KeyCode.ButtonR2] = { function() -- Line: 86
            -- upvalues: TargettingInputBegan (copy)
            TargettingInputBegan();
        end }
};
local u7 = {
    [Enum.UserInputType.Touch] = { function(p6: userdata) -- Line: 94
            -- upvalues: TargettingInputEnded (copy)
            TargettingInputEnded();
        end },
    [Enum.UserInputType.MouseButton1] = { function() -- Line: 99
            -- upvalues: TargettingInputEnded (copy)
            TargettingInputEnded();
        end },
    [Enum.KeyCode.ButtonR2] = { function() -- Line: 104
            -- upvalues: TargettingInputEnded (copy)
            TargettingInputEnded();
        end }
};
UserInputService.InputBegan:Connect(function(u8, p9) -- Line: 110
    -- upvalues: u5 (copy)
    local v10 = u5[u8.KeyCode] or u5[u8.UserInputType];

    if not v10 then
        return;
    end;

    for _, v in v10 do
        task.spawn(function() -- Line: 114
            -- upvalues: v (copy), u8 (copy)
            v(u8);
        end);
    end;
end);
UserInputService.InputEnded:Connect(function(u11, p12) -- Line: 121
    -- upvalues: u7 (copy)
    local v13 = u7[u11.KeyCode] or u7[u11.UserInputType];

    if not v13 then
        return;
    end;

    for _, v in v13 do
        task.spawn(function() -- Line: 125
            -- upvalues: v (copy), u11 (copy)
            v(u11);
        end);
    end;
end);
UserInputService.TouchTap:Connect(function() -- Line: 131
    -- upvalues: TargettingInputBegan (copy)
    TargettingInputBegan();
end);
UserInputService.TouchEnded:Connect(function() -- Line: 135
    -- upvalues: TargettingInputEnded (copy)
    TargettingInputEnded();
end);
Highlight.Parent = script;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterDescendantsInstances = CollectionService:GetTagged("CosmeticHitBox");
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
CreateTagHandler({
    Tag = "CosmeticHitBox",

    OnInstanceAdded = function(p14) -- Line: 149, Name: OnInstanceAdded
        -- upvalues: RaycastParams_new_ret (copy)
        RaycastParams_new_ret:AddToFilter(p14);
    end
});
task.spawn(function() -- Line: 155
    -- upvalues: UserInputService (copy), u2 (ref), GetMouseToWorld (copy), RaycastParams_new_ret (copy), u1 (copy), CosmeticInventoryUserInterfaceService (copy), GetUIElementWithTag (copy), Highlight (copy), CosmeticHover (copy), u3 (ref)
    while true do
        local v15;

        repeat
            task.wait(0.025);
            v15 = UserInputService:GetMouseLocation();
        until v15 ~= u2;

        u2 = v15;
        local v16 = GetMouseToWorld(RaycastParams_new_ret, 1000);

        if v16 then
            v16 = v16.Instance;
        end;

        if v16 and not v16:IsDescendantOf(u1) then
            v16 = nil;
        elseif not CosmeticInventoryUserInterfaceService.State or GetUIElementWithTag("ICON_TEMPLATE") then
            v16 = nil;
        end;

        if v16 then
            v16 = v16.Parent;
        end;

        Highlight.Adornee = v16 or script;
        CosmeticHover.Visible = v16 ~= nil;
        CosmeticHover.TextLabel.Text = `{v16 and (v16.Name or "") or ""}`;

        if v16 and v16:GetAttribute("CosmeticVariant") then
            CosmeticHover.TextLabel.Text = `{CosmeticHover.TextLabel.Text} (Variant {v16:GetAttribute("CosmeticVariant")})`;
        end;

        u3 = v16;
    end;
end);
RunService.RenderStepped:Connect(function(p17: number) -- Line: 183
    -- upvalues: UserInputService (copy), GuiService (copy), CosmeticHover (copy)
    local v18 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
    CosmeticHover.Position = UDim2.fromOffset(v18.X, v18.Y);
end);

return {};