-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
local v1 = RunService:IsServer() and ServerStorage:WaitForChild("Cosmetics") or Instance.new("Folder");
local CreateHitBoxFor = require(ReplicatedStorage.Modules.CreateHitBoxFor);
local v2 = {
    SeedEventCraftingWorkBench = {
        Description = "SeedEventCraftingWorkBench",
        Rarity = "Prismatic",
        Icon = "rbxassetid://0",
        Undeletable = true,
        Model = v1:FindFirstChild("SeedEventCraftingWorkBench"),
        Actions = {},
        Tags = { "MACHINE" }
    },
    ["Monster Mash Trophy"] = {
        Description = "Monster Mash Trophy gained by participating in the WORLD RECORD monster mash!",
        Rarity = "Prismatic",
        Icon = "rbxassetid://77599265819344",
        Undeletable = true,
        Model = v1:FindFirstChild("Monster Mash Trophy"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Grilled Moon Lit Owl"] = {
        Description = "R.I.P. little birdy",
        Rarity = "Mythical",
        Icon = "rbxassetid://102528497739104",
        Model = v1:FindFirstChild("Grilled Moon Lit Owl"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Jump Pad"] = {
        Description = "You completed the obby!",
        Rarity = "Prismatic",
        Icon = "rbxassetid://86613236531689",
        Model = v1:FindFirstChild("Jump Pad"),
        Actions = {},
        Tags = { "MISC", "UTILITY" }
    },
    ["Yellow Umbrella"] = {
        Description = "Sunshine on a stick.",
        Rarity = "Common",
        Icon = "rbxassetid://94314012476539",
        Model = v1:FindFirstChild("Yellow Umbrella"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Orange Umbrella"] = {
        Description = "Citrusy shade for sunny days.",
        Rarity = "Common",
        Icon = "rbxassetid://88274038012868",
        Model = v1:FindFirstChild("Orange Umbrella"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Brick Stack"] = {
        Description = "Stacked with brickstar power.",
        Rarity = "Common",
        Icon = "rbxassetid://128357565698061",
        Model = v1:FindFirstChild("Brick Stack"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Compost Bin"] = {
        Description = "Trash to treasure, garden edition.",
        Rarity = "Common",
        Icon = "rbxassetid://96378933887328",
        Model = v1:FindFirstChild("Compost Bin"),
        Actions = {},
        Tags = { "MISC" }
    },
    Log = {
        Description = "The OG garden decor.",
        Rarity = "Common",
        Icon = "rbxassetid://76301661478378",
        Model = v1:FindFirstChild("Log"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Rock Pile"] = {
        Description = "Rocks with sedimental value.",
        Rarity = "Common",
        Icon = "rbxassetid://115500068524301",
        Model = v1:FindFirstChild("Rock Pile"),
        Actions = {},
        Tags = { "MISC" }
    },
    Rake = {
        Description = "Tools with cult-ivation.",
        Rarity = "Common",
        Icon = "rbxassetid://112597085006662",
        Model = v1:FindFirstChild("Rake"),
        Actions = {},
        Tags = { "MISC" }
    },
    Shovel = {
        Description = "Tools with cult-ivation.",
        Rarity = "Common",
        Icon = "rbxassetid://91314518527541",
        Model = v1:FindFirstChild("Shovel"),
        Actions = {},
        Tags = { "MISC" }
    },
    Torch = {
        Description = "Light up the night—flamingly.",
        Rarity = "Common",
        Icon = "rbxassetid://138930375147694",
        Model = v1:FindFirstChild("Torch"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Red Pottery"] = {
        Description = "Clay-zy for garden decor.",
        Rarity = "Common",
        Icon = "rbxassetid://116715517791414",
        Model = v1:FindFirstChild("Red Pottery"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["White Pottery"] = {
        Description = "Clay-zy for garden decor.",
        Rarity = "Common",
        Icon = "rbxassetid://98046045828300",
        Model = v1:FindFirstChild("White Pottery"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wood Pile"] = {
        Description = "Logging some serious style points.",
        Rarity = "Common",
        Icon = "rbxassetid://123525466548522",
        Model = v1:FindFirstChild("Wood Pile"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Small Circle Tile"] = {
        Description = "Going in circles never looked so good.",
        Rarity = "Common",
        Icon = "rbxassetid://140549587097599",
        Model = v1:FindFirstChild("Small Circle Tile"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Medium Circle Tile"] = {
        Description = "Going in circles never looked so good.",
        Rarity = "Common",
        Icon = "rbxassetid://114920818848221",
        Model = v1:FindFirstChild("Medium Circle Tile"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Small Path Tile"] = {
        Description = "Pave the way to floral fame.",
        Rarity = "Common",
        Icon = "rbxassetid://115709059245481",
        Model = v1:FindFirstChild("Small Path Tile"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Medium Path Tile"] = {
        Description = "Pave the way to floral fame.",
        Rarity = "Common",
        Icon = "rbxassetid://71405070143013",
        Model = v1:FindFirstChild("Medium Path Tile"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Large Path Tile"] = {
        Description = "Pave the way to floral fame.",
        Rarity = "Common",
        Icon = "rbxassetid://85801904008201",
        Model = v1:FindFirstChild("Large Path Tile"),
        Actions = {},
        Tags = { "MISC" }
    },
    Duckfloat = {
        Description = "Ducky Floaty Hehe.",
        Rarity = "Rare",
        Icon = "rbxassetid://122002865494426",
        Model = v1:FindFirstChild("Duckfloat"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Axe Stump"] = {
        Description = "Chopped, but never forgotten.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://96264914166618",
        Model = v1:FindFirstChild("Axe Stump"),
        Actions = {},
        Tags = { "MISC" }
    },
    Bookshelf = {
        Description = "Grow your mind while your garden grows.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://115973373909016",
        Model = v1:FindFirstChild("Bookshelf"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Brown Bench"] = {
        Description = "Sit, stay, bloom.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://98910490474013",
        Model = v1:FindFirstChild("Brown Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Hay Bale"] = {
        Description = "Bale-out plan for bland gardens.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://87723268241453",
        Model = v1:FindFirstChild("Hay Bale"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Light On Ground"] = {
        Description = "Bright ideas start here.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://117164021377008",
        Model = v1:FindFirstChild("Light On Ground"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Log Bench"] = {
        Description = "Take a seat and branch out.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://70530203579288",
        Model = v1:FindFirstChild("Log Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Mini TV"] = {
        Description = "Binge-watch your plants grow.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://131992955716873",
        Model = v1:FindFirstChild("Mini TV"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Shovel Grave"] = {
        Description = "RIP, dear tool—you dug your last hole.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://120224305204338",
        Model = v1:FindFirstChild("Shovel Grave"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Small Stone Lantern"] = {
        Description = "Glow stoned.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://106313535982394",
        Model = v1:FindFirstChild("Small Stone Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Small Stone Pad"] = {
        Description = "Rock your garden\'s world.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://76334118664068",
        Model = v1:FindFirstChild("Small Stone Pad"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Large Stone Pad"] = {
        Description = "Rock your garden\'s world.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://136964060505236",
        Model = v1:FindFirstChild("Large Stone Pad"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Stone Lantern"] = {
        Description = "Glow stoned.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://119551465521930",
        Model = v1:FindFirstChild("Stone Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Viney Beam"] = {
        Description = "Nature\'s way of saying, \'Hang in there.\'",
        Rarity = "Uncommon",
        Icon = "rbxassetid://124170877039835",
        Model = v1:FindFirstChild("Viney Beam"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Water Trough"] = {
        Description = "Hydration station for your green nation.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://75910954482613",
        Model = v1:FindFirstChild("Water Trough"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["White Bench"] = {
        Description = "Sit, stay, bloom.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://84377225645349",
        Model = v1:FindFirstChild("White Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wood Fence"] = {
        Description = "Good fences make good gardeners.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://132290111901072",
        Model = v1:FindFirstChild("Wood Fence"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Small Wood Flooring"] = {
        Description = "Floors so nice, you wood not believe it.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://130831326552652",
        Model = v1:FindFirstChild("Small Wood Flooring"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Medium Wood Flooring"] = {
        Description = "Floors so nice, you wood not believe it.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://77772412695376",
        Model = v1:FindFirstChild("Medium Wood Flooring"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Large Wood Flooring"] = {
        Description = "Floors so nice, you wood not believe it.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://74406299280955",
        Model = v1:FindFirstChild("Large Wood Flooring"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Small Stone Table"] = {
        Description = "Dine rock-style.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://93138997640716",
        Model = v1:FindFirstChild("Small Stone Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Medium Stone Table"] = {
        Description = "Dine rock-style.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://83559202798747",
        Model = v1:FindFirstChild("Medium Stone Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Long Stone Table"] = {
        Description = "Dine rock-style.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://119328686937204",
        Model = v1:FindFirstChild("Long Stone Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Lamp Post"] = {
        Description = "Shine bright like a garden diamond.",
        Rarity = "Rare",
        Icon = "rbxassetid://138744299024719",
        Model = v1:FindFirstChild("Lamp Post"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bamboo Wind Chime"] = {
        Description = "Let the wind drop the beat.",
        Rarity = "Rare",
        Icon = "rbxassetid://78310105473480",
        Model = v1:FindFirstChild("Bamboo Wind Chime"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Metal Wind Chime"] = {
        Description = "Let the wind drop the beat.",
        Rarity = "Rare",
        Icon = "rbxassetid://111513959090645",
        Model = v1:FindFirstChild("Metal Wind Chime"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bird Bath"] = {
        Description = "A spa day for your feathered friends.",
        Rarity = "Rare",
        Icon = "rbxassetid://114210337316371",
        Model = v1:FindFirstChild("Bird Bath"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Brown Stone Pillar"] = {
        Description = "Pillars of rock-solid style.",
        Rarity = "Rare",
        Icon = "rbxassetid://80217593163027",
        Model = v1:FindFirstChild("Brown Stone Pillar"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Dark Stone Pillar"] = {
        Description = "Pillars of rock-solid style.",
        Rarity = "Rare",
        Icon = "rbxassetid://115143090894918",
        Model = v1:FindFirstChild("Dark Stone Pillar"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Grey Stone Pillar"] = {
        Description = "Pillars of rock-solid style.",
        Rarity = "Rare",
        Icon = "rbxassetid://108713406223798",
        Model = v1:FindFirstChild("Grey Stone Pillar"),
        Actions = {},
        Tags = { "MISC" }
    },
    Campfire = {
        Description = "For lit garden vibes.",
        Rarity = "Rare",
        Icon = "rbxassetid://114219794929389",
        Model = v1:FindFirstChild("Campfire"),
        Actions = {},
        Tags = { "MISC" }
    },
    Clothesline = {
        Description = "Hang your worries out to dry.",
        Rarity = "Rare",
        Icon = "rbxassetid://135426465898486",
        Model = v1:FindFirstChild("Clothesline"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cooking Pot"] = {
        Description = "Stirring up some botanical brews.",
        Rarity = "Rare",
        Icon = "rbxassetid://74493838787153",
        Model = v1:FindFirstChild("Cooking Pot"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Curved Canopy"] = {
        Description = "Shelter with arch-appeal.",
        Rarity = "Rare",
        Icon = "rbxassetid://140452365544446",
        Model = v1:FindFirstChild("Curved Canopy"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Flat Canopy"] = {
        Description = "Shelter with arch-appeal.",
        Rarity = "Rare",
        Icon = "rbxassetid://98042972289231",
        Model = v1:FindFirstChild("Flat Canopy"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Small Wood Arbour"] = {
        Description = "Walk this way—blossom that way.",
        Rarity = "Rare",
        Icon = "rbxassetid://101767783873802",
        Model = v1:FindFirstChild("Small Wood Arbour"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Square Metal Arbour"] = {
        Description = "Walk this way—blossom that way.",
        Rarity = "Rare",
        Icon = "rbxassetid://124482021450642",
        Model = v1:FindFirstChild("Square Metal Arbour"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Small Wood Table"] = {
        Description = "Gather \'round the stump speech.",
        Rarity = "Rare",
        Icon = "rbxassetid://79156265194662",
        Model = v1:FindFirstChild("Small Wood Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Large Wood Table"] = {
        Description = "Gather \'round the stump speech.",
        Rarity = "Rare",
        Icon = "rbxassetid://81844858986120",
        Model = v1:FindFirstChild("Large Wood Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    Wheelbarrow = {
        Description = "Hauling blooms and dad jokes since forever.",
        Rarity = "Rare",
        Icon = "rbxassetid://129661977849436",
        Model = v1:FindFirstChild("Wheelbarrow"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blue Well"] = {
        Description = "Make a wish—petals crossed!",
        Rarity = "Legendary",
        Icon = "rbxassetid://137217556459922",
        Model = v1:FindFirstChild("Blue Well"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Brown Well"] = {
        Description = "Make a wish—petals crossed!",
        Rarity = "Legendary",
        Icon = "rbxassetid://97081445435777",
        Model = v1:FindFirstChild("Brown Well"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Red Well"] = {
        Description = "Make a wish—petals crossed!",
        Rarity = "Legendary",
        Icon = "rbxassetid://100605398217067",
        Model = v1:FindFirstChild("Red Well"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Green Tractor"] = {
        Description = "Crop-tastic cruising.",
        Rarity = "Legendary",
        Icon = "rbxassetid://127815398735746",
        Model = v1:FindFirstChild("Green Tractor"),
        Actions = {},
        Tags = { "MACHINE" }
    },
    ["Red Tractor"] = {
        Description = "Crop-tastic cruising.",
        Rarity = "Legendary",
        Icon = "rbxassetid://88340270174678",
        Model = v1:FindFirstChild("Red Tractor"),
        Actions = {},
        Tags = { "MACHINE" }
    },
    ["Ring Walkway"] = {
        Description = "Walk in circles, but make it fashion.",
        Rarity = "Legendary",
        Icon = "rbxassetid://111450830262119",
        Model = v1:FindFirstChild("Ring Walkway"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Viney Ring Walkway"] = {
        Description = "Step into the vine zone.",
        Rarity = "Legendary",
        Icon = "rbxassetid://96399926163763",
        Model = v1:FindFirstChild("Viney Ring Walkway"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Large Wood Arbour"] = {
        Description = "Walk this way—blossom that way.",
        Rarity = "Legendary",
        Icon = "rbxassetid://114586442817919",
        Model = v1:FindFirstChild("Large Wood Arbour"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Round Metal Arbour"] = {
        Description = "Walk this way—blossom that way.",
        Rarity = "Legendary",
        Icon = "rbxassetid://104999736010025",
        Model = v1:FindFirstChild("Round Metal Arbour"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Frog Fountain"] = {
        Description = "Ribbit and relax.",
        Rarity = "Legendary",
        Icon = "rbxassetid://124446917752784",
        Model = v1:FindFirstChild("Frog Fountain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Arcade Machine"] = {
        Description = "A nostalgic money-eating box that promises endless fun and occasional finger cramps.",
        Rarity = "Legendary",
        Icon = "rbxassetid://80636317407905",
        Model = v1:FindFirstChild("ArcadeMachine"),
        Actions = {},
        Tags = { "MACHINE" }
    },
    ["Beach Towel Blue"] = {
        Description = "A portable sandy throne for your sunbathing empire.",
        Rarity = "Rare",
        Icon = "rbxassetid://99004531154140",
        Model = v1:FindFirstChild("BeachTowelBlue"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Beach Towel Pink"] = {
        Description = "A portable sandy throne for your sunbathing empire.",
        Rarity = "Rare",
        Icon = "rbxassetid://109969533331323",
        Model = v1:FindFirstChild("BeachTowelPink"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Beach Towel Red"] = {
        Description = "A portable sandy throne for your sunbathing empire.",
        Rarity = "Rare",
        Icon = "rbxassetid://107120167826878",
        Model = v1:FindFirstChild("BeachTowelRed"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Beach Towel Yellow"] = {
        Description = "A portable sandy throne for your sunbathing empire.",
        Rarity = "Rare",
        Icon = "rbxassetid://116055841484575",
        Model = v1:FindFirstChild("BeachTowelYellow"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bean Bag Toss Blue"] = {
        Description = "A portable sandy throne for your sunbathing empire.",
        Rarity = "Rare",
        Icon = "rbxassetid://131369979026921",
        Model = v1:FindFirstChild("BeanBagTossBlue"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bean Bag Toss Red"] = {
        Description = "A portable sandy throne for your sunbathing empire.",
        Rarity = "Rare",
        Icon = "rbxassetid://93045760456133",
        Model = v1:FindFirstChild("BeanBagTossRed"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blue Beach Ball"] = {
        Description = "A vibrant blue inflatable ball designed for fun and games at the beach or pool.",
        Rarity = "Rare",
        Icon = "rbxassetid://71837625336616",
        Model = v1:FindFirstChild("BlueBeachBall"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blue Cooler Chest"] = {
        Description = "Keeps your drinks perfectly chilled for those sunny hangouts with friends!",
        Rarity = "Rare",
        Icon = "rbxassetid://103573199416660",
        Model = v1:FindFirstChild("BlueCoolerChest"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pink Cooler Chest"] = {
        Description = "Keeps your drinks perfectly chilled for those sunny hangouts with friends!",
        Rarity = "Rare",
        Icon = "rbxassetid://100763899517565",
        Model = v1:FindFirstChild("PinkCoolerChest"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blue Popsicle"] = {
        Description = "A cool, sweet treat that’s perfect for beating the summer heat!",
        Rarity = "Rare",
        Icon = "rbxassetid://132544002490198",
        Model = v1:FindFirstChild("BluePopsicle"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blue Short Beach Chair"] = {
        Description = "Relax in style with this comfy, compact chair made for soaking up the sun by the shore!",
        Rarity = "Rare",
        Icon = "rbxassetid://106287089125606",
        Model = v1:FindFirstChild("BlueShortBeachChair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blue Beach Umbrella"] = {
        Description = "Stay cool and shaded while enjoying a day of fun under this breezy blue canopy!",
        Rarity = "Rare",
        Icon = "rbxassetid://95490603436919",
        Model = v1:FindFirstChild("Blue Beach Umbrella"),
        Actions = {},
        Tags = { "MISC" }
    },
    Cabana = {
        Description = "More shade than an umbrella",
        Rarity = "Legendary",
        Icon = "rbxassetid://122281158985851",
        Model = v1:FindFirstChild("Cabana"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Ice Cream Cart"] = {
        Description = "Never to cool for an ice cream",
        Rarity = "Mythical",
        Icon = "rbxassetid://73029854192902",
        Model = v1:FindFirstChild("IceCreamCart"),
        Actions = {},
        Tags = { "MACHINE" }
    },
    ["Lemonade Stand"] = {
        Description = "Who doesn\'t like a glass of fresh lemonade",
        Rarity = "Mythical",
        Icon = "rbxassetid://83319614843666",
        Model = v1:FindFirstChild("LemonadeStand"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Market Cart"] = {
        Description = "Always great prices!",
        Rarity = "Mythical",
        Icon = "rbxassetid://110100785748233",
        Model = v1:FindFirstChild("MarketCart"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Red Surf Board"] = {
        Description = "Great board to ride the waves, easy to see against the blue ocean",
        Rarity = "Rare",
        Icon = "rbxassetid://90176745523850",
        Model = v1:FindFirstChild("RedSurfBoard"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blue Surf Board"] = {
        Description = "Great board to ride the waves, not easy to see against the blue ocean",
        Rarity = "Rare",
        Icon = "rbxassetid://95460515956088",
        Model = v1:FindFirstChild("BlueSurfBoard"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Yellow Surf Board"] = {
        Description = "Great board to ride the waves, easy to see against the blue ocean",
        Rarity = "Rare",
        Icon = "rbxassetid://89453521848259",
        Model = v1:FindFirstChild("YellowSurfBoard"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pink Surf Board"] = {
        Description = "Great board to ride the waves, easy to see against the blue ocean",
        Rarity = "Rare",
        Icon = "rbxassetid://114981177780072",
        Model = v1:FindFirstChild("PinkSurfBoard"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pink Beach Ball"] = {
        Description = "A bright pink inflatable ball designed for fun and games at the beach or pool.",
        Rarity = "Rare",
        Icon = "rbxassetid://117179532514857",
        Model = v1:FindFirstChild("PinkBeachBall"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pink Popsicle"] = {
        Description = "A cool, sweet treat that’s perfect for beating the summer heat!",
        Rarity = "Rare",
        Icon = "rbxassetid://138395803583239",
        Model = v1:FindFirstChild("PinkPopsicle"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pink Short Beach Chair"] = {
        Description = "Relax in style with this comfy, compact chair made for soaking up the sun by the shore!",
        Rarity = "Rare",
        Icon = "rbxassetid://102436585837305",
        Model = v1:FindFirstChild("PinkShortBeachChair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pink Beach Umbrella"] = {
        Description = "Stay cool and shaded while enjoying a day of fun under this breezy pink canopy!",
        Rarity = "Rare",
        Icon = "rbxassetid://104654926646080",
        Model = v1:FindFirstChild("Pink Beach Umbrella"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Red Beach Ball"] = {
        Description = "A red inflatable ball designed for fun and games at the beach or pool.",
        Rarity = "Rare",
        Icon = "rbxassetid://80096178020566",
        Model = v1:FindFirstChild("RedBeachBall"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Red Cooler Chest"] = {
        Description = "Keeps your drinks perfectly chilled for those sunny hangouts with friends!",
        Rarity = "Rare",
        Icon = "rbxassetid://103299416006910",
        Model = v1:FindFirstChild("RedCoolerChest"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blue Hammock"] = {
        Description = "A great spot for a nap, now in blue!",
        Rarity = "Rare",
        Icon = "rbxassetid://94505677915520",
        Model = v1:FindFirstChild("BlueHammock"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Red Hammock"] = {
        Description = "A great spot for a nap, now in red!",
        Rarity = "Rare",
        Icon = "rbxassetid://82064982360485",
        Model = v1:FindFirstChild("RedHammock"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Red Long Beach Chair"] = {
        Description = "Now all we need is a beach.",
        Rarity = "Rare",
        Icon = "rbxassetid://88627619442635",
        Model = v1:FindFirstChild("RedLongBeachChair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Red Popsicle"] = {
        Description = "A cool, sweet treat that’s perfect for beating the summer heat!",
        Rarity = "Rare",
        Icon = "rbxassetid://120788253745071",
        Model = v1:FindFirstChild("RedPopsicle"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Red Short Beach Chair"] = {
        Description = "Relax in style with this comfy, compact chair made for soaking up the sun by the shore!",
        Rarity = "Rare",
        Icon = "rbxassetid://106546394681244",
        Model = v1:FindFirstChild("RedShortBeachChair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Red Beach Umbrella"] = {
        Description = "Stay cool and shaded while enjoying a day of fun under this red canopy!",
        Rarity = "Rare",
        Icon = "rbxassetid://136165125481786",
        Model = v1:FindFirstChild("Red Beach Umbrella"),
        Actions = {},
        Tags = { "MISC" }
    },
    Speakers = {
        Description = "Creates a lot of noise",
        Rarity = "Legendary",
        Icon = "rbxassetid://80430866675960",
        Model = v1:FindFirstChild("Speakers"),
        Actions = {},
        Tags = { "MACHINE" }
    },
    ["Tiki Bar"] = {
        Description = "The one stop place to get all your cool drinks and refreshments.",
        Rarity = "Mythical",
        Icon = "rbxassetid://106886101958316",
        Model = v1:FindFirstChild("TikiBar"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Volley Ball Net"] = {
        Description = "Great place to make use of all those beach balls",
        Rarity = "Legendary",
        Icon = "rbxassetid://129721262517254",
        Model = v1:FindFirstChild("VolleyBallNet"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Yellow Beach Ball"] = {
        Description = "A yellow inflatable ball designed for fun and games at the beach or pool.",
        Rarity = "Rare",
        Icon = "rbxassetid://136111379252509",
        Model = v1:FindFirstChild("YellowBeachBall"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Yellow Long Beach Chair"] = {
        Description = "Now all we need is a beach.",
        Rarity = "Rare",
        Icon = "rbxassetid://120486654324450",
        Model = v1:FindFirstChild("YellowLongBeachChair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Yellow Short Beach Chair"] = {
        Description = "Relax in style with this comfy, compact chair made for soaking up the sun by the shore!",
        Rarity = "Rare",
        Icon = "rbxassetid://95784261871354",
        Model = v1:FindFirstChild("YellowShortBeachChair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Yellow Beach Umbrella"] = {
        Description = "Stay cool and shaded while enjoying a day of fun under this yellow canopy!",
        Rarity = "Rare",
        Icon = "rbxassetid://72656459420319",
        Model = v1:FindFirstChild("Yellow Beach Umbrella"),
        Actions = {},
        Tags = { "MISC" }
    },
    Mower = {
        Description = "Not to be confused with the other Moa",
        Rarity = "Legendary",
        Icon = "rbxassetid://135914882416689",
        Model = v1:FindFirstChild("Mower"),
        Actions = {},
        Tags = { "MACHINE" }
    },
    ["Beta Gnome"] = {
        Description = "Crash test Gnomey.",
        Rarity = "Rare",
        Icon = "rbxassetid://82942574971091",
        Model = v1:FindFirstChild("BetaGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Green Gnome"] = {
        Description = "Gree-gnome.",
        Rarity = "Rare",
        Icon = "rbxassetid://114712911840962",
        Model = v1:FindFirstChild("GreenGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Blue Gnome"] = {
        Description = "No one hates blue!",
        Rarity = "Rare",
        Icon = "rbxassetid://126793677651227",
        Model = v1:FindFirstChild("BlueGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["No Trespassing Sign"] = {
        Description = "Sign here for sass.",
        Rarity = "Rare",
        Icon = "rbxassetid://111642019686941",
        Model = v1:FindFirstChild("NoTrespassingSign"),
        Actions = {},
        Tags = { "SIGN" }
    },
    ["Beware Of Dog Sign"] = {
        Description = "Sign here for sass.",
        Rarity = "Rare",
        Icon = "rbxassetid://89778210976821",
        Model = v1:FindFirstChild("BewareOfDogSign"),
        Actions = {},
        Tags = { "SIGN" }
    },
    ["Mean Gardener Sign"] = {
        Description = "Sign here for sass.",
        Rarity = "Rare",
        Icon = "rbxassetid://74001450966740",
        Model = v1:FindFirstChild("MeanGardenerSign"),
        Actions = {},
        Tags = { "SIGN" }
    },
    ["Keep Out Sign"] = {
        Description = "Sign here for sass.",
        Rarity = "Rare",
        Icon = "rbxassetid://137279504847698",
        Model = v1:FindFirstChild("KeepOutSign"),
        Actions = {},
        Tags = { "SIGN" }
    },
    ["Smile On Cam Sign"] = {
        Description = "Sign here for sass.",
        Rarity = "Rare",
        Icon = "rbxassetid://135786183918317",
        Model = v1:FindFirstChild("SmileOnCamSign"),
        Actions = {},
        Tags = { "SIGN" }
    },
    ["No Stealing Sign"] = {
        Description = "Sign here for sass.",
        Rarity = "Legendary",
        Icon = "rbxassetid://96708017956784",
        Model = v1:FindFirstChild("NoStealingSign"),
        Actions = {},
        Tags = { "SIGN" }
    },
    ["Sleepy Gnome"] = {
        Description = "Catching some zzzzeeds.",
        Rarity = "Rare",
        Icon = "rbxassetid://104198914328516",
        Model = v1:FindFirstChild("SleepyGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Silly Gnome"] = {
        Description = "If you wait long enough it\'ll do a backflip",
        Rarity = "Rare",
        Icon = "rbxassetid://85284169151224",
        Model = v1:FindFirstChild("SillyGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Crazy Gnome"] = {
        Description = "Gnome way out.",
        Rarity = "Rare",
        Icon = "rbxassetid://114913163768225",
        Model = v1:FindFirstChild("CrazyGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Grumpy Gnome"] = {
        Description = "You are gnot going to like me when grumpy!",
        Rarity = "Rare",
        Icon = "rbxassetid://113529246996386",
        Model = v1:FindFirstChild("GrumpyGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Fearless Gnome"] = {
        Description = "I AM LE-GNOME!",
        Rarity = "Legendary",
        Icon = "rbxassetid://71291637119739",
        Model = v1:FindFirstChild("FearlessGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    Roundabout = {
        Description = "Spin your garden drama away.",
        Rarity = "Legendary",
        Icon = "rbxassetid://127576228279994",
        Model = v1:FindFirstChild("Roundabout"),
        Actions = {},
        Tags = { "MISC" }
    },
    Seesaw = {
        Description = "Ups and downs, but make it playful.",
        Rarity = "Legendary",
        Icon = "rbxassetid://129298071024340",
        Model = v1:FindFirstChild("Seesaw"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Swing set"] = {
        Description = "Swinging into serenity.",
        Rarity = "Legendary",
        Icon = "rbxassetid://97650946469601",
        Model = v1:FindFirstChild("Swingset"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Red Flag"] = {
        Description = "Claim your petal territory.",
        Rarity = "Legendary",
        Icon = "rbxassetid://108826376055758",
        Model = v1:FindFirstChild("RedFlag"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blue Flag"] = {
        Description = "Claim your petal territory.",
        Rarity = "Legendary",
        Icon = "rbxassetid://86956824591443",
        Model = v1:FindFirstChild("BlueFlag"),
        Actions = {},
        Tags = { "MISC" }
    },
    Trampoline = {
        Description = "Bounce into botanical bliss.",
        Rarity = "Mythical",
        Icon = "rbxassetid://72039279547348",
        Model = v1:FindFirstChild("Trampoline"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Raphael Gnome"] = {
        Description = "A gnome of Raphael, owner of the pet stall!",
        Rarity = "Rare",
        Icon = "rbxassetid://83040285262266",
        Model = v1:FindFirstChild("RaphaelGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Steven Gnome"] = {
        Description = "A gnome of Steven, owner of the sell stall!",
        Rarity = "Rare",
        Icon = "rbxassetid://130945698778443",
        Model = v1:FindFirstChild("StevenGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Eloise Gnome"] = {
        Description = "A gnome of Eloise, owner of the gear shop!",
        Rarity = "Legendary",
        Icon = "rbxassetid://111228051132202",
        Model = v1:FindFirstChild("EloiseGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Sam Gnome"] = {
        Description = "A gnome of Sam, owner of the seed shop!",
        Rarity = "Legendary",
        Icon = "rbxassetid://120985613541798",
        Model = v1:FindFirstChild("SamGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Cleetus Gnome"] = {
        Description = "HOWDY!",
        Rarity = "Mythical",
        Icon = "rbxassetid://105475165224126",
        Model = v1:FindFirstChild("CleetusGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Builderman Gnome"] = {
        Description = "He will design a gnomenclature!",
        Rarity = "Mythical",
        Icon = "rbxassetid://112903384537909",
        Model = v1:FindFirstChild("BuildermanGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Bacon Gnome"] = {
        Description = "Cant get enough of (GNO)ME!",
        Rarity = "Mythical",
        Icon = "rbxassetid://120778286675384",
        Model = v1:FindFirstChild("BaconGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Zombie Gnome"] = {
        Description = "These are real zombie hours!",
        Rarity = "Mythical",
        Icon = "rbxassetid://133857140992876",
        Model = v1:FindFirstChild("ZombieGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Noob Gnome"] = {
        Description = "You as a gnome!",
        Rarity = "Mythical",
        Icon = "rbxassetid://98160377296946",
        Model = v1:FindFirstChild("NoobGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Gold Gnome"] = {
        Description = "You\'ve been golden gnomed!",
        Rarity = "Divine",
        Icon = "rbxassetid://107517587303429",
        Model = v1:FindFirstChild("GoldGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Female Scarecrow"] = {
        Description = "Scare the crows, charm the neighbors.",
        Rarity = "Rare",
        Icon = "rbxassetid://104939198269666",
        Model = v1:FindFirstChild("FemaleScarecrow"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Male Scarecrow"] = {
        Description = "Scare the crows, charm the neighbors.",
        Rarity = "Rare",
        Icon = "rbxassetid://135026002683202",
        Model = v1:FindFirstChild("MaleScarecrow"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Stone Mango Statue"] = {
        Description = "Rock solid style for your garden!",
        Rarity = "Legendary",
        Icon = "rbxassetid://91117322281959",
        Model = v1:FindFirstChild("StoneMangoStatue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Mossy Stone Blossom Statue"] = {
        Description = "Rock solid style for your garden!",
        Rarity = "Legendary",
        Icon = "rbxassetid://125324768942930",
        Model = v1:FindFirstChild("MossyStoneBlossomStatue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Stone Candy Blossom Statue"] = {
        Description = "Rock solid style for your garden!",
        Rarity = "Mythical",
        Icon = "rbxassetid://107207612180537",
        Model = v1:FindFirstChild("StoneCandyBlossomStatue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Stone Bunny Statue"] = {
        Description = "A stone bunny who’s been guarding gardens longer than anyone can remember.",
        Rarity = "Legendary",
        Icon = "rbxassetid://83622392226670",
        Model = v1:FindFirstChild("StoneBunnyStatue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Gold Pillar"] = {
        Description = "A shiny gold pillar, way too fancy for a vegetable patch.",
        Rarity = "Mythical",
        Icon = "rbxassetid://73954265276442",
        Model = v1:FindFirstChild("GoldPillar"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gold Fire Pit"] = {
        Description = "A dazzling firepit.",
        Rarity = "Mythical",
        Icon = "rbxassetid://138669093930760",
        Model = v1:FindFirstChild("GoldFirePit"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gold Torii"] = {
        Description = "A golden gateway that welcomes good vibes.",
        Rarity = "Divine",
        Icon = "rbxassetid://133029271065028",
        Model = v1:FindFirstChild("GoldTorii"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gold Water Fountain"] = {
        Description = "Golden water not included.",
        Rarity = "Divine",
        Icon = "rbxassetid://133358999373894",
        Model = v1:FindFirstChild("GoldWaterFountain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gold Candy Blossom Statue"] = {
        Description = "Rock solid style for your garden!",
        Rarity = "Divine",
        Icon = "rbxassetid://136237571582291",
        Model = v1:FindFirstChild("GoldCandyBlossomStatue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Platinum Candy Blossom Statue"] = {
        Description = "Rock solid style for your garden!",
        Rarity = "Prismatic",
        Icon = "rbxassetid://97698023241956",
        Model = v1:FindFirstChild("PlatinumCandyBlossomStatue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Twilight Ring Walkway"] = {
        Description = "Rock solid style for your garden!",
        Rarity = "Mythical",
        Icon = "rbxassetid://108295843838649",
        Model = v1:FindFirstChild("Twilight Ring Walkway"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Twilight Pillar"] = {
        Description = "Imbued with the moon\'s energy.",
        Rarity = "Mythical",
        Icon = "rbxassetid://76251994949545",
        Model = v1:FindFirstChild("Twilight Pillar"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Twilight Fence"] = {
        Description = "It shimmers with the light of the moon.",
        Rarity = "Mythical",
        Icon = "rbxassetid://111459308259276",
        Model = v1:FindFirstChild("Twilight Fence"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Twilight Night Owl Statue"] = {
        Description = "Hoo, hoo. Who? Me?",
        Rarity = "Mythical",
        Icon = "rbxassetid://71069798187910",
        Model = v1:FindFirstChild("Twilight Night Owl Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Twilight Fire Pit"] = {
        Description = "The fire seems to be cold.",
        Rarity = "Mythical",
        Icon = "rbxassetid://128525890363803",
        Model = v1:FindFirstChild("Twilight Fire Pit"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blood Bench"] = {
        Description = "A crimson seat for daring souls who love the night.",
        Rarity = "Mythical",
        Icon = "rbxassetid://91426040633172",
        Model = v1:FindFirstChild("Blood Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blood Lamp"] = {
        Description = "A blood-red light that casts a haunting glow.",
        Rarity = "Mythical",
        Icon = "rbxassetid://130449439996161",
        Model = v1:FindFirstChild("Blood Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blood Chain"] = {
        Description = "Chains that emit a dark, magical pulse.",
        Rarity = "Mythical",
        Icon = "rbxassetid://129878935477772",
        Model = v1:FindFirstChild("Blood Chain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blood Fence"] = {
        Description = "A fence dyed with the eerie glow of the blood moon.",
        Rarity = "Mythical",
        Icon = "rbxassetid://114306578289240",
        Model = v1:FindFirstChild("Blood Fence"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blood Fire Pit"] = {
        Description = "A fire pit that burns with an unsettling crimson flame.",
        Rarity = "Mythical",
        Icon = "rbxassetid://87320185293134",
        Model = v1:FindFirstChild("Blood Fire Pit"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Chair"] = {
        Description = "A bee-sized chair or a chair-sized bee? Neither.",
        Rarity = "Common",
        Icon = "rbxassetid://124322647736138",
        Model = v1:FindFirstChild("BeeChair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Honey Comb"] = {
        Description = "Excellent structural integrity.",
        Rarity = "Rare",
        Icon = "rbxassetid://127458246297955",
        Model = v1:FindFirstChild("HoneyComb"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Honey Walkway"] = {
        Description = "Watch out for drips.",
        Rarity = "Rare",
        Icon = "rbxassetid://92765418822065",
        Model = v1:FindFirstChild("HoneyWalkway"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Honey Torch"] = {
        Description = "The honey emits a strange glow.",
        Rarity = "Legendary",
        Icon = "rbxassetid://73494334572183",
        Model = v1:FindFirstChild("HoneyTorch"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Honey Barrel"] = {
        Description = "I hope they don\'t want this back.",
        Rarity = "Mythical",
        Icon = "rbxassetid://95914467481199",
        Model = v1:FindFirstChild("HoneyBarrel"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Honey Fountain"] = {
        Description = "The perfect companion for a stack of buttered toast.",
        Rarity = "Mythical",
        Icon = "rbxassetid://77404037269428",
        Model = v1:FindFirstChild("HoneyFountain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Honey Pillar"] = {
        Description = "Greek-designed, bee-built.",
        Rarity = "Mythical",
        Icon = "rbxassetid://134173394113465",
        Model = v1:FindFirstChild("HoneyPillar"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Honey Pot"] = {
        Description = "Mythical of sweet, sticky honey.",
        Rarity = "Mythical",
        Icon = "rbxassetid://133164059676431",
        Model = v1:FindFirstChild("HoneyPot"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Podium"] = {
        Description = "Her Majesty is on display.",
        Rarity = "Prismatic",
        Icon = "rbxassetid://130464966061346",
        Model = v1:FindFirstChild("BeePodium"),
        Actions = {},
        Tags = { "MACHINE" }
    },
    BeeHive = {
        Description = "Infinite honey glitch.",
        Rarity = "Mythical",
        Icon = "rbxassetid://77959075692985",
        Model = v1:FindFirstChild("ActiveBeeHive"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Honey Gate"] = {
        Description = "The entry to the hive.",
        Rarity = "Mythical",
        Icon = "rbxassetid://101078824256085",
        Model = v1:FindFirstChild("HoneyGate"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Flag"] = {
        Description = "A sticky flagpole representing bee-kind.",
        Rarity = "Mythical",
        Icon = "rbxassetid://126322654949831",
        Model = v1:FindFirstChild("BeeFlag"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Hunter Statue"] = {
        Description = "Never stand between a bee hunter and his honey.",
        Rarity = "Prismatic",
        Icon = "rbxassetid://74475541400439",
        Model = v1:FindFirstChild("BeeHunterStatue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Bee Mailbox"] = {
        Description = "You\'ve got mail!",
        Rarity = "Mythical",
        Icon = "rbxassetid://97954964771347",
        Model = v1:FindFirstChild("BeeMailbox"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Painting"] = {
        Description = "According to all known laws of aviation...",
        Rarity = "Mythical",
        Icon = "rbxassetid://87070081617616",
        Model = v1:FindFirstChild("BeePainting"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Rug"] = {
        Description = "Footwear recommended.",
        Rarity = "Mythical",
        Icon = "rbxassetid://111312932734327",
        Model = v1:FindFirstChild("BeeRug"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Stinger Painting"] = {
        Description = "Pointy.",
        Rarity = "Mythical",
        Icon = "rbxassetid://98657062197407",
        Model = v1:FindFirstChild("BeeStingerPainting"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Queen Bee Painting"] = {
        Description = "A painting dedicated to her royal highness.",
        Rarity = "Mythical",
        Icon = "rbxassetid://95766006476194",
        Model = v1:FindFirstChild("QueenBeePainting"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["1x1x1x1 Gnome"] = {
        Description = "A mysterious gnome with powers nobody dares to question.",
        Rarity = "Mythical",
        Icon = "rbxassetid://131967223688140",
        Model = v1:FindFirstChild("1x1x1x1Gnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Bloxy Cola Gnome"] = {
        Description = "This gnome runs purely on sugar and carbonated chaos.",
        Rarity = "Mythical",
        Icon = "rbxassetid://75332180369848",
        Model = v1:FindFirstChild("BloxyColaGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Candy Blossom Gnome"] = {
        Description = "A sweet little guardian of candy trees and sugar dreams.",
        Rarity = "Mythical",
        Icon = "rbxassetid://92609695018363",
        Model = v1:FindFirstChild("CandyBlossomGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Guest Gnome"] = {
        Description = "A nostalgic gnome from the days before usernames were cool.",
        Rarity = "Mythical",
        Icon = "rbxassetid://100014278372173",
        Model = v1:FindFirstChild("GuestGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Shedletsky Gnome"] = {
        Description = "A legendary gnome with hair as epic as his adventures.",
        Rarity = "Divine",
        Icon = "rbxassetid://117836343477747",
        Model = v1:FindFirstChild("ShedletskyGnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Blue Long Beach Chair"] = {
        Description = "Now all we need is a beach.",
        Rarity = "Legendary",
        Icon = "rbxassetid://71991465120758",
        Model = v1:FindFirstChild("Blue Long Beach Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pink Long Beach Chair"] = {
        Description = "Now all we need is a beach.",
        Rarity = "Legendary",
        Icon = "rbxassetid://91651365490043",
        Model = v1:FindFirstChild("Pink Long Beach Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    Heart = {
        Description = "The archway of loooove.",
        Rarity = "Legendary",
        Icon = "rbxassetid://108059871334863",
        Model = v1:FindFirstChild("Heart"),
        Actions = {},
        Tags = { "MISC" }
    },
    Slide = {
        Description = "Wheeeeeee!",
        Rarity = "Legendary",
        Icon = "rbxassetid://105765854848210",
        Model = v1:FindFirstChild("Slide"),
        Actions = {},
        Tags = { "MISC" }
    },
    Pool = {
        Description = "Fancy a swim?",
        Rarity = "Legendary",
        Icon = "rbxassetid://104950169841584",
        Model = v1:FindFirstChild("Pool"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Boat Painting"] = {
        Description = "Do not use as a buoyancy device.",
        Rarity = "Legendary",
        Icon = "rbxassetid://113199592747087",
        Model = v1:FindFirstChild("Boat Painting"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Palm Tree Painting"] = {
        Description = "Masterfully painted by a swarm of crabs.",
        Rarity = "Legendary",
        Icon = "rbxassetid://122087058031386",
        Model = v1:FindFirstChild("Palm Tree Painting"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sun Carpet"] = {
        Description = "The sun is high in the sky... no, it\'s on the floor!",
        Rarity = "Legendary",
        Icon = "rbxassetid://132563627216085",
        Model = v1:FindFirstChild("Sun Carpet"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sun Gate"] = {
        Description = "Enough to brighten the day of anyone who walks through.",
        Rarity = "Legendary",
        Icon = "rbxassetid://77503031812482",
        Model = v1:FindFirstChild("Sun Gate"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sun Painting"] = {
        Description = "A beautiful sunset.",
        Rarity = "Legendary",
        Icon = "rbxassetid://135714213682077",
        Model = v1:FindFirstChild("Sun Painting"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Surfer Statue"] = {
        Description = "Surf\'s up!",
        Rarity = "Legendary",
        Icon = "rbxassetid://118898226476172",
        Model = v1:FindFirstChild("Surfer Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Throne Sun"] = {
        Description = "Do not look directly at the throne.",
        Rarity = "Legendary",
        Icon = "rbxassetid://101215048324104",
        Model = v1:FindFirstChild("Throne Sun"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Dino Skull"] = {
        Description = "Perfectly preserved over millions of years.",
        Rarity = "Legendary",
        Icon = "rbxassetid://135977449505109",
        Model = v1:FindFirstChild("Dino Skull"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Dinosaur Footprints"] = {
        Description = "Must have been a big dog...",
        Rarity = "Legendary",
        Icon = "rbxassetid://118119830496962",
        Model = v1:FindFirstChild("Dinosaur Footprints"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Dino Proof Fence"] = {
        Description = "Is it to keep the dinos in, or keep us out?",
        Rarity = "Legendary",
        Icon = "rbxassetid://132790191705590",
        Model = v1:FindFirstChild("Dino Proof Fence"),
        Actions = {},
        Tags = { "MISC" }
    },
    Bone = {
        Description = "Keep out of reach of pets.",
        Rarity = "Legendary",
        Icon = "rbxassetid://70986536992671",
        Model = v1:FindFirstChild("Bone"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Rock Car"] = {
        Description = "Yabba-dabba-doo your way to work in prehistoric style!",
        Rarity = "Legendary",
        Icon = "rbxassetid://84416518410872",
        Model = v1:FindFirstChild("Rock Car"),
        Actions = {},
        Tags = { "MACHINE" }
    },
    ["Skeleton Statue"] = {
        Description = "It\'s said to be the remains of the last dino hunter.",
        Rarity = "Legendary",
        Icon = "rbxassetid://137874336811380",
        Model = v1:FindFirstChild("Skeleton Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Spine Fence"] = {
        Description = "Ouch! Spiky!",
        Rarity = "Legendary",
        Icon = "rbxassetid://119358212260594",
        Model = v1:FindFirstChild("Spine Fence"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["DNA Container"] = {
        Description = "The twisty code of life, neatly packed into a tube.",
        Rarity = "Legendary",
        Icon = "rbxassetid://104144486946979",
        Model = v1:FindFirstChild("DNA Container"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Archeology Tool Rack"] = {
        Description = "The essentials for digging up ancient secrets.",
        Rarity = "Legendary",
        Icon = "rbxassetid://124130509505417",
        Model = v1:FindFirstChild("Archeology Tool Rack"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Dino Lamp"] = {
        Description = "A tall lamp, carefully crafted from bones and sinew.",
        Rarity = "Legendary",
        Icon = "rbxassetid://133738368629123",
        Model = v1:FindFirstChild("Dino Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Dino Trophy"] = {
        Description = "Prized skull of a real dinosaur!",
        Rarity = "Legendary",
        Icon = "rbxassetid://120457261434549",
        Model = v1:FindFirstChild("Dino Trophy"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Dino Bone Case"] = {
        Description = "Not a chew toy.",
        Rarity = "Legendary",
        Icon = "rbxassetid://90556385672649",
        Model = v1:FindFirstChild("Dino Bone Case"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Dino Slayer Statue"] = {
        Description = "Legend has it, the dino slayer made the dinosaurs go extinct.",
        Rarity = "Legendary",
        Icon = "rbxassetid://88357970667971",
        Model = v1:FindFirstChild("Dino Slayer Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Long Neck Dino Statue"] = {
        Description = "How\'s the weather up there?",
        Rarity = "Legendary",
        Icon = "rbxassetid://107433332329644",
        Model = v1:FindFirstChild("Long Neck Dino Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    Volcano = {
        Description = "Full of red hot lava.",
        Rarity = "Legendary",
        Icon = "rbxassetid://138206771411283",
        Model = v1:FindFirstChild("Volcano"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["America Banner"] = {
        Description = "Wave it proud - your garden is the land of the free and home of the harvest!",
        Rarity = "Legendary",
        Icon = "rbxassetid://79593589083679",
        Model = v1:FindFirstChild("America Banner"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["America Flag Badge"] = {
        Description = "True patriots only.",
        Rarity = "Legendary",
        Icon = "rbxassetid://120228722090334",
        Model = v1:FindFirstChild("America Flag Badge"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["American Flag"] = {
        Description = "Planting freedom one seed at a time.",
        Rarity = "Legendary",
        Icon = "rbxassetid://92722333236046",
        Model = v1:FindFirstChild("American Flag"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bald Eagle Statue"] = {
        Description = "EagleSoundEffect.mp3",
        Rarity = "Legendary",
        Icon = "rbxassetid://126085067316745",
        Model = v1:FindFirstChild("Bald Eagle Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["July 4th Toy"] = {
        Description = "Celebrate your harvest\'s independence with explosive flair!",
        Rarity = "Legendary",
        Icon = "rbxassetid://81836108062745",
        Model = v1:FindFirstChild("July 4th Toy"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Uncle Sam Gnome"] = {
        Description = "Wants YOU to have the most patriotic garden in the neighborhood.",
        Rarity = "Legendary",
        Icon = "rbxassetid://120023580280311",
        Model = v1:FindFirstChild("Uncle Sam Gnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Dark Ninja Gnome"] = {
        Description = "Strikes from the shadows to protect your crops.",
        Rarity = "Legendary",
        Icon = "rbxassetid://93038221719499",
        Model = v1:FindFirstChild("Dark Ninja Gnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Light Ninja Gnome"] = {
        Description = "Bringing balance to the darkness.",
        Rarity = "Legendary",
        Icon = "rbxassetid://110343561582804",
        Model = v1:FindFirstChild("Light Ninja Gnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Zen Channeller Gnome"] = {
        Description = "Enlightenment sold separately.",
        Rarity = "Legendary",
        Icon = "rbxassetid://130020217436802",
        Model = v1:FindFirstChild("Zen Channeller Gnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Panda Gnome"] = {
        Description = "You are gnot going to like me when grumpy!",
        Rarity = "Legendary",
        Icon = "rbxassetid://136464590894047",
        Model = v1:FindFirstChild("Panda Gnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Samurai Gnome"] = {
        Description = "Honor your harvest with the way of the warrior gardener.",
        Rarity = "Legendary",
        Icon = "rbxassetid://98408249952275",
        Model = v1:FindFirstChild("Samurai Gnome"),
        Actions = {},
        Tags = { "GNOME" }
    },
    ["Whispering Torii"] = {
        Description = "What secrets does it hold?",
        Rarity = "Mythical",
        Icon = "rbxassetid://123218145042358",
        Model = v1:FindFirstChild("Whispering Torii"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Hot Spring"] = {
        Description = "The perfect spot to unwind after a long day.",
        Rarity = "Rare",
        Icon = "rbxassetid://102701113946399",
        Model = v1:FindFirstChild("Hot Spring"),
        Actions = {},
        Tags = { "MISC", "UTILITY" }
    },
    ["Pancake Stack"] = {
        Description = "Your pets seem to be really attracted to the stack of pancakes!",
        Rarity = "Mythical",
        Icon = "rbxassetid://72003221560635",
        Undeletable = true,
        Model = v1:FindFirstChild("Pancake Stack"),
        Actions = {},
        Tags = { "MISC", "UTILITY" }
    },
    ["Zen Sand"] = {
        Description = "Raking in the peace.",
        Rarity = "Legendary",
        Icon = "rbxassetid://89555305118515",
        Model = v1:FindFirstChild("Zen Sand"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Temple Lamp"] = {
        Description = "A beacon in the dark for garden spirits.",
        Rarity = "Legendary",
        Icon = "rbxassetid://118855603196154",
        Model = v1:FindFirstChild("Temple Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bamboo Fence"] = {
        Description = "Keeps the gnomes out.",
        Rarity = "Legendary",
        Icon = "rbxassetid://108164141573262",
        Model = v1:FindFirstChild("Bamboo Fence"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bamboo Tech"] = {
        Description = "Such a creative little contraption.",
        Rarity = "Legendary",
        Icon = "rbxassetid://136277100467130",
        Model = v1:FindFirstChild("Bamboo Tech"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Japanese Gong"] = {
        Description = "~BWONNGGGGGGGGG~",
        Rarity = "Legendary",
        Icon = "rbxassetid://98584483995379",
        Model = v1:FindFirstChild("Japanese Gong"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Zen Bridge"] = {
        Description = "A simple wooden bridge that invites calm steps and peaceful strolls.",
        Rarity = "Legendary",
        Icon = "rbxassetid://107695376294579",
        Model = v1:FindFirstChild("Zen Bridge"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Zen Waterfall"] = {
        Description = "A gentle waterfall inviting peace and serenity.",
        Rarity = "Legendary",
        Icon = "rbxassetid://82333210563868",
        Model = v1:FindFirstChild("Zen Waterfall"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Buddha Statue"] = {
        Description = "A serene statue spreading chill vibes and quiet wisdom.",
        Rarity = "Legendary",
        Icon = "rbxassetid://129654063898982",
        Model = v1:FindFirstChild("Buddha Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Zen Fan"] = {
        Description = "Bringing a cool, calm breeze to your garden.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://75369672011401",
        Model = v1:FindFirstChild("Zen Fan"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Corrupted Garden Light"] = {
        Description = "Fills your garden with a pulsating glow of corruption.",
        Rarity = "Rare",
        Icon = "rbxassetid://115031659359620",
        Model = v1:FindFirstChild("Corrupted Garden Light"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Corrupted Bamboo Fence"] = {
        Description = "A regular old bamboo fence (but it\'s evil).",
        Rarity = "Rare",
        Icon = "rbxassetid://86998488556965",
        Model = v1:FindFirstChild("Corrupted Bamboo Fence"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Mounted Katanas"] = {
        Description = "Legendary twin blades, thought to have been lost to time.",
        Rarity = "Legendary",
        Icon = "rbxassetid://87570375939460",
        Model = v1:FindFirstChild("Mounted Katanas"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Corrupted Bridge"] = {
        Description = "It seems to be pulsing with dark energy.",
        Rarity = "Mythical",
        Icon = "rbxassetid://99827869575418",
        Model = v1:FindFirstChild("Corrupted Bridge"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Corrupted Well"] = {
        Description = "Well, well, well...",
        Rarity = "Mythical",
        Icon = "rbxassetid://117482074049800",
        Model = v1:FindFirstChild("Corrupted Well"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pink Cake"] = {
        Description = "Sweet vibes only.",
        Rarity = "Common",
        Icon = "rbxassetid://139803447090329",
        Model = v1:FindFirstChild("Pink Cake"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blue Cake"] = {
        Description = "A berry blue-tiful dessert.",
        Rarity = "Common",
        Icon = "rbxassetid://107286814174017",
        Model = v1:FindFirstChild("Blue Cake"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Coffee Machine"] = {
        Description = "The pick me up station.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://131424870913780",
        Model = v1:FindFirstChild("Coffee Machine"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Banana Hammock"] = {
        Description = "An ap-peel-ing spot for a nap.",
        Rarity = "Rare",
        Icon = "rbxassetid://111292578609127",
        Model = v1:FindFirstChild("Banana Hammock"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cheese Mat"] = {
        Description = "The grate-est mat to ever bless your garden.",
        Rarity = "Rare",
        Icon = "rbxassetid://120715470358349",
        Model = v1:FindFirstChild("Cheese Mat"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Hotdog Cart"] = {
        Description = "Mobile dog dispenser.",
        Rarity = "Legendary",
        Icon = "rbxassetid://130716429170835",
        Model = v1:FindFirstChild("Hotdog Cart"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Golden Hotdog Statue"] = {
        Description = "The ULTIMATE symbol of status!",
        Rarity = "Mythical",
        Icon = "rbxassetid://73484648804885",
        Model = v1:FindFirstChild("Golden Hotdog Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Fork Fence"] = {
        Description = "It was either this or the spork fence.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://116492910249771",
        Model = v1:FindFirstChild("Fork Fence"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pretzel Cart"] = {
        Description = "Portable snack wagon of twisty bread and dreams.",
        Rarity = "Legendary",
        Icon = "rbxassetid://106567090231143",
        Model = v1:FindFirstChild("Pretzel Cart"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cooking Cauldron"] = {
        Description = "UNGA BUNGA COOKING TIME",
        Rarity = "Rare",
        Icon = "rbxassetid://140572721830268",
        Model = v1:FindFirstChild("Cooking Cauldron"),
        Actions = {},
        Tags = { "MISC", "UTILITY" }
    },
    Stoplight = {
        Description = "Tells you when to vibe, zoom, or full send.",
        Rarity = "Prismatic",
        Icon = "rbxassetid://72661770099625",
        Model = v1:FindFirstChild("Stoplight"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pizza Box"] = {
        Description = "Smells like gamer fuel.",
        Rarity = "Rare",
        Icon = "rbxassetid://117102090447163",
        Model = v1:FindFirstChild("Pizza Box"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Donut Swing"] = {
        Description = "Swings you into another dimension of sweetness.",
        Rarity = "Legendary",
        Icon = "rbxassetid://70992139994852",
        Model = v1:FindFirstChild("Donut Swing"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sink Cabinet"] = {
        Description = "Where dishes to go cry and respawn.",
        Rarity = "Common",
        Icon = "rbxassetid://119530033900682",
        Model = v1:FindFirstChild("Sink Cabinet"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Chris P Statue"] = {
        Description = "Would you pick up the phone?",
        Rarity = "Prismatic",
        Icon = "rbxassetid://76638055963426",
        Model = v1:FindFirstChild("Chris P Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    Fridge = {
        Description = "Anything tasty in here?",
        Rarity = "Uncommon",
        Icon = "rbxassetid://100427797189679",
        Model = v1:FindFirstChild("Fridge"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cabinet Utensil"] = {
        Description = "Full of handy kitchen tools.",
        Rarity = "Rare",
        Icon = "rbxassetid://123693600291594",
        Model = v1:FindFirstChild("CabinetUtensil"),
        Actions = {},
        Tags = { "MISC" }
    },
    Stove = {
        Description = "The heart of every garden kitchen.",
        Rarity = "Rare",
        Icon = "rbxassetid://112715903134219",
        Model = v1:FindFirstChild("Stove"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Frying Pan"] = {
        Description = "Perfect for flipping pancakes or chasing garden gnomes.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://124704815957312",
        Model = v1:FindFirstChild("Frying Pan"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Kitchen Cart"] = {
        Description = "Meals on wheels.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://135556889455073",
        Model = v1:FindFirstChild("Kitchen Cart"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Kitchen Flooring"] = {
        Description = "Kitchen isn\'t a kitchen without a floor!",
        Rarity = "Uncommon",
        Icon = "rbxassetid://127702999731295",
        Model = v1:FindFirstChild("Kitchen Flooring"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Smoothie Fountain"] = {
        Description = "Infinite fruity goodness.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://108938932915450",
        Model = v1:FindFirstChild("Smoothie Fountain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Flamingo Garden Stake"] = {
        Description = "The fabulous guardian of the garden.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://94984928124462",
        Model = v1:FindFirstChild("Flamingo Garden Stake"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Beanpod Crate"] = {
        Description = "A crate that smells faintly of beans. You probably shouldn’t store soup in it.",
        Rarity = "Rare",
        Icon = "rbxassetid://111143723554629",
        Model = v1:FindFirstChild("Beanpod Crate"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Beanstalk Entrance"] = {
        Description = "Step through here and you might find a giant… or just more beans.",
        Rarity = "Legendary",
        Icon = "rbxassetid://133847364538116",
        Model = v1:FindFirstChild("Beanstalk Entrance"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Beanstalk Hammock"] = {
        Description = "Perfect for a nap high above the clouds, if you’re not scared of heights.",
        Rarity = "Rare",
        Icon = "rbxassetid://106954303075560",
        Model = v1:FindFirstChild("Beanstalk Hammock"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Chopped Beanstalk"] = {
        Description = "The story ends here… unless you like falling.",
        Rarity = "Legendary",
        Icon = "rbxassetid://113996684408956",
        Model = v1:FindFirstChild("Chopped Beanstalk"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bean Vine Pillar"] = {
        Description = "Strong enough to hold a castle... and some clouds.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://97688674720996",
        Model = v1:FindFirstChild("Bean Vine Pillar"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Egg Podium"] = {
        Description = "Where only the most eggcellent eggs deserve to stand.",
        Rarity = "Mythical",
        Icon = "rbxassetid://112480478736815",
        Model = v1:FindFirstChild("Egg Podium"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cooking Kit"] = {
        Description = "A mini Cooking Kit for cooking food!",
        Rarity = "Prismatic",
        Icon = "rbxassetid://76909170310985",
        Max = 3,
        Undeletable = true,
        Model = v1:FindFirstChild("Cooking Kit"),
        Actions = {},
        Tags = { "MISC", "UTILITY" }
    },
    ["Statue Of Achievement"] = {
        Description = "The Grand Reward for getting all core Achievements! Increases backpack size by 100!",
        Rarity = "Prismatic",
        Icon = "rbxassetid://121858779296935",
        Max = 1,
        Undeletable = true,
        Model = v1:FindFirstChild("Statue Of Achievement"),
        Actions = {},
        Tags = { "STATUE", "UTILITY" }
    },
    ["Pet Incubator"] = {
        Description = "Increases Pet EXP gain",
        Rarity = "Prismatic",
        Icon = "rbxassetid://85299659167272",
        Undeletable = true,
        Max = 3,
        Model = v1:FindFirstChild("Pet Incubator"),
        Actions = {},
        Tags = { "MACHINE", "UTILITY" }
    },
    ["Egg Incubator"] = {
        Description = "Increases Egg Hatch Time",
        Rarity = "Prismatic",
        Icon = "rbxassetid://109904712559790",
        Undeletable = true,
        Max = 3,
        Model = v1:FindFirstChild("Egg Incubator"),
        Actions = {},
        Tags = { "MACHINE", "UTILITY" }
    },
    ["Mutation Machine Booster"] = {
        Description = "Reduces the time of the pet mutation machine",
        Rarity = "Prismatic",
        Icon = "rbxassetid://117000789940046",
        Undeletable = true,
        Max = 3,
        Model = v1:FindFirstChild("Mutation Machine Booster"),
        Actions = {},
        Tags = { "MACHINE", "UTILITY" }
    },
    ["Steal a Character Tombstone"] = {
        Description = "Go BIG or go fix feet under",
        Rarity = "Divine",
        Icon = "rbxassetid://138270941214642",
        Model = v1:FindFirstChild("Steal a Character Tombstone"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bean Chair"] = {
        Description = "That does not look too comfortable...",
        Rarity = "Common",
        Icon = "rbxassetid://93975598685883",
        Model = v1:FindFirstChild("Bean Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Giant Painting"] = {
        Description = "What\'ll it be, tiny?",
        Rarity = "Uncommon",
        Icon = "rbxassetid://108391142160867",
        Model = v1:FindFirstChild("Giant Painting"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Beanstalk Painting"] = {
        Description = "As you look at this, it may or may not remind you of that time you climbed up the beanstalk.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://79662411456574",
        Model = v1:FindFirstChild("Beanstalk Painting"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Golden Goose Painting"] = {
        Description = "There is only one Golden Goose in the world! (Real)",
        Rarity = "Uncommon",
        Icon = "rbxassetid://90257134404383",
        Model = v1:FindFirstChild("Golden Goose Painting"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bean Sprout Float Light"] = {
        Description = "Lights out, bean sprout.",
        Rarity = "Rare",
        Icon = "rbxassetid://107117826079251",
        Model = v1:FindFirstChild("Bean Sprout Float Light"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Green Bean Memories"] = {
        Description = "Where have you bean? Always green, never leave...",
        Rarity = "Legendary",
        Icon = "rbxassetid://72082340784003",
        Model = v1:FindFirstChild("Green Bean Memories"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bean Pool Table"] = {
        Description = "The sounds of the pool beans rolling across the bean table doesn\'t sound too pleasant.",
        Rarity = "Legendary",
        Icon = "rbxassetid://106141930841467",
        Model = v1:FindFirstChild("Bean Pool Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bouncy Mushroom"] = {
        Description = "BEAN BOING!",
        Rarity = "Divine",
        Icon = "rbxassetid://134306738320631",
        Model = v1:FindFirstChild("Bouncy Mushroom"),
        Actions = {},
        Tags = { "MISC", "UTILITY" }
    },
    ["Griffin Statue"] = {
        Description = "These glorious creatures create winds strong enough to knock even giants down to defend their nests set up on beanstalk leaves.",
        Rarity = "Divine",
        Icon = "rbxassetid://86408013808631",
        Model = v1:FindFirstChild("Griffin Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Fairy Chair"] = {
        Description = "A delicate seat woven from petals and moonlight, perfect for resting tiny wings.",
        Rarity = "Rare",
        Icon = "rbxassetid://100414519497909",
        Model = v1:FindFirstChild("Fairy Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fairy Lamp"] = {
        Description = "A glowing lantern filled with captured starlight, guiding fairies through the night.",
        Rarity = "Rare",
        Icon = "rbxassetid://119538947585220",
        Model = v1:FindFirstChild("Fairy Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fairy Stand"] = {
        Description = "A tiny pedestal carved from enchanted wood, where fairies display their treasures.",
        Rarity = "Rare",
        Icon = "rbxassetid://135551660321823",
        Model = v1:FindFirstChild("Fairy Stand"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gnome Wagon"] = {
        Description = "A sturdy wooden wagon used by gnomes to carry mushrooms, gems, and secrets.",
        Rarity = "Legendary",
        Icon = "rbxassetid://102150891226977",
        Model = v1:FindFirstChild("Gnome Wagon"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fairy Gate"] = {
        Description = "An enchanted archway that shimmers with hidden magic, leading to realms unseen.",
        Rarity = "Legendary",
        Icon = "rbxassetid://126215858817107",
        Model = v1:FindFirstChild("Fairy Gate"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Mushroom Gnome Home"] = {
        Description = "A cozy home nestled inside a giant mushroom, glowing warmly with gnome magic.",
        Rarity = "Legendary",
        Icon = "rbxassetid://111227810329813",
        Model = v1:FindFirstChild("Mushroom Gnome Home"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fairy Mirror"] = {
        Description = "A mystical mirror that shows not only reflections, but whispers of future dreams.",
        Rarity = "Mythical",
        Icon = "rbxassetid://77646378358232",
        Model = v1:FindFirstChild("Fairy Mirror"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fairy Pond"] = {
        Description = "A crystal-clear pond where moonlight dances and fairies gather to sing.",
        Rarity = "Mythical",
        Icon = "rbxassetid://114756185049128",
        Model = v1:FindFirstChild("Fairy Pond"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wisp Well"] = {
        Description = "There is a great overwhelming force of Wisp energy eminating from this mystical well.",
        Rarity = "Mythical",
        Icon = "rbxassetid://79205504566654",
        Undeletable = true,
        Model = v1:FindFirstChild("Wisp Well"),
        Actions = {},
        Tags = { "MISC", "UTILITY" }
    },
    ["Elden Fairy Lamp Post"] = {
        Description = "A Elden Fairy Lamp Post",
        Rarity = "Mythical",
        Icon = "rbxassetid://131342736520551",
        Model = v1:FindFirstChild("EldenFairyLampPost"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fairy Book Shelf"] = {
        Description = "A Fairy Book Shelf",
        Rarity = "Mythical",
        Icon = "rbxassetid://112212297537595",
        Model = v1:FindFirstChild("FairyBookShelf"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fairy Purple Chair"] = {
        Description = "A Fairy Purple Chair",
        Rarity = "Mythical",
        Icon = "rbxassetid://135179698088586",
        Model = v1:FindFirstChild("FairyPurpleChair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fairy Statue"] = {
        Description = "A Fairy Statue",
        Rarity = "Mythical",
        Icon = "rbxassetid://139645908100040",
        Model = v1:FindFirstChild("FairyStatue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Mushroom Lamp"] = {
        Description = "A Mushroom Lamp",
        Rarity = "Mythical",
        Icon = "rbxassetid://114948584388331",
        Model = v1:FindFirstChild("MushroomLamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Mushroom Table"] = {
        Description = "A Mushroom Table",
        Rarity = "Mythical",
        Icon = "rbxassetid://110882742794079",
        Model = v1:FindFirstChild("MushroomTable"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wish Fountain"] = {
        Description = "Wish Fountain",
        Rarity = "Prismatic",
        Icon = "rbxassetid://127146743394145",
        Model = v1:FindFirstChild("Wish Fountain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Alien Lamp"] = {
        Description = "",
        Rarity = "Mythical",
        Icon = "rbxassetid://75938358432703",
        Model = v1:FindFirstChild("Alien Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    AlienShip = {
        Description = "",
        Rarity = "Mythical",
        Icon = "rbxassetid://98708880341870",
        Model = v1:FindFirstChild("AlienShip"),
        Actions = {},
        Tags = { "MISC" }
    },
    AlienShipTrophy = {
        Description = "",
        Rarity = "Mythical",
        Icon = "rbxassetid://73515066175359",
        Model = v1:FindFirstChild("AlienShipTrophy"),
        Actions = {},
        Tags = { "MISC" }
    },
    Sphinx = {
        Description = "",
        Rarity = "Mythical",
        Icon = "rbxassetid://106974983987906",
        Model = v1:FindFirstChild("Sphinx"),
        Actions = {},
        Tags = { "STATUE" }
    },
    EgyptianPillar = {
        Description = "",
        Rarity = "Mythical",
        Icon = "rbxassetid://123449668900156",
        Model = v1:FindFirstChild("EgyptianPillar"),
        Actions = {},
        Tags = { "MISC" }
    },
    EgyptianPainting = {
        Description = "",
        Rarity = "Mythical",
        Icon = "rbxassetid://111339106695829",
        Model = v1:FindFirstChild("EgyptianPainting"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Green Bean Chamber"] = {
        Description = "The war is over. May the beans rest well.",
        Rarity = "Prismatic",
        Icon = "rbxassetid://88363440397145",
        Model = v1:FindFirstChild("Green Bean Chamber"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fall Wheel"] = {
        Description = "A wheel of a fall harvest wagon.",
        Rarity = "Uncommon",
        Icon = "rbxassetid://117160661132152",
        Model = v1:FindFirstChild("Fall Wheel"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Crate Of Pumpkin Corn"] = {
        Description = "A crate filled with pumpkin and corn, some fall staples.",
        Rarity = "Rare",
        Icon = "rbxassetid://139249116184958",
        Model = v1:FindFirstChild("Crate Of Pumpkin Corn"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Acorn Brazier"] = {
        Description = "Ancient squirrel civilization used acorns as fire pits to keep warm just before the great winter hibernation.",
        Rarity = "Rare",
        Icon = "rbxassetid://74641482329908",
        Model = v1:FindFirstChild("Acorn Brazier"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Maple Trophy"] = {
        Description = "Embody the spirit of Fall!",
        Rarity = "Legendary",
        Icon = "rbxassetid://130271298819838",
        Model = v1:FindFirstChild("Maple Trophy"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Log Tunnel Fall"] = {
        Description = "Crisp leaves crunch as you step through.",
        Rarity = "Mythical",
        Icon = "rbxassetid://86171077862769",
        Model = v1:FindFirstChild("Log Tunnel Fall"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fall Leaf Chair"] = {
        Description = "Perfect for relaxing while watching the leaves drift down around you.",
        Rarity = "Common",
        Icon = "rbxassetid://125212137128357",
        Model = v1:FindFirstChild("Fall Leaf Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Maple Flag"] = {
        Description = "A beautiful maple flag displaying the colors of fall.",
        Rarity = "Rare",
        Icon = "rbxassetid://115615263120810",
        Model = v1:FindFirstChild("Maple Flag"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Flying Kite"] = {
        Description = "The leaves fall and the kites rise.",
        Rarity = "Legendary",
        Icon = "rbxassetid://99214834487736",
        Model = v1:FindFirstChild("Flying Kite"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fall Fountain"] = {
        Description = "Periodically imbues your crops with the Fall mutation!",
        Rarity = "Divine",
        Icon = "rbxassetid://94850925562735",
        Max = 6,
        Model = v1:FindFirstChild("Fall Fountain"),
        Actions = {},
        Tags = { "MISC" }
    },
    RDCAward = {
        Description = "You are the only reason this was possible so for that; Thank you for everything!",
        Rarity = "Prismatic",
        Icon = "rbxassetid://92157401543343",
        Model = v1:FindFirstChild("RDCAward"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Acorn Painting"] = {
        Description = "Acorns are Fall\'s carrots!",
        Rarity = "Legendary",
        Icon = "rbxassetid://107143164439177",
        Model = v1:FindFirstChild("Acorn Painting"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fall Market Painting"] = {
        Description = "Oh, it\'s the Fall Market!",
        Rarity = "Legendary",
        Icon = "rbxassetid://77819899927387",
        Model = v1:FindFirstChild("Fall Market Painting"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fall Table"] = {
        Description = "Put leaves, plants, pets on me!",
        Rarity = "Rare",
        Icon = "rbxassetid://100709295775548",
        Model = v1:FindFirstChild("Fall Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fall Wreath"] = {
        Description = "Whispers of fall spun round and round!",
        Rarity = "Rare",
        Icon = "rbxassetid://118680729910862",
        Model = v1:FindFirstChild("Fall Wreath"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Golden Swan Statue"] = {
        Description = "A graceful guardian cast in gold!",
        Rarity = "Divine",
        Icon = "rbxassetid://86969051940942",
        Model = v1:FindFirstChild("Golden Swan Statue"),
        Actions = {},
        Tags = { "MISC", "STATUE" }
    },
    ["Fall Hay Bale"] = {
        Description = "It\'s just a hay bale!",
        Rarity = "Rare",
        Icon = "rbxassetid://120930808526597",
        Model = v1:FindFirstChild("Fall Hay Bale"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pile Of Leaves"] = {
        Description = "Go on, jump in it!",
        Rarity = "Rare",
        Icon = "rbxassetid://110846948895211",
        Model = v1:FindFirstChild("Pile Of Leaves"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pumpkin Wheelbarrow"] = {
        Description = "Easier to carry your crops!",
        Rarity = "Rare",
        Icon = "rbxassetid://73703895481552",
        Model = v1:FindFirstChild("Pumpkin Wheelbarrow"),
        Actions = {},
        Tags = { "MISC" }
    },
    Scarecrow = {
        Description = "Always smiling, even when no one’s around...",
        Rarity = "Rare",
        Icon = "rbxassetid://112374836896137",
        Model = v1:FindFirstChild("Scarecrow"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fall Market Cart"] = {
        Description = "Become a Fall Market Merchant!",
        Rarity = "Rare",
        Icon = "rbxassetid://138446161837381",
        Model = v1:FindFirstChild("Fall Market Cart"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Computer Monitor"] = {
        Description = "A glowing frame.",
        Rarity = "Rare",
        Icon = "rbxassetid://100475940251774",
        Model = v1:FindFirstChild("Computer Monitor"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Flower Swing"] = {
        Description = "A seat wrapped in blossoms.",
        Rarity = "Legendary",
        Icon = "rbxassetid://73173574113839",
        Model = v1:FindFirstChild("Flower Swing"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Golden Harp"] = {
        Description = "Melody spun from gold!",
        Rarity = "Divine",
        Icon = "rbxassetid://96793904572444",
        Model = v1:FindFirstChild("Golden Harp"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Golden Radio"] = {
        Description = "Golden voice box of joy!",
        Rarity = "Mythical",
        Icon = "rbxassetid://121910138612270",
        Model = v1:FindFirstChild("Golden Radio"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Golden Rings"] = {
        Description = "Circles that gleam forever!",
        Rarity = "Mythical",
        Icon = "rbxassetid://74995141061303",
        Model = v1:FindFirstChild("Golden Rings"),
        Actions = {},
        Tags = { "MISC", "STATUE" }
    },
    ["Mushroom Bed"] = {
        Description = "Cozy bed grown from the forest.",
        Rarity = "Legendary",
        Icon = "rbxassetid://139362142949816",
        Model = v1:FindFirstChild("Mushroom Bed"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Mushroom Rug"] = {
        Description = "Soft, spongy magic for your toes.",
        Rarity = "Legendary",
        Icon = "rbxassetid://107413853079743",
        Model = v1:FindFirstChild("Mushroom Rug"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Mushroom Throne"] = {
        Description = "The seat where stories and magic begin!",
        Rarity = "Legendary",
        Icon = "rbxassetid://92423835907357",
        Model = v1:FindFirstChild("Mushroom Throne"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Mystical Archway"] = {
        Description = "An archway that whispers secrets of old...",
        Rarity = "Mythical",
        Icon = "rbxassetid://127453298266430",
        Model = v1:FindFirstChild("Mystical Archway"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Mystical Waterfall"] = {
        Description = "Nature’s spell in flowing form!",
        Rarity = "Mythical",
        Icon = "rbxassetid://96179259788217",
        Model = v1:FindFirstChild("Mystical Waterfall"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Snake Pillar"] = {
        Description = "A snake that loves to play peek-a-boo!",
        Rarity = "Legendary",
        Icon = "rbxassetid://106063311813613",
        Model = v1:FindFirstChild("Snake Pillar"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Tree Trunk Stairs"] = {
        Description = "Wonder where those steps lead?",
        Rarity = "Rare",
        Icon = "rbxassetid://121142939380745",
        Model = v1:FindFirstChild("Tree Trunk Stairs"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Vine Spiked Fence"] = {
        Description = "Ouch, that\'s spiky!",
        Rarity = "Rare",
        Icon = "rbxassetid://134126728404869",
        Model = v1:FindFirstChild("Vine Spiked Fence"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Treasure Chest"] = {
        Description = "Packed with loot and secrets!",
        Rarity = "Legendary",
        Icon = "rbxassetid://89617169584023",
        Model = v1:FindFirstChild("Treasure Chest"),
        Actions = {},
        Tags = { "MISC" }
    },
    Telescope = {
        Description = "Galaxies at your fingertips!",
        Rarity = "Rare",
        Icon = "rbxassetid://87521337166060",
        Model = v1:FindFirstChild("Telescope"),
        Actions = {},
        Tags = { "MISC" }
    },
    Fireplace = {
        Description = "Warmth and cozy vibes!",
        Rarity = "Mythical",
        Icon = "rbxassetid://73881410789867",
        Model = v1:FindFirstChild("Fireplace"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Grandfather Clock"] = {
        Description = "Tick-tock .... tick-tock ...",
        Rarity = "Rare",
        Icon = "rbxassetid://131195281744176",
        Model = v1:FindFirstChild("Grandfather Clock"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wood Windmill"] = {
        Description = "Turning with the breeze!",
        Rarity = "Rare",
        Icon = "rbxassetid://139928525381726",
        Model = v1:FindFirstChild("Wood Windmill"),
        Actions = {},
        Tags = { "MISC" }
    },
    Cannon = {
        Description = "Big boom, big impact!!",
        Rarity = "Mythical",
        Icon = "rbxassetid://121227189383431",
        Model = v1:FindFirstChild("Cannon"),
        Actions = {},
        Tags = { "MISC" }
    },
    Workbench = {
        Description = "Gotta get to work!",
        Rarity = "Legendary",
        Icon = "rbxassetid://119867985372344",
        Model = v1:FindFirstChild("Workbench"),
        Actions = {},
        Tags = { "MISC" }
    },
    Keyboard = {
        Description = "Make every key count!",
        Rarity = "Rare",
        Icon = "rbxassetid://125435823218731",
        Model = v1:FindFirstChild("Keyboard"),
        Actions = {},
        Tags = { "MISC" }
    },
    Scooter = {
        Description = "Swift, smooth, speedy!",
        Rarity = "Legendary",
        Icon = "rbxassetid://102512725078827",
        Model = v1:FindFirstChild("Scooter"),
        Actions = {},
        Tags = { "MISC" }
    },
    Treadmill = {
        Description = "Step into fitness!",
        Rarity = "Rare",
        Icon = "rbxassetid://135628781134806",
        Model = v1:FindFirstChild("Treadmill"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Woody Sign"] = {
        Description = "A woody sign",
        Rarity = "Common",
        Icon = "rbxassetid://90947798053901",
        Model = v1:FindFirstChild("Woody Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Stalky Sign"] = {
        Description = "A stalky sign",
        Rarity = "Common",
        Icon = "rbxassetid://113785321384989",
        Model = v1:FindFirstChild("Stalky Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Spicy Sign"] = {
        Description = "A spicy sign",
        Rarity = "Common",
        Icon = "rbxassetid://87914101845857",
        Model = v1:FindFirstChild("Spicy Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sweet Sign"] = {
        Description = "A sweet sign",
        Rarity = "Common",
        Icon = "rbxassetid://136360670714246",
        Model = v1:FindFirstChild("Sweet Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Tropical Sign"] = {
        Description = "A tropical sign",
        Rarity = "Common",
        Icon = "rbxassetid://74098972118405",
        Model = v1:FindFirstChild("Tropical Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Vegetable Sign"] = {
        Description = "A vegetable sign",
        Rarity = "Common",
        Icon = "rbxassetid://82835390126793",
        Model = v1:FindFirstChild("Vegetable Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Prickly Sign"] = {
        Description = "A prickly sign",
        Rarity = "Common",
        Icon = "rbxassetid://138335256345399",
        Model = v1:FindFirstChild("Prickly Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Berry Sign"] = {
        Description = "A berry sign",
        Rarity = "Common",
        Icon = "rbxassetid://120921984292872",
        Model = v1:FindFirstChild("Berry Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Flower Sign"] = {
        Description = "A flower sign",
        Rarity = "Common",
        Icon = "rbxassetid://121138671792368",
        Model = v1:FindFirstChild("Flower Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fruit Sign"] = {
        Description = "A fruit sign",
        Rarity = "Common",
        Icon = "rbxassetid://117553553339011",
        Model = v1:FindFirstChild("Fruit Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Leafy Sign"] = {
        Description = "A leafy sign",
        Rarity = "Common",
        Icon = "rbxassetid://72408063141032",
        Model = v1:FindFirstChild("Leafy Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Egg Yolk Mat"] = {
        Description = "A sunny splash of golden yolk, perfectly fried into comfort. Step onto it and feel breakfast’s warm embrace beneath your feet.",
        Rarity = "Mythical",
        Icon = "rbxassetid://116585587483820",
        Model = v1:FindFirstChild("Egg Yolk Mat"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Football Goal"] = {
        Description = "A fun goal post!",
        Rarity = "Prismatic",
        Icon = "rbxassetid://83428419041866",
        Model = v1:FindFirstChild("Football Goal"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Squirrel House"] = {
        Description = "Wonder who lives in here ...",
        Rarity = "Rare",
        Icon = "rbxassetid://98770681631165",
        Model = v1:FindFirstChild("Squirrel House"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Acorn Bookshelf"] = {
        Description = "Can squirrels read?",
        Rarity = "Rare",
        Icon = "rbxassetid://133207959679854",
        Model = v1:FindFirstChild("Acorn Bookshelf"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Acorn Couch"] = {
        Description = "A place to sit for tiny critters",
        Rarity = "Rare",
        Icon = "rbxassetid://96109651776731",
        Model = v1:FindFirstChild("Acorn Couch"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Acorn Fountain"] = {
        Description = "Tiny streams from a woodland gem.",
        Rarity = "Mythical",
        Icon = "rbxassetid://136063174535857",
        Model = v1:FindFirstChild("Acorn Fountain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Acorn Lantern"] = {
        Description = "An acorn that glows brightly.",
        Rarity = "Rare",
        Icon = "rbxassetid://106427986646630",
        Model = v1:FindFirstChild("Acorn Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Acorn Mirror"] = {
        Description = "I guess squirrels need to look good too!",
        Rarity = "Rare",
        Icon = "rbxassetid://135032889367452",
        Model = v1:FindFirstChild("Acorn Mirror"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Acorn Rug"] = {
        Description = "A regular acorn rug.",
        Rarity = "Rare",
        Icon = "rbxassetid://79708170599291",
        Model = v1:FindFirstChild("Acorn Rug"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Acorn Statue"] = {
        Description = "Ooooh shiny acorn!",
        Rarity = "Mythical",
        Icon = "rbxassetid://86864992731654",
        Model = v1:FindFirstChild("Acorn Statue"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Acorn Stool"] = {
        Description = "Squirrels need to sit down and rest!",
        Rarity = "Rare",
        Icon = "rbxassetid://105779714869638",
        Model = v1:FindFirstChild("Acorn Stool"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Acorn Table"] = {
        Description = "Dinner time for squirrels!",
        Rarity = "Rare",
        Icon = "rbxassetid://96964684093251",
        Model = v1:FindFirstChild("Acorn Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Garden Lanterns"] = {
        Description = "Light up your garden!",
        Rarity = "Rare",
        Icon = "rbxassetid://109111690407497",
        Model = v1:FindFirstChild("Garden Lanterns"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Glass Bookshelf"] = {
        Description = "A clear home for hidden tales!",
        Rarity = "Legendary",
        Icon = "rbxassetid://131736832761119",
        Model = v1:FindFirstChild("Glass Bookshelf"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Glass Staircase"] = {
        Description = "Each step shimmers like dew...",
        Rarity = "Legendary",
        Icon = "rbxassetid://119725575499382",
        Model = v1:FindFirstChild("Glass Staircase"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Glass Table"] = {
        Description = "A table made of daylight!",
        Rarity = "Rare",
        Icon = "rbxassetid://96062261432935",
        Model = v1:FindFirstChild("Glass Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Party Lights"] = {
        Description = "Time to party!",
        Rarity = "Rare",
        Icon = "rbxassetid://137721146601497",
        Model = v1:FindFirstChild("Party Lights"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Round Lantern"] = {
        Description = "A lantern but round!",
        Rarity = "Rare",
        Icon = "rbxassetid://112123770115507",
        Model = v1:FindFirstChild("Round Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Street Lantern"] = {
        Description = "A little light for wandering feet!",
        Rarity = "Rare",
        Icon = "rbxassetid://110993339282133",
        Model = v1:FindFirstChild("Street Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Jack-O-Lantern"] = {
        Description = "A classic Halloween decorative staple!",
        Rarity = "Rare",
        Icon = "rbxassetid://139597230777550",
        Models = {
            v1:FindFirstChild("Happy Pumpkin"),
            v1:FindFirstChild("Devious Pumpkin"),
            v1:FindFirstChild("Sad Pumpkin"),
            v1:FindFirstChild("Cry Pumpkin"),
            v1:FindFirstChild("Sleepy Pumpkin")
        },
        Actions = {},
        Tags = { "MISC" }
    },
    ["Witch\'s Cauldron"] = {
        Description = "Double, double toil and trouble; Fire burn and cauldron bubble.",
        Rarity = "Mythical",
        Icon = "rbxassetid://73021053514257",
        Model = v1:FindFirstChild("Witch\'s Cauldron"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fog Machine"] = {
        Description = "Whispers mist into the air.",
        Rarity = "Rare",
        Icon = "rbxassetid://70889663680181",
        Model = v1:FindFirstChild("Fog Machine"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Ghost Chair"] = {
        Description = "Looks empty... yet feels alive..",
        Rarity = "Rare",
        Icon = "rbxassetid://93022780864567",
        Model = v1:FindFirstChild("Ghost Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Ghost Lantern"] = {
        Description = "A glow from the other side.",
        Rarity = "Rare",
        Icon = "rbxassetid://127706061197677",
        Model = v1:FindFirstChild("Ghost Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Halloween Basket"] = {
        Description = "Carry your tricks and treats in style.",
        Rarity = "Legendary",
        Icon = "rbxassetid://116536035330186",
        Model = v1:FindFirstChild("Halloween Basket"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Halloween Candles"] = {
        Description = "Flickers of spooky warmth.",
        Rarity = "Rare",
        Icon = "rbxassetid://130332100496134",
        Model = v1:FindFirstChild("Halloween Candles"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pallet Grave"] = {
        Description = "Watch your step!!",
        Rarity = "Legendary",
        Icon = "rbxassetid://81383255386017",
        Model = v1:FindFirstChild("Pallet Grave"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pumpkin Lantern"] = {
        Description = "Keeps the dark away with a grin.",
        Rarity = "Legendary",
        Icon = "rbxassetid://116484217723185",
        Model = v1:FindFirstChild("Pumpkin Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pumpkin Light"] = {
        Description = "Pumpkin warmth, bottled in a glow.",
        Rarity = "Rare",
        Icon = "rbxassetid://115111162877107",
        Model = v1:FindFirstChild("Pumpkin Light"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pumpkin Set"] = {
        Description = "A cozy cluster of pumpkins.",
        Rarity = "Rare",
        Icon = "rbxassetid://131102235209478",
        Model = v1:FindFirstChild("Pumpkin Set"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Skull Chain"] = {
        Description = "A rattling row of spooky smiles.",
        Rarity = "Mythical",
        Icon = "rbxassetid://104452469816621",
        Model = v1:FindFirstChild("Skull Chain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Headless Horseman Statue"] = {
        Description = "A ghost who rides a horse and carries a pumpkin instead of a head...",
        Rarity = "Divine",
        Icon = "rbxassetid://119355044809313",
        Model = v1:FindFirstChild("Headless Horseman Statue"),
        Actions = {},
        Tags = { "MISC", "STATUE" }
    },
    Tombstones = {
        Description = "Resting.. sort of.",
        Rarity = "Legendary",
        Icon = "rbxassetid://94361324763679",
        Model = v1:FindFirstChild("Tombstones"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pumpkin on a Stick"] = {
        Description = "Cheerfully creepy.",
        Rarity = "Rare",
        Icon = "rbxassetid://137947408195393",
        Model = v1:FindFirstChild("Pumpkin on a Stick"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Halloween Lights"] = {
        Description = "Twinkling lights that dance with ghostly delight.",
        Rarity = "Rare",
        Icon = "rbxassetid://121996063183790",
        Model = v1:FindFirstChild("Halloween Lights"),
        Actions = {},
        Tags = { "MISC" }
    },
    Casket = {
        Description = "Wonder who\'s inside?",
        Rarity = "Mythical",
        Icon = "rbxassetid://82910491809508",
        Model = v1:FindFirstChild("Casket"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pumpkin Scarecrow"] = {
        Description = "A grinning guardian of the haunted patch.",
        Rarity = "Legendary",
        Icon = "rbxassetid://113076006623309",
        Model = v1:FindFirstChild("Pumpkin Scarecrow"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Halloween Archway"] = {
        Description = "Step through… if you dare to delight.",
        Rarity = "Mythical",
        Icon = "rbxassetid://98723874771666",
        Model = v1:FindFirstChild("Halloween Archway"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Halloween Ribbon"] = {
        Description = "Tied with a twist of spooky cheer.",
        Rarity = "Rare",
        Icon = "rbxassetid://72805409953125",
        Model = v1:FindFirstChild("Halloween Ribbon"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Halloween Stump"] = {
        Description = "Once a tree, now a seat for spooky stories.",
        Rarity = "Legendary",
        Icon = "rbxassetid://123568924429983",
        Model = v1:FindFirstChild("Halloween Stump"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Hex Circle"] = {
        Description = "Looksss like its used for sssome ritualistic practice...",
        Rarity = "Mythical",
        Icon = "rbxassetid://87455983401272",
        Model = v1:FindFirstChild("Hex Circle"),
        Actions = {},
        Tags = { "MISC" }
    },
    Sarcophagus = {
        Description = "A great ruler deserves sarcophagorgeous burial.",
        Rarity = "Divine",
        Icon = "rbxassetid://96717470384967",
        Model = v1:FindFirstChild("Sarcophagus"),
        Actions = {},
        Tags = { "MISC" }
    },
    Gravestone = {
        Description = "RIP",
        Rarity = "Rare",
        Icon = "rbxassetid://114879563099440",
        Models = {
            v1:FindFirstChild("Gravestone_1"),
            v1:FindFirstChild("Gravestone_2"),
            v1:FindFirstChild("Gravestone_3"),
            v1:FindFirstChild("Gravestone_4"),
            v1:FindFirstChild("Gravestone_5"),
            v1:FindFirstChild("Gravestone_6")
        },
        Actions = {},
        Tags = { "MISC" }
    },
    Cobweb = {
        Description = "Don’t get tangled up in the details.",
        Rarity = "Rare",
        Icon = "rbxassetid://118924465497200",
        Models = {
            v1:FindFirstChild("Cobweb_1"),
            v1:FindFirstChild("Cobweb_2"),
            v1:FindFirstChild("Cobweb_3"),
            v1:FindFirstChild("Cobweb_4"),
            v1:FindFirstChild("Cobweb_5")
        },
        Actions = {},
        Tags = { "MISC" }
    },
    ["Graveyard Fence"] = {
        Description = "For keeping intruders out and keeping ghosts in!",
        Rarity = "Rare",
        Icon = "rbxassetid://118758054291891",
        Model = v1:FindFirstChild("Graveyard Fence"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Graveyard Lamp Post"] = {
        Description = "Lighting the way for the dearly de-parted.",
        Rarity = "Rare",
        Icon = "rbxassetid://73143571843994",
        Model = v1:FindFirstChild("Graveyard Lamp Post"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Graveyard Urn"] = {
        Description = "Oh how the tables urn?",
        Rarity = "Rare",
        Icon = "rbxassetid://89152422090075",
        Model = v1:FindFirstChild("Graveyard Urn"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Black String Lights"] = {
        Description = "Darkest lights in the spooky market.",
        Rarity = "Rare",
        Icon = "rbxassetid://126278824766131",
        Model = v1:FindFirstChild("Black String Lights"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Spell Book"] = {
        Description = "Your spooky spells in one book!",
        Rarity = "Legendary",
        Icon = "rbxassetid://107421290151802",
        Model = v1:FindFirstChild("Spell Book"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Spider Prop"] = {
        Description = "Looks like a bunch of real spiders!",
        Rarity = "Rare",
        Icon = "rbxassetid://95206497311955",
        Model = v1:FindFirstChild("Spider Prop"),
        Actions = {},
        Tags = { "MISC" }
    },
    Mausoleum = {
        Description = "A silent stone tomb where whispers never fade.",
        Rarity = "Legendary",
        Icon = "rbxassetid://100270381298737",
        Model = v1:FindFirstChild("Mausoleum"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Lich Statue"] = {
        Description = "A towering figure cloaked in shadow.",
        Rarity = "Legendary",
        Icon = "rbxassetid://76042030381858",
        Model = v1:FindFirstChild("Lich Statue"),
        Actions = {},
        Tags = { "MISC", "STATUE" }
    },
    ["Safari Arch"] = {
        Description = "Entrance to the Safari.",
        Rarity = "Legendary",
        Icon = "rbxassetid://82271666801469",
        Model = v1:FindFirstChild("Safari Arch"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Explorer Kit"] = {
        Description = "Don\'t forget your tools!",
        Rarity = "Rare",
        Icon = "rbxassetid://88961710358079",
        Model = v1:FindFirstChild("Explorer Kit"),
        Actions = {},
        Tags = { "MISC" }
    },
    Suitcases = {
        Description = "Carries all your explorer clothes and stuff",
        Rarity = "Rare",
        Icon = "rbxassetid://106137546684529",
        Model = v1:FindFirstChild("Suitcases"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Safari Tent"] = {
        Description = "Time to rest....",
        Rarity = "Legendary",
        Icon = "rbxassetid://135155740975217",
        Model = v1:FindFirstChild("Safari Tent"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Elephant Statue"] = {
        Description = "Wait ... is that a shiny elephant?",
        Rarity = "Mythical",
        Icon = "rbxassetid://105604230176380",
        Model = v1:FindFirstChild("Elephant Statue"),
        Actions = {},
        Tags = { "MISC", "STATUE" }
    },
    ["Safari Painting"] = {
        Description = "A nice painting of the Safari.",
        Rarity = "Rare",
        Icon = "rbxassetid://119129370276754",
        Model = v1:FindFirstChild("Safari Painting"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Basketball Hoop"] = {
        Description = "Lets play ball!",
        Rarity = "Rare",
        Icon = "rbxassetid://106112826191131",
        Model = v1:FindFirstChild("Basketball Hoop"),
        Actions = {},
        Tags = { "MISC" }
    },
    Bonfire = {
        Description = "Gather \'round the bonfire.",
        Rarity = "Rare",
        Icon = "rbxassetid://105815532052304",
        Model = v1:FindFirstChild("Bonfire"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Rotary Clothesline"] = {
        Description = "Set the clothes to spin dry.",
        Rarity = "Rare",
        Icon = "rbxassetid://135671594715771",
        Model = v1:FindFirstChild("Rotary Clothesline"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Flower Bench"] = {
        Description = "They are very strong flowers.",
        Rarity = "Rare",
        Icon = "rbxassetid://124929387730332",
        Model = v1:FindFirstChild("Flower Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Garden Arbor"] = {
        Description = "A charming wooden arbor perfect for any garden entrance.",
        Rarity = "Rare",
        Icon = "rbxassetid://113516853670313",
        Model = v1:FindFirstChild("Garden Arbor"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Garden Workbench"] = {
        Description = "A useful bench for working outdoors.",
        Rarity = "Rare",
        Icon = "rbxassetid://82693446156704",
        Model = v1:FindFirstChild("Garden Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Garden Hose"] = {
        Description = "A trusty hose for watering your plants.",
        Rarity = "Rare",
        Icon = "rbxassetid://124616104262605",
        Model = v1:FindFirstChild("Garden Hose"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Garden Shed"] = {
        Description = "A small shed to store all your gardening tools.",
        Rarity = "Rare",
        Icon = "rbxassetid://138121014938433",
        Model = v1:FindFirstChild("Garden Shed"),
        Actions = {},
        Tags = { "MISC" }
    },
    Gazebo = {
        Description = "A beautiful outdoor gazebo for shade and style.",
        Rarity = "Rare",
        Icon = "rbxassetid://140215849240233",
        Model = v1:FindFirstChild("Gazebo"),
        Actions = {},
        Tags = { "MISC" }
    },
    Grill = {
        Description = "A shiny grill for your next backyard barbecue.",
        Rarity = "Rare",
        Icon = "rbxassetid://115167736334853",
        Model = v1:FindFirstChild("Grill"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Manual Lawnmower"] = {
        Description = "An old-school manual lawnmower for a bit of a workout.",
        Rarity = "Rare",
        Icon = "rbxassetid://80251024139315",
        Model = v1:FindFirstChild("Manual Lawnmower"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Mossy Rock"] = {
        Description = "A moss-covered rock to add some nature to your yard.",
        Rarity = "Rare",
        Icon = "rbxassetid://103711780677419",
        Model = v1:FindFirstChild("Mossy Rock"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sun Dial"] = {
        Description = "A classic sun dial to tell time the old-fashioned way.",
        Rarity = "Rare",
        Icon = "rbxassetid://98602814047955",
        Model = v1:FindFirstChild("Sun Dial"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Skull Chair"] = {
        Description = "A throne carved from bone and shadow.",
        Rarity = "Legendary",
        Icon = "rbxassetid://94644139300848",
        Model = v1:FindFirstChild("Skull Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Silver Beetle Trophy"] = {
        Description = "For the almost champions.",
        Rarity = "Rare",
        Icon = "rbxassetid://106695276316428",
        Model = v1:FindFirstChild("Silver Beetle Trophy"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Gold Beetle Trophy"] = {
        Description = "For the champions.",
        Rarity = "Legendary",
        Icon = "rbxassetid://117363879598257",
        Model = v1:FindFirstChild("Gold Beetle Trophy"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Pine Beetle Trophy"] = {
        Description = "For the festive champions.",
        Rarity = "Legendary",
        Icon = "rbxassetid://91545706770851",
        Model = v1:FindFirstChild("Pine Beetle Trophy"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Safari Animal Statue"] = {
        Description = "Different Safari animals carved into beautiful marble.",
        Rarity = "Legendary",
        Icon = "rbxassetid://114149311930351",
        Models = {
            v1:FindFirstChild("Safari Oxpecker Statue"),
            v1:FindFirstChild("Safari Zebra Statue"),
            v1:FindFirstChild("Safari Giraffe Statue"),
            v1:FindFirstChild("Safari Rhino Statue"),
            v1:FindFirstChild("Safari Elephant Statue")
        },
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Safari Chair"] = {
        Description = "Take a break from exploring the Safari.",
        Rarity = "Rare",
        Icon = "rbxassetid://107278965484084",
        Model = v1:FindFirstChild("Safari Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Lion Rug"] = {
        Description = "A fluffy lion rug that looks fierce but feels fancy.",
        Rarity = "Rare",
        Icon = "rbxassetid://121092374245194",
        Model = v1:FindFirstChild("Lion Rug"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Open Tent"] = {
        Description = "Adventure outside, snacks and chill vibes inside.",
        Rarity = "Legendary",
        Icon = "rbxassetid://112740184415387",
        Model = v1:FindFirstChild("Open Tent"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Safari Car Statue"] = {
        Description = "A miniature safari truck frozen mid-adventure.",
        Rarity = "Legendary",
        Icon = "rbxassetid://87392652878665",
        Model = v1:FindFirstChild("Safari Car Statue"),
        Actions = {},
        Tags = { "MISC", "STATUE" }
    },
    ["Safari Lamp Post"] = {
        Description = "Glows like a cozy campfire for explorers.",
        Rarity = "Rare",
        Icon = "rbxassetid://94681144072423",
        Model = v1:FindFirstChild("Safari Lamp Post"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Safari Telescope"] = {
        Description = "Rugged safari telescope perched on a tripod, ready to spy lions in the wild….",
        Rarity = "Rare",
        Icon = "rbxassetid://84440344986769",
        Model = v1:FindFirstChild("Safari Telescope"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Safari Shipping Container"] = {
        Description = "Special imported fruits from the Safari!",
        Rarity = "Mythical",
        Icon = "rbxassetid://79434384379842",
        Model = v1:FindFirstChild("Safari Shipping Container"),
        Actions = {},
        Tags = { "MISC" }
    },
    Anvil = {
        Description = "Perfect for crafting masterpieces or just making a lot of noise.",
        Rarity = "Rare",
        Icon = "rbxassetid://93100248901098",
        Model = v1:FindFirstChild("Anvil"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Anvil Statue"] = {
        Description = "Silent now, but it still hums with the echoes of a thousand strikes.",
        Rarity = "Legendary",
        Icon = "rbxassetid://126995080935350",
        Model = v1:FindFirstChild("Anvil Statue"),
        Actions = {},
        Tags = { "MISC", "STATUE" }
    },
    ["Coal Box"] = {
        Description = "Where embers rest, waiting for their next forge-born flame.",
        Rarity = "Rare",
        Icon = "rbxassetid://97680338753167",
        Model = v1:FindFirstChild("Coal Box"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blacksmith Grinder"] = {
        Description = "Designed for grinding, shaping, and sharpening metal. Watch your fingers!",
        Rarity = "Legendary",
        Icon = "rbxassetid://78243597750567",
        Model = v1:FindFirstChild("Blacksmith Grinder"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Shield Statue"] = {
        Description = "A proud shield statue, standing ready… though don’t expect it to block any real dragons!",
        Rarity = "Mythical",
        Icon = "rbxassetid://76837871817367",
        Model = v1:FindFirstChild("Shield Statue"),
        Actions = {},
        Tags = { "MISC", "STATUE" }
    },
    ["Tools Rack"] = {
        Description = "Hammers and tongs neatly displayed... ready for forging legends...",
        Rarity = "Rare",
        Icon = "rbxassetid://123860695640127",
        Model = v1:FindFirstChild("Tools Rack"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Garden Signpost"] = {
        Description = "Guiding lost gardeners since... well, whenever it feels like it...",
        Rarity = "Rare",
        Icon = "rbxassetid://87078986230727",
        Model = v1:FindFirstChild("Garden Signpost"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Metal Ladder"] = {
        Description = "Sturdy steps to reach new heights (or tall tomatoes).",
        Rarity = "Rare",
        Icon = "rbxassetid://121044177049636",
        Model = v1:FindFirstChild("Metal Ladder"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sack Pallet"] = {
        Description = "A tidy stack of bundled goods, ready for any hardworking gardener’s day.",
        Rarity = "Rare",
        Icon = "rbxassetid://88252397951881",
        Model = v1:FindFirstChild("Sack Pallet"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Seed Display"] = {
        Description = "Are those the old seedpacks?!",
        Rarity = "Legendary",
        Icon = "rbxassetid://86420818588158",
        Model = v1:FindFirstChild("Seed Display"),
        Actions = {},
        Tags = { "MISC" }
    },
    Trellis = {
        Description = "A gentle climb for wandering vines.",
        Rarity = "Rare",
        Icon = "rbxassetid://96391014646182",
        Model = v1:FindFirstChild("Trellis"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wagon Planter"] = {
        Description = "Old wheels, new life...flowers hit the road in style.",
        Rarity = "Rare",
        Icon = "rbxassetid://137046567395908",
        Model = v1:FindFirstChild("Wagon Planter"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Horse Shoe Magnet"] = {
        Description = "A curious charm said to draw nearby critters with its magnetic pull...",
        Rarity = "Mythical",
        Icon = "rbxassetid://114819719255479",
        Undeletable = true,
        Model = v1:FindFirstChild("Horse Shoe Magnet"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gem Chair"] = {
        Description = "A comfy seat covered in little gems.",
        Rarity = "Rare",
        Icon = "rbxassetid://92482271426460",
        Model = v1:FindFirstChild("Gem Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gem Table"] = {
        Description = "A gem-lit table that glows with a gentle, colorful shimmer.",
        Rarity = "Rare",
        Icon = "rbxassetid://81382564359168",
        Model = v1:FindFirstChild("Gem Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gem Lamp"] = {
        Description = "A bright little lamp powered by pure crystal sparkle.",
        Rarity = "Rare",
        Icon = "rbxassetid://123195871956713",
        Model = v1:FindFirstChild("Gem Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gem Bookshelf"] = {
        Description = "A crystal-lined shelf that makes every book feel like treasure.",
        Rarity = "Rare",
        Icon = "rbxassetid://122681872342416",
        Model = v1:FindFirstChild("Gem Bookshelf"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gem Bench"] = {
        Description = "A radiant bench studded with twinkling stones.",
        Rarity = "Rare",
        Icon = "rbxassetid://129352519789499",
        Model = v1:FindFirstChild("Gem Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Silver Ingot"] = {
        Description = "A shiny bar of silver.",
        Rarity = "Rare",
        Icon = "rbxassetid://96553028511092",
        Model = v1:FindFirstChild("Silver Ingot"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gold Ingot"] = {
        Description = "A very shiny bar of gold.",
        Rarity = "Legendary",
        Icon = "rbxassetid://87430159003961",
        Model = v1:FindFirstChild("Gold Ingot"),
        Actions = {},
        Tags = { "MISC" }
    },
    Smelter = {
        Description = "Bubbles, burns, and blazes—this smelter turns rocky ore into shiny, shapable metal.",
        Rarity = "Rare",
        Icon = "rbxassetid://109370809205883",
        Model = v1:FindFirstChild("Smelter"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Forge Blower"] = {
        Description = "An old-style forge blower that wheezes and whirs, breathing life into the flames.",
        Rarity = "Rare",
        Icon = "rbxassetid://71753838383643",
        Model = v1:FindFirstChild("Forge Blower"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cooling Barrel"] = {
        Description = "A splashy barrel where red-hot metal goes ‘hisss!’ and chills out.",
        Rarity = "Rare",
        Icon = "rbxassetid://102821774461827",
        Model = v1:FindFirstChild("Cooling Barrel"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Blacksmith Forge"] = {
        Description = "Where metal takes a fiery bath before being hammered into greatness.",
        Rarity = "Legendary",
        Icon = "rbxassetid://81645215037629",
        Model = v1:FindFirstChild("Blacksmith Forge"),
        Actions = {},
        Tags = { "MISC" }
    },
    Bellows = {
        Description = "A puff-powered helper that keeps the fire lively.",
        Rarity = "Legendary",
        Icon = "rbxassetid://89019460036468",
        Model = v1:FindFirstChild("Bellows"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Christmas Gift Small"] = {
        Description = "I wonder what\'s inside? Something tiny?",
        Rarity = "Uncommon",
        Icon = "rbxassetid://83663076636173",
        Model = v1:FindFirstChild("Christmas Gift Small"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Christmas Gift Medium"] = {
        Description = "I wonder what\'s inside? Something just right?",
        Rarity = "Uncommon",
        Icon = "rbxassetid://71573321333783",
        Model = v1:FindFirstChild("Christmas Gift Medium"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Christmas Gift Large"] = {
        Description = "I wonder what\'s inside? Something huge?",
        Rarity = "Uncommon",
        Icon = "rbxassetid://103596951824599",
        Model = v1:FindFirstChild("Christmas Gift Large"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Christmas Gift Tall"] = {
        Description = "I wonder what\'s inside? Something tall?",
        Rarity = "Uncommon",
        Icon = "rbxassetid://128072199521894",
        Model = v1:FindFirstChild("Christmas Gift Tall"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Christmas Gift Long"] = {
        Description = "I wonder what\'s inside? Something long?",
        Rarity = "Uncommon",
        Icon = "rbxassetid://111339711670641",
        Model = v1:FindFirstChild("Christmas Gift Long"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Christmas Gift Tube"] = {
        Description = "I wonder what\'s inside? Something cylindrical?",
        Rarity = "Uncommon",
        Icon = "rbxassetid://76106924019987",
        Model = v1:FindFirstChild("Christmas Gift Tube"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Snow Fort Wall"] = {
        Description = "Perfect for keeping snowballs on *their* side.",
        Rarity = "Rare",
        Icon = "rbxassetid://122786444825708",
        Model = v1:FindFirstChild("Snow Fort Wall"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Snow Fort Staircase"] = {
        Description = "Rise above all, one crunchy snow step at a time.",
        Rarity = "Rare",
        Icon = "rbxassetid://98124209949698",
        Model = v1:FindFirstChild("Snow Fort Staircase"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Snow Fort Tower"] = {
        Description = "Its over snowmen, I have the high ground!",
        Rarity = "Rare",
        Icon = "rbxassetid://126116444637716",
        Model = v1:FindFirstChild("Snow Fort Tower"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Snow Fort Banner"] = {
        Description = "Wintery fabric.",
        Rarity = "Rare",
        Icon = "rbxassetid://115050520456825",
        Model = v1:FindFirstChild("Snow Fort Banner"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Snow Fort Gate"] = {
        Description = "Open wide the grand entrance to a frosty kingdom.",
        Rarity = "Rare",
        Icon = "rbxassetid://75020265466703",
        Model = v1:FindFirstChild("Snow Fort Gate"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Snow Fort Lantern"] = {
        Description = "A warm glow in a cold world. Light up those late night sieges.",
        Rarity = "Rare",
        Icon = "rbxassetid://116202214397669",
        Model = v1:FindFirstChild("Snow Fort Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Winter Bridge"] = {
        Description = "A cozy winter bridge wrapped in garlands and frost.",
        Rarity = "Legendary",
        Icon = "rbxassetid://130817083747877",
        Model = v1:FindFirstChild("Winter Bridge"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Frost Rune"] = {
        Description = "A mysterious rune etched in ancient ice.",
        Rarity = "Legendary",
        Icon = "rbxassetid://84232130989736",
        Model = v1:FindFirstChild("Frost Rune"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Frozen Pond"] = {
        Description = "A still pond captured in frost.",
        Rarity = "Rare",
        Icon = "rbxassetid://125623633434242",
        Model = v1:FindFirstChild("Frozen Pond"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Winter Arch"] = {
        Description = "Walk through winter’s welcome—complete with bell and bow.",
        Rarity = "Mythical",
        Icon = "rbxassetid://104242207664536",
        Model = v1:FindFirstChild("Winter Arch"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Winter Fountain"] = {
        Description = "Silent waters, sparkling frost.",
        Rarity = "Legendary",
        Icon = "rbxassetid://83474243882209",
        Model = v1:FindFirstChild("Winter Fountain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Winter Globe"] = {
        Description = "A tiny frozen wonderland.",
        Rarity = "Mythical",
        Icon = "rbxassetid://102511160943340",
        Model = v1:FindFirstChild("Winter Globe"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Winter Lantern"] = {
        Description = "Soft light in a world of snow.",
        Rarity = "Rare",
        Icon = "rbxassetid://125345612856155",
        Model = v1:FindFirstChild("Winter Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Winter Wheelbarrow"] = {
        Description = "Hauling snow and holiday cheer.",
        Rarity = "Rare",
        Icon = "rbxassetid://136354706459270",
        Model = v1:FindFirstChild("Winter Wheelbarrow"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Toy Horse"] = {
        Description = "Trotting in festive style.",
        Rarity = "Rare",
        Icon = "rbxassetid://135018077483755",
        Model = v1:FindFirstChild("Toy Horse"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Ice Table"] = {
        Description = "Ice cold table and chair.",
        Rarity = "Rare",
        Icon = "rbxassetid://121679969550679",
        Model = v1:FindFirstChild("Ice Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Christmas Lamp"] = {
        Description = "The most festive lamp there ever was.",
        Rarity = "Legendary",
        Icon = "rbxassetid://84954761168545",
        Model = v1:FindFirstChild("Christmas Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    Nutcracker = {
        Description = "A wooden hero brought to life for the holidays.",
        Rarity = "Legendary",
        Icon = "rbxassetid://108460999021109",
        Model = v1:FindFirstChild("Nutcracker"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Christmas Bench"] = {
        Description = "A merry little bench ready for holiday memories.",
        Rarity = "Legendary",
        Icon = "rbxassetid://89433127103432",
        Model = v1:FindFirstChild("Christmas Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Penguin Statue"] = {
        Description = "This little penguin may not swim, but it sure knows how to strike a pose.",
        Rarity = "Legendary",
        Icon = "rbxassetid://102293094118977",
        Model = v1:FindFirstChild("Penguin Statue"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Candycane Fence"] = {
        Description = "A fence so sweet, you almost want to take a bite!",
        Rarity = "Legendary",
        Icon = "rbxassetid://133577137208326",
        Model = v1:FindFirstChild("Candycane Fence"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Christmas Tree Painting"] = {
        Description = "A colorful tree captured on canvas.",
        Rarity = "Rare",
        Icon = "rbxassetid://109269916258884",
        Model = v1:FindFirstChild("Christmas Tree Painting"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Elf Chair"] = {
        Description = "A cheerful little chair, ready for an elf to take a seat.",
        Rarity = "Rare",
        Icon = "rbxassetid://111334528868338",
        Model = v1:FindFirstChild("Elf Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gift Stack"] = {
        Description = "Presents piled high — who’s lucky enough to open them first?",
        Rarity = "Rare",
        Icon = "rbxassetid://92235206873270",
        Model = v1:FindFirstChild("Gift Stack"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Christmas Ribbon"] = {
        Description = "A ribbon so festive, it practically jingles with Christmas spirit.",
        Rarity = "Rare",
        Icon = "rbxassetid://93565308522143",
        Model = v1:FindFirstChild("Christmas Ribbon"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Christmas Lights"] = {
        Description = "Glowing bulbs that shimmer with holiday magic.",
        Rarity = "Rare",
        Icon = "rbxassetid://95522328864056",
        Model = v1:FindFirstChild("Christmas Lights"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Frozen Krampus"] = {
        Description = "The fearsome Krampus, paused in icy stillness, waiting in winter’s grip.",
        Rarity = "Legendary",
        Icon = "rbxassetid://122618334241261",
        Model = v1:FindFirstChild("Frozen Krampus"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Santa Chair"] = {
        Description = "Santa’s special chair, waiting for the holiday magic to begin.",
        Rarity = "Rare",
        Icon = "rbxassetid://138218541127571",
        Model = v1:FindFirstChild("Santa Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    Snowman = {
        Description = "A friendly snowman, ready for snowball fights and winter fun.",
        Rarity = "Rare",
        Icon = "rbxassetid://93488154659802",
        Model = v1:FindFirstChild("Snowman"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Snowman Lights"] = {
        Description = "Snowman-shaped lights that brighten up any festive scene.",
        Rarity = "Rare",
        Icon = "rbxassetid://139945494671286",
        Model = v1:FindFirstChild("Snowman Lights"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Hot Chocolate Mug"] = {
        Description = "COSMETIC: Nothing beats a cup of hot Cocoa on a cold winter night...",
        Rarity = "Rare",
        Icon = "rbxassetid://81385371190734",
        Model = v1:FindFirstChild("Hot Chocolate Mug"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Snow Globe"] = {
        Description = "Snowflakes trapped in a globe of magic!",
        Rarity = "Mythical",
        Icon = "rbxassetid://102600165060105",
        Model = v1:FindFirstChild("Snow Globe"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["North Pole Sign"] = {
        Description = "North Pole: Santa’s Playground!",
        Rarity = "Legendary",
        Icon = "rbxassetid://136433741552918",
        Model = v1:FindFirstChild("North Pole Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Christmas Drums"] = {
        Description = "Drum up some holiday cheer!",
        Rarity = "Legendary",
        Icon = "rbxassetid://88210316515948",
        Model = v1:FindFirstChild("Christmas Drums"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Christmas Ornament"] = {
        Description = "Comes in different vibrant colors to elevate your Christmas Tree!",
        Rarity = "Uncommon",
        Icon = "rbxassetid://98655021197453",
        Models = {
            v1:FindFirstChild("Christmas Ornament Red"),
            v1:FindFirstChild("Christmas Ornament Green"),
            v1:FindFirstChild("Christmas Ornament Blue"),
            v1:FindFirstChild("Christmas Ornament Yellow")
        },
        Actions = {},
        Tags = { "MISC" }
    },
    ["Christmas Topper"] = {
        Description = "The final touch to your Christmas Tree!!",
        Rarity = "Rare",
        Icon = "rbxassetid://86949094785347",
        Model = v1:FindFirstChild("Christmas Topper"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Disco Ball"] = {
        Description = "It\'s the new year time to party!!",
        Rarity = "Rare",
        Icon = "rbxassetid://119643167400356",
        Model = v1:FindFirstChild("Disco Ball"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Party Sign"] = {
        Description = "Let everyone know where the party is at!",
        Rarity = "Rare",
        Icon = "rbxassetid://118455719780708",
        Model = v1:FindFirstChild("Party Sign"),
        Actions = {},
        Tags = { "SIGN" }
    },
    ["Firework Shooter"] = {
        Description = "Insert fireworks here and launch!",
        Rarity = "Rare",
        Icon = "rbxassetid://118051589631565",
        Model = v1:FindFirstChild("Firework Shooter"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Confetti Cannon"] = {
        Description = "Throw confetti like its the new year everyday.",
        Rarity = "Rare",
        Icon = "rbxassetid://126531195035317",
        Model = v1:FindFirstChild("Confetti Cannon"),
        Actions = {},
        Tags = { "MISC" }
    },
    Sparkler = {
        Description = "Let the sparks fly.",
        Rarity = "Rare",
        Icon = "rbxassetid://97349039087490",
        Model = v1:FindFirstChild("Sparkler"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Firework Rockets"] = {
        Description = "The works. The Fireworks.",
        Rarity = "Rare",
        Icon = "rbxassetid://89508568465290",
        Model = v1:FindFirstChild("Firework Rockets"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Party Hat"] = {
        Description = "For the New Year and for your head!",
        Rarity = "Rare",
        Icon = "rbxassetid://118589533938333",
        Models = { v1:FindFirstChild("Polka Dot Party Hat"), v1:FindFirstChild("Black Party Hat") },
        Actions = {},
        Tags = { "MISC" }
    },
    ["Clockwork Key"] = {
        Description = "What could this possibly unlock? We may never know.",
        Rarity = "Rare",
        Icon = "rbxassetid://75020102537955",
        Model = v1:FindFirstChild("Clockwork Key"),
        Actions = {},
        Tags = { "MISC" }
    },
    Chains = {
        Description = "Chain, chain go away.",
        Rarity = "Rare",
        Icon = "rbxassetid://129196816165190",
        Model = v1:FindFirstChild("Chains"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gear Wheel"] = {
        Description = "A gear wheel (or just gear) is a rotating machine part with teeth (cogs) around its edge, designed to mesh with another toothed part to transmit rotational motion, power, or change speed/direction in a mechanism, with synonyms like cogwheel, toothed wheel, or pinion (for a small gear). It\'s a fundamental component in mechanics, forming gear trains when multiple gears interlock, controlling how force and speed are managed in devices from clocks to cars.",
        Rarity = "Rare",
        Icon = "rbxassetid://135771267664982",
        Model = v1:FindFirstChild("Gear Wheel"),
        Actions = {},
        Tags = { "MISC" }
    },
    Pipes = {
        Description = "Transfer liquids between to points or drop it. It makes a funny sound!",
        Rarity = "Rare",
        Icon = "rbxassetid://88609712593803",
        Model = v1:FindFirstChild("Pipes"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Clockwork Lantern"] = {
        Description = "Light up those intricate machineries.",
        Rarity = "Rare",
        Icon = "rbxassetid://106767732565639",
        Model = v1:FindFirstChild("Clockwork Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bell Arch"] = {
        Description = "A cozy arch crowned with one grand bell.",
        Rarity = "Mythical",
        Icon = "rbxassetid://95765932512980",
        Model = v1:FindFirstChild("Bell Arch"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Big Chair"] = {
        Description = "A big, cozy chair that feels perfect for resting after a long day in the garden.",
        Rarity = "Mythical",
        Icon = "rbxassetid://123149649402544",
        Model = v1:FindFirstChild("Big Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Chain Swing"] = {
        Description = "A playful chain swing that gently sways, adding a touch of fun and charm to your garden.",
        Rarity = "Mythical",
        Icon = "rbxassetid://82216889205694",
        Model = v1:FindFirstChild("Chain Swing"),
        Actions = {},
        Tags = { "MISC" }
    },
    Dresser = {
        Description = "Stack, stash, and style—your outfit’s happy place.",
        Rarity = "Mythical",
        Icon = "rbxassetid://121541278874931",
        Model = v1:FindFirstChild("Dresser"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Flower Bridge"] = {
        Description = "A bridge that blooms as beautifully as it connects.",
        Rarity = "Mythical",
        Icon = "rbxassetid://84037821709636",
        Model = v1:FindFirstChild("Flower Bridge"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Flower Cart"] = {
        Description = "Fresh flowers, happy vibes, zero traffic jams.",
        Rarity = "Mythical",
        Icon = "rbxassetid://120709604627317",
        Model = v1:FindFirstChild("Flower Cart"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Giant Scorpion Statue"] = {
        Description = "Big, bold, and ready to sting your imagination.",
        Rarity = "Mythical",
        Icon = "rbxassetid://81049787896991",
        Model = v1:FindFirstChild("Giant Scorpion Statue"),
        Actions = {},
        Tags = { "MISC" }
    },
    Gramophone = {
        Description = "Spinning tunes and old-school charm, one crackle at a time.",
        Rarity = "Mythical",
        Icon = "rbxassetid://112737038077633",
        Model = v1:FindFirstChild("Gramophone"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Lab Samples"] = {
        Description = "Small tubes, massive potential.",
        Rarity = "Mythical",
        Icon = "rbxassetid://84743529605346",
        Model = v1:FindFirstChild("Lab Samples"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Medieval Table"] = {
        Description = "Where knights, peasants, and snacks all feel welcome.",
        Rarity = "Mythical",
        Icon = "rbxassetid://85316821603093",
        Model = v1:FindFirstChild("Medieval Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Piano Set"] = {
        Description = "A mini concert waiting to happen.",
        Rarity = "Mythical",
        Icon = "rbxassetid://140100425394401",
        Model = v1:FindFirstChild("Piano Set"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Power Lamp"] = {
        Description = "Power on, worries off.",
        Rarity = "Mythical",
        Icon = "rbxassetid://71162989597476",
        Model = v1:FindFirstChild("Power Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    Sandpit = {
        Description = "Where castles rise and boredom sinks.",
        Rarity = "Mythical",
        Icon = "rbxassetid://128303287766722",
        Model = v1:FindFirstChild("Sandpit"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Simple Shelf"] = {
        Description = "A tidy spot for your treasures and trinkets.",
        Rarity = "Mythical",
        Icon = "rbxassetid://87369657966088",
        Model = v1:FindFirstChild("Simple Shelf"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Steampunk Lamp"] = {
        Description = "Turning heads and cranking up the charm.",
        Rarity = "Mythical",
        Icon = "rbxassetid://87686180805440",
        Model = v1:FindFirstChild("Steampunk Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sword In Stone"] = {
        Description = "Where heroes are made, one tug at a time.",
        Rarity = "Mythical",
        Icon = "rbxassetid://122152059621951",
        Model = v1:FindFirstChild("Sword In Stone"),
        Actions = {},
        Tags = { "MISC" }
    },
    Tarp = {
        Description = "Simple, sturdy, and ready for anything.",
        Rarity = "Mythical",
        Icon = "rbxassetid://131024443587365",
        Model = v1:FindFirstChild("Tarp"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Water Tank"] = {
        Description = "Your trusty reservoir for all things splashy.",
        Rarity = "Mythical",
        Icon = "rbxassetid://133481476446725",
        Model = v1:FindFirstChild("Water Tank"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wooden Throne"] = {
        Description = "A seat fit for legends (and long naps).",
        Rarity = "Mythical",
        Icon = "rbxassetid://78124872369170",
        Model = v1:FindFirstChild("Wooden Throne"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wooden Well"] = {
        Description = "A wooden well that’s deep on character.",
        Rarity = "Mythical",
        Icon = "rbxassetid://84223199265594",
        Model = v1:FindFirstChild("Wooden Well"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Storage Frame"] = {
        Description = "A sleek spot for all the bits and bobs you cherish.",
        Rarity = "Mythical",
        Icon = "rbxassetid://125538849640600",
        Model = v1:FindFirstChild("Storage Frame"),
        Actions = {},
        Tags = { "MISC" }
    },
    Chainsaw = {
        Description = "Big teeth, bigger fun.",
        Rarity = "Mythical",
        Icon = "rbxassetid://95311524007342",
        Model = v1:FindFirstChild("Chainsaw"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Carnival Arch"] = {
        Description = "Step right up! This cheerful arch marks the start of carnival magic.",
        Rarity = "Mythical",
        Icon = "rbxassetid://103716276123603",
        Model = v1:FindFirstChild("Carnival Arch"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fire Ring"] = {
        Description = "A fiery hoop made for carnival showstoppers.",
        Rarity = "Mythical",
        Icon = "rbxassetid://129168923594236",
        Model = v1:FindFirstChild("Fire Ring"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Carnival Ribbon"] = {
        Description = "A colorful ribbon made for festive carnival flair.",
        Rarity = "Rare",
        Icon = "rbxassetid://130862824234035",
        Model = v1:FindFirstChild("Carnival Ribbon"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Carnival Flag"] = {
        Description = "A festive flag for carnival fun.",
        Rarity = "Rare",
        Icon = "rbxassetid://104560158750928",
        Model = v1:FindFirstChild("Carnival Flag"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Magic Bunny"] = {
        Description = "Surprise! A fluffy bunny hops out of this magic hat.",
        Rarity = "Legendary",
        Icon = "rbxassetid://71561328489060",
        Model = v1:FindFirstChild("Magic Bunny"),
        Actions = {},
        Tags = { "MISC" }
    },
    Unicycle = {
        Description = "A classic carnival unicycle.",
        Rarity = "Legendary",
        Icon = "rbxassetid://73128977042804",
        Model = v1:FindFirstChild("Unicycle"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Valentine Arch"] = {
        Description = "A cute valentine arch.",
        Rarity = "Legendary",
        Icon = "rbxassetid://97219704562929",
        Model = v1:FindFirstChild("Valentine Arch"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Heart Bench"] = {
        Description = "A cute heart bench.",
        Rarity = "Legendary",
        Icon = "rbxassetid://128917754594343",
        Model = v1:FindFirstChild("Heart Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["L Heart Sign"] = {
        Description = "A cute sign with the letter L.",
        Rarity = "Legendary",
        Icon = "rbxassetid://98514769555823",
        Model = v1:FindFirstChild("L Heart Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["O Heart Sign"] = {
        Description = "A cute sign with the letter O.",
        Rarity = "Legendary",
        Icon = "rbxassetid://109734954051672",
        Model = v1:FindFirstChild("O Heart Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["V Heart Sign"] = {
        Description = "A cute sign with the letter V.",
        Rarity = "Legendary",
        Icon = "rbxassetid://91291345238598",
        Model = v1:FindFirstChild("V Heart Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["E Heart Sign"] = {
        Description = "A cute sign with the letter E.",
        Rarity = "Legendary",
        Icon = "rbxassetid://122286172972373",
        Model = v1:FindFirstChild("E Heart Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Heart Arch"] = {
        Description = "Beautiful heart arch.",
        Rarity = "Legendary",
        Icon = "rbxassetid://128917754594343",
        Model = v1:FindFirstChild("Heart Arch"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Heart String Light"] = {
        Description = "A cute post with heart lights.",
        Rarity = "Legendary",
        Icon = "rbxassetid://126349155864878",
        Model = v1:FindFirstChild("Heart String Light"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Baby Cupid Statue"] = {
        Description = "A cute baby cupid statue to display.",
        Rarity = "Legendary",
        Icon = "rbxassetid://128337355541873",
        Model = v1:FindFirstChild("Baby Cupid Statue"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Valentines Mailbox"] = {
        Description = "Best way to get a letter from that special someone.",
        Rarity = "Legendary",
        Icon = "rbxassetid://130900999578592",
        Model = v1:FindFirstChild("Valentines Mailbox"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Love Walkway"] = {
        Description = "A cute walkway.",
        Rarity = "Legendary",
        Icon = "rbxassetid://114763613429040",
        Model = v1:FindFirstChild("Love Walkway"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Red Rose Fox Statue"] = {
        Description = "Displays a cute red rose fox!",
        Rarity = "Legendary",
        Icon = "rbxassetid://91154040471814",
        Model = v1:FindFirstChild("Red Rose Fox Statue"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Heart Bridge"] = {
        Description = "A bridge with hearts on it.",
        Rarity = "Legendary",
        Icon = "rbxassetid://74260656011472",
        Model = v1:FindFirstChild("Heart Bridge"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cross Heart Statue"] = {
        Description = "This statue was struck by cupid.",
        Rarity = "Legendary",
        Icon = "rbxassetid://136252630962023",
        Model = v1:FindFirstChild("Cross Heart Statue"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Angel Arrow Statue"] = {
        Description = "A cute angel with a bow.",
        Rarity = "Legendary",
        Icon = "rbxassetid://109725256981468",
        Model = v1:FindFirstChild("Angel Arrow Statue"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Heart Fountain"] = {
        Description = "Beautiful heart shaped fountain.",
        Rarity = "Legendary",
        Icon = "rbxassetid://73111367882659",
        Model = v1:FindFirstChild("Heart Fountain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Heart Stepping Stone"] = {
        Description = "A pathway that is shaped like a heart.",
        Rarity = "Legendary",
        Icon = "rbxassetid://79739309175027",
        Model = v1:FindFirstChild("Heart Stepping Stone"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Heart Shaped Gate"] = {
        Description = "A gate that is shaped like a heart with roses!",
        Rarity = "Legendary",
        Icon = "rbxassetid://73467197257053",
        Model = v1:FindFirstChild("Heart Shaped Gate"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Clover String Light"] = {
        Description = "A string of clover shaped lights!",
        Rarity = "Legendary",
        Icon = "rbxassetid://110689828351845",
        Model = v1:FindFirstChild("Clover String Light"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pot of Gold"] = {
        Description = "A golden pot.. that has gold!",
        Rarity = "Legendary",
        Icon = "rbxassetid://123629969648843",
        Model = v1:FindFirstChild("Pot of Gold"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Clover Statue"] = {
        Description = "A statue of a beautiful clover!",
        Rarity = "Legendary",
        Icon = "rbxassetid://98275012940649",
        Model = v1:FindFirstChild("Clover Statue"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Golden Throne"] = {
        Description = "A regal seat made from pure gold. Perfect for ruling over your garden plots.",
        Rarity = "Rare",
        Icon = "rbxassetid://105877034009358",
        Model = v1:FindFirstChild("Golden Throne"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Picnic Table"] = {
        Description = "A cozy picnic table for relaxing.",
        Rarity = "Rare",
        Icon = "rbxassetid://105025670459365",
        Model = v1:FindFirstChild("Picnic Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Garden Basin"] = {
        Description = "Keep your garden plots feeling fresh.",
        Rarity = "Rare",
        Icon = "rbxassetid://130284931152446",
        Model = v1:FindFirstChild("Garden Basin"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Vine Bench"] = {
        Description = "Leafy vine bench, perfect for resting.",
        Rarity = "Legendary",
        Icon = "rbxassetid://97843511506024",
        Model = v1:FindFirstChild("Vine Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Garden Shade"] = {
        Description = "Keeps you cool while you nurture your garden plots.",
        Rarity = "Legendary",
        Icon = "rbxassetid://102223718437962",
        Model = v1:FindFirstChild("Garden Shade"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Lava Arch"] = {
        Description = "Fiery gateway that marks the path through molten gardens.",
        Rarity = "Mythical",
        Icon = "rbxassetid://84382700238502",
        Model = v1:FindFirstChild("Lava Arch"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Lava Fountain"] = {
        Description = "Blazing fountain of molten lava.",
        Rarity = "Mythical",
        Icon = "rbxassetid://136366934293320",
        Model = v1:FindFirstChild("Lava Fountain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pool Table"] = {
        Description = "Classic table for a friendly game, indoors or out.",
        Rarity = "Rare",
        Icon = "rbxassetid://99417028609088",
        Model = v1:FindFirstChild("Pool Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fire Lamp"] = {
        Description = "Keep your garden glowing, one flame at a time.",
        Rarity = "Rare",
        Icon = "rbxassetid://96181837245115",
        Model = v1:FindFirstChild("Fire Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    Vials = {
        Description = "Collect rare elixirs and enchanted brews in these delicate vials.",
        Rarity = "Legendary",
        Icon = "rbxassetid://128022698282843",
        Model = v1:FindFirstChild("Vials"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cerberus Statue"] = {
        Description = "A fearsome guardian with three heads, watching over your domain.",
        Rarity = "Mythical",
        Icon = "rbxassetid://117621526842802",
        Model = v1:FindFirstChild("Cerberus Statue"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gear Lamp"] = {
        Description = "Turning gears and glowing light combine for a steampunk touch.",
        Rarity = "Legendary",
        Icon = "rbxassetid://83193888394253",
        Model = v1:FindFirstChild("Gear Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Hydro Pillar"] = {
        Description = "A calming cascade captured in a striking pillar.",
        Rarity = "Legendary",
        Icon = "rbxassetid://125512307952785",
        Model = v1:FindFirstChild("Hydro Pillar"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Ash Castle Wall"] = {
        Description = "Perfect for keeping ashened cannonballs on *their* side.",
        Rarity = "Rare",
        Icon = "rbxassetid://71743855105491",
        Model = v1:FindFirstChild("Ash Castle Wall"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Ash Castle Staircase"] = {
        Description = "Rise above all, one coarse ashened step at a time.",
        Rarity = "Rare",
        Icon = "rbxassetid://71531666579302",
        Model = v1:FindFirstChild("Ash Castle Staircase"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Ash Castle Tower"] = {
        Description = "Its over for these ashened monstrosities, I have the high ground!",
        Rarity = "Rare",
        Icon = "rbxassetid://87991071493713",
        Model = v1:FindFirstChild("Ash Castle Tower"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Ash Castle Banner"] = {
        Description = "Ashened fabric.",
        Rarity = "Rare",
        Icon = "rbxassetid://139032943559136",
        Model = v1:FindFirstChild("Ash Castle Banner"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Ash Castle Gate"] = {
        Description = "Open wide the grand entrance to a ashened kingdom.",
        Rarity = "Rare",
        Icon = "rbxassetid://100002258431163",
        Model = v1:FindFirstChild("Ash Castle Gate"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Ash Castle Lantern"] = {
        Description = "A cold glow in a warm world. Light up those late night sieges.",
        Rarity = "Rare",
        Icon = "rbxassetid://123402445803627",
        Model = v1:FindFirstChild("Ash Castle Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Egg Lights"] = {
        Description = "Easter eggs that will light up your garden.",
        Rarity = "Rare",
        Icon = "rbxassetid://81879823778004",
        Model = v1:FindFirstChild("Egg Lights"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Egg Lamp"] = {
        Description = "Is that an egg shaped lamp?",
        Rarity = "Rare",
        Icon = "rbxassetid://109953849556509",
        Model = v1:FindFirstChild("Egg Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Egg Basket"] = {
        Description = "Use this to collect all your Easter eggs.",
        Rarity = "Rare",
        Icon = "rbxassetid://91464687991109",
        Model = v1:FindFirstChild("Egg Basket"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Easter Bunny Statue"] = {
        Description = "Big Easter Bunny overlooking your garden.",
        Rarity = "Mythical",
        Icon = "rbxassetid://107771512352539",
        Model = v1:FindFirstChild("Easter Bunny Statue"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Carrot Chair"] = {
        Description = "Cozy chair that looks like a... carrot...?",
        Rarity = "Legendary",
        Icon = "rbxassetid://78938790520178",
        Model = v1:FindFirstChild("Carrot Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bunny Mat"] = {
        Description = "Hop into comfort on this mat!",
        Rarity = "Legendary",
        Icon = "rbxassetid://137147944662174",
        Model = v1:FindFirstChild("Bunny Mat"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Easter Nest"] = {
        Description = "A nest that holds all your Easter eggs.",
        Rarity = "Legendary",
        Icon = "rbxassetid://128025957608754",
        Model = v1:FindFirstChild("Easter Nest"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Easter Sign"] = {
        Description = "Easter Hunt begins!",
        Rarity = "Legendary",
        Icon = "rbxassetid://113597392808346",
        Model = v1:FindFirstChild("Easter Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bunny Stump"] = {
        Description = "A rabbit resting on a stump.",
        Rarity = "Rare",
        Icon = "rbxassetid://134908608925316",
        Model = v1:FindFirstChild("Bunny Stump"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wooden Wall With Door"] = {
        Description = "A wooden wall with a door.",
        Rarity = "Rare",
        Icon = "rbxassetid://107378482389658",
        Model = v1:FindFirstChild("Wooden Wall With Door"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wooden Floor"] = {
        Description = "A simple wooden floor.",
        Rarity = "Rare",
        Icon = "rbxassetid://102852409467271",
        Model = v1:FindFirstChild("Wooden Floor"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wooden Wall With Window"] = {
        Description = "A wooden wall with a window.",
        Rarity = "Rare",
        Icon = "rbxassetid://99596569046069",
        Model = v1:FindFirstChild("Wooden Wall With Window"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wooden Wall"] = {
        Description = "A simple wooden wall.",
        Rarity = "Rare",
        Icon = "rbxassetid://72327404006878",
        Model = v1:FindFirstChild("Wooden Wall"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wooden Corner Log"] = {
        Description = "Connect your wooden walls with this log connector!",
        Rarity = "Rare",
        Icon = "rbxassetid://114143520834365",
        Model = v1:FindFirstChild("Wooden Corner Log"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wooden Roof Panel"] = {
        Description = "A wooden roof to take cover in.",
        Rarity = "Mythical",
        Icon = "rbxassetid://87427077517030",
        Model = v1:FindFirstChild("Wooden Roof Panel"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Easter 2026 Statue"] = {
        Description = "A stone statue to commemorate the 2026 Easter event!",
        Rarity = "Divine",
        Icon = "rbxassetid://78828259580186",
        Model = v1:FindFirstChild("Easter 2026 Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Bee Event 2026 Statue"] = {
        Description = "A statue to commemorate the 2026 Bee event!",
        Rarity = "Divine",
        Icon = "rbxassetid://86008039922068",
        Model = v1:FindFirstChild("Bee Event 2026 Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Bee Bridge"] = {
        Description = "A buzzy bridge for bees to fly over!",
        Rarity = "Mythical",
        Icon = "rbxassetid://136895928640819",
        Model = v1:FindFirstChild("Bee Bridge"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Case"] = {
        Description = "A case with a scary bee inside..?",
        Rarity = "Legendary",
        Icon = "rbxassetid://104330848028513",
        Model = v1:FindFirstChild("Bee Case"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Lamp"] = {
        Description = "Bring a little buzz of light to your farm.",
        Rarity = "Rare",
        Icon = "rbxassetid://93921681515204",
        Model = v1:FindFirstChild("Bee Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Empress Bee Statue"] = {
        Description = "A regal Empress Bee statue buzzing with royal charm.",
        Rarity = "Mythical",
        Icon = "rbxassetid://109213470694305",
        Model = v1:FindFirstChild("Empress Bee Statue"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Jester Bee Statue"] = {
        Description = "A myschievous bee statue that will make you giggle.",
        Rarity = "Rare",
        Icon = "rbxassetid://105454212304155",
        Model = v1:FindFirstChild("Jester Bee Statue"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Princess Bee Statue"] = {
        Description = "A royal flair, delicate details, and a playful sparkle fit for a tiny queen-in-training.",
        Rarity = "Legendary",
        Icon = "rbxassetid://139927664937351",
        Model = v1:FindFirstChild("Princess Bee Statue"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Royal Jelly Fountain"] = {
        Description = "Periodically imbues your crops with the Jellygem mutation!",
        Rarity = "Divine",
        Icon = "rbxassetid://108043937370031",
        Max = 6,
        Model = v1:FindFirstChild("Royal Jelly Fountain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Castle Base"] = {
        Description = "Sturdy enough for even the busiest hive.",
        Rarity = "Rare",
        Icon = "rbxassetid://136102061762370",
        Model = v1:FindFirstChild("Bee Castle Base"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Castle Staircase"] = {
        Description = "The sweetest way to reach the top of the hive.",
        Rarity = "Rare",
        Icon = "rbxassetid://76586471775243",
        Model = v1:FindFirstChild("Bee Castle Staircase"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Castle Straight Wall"] = {
        Description = "Sweet protection for a busy colony.",
        Rarity = "Rare",
        Icon = "rbxassetid://104781060902805",
        Model = v1:FindFirstChild("Bee Castle Straight Wall"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Castle Wall Corner"] = {
        Description = "The hive’s secret to airtight defense.",
        Rarity = "Rare",
        Icon = "rbxassetid://133781503164745",
        Model = v1:FindFirstChild("Bee Castle Wall Corner"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Castle Wall With Door"] = {
        Description = "Welcome in, but watch out for the stingers.",
        Rarity = "Rare",
        Icon = "rbxassetid://88506966193242",
        Model = v1:FindFirstChild("Bee Castle Wall With Door"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Castle Dome"] = {
        Description = "Where the buzz rises highest.",
        Rarity = "Rare",
        Icon = "rbxassetid://91398955229125",
        Model = v1:FindFirstChild("Bee Castle Dome"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bee Castle Tower"] = {
        Description = "Where the royal bees keep watch.",
        Rarity = "Rare",
        Icon = "rbxassetid://118683351312942",
        Model = v1:FindFirstChild("Bee Castle Tower"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Garden Lantern"] = {
        Description = "A weathered garden lantern.",
        Rarity = "Rare",
        Icon = "rbxassetid://115595993493743",
        Model = v1:FindFirstChild("Garden Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bamboo Fountain"] = {
        Description = "Tiny fountain, maximum calm vibes.",
        Rarity = "Rare",
        Icon = "rbxassetid://87232847483926",
        Model = v1:FindFirstChild("Bamboo Fountain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Outdoor Table"] = {
        Description = "Brings food and friends together under the sky.",
        Rarity = "Rare",
        Icon = "rbxassetid://139523066825553",
        Model = v1:FindFirstChild("Outdoor Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Timber Canopy"] = {
        Description = "A cozy wood canopy that turns sunlight into soft shade.",
        Rarity = "Legendary",
        Icon = "rbxassetid://90441832934537",
        Model = v1:FindFirstChild("Timber Canopy"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Solar Bollard"] = {
        Description = "Standing tall, glowing softly, no wires needed.",
        Rarity = "Legendary",
        Icon = "rbxassetid://99674598835749",
        Model = v1:FindFirstChild("Solar Bollard"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wooden Staircase"] = {
        Description = "Step up into the garden like it’s an adventure.",
        Rarity = "Mythical",
        Icon = "rbxassetid://104190247706844",
        Model = v1:FindFirstChild("Wooden Staircase"),
        Actions = {},
        Tags = { "MISC" }
    },
    Cascade = {
        Description = "A mini waterfall that never gets tired.",
        Rarity = "Mythical",
        Icon = "rbxassetid://108418023166378",
        Model = v1:FindFirstChild("Cascade"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Storage Unit"] = {
        Description = "Where clutter goes to disappear.",
        Rarity = "Rare",
        Icon = "rbxassetid://91536850061738",
        Model = v1:FindFirstChild("Storage Unit"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Garden Bin"] = {
        Description = "Quietly taking leaves, scraps, and chaos.",
        Rarity = "Rare",
        Icon = "rbxassetid://94013813713833",
        Model = v1:FindFirstChild("Garden Bin"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Red Mailbox"] = {
        Description = "Bright, bold, and always expecting mail.",
        Rarity = "Legendary",
        Icon = "rbxassetid://105654690963462",
        Model = v1:FindFirstChild("Red Mailbox"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Stepping Stones"] = {
        Description = "Hop, skip, and stroll through the garden.",
        Rarity = "Rare",
        Icon = "rbxassetid://131235261690436",
        Model = v1:FindFirstChild("Stepping Stones"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Garden Chest"] = {
        Description = "Where garden treasures and tools quietly hide.",
        Rarity = "Rare",
        Icon = "rbxassetid://116511303928127",
        Model = v1:FindFirstChild("Garden Chest"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Empty Cart"] = {
        Description = "Waiting patiently for the next big haul.",
        Rarity = "Legendary",
        Icon = "rbxassetid://114553701009045",
        Model = v1:FindFirstChild("Empty Cart"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Camp Chair"] = {
        Description = "Your front-row seat to the great outdoors.",
        Rarity = "Rare",
        Icon = "rbxassetid://109409775289564",
        Model = v1:FindFirstChild("Camp Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Camp Grill"] = {
        Description = "Small grill, big campfire flavor.",
        Rarity = "Rare",
        Icon = "rbxassetid://131833722178083",
        Model = v1:FindFirstChild("Camp Grill"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Camp Tent"] = {
        Description = "Your cozy home between adventures.",
        Rarity = "Rare",
        Icon = "rbxassetid://73658701699503",
        Model = v1:FindFirstChild("Camp Tent"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Folding Chair"] = {
        Description = "Open, sit, enjoy.",
        Rarity = "Legendary",
        Icon = "rbxassetid://107435119198077",
        Model = v1:FindFirstChild("Folding Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Large Grill"] = {
        Description = "Built to feed the whole crew.",
        Rarity = "Mythical",
        Icon = "rbxassetid://83582665734730",
        Model = v1:FindFirstChild("Large Grill"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Small Campfire"] = {
        Description = "Compact warmth for outdoor moments.",
        Rarity = "Mythical",
        Icon = "rbxassetid://91584145016981",
        Model = v1:FindFirstChild("Small Campfire"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Triple Tiered Bird Bath"] = {
        Description = "0 Bed 3 Bath, perfect for a bird family.",
        Rarity = "Rare",
        Icon = "rbxassetid://95365155848194",
        Model = v1:FindFirstChild("Triple Tiered Bird Bath"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Tesla Coil"] = {
        Description = "Summons crackling bolts of electricity that zap the garden with shocking energy!",
        Rarity = "Mythical",
        Icon = "rbxassetid://135180487656065",
        Model = v1:FindFirstChild("Tesla Coil"),
        Actions = {},
        Tags = { "MISC" }
    },
    Generator = {
        Description = "Turns fuel into energy for all your garden gadgets.",
        Rarity = "Legendary",
        Icon = "rbxassetid://98684338428394",
        Model = v1:FindFirstChild("Generator"),
        Actions = {},
        Tags = { "MISC" }
    },
    Floodlight = {
        Description = "Brightens the garden with a powerful beam of light!",
        Rarity = "Legendary",
        Icon = "rbxassetid://111462619798077",
        Model = v1:FindFirstChild("Floodlight"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Solar Panel"] = {
        Description = "Charges up with the power of the sun.",
        Rarity = "Legendary",
        Icon = "rbxassetid://93757176251390",
        Model = v1:FindFirstChild("Solar Panel"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wooden Birdhouse"] = {
        Description = "A cozy little home for feathered garden visitors.",
        Rarity = "Rare",
        Icon = "rbxassetid://92928029714249",
        Model = v1:FindFirstChild("Wooden Birdhouse"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Rope Ladder"] = {
        Description = "Reach new heights, but hold on tight!",
        Rarity = "Rare",
        Icon = "rbxassetid://85552275804226",
        Model = v1:FindFirstChild("Rope Ladder"),
        Actions = {},
        Tags = { "MISC" }
    },
    Vault = {
        Description = "Keeps your riches safe behind reinforced doors.",
        Rarity = "Rare",
        Icon = "rbxassetid://133003247902857",
        Model = v1:FindFirstChild("Vault"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Large Toolbox"] = {
        Description = "Keeps essential tools organized and ready to use.",
        Rarity = "Rare",
        Icon = "rbxassetid://126889967931764",
        Model = v1:FindFirstChild("Large Toolbox"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gumball Machine"] = {
        Description = "Filled with colorful treats and sweet surprises.",
        Rarity = "Legendary",
        Icon = "rbxassetid://128804007004535",
        Model = v1:FindFirstChild("Gumball Machine"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Construction Sign"] = {
        Description = "Marks areas where builders are hard at work.",
        Rarity = "Legendary",
        Icon = "rbxassetid://85646782874708",
        Model = v1:FindFirstChild("Construction Sign"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Classic Beach Chair"] = {
        Description = "A simple chair for laid-back coastal vibes.",
        Rarity = "Rare",
        Icon = "rbxassetid://81383690106555",
        Model = v1:FindFirstChild("Classic Beach Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Garden Bush"] = {
        Description = "A cozy cluster of leaves perfect for a wild garden feel.",
        Rarity = "Rare",
        Icon = "rbxassetid://126289974147269",
        Model = v1:FindFirstChild("Garden Bush"),
        Actions = {},
        Tags = { "MISC" }
    },
    Cooler = {
        Description = "Keeps your items fresh and chilled on warm days.",
        Rarity = "Rare",
        Icon = "rbxassetid://89417133670296",
        Model = v1:FindFirstChild("Cooler"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["4th Of July Archway"] = {
        Description = "The gateway to the 4th of July festivities.",
        Rarity = "Rare",
        Icon = "rbxassetid://78748800207183",
        Model = v1:FindFirstChild("4th Of July Archway"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["4th Of July Fireworks"] = {
        Description = "Small rocket, big boom!",
        Rarity = "Mythical",
        Icon = "rbxassetid://92525157247287",
        Model = v1:FindFirstChild("4th Of July Fireworks"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["4th Of July Rug"] = {
        Description = "Bringing holiday cheer underfoot.",
        Rarity = "Rare",
        Icon = "rbxassetid://132151423039280",
        Model = v1:FindFirstChild("4th Of July Rug"),
        Actions = {},
        Tags = { "MISC" }
    },
    Pinwheel = {
        Description = "Spinning in red, white, and blue.",
        Rarity = "Rare",
        Icon = "rbxassetid://107294401363619",
        Model = v1:FindFirstChild("Pinwheel"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["4th Of July Sparkler"] = {
        Description = "Sparkling through the 4th of July.",
        Rarity = "Legendary",
        Icon = "rbxassetid://112703938620389",
        Model = v1:FindFirstChild("4th Of July Sparkler"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["4th Of July Cake"] = {
        Description = "Baked for fireworks night.",
        Rarity = "Rare",
        Icon = "rbxassetid://98701589212598",
        Model = v1:FindFirstChild("4th Of July Cake"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Beach Lounge Chair"] = {
        Description = "Relax by your garden in seaside comfort.",
        Rarity = "Rare",
        Icon = "rbxassetid://118597419222263",
        Model = v1:FindFirstChild("Beach Lounge Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Beach Mat"] = {
        Description = "A cozy spot to relax under the sun.",
        Rarity = "Rare",
        Icon = "rbxassetid://132952586573503",
        Model = v1:FindFirstChild("Beach Mat"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Beach Parasol"] = {
        Description = "Cool off in the shade while your garden grows.",
        Rarity = "Rare",
        Icon = "rbxassetid://95113433179263",
        Model = v1:FindFirstChild("Beach Parasol"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Ice Cream Stand"] = {
        Description = "The sweetest stop in your garden.",
        Rarity = "Mythical",
        Icon = "rbxassetid://137860967200331",
        Model = v1:FindFirstChild("Ice Cream Stand"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Life Guard Chair"] = {
        Description = "Bring beach patrol vibes to your plot.",
        Rarity = "Mythical",
        Icon = "rbxassetid://129459372781808",
        Model = v1:FindFirstChild("Life Guard Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    Sandbox = {
        Description = "A little corner for seaside adventures.",
        Rarity = "Legendary",
        Icon = "rbxassetid://72216379702493",
        Model = v1:FindFirstChild("Sandbox"),
        Actions = {},
        Tags = { "MISC" }
    },
    Sandcastle = {
        Description = "A mighty sandy castle!",
        Rarity = "Legendary",
        Icon = "rbxassetid://106766998891441",
        Model = v1:FindFirstChild("Sandcastle"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Red Sand Pail"] = {
        Description = "A tool that\'s essential for playing in the sand!",
        Rarity = "Rare",
        Icon = "rbxassetid://97486882716060",
        Model = v1:FindFirstChild("Red Sand Pail"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Beach Tube"] = {
        Description = "A sandy little float made for maximum beach lounging.",
        Rarity = "Rare",
        Icon = "rbxassetid://125566113461164",
        Model = v1:FindFirstChild("Beach Tube"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Summer Drinks"] = {
        Description = "Cold drinks, tiny umbrellas, and peak vacation energy.",
        Rarity = "Rare",
        Icon = "rbxassetid://87951177138219",
        Model = v1:FindFirstChild("Summer Drinks"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Tiki Torch"] = {
        Description = "A tropical torch that keeps the party glowing after sunset.",
        Rarity = "Rare",
        Icon = "rbxassetid://135027809939147",
        Model = v1:FindFirstChild("Tiki Torch"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Beach Chair Statue"] = {
        Description = "A stone-cold reminder to sit back and relax.",
        Rarity = "Legendary",
        Icon = "rbxassetid://119096453402657",
        Model = v1:FindFirstChild("Beach Chair Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Flamingo Tube"] = {
        Description = "A fabulous float that ate too many shrimp.",
        Rarity = "Mythical",
        Icon = "rbxassetid://119003308545594",
        Model = v1:FindFirstChild("Flamingo Tube"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Tidal Wave"] = {
        Description = "Ocean power! No lifeguard required.",
        Rarity = "Divine",
        Icon = "rbxassetid://80917013377350",
        Model = v1:FindFirstChild("Tidal Wave"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sandcastle Banner"] = {
        Description = "Raise the banner and claim the beach as your kingdom.",
        Rarity = "Legendary",
        Icon = "rbxassetid://111651782565282",
        Model = v1:FindFirstChild("Sandcastle Banner"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sandcastle Base"] = {
        Description = "A sturdy sandy foundation fit for a seaside fortress.",
        Rarity = "Legendary",
        Icon = "rbxassetid://131736653713408",
        Model = v1:FindFirstChild("Sandcastle Base"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sandcastle Staircase"] = {
        Description = "A royal staircase sculpted entirely from sand.",
        Rarity = "Legendary",
        Icon = "rbxassetid://133392027530644",
        Model = v1:FindFirstChild("Sandcastle Staircase"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sandcastle Straight Wall"] = {
        Description = "A fortified wall built to withstand the mightiest sandstorm.",
        Rarity = "Legendary",
        Icon = "rbxassetid://127421984106342",
        Model = v1:FindFirstChild("Sandcastle Straight Wall"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sandcastle Tower"] = {
        Description = "Keep watch over the shoreline from this towering sandy stronghold.",
        Rarity = "Legendary",
        Icon = "rbxassetid://122500209650000",
        Model = v1:FindFirstChild("Sandcastle Tower"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sandcastle Wall Corner"] = {
        Description = "Turn the corner without leaving your sandy defenses exposed.",
        Rarity = "Legendary",
        Icon = "rbxassetid://74773103730893",
        Model = v1:FindFirstChild("Sandcastle Wall Corner"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Sandcastle Wall With Door"] = {
        Description = "A grand entrance for rulers of the sandy realm.",
        Rarity = "Legendary",
        Icon = "rbxassetid://106924139351677",
        Model = v1:FindFirstChild("Sandcastle Wall With Door"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Tidal Fountain"] = {
        Description = "Periodically imbues a fruit with the Sandy or Tidal mutation or a pet with +5% XP bonus!",
        Rarity = "Prismatic",
        Icon = "rbxassetid://82987759319963",
        Max = 6,
        Model = v1:FindFirstChild("Tidal Fountain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Harvest Dial"] = {
        Description = "A trusty dial for every Harvest Moon.",
        Rarity = "Legendary",
        Icon = "rbxassetid://104235890557078",
        Model = v1:FindFirstChild("Harvest Dial"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Harvest Moon Mirror"] = {
        Description = "The moon never leaves this mirror.",
        Rarity = "Rare",
        Icon = "rbxassetid://106007392643789",
        Model = v1:FindFirstChild("Harvest Moon Mirror"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Star Catcher"] = {
        Description = "Catch a wish before it falls!",
        Rarity = "Legendary",
        Icon = "rbxassetid://97398648805759",
        Model = v1:FindFirstChild("Star Catcher"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Moon Guide"] = {
        Description = "Guiding every harvest by moonlight.",
        Rarity = "Rare",
        Icon = "rbxassetid://104469680892668",
        Model = v1:FindFirstChild("Moon Guide"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Moon Music Box"] = {
        Description = "A melody only the moon remembers.",
        Rarity = "Mythical",
        Icon = "rbxassetid://131969448174714",
        Model = v1:FindFirstChild("Moon Music Box"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Seed Dispenser"] = {
        Description = "Every harvest begins with a single seed.",
        Rarity = "Divine",
        Icon = "rbxassetid://137840677414980",
        Model = v1:FindFirstChild("Seed Dispenser"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cactus Box"] = {
        Description = "A prickly little box for storing sharp ideas.",
        Rarity = "Rare",
        Icon = "rbxassetid://102148468612908",
        Model = v1:FindFirstChild("Cactus Box"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cactus Rug"] = {
        Description = "Soft enough to stand on, sharp enough to stand out.",
        Rarity = "Rare",
        Icon = "rbxassetid://125579692494780",
        Model = v1:FindFirstChild("Cactus Rug"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cactus Chair"] = {
        Description = "Take a seat, but mind the spikes.",
        Rarity = "Legendary",
        Icon = "rbxassetid://123857853707344",
        Model = v1:FindFirstChild("Cactus Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cactus Table"] = {
        Description = "A sharp centerpiece for any garden.",
        Rarity = "Rare",
        Icon = "rbxassetid://71955690821892",
        Model = v1:FindFirstChild("Cactus Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cactus Lamp"] = {
        Description = "A bright idea with a prickly personality.",
        Rarity = "Legendary",
        Icon = "rbxassetid://91102865569316",
        Model = v1:FindFirstChild("Cactus Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cactus Walkway"] = {
        Description = "Take a walk on the wild and prickly side.",
        Rarity = "Legendary",
        Icon = "rbxassetid://110675836177752",
        Model = v1:FindFirstChild("Cactus Walkway"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cactus Statue"] = {
        Description = "A monument to surviving the sharpest situations.",
        Rarity = "Mythical",
        Icon = "rbxassetid://119624481111253",
        Model = v1:FindFirstChild("Cactus Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Harvest Rug"] = {
        Description = "Bring the warmth of the harvest beneath your feet.",
        Rarity = "Rare",
        Icon = "rbxassetid://138610901736246",
        Model = v1:FindFirstChild("Harvest Rug"),
        Actions = {},
        Events = { "Harvest Moon" },
        Tags = { "MISC" }
    },
    ["Lunar Fountain"] = {
        Description = "Moonlit waters that shimmer through the harvest night.",
        Rarity = "Legendary",
        Icon = "rbxassetid://98386563041611",
        Model = v1:FindFirstChild("Lunar Fountain"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Harvest Lamppost"] = {
        Description = "A golden glow to guide the way home.",
        Rarity = "Legendary",
        Icon = "rbxassetid://76328425606080",
        Model = v1:FindFirstChild("Harvest Lamppost"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Harvest Clock"] = {
        Description = "There is always thyme for another harvest.",
        Rarity = "Mythical",
        Icon = "rbxassetid://131957794059348",
        Model = v1:FindFirstChild("Harvest Clock"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Harvest Archway"] = {
        Description = "Step beneath the glow of an endless autumn.",
        Rarity = "Divine",
        Icon = "rbxassetid://133601300823892",
        Model = v1:FindFirstChild("Harvest Archway"),
        Actions = {},
        Tags = { "MISC" }
    },
    Anchor = {
        Description = "A weathered anchor once lost to the tides.",
        Rarity = "Legendary",
        Icon = "rbxassetid://117585277855756",
        Model = v1:FindFirstChild("Anchor"),
        Actions = {},
        Tags = { "MISC" }
    },
    Obelisk = {
        Description = "A mysterious obelisk from a forgotten age.",
        Rarity = "Rare",
        Icon = "rbxassetid://125301268260605",
        Model = v1:FindFirstChild("Obelisk"),
        Actions = {},
        Tags = { "MISC" }
    },
    Brazier = {
        Description = "Old stone brazier full of forgotten history.",
        Rarity = "Legendary",
        Icon = "rbxassetid://128238976593926",
        Model = v1:FindFirstChild("Brazier"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Moon Altar"] = {
        Description = "Mystical altar that honors the moon above.",
        Rarity = "Mythical",
        Icon = "rbxassetid://113784512483559",
        Model = v1:FindFirstChild("Moon Altar"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Stone Bench"] = {
        Description = "Weathered bench carved from solid stone.",
        Rarity = "Rare",
        Icon = "rbxassetid://111685864043648",
        Model = v1:FindFirstChild("Stone Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Stone Garden Lantern"] = {
        Description = "Classic stone lantern for peaceful gardens.",
        Rarity = "Legendary",
        Icon = "rbxassetid://77406995984581",
        Model = v1:FindFirstChild("Stone Garden Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Moon Rug"] = {
        Description = "Soft rug inspired by the glowing moon.",
        Rarity = "Rare",
        Icon = "rbxassetid://115379825950999",
        Model = v1:FindFirstChild("Moon Rug"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Wooden Farm Cart"] = {
        Description = "Weathered cart built to carry heavy loads.",
        Rarity = "Legendary",
        Icon = "rbxassetid://81767045653707",
        Model = v1:FindFirstChild("Wooden Farm Cart"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Garden Trough"] = {
        Description = "Well-used trough that\'s seen many seasons.",
        Rarity = "Legendary",
        Icon = "rbxassetid://120637185950229",
        Model = v1:FindFirstChild("Garden Trough"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Water Pump"] = {
        Description = "Dependable water pump for busy garden days.",
        Rarity = "Legendary",
        Icon = "rbxassetid://115909477221224",
        Model = v1:FindFirstChild("Water Pump"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bucket Stand"] = {
        Description = "Handy place to keep your buckets close by.",
        Rarity = "Rare",
        Icon = "rbxassetid://127967985011184",
        Model = v1:FindFirstChild("Bucket Stand"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Lumber Rack"] = {
        Description = "A rack for storing building supplies.",
        Rarity = "Rare",
        Icon = "rbxassetid://79420866001160",
        Model = v1:FindFirstChild("Lumber Rack"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Terracotta Jar"] = {
        Description = "Handcrafted jar inspired by traditional gardens.",
        Rarity = "Rare",
        Icon = "rbxassetid://83950029017332",
        Model = v1:FindFirstChild("Terracotta Jar"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Harvest Moon Statue"] = {
        Description = "Raise the harvest, praise the moon!",
        Rarity = "Divine",
        Icon = "rbxassetid://130149172239965",
        Model = v1:FindFirstChild("Harvest Moon Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Fairytale Well"] = {
        Description = "You peer into it and see remnants of a distant world.",
        Rarity = "Rare",
        Icon = "rbxassetid://70473008284190",
        Model = v1:FindFirstChild("Fairytale Well"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Strawberry Bench"] = {
        Description = "A farmer wears a straw hat, lives in a straw house and sits on a... strawberry bench?",
        Rarity = "Rare",
        Icon = "rbxassetid://129986582885434",
        Model = v1:FindFirstChild("Strawberry Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bean Pod Table"] = {
        Description = "A sturdy little table grown straight from the vine.",
        Rarity = "Rare",
        Icon = "rbxassetid://72891125515813",
        Model = v1:FindFirstChild("Bean Pod Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Beanstalk Rug"] = {
        Description = "A soft patch of greenery for your growing garden.",
        Rarity = "Rare",
        Icon = "rbxassetid://109811460630907",
        Model = v1:FindFirstChild("Beanstalk Rug"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Stalky Scarecrow"] = {
        Description = "Standing tall and keeping trouble off the stalk.",
        Rarity = "Rare",
        Icon = "rbxassetid://131141932249507",
        Model = v1:FindFirstChild("Stalky Scarecrow"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Pod Lamp"] = {
        Description = "A glowing pod that lights the way up the vine.",
        Rarity = "Legendary",
        Icon = "rbxassetid://72487523066068",
        Model = v1:FindFirstChild("Pod Lamp"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Elder Bookshelf"] = {
        Description = "Ancient shelves filled with stories from the tallest stalks.",
        Rarity = "Mythical",
        Icon = "rbxassetid://77466633263794",
        Model = v1:FindFirstChild("Elder Bookshelf"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Bean Pod Nook"] = {
        Description = "A cozy hideaway tucked inside a giant bean pod.",
        Rarity = "Divine",
        Icon = "rbxassetid://77935019152434",
        Model = v1:FindFirstChild("Bean Pod Nook"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Brown Bouncy Mushroom"] = {
        Description = "BEAN BOING!",
        Rarity = "Divine",
        Icon = "rbxassetid://109132390729870",
        Model = v1:FindFirstChild("Brown Bouncy Mushroom"),
        Actions = {},
        Tags = { "MISC", "UTILITY" }
    },
    ["Dream Lantern"] = {
        Description = "Casts a gentle glow to guide you through your sweetest dreams.",
        Rarity = "Rare",
        Icon = "rbxassetid://134001008538719",
        Model = v1:FindFirstChild("Dream Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Eye Totem"] = {
        Description = "Watches over the garden, seeing every dream and nightmare.",
        Rarity = "Legendary",
        Icon = "rbxassetid://103297185055083",
        Model = v1:FindFirstChild("Eye Totem"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Dream & Nightmare Mirror"] = {
        Description = "Reflects the thin line between sweet dreams and dark nightmares..",
        Rarity = "Legendary",
        Icon = "rbxassetid://119022060502776",
        Model = v1:FindFirstChild("Dream & Nightmare Mirror"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Nightmare Cage"] = {
        Description = "Imprisons restless dreams before they can escape.",
        Rarity = "Mythical",
        Icon = "rbxassetid://119038896728712",
        Model = v1:FindFirstChild("Nightmare Cage"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cloud Arch"] = {
        Description = "Step beneath the clouds and into a world of dreams.",
        Rarity = "Divine",
        Icon = "rbxassetid://129525904006877",
        Model = v1:FindFirstChild("Cloud Arch"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Nightmare Crystal"] = {
        Description = "Pulses with dark energy drawn from restless dreams.",
        Rarity = "Mythical",
        Icon = "rbxassetid://114241041117236",
        Model = v1:FindFirstChild("Nightmare Crystal"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cloud Bed"] = {
        Description = "A soft, dreamy bed nestled among fluffy clouds.",
        Rarity = "Rare",
        Icon = "rbxassetid://90832734033922",
        Model = v1:FindFirstChild("Cloud Bed"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Nightmare Key"] = {
        Description = "Unlocks chests that were meant to stay sealed.",
        Rarity = "Rare",
        Icon = "rbxassetid://82204879962058",
        Model = v1:FindFirstChild("Nightmare Key"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Nightmare Chest"] = {
        Description = "Keeps your darkest dreams locked safely away.",
        Rarity = "Rare",
        Icon = "rbxassetid://92859282256940",
        Model = v1:FindFirstChild("Nightmare Chest"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Cloud Steps"] = {
        Description = "Climb your way into the sweetest of dreams.",
        Rarity = "Legendary",
        Icon = "rbxassetid://132049450966911",
        Model = v1:FindFirstChild("Cloud Steps"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Dream Orb"] = {
        Description = "Holds a tiny world where dreams drift among the stars.",
        Rarity = "Rare",
        Icon = "rbxassetid://97137406630470",
        Model = v1:FindFirstChild("Dream Orb"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Nightmare Candle"] = {
        Description = "Burns with an eerie flame fuelled by bad dreams.",
        Rarity = "Rare",
        Icon = "rbxassetid://76171886267444",
        Model = v1:FindFirstChild("Nightmare Candle"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Dream Nightstand"] = {
        Description = "Keeps your sweetest dreams close while you sleep.",
        Rarity = "Rare",
        Icon = "rbxassetid://116012008732552",
        Model = v1:FindFirstChild("Dream Nightstand"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Beanstalk Statue"] = {
        Description = "A reward for growing big and strong!",
        Rarity = "Divine",
        Icon = "rbxassetid://74895571456927",
        Model = v1:FindFirstChild("Beanstalk Statue"),
        Actions = {},
        Tags = { "STATUE" }
    },
    ["Giant Boot"] = {
        Description = "A massive boot once worn by a giant. Hopefully they don’t come looking for it...",
        Rarity = "Rare",
        Icon = "rbxassetid://114621280193131",
        Model = v1:FindFirstChild("Giant Boot"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fairytale Bench"] = {
        Description = "A charming storybook bench, perfect for giving your garden a little fairytale magic!",
        Rarity = "Legendary",
        Icon = "rbxassetid://91812297274902",
        Model = v1:FindFirstChild("Fairytale Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fairytale Tower"] = {
        Description = "A towering structure straight out of a storybook, bringing a magical touch to your garden!",
        Rarity = "Mythical",
        Icon = "rbxassetid://90385881258949",
        Model = v1:FindFirstChild("Fairytale Tower"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gourd Lantern"] = {
        Description = "A cozy carved gourd lantern that gives your garden a warm autumn glow.",
        Rarity = "Rare",
        Icon = "rbxassetid://136009607455526",
        Model = v1:FindFirstChild("Gourd Lantern"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Pumpkin Chair"] = {
        Description = "A charming pumpkin shaped chair, perfect for relaxing in your garden.",
        Rarity = "Rare",
        Icon = "rbxassetid://135123580028549",
        Model = v1:FindFirstChild("Pumpkin Chair"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fall Rug"] = {
        Description = "A decorative autumn rug!",
        Rarity = "Rare",
        Icon = "rbxassetid://83679349933384",
        Model = v1:FindFirstChild("Fall Rug"),
        Actions = {},
        Tags = { "MISC" }
    },
    Cornucopia = {
        Description = "A classic harvest decoration overflowing with the bounty of the fall season.",
        Rarity = "Legendary",
        Icon = "rbxassetid://118164065089782",
        Model = v1:FindFirstChild("Cornucopia"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Spice Rack"] = {
        Description = "A rustic rack stocked with all the spices needed for your favorite fall treats.",
        Rarity = "Mythical",
        Icon = "rbxassetid://129793636732632",
        Model = v1:FindFirstChild("Spice Rack"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Drink Press"] = {
        Description = "A seasonal press for turning fresh garden harvests into delicious autumn drinks!",
        Rarity = "Divine",
        Icon = "rbxassetid://76798282137711",
        Model = v1:FindFirstChild("Drink Press"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Orchid Harvest Box"] = {
        Description = "A wooden crate overflowing with freshly harvested fall fruits",
        Rarity = "Rare",
        Icon = "rbxassetid://77392447272816",
        Model = v1:FindFirstChild("Orchid Harvest Box"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Amber Hammock"] = {
        Description = "A cozy hammock perfect for relaxing beneath the autumn leaves",
        Rarity = "Legendary",
        Icon = "rbxassetid://135029711223308",
        Model = v1:FindFirstChild("Amber Hammock"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Harvesting Workbench"] = {
        Description = "A rustic workbench decorated for the fall harvest",
        Rarity = "Divine",
        Icon = "rbxassetid://104353074052482",
        Model = v1:FindFirstChild("Harvesting Workbench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Carved Swingseat"] = {
        Description = "A swingseat carved from a couple of logs, perfect for enjoying the sights and sounds of the fall season!",
        Rarity = "Divine",
        Icon = "rbxassetid://112545954043837",
        Model = v1:FindFirstChild("Carved Swingseat"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Fairy Lightpost"] = {
        Description = "A light with a touch of magic, casting a warm glow over your garden!",
        Rarity = "Rare",
        Icon = "rbxassetid://99016996403003",
        Model = v1:FindFirstChild("Fairy Lightpost"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Enchanted Rug"] = {
        Description = "A magical rug woven with enchanted threads.",
        Rarity = "Rare",
        Icon = "rbxassetid://82746693423567",
        Model = v1:FindFirstChild("Enchanted Rug"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Magic Workbench"] = {
        Description = "A workbench where magical creations come to life.",
        Rarity = "Legendary",
        Icon = "rbxassetid://108250740723180",
        Model = v1:FindFirstChild("Magic Workbench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Magic Mirror"] = {
        Description = "A mysterious mirror that reflects more than meets the eye.",
        Rarity = "Mythical",
        Icon = "rbxassetid://122239528425763",
        Model = v1:FindFirstChild("Magic Mirror"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Log House"] = {
        Description = "A cozy little home fit for a magical fairy.",
        Rarity = "Divine",
        Icon = "rbxassetid://122864932906816",
        Model = v1:FindFirstChild("Log House"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Honey Trough"] = {
        Description = "A sweet trough filled with honey for the bees to feast on.",
        Rarity = "Rare",
        Icon = "rbxassetid://114867356793162",
        Model = v1:FindFirstChild("Honey Trough"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Honey Table"] = {
        Description = "A table made of honeycomb...",
        Rarity = "Legendary",
        Icon = "rbxassetid://89876365310914",
        Model = v1:FindFirstChild("Honey Table"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Honey Umbrella"] = {
        Description = "A drippy umbrella to provide shade for sunny days!",
        Rarity = "Divine",
        Icon = "rbxassetid://80784127354262",
        Model = v1:FindFirstChild("Honey Umbrella"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Gothic Candelabra"] = {
        Description = "A spooky candle that adds an eerie glow to your garden...",
        Rarity = "Rare",
        Icon = "rbxassetid://74943091381495",
        Model = v1:FindFirstChild("Gothic Candelabra"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Halloween Mat"] = {
        Description = "A festive mat perfect for decorating your garden for Halloween!",
        Rarity = "Rare",
        Icon = "rbxassetid://133833984834916",
        Model = v1:FindFirstChild("Halloween Mat"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Spider Web Bench"] = {
        Description = "A creepy bench engraved with spider webs",
        Rarity = "Rare",
        Icon = "rbxassetid://113790538545397",
        Model = v1:FindFirstChild("Spider Web Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Candy Bowl"] = {
        Description = "A bowl filled with delicious Halloween treats. ONLY TAKE ONE!",
        Rarity = "Legendary",
        Icon = "rbxassetid://82607967045620",
        Model = v1:FindFirstChild("Candy Bowl"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Zombie Hand"] = {
        Description = "A zombie hand emerging from the ground...",
        Rarity = "Mythical",
        Icon = "rbxassetid://109168998913656",
        Model = v1:FindFirstChild("Zombie Hand"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Webbed Picnic Bench"] = {
        Description = "A spooky picnic bench engraved with webs.",
        Rarity = "Divine",
        Icon = "rbxassetid://130134154724345",
        Model = v1:FindFirstChild("Webbed Picnic Bench"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Haunted Well"] = {
        Description = "Some say the old well still whispers back...",
        Rarity = "Mythical",
        Icon = "rbxassetid://129493312368818",
        Model = v1:FindFirstChild("Haunted Well"),
        Actions = {},
        Tags = { "MISC" }
    },
    ["Ghoul Garden Statue"] = {
        Description = "A stone statue to commemorate the 2026 Ghoul Garden event!",
        Rarity = "Divine",
        Icon = "rbxassetid://129965996072910",
        Model = v1:FindFirstChild("Ghoul Garden Statue"),
        Actions = {},
        Tags = { "STATUE" }
    }
};
local v3 = {
    Description = "This item has no description! Please write one!",
    Rarity = "Common",
    Icon = "rbxassetid://6937742258"
};
local v4 = RunService:IsServer() and v1:WaitForChild("Axe Stump");
v3.Model = v4;

for i, v in v2 do
    local v5 = i;
    local v6 = v;

    for i2, v7 in v3 do
        if not (v6[i2] or i2 == "Model" and not RunService:IsServer()) then
            if i2 == "Model" then
                v6.Model = v1:FindFirstChild(v5);
            else
                v6[i2] = v7;
            end;
        end;
    end;

    if v6.Models then
        for i2, v7 in v6.Models do
            if not v7 then
                warn((`[CosmeticRegistry] {v5} variant {i2} is nil or missing`));
                v6.Models[i2] = v1:FindFirstChild(v5);
            end;
        end;
    else
        v6.Models = { v6.Model };
    end;

    if not v6.Model then
        v6.Model = v6.Models[1];
    end;

    if RunService:IsServer() then
        for _, v7 in v6.Models do
            if v7 then
                local v8 = v7.PrimaryPart or v7:FindFirstChild("HitBox");

                if not v8 then
                    warn(v5, "variant has no PrimaryPart; generating temporary hitbox");
                    v8 = CreateHitBoxFor(v7);
                    v8:AddTag("CosmeticHitBox");
                end;

                v7.PrimaryPart = v8;
                v7.Name = v5;
                v8:AddTag("CosmeticHitBox");
                v8.Anchored = true;
            else
                warn((`[CosmeticRegistry] {v5} has nil model variant.`));
            end;
        end;
    end;
end;

return v2;