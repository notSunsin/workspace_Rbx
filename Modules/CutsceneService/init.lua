-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local ObjectValue = Instance.new("ObjectValue");
ObjectValue.Parent = game.ReplicatedStorage;
ObjectValue.Name = "CameraTarget";
ObjectValue.Value = nil;
local u1 = script:WaitForChild("SkipCutscene"):Clone();
game.TweenService:Create(u1.TextLabel, TweenInfo.new(2), {
    TextTransparency = 0,
    TextStrokeTransparency = 0
});
game.TweenService:Create(u1.TextLabel, TweenInfo.new(2), {
    TextTransparency = 1,
    TextStrokeTransparency = 1
});
u1.Parent = game.Players.LocalPlayer.PlayerGui;

local function _() -- Line: 18
    -- upvalues: ObjectValue (copy)
    return ObjectValue.Value;
end;

local u2 = false;
local u3 = {};
local u4 = {};

local function playAnimations(u5: userdata, u6: userdata, p7: any) -- Line: 28
    -- upvalues: u4 (ref), u3 (ref), u2 (ref)
    local MarkerEvents = require(u5.MarkerEvents);
    u4 = {};
    table.insert(u4, u5);
    table.insert(u4, u6);

    for i, v in p7 do
        local v8 = u6.Rigs:FindFirstChild(i);

        if v8 then
            local v9 = v8:FindFirstChild("Humanoid") or v8:FindFirstChild("AnimationController", true);

            if v9 then
                u3[i] = v9:LoadAnimation(v);
            else
                warn("Didn\'t find controller for " .. i);
            end;
        end;
    end;

    for i, v in MarkerEvents do
        u3.CameraRig:GetMarkerReachedSignal(i):Connect(function() -- Line: 54
            -- upvalues: v (copy), u5 (copy), u6 (copy), u3 (ref)
            v(u5, u6, u3);
        end);
    end;

    for _, v in u3 do
        v:Play();
    end;

    print("LOADED AND SETUP!");
    u3.CameraRig.Stopped:Once(function() -- Line: 68
        -- upvalues: u2 (ref), MarkerEvents (copy), u5 (copy), u3 (ref)
        if u2 == true then
            MarkerEvents._OnEnd(u5);
        end;

        u2 = false;
        print("ANIMATION ENDED");

        for _, v in u3 do
            v:Stop();
        end;
    end);
    task.spawn(function() -- Line: 85
        -- upvalues: u2 (ref), u3 (ref)
        repeat
            task.wait();
        until u2 == false;

        for _, v in u3 do
            v:Stop();
        end;
    end);
end;

local u13 = {
    attemptDelayedPreload = function(p10) -- Line: 98, Name: attemptDelayedPreload
        -- upvalues: u2 (ref)
        local IDs = require(p10.IDs);
        local _ = p10.CutsceneFolder;
        print("Preloading Started");
        local v11 = {};

        for _, v in IDs do
            local Animation = Instance.new("Animation");
            Animation.AnimationId = "rbxassetid://" .. tonumber(v);
            table.insert(v11, Animation);
        end;

        while true do
            local v12 = u2 == false and v11[1];

            if not v12 then
                break;
            end;

            game:GetService("ContentProvider"):PreloadAsync({ v12 });
            task.wait(Random.new():NextInteger(1, 80));
            table.remove(v11, 1);
        end;

        for _, v in v11 do
            v:Destroy();
        end;
    end
};

local function preloadAnimations(p14: userdata) -- Line: 137
    -- upvalues: playAnimations (copy)
    local IDs = require(p14.IDs);
    local CutsceneFolder = p14.CutsceneFolder;
    CutsceneFolder.Parent = workspace;
    local v15 = {};

    for i, v in IDs do
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://" .. tonumber(v);
        table.insert(v15, Animation);
        v15[i] = Animation;
    end;

    game:GetService("ContentProvider"):PreloadAsync(v15);

    repeat
        task.wait(0);
    until game:GetService("ContentProvider").RequestQueueSize == 0;

    task.wait(2);
    playAnimations(p14, CutsceneFolder, v15);

    return CutsceneFolder;
end;

local function playCamera(u16, u17) -- Line: 165
    -- upvalues: ObjectValue (copy), u2 (ref), u1 (copy), u13 (copy), u4 (ref), u3 (ref)
    ObjectValue.Value = u16.DefaultCameraAttach.Value;
    local MarkerEvents = require(u16.MarkerEvents);
    local FoV = require(u16.FoV);
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local u18 = 0;

    local function Lerp(p19, p20, p21) -- Line: 182
        return p19 + (p20 - p19) * p21;
    end;

    game:GetService("RunService"):BindToRenderStep("CameraTargetUpdate", Enum.RenderPriority.Camera.Value, function(p22) -- Line: 186
        -- upvalues: u2 (ref), ObjectValue (ref), u18 (ref), FoV (copy), workspace_CurrentCamera (copy), FieldOfView (ref)
        if u2 == false then
            game:GetService("RunService"):UnbindFromRenderStep("CameraTargetUpdate");
            game.Players.LocalPlayer.Character.Humanoid.AutoRotate = true;
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace.CurrentCamera.FieldOfView = 70;
            ObjectValue.Value = nil;

            return;
        end;

        workspace.CurrentCamera.CFrame = ObjectValue.Value.CFrame;
        game.Players.LocalPlayer.Character.Humanoid.AutoRotate = false;
        u18 = u18 + p22 * 60;
        local v23 = FoV[math.ceil(u18)];

        if v23 ~= nil then
            if math.ceil(u18) >= #FoV then
                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            local v24 = FieldOfView;
            FieldOfView = v24 + (v23 - v24) * (p22 * 10);
        end;
    end);
    local u25 = {};

    for _, child in game.Players.LocalPlayer.PlayerGui:GetChildren() do
        if child:IsA("LayerCollector") and not child:HasTag("ShowDuringCutscene") then
            u25[child] = child.Enabled;
            child.Enabled = false;
        end;
    end;

    task.spawn(function() -- Line: 230
        -- upvalues: u2 (ref), u1 (ref)
        task.wait(4);

        if u2 then
            return;
        end;

        u1.TextLabel.TextTransparency = 1;
        u1.TextLabel.UIStroke.Transparency = 1;
    end);
    game.Lighting.Blur.Enabled = false;
    local u26 = 0;
    local u27 = u16.CutsceneMaxLength.Value or 60;
    task.spawn(function() -- Line: 246
        -- upvalues: u26 (ref), u27 (copy), u2 (ref), u25 (copy), u13 (ref)
        while u26 < u27 and u2 == true do
            u26 = u26 + game:GetService("RunService").Heartbeat:Wait();
        end;

        for i, v in u25 do
            if i:IsDescendantOf(game.Players.LocalPlayer) then
                i.Enabled = v;
            end;
        end;

        task.spawn(function() -- Line: 258
            local PlayerGui = game.Players.LocalPlayer.PlayerGui;
            PlayerGui.Bottom_UI.Enabled = true;
            PlayerGui.GearHover_UI.Enabled = true;
            PlayerGui.Gift_Notification.Enabled = true;
            PlayerGui.Hud_UI.Enabled = true;
            PlayerGui.PetUI.Enabled = true;
            PlayerGui.PickupTally.Enabled = true;
            PlayerGui.PlantHover_UI.Enabled = true;
            PlayerGui.Pop_Effect.Enabled = true;
            PlayerGui.Rejoin_UI.Enabled = true;
            PlayerGui.Teleport_UI.Enabled = true;
            PlayerGui.Top_Notification.Enabled = true;
            PlayerGui.Tutorial_UI.Enabled = true;

            if PlayerGui:FindFirstChild("TouchGui") then
                PlayerGui.TouchGui.Enabled = true;
            end;

            PlayerGui.BackpackGui.Enabled = true;
        end);
        game.Players.LocalPlayer.Character.Humanoid.AutoRotate = true;
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace.CurrentCamera.FieldOfView = 70;
        task.delay(5, function() -- Line: 289
            game.Lighting.Cutscene.Brightness = 0;
        end);
        u13.Stop();
    end);
    task.spawn(function() -- Line: 302
        -- upvalues: MarkerEvents (copy), u16 (copy), u17 (copy)
        MarkerEvents._OnStart(u16, u17);
    end);

    repeat
        task.wait();
    until u2 == false;

    u2 = false;

    for i, v in u25 do
        if i:IsDescendantOf(game.Players.LocalPlayer) then
            i.Enabled = v;
        end;
    end;

    for _, v in u4 do
        v:Destroy();
    end;

    for _, v in game.CollectionService:GetTagged("RemoveMeIfCutsceneEnd") do
        v:Destroy();
    end;

    u3 = {};
    u4 = {};
    u16:Destroy();
    game.SoundService.Music.Volume = 1;
    game.Lighting.Blur.Enabled = true;
end;

local function cutscene(p28: userdata) -- Line: 336
    -- upvalues: preloadAnimations (copy), playCamera (copy)
    playCamera(p28, (preloadAnimations(p28)));
end;

function u13.Play(p29: userdata, u30: boolean) -- Line: 375
    -- upvalues: u2 (ref), GuiController (copy), preloadAnimations (copy), playCamera (copy)
    if u2 then
        return;
    end;

    for _, child in game.Players.LocalPlayer.PlayerGui:GetChildren() do
        if child:IsA("LayerCollector") and GuiController:GetStateForGui(child).Visible:Get() then
            GuiController:Close(child);
        end;
    end;

    print(u30);
    game.SoundService.Music.Volume = 0;
    u2 = true;

    if u30 then
        task.wait(3);
    end;

    local v31 = p29:Clone();
    task.spawn(function() -- Line: 398
        -- upvalues: u30 (copy)
        if u30 then
            task.wait(2);
        end;
    end);

    if u2 then
        playCamera(v31, (preloadAnimations(v31)));
    end;

    task.wait(3);
    u2 = false;
end;

function u13.Stop() -- Line: 418
    -- upvalues: u2 (ref)
    if not u2 then
        return;
    end;

    task.wait(3);
    u2 = false;
    task.wait(2);
    task.spawn(function() -- Line: 428
        game.Lighting.Cutscene.Brightness = 0;
    end);
    task.spawn(function() -- Line: 433
        local PlayerGui = game.Players.LocalPlayer.PlayerGui;
        PlayerGui.Bottom_UI.Enabled = true;
        PlayerGui.GearHover_UI.Enabled = true;
        PlayerGui.Gift_Notification.Enabled = true;
        PlayerGui.Hud_UI.Enabled = true;
        PlayerGui.PetUI.Enabled = true;
        PlayerGui.PickupTally.Enabled = true;
        PlayerGui.PlantHover_UI.Enabled = true;
        PlayerGui.Pop_Effect.Enabled = true;
        PlayerGui.Rejoin_UI.Enabled = true;
        PlayerGui.Teleport_UI.Enabled = true;
        PlayerGui.Top_Notification.Enabled = true;
        PlayerGui.Tutorial_UI.Enabled = true;

        if PlayerGui:FindFirstChild("TouchGui") then
            PlayerGui.TouchGui.Enabled = true;
        end;

        PlayerGui.BackpackGui.Enabled = true;
        PlayerGui.ProximityPrompts.Enabled = true;
    end);
    game.Players.LocalPlayer.Character.Humanoid.AutoRotate = true;
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace.CurrentCamera.FieldOfView = 70;
end;

game.ReplicatedStorage.GameEvents.CutsceneHandler.OnClientEvent:Connect(function(p32) -- Line: 473
    -- upvalues: u13 (copy)
    u13.Play(p32);
end);

return u13;