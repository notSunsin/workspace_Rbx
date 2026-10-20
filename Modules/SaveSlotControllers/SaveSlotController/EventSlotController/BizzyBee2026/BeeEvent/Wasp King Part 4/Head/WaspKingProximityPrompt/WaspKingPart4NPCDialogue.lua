-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
require(ReplicatedStorage.Modules.BeeEventV2Controllers.WaspEventOddsController);
local NPCDialogueController = require(ReplicatedStorage.Modules.NPCDialogueController);
local Top_Text = require(ReplicatedStorage.Top_Text);
local script_Parent = script.Parent;
local Parent = script_Parent.Parent.Parent;
local v1 = { "Who are you?", "What is this portal behind you?", "What are Bee Enchantments?", "Goodbye" };
NPCDialogueController:Start({
    ExitLine = "Prepare your colony for battle.",
    DeactivationDistance = 20,
    ProximityPrompt = script_Parent,
    SpeakingNPC = Parent,
    PromptList = v1,
    OperationMap = {
        [v1[1]] = function() -- Line: 25
            -- upvalues: Top_Text (copy), Parent (copy)
            Top_Text.NpcText(Parent, "I am the Wasp King!", true);
            task.wait(1.6);
            Top_Text.NpcText(Parent, "Not all wasps are your enemy.", true);
            task.wait(1.8);
            Top_Text.NpcText(Parent, "The invading swarm betrayed my kingdom.", true);
            task.wait(2);
            Top_Text.NpcText(Parent, "Now they attack bees and wasps alike.", true);
            task.wait(2);
            Top_Text.NpcText(Parent, "Help me stop them!", true);
            task.wait(1.6);
        end,

        [v1[2]] = function() -- Line: 79
            -- upvalues: Top_Text (copy), Parent (copy)
            Top_Text.NpcText(Parent, "We are ready to launch an attack on the evil wasp dungeon!", true);
            task.wait(2.5);
            Top_Text.NpcText(Parent, "Bring your strongest bees through the portal.", true);
            task.wait(2);
            Top_Text.NpcText(Parent, "Defeat up to 100 waves of wasps.", true);
            task.wait(2);
            Top_Text.NpcText(Parent, "The farther you go, the greater your rewards.", true);
            task.wait(2.2);
            Top_Text.NpcText(Parent, "Clear the final wave to claim the ultimate reward!", true);
            task.wait(2.3);
            Top_Text.NpcText(Parent, "Free the bees and good wasps from the evil wasp threat!", true);
            task.wait(2.5);
        end,

        [v1[3]] = function() -- Line: 99
            -- upvalues: Top_Text (copy), Parent (copy)
            Top_Text.NpcText(Parent, "Bee Enchantments give your Bees more power!", true);
            task.wait(2.5);
            Top_Text.NpcText(Parent, "Give them to your Bees while they are Nesting.", true);
            task.wait(2.5);
            Top_Text.NpcText(Parent, "You can swap enchantments on Bees.", true);
            task.wait(2.5);
        end,

        [v1[4]] = function() -- Line: 110
            task.wait(0.3);
        end
    },
    IntroLines = { "The swarm grows restless..." },
    RootPart = script_Parent.Parent,

    OnDialogueStarted = function() -- Line: 124, Name: OnDialogueStarted
    end,

    OnDialogueEnded = function() -- Line: 126, Name: OnDialogueEnded
    end
});