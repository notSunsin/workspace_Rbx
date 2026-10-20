-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Data.Events.HalloweenEvent.WitchesBrewTypes);
require(ReplicatedStorage.Modules.UpdateService);
local Trove = require(ReplicatedStorage.Modules.Trove);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local u1 = Trove.new();
local u2 = Trove.new();
local GameEvents = ReplicatedStorage.GameEvents;
local UpdateCauldronVisuals = GameEvents.Events.HalloweenEvent.WitchesBrew.UpdateCauldronVisuals;
local GetCauldronVisualsData = GameEvents.Events.HalloweenEvent.WitchesBrew.GetCauldronVisualsData;
local LocalPlayer = Players.LocalPlayer;
Color3.fromRGB(170, 85, 255):ToHex();
Color3.new(170, 170, 0);
local u3 = {
    ["Left Leg"] = true,
    ["Right Leg"] = true
};
local u4 = nil;
local u5 = {};

local function hitCheck(p6: userdata) -- Line: 37
    -- upvalues: Players (copy), u3 (copy)
    local v7 = p6:FindFirstAncestorOfClass("Model");

    if not v7 then
        return false;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(v7);

    if not PlayerFromCharacter then
        return false;
    end;

    if PlayerFromCharacter ~= Players.LocalPlayer then
        return false;
    end;

    if not v7:FindFirstChildWhichIsA("Humanoid") then
        return false;
    end;

    if p6:IsA("Tool") then
        return false;
    end;

    return u3[p6.Name] and true or false;
end;

function u5.Start(p8) -- Line: 91
    -- upvalues: EventRotationController (copy), CollectionService (copy), u4 (ref), u1 (copy), GetCauldronVisualsData (copy), LocalPlayer (copy), hitCheck (copy), RunService (copy), UpdateCauldronVisuals (copy)
    if not EventRotationController:GetLoadedEvent() then
        return;
    end;

    local v9;

    if EventRotationController:IsPastEventIDIndex(3) then
        v9 = CollectionService:GetTagged("NewWitchesBrewCauldron")[1];
    else
        v9 = CollectionService:GetTagged("WitchesBrewCauldron")[1];
    end;

    if v9 == u4 then
        return;
    end;

    u4 = v9;
    u1:Clean();
    local Water = v9:FindFirstChild("Water", true);
    v9:FindFirstChild("CauldronBottom", true);
    local VisualParts = Water:FindFirstChild("VisualParts");
    local SpoonSpinner = VisualParts:FindFirstChild("SpoonSpinner");
    local BubblesRoot = VisualParts:FindFirstChild("BubblesRoot");
    local SpinPlayerCollider = VisualParts:FindFirstChild("SpinPlayerCollider");
    local Y = Water.CFrame.Position.Y;
    local u10 = GetCauldronVisualsData:InvokeServer();

    local function SpinLaunch() -- Line: 114
        -- upvalues: LocalPlayer (ref), u1 (ref), SpinPlayerCollider (copy), hitCheck (ref), RunService (ref)
        local u11 = false;
        local u12 = false;
        local _ = LocalPlayer.Character;
        local u13 = nil;
        u1:Add(SpinPlayerCollider.Touched:Connect(function(u14: userdata) -- Line: 125
            -- upvalues: hitCheck (ref), u13 (ref), u12 (ref), u11 (ref), RunService (ref)
            task.spawn(function() -- Line: 126
                -- upvalues: hitCheck (ref), u14 (copy), u13 (ref), u12 (ref), u11 (ref), RunService (ref)
                if not hitCheck(u14) then
                    return;
                end;

                if u13 then
                    return;
                end;

                local HumanoidRootPart = u14:FindFirstAncestorOfClass("Model"):WaitForChild("HumanoidRootPart");
                u12 = false;
                u11 = true;
                local u15 = true;
                local u16 = 0;
                u13 = RunService.RenderStepped:Connect(function(u17) -- Line: 140
                    -- upvalues: u15 (ref), u11 (ref), u16 (ref), HumanoidRootPart (copy), u12 (ref), RunService (ref), u13 (ref)
                    if not (u15 and u11) then
                        return;
                    end;

                    u16 = u16 + u17;
                    local v18 = math.clamp(u16 / 6, 0, 1) ^ 2 * 18.84955592153876;
                    local v19 = HumanoidRootPart;
                    v19.CFrame = v19.CFrame * CFrame.Angles(0, v18 * u17, 0);

                    if u16 >= 6 then
                        u15 = false;
                        u12 = true;
                        local v20 = HumanoidRootPart;
                        v20.AssemblyLinearVelocity = v20.AssemblyLinearVelocity + Vector3.new(0, 300, 0);
                        task.spawn(function() -- Line: 159
                            -- upvalues: RunService (ref), u17 (copy), HumanoidRootPart (ref), u13 (ref)
                            local v21 = 0;

                            while v21 < 2 do
                                RunService.RenderStepped:Wait();
                                v21 = v21 + u17;
                                local v22 = HumanoidRootPart;
                                v22.CFrame = v22.CFrame * CFrame.Angles(0, 18.84955592153876 * u17, 0);
                            end;

                            if u13 then
                                u13:Disconnect();
                                u13 = nil;
                            end;
                        end);
                    end;
                end);
            end);
        end));
        u1:Add(SpinPlayerCollider.TouchEnded:Connect(function(u23: userdata) -- Line: 177
            -- upvalues: u13 (ref), u12 (ref), hitCheck (ref), u11 (ref)
            task.spawn(function() -- Line: 178
                -- upvalues: u13 (ref), u12 (ref), hitCheck (ref), u23 (copy), u11 (ref)
                if u13 and (not u12 and hitCheck(u23)) then
                    u11 = false;
                    u13:Disconnect();
                    u13 = nil;
                end;
            end);
        end));
    end;

    local function BubbleVisual() -- Line: 190
        -- upvalues: Water (copy), BubblesRoot (copy), RunService (ref)
        local function createBubble() -- Line: 191
            -- upvalues: Water (ref), BubblesRoot (ref), RunService (ref)
            local Part = Instance.new("Part");
            Part.Shape = Enum.PartType.Block;
            Part.Size = Vector3.new(0.3, 0.3, 0.3);
            Part.Material = Enum.Material.Neon;
            Part.Color = Color3.fromRGB(200, 200, 255);
            Part.Transparency = 0.5;
            Part.Anchored = true;
            Part.CanCollide = false;
            local Size = Water.Size;
            local v24 = (math.random() - 0.5) * Size.X;
            local v25 = (math.random() - 0.5) * Size.Z;
            local _ = Water.Position.Y + Size.Y / 2;
            Part.Position = Water.Position + Vector3.new(v24, 0, v25);
            Part.Parent = BubblesRoot;
            local u26 = 2 + math.random() * 1;
            local u27 = tick();
            local u28 = nil;
            u28 = RunService.Heartbeat:Connect(function() -- Line: 215
                -- upvalues: u27 (copy), u26 (copy), u28 (ref), Part (copy)
                local v29 = tick() - u27;

                if u26 <= v29 then
                    u28:Disconnect();
                    Part:Destroy();

                    return;
                end;

                Part.Position = Part.Position + Vector3.new(0, 0.01, 0);
                Part.Transparency = 0.5 + v29 / u26 * 0.5;
            end);
        end;

        task.spawn(function() -- Line: 227
            -- upvalues: createBubble (copy)
            while true do
                task.wait(0.2);
                createBubble();
            end;
        end);
    end;

    local function SpoonSpinningVisual() -- Line: 235
        -- upvalues: u1 (ref), RunService (ref), SpoonSpinner (copy)
        u1:Add(RunService.Heartbeat:Connect(function(p30) -- Line: 236
            -- upvalues: SpoonSpinner (ref)
            local math_rad_ret = math.rad(45 * p30);
            local CFrame_Angles_ret = CFrame.Angles(0, math_rad_ret, 0);
            SpoonSpinner:PivotTo(SpoonSpinner:GetPivot() * CFrame_Angles_ret);
        end));
    end;

    local function UpdateWaterColor(p31: string) -- Line: 243
        -- upvalues: Water (copy)
        Water.Color = Color3.fromHex(p31);
    end;

    local function UpdateWaterLevel(p32: number) -- Line: 247
        -- upvalues: Water (copy), Y (copy)
        local v33 = Water.CFrame - Water.CFrame.Position;
        Water.CFrame = CFrame.new((Vector3.new(Water.Position.X, Y + p32 * 1.5, Water.Position.Z))) * v33;
    end;

    local function Initialise() -- Line: 253
        -- upvalues: u10 (copy), Water (copy), Y (copy), u1 (ref), RunService (ref), SpoonSpinner (copy), SpinLaunch (copy)
        local v34 = Water.CFrame - Water.CFrame.Position;
        Water.CFrame = CFrame.new((Vector3.new(Water.Position.X, Y + u10.Percentage * 1.5, Water.Position.Z))) * v34;
        Water.Color = Color3.fromHex(u10.WaterColor);
        u1:Add(RunService.Heartbeat:Connect(function(p35) -- Line: 236
            -- upvalues: SpoonSpinner (ref)
            local math_rad_ret = math.rad(45 * p35);
            local CFrame_Angles_ret = CFrame.Angles(0, math_rad_ret, 0);
            SpoonSpinner:PivotTo(SpoonSpinner:GetPivot() * CFrame_Angles_ret);
        end));
        SpinLaunch();
    end;

    u1:Add(UpdateCauldronVisuals.OnClientEvent:Connect(function(p36) -- Line: 260
        -- upvalues: Water (copy), Y (copy)
        local v37 = Water.CFrame - Water.CFrame.Position;
        Water.CFrame = CFrame.new((Vector3.new(Water.Position.X, Y + p36.Percentage * 1.5, Water.Position.Z))) * v37;
        Water.Color = Color3.fromHex(p36.WaterColor);
    end));
    local v38 = Water.CFrame - Water.CFrame.Position;
    Water.CFrame = CFrame.new((Vector3.new(Water.Position.X, Y + u10.Percentage * 1.5, Water.Position.Z))) * v38;
    Water.Color = Color3.fromHex(u10.WaterColor);
    u1:Add(RunService.Heartbeat:Connect(function(p39) -- Line: 236
        -- upvalues: SpoonSpinner (copy)
        local math_rad_ret = math.rad(45 * p39);
        local CFrame_Angles_ret = CFrame.Angles(0, math_rad_ret, 0);
        SpoonSpinner:PivotTo(SpoonSpinner:GetPivot() * CFrame_Angles_ret);
    end));
    SpinLaunch();
end;

EventRotationClientBinder:Bind({
    Script = script,
    EventSet = { "HalloweenEvent", "Halloween2026Event" },

    OnStart = function() -- Line: 271, Name: OnStart
        -- upvalues: u5 (copy), u2 (copy), EventRotationController (copy)
        task.spawn(u5.Start, u5);
        u2:Add(EventRotationController.EventUpdated:Connect(function(p40, p41) -- Line: 274
            -- upvalues: u5 (ref)
            if p41 ~= "HalloweenEvent" then
                return;
            end;

            u5:Start();
        end));
    end,

    OnStop = function() -- Line: 279, Name: OnStop
        -- upvalues: u2 (copy), u1 (copy), u4 (ref)
        u2:Clean();
        u1:Clean();
        u4 = nil;
    end
});

return u5;