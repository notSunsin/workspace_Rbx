-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local Top_Text = require(game.ReplicatedStorage.Top_Text);
local NPC_MOD = require(game.ReplicatedStorage.NPC_MOD);
local UpdateService = require(game.ReplicatedStorage.Modules.UpdateService);
local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local v1 = {};
local u2 = false;

local function AreChoicesAlive(p3: table) -- Line: 65
    for _, v in p3 do
        if v.Parent then
            return true;
        end;
    end;

    return false;
end;

function v1.Start(p4: table, u5: table) -- Line: 74
    -- upvalues: Top_Text (copy), NPC_MOD (copy), u2 (ref), UpdateService (copy), TweenService (copy), TweenInfo_new_ret (copy)
    local ProximityPrompt = u5.ProximityPrompt;
    local SpeakingNPC = u5.SpeakingNPC;
    local PromptList = u5.PromptList;
    local OperationMap = u5.OperationMap;
    local IntroLines = u5.IntroLines;
    local LocalPlayer = game.Players.LocalPlayer;
    local u6 = u5.RootPart or (SpeakingNPC:FindFirstChild("HumanoidRootPart") or SpeakingNPC);
    local DialogueHighlight = SpeakingNPC:FindFirstChild("DialogueHighlight");

    if not DialogueHighlight then
        DialogueHighlight = Instance.new("Highlight");

        if DialogueHighlight and DialogueHighlight:IsA("Highlight") then
            DialogueHighlight.Name = "DialogueHighlight";
            DialogueHighlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            DialogueHighlight.FillTransparency = 1;
            DialogueHighlight.OutlineTransparency = 1;
            DialogueHighlight.Adornee = SpeakingNPC;
            DialogueHighlight.Parent = SpeakingNPC;
        end;
    end;

    local u7 = false;
    local u8 = false;
    local u9 = nil;
    local u10 = {};

    local function IsDialogueEnabled() -- Line: 111
        -- upvalues: SpeakingNPC (copy)
        if SpeakingNPC.Parent then
            return not SpeakingNPC:GetAttribute("DisableDialogue");
        end;

        return false;
    end;

    local function EndConversation(p11: table) -- Line: 118
        -- upvalues: u7 (ref), u9 (ref), u10 (copy), Top_Text (ref), SpeakingNPC (copy), LocalPlayer (copy), NPC_MOD (ref), u8 (ref), u2 (ref), ProximityPrompt (copy)
        if not u7 then
            return;
        end;

        if u9 then
            task.cancel(u9);
        end;

        for _, v in u10 do
            v:Disconnect();
        end;

        table.clear(u10);
        Top_Text.TakeAwayResponses(SpeakingNPC, LocalPlayer);
        Top_Text.RemovePlayerSideFrame(LocalPlayer);
        NPC_MOD.End_Speak(LocalPlayer);

        if p11.OnDialogueEnded then
            p11.OnDialogueEnded();
        end;

        u8 = false;
        u7 = false;

        if SpeakingNPC.Parent then
            SpeakingNPC:SetAttribute("ConversationStarted", false);
        end;

        u2 = false;
        task.wait(0.5);

        if ProximityPrompt.Parent then
            local v12;

            if SpeakingNPC.Parent then
                v12 = not SpeakingNPC:GetAttribute("DisableDialogue");
            else
                v12 = false;
            end;

            ProximityPrompt.Enabled = v12;
        end;
    end;

    local function StartConversation(p13: table) -- Line: 151
        -- upvalues: u2 (ref), u7 (ref), SpeakingNPC (copy), NPC_MOD (ref), LocalPlayer (copy), u8 (ref), ProximityPrompt (copy), IntroLines (copy), Top_Text (ref), EndConversation (copy), PromptList (copy), u10 (copy), OperationMap (copy), u9 (ref)
        if u2 then
            return;
        end;

        if u7 then
            return;
        end;

        local v14;

        if SpeakingNPC.Parent then
            v14 = not SpeakingNPC:GetAttribute("DisableDialogue");
        else
            v14 = false;
        end;

        if not v14 then
            return;
        end;

        u7 = true;
        SpeakingNPC:SetAttribute("ConversationStarted", true);
        u2 = true;
        NPC_MOD.Start_Speak(LocalPlayer);
        u8 = false;
        ProximityPrompt.Enabled = false;

        if p13.OnDialogueStarted then
            p13.OnDialogueStarted();
        end;

        if IntroLines then
            if p13.RandomIntroLine then
                local Random_new_ret = Random.new();
                Top_Text.NpcText(SpeakingNPC, IntroLines[Random_new_ret:NextInteger(1, #IntroLines)], true);
                task.wait(0.5);
            else
                for _, v in IntroLines do
                    if not u7 or u8 then
                        break;
                    end;

                    Top_Text.NpcText(SpeakingNPC, v, true);
                    task.wait(0.5);
                end;
            end;
        end;

        if not u7 or u8 then
            EndConversation(p13);

            return;
        end;

        if #PromptList > 0 then
            Top_Text.TakeAwayResponses(SpeakingNPC, LocalPlayer);
            local v15 = Top_Text.ShowChoices(LocalPlayer, PromptList);
            local u16 = "";

            if not u7 or u8 then
                EndConversation(p13);

                return;
            end;

            table.clear(u10);

            for _, v in v15 do
                local Frame = v:FindFirstChild("Frame");

                if Frame then
                    local ImageButton = Frame:FindFirstChild("ImageButton");

                    if ImageButton then
                        table.insert(u10, ImageButton.Activated:Connect(function() -- Line: 214
                            -- upvalues: u16 (ref), Frame (copy)
                            u16 = Frame.Frame.Text_Element:GetAttribute("Text");
                        end));
                    end;
                end;
            end;

            if not u7 or u8 then
                EndConversation(p13);

                return;
            end;

            while u16 == "" do
                task.wait();

                if u8 or not u7 then
                    for i, v in u10 do
                        v:Disconnect();
                    end;

                    return EndConversation(p13);
                end;

                local v17 = false;

                for _, v in v15 do
                    if v.Parent then
                        v17 = true;
                        break;
                    end;
                end;

                if not v17 then
                    for i, v in u10 do
                        v:Disconnect();
                    end;

                    return EndConversation(p13);
                end;
            end;

            for _, v in u10 do
                v:Disconnect();
            end;

            Top_Text.RemovePlayerSideFrame(LocalPlayer);

            if LocalPlayer.Character then
                Top_Text.PlayerResponse(LocalPlayer.Character, u16, true);
                local v18 = OperationMap[u16];

                if v18 then
                    u9 = task.spawn(v18);

                    repeat
                        task.wait();
                    until coroutine.status(u9) == "dead";
                end;
            end;
        end;

        EndConversation(p13);
    end;

    local u20 = ProximityPrompt.Triggered:Connect(function(p19: userdata) -- Line: 248
        -- upvalues: StartConversation (copy), u5 (copy)
        StartConversation(u5);
    end);
    local u21 = (u5.DeactivationDistance or ProximityPrompt.MaxActivationDistance) + 1;

    local function OnNPCRemoved() -- Line: 255
        -- upvalues: u7 (ref), u8 (ref), EndConversation (copy), u5 (copy)
        if u7 then
            u8 = true;
            EndConversation(u5);
        end;
    end;

    local u22 = SpeakingNPC.Destroying:Connect(OnNPCRemoved);
    local u23 = UpdateService.OnUpdated:Connect(OnNPCRemoved);
    local task_spawn_ret = task.spawn(function() -- Line: 265
        -- upvalues: SpeakingNPC (copy), u7 (ref), EndConversation (copy), u5 (copy), LocalPlayer (copy), u6 (copy), u21 (copy), Top_Text (ref), u22 (ref), u23 (copy)
        local v24 = false;

        while SpeakingNPC.Parent do
            task.wait(0.1);

            if not v24 and u7 then
                local v25;

                if SpeakingNPC.Parent then
                    v25 = not SpeakingNPC:GetAttribute("DisableDialogue");
                else
                    v25 = false;
                end;

                if v25 then
                    if SpeakingNPC:IsDescendantOf(workspace) then
                        if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
                            local v26 = nil;

                            if u6 and u6.Parent then
                                if u6:IsA("Part") then
                                    v26 = u6.Position;
                                elseif u6:IsA("Attachment") then
                                    v26 = u6.WorldPosition;
                                elseif u6:IsA("Model") then
                                    v26 = u6:GetPivot().Position;
                                end;
                            end;

                            if v26 and (LocalPlayer.Character.PrimaryPart.Position - v26).Magnitude >= u21 then
                                if u5.ExitLine then
                                    if u5.RandomExitLine and typeof(u5.ExitLine) == "table" then
                                        local Random_new_ret = Random.new();
                                        Top_Text.NpcText(SpeakingNPC, u5.ExitLine[Random_new_ret:NextInteger(1, #u5.ExitLine)], true);
                                        v24 = false;
                                    else
                                        Top_Text.NpcText(SpeakingNPC, u5.ExitLine, true);
                                        v24 = false;
                                    end;
                                end;

                                EndConversation(u5);
                            end;
                        end;
                    else
                        EndConversation(u5);
                    end;
                else
                    EndConversation(u5);
                end;
            end;
        end;

        if u22 then
            u22:Disconnect();
        end;

        if u23 then
            u23:Disconnect();
        end;
    end);
    local u28 = ProximityPrompt.PromptShown:Connect(function() -- Line: 324
        -- upvalues: SpeakingNPC (copy), TweenService (ref), DialogueHighlight (ref), TweenInfo_new_ret (ref)
        local v27;

        if SpeakingNPC.Parent then
            v27 = not SpeakingNPC:GetAttribute("DisableDialogue");
        else
            v27 = false;
        end;

        if not v27 then
            return;
        end;

        TweenService:Create(DialogueHighlight, TweenInfo_new_ret, {
            OutlineTransparency = 0
        }):Play();
    end);
    local u29 = ProximityPrompt.PromptHidden:Connect(function() -- Line: 331
        -- upvalues: TweenService (ref), DialogueHighlight (ref), TweenInfo_new_ret (ref)
        TweenService:Create(DialogueHighlight, TweenInfo_new_ret, {
            OutlineTransparency = 1
        }):Play();
    end);

    return {
        End = function(p30: table) -- Line: 338, Name: End
            -- upvalues: u7 (ref), u8 (ref), EndConversation (copy), u5 (copy)
            if u7 then
                u8 = true;
                EndConversation(u5);
            end;
        end,

        Destroy = function(p31: table) -- Line: 346, Name: Destroy
            -- upvalues: u7 (ref), u8 (ref), EndConversation (copy), u5 (copy), u22 (ref), u23 (copy), task_spawn_ret (ref), u28 (ref), u29 (ref), u20 (ref)
            if u7 then
                u8 = true;
                EndConversation(u5);
            end;

            if u22 then
                u22:Disconnect();
                u22 = nil;
            end;

            if u23 then
                u23:Disconnect();
            end;

            if task_spawn_ret then
                task.cancel(task_spawn_ret);
                task_spawn_ret = nil;
            end;

            if u28 then
                u28:Disconnect();
                u28 = nil;
            end;

            if u29 then
                u29:Disconnect();
                u29 = nil;
            end;

            if u20 then
                u20:Disconnect();
                u20 = nil;
            end;
        end,

        IsActive = function(p32: table) -- Line: 378, Name: IsActive
            -- upvalues: u7 (ref)
            return u7;
        end
    };
end;

return v1;