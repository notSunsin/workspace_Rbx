-- Decompiled with Potassium's decompiler.

local ExperienceNotificationService = game:GetService("ExperienceNotificationService");
local Players = game:GetService("Players");
game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ExperienceNotificationServicePrompterController = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("ExperienceNotificationServicePrompterController");
local ExperienceNotifications = Players.LocalPlayer.PlayerGui:WaitForChild("ExperienceNotifications");
local WaitForDescendant = require(ReplicatedStorage.Modules.WaitForDescendant);
local SetupHoverAnimations = require(ReplicatedStorage.Modules.SetupHoverAnimations);
local SetupSounds = require(ReplicatedStorage.Modules.SetupSounds);
local u1 = {
    CanPromptOptIn = false
};

local function CanPromptOptIn() -- Line: 23
    -- upvalues: ExperienceNotificationService (copy)
    local success, result = pcall(function() -- Line: 24
        -- upvalues: ExperienceNotificationService (ref)
        return ExperienceNotificationService:CanPromptOptInAsync();
    end);

    if success then
        return result;
    end;

    return false;
end;

local success, result = pcall(function() -- Line: 24
    -- upvalues: ExperienceNotificationService (copy)
    return ExperienceNotificationService:CanPromptOptInAsync();
end);

if not success then
    result = false;
end;

u1.CanPromptOptIn = result;

function u1.CreatePrompt(p2) -- Line: 37
    -- upvalues: u1 (copy), ExperienceNotifications (copy), WaitForDescendant (copy), SetupHoverAnimations (copy), SetupSounds (copy), TweenService (copy), ExperienceNotificationService (copy)
    if not u1.CanPromptOptIn then
        return warn("Cannot prompt notification because not eligiblE!");
    end;

    local InsertionPoint = ExperienceNotifications:FindFirstChild("InsertionPoint");

    if not InsertionPoint then
        return;
    end;

    local u3 = InsertionPoint.ExperienceNotificationTemplate:Clone();
    local UIScale = u3.UIScale;
    UIScale.Scale = 0;
    local v4 = WaitForDescendant(u3, "ACCEPT_BUTTON");
    local v5 = WaitForDescendant(u3, "DECLINE_BUTTON");
    SetupHoverAnimations(v4);
    SetupHoverAnimations(v5);
    local v6 = SetupSounds(v5);

    local function Remove() -- Line: 57
        -- upvalues: TweenService (ref), UIScale (copy), u3 (copy)
        local v7 = TweenService:Create(UIScale, TweenInfo.new(0.2), {
            Scale = 0
        });
        v7:Play();
        v7.Completed:Once(function() -- Line: 63
            -- upvalues: u3 (ref)
            u3:Destroy();
        end);
    end;

    SetupSounds(v4).MouseButton1Click:Connect(function() -- Line: 68
        -- upvalues: Remove (copy), ExperienceNotificationService (ref)
        Remove();
        ExperienceNotificationService:PromptOptIn();
    end);
    v6.MouseButton1Click:Connect(function() -- Line: 73
        -- upvalues: Remove (copy)
        Remove();
    end);
    u3.Visible = true;
    u3.Parent = InsertionPoint;
    TweenService:Create(UIScale, TweenInfo.new(0.5), {
        Scale = 1
    }):Play();
end;

local u8 = { "CreatePrompt" };
ExperienceNotificationServicePrompterController.OnClientEvent:Connect(function(p9, ...) -- Line: 89
    -- upvalues: u8 (copy), u1 (copy)
    if not table.find(u8, p9) then
        return;
    end;

    local v10 = u1[p9];

    if not v10 then
        return;
    end;

    v10(u1, ...);
end);
ExperienceNotificationService.OptInPromptClosed:Connect(function() -- Line: 98
    task.wait(5);
end);

return u1;