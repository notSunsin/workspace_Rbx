-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local v1 = {};
local ReSetupShopFrames = ReplicatedStorage.GameEvents.ABTestingEvents.ReSetupShopFrames;
local LocalPlayer = Players.LocalPlayer;

if not LocalPlayer then
    return v1;
end;

local ClientABTests = require(ReplicatedStorage.UserGenerated.Client.ClientABTests);
local u2 = {
    SunflowerInShop = false,
    ButtercupInFTUShop = nil,
    FTUPlantPool = nil,
    InTutorial = LocalPlayer:GetAttribute("InTutorial")
};

local function UpdateShopDisplays() -- Line: 31
    -- upvalues: u2 (copy), ReSetupShopFrames (copy)
    local v3 = {
        ["Orange Tulip"] = true
    };

    for i, v in require(script.Parent) do
        if not v3[i] then
            local v4 = not (u2.FTUPlantPool and u2.InTutorial) and true or ({
                Carrot = true,
                Strawberry = true,
                Blueberry = true,
                Buttercup = true,
                Tomato = true,
                Corn = true,
                Daffodil = true,
                Watermelon = true,
                Pumpkin = true,
                Apple = true,
                Bamboo = true,
                Coconut = true,
                Cactus = true,
                ["Dragon Fruit"] = true
            })[i] == true;

            if not (u2.ButtercupInFTUShop or (not u2.InTutorial or i ~= "Buttercup")) then
                v4 = false;
            end;

            v.DisplayInShop = v4;
        end;
    end;

    ReSetupShopFrames:Fire();
end;

local function Watch(u5) -- Line: 87
    -- upvalues: ClientABTests (copy), LocalPlayer (copy), u2 (copy), UpdateShopDisplays (copy)
    task.spawn(function() -- Line: 88
        -- upvalues: ClientABTests (ref), LocalPlayer (ref), u2 (ref), u5 (copy), UpdateShopDisplays (ref)
        local v6 = ClientABTests.GetAssignmentsAsync(LocalPlayer, true) and ClientABTests.GetAttributes(LocalPlayer);

        if v6 then
            u2[u5:gsub("AB_", "")] = v6[u5];
            UpdateShopDisplays();
        end;
    end);
end;

for _, v in { "AB_SunflowerInShop", "AB_ButtercupInFTUShop", "AB_FTUPlantPool" } do
    task.spawn(function() -- Line: 88
        -- upvalues: ClientABTests (copy), LocalPlayer (copy), u2 (copy), v (copy), UpdateShopDisplays (copy)
        local v7 = ClientABTests.GetAssignmentsAsync(LocalPlayer, true) and ClientABTests.GetAttributes(LocalPlayer);

        if v7 then
            u2[v:gsub("AB_", "")] = v7[v];
            UpdateShopDisplays();
        end;
    end);
end;

LocalPlayer:GetAttributeChangedSignal("InTutorial"):Connect(function() -- Line: 105
    -- upvalues: u2 (copy), LocalPlayer (copy), UpdateShopDisplays (copy)
    u2.InTutorial = LocalPlayer:GetAttribute("InTutorial");
    UpdateShopDisplays();
end);

return v1;