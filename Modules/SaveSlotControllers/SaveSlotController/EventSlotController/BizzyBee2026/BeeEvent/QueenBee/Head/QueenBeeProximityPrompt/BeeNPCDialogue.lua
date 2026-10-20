-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local NPCDialogueController = require(ReplicatedStorage.Modules.NPCDialogueController);
local Top_Text = require(ReplicatedStorage.Top_Text);
local TeamEventQuestsUIController = require(ReplicatedStorage.Modules.TeamEventControllers.UserInterface.TeamEventQuestsUIController);
local script_Parent = script.Parent;
local Parent = script_Parent.Parent.Parent;
local v1 = { "Where can I get Honey Coins?", "View Quests", "Goodbye" };
NPCDialogueController:Start({
    ExitLine = "Fly back soon.",
    DeactivationDistance = 20,
    ProximityPrompt = script_Parent,
    SpeakingNPC = Parent,
    PromptList = v1,
    OperationMap = {
        [v1[1]] = function() -- Line: 17
            -- upvalues: Top_Text (copy), Parent (copy)
            Top_Text.NpcText(Parent, "Pollinate your plants first.", true);
            task.wait(2.7);
            Top_Text.NpcText(Parent, "Convert them into Honey Coins at the compressor.", true);
            task.wait(3.4);
            Top_Text.NpcText(Parent, "Use Honey Coins for shop rewards.", true);
            task.wait(2.8);
            Top_Text.NpcText(Parent, "Or spend them in the upgrade tree.", true);
            task.wait(3);
        end,

        [v1[2]] = function() -- Line: 31
            -- upvalues: TeamEventQuestsUIController (copy)
            TeamEventQuestsUIController:Toggle(true);
        end,

        [v1[3]] = function() -- Line: 35
            task.wait(0.3);
        end
    },
    IntroLines = { "Welcome, little buzzer." },
    RootPart = script_Parent.Parent,

    OnDialogueStarted = function() -- Line: 51, Name: OnDialogueStarted
    end,

    OnDialogueEnded = function() -- Line: 53, Name: OnDialogueEnded
    end
});