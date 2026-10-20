-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
require(ReplicatedStorage.Data.Events.HalloweenEvent.WitchesBrewTypes);
require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.UpdateService);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local Trove = require(ReplicatedStorage.Modules.Trove);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local SharedCycleHandlerData = require(ReplicatedStorage.Data.SharedCycleHandlerData);
local u1 = Trove.new();
local UpdateCauldronVisuals = ReplicatedStorage:WaitForChild("GameEvents").Events.HalloweenEvent.WitchesBrew.UpdateCauldronVisuals;
local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Sine);
local CFrame_Angles_ret = CFrame.Angles(0, -2.0912360564470855, 0);
local CFrame_Angles_ret2 = CFrame.Angles(0, -1.4759202286564848, 0);
local u2 = CFrame.new(Vector3.new(-111.378, 0, -16.2)) * CFrame_Angles_ret;
local u3 = CFrame.new(Vector3.new(-111.378, 16.012, -16.2)) * CFrame_Angles_ret;
local u4 = CFrame.new(Vector3.new(-111.378, -4, -16.2)) * CFrame_Angles_ret;
local u5 = CFrame.new(Vector3.new(-111.378, 10.348, -16.2)) * CFrame_Angles_ret;
local u6 = CFrame.new(Vector3.new(-112.818, -2, -9.121)) * CFrame_Angles_ret2;
local u7 = CFrame.new(Vector3.new(-112.818, 7.512, -9.121)) * CFrame_Angles_ret2;
local WBLeaderboardEntryTemplate = ReplicatedStorage.UITemplates.WBLeaderboardEntryTemplate;
local u8 = nil;
local u9 = nil;
local u10 = {};
local u11 = {};
local u12 = {};
local WitchesBrew = SharedCycleHandlerData.WitchesBrew;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;

local function HitCheck(p21: userdata) -- Line: 52
    -- upvalues: Players (copy)
    local v22 = p21:FindFirstAncestorOfClass("Model");

    if not v22 then
        return false;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(v22);

    if not PlayerFromCharacter then
        return false;
    end;

    if PlayerFromCharacter == Players.LocalPlayer then
        return v22:FindFirstChildWhichIsA("Humanoid") and true or false;
    end;

    return false;
end;

local function PlayTween(u23: userdata, p24: table, p25: number) -- Line: 67
    -- upvalues: u12 (copy), TweenService (copy), TweenInfo_new_ret (copy)
    if u12[u23] then
        u12[u23]:Cancel();
    end;

    local u26 = TweenService:Create(u23, TweenInfo_new_ret, p24);
    u12[u23] = u26;

    if p25 and p25 > 0 then
        task.delay(p25, function() -- Line: 77
            -- upvalues: u12 (ref), u23 (copy), u26 (copy)
            if u12[u23] == u26 then
                u26:Play();
            end;
        end);

        return;
    end;

    u26:Play();
end;

local function InitialiseCFrames(p27: boolean?) -- Line: 89
    -- upvalues: CFrame_Angles_ret (ref), CFrame_Angles_ret2 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref)
    if p27 then
        CFrame_Angles_ret = CFrame.Angles(0, 1.0503565971427073, 0);
        CFrame_Angles_ret2 = CFrame.Angles(0, 1.6656724249333084, 0);
        u2 = CFrame.new(-90.552, 0, -23.679) * CFrame_Angles_ret;
        u3 = CFrame.new(-90.552, 15.404, -23.679) * CFrame_Angles_ret;
        u4 = CFrame.new(-90.551, -4, -23.679) * CFrame_Angles_ret;
        u5 = CFrame.new(-90.551, 9.74, -23.679) * CFrame_Angles_ret;
        u6 = CFrame.new(-89.111, -10, -30.758) * CFrame_Angles_ret2;
        u7 = CFrame.new(-89.111, 6.904, -30.758) * CFrame_Angles_ret2;

        return;
    end;

    CFrame_Angles_ret = CFrame.Angles(0, -2.0912360564470855, 0);
    CFrame_Angles_ret2 = CFrame.Angles(0, -1.4759202286564848, 0);
    u2 = CFrame.new(Vector3.new(-111.378, 0, -16.2)) * CFrame_Angles_ret;
    u3 = CFrame.new(Vector3.new(-111.378, 16.012, -16.2)) * CFrame_Angles_ret;
    u4 = CFrame.new(Vector3.new(-111.378, -4, -16.2)) * CFrame_Angles_ret;
    u5 = CFrame.new(Vector3.new(-111.378, 10.348, -16.2)) * CFrame_Angles_ret;
    u6 = CFrame.new(Vector3.new(-112.818, -2, -9.121)) * CFrame_Angles_ret2;
    u7 = CFrame.new(Vector3.new(-112.818, 7.512, -9.121)) * CFrame_Angles_ret2;
end;

local function UpdateWitchesBrewInstances() -- Line: 120
    -- upvalues: u13 (ref), CollectionService (copy), WitchesBrew (ref), SharedCycleHandlerData (copy), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref)
    u13 = CollectionService:GetTagged("WitchesBrewModel")[1];

    if WitchesBrew == SharedCycleHandlerData.WitchesBrewAndDeadTree then
        u13 = CollectionService:GetTagged("WitchAndTreePlatform")[1];
    end;

    u14 = u13:WaitForChild("WitchesBrewLeaderboard");
    u15 = u14:FindFirstChild("TitlePlank");
    u16 = u14:FindFirstChild("LeaderboardPanel");
    u17 = u14:FindFirstChild("LeaderboardEnableCollider");
    u18 = u14:FindFirstChild("RobuxFillCauldron");
    u19 = u16:FindFirstChild("SurfaceGui");
    u20 = u19:FindFirstChild("ScoreList", true);
end;

local function BuildLeaderboard(p28: table) -- Line: 136
    -- upvalues: u20 (ref), u10 (ref), WBLeaderboardEntryTemplate (copy)
    local v29 = u20;

    local function contributionSort(p30, p31) -- Line: 137
        return p30.Contribution < p31.Contribution;
    end;

    for _, child in v29:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    u10 = p28;
    table.sort(u10, contributionSort);

    if u10 == nil then
        return;
    end;

    local v32 = #u10;

    for _, v in u10 do
        local v33 = WBLeaderboardEntryTemplate:Clone();
        v33.PlayerName.Text = v.Player.Name;
        v33.PlayerScore.Text = v.Contribution;
        v33.LayoutOrder = -v.Contribution;
        v33.Size = UDim2.new(1, 0, math.min(0.2, 1 / v32), 0);
        v33.Parent = v29;
    end;
end;

local function ConnectLeaderboardTouched(p34: userdata) -- Line: 167
    -- upvalues: u8 (ref), Players (copy), u15 (ref), u3 (ref), u12 (copy), TweenService (copy), TweenInfo_new_ret (copy), u16 (ref), u5 (ref), u18 (ref), u7 (ref)
    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;

    u8 = p34.Touched:Connect(function(p35) -- Line: 173
        -- upvalues: Players (ref), u15 (ref), u3 (ref), u12 (ref), TweenService (ref), TweenInfo_new_ret (ref), u16 (ref), u5 (ref), u18 (ref), u7 (ref)
        local v36 = p35:FindFirstAncestorOfClass("Model");
        local v37;

        if v36 then
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(v36);

            if PlayerFromCharacter and PlayerFromCharacter == Players.LocalPlayer then
                v37 = v36:FindFirstChildWhichIsA("Humanoid") and true or false;
            else
                v37 = false;
            end;
        else
            v37 = false;
        end;

        if not v37 then
            return;
        end;

        local v38 = u15;
        local v39 = {
            Transparency = 0.5,
            CFrame = u3
        };

        if u12[v38] then
            u12[v38]:Cancel();
        end;

        local v40 = TweenService:Create(v38, TweenInfo_new_ret, v39);
        u12[v38] = v40;
        v40:Play();
        local u41 = u16;
        local v42 = {
            Transparency = 0.5,
            CFrame = u5
        };

        if u12[u41] then
            u12[u41]:Cancel();
        end;

        local u43 = TweenService:Create(u41, TweenInfo_new_ret, v42);
        u12[u41] = u43;
        task.delay(0.5, function() -- Line: 77
            -- upvalues: u12 (ref), u41 (copy), u43 (copy)
            if u12[u41] == u43 then
                u43:Play();
            end;
        end);
        local u44 = u18;
        local v45 = {
            Transparency = 0.5,
            CFrame = u7
        };

        if u12[u44] then
            u12[u44]:Cancel();
        end;

        local u46 = TweenService:Create(u44, TweenInfo_new_ret, v45);
        u12[u44] = u46;
        task.delay(0.6, function() -- Line: 77
            -- upvalues: u12 (ref), u44 (copy), u46 (copy)
            if u12[u44] == u46 then
                u46:Play();
            end;
        end);
    end);
end;

local function ConnectLeaderboardTouchedEnded(p47: userdata) -- Line: 182
    -- upvalues: u9 (ref), Players (copy), u18 (ref), u6 (ref), u12 (copy), TweenService (copy), TweenInfo_new_ret (copy), u16 (ref), u4 (ref), u15 (ref), u2 (ref)
    if u9 then
        u9:Disconnect();
        u9 = nil;
    end;

    u9 = p47.TouchEnded:Connect(function(p48) -- Line: 188
        -- upvalues: Players (ref), u18 (ref), u6 (ref), u12 (ref), TweenService (ref), TweenInfo_new_ret (ref), u16 (ref), u4 (ref), u15 (ref), u2 (ref)
        local v49 = p48:FindFirstAncestorOfClass("Model");
        local v50;

        if v49 then
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(v49);

            if PlayerFromCharacter and PlayerFromCharacter == Players.LocalPlayer then
                v50 = v49:FindFirstChildWhichIsA("Humanoid") and true or false;
            else
                v50 = false;
            end;
        else
            v50 = false;
        end;

        if not v50 then
            return;
        end;

        local v51 = u18;
        local v52 = {
            Transparency = 1,
            CFrame = u6
        };

        if u12[v51] then
            u12[v51]:Cancel();
        end;

        local v53 = TweenService:Create(v51, TweenInfo_new_ret, v52);
        u12[v51] = v53;
        v53:Play();
        local u54 = u16;
        local v55 = {
            Transparency = 1,
            CFrame = u4
        };

        if u12[u54] then
            u12[u54]:Cancel();
        end;

        local u56 = TweenService:Create(u54, TweenInfo_new_ret, v55);
        u12[u54] = u56;
        task.delay(0.1, function() -- Line: 77
            -- upvalues: u12 (ref), u54 (copy), u56 (copy)
            if u12[u54] == u56 then
                u56:Play();
            end;
        end);
        local u57 = u15;
        local v58 = {
            Transparency = 1,
            CFrame = u2
        };

        if u12[u57] then
            u12[u57]:Cancel();
        end;

        local u59 = TweenService:Create(u57, TweenInfo_new_ret, v58);
        u12[u57] = u59;
        task.delay(0.35, function() -- Line: 77
            -- upvalues: u12 (ref), u57 (copy), u59 (copy)
            if u12[u57] == u59 then
                u59:Play();
            end;
        end);
    end);
end;

local function Initialise(p60: boolean?) -- Line: 198
    -- upvalues: InitialiseCFrames (copy), u17 (ref), u8 (ref), Players (copy), u15 (ref), u3 (ref), u12 (copy), TweenService (copy), TweenInfo_new_ret (copy), u16 (ref), u5 (ref), u18 (ref), u7 (ref), u9 (ref), u6 (ref), u4 (ref), u2 (ref), BuildLeaderboard (copy), u10 (ref)
    InitialiseCFrames(p60);

    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;

    u8 = u17.Touched:Connect(function(p61) -- Line: 173
        -- upvalues: Players (ref), u15 (ref), u3 (ref), u12 (ref), TweenService (ref), TweenInfo_new_ret (ref), u16 (ref), u5 (ref), u18 (ref), u7 (ref)
        local v62 = p61:FindFirstAncestorOfClass("Model");
        local v63;

        if v62 then
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(v62);

            if PlayerFromCharacter and PlayerFromCharacter == Players.LocalPlayer then
                v63 = v62:FindFirstChildWhichIsA("Humanoid") and true or false;
            else
                v63 = false;
            end;
        else
            v63 = false;
        end;

        if not v63 then
            return;
        end;

        local v64 = u15;
        local v65 = {
            Transparency = 0.5,
            CFrame = u3
        };

        if u12[v64] then
            u12[v64]:Cancel();
        end;

        local v66 = TweenService:Create(v64, TweenInfo_new_ret, v65);
        u12[v64] = v66;
        v66:Play();
        local u67 = u16;
        local v68 = {
            Transparency = 0.5,
            CFrame = u5
        };

        if u12[u67] then
            u12[u67]:Cancel();
        end;

        local u69 = TweenService:Create(u67, TweenInfo_new_ret, v68);
        u12[u67] = u69;
        task.delay(0.5, function() -- Line: 77
            -- upvalues: u12 (ref), u67 (copy), u69 (copy)
            if u12[u67] == u69 then
                u69:Play();
            end;
        end);
        local u70 = u18;
        local v71 = {
            Transparency = 0.5,
            CFrame = u7
        };

        if u12[u70] then
            u12[u70]:Cancel();
        end;

        local u72 = TweenService:Create(u70, TweenInfo_new_ret, v71);
        u12[u70] = u72;
        task.delay(0.6, function() -- Line: 77
            -- upvalues: u12 (ref), u70 (copy), u72 (copy)
            if u12[u70] == u72 then
                u72:Play();
            end;
        end);
    end);

    if u9 then
        u9:Disconnect();
        u9 = nil;
    end;

    u9 = u17.TouchEnded:Connect(function(p73) -- Line: 188
        -- upvalues: Players (ref), u18 (ref), u6 (ref), u12 (ref), TweenService (ref), TweenInfo_new_ret (ref), u16 (ref), u4 (ref), u15 (ref), u2 (ref)
        local v74 = p73:FindFirstAncestorOfClass("Model");
        local v75;

        if v74 then
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(v74);

            if PlayerFromCharacter and PlayerFromCharacter == Players.LocalPlayer then
                v75 = v74:FindFirstChildWhichIsA("Humanoid") and true or false;
            else
                v75 = false;
            end;
        else
            v75 = false;
        end;

        if not v75 then
            return;
        end;

        local v76 = u18;
        local v77 = {
            Transparency = 1,
            CFrame = u6
        };

        if u12[v76] then
            u12[v76]:Cancel();
        end;

        local v78 = TweenService:Create(v76, TweenInfo_new_ret, v77);
        u12[v76] = v78;
        v78:Play();
        local u79 = u16;
        local v80 = {
            Transparency = 1,
            CFrame = u4
        };

        if u12[u79] then
            u12[u79]:Cancel();
        end;

        local u81 = TweenService:Create(u79, TweenInfo_new_ret, v80);
        u12[u79] = u81;
        task.delay(0.1, function() -- Line: 77
            -- upvalues: u12 (ref), u79 (copy), u81 (copy)
            if u12[u79] == u81 then
                u81:Play();
            end;
        end);
        local u82 = u15;
        local v83 = {
            Transparency = 1,
            CFrame = u2
        };

        if u12[u82] then
            u12[u82]:Cancel();
        end;

        local u84 = TweenService:Create(u82, TweenInfo_new_ret, v83);
        u12[u82] = u84;
        task.delay(0.35, function() -- Line: 77
            -- upvalues: u12 (ref), u82 (copy), u84 (copy)
            if u12[u82] == u84 then
                u84:Play();
            end;
        end);
    end);
    u15.CFrame = u2;
    u16.CFrame = u4;
    u18.CFrame = u6;
    BuildLeaderboard(u10);
end;

function u11.Start(p85) -- Line: 210
    -- upvalues: UpdateWitchesBrewInstances (copy), u1 (copy), UpdateCauldronVisuals (copy), BuildLeaderboard (copy), Players (copy), u10 (ref)
    UpdateWitchesBrewInstances();
    u1:Add(UpdateCauldronVisuals.OnClientEvent:Connect(function(p86) -- Line: 214
        -- upvalues: BuildLeaderboard (ref)
        BuildLeaderboard(p86.Leaderboard);
    end));
    u1:Add(Players.PlayerRemoving:Connect(function(p87) -- Line: 219
        -- upvalues: u10 (ref), BuildLeaderboard (ref)
        for i, v in u10 do
            if v.Player == p87 then
                table.remove(u10, i);
                break;
            end;
        end;

        BuildLeaderboard(u10);
    end));
end;

EventRotationClientBinder:Bind({
    Script = script,
    EventSet = { "HalloweenEvent", "Halloween2026Event" },

    OnStart = function() -- Line: 234, Name: OnStart
        -- upvalues: u11 (copy), EventRotationController (copy), WitchesBrew (ref), SharedCycleHandlerData (copy), InitialiseCFrames (copy), u17 (ref), u8 (ref), Players (copy), u15 (ref), u3 (ref), u12 (copy), TweenService (copy), TweenInfo_new_ret (copy), u16 (ref), u5 (ref), u18 (ref), u7 (ref), u9 (ref), u6 (ref), u4 (ref), u2 (ref), BuildLeaderboard (copy), u10 (ref), UpdateWitchesBrewInstances (copy), u1 (copy)
        task.spawn(u11.Start, u11);

        local function CheckCombinedSwitch() -- Line: 237
            -- upvalues: EventRotationController (ref), WitchesBrew (ref), SharedCycleHandlerData (ref), InitialiseCFrames (ref), u17 (ref), u8 (ref), Players (ref), u15 (ref), u3 (ref), u12 (ref), TweenService (ref), TweenInfo_new_ret (ref), u16 (ref), u5 (ref), u18 (ref), u7 (ref), u9 (ref), u6 (ref), u4 (ref), u2 (ref), BuildLeaderboard (ref), u10 (ref), UpdateWitchesBrewInstances (ref)
            if EventRotationController:IsPastEventIDIndex(3) and WitchesBrew ~= SharedCycleHandlerData.WitchesBrewAndDeadTree then
                WitchesBrew:Stop();
                WitchesBrew = SharedCycleHandlerData.WitchesBrewAndDeadTree;
                InitialiseCFrames(true);

                if u8 then
                    u8:Disconnect();
                    u8 = nil;
                end;

                u8 = u17.Touched:Connect(function(p88) -- Line: 173
                    -- upvalues: Players (ref), u15 (ref), u3 (ref), u12 (ref), TweenService (ref), TweenInfo_new_ret (ref), u16 (ref), u5 (ref), u18 (ref), u7 (ref)
                    local v89 = p88:FindFirstAncestorOfClass("Model");
                    local v90;

                    if v89 then
                        local PlayerFromCharacter = Players:GetPlayerFromCharacter(v89);

                        if PlayerFromCharacter and PlayerFromCharacter == Players.LocalPlayer then
                            v90 = v89:FindFirstChildWhichIsA("Humanoid") and true or false;
                        else
                            v90 = false;
                        end;
                    else
                        v90 = false;
                    end;

                    if not v90 then
                        return;
                    end;

                    local v91 = u15;
                    local v92 = {
                        Transparency = 0.5,
                        CFrame = u3
                    };

                    if u12[v91] then
                        u12[v91]:Cancel();
                    end;

                    local v93 = TweenService:Create(v91, TweenInfo_new_ret, v92);
                    u12[v91] = v93;
                    v93:Play();
                    local u94 = u16;
                    local v95 = {
                        Transparency = 0.5,
                        CFrame = u5
                    };

                    if u12[u94] then
                        u12[u94]:Cancel();
                    end;

                    local u96 = TweenService:Create(u94, TweenInfo_new_ret, v95);
                    u12[u94] = u96;
                    task.delay(0.5, function() -- Line: 77
                        -- upvalues: u12 (ref), u94 (copy), u96 (copy)
                        if u12[u94] == u96 then
                            u96:Play();
                        end;
                    end);
                    local u97 = u18;
                    local v98 = {
                        Transparency = 0.5,
                        CFrame = u7
                    };

                    if u12[u97] then
                        u12[u97]:Cancel();
                    end;

                    local u99 = TweenService:Create(u97, TweenInfo_new_ret, v98);
                    u12[u97] = u99;
                    task.delay(0.6, function() -- Line: 77
                        -- upvalues: u12 (ref), u97 (copy), u99 (copy)
                        if u12[u97] == u99 then
                            u99:Play();
                        end;
                    end);
                end);

                if u9 then
                    u9:Disconnect();
                    u9 = nil;
                end;

                u9 = u17.TouchEnded:Connect(function(p100) -- Line: 188
                    -- upvalues: Players (ref), u18 (ref), u6 (ref), u12 (ref), TweenService (ref), TweenInfo_new_ret (ref), u16 (ref), u4 (ref), u15 (ref), u2 (ref)
                    local v101 = p100:FindFirstAncestorOfClass("Model");
                    local v102;

                    if v101 then
                        local PlayerFromCharacter = Players:GetPlayerFromCharacter(v101);

                        if PlayerFromCharacter and PlayerFromCharacter == Players.LocalPlayer then
                            v102 = v101:FindFirstChildWhichIsA("Humanoid") and true or false;
                        else
                            v102 = false;
                        end;
                    else
                        v102 = false;
                    end;

                    if not v102 then
                        return;
                    end;

                    local v103 = u18;
                    local v104 = {
                        Transparency = 1,
                        CFrame = u6
                    };

                    if u12[v103] then
                        u12[v103]:Cancel();
                    end;

                    local v105 = TweenService:Create(v103, TweenInfo_new_ret, v104);
                    u12[v103] = v105;
                    v105:Play();
                    local u106 = u16;
                    local v107 = {
                        Transparency = 1,
                        CFrame = u4
                    };

                    if u12[u106] then
                        u12[u106]:Cancel();
                    end;

                    local u108 = TweenService:Create(u106, TweenInfo_new_ret, v107);
                    u12[u106] = u108;
                    task.delay(0.1, function() -- Line: 77
                        -- upvalues: u12 (ref), u106 (copy), u108 (copy)
                        if u12[u106] == u108 then
                            u108:Play();
                        end;
                    end);
                    local u109 = u15;
                    local v110 = {
                        Transparency = 1,
                        CFrame = u2
                    };

                    if u12[u109] then
                        u12[u109]:Cancel();
                    end;

                    local u111 = TweenService:Create(u109, TweenInfo_new_ret, v110);
                    u12[u109] = u111;
                    task.delay(0.35, function() -- Line: 77
                        -- upvalues: u12 (ref), u109 (copy), u111 (copy)
                        if u12[u109] == u111 then
                            u111:Play();
                        end;
                    end);
                end);
                u15.CFrame = u2;
                u16.CFrame = u4;
                u18.CFrame = u6;
                BuildLeaderboard(u10);
            end;

            if not WitchesBrew:IsRunning() then
                WitchesBrew:Start();
            end;

            UpdateWitchesBrewInstances();
        end;

        u1:Add(EventRotationController.EventUpdated:Connect(function(p112, p113) -- Line: 251
            -- upvalues: CheckCombinedSwitch (copy)
            if p113 ~= "HalloweenEvent" then
                return;
            end;

            CheckCombinedSwitch(p112, p113);
        end));
        local LoadedEvent = EventRotationController:GetLoadedEvent();

        if LoadedEvent then
            CheckCombinedSwitch(LoadedEvent.EventID, LoadedEvent.EventSet);
        end;
    end,

    OnStop = function() -- Line: 261, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u11;