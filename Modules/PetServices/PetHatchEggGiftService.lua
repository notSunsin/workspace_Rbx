-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
local DataService = require(ReplicatedStorage.Modules.DataService);
local PetEggService = ReplicatedStorage.GameEvents.PetEggService;
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = {};
local u3 = {};

local function CreateProximityPromptAttachment(p4: userdata, p5: userdata, p6: vector) -- Line: 25
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = p4;
    Attachment.Name = `{p5.Name}Att`;
    Attachment.CFrame = CFrame.new(p6);
    p5.Parent = Attachment;

    return Attachment;
end;

local function UpdateAttachmentHeight(p7: userdata, p8: userdata) -- Line: 38
    if not p7 then
        return;
    end;

    if not p8 then
        return;
    end;

    local Y = p7:GetExtentsSize().Y;
    p8.CFrame = CFrame.new(0, Y, 0);
end;

local function CheckEggTimer(p9: userdata) -- Line: 45
    -- upvalues: LocalPlayer (copy)
    if p9:GetAttribute("OWNER") == LocalPlayer.Name then
        return;
    end;

    local Attribute = p9:GetAttribute("TimeToHatch");
    local GiftSkipPromptAtt = p9:FindFirstChild("PetEgg"):FindFirstChild("GiftSkipPromptAtt");
    local v10 = (GiftSkipPromptAtt or p9):FindFirstChild("GiftSkipPrompt") or p9:FindFirstChild("GiftSkipPrompt", true);

    if not v10 then
        return warn((`CheckEggTimer | No Proximity Prompt found for {p9}`));
    end;

    local Attribute2 = p9:GetAttribute("ShowTime");

    if Attribute2 and Attribute2 > workspace:GetServerTimeNow() then
        v10.Enabled = false;

        return;
    end;

    if Attribute <= 15 then
        v10.Enabled = false;
    end;

    local v11 = GiftSkipPromptAtt or p9:FindFirstChild("GiftSkipPromptAtt", true);

    if not p9 then
        return;
    end;

    if not v11 then
        return;
    end;

    local Y = p9:GetExtentsSize().Y;
    v11.CFrame = CFrame.new(0, Y, 0);
end;

function u1.Initialise(p12: table, u13: userdata) -- Line: 82
    -- upvalues: LocalPlayer (copy), Players (copy), DataService (copy), u2 (copy), CheckEggTimer (copy), u3 (copy), PetEggService (copy)
    if not u13 then
        warn("PetHatchEggGiftService:Initialise() | No ServerEgg found!");

        return;
    end;

    if u13:GetAttribute("TimeToHatch") <= 10 then
        return;
    end;

    local Attribute = u13:GetAttribute("OWNER");

    if Attribute == LocalPlayer.Name then
        return;
    end;

    local u14 = Players:FindFirstChild(Attribute);

    if not u14 then
        warn((`PetHatchEggGiftService:Initialise() | Couldn't find Player Instance for {Attribute}`));

        return;
    end;

    if not DataService:GetData() then
        return;
    end;

    u13:GetAttribute("OBJECT_UUID");
    u2[u13] = u13:GetAttributeChangedSignal("TimeToHatch"):Connect(function() -- Line: 108
        -- upvalues: CheckEggTimer (ref), u13 (copy)
        CheckEggTimer(u13);
    end);
    local v15 = u13:WaitForChild("PetEgg", 10) or u13;
    local ProximityPrompt = Instance.new("ProximityPrompt");
    ProximityPrompt.ActionText = "[GIFT] Skip Hatch Time";
    ProximityPrompt.Name = "GiftSkipPrompt";
    ProximityPrompt.HoldDuration = 1;
    ProximityPrompt.Enabled = false;
    ProximityPrompt.Parent = v15;
    ProximityPrompt.RequiresLineOfSight = false;
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
    ProximityPrompt:SetAttribute("Theme", "ShadowedPrompt");
    u3[u13] = ProximityPrompt.Triggered:Connect(function() -- Line: 126
        -- upvalues: PetEggService (ref), u13 (copy), u14 (copy)
        PetEggService:FireServer("AuthoriseGiftHatchPurchase", u13, u14);
    end);
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = v15;
    Attachment.Name = `{ProximityPrompt.Name}Att`;
    Attachment.CFrame = CFrame.new(Vector3.new(0, 0, 0));
    ProximityPrompt.Parent = Attachment;

    if u13:GetAttribute("TimeToHatch") > 10 then
        ProximityPrompt.Enabled = true;
    end;

    if not u13 then
        return;
    end;

    if not Attachment then
        return;
    end;

    local Y = u13:GetExtentsSize().Y;
    Attachment.CFrame = CFrame.new(0, Y, 0);
end;

CreateTagHandler({
    Tag = "PetEggServer",

    OnInstanceAdded = function(p16: userdata) -- Line: 142, Name: OnInstanceAdded
        -- upvalues: u1 (copy)
        if not p16:IsDescendantOf(workspace) then
            return;
        end;

        u1:Initialise(p16);
    end,

    OnInstanceRemoved = function(p17) -- Line: 146, Name: OnInstanceRemoved
        -- upvalues: u3 (copy), u2 (copy)
        if u3[p17] then
            u3[p17]:Disconnect();
            u3[p17] = nil;
        end;

        if u2[p17] then
            u2[p17]:Disconnect();
            u2[p17] = nil;
        end;
    end
});

return u1;