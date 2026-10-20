-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local NPCDialogueController = require(ReplicatedStorage.Modules.NPCDialogueController);
local EventShopUIController = require(ReplicatedStorage.Modules.EventShopUIController);
local script_Parent = script.Parent;
local Parent = script_Parent.Parent.Parent;
task.spawn(function() -- Line: 9
    -- upvalues: EventShopUIController (copy)
    EventShopUIController:Prewarm("Honey Coin Shop");
end);
NPCDialogueController:Start({
    ExitLine = "I\'ll bee seeing you!",
    DeactivationDistance = 20,
    ProximityPrompt = script_Parent,
    SpeakingNPC = Parent,
    PromptList = {},
    OperationMap = {},
    IntroLines = { "Dont bee shy! Why not buzz by and check out the honey coin shop?" },
    RootPart = script_Parent.Parent,

    OnDialogueStarted = function() -- Line: 26, Name: OnDialogueStarted
        -- upvalues: EventShopUIController (copy)
        task.delay(0.8, function() -- Line: 27
            -- upvalues: EventShopUIController (ref)
            EventShopUIController:Open("Honey Coin Shop");
        end);
    end,

    OnDialogueEnded = function() -- Line: 31, Name: OnDialogueEnded
    end
});