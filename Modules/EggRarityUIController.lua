-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.GetFarm);
local EggRarityDisplay_UI = Players.LocalPlayer.PlayerGui:WaitForChild("EggRarityDisplay_UI");
require(ReplicatedStorage.Modules.WaitForDescendant);
local PetEggData = require(ReplicatedStorage.Data.PetEggData);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local Frame_Popup_Module = require(game.ReplicatedStorage.Frame_Popup_Module);
local Holder = EggRarityDisplay_UI:WaitForChild("RarityDisplay"):WaitForChild("Main"):WaitForChild("Holder");
local SENSOR = Holder:WaitForChild("Header"):WaitForChild("Exit"):WaitForChild("SENSOR");
local Content = Holder:WaitForChild("ScrollingFrame"):WaitForChild("Content");
local SEGMENT = Content:WaitForChild("SEGMENT");
local u1 = {};
local u2 = {};
local u3 = {
    ["Common Egg"] = "rbxassetid://110495383642358",
    ["Uncommon Egg"] = "rbxassetid://116378505754760",
    ["Rare Egg"] = "rbxassetid://111372276806205",
    ["Mythical Egg"] = "rbxassetid://83210224500991",
    ["Legendary Egg"] = "rbxassetid://97799911854888",
    ["Jungle Egg"] = "rbxassetid://82473700313689",
    ["Bug Egg"] = "rbxassetid://83970205286930"
};

for i, v in PetEggData do
    table.insert(u1, {
        Key = i,
        Value = v
    });
end;

table.sort(u1, function(p4, p5) -- Line: 44
    local StockChance = p4.Value.StockChance;
    local StockChance2 = p5.Value.StockChance;

    if StockChance == StockChance2 then
        return p4.Value.EggName < p5.Value.EggName;
    end;

    return StockChance2 < StockChance;
end);
local u6 = false;

function u2.Show(p7: table, p8: boolean) -- Line: 55
    -- upvalues: u6 (ref), SENSOR (copy), u2 (copy), Frame_Popup_Module (copy), EggRarityDisplay_UI (copy)
    if p8 and u6 == false then
        SENSOR.Activated:Connect(function() -- Line: 58
            -- upvalues: u2 (ref)
            u2:Show(false);
        end);
        u2:Populate();
        u6 = true;
    end;

    if p8 == true then
        Frame_Popup_Module.Show(EggRarityDisplay_UI.RarityDisplay);
    else
        Frame_Popup_Module.Hide(EggRarityDisplay_UI.RarityDisplay);
    end;

    print("ya");
    EggRarityDisplay_UI.Enabled = p8;
end;

function u2.Populate(p9) -- Line: 73
    -- upvalues: Content (copy), u1 (copy), SEGMENT (copy), u3 (copy), PetRegistry (copy)
    for _, child in Content:GetChildren() do
        if child.Name == "SEGMENT_UNUSED" then
            child:Destroy();
        end;
    end;

    local u10 = {};

    for _, v in u1 do
        table.insert(u10, {
            name = v.Value.EggName,
            chance = 1 / v.Value.StockChance
        });
    end;

    local function CalculateEggChance(u11, u12) -- Line: 84
        return 1 - (function() -- Line: 98, Name: SingleSlotNoEgg
            -- upvalues: u11 (copy), u12 (copy)
            local v13 = 1;

            for _, v in ipairs(u11) do
                if v.name == u12 then
                    return v13 * (1 - v13 * v.chance);
                end;

                v13 = v13 * (1 - v.chance);
            end;

            return v13;
        end)() ^ 3;
    end;

    for _, v in u1 do
        local v14 = SEGMENT:Clone();
        local Display = v14:WaitForChild("Display");
        local EGG_IMAGE = Display:WaitForChild("DisplayBox"):WaitForChild("EGG_IMAGE");
        local RARITY_NAME = Display:WaitForChild("RARITY_NAME");
        local RARITY_PERCENTAGE = Display:WaitForChild("RARITY_PERCENTAGE");
        v14.Parent = SEGMENT.Parent;
        EGG_IMAGE.Image = u3[v.Value.EggName];
        RARITY_NAME.Text = v.Value.EggName;
        RARITY_NAME.TextColor3 = PetRegistry.PetEggs[v.Value.EggName].Color;
        local EggName = v.Value.EggName;
        local v16 = (1 - (function() -- Line: 98, Name: SingleSlotNoEgg
            -- upvalues: u10 (copy), EggName (copy)
            local v15 = 1;

            for _, v2 in ipairs(u10) do
                if v2.name == EggName then
                    return v15 * (1 - v15 * v2.chance);
                end;

                v15 = v15 * (1 - v2.chance);
            end;

            return v15;
        end)() ^ 3) * 100;
        RARITY_PERCENTAGE.Text = `{("%.0f"):format(v16)}% of shops`;
        RARITY_PERCENTAGE.TextColor3 = Color3.fromRGB(255, 255, 255);
        v14.LayoutOrder = 1000 / v16;
    end;

    wait(1);
    SEGMENT:Destroy();
end;

return u2;