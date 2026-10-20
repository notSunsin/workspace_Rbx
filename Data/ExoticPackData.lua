-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
require(ReplicatedStorage.Data.CosmeticRegistry);
require(ReplicatedStorage.Data.CosmeticCrateRegistry);
local v1 = {
    Title = "PREMIUM NEW YEAR\'S EGG!",
    Vector = "rbxassetid://101080601124641",
    Display = "Egg",
    DisplayPlural = "Eggs",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 6,
    MidTemplateIndex = 4,
    ReleaseTime = 1766858400,
    EndTime = 1768068000,
    Pity = "Premium New Year\'s Egg",
    Products = {
        [1] = 3489363343,
        [3] = 3489363338,
        [10] = 3489363342,
        [50] = 3489363344
    },
    GiftProducts = {
        [1] = 3489363340,
        [3] = 3489363337,
        [10] = 3489363341,
        [50] = 3489363345
    },
    FallbackPrices = {
        [1] = 149,
        [3] = 429,
        [10] = 1249,
        [50] = 4999
    },
    VectorPosition = UDim2.fromScale(0.111, 0.613),
    VectorSize = UDim2.fromScale(0.31, 0.942)
};
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local v2 = {};

for i, v in PetRegistry.PetEggs["Premium New Year\'s Egg"].RarityData.Items do
    local v3 = i:match("Egg/(.-)$");
    local v4 = {
        Chance = v.ItemOdd,
        Type = v3 and "Egg" or "Pet",
        RewardId = v3 or i
    };
    local v5;

    if v3 then
        v5 = PetRegistry.PetEggs[v3].Icon or "";
    else
        v5 = PetRegistry.PetList[i] and (PetRegistry.PetList[i].Icon or "") or "";
    end;

    v4.Icon = v5;
    table.insert(v2, v4);
end;

table.sort(v2, function(p6, p7) -- Line: 118
    if p6.Type == "Egg" then
        return false;
    end;

    if p7.Type == "Egg" then
        return true;
    end;

    local Chance = p6.Chance;
    local Chance2 = p7.Chance;

    if Chance == Chance2 then
        return p6.RewardId > p7.RewardId;
    end;

    return Chance2 < Chance;
end);
v1.Items = v2;
local v8 = {
    Title = "PREMIUM CARNIVAL EGG!",
    Vector = "rbxassetid://91270408981945",
    Display = "Egg",
    DisplayPlural = "Eggs",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 5,
    MidTemplateIndex = 3,
    ReleaseTime = 1767463200,
    EndTime = 1768672800,
    Pity = "Premium Carnival Egg",
    Products = {
        [1] = 3497475839,
        [3] = 3497475846,
        [10] = 3497475844,
        [50] = 3497475843
    },
    GiftProducts = {
        [1] = 3497475841,
        [3] = 3497475845,
        [10] = 3497475840,
        [50] = 3497475842
    },
    FallbackPrices = {
        [1] = 149,
        [3] = 429,
        [10] = 1249,
        [50] = 4999
    },
    VectorPosition = UDim2.fromScale(0.111, 0.613),
    VectorSize = UDim2.fromScale(0.31, 0.942)
};
local PetRegistry2 = require(ReplicatedStorage.Data.PetRegistry);
local v9 = {};

for i, v in PetRegistry2.PetEggs["Premium Carnival Egg"].RarityData.Items do
    local v10 = i:match("Egg/(.-)$");
    local v11 = {
        Chance = v.ItemOdd,
        Type = v10 and "Egg" or "Pet",
        RewardId = v10 or i
    };
    local v12;

    if v10 then
        v12 = PetRegistry2.PetEggs[v10].Icon or "";
    else
        v12 = PetRegistry2.PetList[i] and (PetRegistry2.PetList[i].Icon or "") or "";
    end;

    v11.Icon = v12;
    table.insert(v9, v11);
end;

table.sort(v9, function(p13, p14) -- Line: 194
    if p13.Type == "Egg" then
        return false;
    end;

    if p14.Type == "Egg" then
        return true;
    end;

    local Chance = p13.Chance;
    local Chance2 = p14.Chance;

    if Chance == Chance2 then
        return p13.RewardId > p14.RewardId;
    end;

    return Chance2 < Chance;
end);
v8.Items = v9;
local v15 = {
    Title = "PREMIUM BIRD EGG!",
    Vector = "rbxassetid://82621628013565",
    Display = "Egg",
    DisplayPlural = "Eggs",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 5,
    MidTemplateIndex = 3,
    ReleaseTime = 1768672800,
    EndTime = 1769277600,
    Pity = "Premium Bird Egg",
    Products = {
        [1] = 3512151971,
        [3] = 3512151973,
        [10] = 3512151976,
        [50] = 3512151977
    },
    GiftProducts = {
        [1] = 3512151974,
        [3] = 3512151972,
        [10] = 3512151975,
        [50] = 3512151981
    },
    FallbackPrices = {
        [1] = 149,
        [3] = 429,
        [10] = 1249,
        [50] = 4999
    },
    VectorPosition = UDim2.fromScale(0.111, 0.613),
    VectorSize = UDim2.fromScale(0.31, 0.942)
};
local PetRegistry3 = require(ReplicatedStorage.Data.PetRegistry);
local v16 = {};

for i, v in PetRegistry3.PetEggs["Premium Bird Egg"].RarityData.Items do
    local v17 = i:match("Egg/(.-)$");
    local v18 = {
        Chance = v.ItemOdd,
        Type = v17 and "Egg" or "Pet",
        RewardId = v17 or i
    };
    local v19;

    if v17 then
        v19 = PetRegistry3.PetEggs[v17].Icon or "";
    else
        v19 = PetRegistry3.PetList[i] and (PetRegistry3.PetList[i].Icon or "") or "";
    end;

    v18.Icon = v19;
    table.insert(v16, v18);
end;

table.sort(v16, function(p20, p21) -- Line: 270
    if p20.Type == "Egg" then
        return false;
    end;

    if p21.Type == "Egg" then
        return true;
    end;

    local Chance = p20.Chance;
    local Chance2 = p21.Chance;

    if Chance == Chance2 then
        return p20.RewardId > p21.RewardId;
    end;

    return Chance2 < Chance;
end);
v15.Items = v16;
local v22 = {
    Title = "EXOTIC BUTTERCUP CHEST!",
    Vector = "rbxassetid://122073426066738",
    Display = "Chest",
    DisplayPlural = "Chests",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 6,
    MidTemplateIndex = 4,
    ReleaseTime = 1769277600,
    EndTime = 1770487200,
    Pity = "Exotic Buttercup Chest",
    Products = {
        [1] = 3520430329,
        [3] = 3520430327,
        [10] = 3520430328,
        [50] = 3520430331
    },
    GiftProducts = {
        [1] = 3520430333,
        [3] = 3520430330,
        [10] = 3520430332,
        [50] = 3520430334
    },
    FallbackPrices = {
        [1] = 149,
        [3] = 429,
        [10] = 1249,
        [50] = 4999
    },
    VectorPosition = UDim2.fromScale(0.1, 0.45),
    VectorSize = UDim2.fromScale(0.3, 0.6),
    Items = SeedPackData.Packs["Exotic Buttercup Chest"].Items
};
local v23 = {
    Title = "PREMIUM GOLDEN EGG!",
    Vector = "rbxassetid://139402975557026",
    Display = "Egg",
    DisplayPlural = "Eggs",
    BackgroundImage = "rbxassetid://78289594972654",
    BiggerTemplateIndex = 4,
    MidTemplateIndex = 3,
    ReleaseTime = 1775174400,
    EndTime = 1777748400,
    Pity = "Premium Golden Egg",
    Products = {
        [1] = 3568827015,
        [3] = 3568827227,
        [10] = 3568827595,
        [50] = 3570157250
    },
    GiftProducts = {
        [1] = 3568827750,
        [3] = 3568828285,
        [10] = 3568828441,
        [50] = 3570157336
    },
    FallbackPrices = {
        [1] = 149,
        [3] = 429,
        [10] = 1249,
        [50] = 4999
    },
    VectorPosition = UDim2.fromScale(0.111, 0.613),
    VectorSize = UDim2.fromScale(0.31, 0.942)
};
local PetRegistry4 = require(ReplicatedStorage.Data.PetRegistry);
local v24 = {};

for i, v in PetRegistry4.PetEggs["Premium Golden Egg"].RarityData.Items do
    local v25 = i:match("Egg/(.-)$");
    local v26 = {
        Chance = v.ItemOdd,
        Type = v25 and "Egg" or "Pet",
        RewardId = v25 or i
    };
    local v27;

    if v25 then
        v27 = PetRegistry4.PetEggs[v25].Icon or "";
    else
        v27 = PetRegistry4.PetList[i] and (PetRegistry4.PetList[i].Icon or "") or "";
    end;

    v26.Icon = v27;
    table.insert(v24, v26);
end;

table.sort(v24, function(p28, p29) -- Line: 389
    if p28.Type == "Egg" then
        return false;
    end;

    if p29.Type == "Egg" then
        return true;
    end;

    local Chance = p28.Chance;
    local Chance2 = p29.Chance;

    if Chance == Chance2 then
        return p28.RewardId > p29.RewardId;
    end;

    return Chance2 < Chance;
end);
v23.Items = v24;
local v30 = {
    Title = "PREMIUM SPRINGTIDE EGG!",
    Vector = "rbxassetid://105201345566503",
    Display = "Egg",
    DisplayPlural = "Eggs",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 4,
    MidTemplateIndex = 3,
    ReleaseTime = 1776524400,
    EndTime = 1778338800,
    Pity = "Premium Springtide Egg",
    Products = {
        [1] = 3576524674,
        [3] = 3576524780,
        [10] = 3576524860,
        [50] = 3576525035
    },
    GiftProducts = {
        [1] = 3576525092,
        [3] = 3576525196,
        [10] = 3576525248,
        [50] = 3576525311
    },
    FallbackPrices = {
        [1] = 149,
        [3] = 429,
        [10] = 1249,
        [50] = 4999
    },
    VectorPosition = UDim2.fromScale(0.111, 0.613),
    VectorSize = UDim2.fromScale(0.31, 0.942)
};
local PetRegistry5 = require(ReplicatedStorage.Data.PetRegistry);
local v31 = {};

for i, v in PetRegistry5.PetEggs["Premium Springtide Egg"].RarityData.Items do
    local v32 = i:match("Egg/(.-)$");
    local v33 = {
        Chance = v.ItemOdd,
        Type = v32 and "Egg" or "Pet",
        RewardId = v32 or i
    };
    local v34;

    if v32 then
        v34 = PetRegistry5.PetEggs[v32].Icon or "";
    else
        v34 = PetRegistry5.PetList[i] and (PetRegistry5.PetList[i].Icon or "") or "";
    end;

    v33.Icon = v34;
    table.insert(v31, v33);
end;

table.sort(v31, function(p35, p36) -- Line: 465
    if p35.Type == "Egg" then
        return false;
    end;

    if p36.Type == "Egg" then
        return true;
    end;

    local Chance = p35.Chance;
    local Chance2 = p36.Chance;

    if Chance == Chance2 then
        return p35.RewardId > p36.RewardId;
    end;

    return Chance2 < Chance;
end);
v30.Items = v31;
local v37 = {
    Title = "PREMIUM HIVE EGG!",
    Vector = "rbxassetid://87081420407627",
    Display = "Egg",
    DisplayPlural = "Eggs",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 4,
    MidTemplateIndex = 3,
    ReleaseTime = 1778356800,
    EndTime = 1780758000,
    Pity = "Premium Hive Egg",
    Products = {
        [1] = 3584036637,
        [3] = 3584036735,
        [10] = 3584036839,
        [50] = 3587190661
    },
    GiftProducts = {
        [1] = 3584036934,
        [3] = 3584037008,
        [10] = 3584037083,
        [50] = 3587190724
    },
    FallbackPrices = {
        [1] = 149,
        [3] = 429,
        [10] = 1249,
        [50] = 4999
    },
    VectorPosition = UDim2.fromScale(0.111, 0.613),
    VectorSize = UDim2.fromScale(0.31, 0.942)
};
local PetRegistry6 = require(ReplicatedStorage.Data.PetRegistry);
local v38 = {};

for i, v in PetRegistry6.PetEggs["Premium Hive Egg"].RarityData.Items do
    local v39 = i:match("Egg/(.-)$");
    local v40 = {
        Chance = v.ItemOdd,
        Type = v39 and "Egg" or "Pet",
        RewardId = v39 or i
    };
    local v41;

    if v39 then
        v41 = PetRegistry6.PetEggs[v39].Icon or "";
    else
        v41 = PetRegistry6.PetList[i] and (PetRegistry6.PetList[i].Icon or "") or "";
    end;

    v40.Icon = v41;
    table.insert(v38, v40);
end;

table.sort(v38, function(p42, p43) -- Line: 541
    if p42.Type == "Egg" then
        return false;
    end;

    if p43.Type == "Egg" then
        return true;
    end;

    local Chance = p42.Chance;
    local Chance2 = p43.Chance;

    if Chance == Chance2 then
        return p42.RewardId > p43.RewardId;
    end;

    return Chance2 < Chance;
end);
v37.Items = v38;
local v44 = {
    Title = "EXOTIC HIVE SEED PACK!",
    Vector = "rbxassetid://85462171123446",
    Display = "Pack",
    DisplayPlural = "Packs",
    BackgroundImage = "rbxassetid://78289594972654",
    BiggerTemplateIndex = 6,
    MidTemplateIndex = 4,
    ReleaseTime = 1778356800,
    EndTime = 1780758000,
    Pity = "Exotic Hive Seed Pack",
    Products = {
        [1] = 3588292639,
        [3] = 3588293165,
        [10] = 3588293244,
        [50] = 3588293328
    },
    GiftProducts = {
        [1] = 3588293395,
        [3] = 3588293465,
        [10] = 3588293540,
        [50] = 3588293629
    },
    FallbackPrices = {
        [1] = 199,
        [3] = 575,
        [10] = 1699,
        [50] = 6999
    },
    VectorPosition = UDim2.fromScale(0.1, 0.7),
    VectorSize = UDim2.fromScale(0.3, 0.6),
    Items = SeedPackData.Packs["Exotic Hive Seed Pack"].Items
};
local v45 = {
    Title = "PREMIUM CAMPFIRE EGG!",
    Vector = "rbxassetid://132816523313383",
    Display = "Egg",
    DisplayPlural = "Eggs",
    BackgroundImage = "rbxassetid://78289594972654",
    BiggerTemplateIndex = 4,
    MidTemplateIndex = 3,
    ReleaseTime = 1780777800,
    EndTime = 1783200600,
    Pity = "Premium Campfire Egg",
    Products = {
        [1] = 3602505965,
        [3] = 3602506028,
        [10] = 3602506064,
        [50] = 3602506115
    },
    GiftProducts = {
        [1] = 3602506154,
        [3] = 3602506203,
        [10] = 3602506392,
        [50] = 3602506446
    },
    FallbackPrices = {
        [1] = 149,
        [3] = 429,
        [10] = 1249,
        [50] = 4999
    },
    VectorPosition = UDim2.fromScale(0.111, 0.613),
    VectorSize = UDim2.fromScale(0.31, 0.942)
};
local PetRegistry7 = require(ReplicatedStorage.Data.PetRegistry);
local v46 = {};

for i, v in PetRegistry7.PetEggs["Premium Campfire Egg"].RarityData.Items do
    local v47 = i:match("Egg/(.-)$");
    local v48 = {
        Chance = v.ItemOdd,
        Type = v47 and "Egg" or "Pet",
        RewardId = v47 or i
    };
    local v49;

    if v47 then
        v49 = PetRegistry7.PetEggs[v47].Icon or "";
    else
        v49 = PetRegistry7.PetList[i] and (PetRegistry7.PetList[i].Icon or "") or "";
    end;

    v48.Icon = v49;
    table.insert(v46, v48);
end;

table.sort(v46, function(p50, p51) -- Line: 660
    if p50.Type == "Egg" then
        return false;
    end;

    if p51.Type == "Egg" then
        return true;
    end;

    local Chance = p50.Chance;
    local Chance2 = p51.Chance;

    if Chance == Chance2 then
        return p50.RewardId > p51.RewardId;
    end;

    return Chance2 < Chance;
end);
v45.Items = v46;
local v52 = {
    Title = "EXOTIC CAMPFIRE SEED PACK!",
    Vector = "rbxassetid://116984912843739",
    Display = "Pack",
    DisplayPlural = "Packs",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 6,
    MidTemplateIndex = 4,
    ReleaseTime = 1781386200,
    EndTime = 1783200600,
    Pity = "Exotic Campfire Seed Pack",
    Products = {
        [1] = 3603829987,
        [3] = 3603830024,
        [10] = 3603830055,
        [50] = 3603830077
    },
    GiftProducts = {
        [1] = 3603830106,
        [3] = 3603830134,
        [10] = 3603830161,
        [50] = 3603830195
    },
    FallbackPrices = {
        [1] = 199,
        [3] = 575,
        [10] = 1699,
        [50] = 6999
    },
    VectorPosition = UDim2.fromScale(0.1, 0.7),
    VectorSize = UDim2.fromScale(0.3, 0.6),
    Items = SeedPackData.Packs["Exotic Campfire Seed Pack"].Items
};
local v53 = {
    Title = "PREMIUM COASTAL EGG!",
    Vector = "rbxassetid://131477461339461",
    Display = "Egg",
    DisplayPlural = "Eggs",
    BackgroundImage = "rbxassetid://78289594972654",
    BiggerTemplateIndex = 4,
    MidTemplateIndex = 3,
    ReleaseTime = 1782898200,
    EndTime = 1785616200,
    Pity = "Premium Coastal Egg",
    Products = {
        [1] = 3607717721,
        [3] = 3607717736,
        [10] = 3607717758,
        [50] = 3607717778
    },
    GiftProducts = {
        [1] = 3607717806,
        [3] = 3607717835,
        [10] = 3607717860,
        [50] = 3607717887
    },
    FallbackPrices = {
        [1] = 149,
        [3] = 429,
        [10] = 1249,
        [50] = 4999
    },
    VectorPosition = UDim2.fromScale(0.111, 0.613),
    VectorSize = UDim2.fromScale(0.31, 0.942)
};
local PetRegistry8 = require(ReplicatedStorage.Data.PetRegistry);
local v54 = {};

for i, v in PetRegistry8.PetEggs["Premium Coastal Egg"].RarityData.Items do
    local v55 = i:match("Egg/(.-)$");
    local v56 = {
        Chance = v.ItemOdd,
        Type = v55 and "Egg" or "Pet",
        RewardId = v55 or i
    };
    local v57;

    if v55 then
        v57 = PetRegistry8.PetEggs[v55].Icon or "";
    else
        v57 = PetRegistry8.PetList[i] and (PetRegistry8.PetList[i].Icon or "") or "";
    end;

    v56.Icon = v57;
    table.insert(v54, v56);
end;

table.sort(v54, function(p58, p59) -- Line: 779
    if p58.Type == "Egg" then
        return false;
    end;

    if p59.Type == "Egg" then
        return true;
    end;

    local Chance = p58.Chance;
    local Chance2 = p59.Chance;

    if Chance == Chance2 then
        return p58.RewardId > p59.RewardId;
    end;

    return Chance2 < Chance;
end);
v53.Items = v54;
local v60 = {
    Title = "EXOTIC COASTAL SEED PACK!",
    Vector = "rbxassetid://136265715608647",
    Display = "Pack",
    DisplayPlural = "Packs",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 6,
    MidTemplateIndex = 4,
    ReleaseTime = 1783546200,
    EndTime = 1785616200,
    Pity = "Exotic Coastal Seed Pack",
    Products = {
        [1] = 3608858826,
        [3] = 3608858860,
        [10] = 3608858882,
        [50] = 3608858906
    },
    GiftProducts = {
        [1] = 3608858929,
        [3] = 3608858947,
        [10] = 3608858978,
        [50] = 3608859002
    },
    FallbackPrices = {
        [1] = 199,
        [3] = 575,
        [10] = 1699,
        [50] = 6999
    },
    VectorPosition = UDim2.fromScale(0.1, 0.7),
    VectorSize = UDim2.fromScale(0.3, 0.6),
    Items = SeedPackData.Packs["Exotic Coastal Seed Pack"].Items
};
local v61 = {
    Title = "COASTAL CONTAINER!",
    Vector = "rbxassetid://108837343329597",
    Display = "Container",
    DisplayPlural = "Containers",
    BackgroundImage = "rbxassetid://139916249283051",
    BiggerTemplateIndex = 5,
    MidTemplateIndex = 3,
    ReleaseTime = 1783546200,
    EndTime = 1786221000,
    Pity = "Coastal Container",
    Products = {
        [1] = 3611262564,
        [3] = 3611262600,
        [10] = 3611262627
    },
    GiftProducts = {
        [1] = 3611262650,
        [3] = 3611262667,
        [10] = 3611262688
    },
    FallbackPrices = {
        [1] = 149,
        [3] = 429,
        [10] = 1249
    },
    VectorPosition = UDim2.fromScale(0.111, 0.613),
    VectorSize = UDim2.fromScale(0.31, 0.942),
    Items = SeedPackData.Packs["Coastal Container"].Items
};
local v62 = {
    Title = "PREMIUM MOON EGG!",
    Vector = "rbxassetid://90683957265356",
    Display = "Egg",
    DisplayPlural = "Eggs",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 4,
    MidTemplateIndex = 3,
    ReleaseTime = 1785616200,
    EndTime = 1788035400,
    Pity = "Premium Moon Egg",
    Products = {
        [1] = 3612305749,
        [3] = 3612305786,
        [10] = 3612305812,
        [50] = 3612305842
    },
    GiftProducts = {
        [1] = 3612305899,
        [3] = 3612305932,
        [10] = 3612305959,
        [50] = 3612305981
    },
    FallbackPrices = {
        [1] = 149,
        [3] = 429,
        [10] = 1249,
        [50] = 4999
    },
    VectorPosition = UDim2.fromScale(0.111, 0.613),
    VectorSize = UDim2.fromScale(0.31, 0.942)
};
local PetRegistry9 = require(ReplicatedStorage.Data.PetRegistry);
local v63 = {};

for i, v in PetRegistry9.PetEggs["Premium Moon Egg"].RarityData.Items do
    local v64 = i:match("Egg/(.-)$");
    local v65 = {
        Chance = v.ItemOdd,
        Type = v64 and "Egg" or "Pet",
        RewardId = v64 or i
    };
    local v66;

    if v64 then
        v66 = PetRegistry9.PetEggs[v64] and (PetRegistry9.PetEggs[v64].Icon or "") or "";
    else
        v66 = PetRegistry9.PetList[i] and (PetRegistry9.PetList[i].Icon or "") or "";
    end;

    v65.Icon = v66;
    table.insert(v63, v65);
end;

table.sort(v63, function(p67, p68) -- Line: 938
    if p67.Type == "Egg" then
        return false;
    end;

    if p68.Type == "Egg" then
        return true;
    end;

    local Chance = p67.Chance;
    local Chance2 = p68.Chance;

    if Chance == Chance2 then
        return p67.RewardId > p68.RewardId;
    end;

    return Chance2 < Chance;
end);
v62.Items = v63;
local v69 = {
    Title = "EXOTIC MOON CHEST!",
    Vector = "rbxassetid://123738452464990",
    Display = "Chest",
    DisplayPlural = "Chests",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 6,
    MidTemplateIndex = 4,
    ReleaseTime = 1786221000,
    EndTime = 1788035400,
    Pity = "Exotic Moon Chest",
    Products = {
        [1] = 3625639161,
        [3] = 3625640337,
        [10] = 3625641435,
        [50] = 3625642643
    },
    GiftProducts = {
        [1] = 3625643815,
        [3] = 3625646165,
        [10] = 3625647334,
        [50] = 3625650074
    },
    FallbackPrices = {
        [1] = 199,
        [3] = 575,
        [10] = 1699,
        [50] = 6999
    },
    VectorPosition = UDim2.fromScale(0.1, 0.7),
    VectorSize = UDim2.fromScale(0.3, 0.6),
    Items = SeedPackData.Packs["Exotic Moon Chest"].Items
};
local v70 = {
    Title = "PREMIUM SEED SACK!",
    Vector = "rbxassetid://123738452464990",
    Display = "Seed Sack",
    DisplayPlural = "Seed Sacks",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 6,
    MidTemplateIndex = 4,
    ReleaseTime = 0,
    EndTime = 1,
    Pity = "Premium Seed Sack",
    Products = {
        [1] = 3273679011,
        [3] = 3273679014,
        [10] = 3273679012
    },
    GiftProducts = {
        [10] = 3273679009
    },
    FallbackPrices = {
        [1] = 199,
        [3] = 575,
        [10] = 1699
    },
    VectorPosition = UDim2.fromScale(0.1, 0.7),
    VectorSize = UDim2.fromScale(0.3, 0.6),
    Items = SeedPackData.Packs.SeedSackPremium.Items
};
local v71 = {
    Title = "PREMIUM BEANPOD EGG!",
    Vector = "rbxassetid://78103649979209",
    Display = "Egg",
    DisplayPlural = "Eggs",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 4,
    MidTemplateIndex = 3,
    ReleaseTime = 1785616200,
    EndTime = 1789849800,
    Pity = "Premium Beanpod Egg",
    Products = {
        [1] = 3709891366,
        [3] = 3709891385,
        [10] = 3709891407,
        [50] = 3709891420
    },
    GiftProducts = {
        [1] = 3709891434,
        [3] = 3709891454,
        [10] = 3709891474,
        [50] = 3709891499
    },
    FallbackPrices = {
        [1] = 149,
        [3] = 429,
        [10] = 1249,
        [50] = 4999
    },
    VectorPosition = UDim2.fromScale(0.111, 0.613),
    VectorSize = UDim2.fromScale(0.31, 0.942)
};
local PetRegistry10 = require(ReplicatedStorage.Data.PetRegistry);
local v72 = {};

for i, v in PetRegistry10.PetEggs["Premium Beanpod Egg"].RarityData.Items do
    local v73 = i:match("Egg/(.-)$");
    local v74 = {
        Chance = v.ItemOdd,
        Type = v73 and "Egg" or "Pet",
        RewardId = v73 or i
    };
    local v75;

    if v73 then
        v75 = PetRegistry10.PetEggs[v73] and (PetRegistry10.PetEggs[v73].Icon or "") or "";
    else
        v75 = PetRegistry10.PetList[i] and (PetRegistry10.PetList[i].Icon or "") or "";
    end;

    v74.Icon = v75;
    table.insert(v72, v74);
end;

table.sort(v72, function(p76, p77) -- Line: 1100
    if p76.Type == "Egg" then
        return false;
    end;

    if p77.Type == "Egg" then
        return true;
    end;

    local Chance = p76.Chance;
    local Chance2 = p77.Chance;

    if Chance == Chance2 then
        return p76.RewardId > p77.RewardId;
    end;

    return Chance2 < Chance;
end);
v71.Items = v72;
local v78 = {
    Title = "EXOTIC BEANPOD CHEST!",
    Vector = "rbxassetid://76983503106409",
    Display = "Chest",
    DisplayPlural = "Chests",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 6,
    MidTemplateIndex = 4,
    ReleaseTime = 1788640200,
    EndTime = 1789849800,
    Pity = "Exotic Beanpod Chest",
    Products = {
        [1] = 3711038375,
        [3] = 3711038401,
        [10] = 3711038424,
        [50] = 3711038455
    },
    GiftProducts = {
        [1] = 3711038487,
        [3] = 3711038498,
        [10] = 3711038514,
        [50] = 3711038536
    },
    FallbackPrices = {
        [1] = 199,
        [3] = 575,
        [10] = 1699,
        [50] = 6999
    },
    VectorPosition = UDim2.fromScale(0.1, 0.7),
    VectorSize = UDim2.fromScale(0.3, 0.6),
    Items = SeedPackData.Packs["Exotic Beanpod Chest"].Items
};
local v79 = {
    Title = "EXOTIC AUTUMN SEED PACK!",
    Vector = "rbxassetid://93541280126803",
    Display = "Pack",
    DisplayPlural = "Packs",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 6,
    MidTemplateIndex = 4,
    ReleaseTime = 1789849800,
    EndTime = 1791664200,
    Pity = "Exotic Autumn Seed Pack",
    Products = {
        [1] = 3713317675,
        [3] = 3713317715,
        [10] = 3713317737,
        [50] = 3713317757
    },
    GiftProducts = {
        [1] = 3713317780,
        [3] = 3713317802,
        [10] = 3713317825,
        [50] = 3713317849
    },
    FallbackPrices = {
        [1] = 199,
        [3] = 575,
        [10] = 1699,
        [50] = 6999
    },
    VectorPosition = UDim2.fromScale(0.1, 0.7),
    VectorSize = UDim2.fromScale(0.3, 0.6),
    Items = SeedPackData.Packs["Exotic Autumn Seed Pack"].Items
};
local v80 = {
    Title = "PREMIUM AUTUMN EGG!",
    Vector = "rbxassetid://80042806233590",
    Display = "Egg",
    DisplayPlural = "Eggs",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 4,
    MidTemplateIndex = 3,
    ReleaseTime = 1790454600,
    EndTime = 1792269000,
    Pity = "Premium Autumn Egg",
    Products = {
        [1] = 3714395739,
        [3] = 3714395815,
        [10] = 3714395899,
        [50] = 3714396001
    },
    GiftProducts = {
        [1] = 3714396065,
        [3] = 3714396129,
        [10] = 3714396230,
        [50] = 3714396299
    },
    FallbackPrices = {
        [1] = 149,
        [3] = 429,
        [10] = 1249,
        [50] = 4999
    },
    VectorPosition = UDim2.fromScale(0.111, 0.613),
    VectorSize = UDim2.fromScale(0.31, 0.942)
};
local PetRegistry11 = require(ReplicatedStorage.Data.PetRegistry);
local v81 = {};

for i, v in PetRegistry11.PetEggs["Premium Autumn Egg"].RarityData.Items do
    local v82 = i:match("Egg/(.-)$");
    local v83 = {
        Chance = v.ItemOdd,
        Type = v82 and "Egg" or "Pet",
        RewardId = v82 or i
    };
    local v84;

    if v82 then
        v84 = PetRegistry11.PetEggs[v82] and (PetRegistry11.PetEggs[v82].Icon or "") or "";
    else
        v84 = PetRegistry11.PetList[i] and (PetRegistry11.PetList[i].Icon or "") or "";
    end;

    v83.Icon = v84;
    table.insert(v81, v83);
end;

table.sort(v81, function(p85, p86) -- Line: 1262
    if p85.Type == "Egg" then
        return false;
    end;

    if p86.Type == "Egg" then
        return true;
    end;

    local Chance = p85.Chance;
    local Chance2 = p86.Chance;

    if Chance == Chance2 then
        return p85.RewardId > p86.RewardId;
    end;

    return Chance2 < Chance;
end);
v80.Items = v81;
local v87 = {
    Title = "EXOTIC FAIRY CHEST!",
    Vector = "rbxassetid://75391043407636",
    Display = "Chest",
    DisplayPlural = "Chests",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 6,
    MidTemplateIndex = 4,
    ReleaseTime = 1788640200,
    EndTime = 1792269000,
    Pity = "Exotic Fairy Chest",
    Products = {
        [1] = 3717205221,
        [3] = 3717205245,
        [10] = 3717205265,
        [50] = 3717205274
    },
    GiftProducts = {
        [1] = 3717205296,
        [3] = 3717205313,
        [10] = 3717205336,
        [50] = 3717205363
    },
    FallbackPrices = {
        [1] = 199,
        [3] = 575,
        [10] = 1699,
        [50] = 6999
    },
    VectorPosition = UDim2.fromScale(0.1, 0.7),
    VectorSize = UDim2.fromScale(0.3, 0.6),
    Items = SeedPackData.Packs["Exotic Fairy Chest"].Items
};
local v88 = {
    Title = "PREMIUM HAUNTED EGG!",
    Vector = "rbxassetid://118375410314383",
    Display = "Egg",
    DisplayPlural = "Eggs",
    BackgroundImage = "rbxassetid://138776814412466",
    BiggerTemplateIndex = 4,
    MidTemplateIndex = 3,
    ReleaseTime = 1790454600,
    EndTime = 1792873800,
    Pity = "Premium Haunted Egg",
    Products = {
        [1] = 3718827230,
        [3] = 3718827272,
        [10] = 3718827355,
        [50] = 3718827410
    },
    GiftProducts = {
        [1] = 3718827497,
        [3] = 3718827540,
        [10] = 3718827727,
        [50] = 3718827768
    },
    FallbackPrices = {
        [1] = 149,
        [3] = 429,
        [10] = 1249,
        [50] = 4999
    },
    VectorPosition = UDim2.fromScale(0.111, 0.613),
    VectorSize = UDim2.fromScale(0.31, 0.942)
};
local PetRegistry12 = require(ReplicatedStorage.Data.PetRegistry);
local v89 = {};

for i, v in PetRegistry12.PetEggs["Premium Haunted Egg"].RarityData.Items do
    local v90 = i:match("Egg/(.-)$");
    local v91 = {
        Chance = v.ItemOdd,
        Type = v90 and "Egg" or "Pet",
        RewardId = v90 or i
    };
    local v92;

    if v90 then
        v92 = PetRegistry12.PetEggs[v90] and (PetRegistry12.PetEggs[v90].Icon or "") or "";
    else
        v92 = PetRegistry12.PetList[i] and (PetRegistry12.PetList[i].Icon or "") or "";
    end;

    v91.Icon = v92;
    table.insert(v89, v91);
end;

table.sort(v89, function(p93, p94) -- Line: 1381
    if p93.Type == "Egg" then
        return false;
    end;

    if p94.Type == "Egg" then
        return true;
    end;

    local Chance = p93.Chance;
    local Chance2 = p94.Chance;

    if Chance == Chance2 then
        return p93.RewardId > p94.RewardId;
    end;

    return Chance2 < Chance;
end);
v88.Items = v89;

return {
    PREMIUM_NEW_YEARS_EGG = v1,
    PREMIUM_CARNIVAL_EGG = v8,
    PREMIUM_BIRD_EGG = v15,
    EXOTIC_BUTTERCUP_CHEST = v22,
    PREMIUM_GOLDEN_EGG = v23,
    PREMIUM_SPRINGTIDE_EGG = v30,
    PREMIUM_HIVE_EGG = v37,
    EXOTIC_HIVE_SEED_PACK = v44,
    PREMIUM_CAMPFIRE_EGG = v45,
    EXOTIC_CAMPFIRE_SEED_PACK = v52,
    PREMIUM_COASTAL_EGG = v53,
    EXOTIC_COASTAL_SEED_PACK = v60,
    COASTAL_CONTAINER = v61,
    PREMIUM_MOON_EGG = v62,
    EXOTIC_MOON_CHEST = v69,
    ANGRY_PLANT_PREMIUM_SEED_SACK = v70,
    PREMIUM_BEANPOD_EGG = v71,
    EXOTIC_BEANPOD_CHEST = v78,
    EXOTIC_AUTUMN_SEED_PACK = v79,
    PREMIUM_AUTUMN_EGG = v80,
    EXOTIC_FAIRY_CHEST = v87,
    PREMIUM_HAUNTED_EGG = v88,
    EXOTIC_HAUNTED_SEED_PACK = {
        Title = "EXOTIC HAUNTED SEED PACK!",
        Vector = "rbxassetid://113291665467789",
        Display = "Pack",
        DisplayPlural = "Packs",
        BackgroundImage = "rbxassetid://138776814412466",
        BiggerTemplateIndex = 6,
        MidTemplateIndex = 4,
        ReleaseTime = 1790454600,
        EndTime = 1794083400,
        Products = {
            [1] = 3718826697,
            [3] = 3718826722,
            [10] = 3718826777,
            [50] = 3718826801
        },
        GiftProducts = {
            [10] = 3718826877,
            [50] = 3718826916
        },
        FallbackPrices = {
            [1] = 199,
            [3] = 575,
            [10] = 1699,
            [50] = 6999
        },
        VectorPosition = UDim2.fromScale(0.1, 0.7),
        VectorSize = UDim2.fromScale(0.3, 0.6),
        Items = SeedPackData.Packs["Exotic Haunted Seed Pack"].Items
    }
};