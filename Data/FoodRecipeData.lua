-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Models");
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);
local TableUtils = require(ReplicatedStorage.Modules.TableUtils);
local v1 = {};
local v2 = { "Corn", "Violet Corn", "Cauliflower", "Banana", "Sugarglaze" };
local v3 = { "Pepper", "Bell Pepper", "Ember Lily", "Cactus", "Mushroom", "Eggplant", "Venus Fly Trap", "Glowshroom", "Bone Blossom", "Tall Asparagus", "Taco Fern" };
local v4 = { "Tomato", "Bamboo", "Taro Flower", "Sunflower", "Avocado", "Pineapple", "Bell Pepper", "Onion", "Jalapeno", "Grand Tomato", "Artichoke" };
local v5 = { "Coconut", "Pumpkin", "Crown Melon", "Sugarglaze" };
local v6 = { "Tomato", "Grand Tomato" };
v1.Recipes = {
    Burger = {
        Id = "c",
        ImageId = "rbxassetid://100029889334054",
        Priority = 10,
        BaseTime = 400,
        BaseWeight = 2,
        Requires = {
            Count = 3,
            Ingredients = {
                Bread = v2,
                Meat = v3,
                Leafy = v4
            }
        },
        Results = { "Burger" }
    },
    Soup = {
        Id = "d",
        ImageId = "rbxassetid://122580735203073",
        Priority = 0,
        BaseTime = 300,
        BaseWeight = 0.5,
        Requires = {
            Count = 1
        },
        Results = { "Soup" }
    },
    Corndog = {
        Id = "cdog",
        ImageId = "rbxassetid://123984061977008",
        Priority = 5,
        BaseTime = 400,
        BaseWeight = 1.5,
        Requires = {
            Count = 2,
            Ingredients = {
                Stick = PlantTraitsData.Traits.Woody,
                Meat = v3,
                Batter = { "Corn", "Violet Corn" }
            }
        },
        Results = { "Corndog" }
    },
    HotDog = {
        Id = "e",
        ImageId = "rbxassetid://136455657586960",
        Priority = 5,
        BaseTime = 400,
        BaseWeight = 1.5,
        Requires = {
            Count = 2,
            Ingredients = {
                Bread = v2,
                Meat = v3
            }
        },
        Results = { "HotDog" }
    },
    Sandwich = {
        Id = "f",
        ImageId = "rbxassetid://139763254124497",
        Priority = 3,
        BaseTime = 350,
        BaseWeight = 1,
        Requires = {
            Count = 3,
            Ingredients = {
                Bread = v2,
                Leafy = v4,
                Tomato = v6
            }
        },
        Results = { "Sandwich" }
    },
    Salad = {
        Id = "g",
        ImageId = "rbxassetid://96781873740831",
        Priority = 2,
        BaseTime = 350,
        BaseWeight = 0.2,
        Requires = {
            Count = 2,
            Ingredients = {
                Leafy = v4,
                Vegetable = PlantTraitsData.Traits.Vegetable
            }
        },
        Results = { "Salad" }
    },
    Pie = {
        Id = "i",
        ImageId = "rbxassetid://126935428774858",
        Priority = 8,
        BaseTime = 400,
        BaseWeight = 3,
        Requires = {
            Count = 2,
            Ingredients = {
                Pastry = v5,
                Filling = TableUtils:MakeTable(PlantTraitsData.Traits.Vegetable, v3)
            }
        },
        Results = { "Pie" }
    },
    Waffle = {
        Id = "j",
        ImageId = "rbxassetid://112367385396275",
        Priority = 6,
        BaseTime = 350,
        BaseWeight = 1.2,
        Requires = {
            Count = 3,
            Ingredients = {
                Pastry = v5,
                Sweet = PlantTraitsData.Traits.Sweet
            }
        },
        Results = { "Waffle" }
    },
    Pizza = {
        Id = "k",
        ImageId = "rbxassetid://99865068747737",
        Priority = 7,
        BaseTime = 500,
        BaseWeight = 2,
        Requires = {
            Count = 4,
            Ingredients = {
                Bread = v2,
                Meat = v3,
                Vegetable = PlantTraitsData.Traits.Vegetable,
                Sauce = PlantTraitsData.Traits.Fruit
            }
        },
        Results = { "Pizza" }
    },
    Sushi = {
        Id = "l",
        ImageId = "rbxassetid://124413058833848",
        Priority = 20,
        BaseTime = 300,
        BaseWeight = 2,
        Requires = {
            Count = 3,
            Ingredients = {
                Bamboo = { "Bamboo" },
                Wrap = v4,
                Main = TableUtils:MakeTable(v3, PlantTraitsData.Traits.Vegetable),
                Rice = TableUtils:MakeTable(v2, "Coconut")
            }
        },
        Results = { "Sushi" }
    },
    Donut = {
        Id = "m",
        ImageId = "rbxassetid://103702025640123",
        Priority = 9,
        BaseTime = 200,
        BaseWeight = 2,
        Requires = {
            Count = 3,
            Ingredients = {
                Bread = v2,
                Icing = PlantTraitsData.Traits.Sweet,
                Sprinkles = PlantTraitsData.Traits.Sweet
            }
        },
        Results = { "Donut" }
    },
    IceCream = {
        Id = "n",
        ImageId = "rbxassetid://80440750183765",
        Priority = 10,
        BaseTime = 300,
        BaseWeight = 2,
        Requires = {
            Count = 2,
            Ingredients = {
                Cone = v2,
                Cream = PlantTraitsData.Traits.Sweet
            }
        },
        Results = { "IceCream" }
    },
    Cake = {
        Id = "o",
        ImageId = "rbxassetid://133935704392240",
        Priority = 10,
        BaseTime = 350,
        BaseWeight = 2,
        Requires = {
            Count = 4,
            Ingredients = {
                Bread = v2,
                Icing = PlantTraitsData.Traits.Sweet,
                Filling = PlantTraitsData.Traits.Sweet,
                Fruit = PlantTraitsData.Traits.Fruit
            }
        },
        Results = { "Cake" }
    },
    Smoothie = {
        Id = "p",
        ImageId = "rbxassetid://99520717630343",
        Priority = 6,
        BaseTime = 400,
        BaseWeight = 1.2,
        Requires = {
            Count = 2,
            Ingredients = {
                Fruit = PlantTraitsData.Traits.Fruit
            }
        },
        Results = { "Smoothie" }
    },
    Porridge = {
        Id = "r",
        ImageId = "rbxassetid://121467388211046",
        Priority = 3,
        BaseTime = 250,
        BaseWeight = 2,
        Requires = {
            Count = 3,
            Ingredients = {
                Base = v2,
                Cream = v2,
                Fruit = PlantTraitsData.Traits.Fruit
            }
        },
        Results = { "Porridge" }
    },
    Spaghetti = {
        Id = "t",
        ImageId = "rbxassetid://118816141566924",
        Priority = 6,
        BaseTime = 350,
        BaseWeight = 2.5,
        Requires = {
            Count = 4,
            Ingredients = {
                Pasta = v2,
                Sauce = v6,
                Meat = v3,
                Vegetables = PlantTraitsData.Traits.Vegetable
            }
        },
        Results = { "Spaghetti" }
    },
    CandyApple = {
        Id = "v",
        ImageId = "rbxassetid://98794672893031",
        Priority = 10,
        BaseTime = 200,
        BaseWeight = 0.7,
        Requires = {
            Count = 2,
            Ingredients = {
                Apple = { "Apple", "Green Apple", "Sugar Apple", "Maple Apple" },
                CandyCoating = PlantTraitsData.Traits.Sweet
            }
        },
        Results = { "CandyApple" }
    },
    SweetTea = {
        Id = "y",
        ImageId = "rbxassetid://114245564378378",
        Priority = 4,
        BaseTime = 270,
        BaseWeight = 0.5,
        Requires = {
            Count = 2,
            Ingredients = {
                HerbalBase = TableUtils:MakeTable(TableUtils:SetSubtract(PlantTraitsData.Traits.Flower, PlantTraitsData.Traits.Toxic), "Mint"),
                Sweetener = PlantTraitsData.Traits.Sweet
            }
        },
        Results = { "SweetTea" }
    },
    GingerbreadCookie = {
        Id = "A",
        ImageId = "rbxassetid://72901053976020",
        Priority = 10,
        BaseTime = 120,
        BaseWeight = 1.5,
        Requires = {
            Count = 3,
            Ingredients = {
                Bread = v2,
                Candy = PlantTraitsData.Traits.Candy,
                Root = PlantTraitsData.Traits.Root
            }
        },
        Results = { "GingerbreadCookie" }
    },
    CandyCane = {
        Id = "B",
        ImageId = "rbxassetid://85331063125317",
        Priority = 6,
        BaseTime = 80,
        BaseWeight = 1,
        Requires = {
            Count = 2,
            Ingredients = {
                Candy = PlantTraitsData.Traits.Candy,
                Mint = { "Mint" }
            }
        },
        Results = { "CandyCane" }
    },
    Wreath = {
        Id = "C",
        ImageId = "rbxassetid://130758481476318",
        Priority = 7,
        BaseTime = 180,
        BaseWeight = 2,
        Requires = {
            Count = 3,
            Ingredients = {
                Leafy = v4,
                Sweet = PlantTraitsData.Traits.Sweet,
                Berries = PlantTraitsData.Traits.Berry
            }
        },
        Results = { "Wreath" }
    },
    HolidayRoast = {
        Id = "D",
        ImageId = "rbxassetid://99579170823587",
        Priority = 8,
        BaseTime = 260,
        BaseWeight = 3,
        Requires = {
            Count = 3,
            Ingredients = {
                Meat1 = v3,
                Meat2 = v3,
                Herbs = v4
            }
        },
        Results = { "HolidayRoast" }
    },
    HolidayStuffing = {
        Id = "E",
        ImageId = "rbxassetid://116151178640426",
        Priority = 7,
        BaseTime = 160,
        BaseWeight = 1.8,
        Requires = {
            Count = 3,
            Ingredients = {
                Bread = v2,
                Herbs = v4,
                Vegetable = PlantTraitsData.Traits.Vegetable
            }
        },
        Results = { "HolidayStuffing" }
    },
    Fruitcake = {
        Id = "F",
        ImageId = "rbxassetid://135864465307102",
        Priority = 11,
        BaseTime = 230,
        BaseWeight = 2.2,
        Requires = {
            Count = 4,
            Ingredients = {
                Bread = v2,
                Fruit = PlantTraitsData.Traits.Fruit,
                Berry = PlantTraitsData.Traits.Berry,
                Sweet = PlantTraitsData.Traits.Sweet
            }
        },
        Results = { "Fruitcake" }
    },
    Eggnog = {
        Id = "G",
        ImageId = "rbxassetid://113004493719741",
        Priority = 10,
        BaseTime = 140,
        BaseWeight = 1.6,
        Requires = {
            Count = 3,
            Ingredients = {
                Creamy = PlantTraitsData.Traits.Creamy,
                Sweet = PlantTraitsData.Traits.Sweet,
                Root = PlantTraitsData.Traits.Root
            }
        },
        Results = { "Eggnog" }
    }
};
local v7 = {};

for i, _ in v1.Recipes do
    v7[i] = i;
end;

v1.RecipeNames = v7;

return v1;