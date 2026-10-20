-- Decompiled with Potassium's decompiler.

local u1 = {
    RidingPet = nil,
    LastWeld = nil
};
game:GetService("RunService");
game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local Character = LocalPlayer.Character;
local u2 = nil;

local function OnCharacterAdded(p3) -- Line: 19
    -- upvalues: Character (ref), u2 (ref)
    if not p3 then
        return;
    end;

    Character = p3;
    u2 = p3:WaitForChild("Humanoid");
end;

local Character2 = LocalPlayer.Character;

if Character2 then
    Character = Character2;
    u2 = Character2:WaitForChild("Humanoid");
end;

LocalPlayer.CharacterAdded:Connect(function(p4) -- Line: 26
    -- upvalues: Character (ref), u2 (ref)
    if not p4 then
        return;
    end;

    Character = p4;
    u2 = p4:WaitForChild("Humanoid");
end);
local ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService);

local function WeldTogether(p5: userdata, p6: userdata) -- Line: 32
    local ManualWeld = Instance.new("ManualWeld");
    ManualWeld.Part0 = p5;
    ManualWeld.Part1 = p6;
    ManualWeld.Name = "Weld";
    ManualWeld.Parent = p6;

    return ManualWeld;
end;

function u1.RidePet(p7: table, p8: string) -- Line: 42
    -- upvalues: ActivePetsService (copy), LocalPlayer (copy), u1 (copy), u2 (ref), Character (ref)
    local ClientPetStateUUID = ActivePetsService:GetClientPetStateUUID(LocalPlayer.Name, p8);

    if not ClientPetStateUUID then
        return;
    end;

    local Model = ClientPetStateUUID.Model;

    if not Model then
        u1:Unride();

        return;
    end;

    u1.RidingPet = p8;
    u2.Sit = true;
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
    local PrimaryPart = Model.PrimaryPart;
    local ManualWeld = Instance.new("ManualWeld");
    ManualWeld.Part0 = HumanoidRootPart;
    ManualWeld.Part1 = PrimaryPart;
    ManualWeld.Name = "Weld";
    ManualWeld.Parent = PrimaryPart;
    ManualWeld.C0 = ManualWeld.C0 * CFrame.new(0, -Model:GetExtentsSize().Y / 2, 0);
    u1.LastWeld = ManualWeld;
end;

function u1.Unride(p9) -- Line: 55
    -- upvalues: u1 (copy), u2 (ref)
    local LastWeld = u1.LastWeld;
    u1.RidingPet = nil;
    u2.Jump = true;

    if LastWeld then
        LastWeld:Destroy();
    end;

    u1.LastWeld = nil;
end;

UserInputService.JumpRequest:Connect(function() -- Line: 68
    -- upvalues: u1 (copy)
    u1:Unride();
end);

return u1;