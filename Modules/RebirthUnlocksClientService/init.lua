-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local DataService = require(game.ReplicatedStorage.Modules.DataService);
require(game.ReplicatedStorage.UserGenerated.Client.ClientABTests);
local RebirthConfigData = require(game.ReplicatedStorage.Data.RebirthConfigData);
local RebirthUnlocksSharedService = require(game.ReplicatedStorage.Modules.RebirthUnlocksSharedService);
local script_RebirthLockTemplate = script.RebirthLockTemplate;
local NPCS = workspace:WaitForChild("NPCS", 30);
local Visuals = workspace:WaitForChild("Visuals", 30);
local Isaac = NPCS:WaitForChild("Isaac", 30);
local Eloise = NPCS:WaitForChild("Eloise", 30);
local PetMutationMachine = NPCS:WaitForChild("PetMutationMachine", 30);
local v1 = NPCS:WaitForChild("Pet Stand", 30);
local CraftingTables = workspace:WaitForChild("CraftingTables", 30);

if not CraftingTables then
    return {};
end;

local SeedEventCraftingWorkBench = CraftingTables:WaitForChild("SeedEventCraftingWorkBench", 30);
local LocalPlayer = Players.LocalPlayer;
local u2 = {};
local u3 = {
    ["Pet Stand"] = {
        Padding = Vector3.new(1, 0, 2),
        PositionalOffset = Vector3.new(0, 0, 0),
        RotationalOffset = Vector3.new(0, 0, 0),
        Model = v1,
        UnlockRequirement = RebirthConfigData.REBIRTH_UNLOCKS.PET_STAND
    },
    ["Gear Stand"] = {
        Padding = Vector3.new(1, 2.5, 1),
        PositionalOffset = Vector3.new(0, 1.5, 0),
        RotationalOffset = Vector3.new(0, 3.1415927, 0),
        Model = Eloise,
        UnlockRequirement = RebirthConfigData.REBIRTH_UNLOCKS.GEAR_STAND
    },
    ["Cosmetic Stand"] = {
        Padding = Vector3.new(1, 2.5, 1),
        PositionalOffset = Vector3.new(0, 1.5, 0),
        RotationalOffset = Vector3.new(0, 3.1415927, 0),
        Model = Isaac,
        UnlockRequirement = RebirthConfigData.REBIRTH_UNLOCKS.COSMETIC_STAND
    },
    ["Pet Mutation Machine"] = {
        Padding = Vector3.new(1.5, 1, 1.5),
        PositionalOffset = Vector3.new(0, 0, 0),
        RotationalOffset = Vector3.new(0, 0, 0),
        Model = PetMutationMachine,
        UnlockRequirement = RebirthConfigData.REBIRTH_UNLOCKS.PET_MUTATION_MACHINE
    },
    ["Seed Crafting Bench"] = {
        Padding = Vector3.new(0.95, 0, 0.95),
        PositionalOffset = Vector3.new(0, 0, 0),
        RotationalOffset = Vector3.new(0, 3.1415927, 0),
        Model = SeedEventCraftingWorkBench,
        UnlockRequirement = RebirthConfigData.REBIRTH_UNLOCKS.CRAFTING
    },
    ["Event Crafting Bench"] = {
        Padding = Vector3.new(1, 1, 1),
        PositionalOffset = Vector3.new(0, 0.4, 0),
        RotationalOffset = Vector3.new(0, 3.1415927, 0),
        Model = CraftingTables:WaitForChild("EventCraftingWorkBench", 30),
        UnlockRequirement = RebirthConfigData.REBIRTH_UNLOCKS.CRAFTING
    }
};

local function CreateBoxAroundStand(p4: userdata, p5: vector, p6: vector, p7: vector, p8: number) -- Line: 96
    -- upvalues: script_RebirthLockTemplate (copy), Visuals (copy)
    if not p4 then
        return nil;
    end;

    local ExtentsSize = p4:GetExtentsSize();
    local BoundingBox, _ = p4:GetBoundingBox();
    local v9 = script_RebirthLockTemplate:Clone();
    v9.Parent = Visuals;
    v9.Size = ExtentsSize + p5;
    v9:PivotTo(BoundingBox * CFrame.new(p6) * CFrame.Angles(p7.X, p7.Y, p7.Z));
    v9:FindFirstChild("SurfaceGui"):FindFirstChild("Container"):FindFirstChild("RequirementText").Text = `Ascensions Required: {p8}`;

    return v9;
end;

local function UpdateRequirementText(p10: userdata, p11: number) -- Line: 117
    p10:FindFirstChild("SurfaceGui"):FindFirstChild("Container"):FindFirstChild("RequirementText").Text = `Ascensions Required: {p11}`;
end;

task.delay(3, function() -- Line: 126, Name: Setup
    -- upvalues: RebirthUnlocksSharedService (copy), LocalPlayer (copy), DataService (copy), u3 (copy), CreateBoxAroundStand (copy), u2 (copy)
    if not RebirthUnlocksSharedService:HasBeenAssignedABTest(LocalPlayer) then
        return;
    end;

    local Data = DataService:GetData();

    if not Data then
        warn("RebirthUnlocksClientService | Unable to retrieve PlayerData!");

        return;
    end;

    for i, v in u3 do
        if Data.RebirthData.TotalRebirths < v.UnlockRequirement then
            u2[i] = CreateBoxAroundStand(v.Model, v.Padding, v.PositionalOffset, v.RotationalOffset, v.UnlockRequirement - Data.RebirthData.TotalRebirths);
        end;
    end;

    local u12 = nil;
    u12 = DataService:GetPathSignal("RebirthData/TotalRebirths"):Connect(function() -- Line: 151
        -- upvalues: u3 (ref), u2 (ref), Data (copy), u12 (ref)
        local v13 = true;

        for i, v in u3 do
            local v14 = u2[i];

            if Data.RebirthData.TotalRebirths < v.UnlockRequirement then
                v13 = false;

                if v14 then
                    local v15 = v.UnlockRequirement - Data.RebirthData.TotalRebirths;
                    v14:FindFirstChild("SurfaceGui"):FindFirstChild("Container"):FindFirstChild("RequirementText").Text = `Ascensions Required: {v15}`;
                end;
            elseif v14 then
                v14:Destroy();
                u2[i] = nil;
            end;
        end;

        if u12 and v13 then
            u12:Disconnect();
            u12 = nil;
        end;
    end);
end);

return {};