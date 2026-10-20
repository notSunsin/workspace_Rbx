-- Decompiled with Potassium's decompiler.

local Assets = game:GetService("ReplicatedStorage"):WaitForChild("Assets");
Assets:WaitForChild("Models");
Assets:WaitForChild("Animations"):WaitForChild("PetAnimations");
local PetConfig = require(script:WaitForChild("PetConfig"));
local DefaultPetNames = require(script:WaitForChild("DefaultPetNames"));
local PetStatesRegistry = require(script:WaitForChild("PetStatesRegistry"));
local PetRarities = require(script:WaitForChild("PetRarities"));
local DefaultPetActions = require(script:WaitForChild("DefaultPetActions"));
local DefaultPetStates = require(script:WaitForChild("DefaultPetStates"));

return {
    PetStatesRegistry = PetStatesRegistry,
    PetList = require(script:WaitForChild("PetList")),
    PetConfig = PetConfig,
    PassiveRegistry = require(script:WaitForChild("PassiveRegistry")),
    PetEggs = require(script:WaitForChild("PetEggs")),
    DefaultPetActions = DefaultPetActions,
    DefaultPetStates = DefaultPetStates,
    DefaultPetNames = DefaultPetNames,
    PetRarities = PetRarities,
    PetMutationRegistry = require(script:WaitForChild("PetMutationRegistry")),
    PetBoostRegistry = require(script:WaitForChild("PetBoostRegistry")),
    EggSkipProducts = require(script:WaitForChild("EggSkipProducts"))
};