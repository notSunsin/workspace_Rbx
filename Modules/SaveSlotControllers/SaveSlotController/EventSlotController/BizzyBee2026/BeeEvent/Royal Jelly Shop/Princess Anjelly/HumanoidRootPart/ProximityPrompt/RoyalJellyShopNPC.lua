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
    ExitLine = "Tis\' a pleasure!",
    DeactivationDistance = 20,
    ProximityPrompt = script_Parent,
    SpeakingNPC = Parent,
    PromptList = {},
    OperationMap = {},
    IntroLines = { "Have a look at my Royal Jelly wares!" },
    RootPart = script_Parent.Parent,

    OnDialogueStarted = function() -- Line: 26, Name: OnDialogueStarted
        -- upvalues: EventShopUIController (copy)
        task.delay(0.8, function() -- Line: 27
            -- upvalues: EventShopUIController (ref)
            EventShopUIController:Open("Royal Jelly Shop");
        end);
    end,

    OnDialogueEnded = function() -- Line: 31, Name: OnDialogueEnded
    end
});