-- Decompiled with Potassium's decompiler.

local ServerStorage = game:GetService("ServerStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("HttpService");
ServerStorage:WaitForChild("SaveableTools");
local ObjectModels = ReplicatedStorage:WaitForChild("ObjectModels");
local FriendshipPots = ReplicatedStorage.Assets.Models.FriendshipPots;
local SprayBottles = ReplicatedStorage.Assets.Models.SprayBottles;
local PetBoosts = ReplicatedStorage.Assets.Models.PetBoosts;
local PetShards = ReplicatedStorage.Assets.Models.PetShards;
local BeeEggs = ReplicatedStorage.Assets.Models.BeeEggs;
require(ReplicatedStorage.Data.SaveableToolsData);
require(ReplicatedStorage.Modules.StringUtils);
local InventoryService = require(ServerScriptService.Modules.InventoryService);
local FriendshipPotToolService = require(ServerScriptService.Modules.FriendshipPot.FriendshipPotToolService);
local SprayService = require(ServerScriptService.Modules.SprayService);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local PetBoostRegistry = require(ReplicatedStorage.Data.PetRegistry.PetBoostRegistry);
local PetMutationHandler = require(ServerScriptService.Modules.PetsServices.PetMutationHandler);
local PetShardService = require(ServerScriptService.Modules.PetShardService);
local Item_Module = require(ReplicatedStorage.Item_Module);
local FertilizerService = require(ServerScriptService.Modules.FertilizerService);
local BeeEggService = require(ServerScriptService.Modules.BeeEggService);
local v1;

if game:GetService("RunService"):IsServer() then
    v1 = ServerStorage:WaitForChild("Assets"):WaitForChild("FoodModels");
else
    v1 = require(ReplicatedStorage.Modules.SelectiveAssetReplication):GetAssetAsync("Assets", "FoodModels");
end;

local MutationNames = MutationHandler.MutationNames;
local MutationNames2 = PetMutationHandler.MutationNames;

local function uses(u2: number?) -- Line: 53
    -- upvalues: InventoryService (copy)
    return function(p3: userdata, p4: string, p5: number?) -- Line: 54
        -- upvalues: u2 (copy), InventoryService (ref)
        local v6 = p5 or (u2 or 1);
        local v7 = InventoryService:Find(p3, p4);
        local _, v8 = next(v7);

        if not v8 then
            InventoryService:CreateItem(p3, p4, {
                Uses = v6
            });

            return;
        end;

        local ItemData = v8.ItemData;
        ItemData.Uses = ItemData.Uses + v6;
    end;
end;

local function usesPlaceableGear(u9: string) -- Line: 73
    -- upvalues: InventoryService (copy)
    return function(p10: userdata, u11: string, p12: number?) -- Line: 74
        -- upvalues: InventoryService (ref), u9 (copy)
        local v13 = p12 or 1;
        local v15 = InventoryService:Find(p10, u9, function(p14) -- Line: 77
            -- upvalues: u11 (copy)
            return p14.ItemName == u11;
        end);
        local _, v16 = next(v15);

        if not v16 then
            InventoryService:CreateItem(p10, u9, {
                ItemName = u11,
                Uses = v13
            });

            return;
        end;

        if not v16.ItemData.Uses then
            v16.ItemData.Uses = 1;
        end;

        local ItemData = v16.ItemData;
        ItemData.Uses = ItemData.Uses + v13;
    end;
end;

local function usesPowerRemaining(u17: number?, u18: number?) -- Line: 97
    -- upvalues: InventoryService (copy)
    return function(p19: userdata, p20: string, p21: number?) -- Line: 98
        -- upvalues: u17 (copy), u18 (ref), InventoryService (ref)
        local v22 = p21 or (u17 or 1);
        u18 = u18 or 100;
        local v23 = InventoryService:Find(p19, p20);
        local _, v24 = next(v23);

        if not v24 then
            InventoryService:CreateItem(p19, p20, {
                Uses = v22,
                PowerRemaining = u18
            });

            return;
        end;

        local ItemData = v24.ItemData;
        ItemData.Uses = ItemData.Uses + v22;
    end;
end;

local function usesPlaceable(u25: number?) -- Line: 116
    -- upvalues: InventoryService (copy)
    return function(p26: userdata, p27: string, p28: number?) -- Line: 117
        -- upvalues: u25 (copy), InventoryService (ref)
        local v29 = p28 or (u25 or 1);
        local v30 = InventoryService:Find(p26, p27);
        local _, v31 = next(v30);

        if not v31 then
            InventoryService:CreateItem(p26, p27, {
                ItemName = p27,
                Uses = v29
            });

            return;
        end;

        local ItemData = v31.ItemData;
        ItemData.Uses = ItemData.Uses + v29;
    end;
end;

local u137 = {
    ["Watering Can"] = function(p32: userdata, p33: string, p34: number?) -- Line: 134
        -- upvalues: InventoryService (copy)
        local v35 = p34 or 1;
        local v36 = InventoryService:Find(p32, "Watering Can");
        local _, v37 = next(v36);

        if not v37 then
            InventoryService:CreateItem(p32, "Watering Can", {
                Uses = v35
            });

            return;
        end;

        local ItemData = v37.ItemData;
        ItemData.Uses = ItemData.Uses + v35;
    end,

    Trowel = function(p38: userdata, p39: string, p40: number?) -- Line: 148
        -- upvalues: InventoryService (copy)
        local v41 = p40 or 1;
        local v42 = InventoryService:Find(p38, "Trowel");
        local _, v43 = next(v42);

        if not v43 then
            InventoryService:CreateItem(p38, "Trowel", {
                Uses = v41
            });

            return;
        end;

        local ItemData = v43.ItemData;
        ItemData.Uses = ItemData.Uses + v41;
    end,

    ["Recall Wrench"] = function(p44: userdata, p45: string, p46: number?) -- Line: 162
        -- upvalues: InventoryService (copy)
        local v47 = p46 or 1;
        local v48 = InventoryService:Find(p44, "Recall Wrench");
        local _, v49 = next(v48);

        if not v49 then
            InventoryService:CreateItem(p44, "Recall Wrench", {
                Uses = v47
            });

            return;
        end;

        local ItemData = v49.ItemData;
        ItemData.Uses = ItemData.Uses + v47;
    end,

    ["Event Lantern"] = function(p50: userdata, p51: string, p52: number?) -- Line: 176
        -- upvalues: InventoryService (copy)
        local v53 = p52 or 1;
        local v54 = InventoryService:Find(p50, "Event Lantern");
        local _, v55 = next(v54);

        if not v55 then
            InventoryService:CreateItem(p50, "Event Lantern", {
                Uses = v53
            });

            return;
        end;

        local ItemData = v55.ItemData;
        ItemData.Uses = ItemData.Uses + v53;
    end,

    ["Favorite Tool"] = function(p56: userdata, p57: string, p58: number) -- Line: 190
        -- upvalues: InventoryService (copy)
        local v59 = p58 or 1;
        local v60 = InventoryService:Find(p56, "Favorite Tool");
        local _, v61 = next(v60);

        if not v61 then
            InventoryService:CreateItem(p56, "Favorite Tool", {
                Uses = v59
            });

            return;
        end;

        local ItemData = v61.ItemData;
        ItemData.Uses = ItemData.Uses + v59;
    end,

    ["Harvest Tool"] = function(p62: userdata, p63: string, p64: number) -- Line: 204
        -- upvalues: InventoryService (copy)
        local v65 = p64 or 1;
        local v66 = InventoryService:Find(p62, "Harvest Tool");
        local _, v67 = next(v66);

        if not v67 then
            InventoryService:CreateItem(p62, "Harvest Tool", {
                Uses = v65
            });

            return;
        end;

        local ItemData = v67.ItemData;
        ItemData.Uses = ItemData.Uses + v65;
    end,

    ["Pet Pouch"] = function(p68: userdata, p69: string, p70: number?) -- Line: 218
        -- upvalues: InventoryService (copy)
        local v71 = p70 or 1;
        local v72 = InventoryService:Find(p68, "Pet Pouch");
        local _, v73 = next(v72);

        if not v73 then
            InventoryService:CreateItem(p68, "Pet Pouch", {
                Uses = v71
            });

            return;
        end;

        local ItemData = v73.ItemData;
        ItemData.Uses = ItemData.Uses + v71;
    end,

    ["Pollen Radar"] = function(p74: userdata, p75: string, p76: number?) -- Line: 232
        -- upvalues: InventoryService (copy)
        local v77 = p76 or 1;
        local v78 = InventoryService:Find(p74, "Pollen Radar");
        local _, v79 = next(v78);

        if not v79 then
            InventoryService:CreateItem(p74, "Pollen Radar", {
                Uses = v77
            });

            return;
        end;

        local ItemData = v79.ItemData;
        ItemData.Uses = ItemData.Uses + v77;
    end,

    ["Tranquil Radar"] = function(p80: userdata, p81: string, p82: number?) -- Line: 246
        -- upvalues: InventoryService (copy)
        local v83 = p82 or 1;
        local v84 = InventoryService:Find(p80, "Tranquil Radar");
        local _, v85 = next(v84);

        if not v85 then
            InventoryService:CreateItem(p80, "Tranquil Radar", {
                Uses = v83
            });

            return;
        end;

        local ItemData = v85.ItemData;
        ItemData.Uses = ItemData.Uses + v83;
    end,

    ["Corrupt Radar"] = function(p86: userdata, p87: string, p88: number?) -- Line: 260
        -- upvalues: InventoryService (copy)
        local v89 = p88 or 1;
        local v90 = InventoryService:Find(p86, "Corrupt Radar");
        local _, v91 = next(v90);

        if not v91 then
            InventoryService:CreateItem(p86, "Corrupt Radar", {
                Uses = v89
            });

            return;
        end;

        local ItemData = v91.ItemData;
        ItemData.Uses = ItemData.Uses + v89;
    end,

    ["Glimmering Radar"] = function(p92: userdata, p93: string, p94: number?) -- Line: 274
        -- upvalues: InventoryService (copy)
        local v95 = p94 or 1;
        local v96 = InventoryService:Find(p92, "Glimmering Radar");
        local _, v97 = next(v96);

        if not v97 then
            InventoryService:CreateItem(p92, "Glimmering Radar", {
                Uses = v95
            });

            return;
        end;

        local ItemData = v97.ItemData;
        ItemData.Uses = ItemData.Uses + v95;
    end,

    Reclaimer = function(p98: userdata, p99: string, p100: number?) -- Line: 288
        -- upvalues: InventoryService (copy)
        local v101 = p100 or 1;
        local v102 = InventoryService:Find(p98, "Reclaimer");
        local _, v103 = next(v102);

        if not v103 then
            InventoryService:CreateItem(p98, "Reclaimer", {
                Uses = v101
            });

            return;
        end;

        local ItemData = v103.ItemData;
        ItemData.Uses = ItemData.Uses + v101;
    end,

    ["Tanning Mirror"] = function(p104: userdata, p105: string, p106: number?) -- Line: 302
        -- upvalues: InventoryService (copy)
        local v107 = p106 or 1;
        local v108 = InventoryService:Find(p104, "Tanning Mirror");
        local _, v109 = next(v108);

        if not v109 then
            InventoryService:CreateItem(p104, "Tanning Mirror", {
                Uses = v107
            });

            return;
        end;

        local ItemData = v109.ItemData;
        ItemData.Uses = ItemData.Uses + v107;
    end,

    ["Magnifying Glass"] = function(p110: userdata, p111: string, p112: number?) -- Line: 316
        -- upvalues: InventoryService (copy)
        local v113 = p112 or 1;
        local v114 = InventoryService:Find(p110, "Magnifying Glass");
        local _, v115 = next(v114);

        if not v115 then
            InventoryService:CreateItem(p110, "Magnifying Glass", {
                Uses = v113
            });

            return;
        end;

        local ItemData = v115.ItemData;
        ItemData.Uses = ItemData.Uses + v113;
    end,

    Firework = function(p116: userdata, p117: string, p118: number?) -- Line: 330
        -- upvalues: InventoryService (copy)
        local v119 = p118 or 1;
        local v120 = InventoryService:Find(p116, "Firework");
        local _, v121 = next(v120);

        if not v121 then
            InventoryService:CreateItem(p116, "Firework", {
                Uses = v119
            });

            return;
        end;

        local ItemData = v121.ItemData;
        ItemData.Uses = ItemData.Uses + v119;
    end,

    ["Plant Booster"] = function(p122: userdata, p123: string, p124: number?) -- Line: 359
        -- upvalues: InventoryService (copy)
        InventoryService:CreateItem(p122, "Plant Booster", {
            PlantBoostAmount = 10
        });
    end,

    ["Egg Booster"] = function(p125: userdata, p126: string, p127: number?) -- Line: 365
        -- upvalues: InventoryService (copy)
        local v128 = p127 or 1;
        local v129 = InventoryService:Find(p125, "Egg Booster");
        local _, v130 = next(v129);

        if not v130 then
            InventoryService:CreateItem(p125, "Egg Booster", {
                EggBoostAmount = 10,
                Uses = v128
            });

            return;
        end;

        local ItemData = v130.ItemData;
        ItemData.Uses = ItemData.Uses + v128;
    end,

    ["Elder Candy Blossom Upgrader"] = function(p131: userdata, p132: string, p133: number?) -- Line: 381
        -- upvalues: InventoryService (copy)
        local v134 = p133 or 1;
        local v135 = InventoryService:Find(p131, "Elder Candy Blossom Upgrader");
        local _, v136 = next(v135);

        if not v136 then
            InventoryService:CreateItem(p131, "Elder Candy Blossom Upgrader", {
                Uses = v134
            });

            return;
        end;

        local ItemData = v136.ItemData;
        ItemData.Uses = ItemData.Uses + v134;
    end
};
local u138 = 1;

u137["Candy Blossom Shard"] = function(p139: userdata, p140: string, p141: number?) -- Line: 54
    -- upvalues: u138 (copy), InventoryService (copy)
    local v142 = p141 or (u138 or 1);
    local v143 = InventoryService:Find(p139, p140);
    local _, v144 = next(v143);

    if not v144 then
        InventoryService:CreateItem(p139, p140, {
            Uses = v142
        });

        return;
    end;

    local ItemData = v144.ItemData;
    ItemData.Uses = ItemData.Uses + v142;
end;

u137["Trading Ticket"] = function(p145: userdata, p146: string, p147: number?) -- Line: 398
    -- upvalues: InventoryService (copy)
    local v148 = p147 or 1;
    local v149 = InventoryService:Find(p145, "Trading Ticket");
    local _, v150 = next(v149);

    if not v150 then
        InventoryService:CreateItem(p145, "Trading Ticket", {
            Uses = v148
        });

        return;
    end;

    local ItemData = v150.ItemData;
    ItemData.Uses = ItemData.Uses + v148;
end;

local u151 = 1;

u137["Fairy Summoner"] = function(p152: userdata, p153: string, p154: number?) -- Line: 54
    -- upvalues: u151 (copy), InventoryService (copy)
    local v155 = p154 or (u151 or 1);
    local v156 = InventoryService:Find(p152, p153);
    local _, v157 = next(v156);

    if not v157 then
        InventoryService:CreateItem(p152, p153, {
            Uses = v155
        });

        return;
    end;

    local ItemData = v157.ItemData;
    ItemData.Uses = ItemData.Uses + v155;
end;

local u158 = 1;

u137["Fairy Power Extender"] = function(p159: userdata, p160: string, p161: number?) -- Line: 54
    -- upvalues: u158 (copy), InventoryService (copy)
    local v162 = p161 or (u158 or 1);
    local v163 = InventoryService:Find(p159, p160);
    local _, v164 = next(v163);

    if not v164 then
        InventoryService:CreateItem(p159, p160, {
            Uses = v162
        });

        return;
    end;

    local ItemData = v164.ItemData;
    ItemData.Uses = ItemData.Uses + v162;
end;

local u165 = 1;

u137["Fairy Caller"] = function(p166: userdata, p167: string, p168: number?) -- Line: 54
    -- upvalues: u165 (copy), InventoryService (copy)
    local v169 = p168 or (u165 or 1);
    local v170 = InventoryService:Find(p166, p167);
    local _, v171 = next(v170);

    if not v171 then
        InventoryService:CreateItem(p166, p167, {
            Uses = v169
        });

        return;
    end;

    local ItemData = v171.ItemData;
    ItemData.Uses = ItemData.Uses + v169;
end;

local u172 = 1;

u137["Luminous Wand"] = function(p173: userdata, p174: string, p175: number?) -- Line: 54
    -- upvalues: u172 (copy), InventoryService (copy)
    local v176 = p175 or (u172 or 1);
    local v177 = InventoryService:Find(p173, p174);
    local _, v178 = next(v177);

    if not v178 then
        InventoryService:CreateItem(p173, p174, {
            Uses = v176
        });

        return;
    end;

    local ItemData = v178.ItemData;
    ItemData.Uses = ItemData.Uses + v176;
end;

local u179 = 1;

u137["Fairy Net"] = function(p180: userdata, p181: string, p182: number?) -- Line: 54
    -- upvalues: u179 (copy), InventoryService (copy)
    local v183 = p182 or (u179 or 1);
    local v184 = InventoryService:Find(p180, p181);
    local _, v185 = next(v184);

    if not v185 then
        InventoryService:CreateItem(p180, p181, {
            Uses = v183
        });

        return;
    end;

    local ItemData = v185.ItemData;
    ItemData.Uses = ItemData.Uses + v183;
end;

local u186 = 1;

u137["Fairy Jar"] = function(p187: userdata, p188: string, p189: number?) -- Line: 54
    -- upvalues: u186 (copy), InventoryService (copy)
    local v190 = p189 or (u186 or 1);
    local v191 = InventoryService:Find(p187, p188);
    local _, v192 = next(v191);

    if not v192 then
        InventoryService:CreateItem(p187, p188, {
            Uses = v190
        });

        return;
    end;

    local ItemData = v192.ItemData;
    ItemData.Uses = ItemData.Uses + v190;
end;

local u193 = 1;

u137["Pet Name Reroller"] = function(p194: userdata, p195: string, p196: number?) -- Line: 54
    -- upvalues: u193 (copy), InventoryService (copy)
    local v197 = p196 or (u193 or 1);
    local v198 = InventoryService:Find(p194, p195);
    local _, v199 = next(v198);

    if not v199 then
        InventoryService:CreateItem(p194, p195, {
            Uses = v197
        });

        return;
    end;

    local ItemData = v199.ItemData;
    ItemData.Uses = ItemData.Uses + v197;
end;

local u200 = 1;

u137["Grow All"] = function(p201: userdata, p202: string, p203: number?) -- Line: 54
    -- upvalues: u200 (copy), InventoryService (copy)
    local v204 = p203 or (u200 or 1);
    local v205 = InventoryService:Find(p201, p202);
    local _, v206 = next(v205);

    if not v206 then
        InventoryService:CreateItem(p201, p202, {
            Uses = v204
        });

        return;
    end;

    local ItemData = v206.ItemData;
    ItemData.Uses = ItemData.Uses + v204;
end;

local u207 = 1;

function u137.Steal(p208: userdata, p209: string, p210: number?) -- Line: 54
    -- upvalues: u207 (copy), InventoryService (copy)
    local v211 = p210 or (u207 or 1);
    local v212 = InventoryService:Find(p208, p209);
    local _, v213 = next(v212);

    if not v213 then
        InventoryService:CreateItem(p208, p209, {
            Uses = v211
        });

        return;
    end;

    local ItemData = v213.ItemData;
    ItemData.Uses = ItemData.Uses + v211;
end;

local u214 = 1;

u137["Firefly Jar"] = function(p215: userdata, p216: string, p217: number?) -- Line: 54
    -- upvalues: u214 (copy), InventoryService (copy)
    local v218 = p217 or (u214 or 1);
    local v219 = InventoryService:Find(p215, p216);
    local _, v220 = next(v219);

    if not v220 then
        InventoryService:CreateItem(p215, p216, {
            Uses = v218
        });

        return;
    end;

    local ItemData = v220.ItemData;
    ItemData.Uses = ItemData.Uses + v218;
end;

local u221 = 1;

u137["Sky Lantern"] = function(p222: userdata, p223: string, p224: number?) -- Line: 54
    -- upvalues: u221 (copy), InventoryService (copy)
    local v225 = p224 or (u221 or 1);
    local v226 = InventoryService:Find(p222, p223);
    local _, v227 = next(v226);

    if not v227 then
        InventoryService:CreateItem(p222, p223, {
            Uses = v225
        });

        return;
    end;

    local ItemData = v227.ItemData;
    ItemData.Uses = ItemData.Uses + v225;
end;

local u228 = 1;

u137["Maple Leaf Kite"] = function(p229: userdata, p230: string, p231: number?) -- Line: 54
    -- upvalues: u228 (copy), InventoryService (copy)
    local v232 = p231 or (u228 or 1);
    local v233 = InventoryService:Find(p229, p230);
    local _, v234 = next(v233);

    if not v234 then
        InventoryService:CreateItem(p229, p230, {
            Uses = v232
        });

        return;
    end;

    local ItemData = v234.ItemData;
    ItemData.Uses = ItemData.Uses + v232;
end;

local u235 = 1;

u137["Maple Syrup"] = function(p236: userdata, p237: string, p238: number?) -- Line: 54
    -- upvalues: u235 (copy), InventoryService (copy)
    local v239 = p238 or (u235 or 1);
    local v240 = InventoryService:Find(p236, p237);
    local _, v241 = next(v240);

    if not v241 then
        InventoryService:CreateItem(p236, p237, {
            Uses = v239
        });

        return;
    end;

    local ItemData = v241.ItemData;
    ItemData.Uses = ItemData.Uses + v239;
end;

local u242 = 1;

u137["Maple Leaf Charm"] = function(p243: userdata, p244: string, p245: number?) -- Line: 54
    -- upvalues: u242 (copy), InventoryService (copy)
    local v246 = p245 or (u242 or 1);
    local v247 = InventoryService:Find(p243, p244);
    local _, v248 = next(v247);

    if not v248 then
        InventoryService:CreateItem(p243, p244, {
            Uses = v246
        });

        return;
    end;

    local ItemData = v248.ItemData;
    ItemData.Uses = ItemData.Uses + v246;
end;

local u249 = 1;

u137["Maple Sprinkler"] = function(p250: userdata, p251: string, p252: number?) -- Line: 54
    -- upvalues: u249 (copy), InventoryService (copy)
    local v253 = p252 or (u249 or 1);
    local v254 = InventoryService:Find(p250, p251);
    local _, v255 = next(v254);

    if not v255 then
        InventoryService:CreateItem(p250, p251, {
            Uses = v253
        });

        return;
    end;

    local ItemData = v255.ItemData;
    ItemData.Uses = ItemData.Uses + v253;
end;

local u256 = 1;

function u137.Bonfire(p257: userdata, p258: string, p259: number?) -- Line: 54
    -- upvalues: u256 (copy), InventoryService (copy)
    local v260 = p259 or (u256 or 1);
    local v261 = InventoryService:Find(p257, p258);
    local _, v262 = next(v261);

    if not v262 then
        InventoryService:CreateItem(p257, p258, {
            Uses = v260
        });

        return;
    end;

    local ItemData = v262.ItemData;
    ItemData.Uses = ItemData.Uses + v260;
end;

local u263 = 1;

u137["Harvest Basket"] = function(p264: userdata, p265: string, p266: number?) -- Line: 54
    -- upvalues: u263 (copy), InventoryService (copy)
    local v267 = p266 or (u263 or 1);
    local v268 = InventoryService:Find(p264, p265);
    local _, v269 = next(v268);

    if not v269 then
        InventoryService:CreateItem(p264, p265, {
            Uses = v267
        });

        return;
    end;

    local ItemData = v269.ItemData;
    ItemData.Uses = ItemData.Uses + v267;
end;

local u270 = 1;

u137["Golden Acorn"] = function(p271: userdata, p272: string, p273: number?) -- Line: 54
    -- upvalues: u270 (copy), InventoryService (copy)
    local v274 = p273 or (u270 or 1);
    local v275 = InventoryService:Find(p271, p272);
    local _, v276 = next(v275);

    if not v276 then
        InventoryService:CreateItem(p271, p272, {
            Uses = v274
        });

        return;
    end;

    local ItemData = v276.ItemData;
    ItemData.Uses = ItemData.Uses + v274;
end;

local u277 = 1;

function u137.Rake(p278: userdata, p279: string, p280: number?) -- Line: 54
    -- upvalues: u277 (copy), InventoryService (copy)
    local v281 = p280 or (u277 or 1);
    local v282 = InventoryService:Find(p278, p279);
    local _, v283 = next(v282);

    if not v283 then
        InventoryService:CreateItem(p278, p279, {
            Uses = v281
        });

        return;
    end;

    local ItemData = v283.ItemData;
    ItemData.Uses = ItemData.Uses + v281;
end;

local u284 = 1;

u137["Acorn Bell"] = function(p285: userdata, p286: string, p287: number?) -- Line: 54
    -- upvalues: u284 (copy), InventoryService (copy)
    local v288 = p287 or (u284 or 1);
    local v289 = InventoryService:Find(p285, p286);
    local _, v290 = next(v289);

    if not v290 then
        InventoryService:CreateItem(p285, p286, {
            Uses = v288
        });

        return;
    end;

    local ItemData = v290.ItemData;
    ItemData.Uses = ItemData.Uses + v288;
end;

local u291 = 1;

u137["Super Watering Can"] = function(p292: userdata, p293: string, p294: number?) -- Line: 54
    -- upvalues: u291 (copy), InventoryService (copy)
    local v295 = p294 or (u291 or 1);
    local v296 = InventoryService:Find(p292, p293);
    local _, v297 = next(v296);

    if not v297 then
        InventoryService:CreateItem(p292, p293, {
            Uses = v295
        });

        return;
    end;

    local ItemData = v297.ItemData;
    ItemData.Uses = ItemData.Uses + v295;
end;

local u298 = 1;

function u137.Frightwork(p299: userdata, p300: string, p301: number?) -- Line: 54
    -- upvalues: u298 (copy), InventoryService (copy)
    local v302 = p301 or (u298 or 1);
    local v303 = InventoryService:Find(p299, p300);
    local _, v304 = next(v303);

    if not v304 then
        InventoryService:CreateItem(p299, p300, {
            Uses = v302
        });

        return;
    end;

    local ItemData = v304.ItemData;
    ItemData.Uses = ItemData.Uses + v302;
end;

local u305 = 1;

u137["Christmas Firework"] = function(p306: userdata, p307: string, p308: number?) -- Line: 54
    -- upvalues: u305 (copy), InventoryService (copy)
    local v309 = p308 or (u305 or 1);
    local v310 = InventoryService:Find(p306, p307);
    local _, v311 = next(v310);

    if not v311 then
        InventoryService:CreateItem(p306, p307, {
            Uses = v309
        });

        return;
    end;

    local ItemData = v311.ItemData;
    ItemData.Uses = ItemData.Uses + v309;
end;

local u312 = 1;

u137["New Year\'s Firework"] = function(p313: userdata, p314: string, p315: number?) -- Line: 54
    -- upvalues: u312 (copy), InventoryService (copy)
    local v316 = p315 or (u312 or 1);
    local v317 = InventoryService:Find(p313, p314);
    local _, v318 = next(v317);

    if not v318 then
        InventoryService:CreateItem(p313, p314, {
            Uses = v316
        });

        return;
    end;

    local ItemData = v318.ItemData;
    ItemData.Uses = ItemData.Uses + v316;
end;

u137["Leaf Blower"] = function(p319: userdata, p320: string, p321: number?) -- Line: 451
    -- upvalues: InventoryService (copy)
    local v322 = p321 or 1;
    local v323 = InventoryService:Find(p319, "Leaf Blower");
    local _, v324 = next(v323);

    if not v324 then
        InventoryService:CreateItem(p319, "Leaf Blower", {
            PowerRemaining = 100,
            Uses = v322
        });

        return;
    end;

    local ItemData = v324.ItemData;
    ItemData.Uses = ItemData.Uses + v322;
end;

u137["Super Leaf Blower"] = function(p325: userdata, p326: string, p327: number?) -- Line: 467
    -- upvalues: InventoryService (copy)
    local v328 = p327 or 1;
    local v329 = InventoryService:Find(p325, "Super Leaf Blower");
    local _, v330 = next(v329);

    if not v330 then
        InventoryService:CreateItem(p325, "Super Leaf Blower", {
            PowerRemaining = 125,
            Uses = v328
        });

        return;
    end;

    local ItemData = v330.ItemData;
    ItemData.Uses = ItemData.Uses + v328;
end;

u137["Sheckles Gun"] = function(p331: userdata, p332: string, p333: number?) -- Line: 483
    -- upvalues: InventoryService (copy)
    local v334 = p333 or 1;
    local v335 = InventoryService:Find(p331, "Sheckles Gun");
    local _, v336 = next(v335);

    if not v336 then
        InventoryService:CreateItem(p331, "Sheckles Gun", {
            PowerRemaining = 100,
            Uses = v334
        });

        return;
    end;

    local ItemData = v336.ItemData;
    ItemData.Uses = ItemData.Uses + v334;
end;

u137["Garden Guide"] = function(p337: userdata, p338: string, p339: number?) -- Line: 500
    -- upvalues: InventoryService (copy)
    local v340 = InventoryService:Find(p337, "Firework");
    local _, _ = next(v340);
    InventoryService:CreateItem(p337, "Garden Guide", {});
end;

u137["Bean Speaker"] = function(p341: userdata, p342: string, p343: number?) -- Line: 509
    -- upvalues: InventoryService (copy)
    local v344 = p343 or 5;
    local v345 = InventoryService:Find(p341, "Bean Speaker");
    local _, v346 = next(v345);

    if not v346 then
        InventoryService:CreateItem(p341, "Bean Speaker", {
            Uses = v344
        });

        return;
    end;

    local ItemData = v346.ItemData;
    ItemData.Uses = ItemData.Uses + v344;
end;

function u137.Beanworks(p347: userdata, p348: string, p349: number?) -- Line: 523
    -- upvalues: InventoryService (copy)
    local v350 = p349 or 1;
    local v351 = InventoryService:Find(p347, "Beanworks");
    local _, v352 = next(v351);

    if not v352 then
        InventoryService:CreateItem(p347, "Beanworks", {
            Uses = v350
        });

        return;
    end;

    local ItemData = v352.ItemData;
    ItemData.Uses = ItemData.Uses + v350;
end;

u137["Can Of Beans"] = function(p353: userdata, p354: string, p355: number?) -- Line: 538
    -- upvalues: InventoryService (copy)
    local v356 = p355 or 1;
    local v357 = InventoryService:Find(p353, "Can Of Beans");
    local _, v358 = next(v357);

    if not v358 then
        InventoryService:CreateItem(p353, "Can Of Beans", {
            Uses = v356
        });

        return;
    end;

    local ItemData = v358.ItemData;
    ItemData.Uses = ItemData.Uses + v356;
end;

u137["Pet Lead"] = function(p359: userdata, p360: string, p361: number?) -- Line: 553
    -- upvalues: InventoryService (copy)
    local v362 = p361 or 1;
    local v363 = InventoryService:Find(p359, "Pet Lead");
    local _, v364 = next(v363);

    if not v364 then
        InventoryService:CreateItem(p359, "Pet Lead", {
            Uses = v362
        });

        return;
    end;

    local ItemData = v364.ItemData;
    ItemData.Uses = ItemData.Uses + v362;
end;

u137["Rainbow Coil"] = function(p365: userdata, p366: string, p367: number?) -- Line: 569
    -- upvalues: InventoryService (copy)
    local v368 = InventoryService:Find(p365, "Rainbow Coil");

    if next(v368) then
        return;
    end;

    InventoryService:CreateItem(p365, "Rainbow Coil", {});
end;

u137["Golden Coil"] = function(p369: userdata, p370: string, p371: number?) -- Line: 575
    -- upvalues: InventoryService (copy)
    local v372 = InventoryService:Find(p369, "Golden Coil");

    if next(v372) then
        return;
    end;

    InventoryService:CreateItem(p369, "Golden Coil", {});
end;

u137["Inferno Shard"] = function(p373: userdata, p374: string, p375: number?) -- Line: 582
    -- upvalues: InventoryService (copy)
    local v376 = p375 or 1;
    local v377 = InventoryService:Find(p373, "Inferno Shard");
    local v378, v379 = next(v377);
    print("GIVE ATTEMPT", v377, v378, v379);

    if not v379 then
        InventoryService:CreateItem(p373, "Inferno Shard", {
            Uses = v376
        });

        return;
    end;

    local ItemData = v379.ItemData;
    ItemData.Uses = ItemData.Uses + v376;
end;

local v380 = {};

for i, v in require(ServerScriptService.Modules.Gears.GenericGearService).GearCallbacks do
    if not u137[i] then
        if v.GearType == "SingleUse" then
            local u381 = v.DefaultIncrease or 1;

            u137[i] = function(p382: userdata, p383: string, p384: number?) -- Line: 54
                -- upvalues: u381 (copy), InventoryService (copy)
                local v385 = p384 or (u381 or 1);
                local v386 = InventoryService:Find(p382, p383);
                local _, v387 = next(v386);

                if not v387 then
                    InventoryService:CreateItem(p382, p383, {
                        Uses = v385
                    });

                    return;
                end;

                local ItemData = v387.ItemData;
                ItemData.Uses = ItemData.Uses + v385;
            end;
        elseif v.GearType == "HoldUse" then
            local u388 = v.DefaultIncrease or 1;
            local u389 = v.StartingPower or 100;

            u137[i] = function(p390: userdata, p391: string, p392: number?) -- Line: 98
                -- upvalues: u388 (copy), u389 (ref), InventoryService (copy)
                local v393 = p392 or (u388 or 1);
                u389 = u389 or 100;
                local v394 = InventoryService:Find(p390, p391);
                local _, v395 = next(v394);

                if not v395 then
                    InventoryService:CreateItem(p390, p391, {
                        Uses = v393,
                        PowerRemaining = u389
                    });

                    return;
                end;

                local ItemData = v395.ItemData;
                ItemData.Uses = ItemData.Uses + v393;
            end;
        elseif v.GearType == "Placeable" then
            local u396 = v.DefaultIncrease or 1;

            u137[i] = function(p397: userdata, p398: string, p399: number?) -- Line: 117
                -- upvalues: u396 (copy), InventoryService (copy)
                local v400 = p399 or (u396 or 1);
                local v401 = InventoryService:Find(p397, p398);
                local _, v402 = next(v401);

                if not v402 then
                    InventoryService:CreateItem(p397, p398, {
                        ItemName = p398,
                        Uses = v400
                    });

                    return;
                end;

                local ItemData = v402.ItemData;
                ItemData.Uses = ItemData.Uses + v400;
            end;
        end;
    end;
end;

for _, child in ObjectModels:GetChildren() do
    local Name = child.Name;
    local v403 = Name:find("Sprinkler");
    local v404 = Name:find("Lightning Rod");
    local v405 = Name:find("Night Staff");
    local v406 = Name:find("Tranquil Staff");
    local v407 = Name:find("Corrupt Staff");
    local v408 = Name:find("Star Caller");
    local v409 = Name:find("Nectar Staff");
    local v410 = Name:find("Fairy Targeter");
    local v411 = Name:find("Bonfire");
    local v412 = Name:find("Moon Staff");

    if v403 then
        u137[Name] = function(p413: userdata, u414: string, p415: number?) -- Line: 629
            -- upvalues: InventoryService (copy)
            local v416 = p415 or 1;
            local v418 = InventoryService:Find(p413, "Sprinkler", function(p417) -- Line: 636
                -- upvalues: u414 (copy)
                return p417.ItemName and p417.ItemName == u414 and true or false;
            end);
            local _, v419 = next(v418);

            if not v419 then
                InventoryService:CreateItem(p413, "Sprinkler", {
                    ItemName = u414,
                    Uses = v416
                });

                return;
            end;

            if not v419.ItemData.Uses then
                v419.ItemData.Uses = 1;
            end;

            local ItemData = v419.ItemData;
            ItemData.Uses = ItemData.Uses + v416;
        end;
    elseif v404 then
        local u420 = "Lightning Rod";

        u137[Name] = function(p421: userdata, u422: string, p423: number?) -- Line: 74
            -- upvalues: InventoryService (copy), u420 (copy)
            local v424 = p423 or 1;
            local v426 = InventoryService:Find(p421, u420, function(p425) -- Line: 77
                -- upvalues: u422 (copy)
                return p425.ItemName == u422;
            end);
            local _, v427 = next(v426);

            if not v427 then
                InventoryService:CreateItem(p421, u420, {
                    ItemName = u422,
                    Uses = v424
                });

                return;
            end;

            if not v427.ItemData.Uses then
                v427.ItemData.Uses = 1;
            end;

            local ItemData = v427.ItemData;
            ItemData.Uses = ItemData.Uses + v424;
        end;
    elseif v409 then
        local u428 = "Nectar Staff";

        u137[Name] = function(p429: userdata, u430: string, p431: number?) -- Line: 74
            -- upvalues: InventoryService (copy), u428 (copy)
            local v432 = p431 or 1;
            local v434 = InventoryService:Find(p429, u428, function(p433) -- Line: 77
                -- upvalues: u430 (copy)
                return p433.ItemName == u430;
            end);
            local _, v435 = next(v434);

            if not v435 then
                InventoryService:CreateItem(p429, u428, {
                    ItemName = u430,
                    Uses = v432
                });

                return;
            end;

            if not v435.ItemData.Uses then
                v435.ItemData.Uses = 1;
            end;

            local ItemData = v435.ItemData;
            ItemData.Uses = ItemData.Uses + v432;
        end;
    elseif v405 then
        local u436 = "Night Staff";

        u137[Name] = function(p437: userdata, u438: string, p439: number?) -- Line: 74
            -- upvalues: InventoryService (copy), u436 (copy)
            local v440 = p439 or 1;
            local v442 = InventoryService:Find(p437, u436, function(p441) -- Line: 77
                -- upvalues: u438 (copy)
                return p441.ItemName == u438;
            end);
            local _, v443 = next(v442);

            if not v443 then
                InventoryService:CreateItem(p437, u436, {
                    ItemName = u438,
                    Uses = v440
                });

                return;
            end;

            if not v443.ItemData.Uses then
                v443.ItemData.Uses = 1;
            end;

            local ItemData = v443.ItemData;
            ItemData.Uses = ItemData.Uses + v440;
        end;
    elseif v406 then
        local u444 = "Tranquil Staff";

        u137[Name] = function(p445: userdata, u446: string, p447: number?) -- Line: 74
            -- upvalues: InventoryService (copy), u444 (copy)
            local v448 = p447 or 1;
            local v450 = InventoryService:Find(p445, u444, function(p449) -- Line: 77
                -- upvalues: u446 (copy)
                return p449.ItemName == u446;
            end);
            local _, v451 = next(v450);

            if not v451 then
                InventoryService:CreateItem(p445, u444, {
                    ItemName = u446,
                    Uses = v448
                });

                return;
            end;

            if not v451.ItemData.Uses then
                v451.ItemData.Uses = 1;
            end;

            local ItemData = v451.ItemData;
            ItemData.Uses = ItemData.Uses + v448;
        end;
    elseif v407 then
        local u452 = "Corrupt Staff";

        u137[Name] = function(p453: userdata, u454: string, p455: number?) -- Line: 74
            -- upvalues: InventoryService (copy), u452 (copy)
            local v456 = p455 or 1;
            local v458 = InventoryService:Find(p453, u452, function(p457) -- Line: 77
                -- upvalues: u454 (copy)
                return p457.ItemName == u454;
            end);
            local _, v459 = next(v458);

            if not v459 then
                InventoryService:CreateItem(p453, u452, {
                    ItemName = u454,
                    Uses = v456
                });

                return;
            end;

            if not v459.ItemData.Uses then
                v459.ItemData.Uses = 1;
            end;

            local ItemData = v459.ItemData;
            ItemData.Uses = ItemData.Uses + v456;
        end;
    elseif v408 then
        local u460 = "Star Caller";

        u137[Name] = function(p461: userdata, u462: string, p463: number?) -- Line: 74
            -- upvalues: InventoryService (copy), u460 (copy)
            local v464 = p463 or 1;
            local v466 = InventoryService:Find(p461, u460, function(p465) -- Line: 77
                -- upvalues: u462 (copy)
                return p465.ItemName == u462;
            end);
            local _, v467 = next(v466);

            if not v467 then
                InventoryService:CreateItem(p461, u460, {
                    ItemName = u462,
                    Uses = v464
                });

                return;
            end;

            if not v467.ItemData.Uses then
                v467.ItemData.Uses = 1;
            end;

            local ItemData = v467.ItemData;
            ItemData.Uses = ItemData.Uses + v464;
        end;
    elseif v410 then
        local u468 = "Fairy Targeter";

        u137[Name] = function(p469: userdata, u470: string, p471: number?) -- Line: 74
            -- upvalues: InventoryService (copy), u468 (copy)
            local v472 = p471 or 1;
            local v474 = InventoryService:Find(p469, u468, function(p473) -- Line: 77
                -- upvalues: u470 (copy)
                return p473.ItemName == u470;
            end);
            local _, v475 = next(v474);

            if not v475 then
                InventoryService:CreateItem(p469, u468, {
                    ItemName = u470,
                    Uses = v472
                });

                return;
            end;

            if not v475.ItemData.Uses then
                v475.ItemData.Uses = 1;
            end;

            local ItemData = v475.ItemData;
            ItemData.Uses = ItemData.Uses + v472;
        end;
    elseif v411 then
        local u476 = "Bonfire";

        u137[Name] = function(p477: userdata, u478: string, p479: number?) -- Line: 74
            -- upvalues: InventoryService (copy), u476 (copy)
            local v480 = p479 or 1;
            local v482 = InventoryService:Find(p477, u476, function(p481) -- Line: 77
                -- upvalues: u478 (copy)
                return p481.ItemName == u478;
            end);
            local _, v483 = next(v482);

            if not v483 then
                InventoryService:CreateItem(p477, u476, {
                    ItemName = u478,
                    Uses = v480
                });

                return;
            end;

            if not v483.ItemData.Uses then
                v483.ItemData.Uses = 1;
            end;

            local ItemData = v483.ItemData;
            ItemData.Uses = ItemData.Uses + v480;
        end;
    elseif v412 then
        local u484 = "Moon Staff";

        u137[Name] = function(p485: userdata, u486: string, p487: number?) -- Line: 74
            -- upvalues: InventoryService (copy), u484 (copy)
            local v488 = p487 or 1;
            local v490 = InventoryService:Find(p485, u484, function(p489) -- Line: 77
                -- upvalues: u486 (copy)
                return p489.ItemName == u486;
            end);
            local _, v491 = next(v490);

            if not v491 then
                InventoryService:CreateItem(p485, u484, {
                    ItemName = u486,
                    Uses = v488
                });

                return;
            end;

            if not v491.ItemData.Uses then
                v491.ItemData.Uses = 1;
            end;

            local ItemData = v491.ItemData;
            ItemData.Uses = ItemData.Uses + v488;
        end;
    end;
end;

for _, child in FriendshipPots:GetChildren() do
    u137[child.Name] = function(p492: userdata, p493: string, p494: number?) -- Line: 679
        -- upvalues: FriendshipPotToolService (copy), child (copy)
        FriendshipPotToolService:GivePot(p492, child.Name, p494);
    end;
end;

for _, child in SprayBottles:GetChildren() do
    if child.Name == "Mutation Spray" then
        local u495 = child;

        for i, _ in MutationNames do
            u137[`{u495.Name} {i}`] = function(p496: userdata, p497: string, p498: number?) -- Line: 688
                -- upvalues: SprayService (copy), u495 (copy), i (copy)
                SprayService:GiveSpray(p496, u495.Name, p498, {
                    SprayMutationName = i
                });
            end;
        end;
    else
        u137[child.Name] = function(p499: userdata, p500: string, p501: number?) -- Line: 693
            -- upvalues: SprayService (copy), child (copy)
            SprayService:GiveSpray(p499, child.Name, p501);
        end;
    end;
end;

for _, v in Item_Module.VariantNames do
    if v ~= "Normal" and v ~= "" then
        u137[`{v} Fertilizer`] = function(p502: userdata, p503: string, p504: number?) -- Line: 704
            -- upvalues: FertilizerService (copy), v (copy)
            FertilizerService:GiveFertilizer(p502, "Variant", p504, {
                FertilizerVariantName = v
            });
        end;
    end;
end;

for _, child in BeeEggs:GetChildren() do
    u137[child.Name] = function(p505: userdata, p506: string, p507: number?) -- Line: 711
        -- upvalues: BeeEggService (copy), child (copy)
        BeeEggService:GiveBeeEgg(p505, child.Name, p507);
    end;
end;

for _, child in v1:GetChildren() do
    u137[`Food {child.Name}`] = function(p508: userdata, p509: string, p510: number?) -- Line: 718
        -- upvalues: InventoryService (copy), child (copy)
        InventoryService:CreateItem(p508, "Food", {
            ItemName = child.Name
        });
    end;
end;

for _, child in PetBoosts:GetChildren() do
    local Attribute = child:GetAttribute("PetBoostType");
    local Attribute2 = child:GetAttribute("PetBoostCapacity");

    if not Attribute then
        error("Give_Gear [petboost] | invalid pet boost type");
    end;

    if not Attribute2 then
        error("Give_Gear [petboost] | invalid capacity");
    end;

    u137[`{Attribute2} {PetBoostRegistry.BoostTypeToPetModelName[Attribute]}`] = function(p511: userdata, p512: string, p513: number?) -- Line: 740
        -- upvalues: ServerScriptService (copy), Attribute (copy), Attribute2 (copy)
        require(ServerScriptService.Modules.PetsServices.PetBoostService):GivePetBoost(p511, Attribute, Attribute2, p513);
    end;
end;

for _, child in PetShards:GetChildren() do
    if child.Name == "Cleansing Pet Shard" then
        u137[child.Name] = function(p514: userdata, p515: string, p516: number?) -- Line: 750
            -- upvalues: PetShardService (copy), child (copy)
            PetShardService:GiveShard(p514, child.Name, p516);
        end;
    else
        local u517 = child;

        for i, _ in MutationNames2 do
            u137[`{u517.Name} {i}`] = function(p518: userdata, p519: string, p520: number?) -- Line: 755
                -- upvalues: PetShardService (copy), u517 (copy), i (copy)
                PetShardService:GiveShard(p518, u517.Name, p520, {
                    ShardMutationName = i
                });
            end;
        end;
    end;
end;

function v380.Give_Gear(p521: userdata, p522: string, p523: number?) -- Line: 768
    -- upvalues: u137 (copy), Players (copy)
    local v524 = u137[p522];

    if not v524 then
        warn((`Give_Gear | no handler registered for gear "{p522}"`));

        return false;
    end;

    local v525 = 0;
    local v526 = false;

    while not (p521.Character and p521.Character.PrimaryPart) do
        if not p521:IsDescendantOf(Players) then
            return false;
        end;

        v525 = v525 + task.wait();

        if not v526 and v525 >= 60 then
            warn((`Give_Gear | "{p522}" for {p521.Name}: still no character after {60}s`));
            v526 = true;
        end;
    end;

    v524(p521, p522, p523);

    return true;
end;

return v380;