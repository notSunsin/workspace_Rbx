-- Decompiled with Potassium's decompiler.

return {
    ["Milk of the Land"] = {
        Description = "All plants within <Range> studs grow <Multiplier>x faster!",
        States = {
            Range = {
                Base = 10,
                Scale = 0.1
            },
            Multiplier = {
                Base = 1.25,
                Scale = 0.0125
            }
        }
    },
    ["For the Blue Colony"] = {
        Description = "<Chance>% chance harvested fruit duplicate! Rarer crops have lower chance to duplicate.",
        States = {
            Chance = {
                Max = 30,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["For the Red Colony"] = {
        Description = "<Chance>% chance harvested fruit duplicate! Rarer crops have lower chance to duplicate.",
        States = {
            Chance = {
                Max = 30,
                Base = 5,
                Scale = 0.1
            }
        }
    },
    ["Candy Harvester"] = {
        Description = "<Chance>% extra chance for Candy type fruit to duplicate!",
        States = {
            Chance = {
                Max = 20,
                Base = 5,
                Scale = 0.15
            }
        }
    },
    ["Slow and Steady"] = {
        Description = "<Chance>% extra chance harvested plants drop seeds. Rarer plants have lower chance to drop seeds.",
        States = {
            Chance = {
                Max = 10,
                Base = 5,
                Scale = 0.05
            }
        }
    },
    ["Rainbow Slow and Steady"] = {
        Description = "<Chance>% extra chance harvested plants drop seeds. Rarer plants have lower chance to drop seeds.",
        States = {
            Chance = {
                Max = 16,
                Base = 8,
                Scale = 0.08
            }
        }
    },
    ["Digging Buddy"] = {
        Description = "Every <Cooldown>s, <Chance>% chance to dig up a random seed!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 60,
                Scale = -1
            },
            Chance = {
                Base = 5,
                Scale = 0.05
            }
        }
    },
    ["Digging Friend"] = {
        Description = "Every <Cooldown>s, <Chance>% chance to dig up a random seed!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 60,
                Scale = -1
            },
            Chance = {
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["Carrot Chomper"] = {
        Description = "Every <Cooldown>s, eats a carrot for <Multiplier>x value bonus!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 45,
                Scale = -1
            },
            Multiplier = {
                Base = 1.5,
                Scale = 0.015
            }
        }
    },
    ["Carrot Devourer"] = {
        Description = "Every <Cooldown>s, eats a carrot for <Multiplier>x value bonus!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 40,
                Scale = -1
            },
            Multiplier = {
                Base = 3,
                Scale = 0.03
            }
        }
    },
    ["Buttercup Muncher"] = {
        Description = "Every <Cooldown>s, eats a buttercup and drops two seeds!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 180,
                Scale = -0.5
            }
        }
    },
    ["Rainbow Buttercup Muncher"] = {
        Description = "Every <Cooldown>s, eats a buttercup and drops three seeds!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 45,
                Scale = -0.5
            }
        }
    },
    ["Cat Nap"] = {
        Description = "Every <Cooldown>s, naps for <Duration>s. New fruit within <Range> studs will be <Multiplier>x larger!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 80,
                Scale = -1
            },
            Duration = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            },
            Range = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            },
            Multiplier = {
                Max = 4,
                Base = 1.25,
                Scale = 0.0025
            }
        }
    },
    ["Lazy Nap"] = {
        Description = "Every <Cooldown>s, naps for <Duration>s. New fruit within <Range> studs will be <Multiplier>x larger!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 90,
                Scale = -1
            },
            Duration = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            },
            Range = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            },
            Multiplier = {
                Max = 5,
                Base = 1.5,
                Scale = 0.01
            }
        }
    },
    Forester = {
        Description = "<Chance>% chance berry fruit stays after collecting! Rarer plants have rarer chance to replant",
        States = {
            Chance = {
                Max = 5,
                Base = 2.5,
                Scale = 0.025
            }
        }
    },
    ["Spotted Forester"] = {
        Description = "<Chance>% chance berry fruit stays after collecting! Rarer plants have rarer chance to replant",
        States = {
            Chance = {
                Max = 10,
                Base = 5,
                Scale = 0.05
            }
        }
    },
    ["Water Spray"] = {
        Description = "Every <Cooldown>s, sprays water on a nearby plant.",
        States = {
            Cooldown = {
                Min = 5,
                Base = 30,
                Scale = -1
            }
        }
    },
    Eggcelerator = {
        Description = "Increases egg hatch speed by <Multiplier>%!",
        States = {
            Multiplier = {
                Max = 35,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["Better Eggcelerator"] = {
        Description = "Increases egg hatch speed by <Multiplier>%!",
        States = {
            Multiplier = {
                Max = 65,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Fertilizer Frenzy"] = {
        Description = "Every <Cooldown>s, emits an aura for <Duration>s granting <Multiplier>x chance for new fruit to grow as variants within <Range> studs!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 120,
                Scale = -1
            },
            Duration = {
                Base = 15,
                Scale = 0.15
            },
            Range = {
                Base = 15,
                Scale = 0.15
            },
            Multiplier = {
                Base = 2,
                Scale = 0.01
            }
        }
    },
    ["Turtle Tinkerer"] = {
        Description = "All Sprinklers last <Multiplier>% longer!",
        States = {
            Range = {
                Base = 35,
                Scale = 0.5
            },
            Multiplier = {
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Cheeky Refund"] = {
        Description = "<Chance>% chance to refund fruit back to your inventory. Rarer plants have lower chance to refund!",
        States = {
            Chance = {
                Max = 8,
                Base = 2.5,
                Scale = 0.025
            }
        }
    },
    ["Premium Cheeky Refund"] = {
        Description = "<Chance>% chance to refund fruit back to your inventory. Rarer plants have lower chance to refund!",
        States = {
            Chance = {
                Max = 20,
                Base = 7.5,
                Scale = 0.075
            }
        }
    },
    ["Movement Variation"] = {
        Description = " ",
        States = {
            Cooldown = {
                Min = 8,
                Base = 8,
                Scale = 0
            }
        }
    },
    Transmutation = {
        Description = "Every <Cooldown>m, turns one random fruit gold!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 300,
                Scale = -3,
                Formatter = "ColonTime"
            }
        }
    },
    ["Polar Express"] = {
        Description = "Every <Cooldown>s, <Chance>% chance a nearby fruit becomes Chilled or Frozen!",
        States = {
            Cooldown = {
                Min = 10,
                Base = 80,
                Scale = -1
            },
            Chance = {
                Base = 10,
                Scale = 0.1
            }
        }
    },
    Bamboozle = {
        Description = "Every <Cooldown>m, eats bamboo for <Multiplier>x value bonus!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 180,
                Scale = -1,
                Formatter = "ColonTime"
            },
            Multiplier = {
                Base = 1.5,
                Scale = 0.015
            }
        }
    },
    Loveboo = {
        Description = "Every <Cooldown>, applies Heartstruck mutation to a random Bamboo!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 180,
                Scale = -1.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Leaf Lover"] = {
        Description = "Passive: All leafy plants grow <Multiplier>x faster!",
        States = {
            Range = {
                Base = 25,
                Scale = 0
            },
            Multiplier = {
                Base = 1.45,
                Scale = 0.15
            }
        }
    },
    ["Zen Zone"] = {
        Description = "Every <Cooldown>s, prays for <Duration>s granting <Multiplier>x variant chance within <Range> studs!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 80,
                Scale = -1
            },
            Duration = {
                Base = 10,
                Scale = 0.1
            },
            Range = {
                Base = 10,
                Scale = 0.1
            },
            Multiplier = {
                Base = 1.5,
                Scale = 0.005
            }
        }
    },
    ["Prickly Lover"] = {
        Description = "Grants prickly plants in <Range> studs a <Multiplier>x size bonus!",
        States = {
            Multiplier = {
                Max = 2.2,
                Base = 1.5,
                Scale = 0.015
            },
            Range = {
                Max = 65,
                Base = 30,
                Scale = 0.2
            }
        }
    },
    ["Nocturnal Nursery"] = {
        Description = "Every <Cooldown>s, goes to the egg with the highest hatch time, and reduces its hatch time by <Amount>s!",
        States = {
            Cooldown = {
                Min = 10,
                Base = 60,
                Scale = -1
            },
            Amount = {
                Max = 60,
                Base = 25,
                Scale = 0.25
            }
        }
    },
    ["Treasure Hunter"] = {
        Description = "Every <Cooldown>s, digs down underground to find treasure. Can dig up gear or sheckles!",
        States = {
            Cooldown = {
                Min = 10,
                Base = 80,
                Scale = -1
            }
        }
    },
    Croak = {
        Description = "Every <Cooldown>m, croaks and a random nearby plant will advance growth by 24 hours!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 604.5,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Echo Croak"] = {
        Description = "Every <Cooldown>m, croaks and a random nearby plant will advance growth by 24 hours!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 303,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Prince of the Night"] = {
        Description = "All active pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Base = 0.2,
                Scale = 0.04
            }
        }
    },
    ["King of the Night"] = {
        Description = "All active pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Base = 0.2,
                Scale = 0.04
            }
        }
    },
    ["Big Eyes"] = {
        Description = "All active pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Base = 0.1,
                Scale = 0.07
            }
        }
    },
    ["Rainbow Big Eyes"] = {
        Description = "All active pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Base = 0.2,
                Scale = 0.14
            }
        }
    },
    Rascal = {
        Description = "Every <Cooldown>m, goes to another player\'s plot and steals (duplicates) a random crop and gives it to you!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 904.5,
                Scale = -4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Whisker Wisdom"] = {
        Description = "Every <Cooldown>m, gains additional <Amount> bonus experience!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 603,
                Scale = -8,
                Formatter = "ColonTime"
            },
            Amount = {
                Base = 500,
                Scale = 8
            }
        }
    },
    Scamper = {
        Description = "Grants additional <Chance>% increase to player movement speed!",
        States = {
            Chance = {
                Base = 12,
                Scale = 0.1
            }
        }
    },
    ["Seed Stash"] = {
        Description = "<Chance>% chance to not consume a use when using the Reclaimer!",
        States = {
            Chance = {
                Max = 30,
                Base = 10,
                Scale = 0.3
            }
        }
    },
    ["Nutty Apology"] = {
        Description = "Gains an additional <Amount> xp per second!",
        States = {
            Amount = {
                Max = 20,
                Base = 3,
                Scale = 0.3
            }
        }
    },
    ["Whiskier Wisdom"] = {
        Description = "Every <Cooldown>m, gains additional <Amount> bonus experience!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 503,
                Scale = -7,
                Formatter = "ColonTime"
            },
            Amount = {
                Base = 750,
                Scale = 11
            }
        }
    },
    ["Cheese Hop"] = {
        Description = "Grants additional <Chance>% increase to player jump height!",
        States = {
            Chance = {
                Base = 12,
                Scale = 0.1
            }
        }
    },
    ["Fruit Harvester"] = {
        Description = "<Chance>% extra chance for Fruit type crops to duplicate!",
        States = {
            Chance = {
                Max = 25,
                Base = 5,
                Scale = 0.1
            }
        }
    },
    Scoundrel = {
        Description = "Every <Cooldown>m, goes to another player\'s random crop tries to get a seed from it and gives it to you. If it succeeds it will try to steal again. Rarer seeds have less chance to succeed stealing!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 443,
                Scale = -5,
                Formatter = "ColonTime"
            }
        }
    },
    Zombify = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Zombified!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 1600,
                Scale = -18,
                Formatter = "ColonTime"
            },
            Chance = {
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Crimson Cradle"] = {
        Description = "Every <Cooldown>s, goes to the egg with the highest hatch time, and reduces its hatch time by <Amount>s!",
        States = {
            Cooldown = {
                Min = 10,
                Base = 60,
                Scale = -1
            },
            Amount = {
                Max = 100,
                Base = 45,
                Scale = 0.45
            }
        }
    },
    ["Monarch of Midnight"] = {
        Description = "All active pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Base = 0.5,
                Scale = 0.08
            }
        }
    },
    ["Sanguine Spike"] = {
        Description = "Grants prickly plants in <Range> studs a <Multiplier>x size bonus!",
        States = {
            Multiplier = {
                Max = 3.2,
                Base = 2,
                Scale = 0.02
            },
            Range = {
                Max = 75,
                Base = 30,
                Scale = 0.2
            }
        }
    },
    ["Prickly Blessing"] = {
        Description = "Grants prickly plants in <Range> studs a <Multiplier>x variant chance bonus!",
        States = {
            Multiplier = {
                Max = 2.2,
                Base = 1.15,
                Scale = 0.0115
            },
            Range = {
                Max = 88,
                Base = 22,
                Scale = 0.2
            }
        }
    },
    ["Moon Nap"] = {
        Description = "Every <Cooldown>s, naps for <Duration>s. New fruit within <Range> studs will be <Multiplier>x larger!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 70,
                Scale = -1
            },
            Duration = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            },
            Range = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            },
            Multiplier = {
                Max = 8,
                Base = 1.5,
                Scale = 0.02
            }
        }
    },
    ["Moon Harvest"] = {
        Description = "<Chance>% chance Night type fruit stays after harvest!",
        States = {
            Chance = {
                Max = 20,
                Base = 6,
                Scale = 0.6
            }
        }
    },
    Pollinator = {
        Description = "Every <Cooldown>m, flies to a nearby fruit and pollinates it, applying Pollinated mutation!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 1510,
                Scale = -16,
                Formatter = "ColonTime"
            }
        }
    },
    ["Beeter Pollinator"] = {
        Description = "Every <Cooldown>m, flies to a nearby fruit and pollinates it, applying Pollinated mutation!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 1210,
                Scale = -12,
                Formatter = "ColonTime"
            }
        }
    },
    ["Flower Harvest"] = {
        Description = "<Chance>% chance Flower type fruit stays after harvest!",
        States = {
            Chance = {
                Max = 5,
                Base = 1,
                Scale = 0.1
            }
        }
    },
    ["Wanna-Bee"] = {
        Description = "Every <Cooldown>m, goes to a nearby fruit and tries to pollinate it, but its not a bee so it fails and turns it to HoneyGlazed instead :(",
        States = {
            Cooldown = {
                Min = 60,
                Base = 1510,
                Scale = -16,
                Formatter = "ColonTime"
            }
        }
    },
    ["Queen Pollinator"] = {
        Description = "Every <Cooldown>m, a nearby fruit gets magically pollinated, applying Pollinated mutation!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 1220,
                Scale = -16,
                Formatter = "ColonTime"
            }
        }
    },
    ["For the Queen"] = {
        Description = "Every <Cooldown>m, the pet with the highest cooldown refreshes its ability!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 1328,
                Scale = -16,
                Formatter = "ColonTime"
            }
        }
    },
    ["Wasp Pollinator"] = {
        Description = "Every <Cooldown>m, flies to a nearby fruit and pollinates it, applying Pollinated mutation!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 1800,
                Scale = -18,
                Formatter = "ColonTime"
            }
        }
    },
    Stinger = {
        Description = "Every <Cooldown>m, stings a random pet and advances its ability cooldown by <Amount>s!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 602,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Amount = {
                Base = 60,
                Scale = 0.6
            }
        }
    },
    ["Tarantula Stinger"] = {
        Description = "Every <Cooldown>m, stings a random pet and advances its ability cooldown by <Amount>s!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 302,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Amount = {
                Base = 80,
                Scale = 0.8
            }
        }
    },
    Silksong = {
        Description = "Every <Cooldown>m, sings to a random pet and restores its hunger to 100%!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 763,
                Scale = -7,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Flutter"] = {
        Description = "Every <Cooldown>m, flies to a nearby fruit with 5+ mutations, removes all mutations from it and turns it Rainbow! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 15,
                Base = 1808,
                Scale = -18,
                Formatter = "ColonTime"
            }
        }
    },
    ["Disco Disco"] = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Disco!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 906,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Chance = {
                Base = 14,
                Scale = 1
            }
        }
    },
    ["Let Him Cook"] = {
        Description = "Every <Cooldown>m, <Chance>% chance to cook a nearby fruit. Usually Burnt, but occasionally Cooked!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 806,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Chance = {
                Base = 15,
                Scale = 0.25
            }
        }
    },
    ["King of the Grill"] = {
        Description = "All active pets gain an additional <Chance> XP/s! Also very tasty!",
        States = {
            Chance = {
                Base = 0.15,
                Scale = 0.03
            }
        }
    },
    ["Pack Bee"] = {
        Description = "Increases player backpack size by <Chance>!",
        States = {
            Chance = {
                Base = 30,
                Scale = 1
            }
        }
    },
    ["You\'re a Star"] = {
        Description = "Gains an additional <Amount> xp per second!",
        States = {
            Amount = {
                Max = 25,
                Base = 5,
                Scale = 0.5
            }
        }
    },
    ["Pinch Pocket"] = {
        Description = "Every <Cooldown>m goes to another random player and pinches them for their money and grants you <Amount> - <AmountHigh> sheckles. Pinched player does not lose sheckles.",
        States = {
            Cooldown = {
                Min = 15,
                Base = 378,
                Scale = -4,
                Formatter = "ColonTime"
            },
            Amount = {
                Base = 225,
                Scale = 25
            },
            AmountHigh = {
                Base = 425,
                Scale = 25
            }
        }
    },
    Scavenger = {
        Description = "When you get a Lucky Harvest: There is a <Chance>% chance to get an extra seed! (stacked chance capped at 12%)",
        States = {
            Chance = {
                Max = 6,
                Base = 3,
                Scale = 0.3
            }
        }
    },
    ["Cuckoo Luck"] = {
        Description = "When you get a Lucky Harvest: There is a <Chance>% chance to get triple seeds! (stacked chance capped at 12%)",
        States = {
            Chance = {
                Max = 6,
                Base = 2,
                Scale = 0.25
            }
        }
    },
    ["Rainbow Cuckoo Luck"] = {
        Description = "When you get a Lucky Harvest: There is a <Chance>% chance to get x4 seeds! (stacked chance capped at 12%)",
        States = {
            Chance = {
                Max = 6,
                Base = 2,
                Scale = 0.25
            }
        }
    },
    ["Tropical Lover"] = {
        Description = "Grants all tropical plants within <Range> studs, a <Multiplier>x size bonus!",
        States = {
            Multiplier = {
                Max = 2.1,
                Base = 1.2,
                Scale = 0.05
            },
            Range = {
                Max = 60,
                Base = 25,
                Scale = 0.25
            }
        }
    },
    ["Tropical Blessing"] = {
        Description = "Grants all tropical plants within <Range> studs, a <Multiplier>x variant chance bonus!",
        States = {
            Multiplier = {
                Max = 8,
                Base = 1.15,
                Scale = 0.1
            },
            Range = {
                Max = 60,
                Base = 25,
                Scale = 0.25
            }
        }
    },
    Flamboyance = {
        Description = "Every <Cooldown>m, stands on one leg for <Duration>s. All plants and fruits within <Range> studs will grow <Multiplier>x faster!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 240,
                Scale = -2,
                Formatter = "ColonTime"
            },
            Duration = {
                Base = 15,
                Scale = 0.5
            },
            Range = {
                Base = 13,
                Scale = 0.3
            },
            Multiplier = {
                Base = 15,
                Scale = 0.25
            }
        }
    },
    ["Shell Share"] = {
        Description = "Every <Cooldown>m, shares its wisdom with a random pet, granting <Amount> bonus experience!",
        States = {
            Cooldown = {
                Min = 20,
                Base = 720,
                Scale = -6.5,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 2800,
                Base = 990,
                Scale = 14
            }
        }
    },
    ["Water Splash"] = {
        Description = "Every <Cooldown>s, splashes water at a nearby fruit and it has a <Chance>% chance to become Wet!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 164,
                Scale = -3
            },
            Chance = {
                Base = 12,
                Scale = 0.2
            }
        }
    },
    ["Seal the Deal"] = {
        Description = "Selling pets have a <Chance>% chance to get the pet back as its egg equivalent! Cannot get Premium/Exotic/Rainbow Eggs back. This bonus is capped at 50% per pet sold.",
        States = {
            Chance = {
                Max = 10,
                Base = 1,
                Scale = 0.05
            }
        }
    },
    ["Helping Hands"] = {
        Description = "When crafting, each material used in the recipe has a <Chance>% chance to not get consumed!",
        States = {
            Chance = {
                Max = 7,
                Base = 3,
                Scale = 0.33
            }
        }
    },
    Eggsperience = {
        Description = "Pets hatched from eggs have a bonus 1 - <Chance> age to their age value!",
        States = {
            Chance = {
                Max = 10,
                Base = 4.5,
                Scale = 0.5
            }
        }
    },
    ["Dark Chirp"] = {
        Description = "Pets hatched from eggs have a bonus 1 - <Chance> age to their age value!",
        States = {
            Chance = {
                Max = 15,
                Base = 3,
                Scale = 0.1
            }
        }
    },
    ["Rainbow Dark Chirp"] = {
        Description = "Pets hatched from eggs have a bonus 1 - <Chance> age to their age value!",
        States = {
            Chance = {
                Max = 17,
                Base = 4,
                Scale = 0.125
            }
        }
    },
    ["Utter Beauty"] = {
        Description = "Every <Cooldown>m, fans its feathers and all active pets within <Range> studs will advance cooldown for their abilities by <Amount>s!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 606,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 150,
                Base = 65,
                Scale = 0.6
            },
            Range = {
                Max = 60,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Chill Zone"] = {
        Description = "All pets within <Range> studs won\'t lose hunger and will gain <Amount> XP every second!",
        States = {
            Amount = {
                Max = 30,
                Base = 3,
                Scale = 0.3
            },
            Range = {
                Max = 40,
                Base = 14.5,
                Scale = 0.25
            }
        }
    },
    ["Verdant Bird"] = {
        Description = "Every <Cooldown>m, <Chance>% chance to mutate a nearby fruit, applying the Verdant mutation!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 524,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Chance = {
                Base = 15,
                Scale = 0.5
            }
        }
    },
    Mimicry = {
        Description = "Every <Cooldown>m, mimics and copies an ability from another pet and performs its ability!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 1212,
                Scale = -12,
                Formatter = "ColonTime"
            }
        }
    },
    ["Coiled Commerce"] = {
        Description = "Buying from the seed/gear shop has a <Chance>% chance to duplicate the bought item! (Max 50%)",
        States = {
            Chance = {
                Max = 6,
                Base = 1,
                Scale = 0.25
            }
        }
    },
    Lookout = {
        Description = "Every <Cooldown>m goes to another pet and does a lookout. That pet advances cooldown by <Amount>s! Has a <Chance>% chance to do it again after each lookout.",
        States = {
            Cooldown = {
                Min = 15,
                Base = 444,
                Scale = -4.4,
                Formatter = "ColonTime"
            },
            Amount = {
                Base = 20,
                Scale = 0.5
            },
            Chance = {
                Max = 100,
                Base = 15,
                Scale = 0.25
            }
        }
    },
    ["Summer Regeneration"] = {
        Description = "<Chance>% chance Summer type fruit stays after collecting! Rarer plants have rarer chance to replant",
        States = {
            Chance = {
                Max = 13,
                Base = 6,
                Scale = 0.2
            }
        }
    },
    ["Cloudtouched Bird"] = {
        Description = "Every <Cooldown>m, <Chance>% chance to mutate a nearby fruit, applying the Cloudtouched mutation!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 486,
                Scale = -4,
                Formatter = "ColonTime"
            },
            Chance = {
                Base = 15,
                Scale = 0.5
            }
        }
    },
    Sly = {
        Description = "Every <Cooldown>m, goes to another player\'s random fruit, has a <Chance>% chance to copy a random mutation and apply it to a random fruit you own!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 1110,
                Scale = -15,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 36,
                Base = 18,
                Scale = 0.18
            }
        }
    },
    ["Hamster Wheel"] = {
        Description = "Every <Cooldown>m, runs in a hamster wheel and boosts crafting speed by <Amount>% for <Duration>s!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 188,
                Scale = -1.5,
                Formatter = "ColonTime"
            },
            Amount = {
                Base = 30,
                Scale = 0.3
            },
            Duration = {
                Base = 18,
                Scale = 0.5
            }
        }
    },
    Hamster = {
        Description = "Crafting speed is increased by <Chance>%!",
        States = {
            Chance = {
                Max = 25,
                Base = 15,
                Scale = 0.5
            }
        }
    },
    ["Wings of Freedom"] = {
        Description = "Every <Cooldown>m, takes flight and spreads its wings. All eggs advanced their hatch time by <Amount>s! There\'s a <Chance>% chance for the time advance to be multiplied by <Multiplier>.",
        States = {
            Cooldown = {
                Min = 424,
                Base = 424,
                Scale = 0,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 70.4,
                Base = 70.4,
                Scale = 0
            },
            Chance = {
                Max = 70.4,
                Base = 70.4,
                Scale = 0
            },
            Multiplier = {
                Base = 1.8,
                Scale = 0.18
            }
        }
    },
    Birbegg = {
        Description = "Every <Cooldown>m, can use its cuteness to hatch eggs faster. All eggs advanced their hatch time by <Amount>s! There\'s a <Chance>% chance for the time advance to be multiplied by <Multiplier>.",
        States = {
            Cooldown = {
                Min = 300,
                Base = 300,
                Scale = 0,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 150,
                Base = 150,
                Scale = 0
            },
            Chance = {
                Max = 30,
                Base = 30,
                Scale = 0
            },
            Multiplier = {
                Base = 2.5,
                Scale = 0.15
            }
        }
    },
    ["Rainbow Birbegg"] = {
        Description = "Every <Cooldown>m, can use its cuteness to hatch eggs faster. All eggs advanced their hatch time by <Amount>s! There\'s a <Chance>% chance for the time advance to be multiplied by <Multiplier>.",
        States = {
            Cooldown = {
                Min = 150,
                Base = 150,
                Scale = 0,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 300,
                Base = 300,
                Scale = 0
            },
            Chance = {
                Max = 50,
                Base = 50,
                Scale = 0
            },
            Multiplier = {
                Base = 5,
                Scale = 0.25
            }
        }
    },
    ["Sparkle Squack"] = {
        Description = "Every <Cooldown>, has a <Chance>% chance to apply the goldsparkle mutation to a nearby fruit!",
        States = {
            Cooldown = {
                Min = 1000,
                Base = 3000,
                Scale = -7.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Min = 5,
                Base = 15,
                Scale = 0.5
            }
        }
    },
    ["Rainbow Sparkle Squack"] = {
        Description = "Every <Cooldown>, has a <Chance>% chance to apply the goldsparkle mutation to a nearby fruit!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1500,
                Scale = -15,
                Formatter = "ColonTime"
            },
            Chance = {
                Min = 10,
                Base = 35,
                Scale = 1.5
            }
        }
    },
    ["Clever Claws"] = {
        Description = "<Chance>% chance fruit gets Amber mutation after collecting! Rarer plants have lesser chance to mutate.",
        States = {
            Chance = {
                Base = 2,
                Scale = 0.2
            }
        }
    },
    ["Raptor Dance"] = {
        Description = "Grants additional <Chance>% increase to player movement speed!",
        States = {
            Chance = {
                Base = 14,
                Scale = 0.25
            }
        }
    },
    ["Tri-Horn"] = {
        Description = "Every <Cooldown>m, rams into <Amount> random plants and advance their growth by <GrowthAmount>m! Has a <Chance>% chance to do it again each time.",
        States = {
            Cooldown = {
                Min = 213,
                Base = 213,
                Scale = 0,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 3,
                Base = 3,
                Scale = 0
            },
            GrowthAmount = {
                Max = 2013,
                Base = 2013,
                Scale = 0,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            }
        }
    },
    ["Prehistoric Doubling"] = {
        Description = "<Chance>% chance harvested fruit duplicates! Rarer crops have lower chance to duplicate.",
        States = {
            Chance = {
                Max = 28,
                Base = 8,
                Scale = 0.15
            }
        }
    },
    ["Prehistoric Harvester"] = {
        Description = "<Chance>% extra chance for Prehistoric type fruit to duplicate!",
        States = {
            Chance = {
                Max = 25,
                Base = 5,
                Scale = 0.1
            }
        }
    },
    ["Air Time"] = {
        Description = "Grants additional <Chance>% increase to player jump height!",
        States = {
            Chance = {
                Base = 14,
                Scale = 0.25
            }
        }
    },
    ["Giant Incubator"] = {
        Description = "Pets hatched from eggs have a <Chance>% increase in base size and weight! This size bonus is capped at 30% per egg and does not apply to Brontosauruses.",
        States = {
            Chance = {
                Max = 30,
                Base = 5.25,
                Scale = 0.1
            }
        }
    },
    ["Sky Reptile"] = {
        Description = "Every <Cooldown>m, flaps its wings and sends out ripples of wind, causing <Amount> random fruit to get Windstruck, with a <Chance>% chance for Twisted to be applied as well!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 666,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Amount = {
                Base = 3,
                Scale = 0.15
            },
            Chance = {
                Base = 18.2,
                Scale = 0.25
            }
        }
    },
    ["Apex Predator"] = {
        Description = "Every <Cooldown>m, devours a random mutation from your garden, then roars, spreading that mutation to <Amount> other random fruits in your garden!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 1224,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Amount = {
                Base = 3,
                Scale = 0.2
            }
        }
    },
    ["Crowbar Head"] = {
        Description = "Every <Cooldown>s, goes to the cosmetic crate with the highest open time, and reduces its open time by <Amount>s! There is a <Chance>% chance for open time reduction to be multiplied by <Multiplier>x",
        States = {
            Cooldown = {
                Min = 10,
                Base = 82,
                Scale = -1.8
            },
            Amount = {
                Base = 80,
                Scale = 0.65
            },
            Chance = {
                Base = 25.5,
                Scale = 0.25
            },
            Multiplier = {
                Base = 1.5,
                Scale = 0.2
            }
        }
    },
    ["Dino Herd"] = {
        Description = "All active Dinosaur type pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Base = 0.6,
                Scale = 0.06
            }
        }
    },
    ["Crafty Dome"] = {
        Description = "Grants a <Chance>% chance to duplicate a crafted item!",
        States = {
            Chance = {
                Max = 25,
                Base = 6,
                Scale = 0.3
            }
        }
    },
    ["Frilled Reptile"] = {
        Description = "Every <Cooldown>m opens its frills and spits out venom! The venom spreads to <Number> other random pets, advancing cooldown by <AmountCD> OR granting <AmountXP> xp!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 846,
                Scale = -8.4,
                Formatter = "ColonTime"
            },
            Number = {
                Max = 5,
                Base = 3,
                Scale = 0.2
            },
            AmountCD = {
                Max = 100,
                Base = 40,
                Scale = 0.25
            },
            AmountXP = {
                Max = 2500,
                Base = 500,
                Scale = 40
            }
        }
    },
    ["Armored Defender"] = {
        Description = "When another player steals fruit from you, grants a <Chance>% chance you get the stolen fruit as well!",
        States = {
            Chance = {
                Max = 35,
                Base = 18.7,
                Scale = 0.25
            }
        }
    },
    ["Food Chain"] = {
        Description = "Every <Cooldown>m, devours a random mutation from <Amount> fruits in your garden each, then roars, spreading those mutations to 1 random fruit in your garden! Prioritizes applying mutations to a favorited fruit.",
        States = {
            Cooldown = {
                Min = 30,
                Base = 1224,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 20,
                Base = 3,
                Scale = 0.2
            }
        }
    },
    ["Rainbow Crowbar Head"] = {
        Description = "Every <Cooldown>s, goes to the cosmetic crate with the highest open time, and reduces its open time by <Amount>s! There is a <Chance>% chance for open time reduction to be multiplied by <Multiplier>x",
        States = {
            Cooldown = {
                Min = 10,
                Base = 41,
                Scale = -0.9
            },
            Amount = {
                Base = 160,
                Scale = 1.3
            },
            Chance = {
                Base = 51,
                Scale = 0.5
            },
            Multiplier = {
                Base = 3,
                Scale = 0.4
            }
        }
    },
    ["Rainbow Dino Herd"] = {
        Description = "All active Dinosaur type pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Base = 1.2,
                Scale = 0.12
            }
        }
    },
    ["Rainbow Crafty Dome"] = {
        Description = "Grants a <Chance>% chance to duplicate a crafted item!",
        States = {
            Chance = {
                Max = 50,
                Base = 12,
                Scale = 0.6
            }
        }
    },
    ["Rainbow Frilled Reptile"] = {
        Description = "Every <Cooldown>m opens its frills and spits out venom! The venom spreads to <Number> other random pets, advancing cooldown by <AmountCD> OR granting <AmountXP> xp!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 643,
                Scale = -6.4,
                Formatter = "ColonTime"
            },
            Number = {
                Max = 12,
                Base = 3,
                Scale = 0.2
            },
            AmountCD = {
                Max = 160,
                Base = 80,
                Scale = 1
            },
            AmountXP = {
                Max = 6000,
                Base = 1000,
                Scale = 80
            }
        }
    },
    ["Rainbow Armored Defender"] = {
        Description = "When another player steals fruit from you, grants a <Chance>% chance you get the stolen fruit as well!",
        States = {
            Chance = {
                Max = 60,
                Base = 31.4,
                Scale = 0.5
            }
        }
    },
    ["Rainbow Food Chain"] = {
        Description = "Every <Cooldown>m, devours a random mutation from <Amount> fruits in your garden each, then roars, spreading those mutations to 1 random fruit in your garden! Prioritizes applying mutations to a favorited fruit.",
        States = {
            Cooldown = {
                Min = 30,
                Base = 912,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 30,
                Base = 6,
                Scale = 0.4
            }
        }
    },
    ["Man\'s Best Tomodachi"] = {
        Description = "Every <Cooldown>s, <Chance>% chance to dig up a random seed!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 60,
                Scale = -1
            },
            Chance = {
                Base = 15,
                Scale = 0.05
            }
        }
    },
    ["Bathe Time"] = {
        Description = "As long as you have a Hot Spring cosmetic in your garden: The pet bathes in it to relax.",
        States = {
            Boost = {
                Max = 0,
                Base = 0,
                Scale = 0
            }
        }
    },
    Mischief = {
        Description = "Every <Cooldown>m, causes mischief, doing random different actions in your garden!",
        States = {
            Cooldown = {
                Min = 80,
                Base = 640,
                Scale = -3.6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Balance and Harmony"] = {
        Description = "Every <Cooldown>m, meditates for <Duration>s, nearby fruits in a <Range> studs have a <Chance>% chance every second to mutate into Tranquil!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 627,
                Scale = -1,
                Formatter = "ColonTime"
            },
            Duration = {
                Base = 10,
                Scale = 0.1
            },
            Range = {
                Base = 15,
                Scale = 0.1
            },
            Chance = {
                Base = 5,
                Scale = 0.05
            }
        }
    },
    ["Water Spirit"] = {
        Description = "Every <Cooldown>m, sprays water on all fruits within <Range> studs, applying Wet mutation. Has a <Chance>% chance to replace Wet mutations already on fruit with Bloodlit mutation!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 514,
                Scale = -4,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 50,
                Base = 20,
                Scale = 0.2
            },
            Chance = {
                Max = 30,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["Nine-Tailed Myth"] = {
        Description = "Every <Cooldown>m, goes to another player\'s crop, mutates it with <font color=\"rgb(255, 80, 65)\">Chakra</font> then steals (duplicates) and gives it to you! Very rare chance to mutate with <font color=\"rgb(255, 0, 0)\">Foxfire Chakra</font> mutation instead!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 1344.5,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Tough Love"] = {
        Description = "Every <Cooldown>m, goes to another player\'s crop, mutates it with <font color=\"rgb(255, 80, 65)\">Cute</font> then steals (duplicates) and gives it to you! Very rare chance to mutate with <font color=\"rgb(255, 0, 0)\">Heartbound</font> mutation instead!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 3000,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Fish of Fortune"] = {
        Description = "When hatching eggs there is a <Chance>% chance to get the egg back! Cannot recover Premium/Exotic/Rainbow Eggs. This bonus is capped at 50% per egg hatched.",
        States = {
            Chance = {
                Max = 10,
                Base = 1,
                Scale = 0.22
            }
        }
    },
    Touchdown = {
        Description = "Every <Cooldown>s, runs to the Gear Shop or Seed Shop (whichever is farther) and does a touchdown which awards you with 870 Sheckles or <Chance>% chance for a Watering Can instead!",
        States = {
            Cooldown = {
                Min = 87,
                Base = 87,
                Scale = 0
            },
            Chance = {
                Max = 35,
                Base = 20,
                Scale = 0.33
            }
        }
    },
    ["Fortune Cat"] = {
        Description = "Every <Cooldown>m, waves and invites good fortune that grants <Chance>% chance to refund fruit back to your inventory for <Duration>s! Rarer fruit have rarer chance to refund.",
        States = {
            Cooldown = {
                Min = 30,
                Base = 143,
                Scale = -0.6,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 20,
                Base = 8,
                Scale = 0.15
            },
            Duration = {
                Max = 22,
                Base = 10,
                Scale = 0.25
            }
        }
    },
    ["Tree Spirit"] = {
        Description = "<Chance>% chance Zen type fruit gets Tranquil mutation after collecting!",
        States = {
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.33
            }
        }
    },
    ["Corrupted Tree Spirit"] = {
        Description = "<Chance>% chance Zen type fruit gets Corrupt mutation after collecting!",
        States = {
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.33
            }
        }
    },
    ["Lightning Beast"] = {
        Description = "Every <Cooldown>m, devours a fruit with Shocked mutation for 1.5x sheckle value to Summon a chain of lightning to mutate <Amount> fruits with Static! During a Thunderstorm: <Chance>% chance for Shocked instead!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 622,
                Scale = -2.6,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 9,
                Base = 4,
                Scale = 0.15
            },
            Chance = {
                Max = 35,
                Base = 20,
                Scale = 0.15
            }
        }
    },
    ["Nine-Tailed Curse"] = {
        Description = "Every <Cooldown>m, launches cursed energy at 9 different fruits. Each fruit has <Chance>% chance to mutate with <font color=\"rgb(0, 85, 255)\">Corrupt Chakra</font> with a very rare chance for <font color=\"rgb(0, 0, 255)\">Corrupt Foxfire Chakra</font> instead!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 1260,
                Scale = -3.6,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Rainbow Fortune Cat"] = {
        Description = "Every <Cooldown>m, waves and invites good fortune that grants <Chance>% chance to refund fruit back to your inventory for <Duration>s! Rarer fruit have rarer chance to refund.",
        States = {
            Cooldown = {
                Min = 15,
                Base = 72,
                Scale = -0.6,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.3
            },
            Duration = {
                Max = 42,
                Base = 20,
                Scale = 0.25
            }
        }
    },
    ["Rainbow Tree Spirit"] = {
        Description = "<Chance>% chance Zen type fruit gets Tranquil mutation after collecting!",
        States = {
            Chance = {
                Max = 16,
                Base = 8,
                Scale = 0.4
            }
        }
    },
    ["Rainbow Nine-Tailed Curse"] = {
        Description = "Every <Cooldown>m, launches cursed energy at 9 different fruits. Each fruit has <Chance>% chance to mutate with <font color=\"rgb(0, 85, 255)\">Corrupt Chakra</font> with a very rare chance for <font color=\"rgb(0, 0, 255)\">Corrupt Foxfire Chakra</font> instead!",
        States = {
            Cooldown = {
                Min = 30,
                Base = 630,
                Scale = -3.6,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 50,
                Base = 25,
                Scale = 0.2
            }
        }
    },
    ["Bagel and Carrots"] = {
        Description = "Every <Cooldown>s, eats a carrot for <Multiplier>x value bonus!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 45,
                Scale = -1
            },
            Multiplier = {
                Base = 5,
                Scale = 0.05
            }
        }
    },
    ["Pancake Hunter"] = {
        Description = "Every <Cooldown>s, digs down underground to find treasure. Can dig up gear or sheckles!",
        States = {
            Cooldown = {
                Min = 10,
                Base = 80,
                Scale = -1
            }
        }
    },
    ["Sushi Express"] = {
        Description = "Every <Cooldown>s, <Chance>% chance a nearby fruit becomes Chilled or Frozen",
        States = {
            Cooldown = {
                Min = 10,
                Base = 80,
                Scale = -1
            },
            Chance = {
                Base = 15,
                Scale = 0.15
            }
        }
    },
    ["Sushi Time"] = {
        Description = "Every <Cooldown>m, flings sushi towards a random pet and feeds it for <Amount>% of its hunger",
        States = {
            Cooldown = {
                Min = 60,
                Base = 670,
                Scale = -3.5,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 0.5,
                Base = 0.01,
                Scale = 0.001,
                Formatter = "Percentage"
            }
        }
    },
    ["Al dente"] = {
        Description = "Every <Cooldown>m, goes to a nearby fruit and does-a-cooking! Applying Pasta, Sauce or Meatball mutation!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 845,
                Scale = -7.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Friendly Frier"] = {
        Description = "Every <Cooldown>m, increases a random pet\'s level by 1! Ability cannot be mimicked or refreshed.",
        States = {
            Cooldown = {
                Min = 1200,
                Base = 3632,
                Scale = -36,
                Formatter = "ColonTime"
            }
        }
    },
    ["Mochi Marathon"] = {
        Description = "All active Food type pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Base = 0.75,
                Scale = 0.15
            }
        }
    },
    ["OIL OR BOIL"] = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit gets the Oil mutation!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 906,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 14,
                Scale = 0.25
            }
        }
    },
    ["Bacon Frenzy"] = {
        Description = "Every <Cooldown>s, emits an aura for <Duration>s granting <Multiplier>x chance for new fruit to grow as variants within <Range> studs!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 120,
                Scale = -1
            },
            Duration = {
                Base = 15,
                Scale = 0.15
            },
            Range = {
                Base = 15,
                Scale = 0.15
            },
            Multiplier = {
                Base = 2,
                Scale = 0.01
            }
        }
    },
    ["Loaded Dog"] = {
        Description = "Every <Cooldown>m, drops a <Radius> stud mustard or ketchup puddle that lasts <Duration> seconds. Pets on mustard have their cooldowns tick by <Amount> faster and pets on ketchup gain <Multiplier>% more experience!",
        States = {
            Cooldown = {
                Min = 80,
                Base = 240,
                Scale = -1.5,
                Formatter = "ColonTime"
            },
            Multiplier = {
                Max = 0.4,
                Base = 0.2,
                Scale = 0.01,
                Formatter = "Percentage"
            },
            Amount = {
                Max = 0.5,
                Base = 0.06,
                Scale = 0.05
            },
            Duration = {
                Max = 45,
                Base = 30,
                Scale = 0.15
            },
            Radius = {
                Max = 16,
                Base = 8,
                Scale = 0.08
            }
        }
    },
    ["Molten Boiling Point"] = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Molten!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 900,
                Scale = -4.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Base = 20,
                Scale = 0.1
            }
        }
    },
    ["Meteoric Boiling Point"] = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Meteoric!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1800,
                Scale = -8.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["Rainbow Bacon Frenzy"] = {
        Description = "Every <Cooldown>s, emits an aura for <Duration>s granting <Multiplier>x chance for new fruit to grow as variants within <Range> studs!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 80,
                Scale = -1
            },
            Duration = {
                Base = 30,
                Scale = 0.15
            },
            Range = {
                Base = 30,
                Scale = 0.15
            },
            Multiplier = {
                Base = 3,
                Scale = 0.01
            }
        }
    },
    ["Rainbow Loaded Dog"] = {
        Description = "Every <Cooldown>m, drops a <Radius> stud mustard or ketchup puddle that lasts <Duration> seconds. Pets on mustard have their cooldowns tick by <Amount> faster and pets on ketchup gain <Multiplier>% more experience!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 200,
                Scale = -1.5,
                Formatter = "ColonTime"
            },
            Multiplier = {
                Max = 0.4,
                Base = 0.3,
                Scale = 0.01,
                Formatter = "Percentage"
            },
            Amount = {
                Max = 0.75,
                Base = 0.09,
                Scale = 0.075
            },
            Duration = {
                Max = 60,
                Base = 45,
                Scale = 0.15
            },
            Radius = {
                Max = 32,
                Base = 16,
                Scale = 0.08
            }
        }
    },
    ["Rainbow Molten Boiling Point"] = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Molten!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 700,
                Scale = -4.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Base = 40,
                Scale = 0.2
            }
        }
    },
    ["Rainbow Meteoric Boiling Point"] = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Meteoric!",
        States = {
            Cooldown = {
                Min = 400,
                Base = 1400,
                Scale = -8.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["King Cook"] = {
        Description = "As long as you have a Cooking Pot cosmetic or Cooking Cauldron cosmetic in your garden: The Gorilla cooks in it and grants <Boost>% to duplicate food on cook!",
        States = {
            Boost = {
                Max = 10,
                Base = 5,
                Scale = 0.1
            }
        }
    },
    ["Trade-In"] = {
        Description = "When selling this pet: Has a small chance to get a Beanstalk seed!",
        States = {}
    },
    Thumper = {
        Description = "Every <Cooldown>s, thumps its feet and has a <Chance>% chance to mutate a nearby fruit, applying the Sandy mutation!",
        States = {
            Cooldown = {
                Min = 50,
                Base = 100,
                Scale = -0.25
            },
            Chance = {
                Base = 15,
                Scale = 0.25
            }
        }
    },
    Sprout = {
        Description = "Every <Cooldown>m, swaps mutations between two different random fruits! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 300,
                Base = 552,
                Scale = -1,
                Formatter = "ColonTime"
            }
        }
    },
    ["Tech Savvy"] = {
        Description = "Every <Cooldown>m goes to the mutation machine and tinkers with it and advances its time by <Amount>s!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 400,
                Scale = -1,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 80,
                Base = 40,
                Scale = 0.5
            }
        }
    },
    ["Golden Laying"] = {
        Description = "Every <Cooldown>m, lays a Golden Egg plant that starts with the Fortune mutation. It can be harvested and mutates like other plants. Selling it may apply Fortune mutation to a fruit in your garden!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 788,
                Scale = -1.5,
                Formatter = "ColonTime"
            }
        }
    },
    Overgrowth = {
        Description = "Every <Cooldown>m, spreads its roots and all fruit within <Range> studs have a <Chance>% chance to get the Bloom mutation!",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1330,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            },
            Range = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            }
        }
    },
    ["Peach Pollinator"] = {
        Description = "Every <Cooldown>m, flies to a nearby fruit and Plasmafies it, applying Plasma mutation!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 1500,
                Scale = -6.6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Peach Stinger"] = {
        Description = "Every <Cooldown>m, stings a random pet and advances its ability cooldown by <Amount>s!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 602,
                Scale = -3.5,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 120,
                Base = 60,
                Scale = 0.6
            }
        }
    },
    ["Apple Harvester"] = {
        Description = "Fruits that have apple in the name have a <Chance>% chance to duplicate when collected",
        States = {
            Chance = {
                Max = 8,
                Base = 4,
                Scale = 0.025
            }
        }
    },
    ["Sugar Warp"] = {
        Description = "Harvesting Sugar Apple crops have a <Chance>% chance to apply Warped mutation to a random fruit in your garden!",
        States = {
            Chance = {
                Max = 4,
                Base = 2,
                Scale = 0.05
            }
        }
    },
    ["Brain-Roar"] = {
        Description = "Every <Cooldown>m, roars whilst applying the Brainrot mutation to a random fruit!",
        States = {
            Cooldown = {
                Min = 300,
                Max = 300,
                Base = 912,
                Scale = -3.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Citrus Roar"] = {
        Description = "Every <Cooldown>m, roars and infuses a random pet with citrus, granting <Amount> bonus experience!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 600,
                Scale = -2.5,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 2500,
                Base = 1500,
                Scale = 15
            }
        }
    },
    ["Bean for the Bean God"] = {
        Description = "Every <Cooldown>m, sacrifices a random Beanstalk fruit in your garden to instantly grow a random plant with <Multiplier>x fruit size bonus! Ability cannot be mimicked or refreshed.",
        States = {
            Cooldown = {
                Min = 870,
                Base = 1800,
                Scale = -9,
                Formatter = "ColonTime"
            },
            Multiplier = {
                Max = 10,
                Base = 5,
                Scale = 0.1
            }
        }
    },
    ["Elk Forester"] = {
        Description = "<Chance>% chance berry fruit stays after collecting! Rarer plants have a rarer chance to replant",
        States = {
            Chance = {
                Max = 5,
                Base = 2.5,
                Scale = 0.025
            }
        }
    },
    ["Mandrake Essence"] = {
        Description = "Harvesting Mandrake crops have a <Chance>% chance to apply Rot mutation to a random fruit in your garden!",
        States = {
            Chance = {
                Max = 7,
                Base = 3.5,
                Scale = 0.05
            }
        }
    },
    ["Glorious Wings"] = {
        Description = "Every <Cooldown>m, flaunts its wings and releases a Cyclone. Pets struck have cooldown advanced by <CooldownAmount>s and fruits struck have a <Chance>% chance to get the Cyclonic mutation!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 935,
                Scale = -2,
                Formatter = "ColonTime"
            },
            CycloneAmount = {
                Max = 1,
                Base = 1,
                Scale = 0
            },
            CooldownAmount = {
                Max = 125,
                Base = 65,
                Scale = 1
            },
            Chance = {
                Max = 30,
                Base = 10,
                Scale = 0.15
            }
        }
    },
    ["Gnome Collector"] = {
        Description = "Every <Cooldown>m, has a <Chance>% chance to mutate a random fruit with the Gnomed mutation. Gains additional <Amount>% chance for every Gnome cosmetic in your garden.",
        States = {
            Cooldown = {
                Min = 200,
                Base = 600,
                Scale = -1.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 3,
                Base = 1,
                Scale = 0.025
            },
            Amount = {
                Max = 3,
                Base = 1,
                Scale = 0.025
            }
        }
    },
    ["Rainbow Elk Forester"] = {
        Description = "<Chance>% chance berry fruit stays after collecting! Rarer plants have rarer chance to replant",
        States = {
            Chance = {
                Max = 10,
                Base = 5,
                Scale = 0.05
            }
        }
    },
    ["Rainbow Mandrake Essence"] = {
        Description = "Harvesting Mandrake crops have a <Chance>% chance to apply Rot mutation to a random fruit in your garden!",
        States = {
            Chance = {
                Max = 14,
                Base = 7,
                Scale = 0.15
            }
        }
    },
    ["Rainbow Glorious Wings"] = {
        Description = "Every <Cooldown>m, flaunts its wings and releases 2 Cyclones. Pets struck have cooldown advanced by <CooldownAmount>s and fruits struck have a <Chance>% chance to get the Cyclonic mutation!",
        States = {
            Cooldown = {
                Min = 150,
                Base = 615,
                Scale = -2,
                Formatter = "ColonTime"
            },
            CycloneAmount = {
                Max = 2,
                Base = 2,
                Scale = 0
            },
            CooldownAmount = {
                Max = 200,
                Base = 100,
                Scale = 1.5
            },
            Chance = {
                Max = 50,
                Base = 18,
                Scale = 0.18
            }
        }
    },
    ["Flower Fortune"] = {
        Description = "All flower type plants grow <Multiplier>x faster!",
        States = {
            Range = {
                Max = 30,
                Base = 30,
                Scale = 0
            },
            Multiplier = {
                Max = 4,
                Base = 1.45,
                Scale = 0.05
            }
        }
    },
    ["Pixie Dust"] = {
        Description = "Every <Cooldown>m, spreads pixie dust for <Duration>s. All plants within <Range> studs will advance growth an extra 30 seconds every second! Also makes nearby players levitate!",
        States = {
            Cooldown = {
                Min = 100,
                Base = 222,
                Scale = -2.4,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 30,
                Base = 15,
                Scale = 0.05
            },
            Range = {
                Max = 30,
                Base = 15,
                Scale = 0.25
            }
        }
    },
    Scamp = {
        Description = "Every 6:66m, the Imp will playfully invite you to chase it. Catching the Imp will grant a random reward! The Imp has a <Chance>% chance to play again on successful chase!",
        States = {
            Cooldown = {
                Max = 426,
                Min = 426,
                Base = 426,
                Scale = 0,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.05
            }
        }
    },
    Glimmer = {
        Description = "Every <Cooldown>m, flies to a nearby fruit and enchants it, applying Glimmering mutation!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 220,
                Scale = -1,
                Formatter = "ColonTime"
            }
        }
    },
    ["Silver Screech"] = {
        Description = "Every <Cooldown>m, screeches and all fruits within <Range> studs have a <Chance>% chance to turn Silver; <GoldChance>% chance to turn Gold!",
        States = {
            Cooldown = {
                Min = 400,
                Base = 1000,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 40,
                Base = 20,
                Scale = 0.25
            },
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.05
            },
            GoldChance = {
                Max = 3,
                Base = 1,
                Scale = 0.01
            }
        }
    },
    ["Venom Spit"] = {
        Description = "Every <Cooldown>m, spits at <Amount> different fruit/eggs/pets. Fruits get Toxic mutation, eggs advance by <AmountEgg> seconds, pets gain <AmountXP> XP.",
        States = {
            Cooldown = {
                Min = 180,
                Base = 625,
                Scale = -3.5,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 10,
                Base = 5,
                Scale = 0.1
            },
            AmountEgg = {
                Max = 150,
                Base = 80,
                Scale = 0.5
            },
            AmountXP = {
                Max = 1500,
                Base = 800,
                Scale = 2.5
            }
        }
    },
    ["Magical Friend"] = {
        Description = "All Magical type plants grow <Multiplier>x faster",
        States = {
            Range = {
                Max = 30,
                Base = 30,
                Scale = 0
            },
            Multiplier = {
                Max = 4,
                Base = 1.5,
                Scale = 0.05
            }
        }
    },
    ["Mushroom Madness"] = {
        Description = "All nearby plants within <Range> studs will have increased <Multiplier>x size bonus for every Fungus type plant planted in your garden! (Max 300).",
        States = {
            Range = {
                Max = 40,
                Base = 14.75,
                Scale = 0.25
            },
            Multiplier = {
                Max = 0.01,
                Base = 0.004,
                Scale = 0.001,
                Formatter = "NoPrecision"
            }
        }
    },
    ["Bird of Rebirth"] = {
        Description = "Pets taken from the pet mutation machine have a bonus 10 - <Chance> age to their age value! (Max 80 age per pet)",
        States = {
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Bird of Rebirth Min"] = {
        Description = "",
        States = {
            Chance = {
                Max = 10,
                Base = 10,
                Scale = 0
            }
        }
    },
    Icarus = {
        Description = "Every <Cooldown>m, travels between <Amount> random fruit in your garden which get the Flaming mutation! Fruits passed have <Chance>% chance to mutated as well!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 460,
                Scale = -2.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            },
            Amount = {
                Max = 8,
                Base = 4,
                Scale = 0.1
            }
        }
    },
    ["Will-o-the-Wisp"] = {
        Description = "As long as you have a Wisp Well cosmetic in your garden: The Wisp will go to it to grant all other pets an additional bonus <Amount> xp per second",
        States = {
            Amount = {
                Max = 6.5,
                Base = 0.64,
                Scale = 0.1
            }
        }
    },
    Flambe = {
        Description = "Goes to any active Cooking Kit and breathes fire on it, helping the cooking process and boosting cooking speed by <Amount>%!",
        States = {
            Amount = {
                Max = 0.2,
                Base = 0.1,
                Scale = 0.01,
                Formatter = "Percentage"
            }
        }
    },
    Illuminate = {
        Description = "Every <Cooldown>m, flies to a nearby fruit and enchants it, applying Luminous mutation!",
        States = {
            Cooldown = {
                Min = 120,
                Base = 920,
                Scale = -3.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Magical Friend"] = {
        Description = "All Magical type plants grow <Multiplier>x faster",
        States = {
            Range = {
                Max = 60,
                Base = 45,
                Scale = 0
            },
            Multiplier = {
                Max = 6.5,
                Base = 2,
                Scale = 0.1
            }
        }
    },
    ["Rainbow Mushroom Madness"] = {
        Description = "All nearby plants within <Range> studs will have increased <Multiplier>x size bonus for every Fungus type plant planted in your garden! (Max 300).",
        States = {
            Range = {
                Max = 60,
                Base = 14.75,
                Scale = 0.35
            },
            Multiplier = {
                Max = 0.01,
                Base = 0.004,
                Scale = 0.001,
                Formatter = "NoPrecision"
            }
        }
    },
    ["Rainbow Bird of Rebirth"] = {
        Description = "Pets taken from the pet mutation machine have a bonus 20 - <Chance> age to their age value! (Max 80 age per pet)",
        States = {
            Chance = {
                Max = 60,
                Base = 30,
                Scale = 0.2
            }
        }
    },
    ["Rainbow Bird of Rebirth Min"] = {
        Description = "",
        States = {
            Chance = {
                Max = 20,
                Base = 20,
                Scale = 0
            }
        }
    },
    ["Rainbow Icarus"] = {
        Description = "Every <Cooldown>m, travels between <Amount> random fruit in your garden which get the Flaming mutation! Fruits passed have <Chance>% chance to mutated as well!",
        States = {
            Cooldown = {
                Min = 30,
                Base = 230,
                Scale = -1.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            },
            Amount = {
                Max = 11,
                Base = 6,
                Scale = 0.2
            }
        }
    },
    ["Tiny Bird"] = {
        Description = "Grants <Chance>% decreased player size!",
        States = {
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["Earthquake Excavator"] = {
        Description = "Every <Cooldown>m, digs around for <Duration>s, displacing the ground. Nearby fruits within <Range> studs have a <Chance>% chance every second to get Cracked mutation!",
        States = {
            Cooldown = {
                Min = 80,
                Base = 312,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            },
            Range = {
                Max = 40,
                Base = 20,
                Scale = 0.25
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["Fall Express"] = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit gets the Fall mutation!",
        States = {
            Cooldown = {
                Min = 30,
                Base = 240,
                Scale = -2,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["Mighty Bear"] = {
        Description = "Grants <Chance>% increased player size!",
        States = {
            Chance = {
                Max = 16,
                Base = 8,
                Scale = 0.1
            }
        }
    },
    ["Wise Shopper"] = {
        Description = "Pets bought directly from shops have a bonus 0.1 - <Chance> KG to their base weight! (Max 3 KG).",
        States = {
            Chance = {
                Max = 0.4,
                Base = 0.18,
                Scale = 0.02
            }
        }
    },
    ["Prince of Fall"] = {
        Description = "All active Fall type pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Max = 2,
                Base = 0.6,
                Scale = 0.06
            }
        }
    },
    ["Swan Song"] = {
        Description = "Every <Cooldown>m, goes to another player\'s pet and befriends it and performs its ability!",
        States = {
            Cooldown = {
                Min = 750,
                Base = 1500,
                Scale = -7.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Bird of Grace"] = {
        Description = "Every <Cooldown>m, graces a fruit with Graceful mutation!",
        States = {
            Cooldown = {
                Min = 120,
                Base = 360,
                Scale = -2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Giant Tiny Bird"] = {
        Description = "Grants <Chance>% decreased player size!",
        States = {
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Giant Earthquake Excavator"] = {
        Description = "Every <Cooldown>m, digs around for <Duration>s, displacing the ground. Nearby fruits within <Range> studs have a <Chance>% chance every second to get Cracked mutation!",
        States = {
            Cooldown = {
                Min = 40,
                Base = 150,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            },
            Range = {
                Max = 80,
                Base = 40,
                Scale = 0.5
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.2
            }
        }
    },
    ["Giant Fall Express"] = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit gets the Fall mutation!",
        States = {
            Cooldown = {
                Min = 30,
                Base = 140,
                Scale = -2,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 45,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Giant Mighty Bear"] = {
        Description = "Grants <Chance>% increased player size!",
        States = {
            Chance = {
                Max = 32,
                Base = 16,
                Scale = 0.2
            }
        }
    },
    ["Giant Wise Shopper"] = {
        Description = "Pets bought directly from shops have a bonus 0.1 - <Chance> KG to their base weight! (Max 3 KG).",
        States = {
            Chance = {
                Max = 0.8,
                Base = 0.36,
                Scale = 0.04
            }
        }
    },
    ["Giant Prince of Fall"] = {
        Description = "All active Fall type pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Max = 4,
                Base = 1.2,
                Scale = 0.12
            }
        }
    },
    ["Giant Swan Song"] = {
        Description = "Every <Cooldown>m, goes to another player\'s pet and befriends it and performs its ability!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 790,
                Scale = -4.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Giant Bird of Grace"] = {
        Description = "Every <Cooldown>m, graces a fruit with Graceful mutation!",
        States = {
            Cooldown = {
                Min = 65,
                Base = 150,
                Scale = -3.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Squirrel Support"] = {
        Description = "When Fall type pets finish their abilities, they start their cooldown with <Chance> seconds less!",
        States = {
            Chance = {
                Max = 30,
                Base = 14,
                Scale = 0.4
            }
        }
    },
    ["Harvest Stash"] = {
        Description = "<Chance>% Chance to not consume a use when using a Harvest Tool!",
        States = {
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.25
            }
        }
    },
    ["Whack-A-Marmot"] = {
        Description = "Every <Cooldown>m, burrows down in the ground and hides in a random mound! Finding the Marmot will grant a Fall related reward! Has a <Chance>% chance to burrow again! Cannot be mimicked,",
        States = {
            Cooldown = {
                Min = 120,
                Base = 540,
                Scale = -3.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.05
            }
        }
    },
    ["Sugar Gliding"] = {
        Description = "Every <Cooldown>m, glides from 3 different mutated fruits. Copies 1 mutation from each fruit and applies it to the next! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 720,
                Base = 1200,
                Scale = -4.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["A Space Odd-Nut-sy"] = {
        Description = "Every <Cooldown>m, has <Chance>% chance to apply the Voidtouched mutation!",
        States = {
            Cooldown = {
                Min = 540,
                Base = 1080,
                Scale = -4.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 25,
                Base = 15,
                Scale = 0.3
            }
        }
    },
    ["Salmon School"] = {
        Description = "For every other Salmon in your garden gains an aditional <Chance> XP per second!",
        States = {
            Chance = {
                Max = 8,
                Base = 4,
                Scale = 0.04
            }
        }
    },
    Woodpecking = {
        Description = "Every <Cooldown>m, goes to a Woody type plant and pecks at it for <Duration> seconds, which grants <Chance>% chance for Woody type fruit to duplicate! Rarer crops have lower chance to duplicate.",
        States = {
            Cooldown = {
                Min = 60,
                Base = 120,
                Scale = -0.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.04
            },
            Duration = {
                Base = 30,
                Scale = 0.5
            }
        }
    },
    Southbound = {
        Description = "Flies south for the winter every half hour in a day, leaving you with a random reward before returning to your inventory.",
        States = {
            Chance = {
                Max = 30,
                Base = 14.85,
                Scale = 0.15
            }
        }
    },
    ["Adorable Haggler"] = {
        Description = "Every <Cooldown>m, goes to the Gear, Seed or Pet Shop and restocks 1 random stock. Rarer items have rarer chance to stock. Ability cannot be mimicked or refreshed.",
        States = {
            Cooldown = {
                Min = 300,
                Base = 720,
                Scale = -6.7,
                Formatter = "ColonTime"
            }
        }
    },
    ["Mini Croak"] = {
        Description = "Every <Cooldown> minutes, advances the growth of a random plant by 15 minutes.",
        States = {
            Cooldown = {
                Min = 30,
                Base = 188,
                Scale = -1.8,
                Formatter = "ColonTime"
            }
        }
    },
    ["Seed Disperser"] = {
        Description = "Every <Cooldown>s, converts a random single-harvest plant into its seed equivalent. Ignores favorited plants",
        States = {
            Cooldown = {
                Min = 15,
                Base = 60,
                Scale = -0.6
            }
        }
    },
    ["Sun Basking"] = {
        Description = "Every <Cooldown>s, goes to a random fruit with Frozen mutation and melts it back to Chilled or Wet. Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 30,
                Base = 80,
                Scale = -0.8
            }
        }
    },
    ["Primate Profit"] = {
        Description = "Every <Cooldown>m, grabs a random fruit from your garden and goes to the sell stall and sells it for you. There is a <Chance>% chance the fruit does not get collected.",
        States = {
            Cooldown = {
                Min = 15,
                Base = 120,
                Scale = -1.2,
                Formatter = "ColonTime"
            },
            Chance = {
                Chance = 12,
                Base = 6,
                Scale = 0.5
            }
        }
    },
    ["Tiger Call"] = {
        Description = "Every <Cooldown>m, the Tiger roars, calls all pets in your garden to move toward it. <Amount> total XP is shared across each pet (max 800 XP per pet).",
        States = {
            Cooldown = {
                Min = 200,
                Base = 780,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 10000,
                Base = 5000,
                Scale = 50
            }
        }
    },
    ["King of the Jungle"] = {
        Description = "Every <Cooldown>m, roars and <Amount> random mutations from your garden will be replaced with another random mutation. Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 140,
                Base = 362,
                Scale = -3.6,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 6,
                Base = 3,
                Scale = 0.3
            }
        }
    },
    ["Berry Friend"] = {
        Description = "All Berry type plants grow <Multiplier>x faster",
        States = {
            Range = {
                Max = 30,
                Base = 30,
                Scale = 0
            },
            Multiplier = {
                Max = 4,
                Base = 1.5,
                Scale = 0.05
            }
        }
    },
    ["Silver Transmutation"] = {
        Description = "Every <Cooldown>m, turns one random fruit Silver!",
        States = {
            Cooldown = {
                Min = 90,
                Base = 484,
                Scale = -4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Lightning Bug"] = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Shocked!",
        States = {
            Cooldown = {
                Min = 110,
                Base = 545,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 20,
                Base = 10.25,
                Scale = 0.1
            }
        }
    },
    ["Water Diety"] = {
        Description = "When selling fruits with Azure mutation: There is a <Chance>% chance a random mutation from that fruit will be applied to a fruit in your garden!",
        States = {
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.1
            }
        }
    },
    ["Azure Surge"] = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Azure!",
        States = {
            Cooldown = {
                Min = 110,
                Base = 545,
                Scale = -3.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.12
            }
        }
    },
    ["Rainbow Berry Friend"] = {
        Description = "All Berry type plants grow <Multiplier>x faster",
        States = {
            Range = {
                Max = 45,
                Base = 45,
                Scale = 0
            },
            Multiplier = {
                Max = 6,
                Base = 2.5,
                Scale = 0.08
            }
        }
    },
    ["GIANT Silver Transmutation"] = {
        Description = "Every <Cooldown>m, turns one random fruit Silver!",
        States = {
            Cooldown = {
                Min = 45,
                Base = 244,
                Scale = -2,
                Formatter = "ColonTime"
            }
        }
    },
    ["GIANT Lightning Bug"] = {
        Description = "Every <Cooldown>s, <Chance>% chance a nearby fruit becomes Shocked!",
        States = {
            Cooldown = {
                Min = 75,
                Base = 225,
                Scale = -2
            },
            Chance = {
                Max = 40,
                Base = 20.25,
                Scale = 0.1
            }
        }
    },
    ["Rainbow Water Diety"] = {
        Description = "When selling fruits with Azure mutation: There is a <Chance>% chance a random mutation from that fruit will be applied to a fruit in your garden!",
        States = {
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.12
            }
        }
    },
    ["Rainbow Azure Surge"] = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Azure!",
        States = {
            Cooldown = {
                Min = 75,
                Base = 225,
                Scale = -2.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 48,
                Base = 24,
                Scale = 0.24
            }
        },
        ""
    },
    ["Chubby Chipmunk"] = {
        Description = "Every <font color=\'#FFD700\'><Cooldown></font>m, eats a fruit in your garden and gains <font color=\'#FFD700\'><Amount></font> KG weight! <font color=\'#AAAAAA\'>(Ignores favorited or single-harvest fruits)</font>\n\nAfter eating, an <font color=\'#FFD700\'>Acorn</font> will spawn somewhere!. Collecting it grants a random reward!",
        States = {
            Cooldown = {
                Min = 35,
                Base = 120,
                Scale = -1.5,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 0.06,
                Base = 0.009,
                Scale = 0.001,
                Formatter = "NoPrecision"
            }
        }
    },
    Chunkmunk = {
        Description = "When fed, has a <font color=\'#FFD700\'><Chance></font>% chance to gain <font color=\'#FFD700\'><Amount></font> KG weight! Each mutation on the fed fruit grants an additional <font color=\'#FFD700\'><MutationChance></font>% chance to gain <font color=\'#FFD700\'><MutationAmount></font> KG!",
        States = {
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.1
            },
            Amount = {
                Max = 0.05,
                Base = 0.009,
                Scale = 0.001,
                Formatter = "NoPrecision"
            },
            MutationChance = {
                Max = 8,
                Base = 3,
                Scale = 0.3
            },
            MutationAmount = {
                Max = 0.03,
                Base = 0.009,
                Scale = 0.001,
                Formatter = "NoPrecision"
            }
        }
    },
    Nuturalist = {
        Description = "All Nut type plants grow <Multiplier>x faster",
        States = {
            Range = {
                Max = 30,
                Base = 30,
                Scale = 0
            },
            Multiplier = {
                Max = 4,
                Base = 1.5,
                Scale = 0.05
            }
        }
    },
    ["Chip-Hop"] = {
        Description = "Every <Cooldown>m, performs a song for <Duration>s and all other pets in your garden restore <Amount>% hunger per second!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 720,
                Scale = -3.5,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 25,
                Base = 8,
                Scale = 0.4
            },
            Amount = {
                Max = 0.03,
                Base = 0.01,
                Scale = 0.004,
                Formatter = "Percentage"
            }
        }
    },
    ["Dust Bath"] = {
        Description = "Every <Cooldown>m, goes to another pet, rolls around in dust and makes that pet perform its ability <Amount> times in a row!",
        States = {
            Cooldown = {
                Min = 1000,
                Base = 2400,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 6,
                Base = 3,
                Scale = 0.02
            }
        }
    },
    ["Rainbow Nuturalist"] = {
        Description = "All Nut type plants grow <Multiplier>x faster",
        States = {
            Range = {
                Max = 45,
                Base = 45,
                Scale = 0
            },
            Multiplier = {
                Max = 6,
                Base = 2.5,
                Scale = 0.05
            }
        }
    },
    ["Rainbow Chip-Hop"] = {
        Description = "Every <Cooldown>m, performs a song for <Duration>s and all other pets in your garden restore <Amount>% hunger per second!",
        States = {
            Cooldown = {
                Min = 100,
                Base = 520,
                Scale = -3.5,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 32,
                Base = 16,
                Scale = 0.6
            },
            Amount = {
                Max = 0.04,
                Base = 0.02,
                Scale = 0.008,
                Formatter = "Percentage"
            }
        }
    },
    ["Rainbow Dust Bath"] = {
        Description = "Every <Cooldown>m, goes to another pet, rolls around in dust and makes that pet perform its ability <Amount> times in a row!",
        States = {
            Cooldown = {
                Min = 1000,
                Base = 1820,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 8,
                Base = 4,
                Scale = 0.04
            }
        }
    },
    ["Hyrax Harvest"] = {
        Description = "Every <Cooldown>m, consumes a random fruit in your garden and converts it into a Fissure Berry seed! Ignores favorited fruit!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 300,
                Scale = -3,
                Formatter = "ColonTime"
            }
        }
    },
    ["CHA-CHING"] = {
        Description = "Every <Cooldown>m, has <Chance>% chance to apply the Jackpot mutation!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 420,
                Scale = -2.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 34,
                Base = 17,
                Scale = 0.17
            }
        }
    },
    ["Spooky Bat"] = {
        Description = "Grants Spooky plants in <Range> studs a <Multiplier>x variant chance bonus!",
        States = {
            Multiplier = {
                Max = 1.5,
                Base = 0.6,
                Scale = 0.05
            },
            Range = {
                Max = 60,
                Base = 32,
                Scale = 0.25
            }
        }
    },
    Gravedigger = {
        Description = "Every <Cooldown>s, <Chance>% chance to dig up a random seed! Can dig up a seed exclusive to the Bone Dog!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 80,
                Scale = -1
            },
            Chance = {
                Base = 15,
                Scale = 0.05
            }
        }
    },
    ["Web Weave"] = {
        Description = "Every <Cooldown>m, weaves a <Range> stud web that lasts for <Duration>s. Pets on the web advance cooldown an extra <AmountPet>s every second & plants grow an additional <AmountPlant>s every second!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 488,
                Scale = -4.8,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 36,
                Base = 18,
                Scale = 0.18
            },
            Duration = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            },
            AmountPet = {
                Max = 1.5,
                Base = 1,
                Scale = 0.01
            },
            AmountPlant = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            }
        }
    },
    ["Witch\'s Nap"] = {
        Description = "Every <Cooldown>m, goes to a Witch\'s Cauldron cosmetic and naps near it for <Duration>s. New fruit within <Range> studs will be <Multiplier>x larger",
        States = {
            Cooldown = {
                Min = 120,
                Base = 244,
                Scale = -2,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            },
            Duration = {
                Max = 28,
                Base = 14.5,
                Scale = 0.15
            },
            Multiplier = {
                Max = 2,
                Base = 1,
                Scale = 0.1
            }
        }
    },
    ["The Reins of Ruin"] = {
        Description = "Every <font color=\'#FFD700\'><Cooldown></font>m, haunts a random level <font color=\'#FFD700\'><Level></font> pet without a mutation, resetting it to <font color=\'#FF5555\'>level 1</font> and bestowing one of four chaotic mutations:\n\n<font color=\'#8C2DAF\'>Dreadbound</font>, <font color=\'#FF5528\'>Soulflame</font>, or <font color=\'#5AC8FF\'>Spectral</font> — with a rare <font color=\'#FF0064\'><Chance>%</font> chance for <font color=\'#FF0064\'>Nightmare</font>!",
        States = {
            Cooldown = {
                Min = 1000,
                Base = 2444,
                Scale = -24,
                Formatter = "ColonTime"
            },
            Level = {
                Min = 30,
                Base = 50.5,
                Scale = -0.5
            },
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.1
            }
        }
    },
    ["Ghostly Spooky Bat"] = {
        Description = "Grants Spooky plants in <Range> studs a <Multiplier>x variant chance bonus!",
        States = {
            Multiplier = {
                Max = 3.4,
                Base = 1.2,
                Scale = 0.05
            },
            Range = {
                Max = 100,
                Base = 50,
                Scale = 0.25
            }
        }
    },
    ["Ghostly Gravedigger"] = {
        Description = "Every <Cooldown>s, <Chance>% chance to dig up a random seed!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 40,
                Scale = -1
            },
            Chance = {
                Base = 30,
                Scale = 0.05
            }
        }
    },
    ["Ghostly Web Weave"] = {
        Description = "Every <Cooldown>m, weaves a <Range> stud web that lasts for <Duration>s. Pets on the web advance cooldown an extra <AmountPet>s every second & plants grow an additional <AmountPlant>s every second!",
        States = {
            Cooldown = {
                Min = 100,
                Base = 244,
                Scale = -2.8,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 40,
                Base = 40,
                Scale = 0.18
            },
            Duration = {
                Max = 40,
                Base = 20,
                Scale = 0.1
            },
            AmountPet = {
                Max = 2.5,
                Base = 2,
                Scale = 0.01
            },
            AmountPlant = {
                Max = 60,
                Base = 30,
                Scale = 0.15
            }
        }
    },
    ["Ghostly Witch\'s Nap"] = {
        Description = "Every <Cooldown>m, goes to a Witch\'s Cauldron cosmetic and naps near it for <Duration>s. New fruit within <Range> studs will be <Multiplier>x larger",
        States = {
            Cooldown = {
                Min = 70,
                Base = 111,
                Scale = -2,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 40,
                Base = 20,
                Scale = 0.1
            },
            Duration = {
                Max = 60,
                Base = 29.5,
                Scale = 0.15
            },
            Multiplier = {
                Max = 3.5,
                Base = 2,
                Scale = 0.1
            }
        }
    },
    ["The Ghostly Reins of Ruin"] = {
        Description = "Every <font color=\'#FFD700\'><Cooldown></font>m, haunts a random level <font color=\'#FFD700\'><Level></font> pet without a mutation, resetting it to <font color=\'#FF5555\'>level 1</font> and bestowing one of four chaotic mutations:\n\n<font color=\'#8C2DAF\'>Dreadbound</font>, <font color=\'#FF5528\'>Soulflame</font>, or <font color=\'#5AC8FF\'>Spectral</font> — with a rare <font color=\'#FF0064\'><Chance>%</font> chance for <font color=\'#FF0064\'>Nightmare</font>!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1222,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Level = {
                Min = 20,
                Base = 30.5,
                Scale = -0.5
            },
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.2
            }
        }
    },
    ["Pumpkin Carver"] = {
        Description = "Every <Cooldown>m, converts a pumpkin into a random Jack-O-Lantern cosmetic! Collect all 5 variants!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 422,
                Scale = -4.2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Boo!"] = {
        Description = "BOO! Every <Cooldown>m, goes to a nearby fruit and scares it! Applies the Spooky mutation!",
        States = {
            Cooldown = {
                Min = 120,
                Base = 1111,
                Scale = -8,
                Formatter = "ColonTime"
            }
        }
    },
    ["Wolf Howl"] = {
        Description = "Every <Cooldown>m, howls: Fruits in <Range> studs have a <Chance>% get Moonlit mutation and turns you into a Werewolf for <Duration>s! Granting bonus <MovementSpeed>% movement speed & <JumpHeight>% jump height!",
        States = {
            Cooldown = {
                Min = 120,
                Base = 244,
                Scale = -2,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            },
            Duration = {
                Max = 70,
                Base = 35,
                Scale = 0.3
            },
            MovementSpeed = {
                Max = 80,
                Base = 40.4,
                Scale = 0.4
            },
            JumpHeight = {
                Max = 160,
                Base = 80.4,
                Scale = 0.8
            }
        }
    },
    ["Reap What You Sow"] = {
        Description = "Every <Cooldown>m, sacrifices 4 fruit in your garden to apply a medium Passive boost or medium XP Boost to a random pet in your garden!",
        States = {
            Cooldown = {
                Min = 720,
                Base = 1320,
                Scale = -6.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Spooky Crow"] = {
        Description = "Spooky type plants within <Range> studs have <Multiplier>x increased growth speed!",
        States = {
            Multiplier = {
                Max = 3,
                Base = 1.4,
                Scale = 0.1
            },
            Range = {
                Max = 60,
                Base = 32,
                Scale = 0.25
            }
        }
    },
    Ram = {
        Description = "Every <Cooldown>m, goes to a random player and rams them, knocking and launching them away!",
        States = {
            Cooldown = {
                Min = 261,
                Base = 522,
                Scale = -3.2,
                Formatter = "ColonTime"
            }
        }
    },
    Looter = {
        Description = "Every <Cooldown>m, goes to another random player and carries them and brings them to you! Player can jump to be released!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 612,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Dark Overgrowth"] = {
        Description = "Every <Cooldown>m, spreads its roots and nearest <MaxAmount> fruit within <Range> studs have a <Chance>% chance to get the Blight mutation! ",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1330,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            },
            Range = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            },
            MaxAmount = {
                Max = 260,
                Base = 130,
                Scale = 0.1
            }
        }
    },
    ["Hex Magic"] = {
        Description = "You must plant 5 single-harvest plants in a Hex Circle cosmetic and every <Cooldown>m: The Hex Serpent will perform a ritual, consuming the plants, granting random rewards! The rarer plants and better variants grants better effects!",
        States = {
            Cooldown = {
                Min = 240,
                Base = 720,
                Scale = -3.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Ghostly Overgrowth"] = {
        Description = "Every <Cooldown>m, spreads its roots and nearest <MaxAmount> fruit within <Range> studs have a <Chance>% chance to get the Blight!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 665,
                Scale = -3.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            },
            Range = {
                Max = 90,
                Base = 45,
                Scale = 0.45
            },
            MaxAmount = {
                Max = 520,
                Base = 260,
                Scale = 0.2
            }
        }
    },
    ["Spooky Scarab"] = {
        Description = "Spooky type plants within <Range> studs have <Multiplier>x increased growth size!",
        States = {
            Range = {
                Max = 60,
                Base = 32,
                Scale = 0.25
            },
            Multiplier = {
                Max = 0.64,
                Base = 0.32,
                Scale = 0.05
            }
        }
    },
    ["Tomb Raid"] = {
        Description = "Every <Cooldown>m, digs down and hides in a random Tombstone. Going to the tombstone awards a random Graveyard cosmetic!",
        States = {
            Cooldown = {
                Min = 110,
                Base = 320,
                Scale = -3,
                Formatter = "ColonTime"
            }
        }
    },
    ["King\'s Sarcophagus"] = {
        Description = "As long as you have a Sarcophagus cosmetic in your garden: Pets you get from chest have a bonus 0.1 - <Amount> KG to their base weight! (Max 3.5 KG).",
        States = {
            Amount = {
                Max = 0.5,
                Base = 0.28,
                Scale = 0.02
            }
        }
    },
    ["Treasures of the King"] = {
        Description = "Every <Cooldown>m goes to a Sarcophagus cosmetic in your garden and applies Gold to the nearest plant in <Range> studs for <Duration>s! Target plant cant exceed <MaxDuration>s of being gold.",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1333,
                Scale = -7,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 70,
                Base = 35,
                Scale = 0.25
            },
            Duration = {
                Max = 60,
                Base = 29,
                Scale = 1
            },
            MaxDuration = {
                Min = 300,
                Max = 300,
                Base = 300,
                Scale = 0
            }
        }
    },
    ["Ghostly Spooky Scarab"] = {
        Description = "Spooky type plants within <Range> studs have <Multiplier>x increased growth size!",
        States = {
            Range = {
                Max = 90,
                Base = 45,
                Scale = 0.25
            },
            Multiplier = {
                Max = 1,
                Base = 0.52,
                Scale = 0.05
            }
        }
    },
    ["Ghostly Tomb Raid"] = {
        Description = "Every <Cooldown>m, digs down and hides in a random Tombstone. Going to the tombstone awards a random Graveyard cosmetic!",
        States = {
            Cooldown = {
                Min = 80,
                Base = 160,
                Scale = -2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Ghostly King\'s Sarcophagus"] = {
        Description = "As long as you have a Sarcophagus cosmetic in your garden: Pets you get from chest have a bonus 0.1 - <Amount> KG to their base weight! (Max 3.5 KG).",
        States = {
            Amount = {
                Max = 0.6,
                Base = 0.38,
                Scale = 0.04
            }
        }
    },
    ["Ghostly Treasures of the King"] = {
        Description = "Every <Cooldown>m goes to a Sarcophagus cosmetic in your garden and applies Gold to the nearest plant in <Range> studs for <Duration>s! Target plant cant exceed <MaxDuration>s of being gold.",
        States = {
            Cooldown = {
                Min = 333,
                Base = 666,
                Scale = -3.5,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 90,
                Base = 45,
                Scale = 0.25
            },
            Duration = {
                Max = 88,
                Base = 44,
                Scale = 2
            },
            MaxDuration = {
                Min = 300,
                Max = 300,
                Base = 300,
                Scale = 0
            }
        }
    },
    ["Spooky Lich"] = {
        Description = "Spooky type plants within <Range> studs have increased <VariantMultiplier>x variant chance, <GrowthMultiplier>x growth speed and <SizeMultiplier>x size bonus!",
        States = {
            VariantMultiplier = {
                Max = 1.5,
                Base = 0.6,
                Scale = 0.05
            },
            GrowthMultiplier = {
                Max = 3,
                Base = 1.4,
                Scale = 0.1
            },
            SizeMultiplier = {
                Max = 1,
                Base = 0.42,
                Scale = 0.05
            },
            Range = {
                Max = 60,
                Base = 32,
                Scale = 0.25
            }
        }
    },
    ["Dread Lord"] = {
        Description = "All active Halloween type pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Max = 4,
                Base = 1.4,
                Scale = 0.05
            }
        }
    },
    ["Lich Blessing"] = {
        Description = "",
        States = {
            Multiplier = {
                Max = 1.5,
                Base = 0.6,
                Scale = 0.05
            },
            Range = {
                Max = 60,
                Base = 32,
                Scale = 0.25
            }
        }
    },
    ["Lich Tempo"] = {
        Description = "",
        States = {
            Multiplier = {
                Max = 3,
                Base = 1.4,
                Scale = 0.1
            },
            Range = {
                Max = 60,
                Base = 32,
                Scale = 0.25
            }
        }
    },
    ["Lich Power"] = {
        Description = "",
        States = {
            Multiplier = {
                Max = 1,
                Base = 0.42,
                Scale = 0.05
            },
            Range = {
                Base = 30,
                Scale = 0.25
            }
        }
    },
    Haunt = {
        Description = "Every <Cooldown>m, haunts a random fruit and has <Chance>% chance to mutate it with Vamp, or rare chance for Spooky or even rarer chance for Ghostly instead!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 812,
                Scale = -4.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 50,
                Base = 24.75,
                Scale = 0.25
            }
        }
    },
    ["Vampire Doggy"] = {
        Description = "Every <Cooldown>m, goes to nearby fruit and dances, applying Leeched mutation!",
        States = {
            Cooldown = {
                Min = 140,
                Base = 600,
                Scale = -6.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Gloss Animal"] = {
        Description = "Every <Cooldown>s, polishes a nearby fruit and it has a <Chance>% chance to become Glossy!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 264,
                Scale = -4
            },
            Chance = {
                Base = 15,
                Scale = 0.15
            }
        }
    },
    ["Armadillo Roll"] = {
        Description = "Every <Cooldown>m, rolls into a ball and transforms you into a armadillo ball for <Duration>s!",
        States = {
            Cooldown = {
                Min = 240,
                Base = 480,
                Scale = -4,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            }
        }
    },
    ["Beetle Duel"] = {
        Description = "Every <Cooldown>m, initiates a battle with another player\'s Beetle. If your beetle wins you get a reward! The higher level and heavier the beetle the more likely it is to win!",
        States = {
            Cooldown = {
                Min = 80,
                Base = 360,
                Scale = -2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Shrimpunch!!!"] = {
        Description = "Every <Cooldown>m, punches different things in your garden for different effects!",
        States = {
            Cooldown = {
                Min = 333,
                Base = 888,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Three-Headed"] = {
        Description = "Every <Cooldown>m, ages itself up by 1, hatches an egg and applies Terran mutation. Cannot be mimicked or refreshed!",
        States = {
            Cooldown = {
                Min = 1250,
                Base = 2500,
                Scale = -10,
                Formatter = "ColonTime"
            }
        }
    },
    ["Earth Diety"] = {
        Description = "When selling fruits with Terran mutation: There is a <Chance>% chance a random mutation from that fruit will be applied to a fruit in your garden!",
        States = {
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.1
            }
        }
    },
    ["Safari Support"] = {
        Description = "When Safari type pets finish their abilities, they start their cooldown with <Chance> seconds less!",
        States = {
            Chance = {
                Max = 30,
                Base = 14,
                Scale = 0.4
            }
        }
    },
    ["Zebra Stampede"] = {
        Description = "Every 30m on the clock, All Zebras stampede back and forth from the Seed Shop to Gear Shop or vice-versa, and grants you a random reward! Has <Chance>% chance to trigger again on each stampede!",
        States = {
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["Great Grazer"] = {
        Description = "Every <Cooldown>m, eats fruit that are at least 10 studs high for <Multiplier>x sell value. The plant the fruit came from advances growth by <Amount>m! Also applies Arid mutation to all other fruits on that plant.",
        States = {
            Cooldown = {
                Min = 333,
                Base = 888,
                Scale = -4.4,
                Formatter = "ColonTime"
            },
            Multiplier = {
                Max = 3,
                Base = 1.45,
                Scale = 0.05
            },
            Amount = {
                Max = 7200,
                Base = 3990,
                Scale = 30,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rhino Ram"] = {
        Description = "Every <Cooldown>m, charges into a random egg or random fruit in your garden: Rammed eggs have hatch time halved, rammed fruits get Mirage mutation! Cannot be mimicked or refreshed.",
        States = {
            Cooldown = {
                Min = 444,
                Base = 888,
                Scale = -8,
                Formatter = "ColonTime"
            }
        }
    },
    ["Jumbo Blessing"] = {
        Description = "Every <Cooldown>m, blesses an age <Age> pet, resetting its age back to 1, increasing its base weight by 0.1 KG if its base weight is less than <Max> KG! Cannot bless other Elephants. Cannot be mimicked or refreshed.",
        States = {
            Cooldown = {
                Min = 400,
                Base = 1388,
                Scale = -13,
                Formatter = "ColonTime"
            },
            Age = {
                Min = 50,
                Base = 50.25,
                Scale = -0.25
            },
            Max = {
                Max = 3.5,
                Base = 2,
                Scale = 0.05
            }
        }
    },
    ["GIANT Armadillo Roll"] = {
        Description = "Every <Cooldown>m, rolls into a ball and transforms you into a armadillo ball for <Duration>s!",
        States = {
            Cooldown = {
                Min = 120,
                Base = 240,
                Scale = -4,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 90,
                Base = 45,
                Scale = 0.45
            }
        }
    },
    ["Rainbow Beetle Duel"] = {
        Description = "Every <Cooldown>m, initiates a battle with another player\'s Beetle. If your beetle wins you get a reward! The higher level and heavier the beetle the more likely it is to win!",
        States = {
            Cooldown = {
                Min = 40,
                Base = 260,
                Scale = -2,
                Formatter = "ColonTime"
            }
        }
    },
    ["GIANT Shrimpunch!!!"] = {
        Description = "Every <Cooldown>m, punches different things in your garden for different effects!",
        States = {
            Cooldown = {
                Min = 222,
                Base = 444,
                Scale = -4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Three-Headed"] = {
        Description = "Every <Cooldown>m, ages itself up by 1, hatches an egg and applies Terran mutation. Cannot be mimicked or refreshed!",
        States = {
            Cooldown = {
                Min = 800,
                Base = 1500,
                Scale = -10,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Earth Diety"] = {
        Description = "When selling fruits with Terran mutation: There is a <Chance>% chance a random mutation from that fruit will be applied to a fruit in your garden!",
        States = {
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.2
            }
        }
    },
    ["Rainbow Safari Support"] = {
        Description = "When Safari type pets finish their abilities, they start their cooldown with <Chance> seconds less!",
        States = {
            Chance = {
                Max = 50,
                Base = 24,
                Scale = 0.5
            }
        }
    },
    ["Rainbow Zebra Stampede"] = {
        Description = "Every 30m on the clock, All Zebras stampede back and forth from the Seed Shop to Gear Shop or vice-versa, and grants you a random reward! Has <Chance>% chance to trigger again on each stampede!",
        States = {
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Rainbow Great Grazer"] = {
        Description = "Every <Cooldown>m, eats fruit that are at least 10 studs high for <Multiplier>x sell value. The plant the fruit came from advances growth by <Amount>m! Also applies Arid mutation to all other fruits on that plant.",
        States = {
            Cooldown = {
                Min = 222,
                Base = 444,
                Scale = -2.2,
                Formatter = "ColonTime"
            },
            Multiplier = {
                Max = 4,
                Base = 2,
                Scale = 0.1
            },
            Amount = {
                Max = 9200,
                Base = 4990,
                Scale = 40,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Rhino Ram"] = {
        Description = "Every <Cooldown>m, charges into a random egg or random fruit in your garden: Rammed eggs have hatch time halved, rammed fruits get Mirage mutation! Cannot be mimicked or refreshed.",
        States = {
            Cooldown = {
                Min = 333,
                Base = 666,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Jumbo Blessing"] = {
        Description = "Every <Cooldown>m, blesses an age <Age> pet, resetting its age back to 1, increasing its base weight by 0.1 KG if its base weight is less than <Max> KG! Cannot bless other Elephants. Cannot be mimicked or refreshed.",
        States = {
            Cooldown = {
                Min = 450,
                Base = 900,
                Scale = -9,
                Formatter = "ColonTime"
            },
            Age = {
                Min = 40,
                Base = 40.25,
                Scale = -0.25
            },
            Max = {
                Max = 5.5,
                Base = 3,
                Scale = 0.05
            }
        }
    },
    ["Gecko Gold"] = {
        Description = "Safari type plants within <Range> studs have <Multiplier>x increased variant chance!",
        States = {
            Multiplier = {
                Max = 1.4,
                Base = 0.6,
                Scale = 0.05
            },
            Range = {
                Max = 60,
                Base = 29,
                Scale = 0.25
            }
        }
    },
    ["Pack Hunting"] = {
        Description = "Gains an additional <Amount> XP/s for every Hyena in your garden! Requires another non-Hyena pet equipped to activate this effect.",
        States = {
            Amount = {
                Max = 8,
                Base = 4,
                Scale = 0.04
            }
        }
    },
    ["Safari Renewal"] = {
        Description = "<Chance>% chance harvested fruit duplicates! Rarer crops have lower chance to duplicate.",
        States = {
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.15
            }
        }
    },
    ["Safari Harvester"] = {
        Description = "<Chance>% extra chance for Safari type fruit to duplicate!",
        States = {
            Chance = {
                Max = 15,
                Base = 5,
                Scale = 0.1
            }
        }
    },
    ["Watermelon Chomper"] = {
        Description = "Every <Cooldown>m, eats a Watermelon for <Multiplier>x value bonus and has a <Chance>% chance to recover the Watermelon seed!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 200,
                Scale = -1,
                Formatter = "ColonTime"
            },
            Multiplier = {
                Max = 8,
                Base = 2,
                Scale = 0.02
            },
            Chance = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            }
        }
    },
    ["Monsoon Beast"] = {
        Description = "Every <Cooldown>m, goes to a nearby fruit and applies Monsoon mutation!",
        States = {
            Cooldown = {
                Min = 222,
                Base = 1111,
                Scale = -11,
                Formatter = "ColonTime"
            }
        }
    },
    ["Croc Roll"] = {
        Description = "Every <Cooldown>m, bites on to a random Plant or Pet for <Duration>s and performs a roll. Plants grow an additional <AmountPlant>s/s and Pets get additional <AmountXP> XP/s",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1200,
                Scale = -6.6,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 50,
                Base = 30,
                Scale = 0.1
            },
            AmountPlant = {
                Max = 90,
                Base = 45,
                Scale = 0.1
            },
            AmountXP = {
                Max = 65,
                Base = 35,
                Scale = 0.1
            }
        }
    },
    ["Lion Call"] = {
        Description = "Every <Cooldown>m, roars, calls pets in your garden to move toward it. <Amount> total cooldown advancement is shared across each pet (max <MaxAmount>s per pet).",
        States = {
            Cooldown = {
                Min = 200,
                Base = 800,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 800,
                Base = 400,
                Scale = 4
            },
            MaxAmount = {
                Max = 120,
                Base = 60,
                Scale = 0.6
            }
        }
    },
    ["King of the Safari"] = {
        Description = "Every <Cooldown>m, roars and mutates fruit up to the number of Safari type pets you have in your garden with a random Safari Mutation!",
        States = {
            Cooldown = {
                Min = 400,
                Base = 1400,
                Scale = -14,
                Formatter = "ColonTime"
            }
        }
    },
    ["Shard and Steady"] = {
        Description = "When triggering a Lucky Harvest: <Chance>% you get a Cleansing Pet Shard! (Max 50%)",
        States = {
            Chance = {
                Max = 14,
                Base = 7,
                Scale = 0.07
            }
        }
    },
    ["Gem Carver"] = {
        Description = "Every <Cooldown>m, goes to a random fruit and converts it into a random Gem-themed cosmetic!",
        States = {
            Cooldown = {
                Min = 80,
                Base = 422,
                Scale = -4.2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Crystalized Bird"] = {
        Description = "Every <Cooldown>m, <Chance>% chance to mutate a nearby fruit, applying the Crystalized mutation!",
        States = {
            Cooldown = {
                Min = 14,
                Base = 486,
                Scale = -4,
                Formatter = "ColonTime"
            },
            Chance = {
                Base = 15,
                Scale = 0.5
            }
        }
    },
    ["12 Carats"] = {
        Description = "When harvesting a fruit with 12 or more mutations: <Chance>% chance for random pet to age up by 1! (Max 30%)",
        States = {
            Chance = {
                Max = 6,
                Base = 3,
                Scale = 0.1
            }
        }
    },
    ["Ruby Ink"] = {
        Description = "Continously copies a random pet\'s passive (non-cooldown based).",
        States = {}
    },
    ["Level Eater"] = {
        Description = "Every <Cooldown>m, eats from and reduces a random pet\'s level by 1",
        States = {
            Cooldown = {
                Min = 300,
                Base = 700,
                Scale = -4.8,
                Formatter = "ColonTime"
            }
        }
    },
    ["Geode Sprinkler"] = {
        Description = "Every <Cooldown>m, converts an Advanced Sprinkler into a Geode Sprinkler which applies Geode mutation!",
        States = {
            Cooldown = {
                Min = 30,
                Base = 352,
                Scale = -3.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Web Supply"] = {
        Description = "Every <Cooldown>s, eats a random fruit in your garden and all fruits within a <Range> stud range has a <Chance>% chance to mutate with the Webbed Mutation!",
        States = {
            Cooldown = {
                Min = 150,
                Base = 300,
                Scale = -3
            },
            Chance = {
                Max = 16,
                Base = 8,
                Scale = 0.1
            },
            Range = {
                Max = 50,
                Base = 25,
                Scale = 0.25
            }
        }
    },
    Miner = {
        Description = "Every 5 minutes on the clock has a <Chance>% chance to grant a dig!",
        States = {
            Chance = {
                Max = 5,
                Base = 2,
                Scale = 0.05
            }
        }
    },
    ["Smithing Digging"] = {
        Description = "Every <Cooldown>m, <Chance>% chance to dig up coal!",
        States = {
            Cooldown = {
                Min = 150,
                Base = 303,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.05
            }
        }
    },
    ["Master of Faster"] = {
        Description = "Every <Cooldown>m, turns you into a cheetah for <Duration>s. Harvested fruit during this time have a <Chance>% chance to get the Wildfast mutation!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 480,
                Scale = -4,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            }
        }
    },
    ["Silver Hoarder"] = {
        Description = "All nearby plants within <Range> studs will gain additional <Multiplier> SEC/s growth speed for every Silver Ingot Cosmetic in your garden!",
        States = {
            Range = {
                Max = 40,
                Base = 20,
                Scale = 0.1
            },
            Multiplier = {
                Max = 0.1,
                Base = 0.05,
                Scale = 0.01,
                Formatter = "NoPrecision"
            }
        }
    },
    ["Gold Hoarder"] = {
        Description = "All nearby pets within <Range> studs will gain additional <Multiplier> XP/s for every Gold Ingot Cosmetic in your garden!",
        States = {
            Range = {
                Max = 60,
                Base = 30,
                Scale = 0.15
            },
            Multiplier = {
                Max = 0.2,
                Base = 0.1,
                Scale = 0.01,
                Formatter = "NoPrecision"
            }
        }
    },
    ["Water Reserve"] = {
        Description = "When using watering cans, there is a <Chance>% chance it is not consumed!",
        States = {
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.45
            }
        }
    },
    ["Shiny Eye"] = {
        Description = "When selling silver fruit, it has a <Chance>% chance to grant a random reward! (Max 30%)",
        States = {
            Chance = {
                Max = 14,
                Base = 7,
                Scale = 0.07
            }
        }
    },
    ["Egg Stash"] = {
        Description = "Every <Cooldown>m, consumes all fruit on a plant (at least 3) that is Divine rarity and above: Grants a random egg from the egg shop! Ignores plants with favorited fruit.",
        States = {
            Cooldown = {
                Min = 1400,
                Base = 2405,
                Scale = -12,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Water Reserve"] = {
        Description = "When using watering cans, there is a <Chance>% chance it is not consumed!",
        States = {
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.45
            }
        }
    },
    ["Rainbow Shiny Eye"] = {
        Description = "When selling silver fruit, it has a <Chance>% chance to grant a random reward! (Max 30%)",
        States = {
            Chance = {
                Max = 21,
                Base = 14,
                Scale = 0.07
            }
        }
    },
    ["Rainbow Egg Stash"] = {
        Description = "Every <Cooldown>m, consumes all fruit on a plant (at least 3) that is Divine rarity and above: Grants a random egg from the egg shop! Ignores plants with favorited fruit.",
        States = {
            Cooldown = {
                Min = 1000,
                Base = 2000,
                Scale = -10,
                Formatter = "ColonTime"
            }
        }
    },
    ["Supply Line"] = {
        Description = "Crafted pets have a bonus 0.1 - <Chance> KG to their base weight! (Max 3 KG).",
        States = {
            Chance = {
                Max = 0.4,
                Base = 0.18,
                Scale = 0.02
            }
        }
    },
    ["Chimera Call"] = {
        Description = "Every <Cooldown>m, roars and <Amount> total cooldown advancement is shared across each pet (max <MaxAmount>s per pet).",
        States = {
            Cooldown = {
                Min = 200,
                Base = 800,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 1600,
                Base = 800,
                Scale = 8
            },
            MaxAmount = {
                Max = 160,
                Base = 80,
                Scale = 0.8
            }
        }
    },
    ["Chimera Ram"] = {
        Description = "Every <Cooldown>m, rams a random player, knocking them away but gives them a Common Egg!",
        States = {
            Cooldown = {
                Min = 211,
                Base = 522,
                Scale = -5.2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Chimera Commerce"] = {
        Description = "Buying from the seed/gear shop has a <Chance>% chance to duplicate the bought item! (Max 50%)",
        States = {
            Chance = {
                Max = 8,
                Base = 2,
                Scale = 0.45
            }
        }
    },
    Shecklenator = {
        Description = "Grants <Amount> Sheckles per second!",
        States = {
            Amount = {
                Max = 2,
                Base = 1,
                Scale = 0.1
            }
        }
    },
    ["Coinfruit Lover"] = {
        Description = "Every <Cooldown>m, goes to a Coinfruit plant and sacrifices itself to mutates all fruits on the Coinfruit with Coin mutation! (This deletes the Sheckling). Cannot be mimicked.",
        States = {
            Cooldown = {
                Min = 120,
                Base = 360,
                Scale = -3.6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Mutation Messenger"] = {
        Description = "Every <Cooldown>m, grabs a random mutation from a random fruit in your garden and delivers it to another player\'s fruit! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 120,
                Base = 244.4,
                Scale = -4.4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Camel Caravan"] = {
        Description = "Every <Cooldown>m, gathers <Amount> Prickly type fruit, forms a caravan with all other camels to travel around the map. Drops one package per fruit along its path. Collect packages for random rewards! Rarer fruit/better variant/more camels gives better rewards.",
        States = {
            Cooldown = {
                Min = 300,
                Base = 606,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 10,
                Base = 5,
                Scale = 0.15
            }
        }
    },
    ["Snow-munition"] = {
        Description = "Every <Cooldown>m, grants <MinAmount> - <MaxAmount> Snowballs!",
        States = {
            Cooldown = {
                Min = 30,
                Base = 180,
                Scale = -1.8,
                Formatter = "ColonTime"
            },
            MinAmount = {
                Max = 6,
                Base = 3,
                Scale = 0.25
            },
            MaxAmount = {
                Max = 12,
                Base = 6,
                Scale = 0.25
            }
        }
    },
    ["Icy Fortifications"] = {
        Description = "Every <Cooldown>m, consumes Fruits with any Cold type mutations and grants a Snow-Fort based cosmetic reward! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 120,
                Base = 240,
                Scale = -2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Arctic Scoundrel"] = {
        Description = "Every <Cooldown>m, steals 24 random unique fruit from your garden and restocks the seed shop! Ignores favorited fruit. Cannot be mimicked or refreshed.",
        States = {
            Cooldown = {
                Min = 700,
                Base = 1454,
                Scale = -14,
                Formatter = "ColonTime"
            }
        }
    },
    ["Glacial Dragon"] = {
        Description = "Every <Cooldown>m, converts all Frozen mutation within <Range> studs to Glacial mutation. For every mutation converted: <XPAmount> XP is added to all other pets in your garden. (Max 10,000 XP) Ignores favorited fruit",
        States = {
            Cooldown = {
                Min = 270,
                Base = 540,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            },
            XPAmount = {
                Max = 1000,
                Base = 500,
                Scale = 50
            }
        }
    },
    ["Frost Diety"] = {
        Description = "When selling Fruits with Glacial Mutation, <Chance>% chance a random mutation from that fruit will be applied to the fruits in your garden!",
        States = {
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.1
            }
        }
    },
    ["GIANT Snow-munition"] = {
        Description = "Every <Cooldown>m, grants <MinAmount> - <MaxAmount> Snowballs!",
        States = {
            Cooldown = {
                Min = 30,
                Base = 90,
                Scale = -1.8,
                Formatter = "ColonTime"
            },
            MinAmount = {
                Max = 10,
                Base = 5,
                Scale = 0.25
            },
            MaxAmount = {
                Max = 16,
                Base = 8,
                Scale = 0.25
            }
        }
    },
    ["GIANT Icy Fortifications"] = {
        Description = "Every <Cooldown>m, consumes Fruits with any Cold type mutations and grants a Snow-Fort based cosmetic reward! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 60,
                Base = 120,
                Scale = -2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Arctic Scoundrel"] = {
        Description = "Every <Cooldown>m, steals 24 random unique fruit from your garden and refreshes the seed shop! Ignores favorited fruit. Cannot be mimicked or refreshed.",
        States = {
            Cooldown = {
                Min = 400,
                Base = 800,
                Scale = -14,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Glacial Dragon"] = {
        Description = "Every <Cooldown>m, converts all Frozen mutation within <Range> studs to Glacial mutation. For every mutation converted: <XPAmount> XP is added to all other pets in your garden. (Max 10,000 XP) Ignores favorited fruit",
        States = {
            Cooldown = {
                Min = 120,
                Base = 270,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 90,
                Base = 45,
                Scale = 0.3
            },
            XPAmount = {
                Max = 2000,
                Base = 1000,
                Scale = 50
            }
        }
    },
    ["Rainbow Frost Diety"] = {
        Description = "When selling Fruits with Glacial Mutation, <Chance>% chance a random mutation from that fruit will be applied to the fruits in your garden!",
        States = {
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.1
            }
        }
    },
    ["Gift Wrat"] = {
        Description = "Every <Cooldown>m, converts an apple into a random gift cosmetic! Collect all 6 variants!",
        States = {
            Cooldown = {
                Min = 120,
                Base = 420,
                Scale = -4.2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Belly Slide"] = {
        Description = "Every <Cooldown>m, turns you into a belly sliding penguin for <Duration>s! Also belly slides to <Amount> random fruit in your garden and applies the Arctic mutation!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 727,
                Scale = -7.2,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 60,
                Base = 29.7,
                Scale = 1
            },
            Amount = {
                Max = 12,
                Base = 3,
                Scale = 0.3
            }
        }
    },
    ["Christmas Carrot"] = {
        Description = "Every <Cooldown>m, eats a Carrot for <Multiplier>x sheckles value and grants all Bunnies in your garden <MinXP> - <MaxXP> XP!",
        States = {
            Cooldown = {
                Min = 140,
                Base = 720,
                Scale = -4.2,
                Formatter = "ColonTime"
            },
            Multiplier = {
                Base = 1.5,
                Scale = 0.015
            },
            MinXP = {
                Max = 2000,
                Base = 1000,
                Scale = 10
            },
            MaxXP = {
                Max = 4000,
                Base = 2000,
                Scale = 10
            }
        }
    },
    ["Christmas Hen"] = {
        Description = "Christmas type plants within <Range> studs have <Multiplier>x increased size multiplier!",
        States = {
            Multiplier = {
                Max = 0.7,
                Base = 0.35,
                Scale = 0.035
            },
            Range = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            }
        }
    },
    ["Cold Belly"] = {
        Description = "Every <Cooldown>m, grabs fruits with Cold type mutations to reduce a random pot\'s cooking time by <Amount>s!",
        States = {
            Cooldown = {
                Min = 120,
                Base = 300,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 160,
                Base = 80,
                Scale = 1
            }
        }
    },
    ["Jolly Croak"] = {
        Description = "Every <Cooldown>m, croaks at the nearest plant, advancing growth by <Time>m for each Christmas type pet in your garden, then all fruits on that plant will get the Chilled mutation!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 909,
                Scale = -9,
                Formatter = "ColonTime"
            },
            Time = {
                Max = 1800,
                Base = 891,
                Scale = 9,
                Formatter = "ColonTime"
            }
        }
    },
    ["Coal Sack"] = {
        Description = "Every <Cooldown>m, consumes a percentage of your sheckles to punish the nearest player to you! Greater punishments are rarer and consume more sheckles.",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Christmas Carrot"] = {
        Description = "Every <Cooldown>m, eats a Carrot for <Multiplier>x sheckles value and grants all Bunnies in your garden <MinXP> - <MaxXP> XP!",
        States = {
            Cooldown = {
                Min = 120,
                Base = 360,
                Scale = -4.2,
                Formatter = "ColonTime"
            },
            Multiplier = {
                Base = 1.5,
                Scale = 0.015
            },
            MinXP = {
                Max = 4000,
                Base = 2000,
                Scale = 10
            },
            MaxXP = {
                Max = 8000,
                Base = 4000,
                Scale = 10
            }
        }
    },
    ["Rainbow Christmas Hen"] = {
        Description = "Christmas type plants within <Range> studs have <Multiplier>x increased size multiplier!",
        States = {
            Multiplier = {
                Max = 0.7,
                Base = 0.35,
                Scale = 0.035
            },
            Range = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Rainbow Cold Belly"] = {
        Description = "Every <Cooldown>s, grabs fruits with Cold type mutations to reduce a random pot\'s cooking time by <Amount>s!",
        States = {
            Cooldown = {
                Min = 75,
                Base = 150,
                Scale = -1.5,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 240,
                Base = 120,
                Scale = 1
            }
        }
    },
    ["Rainbow Jolly Croak"] = {
        Description = "Every <Cooldown>m, croaks at the nearest plant, advancing growth by <Time>m for each Christmas type pet in your garden, then all fruits on that plant will get the Chilled mutation!",
        States = {
            Cooldown = {
                Min = 100,
                Base = 606,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Time = {
                Max = 2000,
                Base = 1300,
                Scale = 9,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Coal Sack"] = {
        Description = "Every <Cooldown>m, consumes a percentage of your sheckles to punish the nearest player to you! Greater punishments are rarer and consume more sheckles.",
        States = {
            Cooldown = {
                Min = 240,
                Base = 480,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Christmas Dove"] = {
        Description = "Christmas plants within <Range> studs have <Multiplier>x increased growth speed chance!",
        States = {
            Multiplier = {
                Max = 0.6,
                Base = 0.3,
                Scale = 0.03
            },
            Range = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            }
        }
    },
    ["Sleigh Synergy"] = {
        Description = "Gains an additional <Amount> XP/s for every other Reindeer in your garden!",
        States = {
            Amount = {
                Max = 12,
                Base = 6,
                Scale = 0.06
            }
        }
    },
    ["Beast of Snow"] = {
        Description = "Every <Cooldown>m, has <Chance>% chance to apply the Snowy mutation to a nearby fruit!",
        States = {
            Cooldown = {
                Min = 150,
                Base = 303,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 28,
                Base = 14,
                Scale = 0.14
            }
        }
    },
    Nutcracker = {
        Description = "Every <Cooldown>m, cracks open a random Nutty type fruit and grants a random Christmas related reward! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 360,
                Base = 720,
                Scale = -4.2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Yeti Night"] = {
        Description = "Every <Cooldown>m devours a fruit with at least 16 mutations to summon the Yeti Night weather! Ignores favorited fruit!",
        States = {
            Cooldown = {
                Min = 400,
                Base = 909,
                Scale = -9,
                Formatter = "ColonTime"
            }
        }
    },
    ["Cold Gears"] = {
        Description = "Grants a <font color=\'#FFD700\'><Chance>%</font> chance for the pet mutation acquired from Pet Mutation Machine to become one of four Ice Golem–exclusive mutations:\n\n<font color=\'#00C800\'>Christmas Rally</font>, <font color=\'#FF0000\'>Jolly Decorator</font>, <font color=\'#FFD700\'>Merry Nursery</font>, with a rare chance for <font color=\'#5AC8FF\'>Giant Golem</font>!",
        States = {
            Chance = {
                Max = 10,
                Base = 4,
                Scale = 0.4
            }
        }
    },
    ["Festive Christmas Dove"] = {
        Description = "Christmas plants within <Range> studs have <Multiplier>x increased growth speed chance!",
        States = {
            Multiplier = {
                Max = 1.2,
                Base = 0.6,
                Scale = 0.06
            },
            Range = {
                Max = 50,
                Base = 25,
                Scale = 0.15
            }
        }
    },
    ["Festive Sleigh Synergy"] = {
        Description = "Gains an additional <Amount> XP/s for every other Reindeer in your garden!",
        States = {
            Amount = {
                Max = 16,
                Base = 8,
                Scale = 0.08
            }
        }
    },
    ["Festive Beast of Snow"] = {
        Description = "Every <Cooldown>m, has <Chance>% chance to apply the Snowy mutation to a nearby fruit!",
        States = {
            Cooldown = {
                Min = 80,
                Base = 151.5,
                Scale = -1.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Festive Nutcracker"] = {
        Description = "Every <Cooldown>m, cracks open a random Nutty type fruit and grants a random Christmas related reward! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 120,
                Base = 360,
                Scale = -3.6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Festive Yeti Night"] = {
        Description = "Every <Cooldown>m devours a fruit with at least 16 mutations to summon the Yeti Night weather! Ignores favorited fruit!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Festive Cold Gears"] = {
        Description = "Grants a <font color=\'#FFD700\'><Chance>%</font> chance for the pet mutation acquired from Pet Mutation Machine to become one of four Ice Golem–exclusive mutations:\n\n<font color=\'#00C800\'>Christmas Rally</font>, <font color=\'#FF0000\'>Jolly Decorator</font>, <font color=\'#FFD700\'>Merry Nursery</font>, with a rare chance for <font color=\'#5AC8FF\'>Giant Golem</font>!",
        States = {
            Chance = {
                Max = 16,
                Base = 8,
                Scale = 0.8
            }
        }
    },
    ["Pine Beetle Duel"] = {
        Description = "Every <Cooldown>m, initiates a battle with another player\'s Beetle. If your beetle wins you get a reward! The higher level and heavier the beetle the more likely it is to win! Pine Beetles can give a beetle reward exclusive to it.",
        States = {
            Cooldown = {
                Min = 80,
                Base = 360,
                Scale = -2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Cocoa Nap"] = {
        Description = "Every <Cooldown>m, goes to a Hot Chocolate Mug cosmetic and naps near it for <Duration>s. New fruit within <Range> studs will be <Multiplier>x larger",
        States = {
            Cooldown = {
                Min = 120,
                Base = 244,
                Scale = -2,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            },
            Duration = {
                Max = 28,
                Base = 14.5,
                Scale = 0.15
            },
            Multiplier = {
                Max = 2,
                Base = 1,
                Scale = 0.1
            }
        }
    },
    Eggnoginator = {
        Description = "Every <Cooldown>m, has a <Chance>% chance to mutate a random fruit with the Eggnog mutation. Gains additional <Amount>% chance for every Egg in your garden.",
        States = {
            Cooldown = {
                Min = 150,
                Base = 303,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 6,
                Base = 3,
                Scale = 0.03
            },
            Amount = {
                Max = 4,
                Base = 2,
                Scale = 0.02
            }
        }
    },
    ["Red-Nosed Reindeer"] = {
        Description = "Every <Cooldown>m, grants <Amount>XP to a random non-Reindeer Pet in your garden for every Reindeer in your garden!",
        States = {
            Cooldown = {
                Min = 150,
                Base = 300,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 4000,
                Base = 2000,
                Scale = 20
            }
        }
    },
    ["Shiny Nose"] = {
        Description = "Every <Cooldown>m, mutates fruit up to the number of Reindeer in your garden with Ornamented mutation!",
        States = {
            Cooldown = {
                Min = 400,
                Base = 913,
                Scale = -9,
                Formatter = "ColonTime"
            }
        }
    },
    ["Christmas Partridge"] = {
        Description = "Grants Christmas plants in <Range> studs a <Multiplier>x variant chance bonus!",
        States = {
            Multiplier = {
                Max = 0.8,
                Base = 0.4,
                Scale = 0.04
            },
            Range = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Merry Beary"] = {
        Description = "Every <Cooldown>m, spawns a gift randomly somewhere! Finding the Gift will grant a Christmas related reward!",
        States = {
            Cooldown = {
                Min = 120,
                Base = 540,
                Scale = -5.4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Christmas Support"] = {
        Description = "When Christmas type pets finish their abilities, they start their cooldown with <Chance> seconds less!",
        States = {
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.4
            }
        }
    },
    ["Moose Call"] = {
        Description = "Every <Cooldown>m, eats a fruit with a Cold type mutation and all nearby plants within <Range> studs advance growth by <Amount>m! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 120,
                Base = 240,
                Scale = -2.4,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            },
            Amount = {
                Max = 360,
                Base = 180,
                Scale = 1.8,
                Formatter = "ColonTime"
            }
        }
    },
    ["FREEZE!"] = {
        Description = "Every <Cooldown>m, has a <Chance>% chance to apply the Subzero Mutation!",
        States = {
            Cooldown = {
                Min = 30,
                Base = 303,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.12
            }
        }
    },
    ["Gnawing Hunger"] = {
        Description = "Loses 0.25% Hunger per second. At 30%+ Hunger, all other pets gain +<Amount> XP/s. At 60%+ Hunger, all other pets stop losing Hunger. At 90%+ Hunger, both bonuses are active simultaneously.",
        States = {
            Amount = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            }
        }
    },
    ["Festive Christmas Partridge"] = {
        Description = "Grants Christmas plants in <Range> studs a <Multiplier>x variant chance bonus!",
        States = {
            Multiplier = {
                Max = 1,
                Base = 0.5,
                Scale = 0.05
            },
            Range = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            }
        }
    },
    ["Festive Merry Beary"] = {
        Description = "Every <Cooldown>m, spawns a gift randomly somewhere! Finding the Gift will grant a Christmas related reward!",
        States = {
            Cooldown = {
                Min = 100,
                Base = 300,
                Scale = -4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Festive Christmas Support"] = {
        Description = "When Christmas type pets finish their abilities, they start their cooldown with <Chance> seconds less!",
        States = {
            Chance = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            }
        }
    },
    ["Festive Moose Call"] = {
        Description = "Every <Cooldown>m, eats a fruit with a Cold type mutation and all nearby plants within <Range> studs advance growth by <Amount>m! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 100,
                Base = 200,
                Scale = -2,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 80,
                Base = 40,
                Scale = 0.4
            },
            Amount = {
                Max = 400,
                Base = 200,
                Scale = 2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Festive FREEZE!"] = {
        Description = "Every <Cooldown>m, has a <Chance>% chance to apply the Subzero Mutation!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 170,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 48,
                Base = 24,
                Scale = 0.24
            }
        }
    },
    ["Festive Gnawing Hunger"] = {
        Description = "Loses 0.25% Hunger per second. At 30%+ Hunger, all other pets gain +<Amount> XP/s. At 60%+ Hunger, all other pets stop losing Hunger. At 90%+ Hunger, both bonuses are active simultaneously.",
        States = {
            Amount = {
                Max = 100,
                Base = 50,
                Scale = 0.5
            }
        }
    },
    ["Yellow Christmas"] = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Sandy or Snowy!",
        States = {
            Cooldown = {
                Min = 30,
                Base = 120,
                Scale = -1.2,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["The Christmas Spirit"] = {
        Description = "Christmas type plants within <Range> studs have increased <VariantMultiplier>x variant chance, <GrowthMultiplier>x growth speed and <SizeMultiplier>x size bonus!",
        States = {
            VariantMultiplier = {
                Max = 1.5,
                Base = 0.6,
                Scale = 0.05
            },
            GrowthMultiplier = {
                Max = 3,
                Base = 1.4,
                Scale = 0.1
            },
            SizeMultiplier = {
                Max = 1,
                Base = 0.42,
                Scale = 0.05
            },
            Range = {
                Max = 60,
                Base = 32,
                Scale = 0.25
            }
        }
    },
    ["The Christmas Cheer"] = {
        Description = "Every <Cooldown>m, <Amount> random fruit have a <Chance>% chance to get the Festive mutation!",
        States = {
            Cooldown = {
                Min = 450,
                Base = 909,
                Scale = -9,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.2
            },
            Amount = {
                Max = 8,
                Base = 4,
                Scale = 0.04
            }
        }
    },
    ["The Christmas Rally"] = {
        Description = "All active Christmas type pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Max = 4,
                Base = 1.4,
                Scale = 0.05
            }
        }
    },
    ["Christmas Power"] = {
        Description = "",
        States = {
            Multiplier = {
                Max = 1,
                Base = 0.42,
                Scale = 0.05
            },
            Range = {
                Max = 60,
                Base = 32,
                Scale = 0.25
            }
        }
    },
    ["Christmas Tempo"] = {
        Description = "",
        States = {
            Multiplier = {
                Max = 3,
                Base = 1.4,
                Scale = 0.1
            },
            Range = {
                Max = 60,
                Base = 32,
                Scale = 0.25
            }
        }
    },
    ["Christmas Blessing"] = {
        Description = "",
        States = {
            Multiplier = {
                Max = 1.5,
                Base = 0.6,
                Scale = 0.05
            },
            Range = {
                Max = 60,
                Base = 32,
                Scale = 0.25
            }
        }
    },
    ["New Year\'s Bird"] = {
        Description = "Every <Cooldown>m flies around and launches fireworks everywhere to celebrate the new year!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 120,
                Scale = -1.2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Firework Fairy"] = {
        Description = "Every <Cooldown>m, grants <MinAmount> - <MaxAmount> Fireworks!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 180,
                Scale = -1.8,
                Formatter = "ColonTime"
            },
            MinAmount = {
                Max = 6,
                Base = 3,
                Scale = 0.05
            },
            MaxAmount = {
                Max = 10,
                Base = 5,
                Scale = 0.05
            }
        }
    },
    ["Celebration\'s Best Friend"] = {
        Description = "Every <Cooldown>m, <Chance>% chance to dig up a random New Year cosmetic!",
        States = {
            Cooldown = {
                Min = 100,
                Base = 200,
                Scale = -2,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["Primate Productivity"] = {
        Description = "Every <Cooldown>m, grabs a random crop from your garden and brings it to 1 of 4 different things for different bonuses! (Ignores favorited)",
        States = {
            Cooldown = {
                Min = 240,
                Base = 480,
                Scale = -4.2,
                Formatter = "ColonTime"
            },
            EggAdvancementAmount = {
                Max = 200,
                Base = 100,
                Scale = 1
            },
            GearMaxAmount = {
                Max = 6,
                Base = 3,
                Scale = 0.03
            },
            PetXPAmount = {
                Max = 2000,
                Base = 1000,
                Scale = 10
            }
        }
    },
    ["Celestial Howl"] = {
        Description = "Every <Cooldown>m consumes the energy of 5 random moonlit fruits (Ignores favorited), howls and calls forth <AmountMin> - <AmountMax> shooting stars to fall on your garden which mutate fruits into Celestial!",
        States = {
            Cooldown = {
                Min = 540,
                Base = 1040,
                Scale = -10.4,
                Formatter = "ColonTime"
            },
            AmountMin = {
                Max = 4,
                Base = 2,
                Scale = 0.04
            },
            AmountMax = {
                Max = 8,
                Base = 4,
                Scale = 0.04
            }
        }
    },
    ["Breath of Fireworks"] = {
        Description = "Every <Cooldown>m breathes fireworks on <AmountMin> - <AmountMax> random fruits in your garden and mutates them with Firework mutation!",
        States = {
            Cooldown = {
                Min = 540,
                Base = 1080,
                Scale = -10.8,
                Formatter = "ColonTime"
            },
            AmountMin = {
                Max = 20,
                Base = 20,
                Scale = 0
            },
            AmountMax = {
                Max = 26,
                Base = 26,
                Scale = 0
            }
        }
    },
    Resolution = {
        Description = "Every <Cooldown>m, consumes <Amount> fruit with the Firework mutation to give you the Dragon\'s Firework Gear which has positive bonuses when used! Cannot be mimicked or refreshed.",
        States = {
            Cooldown = {
                Min = 400,
                Base = 720,
                Scale = -7.2,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 100,
                Min = 100,
                Base = 100,
                Scale = 0
            }
        }
    },
    ["Rainbow New Year\'s Bird"] = {
        Description = "Every <Cooldown>m flies around and launches fireworks everywhere to celebrate the new year!",
        States = {
            Cooldown = {
                Min = 30,
                Base = 60,
                Scale = -0.6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Firework Fairy"] = {
        Description = "Every <Cooldown>m, grants <MinAmount> - <MaxAmount> Fireworks!",
        States = {
            Cooldown = {
                Min = 50,
                Base = 100,
                Scale = -1,
                Formatter = "ColonTime"
            },
            MinAmount = {
                Max = 10,
                Base = 5,
                Scale = 0.08
            },
            MaxAmount = {
                Max = 16,
                Base = 8,
                Scale = 0.08
            }
        }
    },
    ["Rainbow Celebration\'s Best Friend"] = {
        Description = "Every <Cooldown>m, <Chance>% chance to dig up a random New Year cosmetic!",
        States = {
            Cooldown = {
                Min = 50,
                Base = 100,
                Scale = -1
            },
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Rainbow Primate Productivity"] = {
        Description = "Every <Cooldown>m, grabs a random crop from your garden and brings it to 1 of 4 different things for different bonuses! (Ignores favorited)",
        States = {
            Cooldown = {
                Min = 120,
                Base = 240,
                Scale = -2.4,
                Formatter = "ColonTime"
            },
            EggAdvancementAmount = {
                Max = 300,
                Base = 150,
                Scale = 1.5
            },
            GearMaxAmount = {
                Max = 10,
                Base = 5,
                Scale = 0.05
            },
            PetXPAmount = {
                Max = 3000,
                Base = 1500,
                Scale = 15
            }
        }
    },
    ["Rainbow Celestial Howl"] = {
        Description = "Every <Cooldown>m consumes the energy of 5 random moonlit fruits (Ignores favorited), howls and calls forth <AmountMin> - <AmountMax> shooting stars to fall on your garden which mutate fruits into Celestial!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 520,
                Scale = -5.2,
                Formatter = "ColonTime"
            },
            AmountMin = {
                Max = 8,
                Base = 4,
                Scale = 0.04
            },
            AmountMax = {
                Max = 16,
                Base = 8,
                Scale = 0.04
            }
        }
    },
    ["Rainbow Breath of Fireworks"] = {
        Description = "Every <Cooldown>m breathes fireworks on <AmountMin> - <AmountMax> random fruits in your garden and mutates them with Firework mutation!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -6.8,
                Formatter = "ColonTime"
            },
            AmountMin = {
                Max = 20,
                Base = 20,
                Scale = 0
            },
            AmountMax = {
                Max = 26,
                Base = 26,
                Scale = 0
            }
        }
    },
    ["Rainbow Resolution"] = {
        Description = "Every <Cooldown>m, consumes <Amount> fruit with the Firework mutation to give you the Dragon\'s Firework Gear which has positive bonuses when used! Cannot be mimicked or refreshed.",
        States = {
            Cooldown = {
                Min = 200,
                Base = 400,
                Scale = -4,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 80,
                Min = 80,
                Base = 80,
                Scale = 0
            }
        }
    },
    Unicycling = {
        Description = "Grants <Chance>% increased movement speed!",
        States = {
            Chance = {
                Max = 48,
                Base = 24,
                Scale = 0.24
            }
        }
    },
    ["Play Ball"] = {
        Description = "Every <Cooldown>m, plays ball with you. Every time you succesfully recieve the ball a random plant in your garden grows by <AmountGrowth>s or a random pet gets <AmountXP> XP! (Max 15)",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -6,
                Formatter = "ColonTime"
            },
            AmountGrowth = {
                Max = 120,
                Base = 60,
                Scale = 0.6
            },
            AmountXP = {
                Max = 100,
                Base = 50,
                Scale = 0.5
            }
        }
    },
    ["One Bear Act"] = {
        Description = "Every <Cooldown>m, goes to a random fruit in your garden and does a trick on it, applying the Whimsical mutation!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 1200,
                Scale = -12,
                Formatter = "ColonTime"
            }
        }
    },
    ["Pony Parade"] = {
        Description = "Every 30m on the clock, All your Ponies form a line and Parade towards the Gear Shop, Egg Shop or Seed Shop and has a chance to restock 1 random item for every pony in the parade.",
        States = {}
    },
    ["The Show Must Go On"] = {
        Description = "When a pet finishes their ability: There is a <Chance>% chance the ability is activated again. You cannot have two pets of the same type for this passive to activate. (Except Carnival Elephants)",
        States = {
            Chance = {
                Max = 6,
                Base = 3,
                Scale = 0.03
            }
        }
    },
    ["Rainbow Unicycling"] = {
        Description = "Grants <Chance>% increased movement speed!",
        States = {
            Chance = {
                Max = 64,
                Base = 32,
                Scale = 0.32
            }
        }
    },
    ["Rainbow Play Ball"] = {
        Description = "Every <Cooldown>m, plays ball with you. Every time you succesfully recieve the ball a random plant in your garden grows by <AmountGrowth>s or a random pet gets <AmountXP> XP! (Max 15)",
        States = {
            Cooldown = {
                Min = 250,
                Base = 500,
                Scale = -5,
                Formatter = "ColonTime"
            },
            AmountGrowth = {
                Max = 240,
                Base = 120,
                Scale = 0.6
            },
            AmountXP = {
                Max = 200,
                Base = 100,
                Scale = 0.5
            }
        }
    },
    ["Rainbow One Bear Act"] = {
        Description = "Every <Cooldown>m, goes to a random fruit in your garden and does a trick on it, applying the Whimsical mutation!",
        States = {
            Cooldown = {
                Min = 100,
                Base = 600,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Pony Parade"] = {
        Description = "Every 30m on the clock, All your Ponies form a line and Parade towards the Gear Shop, Egg Shop or Seed Shop and has a chance to restock 1 random item for every pony in the parade.",
        States = {}
    },
    ["Rainbow The Show Must Go On"] = {
        Description = "When a pet finishes their ability: There is a <Chance>% chance the ability is activated again. You cannot have two pets of the same type for this passive to activate. (Except Carnival Elephants)",
        States = {
            Chance = {
                Max = 10,
                Base = 5,
                Scale = 0.05
            }
        }
    },
    ["Angora Ram"] = {
        Description = "Every <Cooldown>m, rams a random player, knocking them away with a <Chance>% chance to give them a random single harvest seed from the seed shop. Rarer seeds have rarer chance.",
        States = {
            Cooldown = {
                Min = 100,
                Base = 360,
                Scale = -3.6,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 40,
                Base = 30,
                Scale = 0.3
            }
        }
    },
    ["Fat Snake"] = {
        Description = "<Chance>% extra chance harvested plants drop seeds. Rarer plants have lower chance to drop seeds.",
        States = {
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.05
            }
        }
    },
    ["Mechanical Rodent"] = {
        Description = "Every <Cooldown>m, converts a Buttercup into a random mechanical themed cosmetic! Collect all 5!",
        States = {
            Cooldown = {
                Min = 120,
                Base = 420,
                Scale = -4.2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Hot Honey"] = {
        Description = "Every <Cooldown>m, <Chance>% chance for a nearby fruit to become Burnt or Flaming!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 404,
                Scale = -4,
                Formatter = "ColonTime"
            },
            Chance = {
                Base = 15,
                Scale = 0.15
            }
        }
    },
    ["Champion Beetle Duel"] = {
        Description = "Every <Cooldown>m, initiates a battle with another player\'s Beetle. If your beetle wins you get a reward! The higher level and heavier the beetle the more likely it is to win! Champion Beetles can reward Beetle Medals which when used on a pet gains XP based on number of Beetle Trophies you have in your garden!",
        States = {
            Cooldown = {
                Min = 80,
                Base = 360,
                Scale = -2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Calico Nap"] = {
        Description = "Every <Cooldown>s, naps for <Duration>s. New fruit within <Range> studs will be <Multiplier>x larger and have a <Chance>% chance to be mutated with Sleepy mutation!",
        States = {
            Cooldown = {
                Min = 100,
                Base = 202,
                Scale = -2
            },
            Duration = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            },
            Range = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            },
            Multiplier = {
                Max = 5,
                Base = 1.5,
                Scale = 0.15
            },
            Chance = {
                Max = 16,
                Base = 8,
                Scale = 0.08
            }
        }
    },
    ["Digging K9"] = {
        Description = "Every <Cooldown>s, <Chance>% chance to dig up a random seed! The dug up seed has a <GoldChance>% chance to be a Gold seed instead!",
        States = {
            Cooldown = {
                Min = 100,
                Base = 200,
                Scale = -2
            },
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.12
            },
            GoldChance = {
                Max = 8,
                Base = 4,
                Scale = 0.04
            }
        }
    },
    ["Garden Looter"] = {
        Description = "Every <Cooldown>m, goes to a random shop and steals an item that is in stock and gives it to you! Rarer items have rarer chance to be stolen.",
        States = {
            Cooldown = {
                Min = 180,
                Base = 360,
                Scale = -3.6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Opulent Bird"] = {
        Description = "Every <Cooldown>m, <Chance>% chance to mutate a nearby fruit, applying the Opulent mutation!",
        States = {
            Cooldown = {
                Min = 15,
                Base = 486,
                Scale = -4,
                Formatter = "ColonTime"
            },
            Chance = {
                Base = 15,
                Scale = 0.5
            }
        }
    },
    ["Pure Beauty"] = {
        Description = "Every <Cooldown>m, fans its feathers and all active pets within <Range> studs will advance cooldown for their abilities by <Amount>s and gain XP equal to half that amount!",
        States = {
            Cooldown = {
                Min = 30,
                Base = 606,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 150,
                Base = 65,
                Scale = 0.6
            },
            Range = {
                Max = 60,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Queen of the Safari"] = {
        Description = "Every <Cooldown>m, roars and mutates fruit up to the number of Safari type pets you have in your garden with a random Safari Mutation!",
        States = {
            Cooldown = {
                Min = 400,
                Base = 1400,
                Scale = -14,
                Formatter = "ColonTime"
            }
        }
    },
    ["Diamond Transmutation"] = {
        Description = "Every <Cooldown>m, turns one random fruit diamond!",
        States = {
            Cooldown = {
                Min = 150,
                Base = 303,
                Scale = -3,
                Formatter = "ColonTime"
            }
        }
    },
    ["Scorpion Sting"] = {
        Description = "Every <Cooldown>m, stings a pet with the highest cooldown and refreshes its ability! There is a <Chance>% chance for the stung pet to get the Venom Pet Mutation!",
        States = {
            Cooldown = {
                Min = 450,
                Base = 909,
                Scale = -9,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 10,
                Base = 5,
                Scale = 0.05
            }
        }
    },
    ["Whale Waters"] = {
        Description = "Every <Cooldown>m, eats a fruit that is at least <FruitWeight>kg and summons the Whale Waters weather! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1818,
                Scale = -18,
                Formatter = "ColonTime"
            },
            FruitWeight = {
                Min = 0,
                Base = 50,
                Scale = 0
            }
        }
    },
    ["Gale Wyvern"] = {
        Description = "Every <Cooldown>m, converts all Windstruck mutation fruit within <Range> studs to Gale mutation. For every mutation converted: <Amount>s cooldown is advanced for all other pets in your garden. (Max 10 minutes)",
        States = {
            Cooldown = {
                Min = 270,
                Base = 540,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            },
            Amount = {
                Max = 60,
                Base = 5,
                Scale = 2
            }
        }
    },
    ["Wind Diety"] = {
        Description = "When selling Fruits with Gale Mutation, <Chance>% chance a random mutation from that fruit will be applied to the fruits in your garden!",
        States = {
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.1
            }
        }
    },
    ["Honest Labor"] = {
        Description = "Every <Cooldown>m, harvests a crop and gives it to you! <Chance>% chance the crop stays when harvested.",
        States = {
            Cooldown = {
                Min = 120,
                Base = 242.4,
                Scale = -2.4,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            }
        }
    },
    ["Light Up"] = {
        Description = "Every <Cooldown>m, stings a random pet and advances its ability cooldown by <Amount>s! Extra <AmountBonus>s cooldown advanced for every other Firemite in your garden!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 602,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 80,
                Base = 40,
                Scale = 0.4
            },
            AmountBonus = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Ashened Furnishing"] = {
        Description = "Every <Cooldown>m, consumes Fruits with Ash and/or Burnt mutation and grants an Ash-Castle based cosmetic reward! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 150,
                Base = 300,
                Scale = -3,
                Formatter = "ColonTime"
            }
        }
    },
    ["Hound of Ash"] = {
        Description = "Every <Cooldown>m, applies Ash mutation to a random fruit!",
        States = {
            Cooldown = {
                Min = 400,
                Base = 800,
                Scale = -4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Hound of Haze"] = {
        Description = "Every <Cooldown>m, applies Haze mutation to a random fruit!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1000,
                Scale = -5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Trial by Fire"] = {
        Description = "Every <Cooldown>m, devours a fruit with Ash, Haze, Burnt & Flaming mutations, applying Smoldering mutation to another fruit, also has a <Chance>% chance to increase the level of pet in your garden.",
        States = {
            Cooldown = {
                Min = 1100,
                Base = 2200,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 6,
                Base = 3,
                Scale = 0.3
            }
        }
    },
    ["Flame Diety"] = {
        Description = "When selling Fruits with Smoldering Mutation, <Chance>% chance a random mutation from that fruit will be applied to the fruits in your garden!",
        States = {
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.1
            }
        }
    },
    ["GIANT Light Up"] = {
        Description = "Every <Cooldown>m, stings a random pet and advances its ability cooldown by <Amount>s! Extra <AmountBonus>s cooldown advanced for every other Firemite in your garden!",
        States = {
            Cooldown = {
                Min = 50,
                Base = 502,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 100,
                Base = 50,
                Scale = 0.4
            },
            AmountBonus = {
                Max = 50,
                Base = 30,
                Scale = 0.3
            }
        }
    },
    ["GIANT Ashened Furnishing"] = {
        Description = "Every <Cooldown>m, consumes Fruits with Ash and/or Burnt mutation and grants an Ash-Castle based cosmetic reward! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 100,
                Base = 200,
                Scale = -3,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Hound of Ash"] = {
        Description = "Every <Cooldown>m, applies Ash mutation to a random fruit!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Hound of Haze"] = {
        Description = "Every <Cooldown>m, applies Haze mutation to a random fruit!",
        States = {
            Cooldown = {
                Min = 400,
                Base = 800,
                Scale = -5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Trial by Fire"] = {
        Description = "Every <Cooldown>m, devours a fruit with Ash, Haze, Burnt & Flaming mutations, applying Smoldering mutation to another fruit, also has a <Chance>% chance to increase the level of pet in your garden.",
        States = {
            Cooldown = {
                Min = 900,
                Base = 1800,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 8,
                Base = 4,
                Scale = 0.3
            }
        }
    },
    ["Rainbow Flame Diety"] = {
        Description = "When selling Fruits with Smoldering Mutation, <Chance>% chance a random mutation from that fruit will be applied to the fruits in your garden!",
        States = {
            Chance = {
                Max = 16,
                Base = 8,
                Scale = 0.1
            }
        }
    },
    ["Choc Chomper"] = {
        Description = "Every <Cooldown>m, Eats any Carrot plant with Choc mutation and spreads it to two other random fruits in your garden. Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 240,
                Base = 480,
                Scale = -4.8,
                Formatter = "ColonTime"
            }
        }
    },
    ["Easter Eggcelerator"] = {
        Description = "Every <Cooldown>m, goes to a random un-hatched egg, and reduces its hatch time by <Amount>s! Bonus <AmountBonus>s for every other Easter Egg Chick in your garden!",
        States = {
            Cooldown = {
                Min = 100,
                Base = 180,
                Scale = -1.8,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 60,
                Base = 25,
                Scale = 0.25
            },
            AmountBonus = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["The Smore You Know"] = {
        Description = "Every <Cooldown>m, grants another pet in your garden either <XPAmount> XP OR advances its ability cooldown by <CDAmount>s! Marshmallow Lamb gains whichever bonus was not given.",
        States = {
            Cooldown = {
                Min = 360,
                Base = 720,
                Scale = -7,
                Formatter = "ColonTime"
            },
            XPAmount = {
                Max = 800,
                Base = 400,
                Scale = 20
            },
            CDAmount = {
                Max = 160,
                Base = 80,
                Scale = 0.8
            }
        }
    },
    ["Egg Hunt"] = {
        Description = "Every <Cooldown>m hides an Easter Egg reward in a random spot. Finding the Easter Egg grants great rewards/very positive effects!",
        States = {
            Cooldown = {
                Min = 722,
                Base = 1444,
                Scale = -14,
                Formatter = "ColonTime"
            }
        }
    },
    ["Gilded Choc Choc Chomper"] = {
        Description = "Every <Cooldown>m, Eats any Carrot plant with Choc mutation and spreads it to two other random fruits in your garden. Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 150,
                Base = 300,
                Scale = -4.8,
                Formatter = "ColonTime"
            }
        }
    },
    ["Gilded Choc Easter Eggcelerator"] = {
        Description = "Every <Cooldown>m, goes to a random un-hatched egg, and reduces its hatch time by <Amount>s! Bonus <AmountBonus>s for every other Easter Egg Chick in your garden!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 110,
                Scale = -1.8,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 70,
                Base = 35,
                Scale = 0.25
            },
            AmountBonus = {
                Max = 50,
                Base = 25,
                Scale = 0.2
            }
        }
    },
    ["Gilded Choc The Smore You Know"] = {
        Description = "Every <Cooldown>m, grants another pet in your garden either <XPAmount> XP OR advances its ability cooldown by <CDAmount>s! Marshmallow Lamb gains whichever bonus was not given.",
        States = {
            Cooldown = {
                Min = 260,
                Base = 520,
                Scale = -7,
                Formatter = "ColonTime"
            },
            XPAmount = {
                Max = 1000,
                Base = 500,
                Scale = 20
            },
            CDAmount = {
                Max = 160,
                Base = 100,
                Scale = 0.8
            }
        }
    },
    ["Gilded Choc Egg Hunt"] = {
        Description = "Every <Cooldown>m hides an Easter Egg reward in a random spot. Finding the Easter Egg grants great rewards/very positive effects!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1000,
                Scale = -14,
                Formatter = "ColonTime"
            }
        }
    },
    ["Gummy Express"] = {
        Description = "Every <Cooldown>s, <Chance>% chance a nearby fruit gets the Gummy mutation!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 120,
                Scale = -1
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["Hootsie Experience"] = {
        Description = "All active Easter type pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Base = 0.6,
                Scale = 0.06
            }
        }
    },
    ["Hootsie Effect"] = {
        Description = "All active pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Base = 0.6,
                Scale = 0.06
            }
        }
    },
    ["The Wood Works"] = {
        Description = "Every <Cooldown>m, goes to a Woody type fruit in your garden to convert it into a random wooden-based building cosmetic! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 240,
                Base = 480,
                Scale = -4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Stork Delivery"] = {
        Description = "Every <Cooldown>m, grabs a random fruit in your garden and delivers it to another player\'s pet: to give <XPAmount>XP, or a Small Passive Boost! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -6,
                Formatter = "ColonTime"
            },
            XPAmount = {
                Max = 1000,
                Base = 500,
                Scale = 25
            }
        }
    },
    ["Orchid Zone"] = {
        Description = "Every <Cooldown>m, prays for <Duration>s & each second a fruit within <Range> studs has a <Chance>% chance to gain the Floral mutation. Fruit with Floral turn Gold, and Gold fruit with Floral convert to Rainbow!",
        States = {
            Cooldown = {
                Min = 390,
                Base = 780,
                Scale = -7.8,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            },
            Range = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            },
            Chance = {
                Max = 6,
                Base = 3,
                Scale = 0.03
            }
        }
    },
    ["Candy Craze"] = {
        Description = "Every <Cooldown>m, has <Chance>% chance to apply the Candy mutation!",
        States = {
            Cooldown = {
                Min = 540,
                Base = 1080,
                Scale = -4.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 25,
                Base = 15,
                Scale = 0.3
            }
        }
    },
    ["Bloom Bee"] = {
        Description = "Every <Cooldown>m, <Chance>% chance for a nearby fruit to get the Bloom mutation!",
        States = {
            Cooldown = {
                Min = 202,
                Base = 404,
                Scale = -4,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            }
        }
    },
    ["Hop Streak"] = {
        Description = "Every <Cooldown>m, hops in place: gaining <XPAmount> XP and advances growth for a random plant in your garden by <AdvancementAmount>m! The Jerboa has a <Chance>% chance to do it again each hop.",
        States = {
            Cooldown = {
                Min = 225,
                Base = 450,
                Scale = -4,
                Formatter = "ColonTime"
            },
            XPAmount = {
                Max = 600,
                Base = 300,
                Scale = 3
            },
            AdvancementAmount = {
                Max = 600,
                Base = 300,
                Scale = 3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["Spring Grazer"] = {
        Description = "Every <Cooldown>m, eats fruit with at least 4 mutations (Ignores favorited). Fruits and pets within <Range> studs get Bonuses: Fruits have a <Chance>% chance to get the Lush mutation & pets have a <Chance>% chance to gain <XPAmount>XP!",
        States = {
            Cooldown = {
                Min = 480,
                Base = 960,
                Scale = -9.6,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 50,
                Base = 25,
                Scale = 0.25
            },
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            },
            XPAmount = {
                Max = 2400,
                Base = 1200,
                Scale = 12
            }
        }
    },
    ["Everchanting Spring"] = {
        Description = "Every <Cooldown>m, blesses all pets in your garden, granting <XPAmount>XP each! There is a <Chance>% chance for one of the blessed pets to get the Everchanted Pet Mutation!",
        States = {
            Cooldown = {
                Min = 750,
                Base = 1500,
                Scale = -15,
                Formatter = "ColonTime"
            },
            XPAmount = {
                Max = 22000,
                Base = 11000,
                Scale = 80
            },
            Chance = {
                Max = 3,
                Base = 1.5,
                Scale = 0.015
            }
        }
    },
    ["Gilded Choc Bloom Bee"] = {
        Description = "Every <Cooldown>m, <Chance>% chance for a nearby fruit to get the Bloom mutation!",
        States = {
            Cooldown = {
                Min = 150,
                Base = 303,
                Scale = -4,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.15
            }
        }
    },
    ["Gilded Choc Hop Streak"] = {
        Description = "Every <Cooldown>m, hops in place: gaining <XPAmount> XP and advances growth for a random plant in your garden by <AdvancementAmount>m! The Jerboa has a <Chance>% chance to do it again each hop.",
        States = {
            Cooldown = {
                Min = 175,
                Base = 350,
                Scale = -4,
                Formatter = "ColonTime"
            },
            XPAmount = {
                Max = 800,
                Base = 400,
                Scale = 3
            },
            AdvancementAmount = {
                Max = 800,
                Base = 400,
                Scale = 3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.1
            }
        }
    },
    ["Gilded Choc Spring Grazer"] = {
        Description = "Every <Cooldown>m, eats fruit with at least 4 mutations (Ignores favorited). Fruits and pets within <Range> studs get Bonuses: Fruits have a <Chance>% chance to get the Lush mutation & pets have a <Chance>% chance to gain <XPAmount>XP!",
        States = {
            Cooldown = {
                Min = 380,
                Base = 760,
                Scale = -9.6,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 60,
                Base = 30,
                Scale = 0.25
            },
            Chance = {
                Max = 25,
                Base = 25,
                Scale = 0.2
            },
            XPAmount = {
                Max = 3000,
                Base = 1500,
                Scale = 12
            }
        }
    },
    ["Gilded Choc Everchanting Spring"] = {
        Description = "Every <Cooldown>m, blesses all pets in your garden, granting <XPAmount>XP each! There is a <Chance>% chance for one of the blessed pets to get the Everchanted Pet Mutation!",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1200,
                Scale = -15,
                Formatter = "ColonTime"
            },
            XPAmount = {
                Max = 300000,
                Base = 15000,
                Scale = 80
            },
            Chance = {
                Max = 5,
                Base = 2.5,
                Scale = 0.015
            }
        }
    },
    ["Song of Lyre"] = {
        Description = "Every <Cooldown>m, sings an empowering song, granting you the Song of Lyre buff for <Duration>s. While active, you have a <Chance>% chance to duplicate collected fruits and also get bonus <BonusAmount>kg weight multiplier. Reapplying the buff refreshes its duration. If the new buff has a higher chance or weight bonus, it replaces the current one.",
        States = {
            Cooldown = {
                Min = 400,
                Base = 800,
                Scale = -8,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 40,
                Base = 20,
                Scale = 0.2,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.2
            },
            BonusAmount = {
                Max = 4,
                Base = 2,
                Scale = 0.02,
                Formatter = "Weight"
            }
        }
    },
    ["Striking Spots"] = {
        Description = "Every <Cooldown>m, releases pink and blue spots, striking <Amount> random fruits, mutating them with <font color=\"rgb(0, 124, 255)\">S</font><font color=\"rgb(255, 34, 154)\">p</font><font color=\"rgb(0, 124, 255)\">o</font><font color=\"rgb(255, 34, 154)\">t</font><font color=\"rgb(0, 124, 255)\">t</font><font color=\"rgb(255, 34, 154)\">y</font>!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 1260,
                Scale = -3.6,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 10,
                Base = 5,
                Scale = 0.1
            }
        }
    },
    ["Bumble Pollinator"] = {
        Description = "Every <Cooldown>m, flies to a nearby fruit and pollinates it, applying Pollinated mutation!",
        States = {
            Cooldown = {
                Min = 50,
                Base = 900,
                Scale = -4.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Beeler Healer"] = {
        Description = "Every <Cooldown>m, grabs a Pollinated fruit (Ignores favorited) and gives it to another Pet. The pet gets either <XPAmount> XP or <HungerAmount>% restored hunger!",
        States = {
            Cooldown = {
                Min = 270,
                Base = 540,
                Scale = -5.4,
                Formatter = "ColonTime"
            },
            XPAmount = {
                Max = 800,
                Base = 400,
                Scale = 4
            },
            HungerAmount = {
                Max = 0.24,
                Base = 0.12,
                Scale = 0.012,
                Formatter = "Percentage"
            }
        }
    },
    Beetanist = {
        Description = "Every <Cooldown>m, transfers Pollinated mutation from a fruit (Ignores favorited) to <FruitAmount> other random fruits! The plants that have these fruits advance growth by <AdvancementAmount>m!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1010,
                Scale = -10,
                Formatter = "ColonTime"
            },
            FruitAmount = {
                Max = 6,
                Base = 3,
                Scale = 0.03
            },
            AdvancementAmount = {
                Max = 960,
                Base = 480,
                Scale = 4.8,
                Formatter = "ColonTime"
            }
        }
    },
    Beelemental = {
        Description = "Every <Cooldown>m, mutates a random fruit in your garden with Frozen, Windstruck, Verdant or Flaming!",
        States = {
            Cooldown = {
                Min = 330,
                Base = 660,
                Scale = -6.6,
                Formatter = "ColonTime"
            }
        }
    },
    ["For the Empress"] = {
        Description = "Every <Cooldown>m, refreshes the ability cooldowns for <AmountPets> random pets! Cannot be mimicked or refreshed",
        States = {
            Cooldown = {
                Min = 360,
                Base = 720,
                Scale = -7.2,
                Formatter = "ColonTime"
            },
            AmountPets = {
                Max = 4,
                Base = 2,
                Scale = 0.02
            }
        }
    },
    ["Rainbow Bumble Pollinator"] = {
        Description = "Every <Cooldown>m, flies to a nearby fruit and pollinates it, applying Pollinated mutation!",
        States = {
            Cooldown = {
                Min = 40,
                Base = 500,
                Scale = -4.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Beeler Healer"] = {
        Description = "Every <Cooldown>m, grabs a Pollinated fruit (Ignores favorited) and gives it to another Pet. The pet gets either <XPAmount> XP or <HungerAmount>% restored hunger!",
        States = {
            Cooldown = {
                Min = 170,
                Base = 340,
                Scale = -5.4,
                Formatter = "ColonTime"
            },
            XPAmount = {
                Max = 1200,
                Base = 600,
                Scale = 4
            },
            HungerAmount = {
                Max = 0.4,
                Base = 0.2,
                Scale = 0.012,
                Formatter = "Percentage"
            }
        }
    },
    ["Rainbow Beetanist"] = {
        Description = "Every <Cooldown>m, transfers Pollinated mutation from a fruit (Ignores favorited) to <FruitAmount> other random fruits! The plants that have these fruits advance growth by <AdvancementAmount>m!",
        States = {
            Cooldown = {
                Min = 400,
                Base = 800,
                Scale = -10,
                Formatter = "ColonTime"
            },
            FruitAmount = {
                Max = 8,
                Base = 4,
                Scale = 0.03
            },
            AdvancementAmount = {
                Max = 1160,
                Base = 680,
                Scale = 4.8,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Beelemental"] = {
        Description = "Every <Cooldown>m, mutates a random fruit in your garden with Frozen, Windstruck, Verdant or Flaming!",
        States = {
            Cooldown = {
                Min = 230,
                Base = 460,
                Scale = -6.6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow For the Empress"] = {
        Description = "Every <Cooldown>m, refreshes the ability cooldowns for <AmountPets> random pets! Cannot be mimicked or refreshed",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -7.2,
                Formatter = "ColonTime"
            },
            AmountPets = {
                Max = 4,
                Base = 2,
                Scale = 0.02
            }
        }
    },
    ["Bee-raniac"] = {
        Description = "All active Bee type pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Base = 1,
                Scale = 0.1
            }
        }
    },
    ["Hive Workshop"] = {
        Description = "Every <Cooldown>m, Occasionally converts a Pollinated or HoneyGlazed fruit into a bee castle-themed cosmetic.",
        States = {
            Cooldown = {
                Min = 240,
                Base = 480,
                Scale = -4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Honey Lover"] = {
        Description = "Every <Cooldown>m, consumes a fruit with HoneyGlazed or Pollinated then either spreads it to other <FruitAmount> fruits or restores <HungerAmount>% hunger to another pet in your garden! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 250,
                Base = 500,
                Scale = -5,
                Formatter = "ColonTime"
            },
            FruitAmount = {
                Max = 4,
                Base = 2,
                Scale = 0.02
            },
            HungerAmount = {
                Max = 0.3,
                Base = 0.15,
                Scale = 0.015,
                Formatter = "Percentage"
            }
        }
    },
    ["Prince Stinger"] = {
        Description = "Every <Cooldown>m, stings a random pet and advances its ability cooldown by <Amount>s! There is a <Chance>% for it to sting again each time!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 602,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Amount = {
                Base = 60,
                Scale = 0.6
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.05
            }
        }
    },
    ["King Pollinator"] = {
        Description = "Every <Cooldown>m, <FruitAmount> random fruits get the Pollinated mutation!",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1200,
                Scale = -12,
                Formatter = "ColonTime"
            },
            FruitAmount = {
                Max = 12,
                Base = 6,
                Scale = 0.06
            }
        }
    },
    ["For the King"] = {
        Description = "Every <Cooldown>m, all Pollinated fruits (Max 50) in your garden have a <Chance>% chance to also get the Honeygem mutation. For every fruit mutated: grants bonus <AmountXP> XP to all pets and grows 8 random plants by <AdvancementAmount>s!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 602,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            },
            AmountXP = {
                Max = 400,
                Base = 200,
                Scale = 0.6
            },
            AdvancementAmount = {
                Max = 160,
                Base = 80,
                Scale = 0.3,
                Formatter = "ColonTime"
            }
        }
    },
    ["Blend In"] = {
        Description = "Leafy type plants within <Range> studs have <Multiplier>x increased growth size!",
        States = {
            Range = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            },
            Multiplier = {
                Max = 0.32,
                Base = 0.16,
                Scale = 0.016
            }
        }
    },
    ["Resplendent Bird"] = {
        Description = "Every <Cooldown>m, <Chance>% chance to mutate a nearby fruit, applying the Resplendent mutation!",
        States = {
            Cooldown = {
                Min = 150,
                Base = 300,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            }
        }
    },
    ["Solitary Monitary"] = {
        Description = "If there’s only 1 Monitor Lizard in your garden: Every <Cooldown>m, eats a mutated fruit. For <Duration>s, each mutation (Max 15) boosts all pet cooldowns an extra <AmountPet>s every second and plant growth <AmountPlant>s every second! Ignores favorited",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            },
            AmountPet = {
                Max = 1,
                Base = 0.5,
                Scale = 0.005
            },
            AmountPlant = {
                Max = 10,
                Base = 5,
                Scale = 0.05
            }
        }
    },
    ["Conversion of Nature"] = {
        Description = "Every <Cooldown>m, converts all Verdant or Resplendent mutation within <Range> studs to Sylvan mutation. For every mutation converted: <XPAmount> XP is added to all other pets in your garden. (Max 12,000 XP) Ignores favorited fruit",
        States = {
            Cooldown = {
                Min = 270,
                Base = 540,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            },
            XPAmount = {
                Max = 1000,
                Base = 500,
                Scale = 50
            }
        }
    },
    ["Nature Diety"] = {
        Description = "When selling Fruits with Sylvan Mutation, <Chance>% chance a random mutation from that fruit will be applied to the fruits in your garden!",
        States = {
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.1
            }
        }
    },
    ["GIANT Blend In"] = {
        Description = "Leafy type plants within <Range> studs have <Multiplier>x increased growth size!",
        States = {
            Range = {
                Max = 50,
                Base = 25,
                Scale = 0.2
            },
            Multiplier = {
                Max = 0.64,
                Base = 0.32,
                Scale = 0.032
            }
        }
    },
    ["GIANT Resplendent Bird"] = {
        Description = "Every <Cooldown>m, <Chance>% chance to mutate a nearby fruit, applying the Resplendent mutation!",
        States = {
            Cooldown = {
                Min = 100,
                Base = 200,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.15
            }
        }
    },
    ["Rainbow Solitary Monitary"] = {
        Description = "If there’s only 1 Monitor Lizard in your garden: Every <Cooldown>m, eats a mutated fruit. For <Duration>s, each mutation (Max 15) boosts all pet cooldowns an extra <AmountPet>s every second and plant growth <AmountPlant>s every second! Ignores favorited",
        States = {
            Cooldown = {
                Min = 250,
                Base = 500,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 24,
                Base = 12,
                Scale = 0.1
            },
            AmountPet = {
                Max = 1.2,
                Base = 0.6,
                Scale = 0.005
            },
            AmountPlant = {
                Max = 14,
                Base = 7,
                Scale = 0.05
            }
        }
    },
    ["Rainbow Conversion of Nature"] = {
        Description = "Every <Cooldown>m, converts all Verdant or Resplendent mutation within <Range> studs to Sylvan mutation. For every mutation converted: <XPAmount> XP is added to all other pets in your garden. (Max 12,000 XP) Ignores favorited fruit",
        States = {
            Cooldown = {
                Min = 210,
                Base = 420,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 80,
                Base = 40,
                Scale = 0.3
            },
            XPAmount = {
                Max = 1400,
                Base = 700,
                Scale = 50
            }
        }
    },
    ["Rainbow Nature Diety"] = {
        Description = "When selling Fruits with Sylvan Mutation, <Chance>% chance a random mutation from that fruit will be applied to the fruits in your garden!",
        States = {
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.1
            }
        }
    },
    ["Summer Buzz"] = {
        Description = "Every <Cooldown>m, lands on a plant and begins buzzing. That plant grows an additional <AdvanceSeconds>s every second for <Duration>s!",
        States = {
            Cooldown = {
                Min = 360,
                Base = 720,
                Scale = -7.2,
                Formatter = "ColonTime"
            },
            AdvanceSeconds = {
                Max = 20,
                Base = 10,
                Scale = 0.1,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 20,
                Base = 10,
                Scale = 0.1,
                Formatter = "ColonTime"
            }
        }
    },
    Renewtal = {
        Description = "<Chance>% chance harvested fruit duplicates! Rarer crops have lower chance to duplicate.",
        States = {
            Chance = {
                Max = 16,
                Base = 8,
                Scale = 0.08
            }
        }
    },
    ["Summer Harvester"] = {
        Description = "<Chance>% extra chance for Summer type fruit to duplicate!",
        States = {
            Chance = {
                Max = 10,
                Base = 5,
                Scale = 0.05
            }
        }
    },
    ["Call of the Night"] = {
        Description = "Every <Cooldown>m, consumes a fruit with Moonlit mutation and applies Small XP Boost and Small Passive Boost to a random pet in your garden. If the fruit consumed also has Bloodlit: Applies a Large Passive Boost instead. Ignores favorited",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1000,
                Scale = -5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Heart of Fire"] = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Ember! Cannot be mimicked or refreshed",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1000,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 10,
                Base = 5,
                Scale = 0.05
            }
        }
    },
    Fireheart = {
        Description = "Every <Cooldown>m, has a <Chance>% chance to apply the Ember Pet Mutation to a age 100+ pet. If successful: Reduces age by 100, otherwise reduces age by 50. Cannot be mimicked or refreshed",
        States = {
            Cooldown = {
                Min = 1000,
                Base = 1800,
                Scale = -18,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 6,
                Base = 3,
                Scale = 0.03
            }
        }
    },
    ["Rainbow Summer Buzz"] = {
        Description = "Every <Cooldown>m, lands on a plant and begins buzzing. That plant grows an additional <AdvanceSeconds>s every second for <Duration>s!",
        States = {
            Cooldown = {
                Min = 250,
                Base = 500,
                Scale = -7.2,
                Formatter = "ColonTime"
            },
            AdvanceSeconds = {
                Max = 24,
                Base = 12,
                Scale = 0.1,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 24,
                Base = 12,
                Scale = 0.1,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Renewtal"] = {
        Description = "<Chance>% chance harvested fruit duplicates! Rarer crops have lower chance to duplicate.",
        States = {
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.08
            }
        }
    },
    ["Rainbow Summer Harvester"] = {
        Description = "<Chance>% extra chance for Summer type fruit to duplicate!",
        States = {
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.05
            }
        }
    },
    ["Rainbow Call of the Night"] = {
        Description = "Every <Cooldown>m, consumes a fruit with Moonlit mutation and applies Small XP Boost and Small Passive Boost to a random pet in your garden. If the fruit consumed also has Bloodlit: Applies a Large Passive Boost instead. Ignores favorited",
        States = {
            Cooldown = {
                Min = 400,
                Base = 800,
                Scale = -5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Heart of Fire"] = {
        Description = "Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Ember! Cannot be mimicked or refreshed",
        States = {
            Cooldown = {
                Min = 400,
                Base = 800,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 16,
                Base = 8,
                Scale = 0.08
            }
        }
    },
    ["Rainbow Fireheart"] = {
        Description = "Every <Cooldown>m, has a <Chance>% chance to apply the Ember Pet Mutation to a age 100+ pet. If successful: Reduces age by 100, otherwise reduces age by 50. Cannot be mimicked or refreshed",
        States = {
            Cooldown = {
                Min = 800,
                Base = 1500,
                Scale = -18,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 10,
                Base = 5,
                Scale = 0.03
            }
        }
    },
    ["Flame On"] = {
        Description = "Every <Cooldown>m, flings a fireball towards a random pet, restoring <Amount>% hunger and granting <AmountXP> XP!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 0.5,
                Base = 0.01,
                Scale = 0.001,
                Formatter = "Percentage"
            },
            AmountXP = {
                Max = 1600,
                Base = 800,
                Scale = 8
            }
        }
    },
    ["Shadow Nap"] = {
        Description = "Every <Cooldown>m, <Chance>% chance nearby fruit gets Shadow mutation!",
        States = {
            Cooldown = {
                Min = 150,
                Base = 300,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 25,
                Base = 12.5,
                Scale = 1.25
            }
        }
    },
    ["Shark Bite"] = {
        Description = "Every <Cooldown>m, eats another age 100+ pet with a pet mutation, then spits the pet mutation at another pet and has a <Chance>% chance to apply it. If it fails it will increase its age by <AgeAmount> instead.",
        States = {
            Cooldown = {
                Min = 720,
                Base = 1440,
                Scale = -7.2,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            },
            AgeAmount = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            }
        }
    },
    ["Canary Call"] = {
        Description = "Every <Cooldown>m, a random plant in your garden grows by <AdvanceSeconds>s for every Canary in your garden!",
        States = {
            Cooldown = {
                Min = 360,
                Base = 720,
                Scale = -7,
                Formatter = "ColonTime"
            },
            AdvanceSeconds = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["ZAP!"] = {
        Description = "Every <Cooldown>m, zaps another pet, removing any boosts, but has a <Chance>% chance to increase level by 1, otherwise decreases level by 2 but applies a Medium Passive Boost instead.",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["Lightning Dash"] = {
        Description = "Every <Cooldown>m, grants you lightning dash powers, increasing movement speed by <SpeedBoost>%, for <Duration>s, any fruit passed has a <Chance>% chance to be mutated with Static. If already has Static, mutates with Shocked instead!",
        States = {
            Cooldown = {
                Min = 250,
                Base = 500,
                Scale = -4,
                Formatter = "ColonTime"
            },
            SpeedBoost = {
                Max = 100,
                Base = 50,
                Scale = 0.5
            },
            Duration = {
                Max = 45,
                Base = 25,
                Scale = 0.25
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            }
        }
    },
    ["Wings of Thunder"] = {
        Description = "Every <Cooldown>m spreads it wings and releases lightning at <Number> other random pets, advancing cooldown by <AmountCD> OR granting <AmountXP> xp!",
        States = {
            Cooldown = {
                Min = 450,
                Base = 900,
                Scale = -7,
                Formatter = "ColonTime"
            },
            Number = {
                Max = 10,
                Base = 5,
                Scale = 0.04
            },
            AmountCD = {
                Max = 80,
                Base = 40,
                Scale = 0.4
            },
            AmountXP = {
                Max = 1600,
                Base = 800,
                Scale = 8
            }
        }
    },
    ["Lightning Diety"] = {
        Description = "When selling Fruits with Shocked Mutation, <Chance>% chance a random mutation from that fruit will be applied to the fruits in your garden!",
        States = {
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.1
            }
        }
    },
    ["GIANT Canary Call"] = {
        Description = "Every <Cooldown>m, a random plant in your garden grows by <AdvanceSeconds>s for every Canary in your garden!",
        States = {
            Cooldown = {
                Min = 260,
                Base = 520,
                Scale = -7,
                Formatter = "ColonTime"
            },
            AdvanceSeconds = {
                Max = 30,
                Base = 15,
                Scale = 0.1
            }
        }
    },
    ["GIANT ZAP!"] = {
        Description = "Every <Cooldown>m, zaps another pet, removing any boosts, but has a <Chance>% chance to increase level by 1, otherwise decreases level by 2 but applies a Medium Passive Boost instead.",
        States = {
            Cooldown = {
                Min = 225,
                Base = 450,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.1
            }
        }
    },
    ["Rainbow Lightning Dash"] = {
        Description = "Every <Cooldown>m, grants you lightning dash powers, increasing movement speed by <SpeedBoost>%, for <Duration>s, any fruit passed has a <Chance>% chance to be mutated with Static. If already has Static, mutates with Shocked instead!",
        States = {
            Cooldown = {
                Min = 150,
                Base = 300,
                Scale = -4,
                Formatter = "ColonTime"
            },
            SpeedBoost = {
                Max = 120,
                Base = 60,
                Scale = 0.5
            },
            Duration = {
                Max = 70,
                Base = 35,
                Scale = 0.25
            },
            Chance = {
                Max = 50,
                Base = 25,
                Scale = 0.15
            }
        }
    },
    ["Rainbow Wings of Thunder"] = {
        Description = "Every <Cooldown>m spreads it wings and releases lightning at <Number> other random pets, advancing cooldown by <AmountCD> OR granting <AmountXP> xp!",
        States = {
            Cooldown = {
                Min = 350,
                Base = 700,
                Scale = -7,
                Formatter = "ColonTime"
            },
            Number = {
                Max = 12,
                Base = 6,
                Scale = 0.04
            },
            AmountCD = {
                Max = 90,
                Base = 50,
                Scale = 0.4
            },
            AmountXP = {
                Max = 1700,
                Base = 900,
                Scale = 8
            }
        }
    },
    ["Rainbow Lightning Diety"] = {
        Description = "When selling Fruits with Shocked Mutation, <Chance>% chance a random mutation from that fruit will be applied to the fruits in your garden!",
        States = {
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.1
            }
        }
    },
    ["Hooves of Freedom"] = {
        Description = "Every <Cooldown>m, charges into <Amount> random plants and advance their growth by <GrowthAmount>m! Fruits on that plant, if any also get the Firework mutation! Has a <Chance>% chance to do it again each time.",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 8,
                Base = 4,
                Scale = 0.04
            },
            GrowthAmount = {
                Max = 6000,
                Base = 3000,
                Scale = 15,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.1
            }
        }
    },
    ["Tide Pool"] = {
        Description = "All active Summer type pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Max = 4,
                Base = 2,
                Scale = 0.1
            }
        }
    },
    ["Bubble Beam"] = {
        Description = "Every <Cooldown>m, consumes a random fruit in your garden (Ignores favorited) to apply the Tidal mutation!",
        States = {
            Cooldown = {
                Min = 420,
                Base = 840,
                Scale = -8.4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Hermit Pinch"] = {
        Description = "Every <Cooldown>m, pinches a random pet, plant, or shop NPC, granting a Medium Passive Boost, advancing growth by <Amount>m, or restocking a random item, respectively.",
        States = {
            Cooldown = {
                Min = 510,
                Base = 1020,
                Scale = -10.2,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 3600,
                Base = 1800,
                Scale = 18,
                Formatter = "ColonTime"
            }
        }
    },
    ["Orca Zone"] = {
        Description = "Every <Cooldown>m, all pets within <Radius> stud range get <XPAmount> xp. There is a <Chance>% chance the pet ages up by 1 or advances cooldown by <CooldownAmount>s instead.",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1212,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Radius = {
                Max = 45,
                Base = 30,
                Scale = 0.3
            },
            XPAmount = {
                Max = 2000,
                Base = 1000,
                Scale = 10
            },
            Chance = {
                Max = 6,
                Base = 3,
                Scale = 0.02
            },
            CooldownAmount = {
                Max = 120,
                Base = 60,
                Scale = 0.5
            }
        }
    },
    ["Tidal Tide Pool"] = {
        Description = "All active Summer type pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Max = 8,
                Base = 4,
                Scale = 0.1
            }
        }
    },
    ["Tidal Bubble Beam"] = {
        Description = "Every <Cooldown>m, consumes a random fruit in your garden (Ignores favorited) to apply the Tidal mutation!",
        States = {
            Cooldown = {
                Min = 320,
                Base = 640,
                Scale = -8.4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Tidal Hermit Pinch"] = {
        Description = "Every <Cooldown>m, pinches a random pet, plant, or shop NPC, granting a Medium Passive Boost, advancing growth by <Amount>m, or restocking a random item, respectively.",
        States = {
            Cooldown = {
                Min = 410,
                Base = 820,
                Scale = -10.2,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 4000,
                Base = 2000,
                Scale = 18,
                Formatter = "ColonTime"
            }
        }
    },
    ["Tidal Orca Zone"] = {
        Description = "Every <Cooldown>m, all pets within <Radius> stud range get <XPAmount> xp. There is a <Chance>% chance the pet ages up by 1 or advances cooldown by <CooldownAmount>s instead.",
        States = {
            Cooldown = {
                Min = 450,
                Base = 912,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Radius = {
                Max = 50,
                Base = 35,
                Scale = 0.3
            },
            XPAmount = {
                Max = 2400,
                Base = 1200,
                Scale = 10
            },
            Chance = {
                Max = 8,
                Base = 4,
                Scale = 0.02
            },
            CooldownAmount = {
                Max = 150,
                Base = 75,
                Scale = 0.5
            }
        }
    },
    ["Urchin Searchin"] = {
        Description = "Every <Cooldown>m, converts a fruit with at least 2 mutations (Ignores favorited) into <XPAmount> XP and is applied to a random pet in your garden!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -6,
                Formatter = "ColonTime"
            },
            XPAmount = {
                Max = 400,
                Base = 200,
                Scale = 2
            }
        }
    },
    ["Catch of the Day"] = {
        Description = "Every <Cooldown>m, converts a random Non-summer type fruit in your garden (Ignores favorited) into Summer type fruit of the same rarity and gives it to you!",
        States = {
            Cooldown = {
                Min = 404,
                Base = 808,
                Scale = -8,
                Formatter = "ColonTime"
            }
        }
    },
    ["Blubber Forager"] = {
        Description = "Every <Cooldown>m, rewards you with 1 of 4 random gears or mutates a fruit in your garden with a 1 of 4 summer type mutations. Rarer gears and rarer mutations have rarer chance!",
        States = {
            Cooldown = {
                Min = 350,
                Base = 707,
                Scale = -7,
                Formatter = "ColonTime"
            }
        }
    },
    ["Ray of Renewal"] = {
        Description = "Every <Cooldown>m, swims and glides over <FruitAmount> different fruit in your garden. Those fruits gain Wet or Tidal mutation, along the way all pets passed gain <XPAmount> XP and plants passed advanced growth by <AdvancementAmount>m!",
        States = {
            Cooldown = {
                Min = 700,
                Base = 1400,
                Scale = -14,
                Formatter = "ColonTime"
            },
            FruitAmount = {
                Max = 8,
                Base = 4,
                Scale = 0.04
            },
            XPAmount = {
                Max = 2000,
                Base = 1000,
                Scale = 10
            },
            AdvancementAmount = {
                Max = 2400,
                Base = 1200,
                Scale = 12,
                Formatter = "ColonTime"
            }
        }
    },
    ["Sandcastle Summer"] = {
        Description = "Every <Cooldown>m, goes to a random fruit with Sandy and/or Tidal mutation and converts it into a random Sandcastle cosmetic! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 420,
                Base = 840,
                Scale = -8.4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Jelly Sting"] = {
        Description = "Every <Cooldown>m, stings a fruit or pet in your garden. Fruits have a <Chance>% chance to gain Static, Tidal, and Shocked; otherwise, loses 1 random mutation. Pets have a <Chance>% chance to gain <AmountXP> XP and advance cooldown by <CooldownAdvancement>m; otherwise, it loses 1 level.",
        States = {
            Cooldown = {
                Min = 420,
                Base = 840,
                Scale = -8.4,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 50,
                Base = 25,
                Scale = 0.2
            },
            AmountXP = {
                Max = 2000,
                Base = 1000,
                Scale = 10
            },
            CooldownAdvancement = {
                Max = 260,
                Base = 130,
                Scale = 1.3,
                Formatter = "ColonTime"
            }
        }
    },
    ["Tidebound Steed"] = {
        Description = "Every <Cooldown>m, channels a current for <Duration>s. Pets within <Radius> studs gain an additional <XPAmount> XP/s and advance cooldowns 1 second every second. Fruits have a <Chance>% chance to gain the Sandy mutation. Fruits that are already Sandy get Tidal, and fruits that are already Tidal turn Gold.",
        States = {
            Cooldown = {
                Min = 950,
                Base = 1900,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            },
            Radius = {
                Max = 45,
                Base = 30,
                Scale = 0.3
            },
            XPAmount = {
                Max = 180,
                Base = 90,
                Scale = 9
            },
            Chance = {
                Max = 7,
                Base = 3.5,
                Scale = 0.035
            }
        }
    },
    ["Living Fossil"] = {
        Description = "Every <Cooldown>m, adds <AddedAmount>s hatch time to a random egg but advances hatch time for another egg by <AdvancedAmount>m!",
        States = {
            Cooldown = {
                Min = 70,
                Base = 140,
                Scale = -1.4,
                Formatter = "ColonTime"
            },
            AddedAmount = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            },
            AdvancedAmount = {
                Max = 160,
                Base = 80,
                Scale = 0.8,
                Formatter = "ColonTime"
            }
        }
    },
    ["Dolphin\'s Grace"] = {
        Description = "Every <Cooldown>m, transforms you into a Dolphin with <MovementSpeedBonus>% movement speed and 4x jump height for <Duration>s. Fruits passed during this time have a <Chance>% chance to get the Tidal mutation!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1000,
                Scale = -10,
                Formatter = "ColonTime"
            },
            MovementSpeedBonus = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            },
            Duration = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["Bloodlit Squid"] = {
        Description = "Every <Cooldown>m, a random fruit in the garden gets the Bloodlit mutation!",
        States = {
            Cooldown = {
                Min = 350,
                Base = 707,
                Scale = -7,
                Formatter = "ColonTime"
            }
        }
    },
    ["Squid of the Night"] = {
        Description = "All active Night type pets gain an additional <Chance> XP/s!",
        States = {
            Chance = {
                Max = 4,
                Base = 2,
                Scale = 0.02
            }
        }
    },
    ["Cactus Furnishings"] = {
        Description = "Every <Cooldown>m, converts a Cactus into a 1 of 6 Cactus Furniture cosmetics.",
        States = {
            Cooldown = {
                Min = 150,
                Base = 300,
                Scale = -3,
                Formatter = "ColonTime"
            }
        }
    },
    ["Sprinkler Oasis"] = {
        Description = "Every 10 minutes on the clock: Converts a fruit with at least 1 mutation into a sprinkler from the gear shop. Rarer sprinklers have rarer chance.",
        States = {}
    },
    ["Earth Emperor"] = {
        Description = "Every <Cooldown>m, destroys a fruit (Ignores favorited) with 32+ mutations: Another pet in the garden gains 1 age for every 4 mutations. There is a <Chance>% chance for 1 age gained for every 2 mutations instead!",
        States = {
            Cooldown = {
                Min = 800,
                Base = 1616,
                Scale = -16,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 5,
                Base = 2.5,
                Scale = 0.02
            }
        }
    },
    ["Blessing of the Dunes"] = {
        Description = "Every <Cooldown>m, burrows and travels towards another random pet in the garden. That pet advances Cooldown by <AdvancedCooldown>s and the nearest fruit gets Sandy mutation! There is a <Chance>% the Sand Wyrm travels to another pet each time.",
        States = {
            Cooldown = {
                Min = 1000,
                Base = 2000,
                Scale = -20,
                Formatter = "ColonTime"
            },
            AdvancedCooldown = {
                Max = 400,
                Base = 200,
                Scale = 0.2,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.03
            }
        }
    },
    ["Sand Diety"] = {
        Description = "When selling Fruits with Sandy Mutation, <Chance>% chance a random mutation from that fruit will be applied to the fruits in your garden!",
        States = {
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.1
            }
        }
    },
    ["GIANT Cactus Furnishings"] = {
        Description = "Every <Cooldown>m, converts a Cactus into a 1 of 6 Cactus Furniture cosmetics.",
        States = {
            Cooldown = {
                Min = 100,
                Base = 200,
                Scale = -3,
                Formatter = "ColonTime"
            }
        }
    },
    ["GIANT Sprinkler Oasis"] = {
        Description = "Every 10 minutes on the clock: Converts a fruit with at least 1 mutation into a sprinkler from the gear shop. Rarer sprinklers have rarer chance.",
        States = {}
    },
    ["Rainbow Earth Emperor"] = {
        Description = "Every <Cooldown>m, destroys a fruit (Ignores favorited) with 32+ mutations: Another pet in the garden gains 1 age for every 4 mutations. There is a <Chance>% chance for 1 age gained for every 2 mutations instead!",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1200,
                Scale = -16,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 6,
                Base = 3.5,
                Scale = 0.02
            }
        }
    },
    ["Rainbow Blessing of the Dunes"] = {
        Description = "Every <Cooldown>m, burrows and travels towards another random pet in the garden. That pet advances Cooldown by <AdvancedCooldown>s and the nearest fruit gets Sandy mutation! There is a <Chance>% the Sand Wyrm travels to another pet each time.",
        States = {
            Cooldown = {
                Min = 850,
                Base = 1700,
                Scale = -20,
                Formatter = "ColonTime"
            },
            AdvancedCooldown = {
                Max = 500,
                Base = 250,
                Scale = 0.2,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 14,
                Base = 7,
                Scale = 0.03
            }
        }
    },
    ["Rainbow Sand Diety"] = {
        Description = "When selling Fruits with Sandy Mutation, <Chance>% chance a random mutation from that fruit will be applied to the fruits in your garden!",
        States = {
            Chance = {
                Max = 16,
                Base = 8,
                Scale = 0.1
            }
        }
    },
    ["Moon\'s Blessing"] = {
        Description = "Night type plants within <Range> studs have <Multiplier>x increased growth size!",
        States = {
            Range = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            },
            Multiplier = {
                Max = 0.4,
                Base = 0.2,
                Scale = 0.02
            }
        }
    },
    ["Photobacterium Eclipse"] = {
        Description = "Every <Cooldown>m, bites a fruit and there is a <Chance>% chance it applies the Eclipsed mutation!",
        States = {
            Cooldown = {
                Min = 250,
                Base = 500,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 14,
                Base = 7,
                Scale = 0.07
            }
        }
    },
    ["Photobacterium Aurora"] = {
        Description = "Every <Cooldown>m, bites a fruit and there is a <Chance>% chance it applies the Aurora mutation!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1000,
                Scale = -10,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 10,
                Base = 5,
                Scale = 0.05
            }
        }
    },
    ["Wisdom\'s Ruler"] = {
        Description = "Pets without pet mutations gain additional <XPAmount>% xp of current level every 5 seconds. (Does not stack)",
        States = {
            XPAmount = {
                Max = 0.02,
                Base = 0.01,
                Scale = 0.0001,
                Formatter = "Percentage"
            }
        }
    },
    ["Ruler\'s Wisdom"] = {
        Description = "Every <Cooldown>m, copies all of the mutations from a random fruit. Each mutation has a <Chance>% chance to be applied to another fruit in the garden.",
        States = {
            Cooldown = {
                Min = 350,
                Base = 700,
                Scale = -7,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 3,
                Base = 1.5,
                Scale = 0.015
            }
        }
    },
    ["Rainbow Moon\'s Blessing"] = {
        Description = "Night type plants within <Range> studs have <Multiplier>x increased growth size!",
        States = {
            Range = {
                Max = 50,
                Base = 25,
                Scale = 0.2
            },
            Multiplier = {
                Max = 0.45,
                Base = 0.25,
                Scale = 0.02
            }
        }
    },
    ["Rainbow Photobacterium Eclipse"] = {
        Description = "Every <Cooldown>m, bites a fruit and there is a <Chance>% chance it applies the Eclipsed mutation!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 400,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 18,
                Base = 9,
                Scale = 0.07
            }
        }
    },
    ["Rainbow Photobacterium Aurora"] = {
        Description = "Every <Cooldown>m, bites a fruit and there is a <Chance>% chance it applies the Aurora mutation!",
        States = {
            Cooldown = {
                Min = 400,
                Base = 800,
                Scale = -10,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 14,
                Base = 7,
                Scale = 0.05
            }
        }
    },
    ["Rainbow Wisdom\'s Ruler"] = {
        Description = "Pets without pet mutations gain additional <XPAmount>% xp of current level every 5 seconds. (Does not stack)",
        States = {
            XPAmount = {
                Max = 0.03,
                Base = 0.015,
                Scale = 0.0001,
                Formatter = "Percentage"
            }
        }
    },
    ["Rainbow Ruler\'s Wisdom"] = {
        Description = "Every <Cooldown>m, copies all of the mutations from a random fruit. Each mutation has a <Chance>% chance to be applied to another fruit in the garden.",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -7,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 4,
                Base = 2,
                Scale = 0.015
            }
        }
    },
    ["Night Support"] = {
        Description = "When Night type pets finish their abilities, they start their cooldown with <Chance> seconds less!",
        States = {
            Chance = {
                Max = 10,
                Base = 5,
                Scale = 0.1
            }
        }
    },
    Moonsong = {
        Description = "Every <Cooldown>m, sings for <Duration>s, all plants within <Radius> studs will advance growth an extra <AdvancementAmount>s every second! Pets within range also get <HungerAmount>% hunger restored every second!",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1212,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 16,
                Base = 8,
                Scale = 0.1,
                Formatter = "ColonTime"
            },
            Radius = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            },
            AdvancementAmount = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            },
            HungerAmount = {
                Max = 0.1,
                Base = 0.05,
                Scale = 0.0005,
                Formatter = "Percentage"
            }
        }
    },
    ["Selenic Steed"] = {
        Description = "Every <Cooldown>m, channels magic through 2 random fruits, sacrificing them, (Ignores favorited) to apply the Moonbeam mutation to random fruit in your garden!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 606,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Draconis Luna"] = {
        Description = "Every <Cooldown>m, mutates fruit up to the number of Night type pets in your garden with Moonlit or Moonbeam. Each fruit mutated has a <Chance>% chance each to increase the level of a random pet in the garden by 1! Cannot be mimicked or refreshed.",
        States = {
            Cooldown = {
                Min = 650,
                Base = 1313,
                Scale = -13,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 8,
                Base = 4,
                Scale = 0.4
            }
        }
    },
    ["Starry Night Support"] = {
        Description = "When Night type pets finish their abilities, they start their cooldown with <Chance> seconds less!",
        States = {
            Chance = {
                Max = 14,
                Base = 7,
                Scale = 0.1
            }
        }
    },
    ["Starry Moonsong"] = {
        Description = "Every <Cooldown>m, sings for <Duration>s, all plants within <Radius> studs will advance growth an extra <AdvancementAmount>s every second! Pets within range also get <HungerAmount>% hunger restored every second!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1000,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 20,
                Base = 10,
                Scale = 0.1,
                Formatter = "ColonTime"
            },
            Radius = {
                Max = 50,
                Base = 25,
                Scale = 0.2
            },
            AdvancementAmount = {
                Max = 30,
                Base = 15,
                Scale = 0.1
            },
            HungerAmount = {
                Max = 0.16,
                Base = 0.08,
                Scale = 0.0005,
                Formatter = "Percentage"
            }
        }
    },
    ["Starry Selenic Steed"] = {
        Description = "Every <Cooldown>m, channels magic through 2 random fruits, sacrificing them, (Ignores favorited) to apply the Moonbeam mutation to random fruit in your garden!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 400,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Starry Draconis Luna"] = {
        Description = "Every <Cooldown>m, mutates fruit up to the number of Night type pets in your garden with Moonlit or Moonbeam. Each fruit mutated has a <Chance>% chance each to increase the level of a random pet in the garden by 1! Cannot be mimicked or refreshed.",
        States = {
            Cooldown = {
                Min = 550,
                Base = 1100,
                Scale = -13,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.4
            }
        }
    },
    ["Wheat Flock"] = {
        Description = "Every <Cooldown>m, <Amount> random plants advance <GrowthAmount>s for every Wheat Crow in your garden.",
        States = {
            Cooldown = {
                Min = 340,
                Base = 540,
                Scale = -5.6,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 12,
                Base = 6,
                Scale = 0.06
            },
            GrowthAmount = {
                Max = 80,
                Base = 40,
                Scale = 0.5
            }
        }
    },
    ["Harvest Smash"] = {
        Description = "Every <Cooldown>m, smashes a <Radius> stud area near a random plant. Within that area, all plants grow an additional <Amount>m and <AmountFruit> random fruit (Ignores favorited) get collected. Each fruit has a <Chance>% chance to stay on the plant.",
        States = {
            Cooldown = {
                Min = 500,
                Base = 900,
                Scale = -10,
                Formatter = "ColonTime"
            },
            Radius = {
                Max = 36,
                Base = 18,
                Scale = 0.18
            },
            Amount = {
                Max = 3600,
                Base = 1800,
                Scale = 10,
                Formatter = "ColonTime"
            },
            AmountFruit = {
                Max = 200,
                Base = 99,
                Scale = 1
            },
            Chance = {
                Max = 16,
                Base = 8,
                Scale = 0.03
            }
        }
    },
    ["Corn Synergy"] = {
        Description = "Every <Cooldown>m, transfers all mutations on a fruit (Ignores favorited) to a fruit with no mutation. There is a <Chance>% chance that each mutation stays on the original fruit for every Corn (Max 50) planted in your garden! Cannot be mimicked.",
        States = {
            Cooldown = {
                Min = 400,
                Base = 800,
                Scale = -7,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 1,
                Base = 0.5,
                Scale = 0.01
            }
        }
    },
    ["Wooly Blizzard"] = {
        Description = "Every <Cooldown>m, <Amount> different fruit in your garden have a <Chance>% get Chilled. If already Chilled, gets Frozen instead. For each Chilled fruit, all pets gain <XPAmount>XP. XP gain is doubled if Frozen was applied.",
        States = {
            Cooldown = {
                Min = 900,
                Base = 1800,
                Scale = -18,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            },
            Amount = {
                Max = 50,
                Base = 25,
                Scale = 0.25
            },
            XPAmount = {
                Max = 20000,
                Base = 10000,
                Scale = 15
            }
        }
    },
    ["Bean Support Growth"] = {
        Description = "Beanstalks within <Range> studs have <Multiplier>x increased growth speed!",
        States = {
            Multiplier = {
                Max = 3,
                Base = 1.5,
                Scale = 0.15
            },
            Range = {
                Max = 70,
                Base = 35,
                Scale = 0.35
            }
        }
    },
    ["Bean Support Size"] = {
        Description = "Beanstalks within <Range> studs have <Multiplier>x increased growth size!",
        States = {
            Range = {
                Max = 70,
                Base = 35,
                Scale = 0.35
            },
            Multiplier = {
                Max = 0.7,
                Base = 0.35,
                Scale = 0.035
            }
        }
    },
    ["Snake Stalk"] = {
        Description = "Every <Cooldown>m, converts a Legendary or higher rarity random fruit (Ignores favorited) in your garden into a Beanstalk and gives it to you!",
        States = {
            Cooldown = {
                Min = 210,
                Base = 420,
                Scale = -4.2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Cloudtouched Sprite"] = {
        Description = "Every <Cooldown>m, advances growth for a plant by <Amount>s! Then each fruit on that plant has a <Chance>% chance to get the Cloudtouched mutation!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 4800,
                Base = 2400,
                Scale = 12,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    Frabjous = {
        Description = "Every <Cooldown>m, destroys a Beanstalk plant in your garden (Ignores plants with favorited fruit) and then for every fruit on that plant, that many plants grow by <AdvancedAmount>h, that many fruit have a <Chance>% chance to get Beanbound or levels up that many pets by 1!",
        States = {
            Cooldown = {
                Min = 900,
                Base = 1800,
                Scale = -18,
                Formatter = "ColonTime"
            },
            AdvancedAmount = {
                Max = 14000,
                Base = 7000,
                Scale = 70,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 50,
                Base = 25,
                Scale = 0.25
            }
        }
    },
    ["Rainbow Bean Support Growth"] = {
        Description = "Beanstalks within <Range> studs have <Multiplier>x increased growth speed!",
        States = {
            Multiplier = {
                Max = 3.5,
                Base = 1.75,
                Scale = 0.15
            },
            Range = {
                Max = 80,
                Base = 40,
                Scale = 0.35
            }
        }
    },
    ["Rainbow Bean Support Size"] = {
        Description = "Beanstalks within <Range> studs have <Multiplier>x increased growth size!",
        States = {
            Range = {
                Max = 80,
                Base = 40,
                Scale = 0.35
            },
            Multiplier = {
                Max = 0.85,
                Base = 0.45,
                Scale = 0.035
            }
        }
    },
    ["Rainbow Snake Stalk"] = {
        Description = "Every <Cooldown>m, converts a random fruit in your garden into a Beanstalk and gives it to you!",
        States = {
            Cooldown = {
                Min = 220,
                Base = 440,
                Scale = -4.4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Cloudtouched Sprite"] = {
        Description = "Every <Cooldown>m, advances growth for a plant by <Amount>s! Then each fruit on that plant has a <Chance>% chance to get the Cloudtouched mutation!",
        States = {
            Cooldown = {
                Min = 250,
                Base = 500,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 6000,
                Base = 3000,
                Scale = 12,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.1
            }
        }
    },
    ["Rainbow Frabjous"] = {
        Description = "Every <Cooldown>m, destroys a Beanstalk plant in your garden (Ignores plants with favorited fruit) and then for every fruit on that plant, that many plants grow by <AdvancedAmount>h, that many fruit have a <Chance>% chance to get Beanbound or levels up that many pets by 1!",
        States = {
            Cooldown = {
                Min = 750,
                Base = 1500,
                Scale = -18,
                Formatter = "ColonTime"
            },
            AdvancedAmount = {
                Max = 18000,
                Base = 9000,
                Scale = 70,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 70,
                Base = 35,
                Scale = 0.25
            }
        }
    },
    ["Wool Produce"] = {
        Description = "Every <Cooldown>m, eats a random fruit without any mutations (Ignores favorited) and has a <Chance>% chance to produce Wool that is around <KGAmount>kg which you can sell!",
        States = {
            Cooldown = {
                Min = 350,
                Base = 700,
                Scale = -7,
                Formatter = "ColonTime"
            },
            KGAmount = {
                Max = 10,
                Base = 5,
                Scale = 0.05
            },
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.12
            }
        }
    },
    ["Cloud Absorption"] = {
        Description = "Every <Cooldown>m, absorbs fruit with Cloudtouched mutation (Ignores favorited) and advances the cooldown of a random pet by <CooldownAmount>m! There is a <Chance>% chance it absorbs 3 fruits at a time and refreshes cooldowns instead!",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1200,
                Scale = -12,
                Formatter = "ColonTime"
            },
            CooldownAmount = {
                Max = 480,
                Base = 240,
                Scale = 2.4,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 18,
                Base = 9,
                Scale = 0.09
            }
        }
    },
    ["Mimic\'s Bite"] = {
        Description = "Every <Cooldown>m, eats a Chest from your inventory (Ignores Premium/Exotic Chests) for a <Chance>% chance to level up a pet by 1!",
        States = {
            Cooldown = {
                Min = 700,
                Base = 1400,
                Scale = -14,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            }
        }
    },
    ["Rainbow Wool Produce"] = {
        Description = "Every <Cooldown>m, eats a random fruit without any mutations (Ignores favorited) and has a <Chance>% chance to produce Wool that is around base <KGAmount>kg which you can sell!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -7,
                Formatter = "ColonTime"
            },
            KGAmount = {
                Max = 14,
                Base = 7,
                Scale = 0.05
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.12
            }
        }
    },
    ["Rainbow Cloud Absorption"] = {
        Description = "Every <Cooldown>m, absorbs a fruit with Cloudtouched mutation (Ignores favorited) and advances the cooldown of a random pet by <CooldownAmount>m! There is a <Chance>% chance it absorbs 3 fruits at a time and refreshes cooldowns instead!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1000,
                Scale = -12,
                Formatter = "ColonTime"
            },
            CooldownAmount = {
                Max = 600,
                Base = 300,
                Scale = 2.4,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 22,
                Base = 11,
                Scale = 0.09
            }
        }
    },
    ["Rainbow Mimic\'s Bite"] = {
        Description = "Every <Cooldown>m, eats a Chest from your inventory (Ignores Premium/Exotic Chests) for a <Chance>% chance to level up a pet by 1!",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1200,
                Scale = -14,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 70,
                Base = 40,
                Scale = 0.3
            }
        }
    },
    ["Bear o Bean"] = {
        Description = "Every <Cooldown>m, consumes a Beanstalk fruit (Ignores favorited) for a <Chance>% chance to give you a Can of Beans!",
        States = {
            Cooldown = {
                Min = 250,
                Base = 500,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 24,
                Base = 12,
                Scale = 0.12
            }
        }
    },
    Torpor = {
        Description = "Night type plants within <Range> studs have <Multiplier>x increased growth speed!",
        States = {
            Multiplier = {
                Max = 3,
                Base = 1.4,
                Scale = 0.1
            },
            Range = {
                Max = 60,
                Base = 32,
                Scale = 0.25
            }
        }
    },
    Bearcat = {
        Description = "Every <Cooldown>m, eats a Berry type fruit to feed a pet for <Amount>% of its hunger!",
        States = {
            Cooldown = {
                Min = 250,
                Base = 500,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 0.06,
                Base = 0.03,
                Scale = 0.002,
                Formatter = "Percentage"
            }
        }
    },
    ["Heavy Sleeper"] = {
        Description = "Every <Cooldown>m, sleeps and removes a fruit (Ignores favorited) with at least 3 mutations to have a <Chance>% chance to apply the Dream mutation!",
        States = {
            Cooldown = {
                Min = 700,
                Base = 1400,
                Scale = -14,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.05
            }
        }
    },
    ["Super Supial"] = {
        Description = "Every <Cooldown>m all pets within <Range> studs gain <XPAmount>XP for every fruit with Dream mutation (Max 50) in your garden! Each Dream mutation has a <Chance>% chance to be removed!",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1200,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            },
            XPAmount = {
                Max = 600,
                Base = 300,
                Scale = 3
            },
            Chance = {
                Min = 5,
                Base = 10,
                Scale = -0.16
            }
        }
    },
    ["Bad Dream"] = {
        Description = "Every <Cooldown>m, reduces level of another pet in the garden by 3 to apply the Nightmare mutation!",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1200,
                Scale = -12,
                Formatter = "ColonTime"
            }
        }
    },
    ["Nightmare Eater"] = {
        Description = "Every <Cooldown>m, devours all fruits (Ingores favorited) with Nightmare mutation. For every fruit devoured: A random pet\'s level has a <Chance>% chance to increase by 1. If a level is increased their cooldown is also refreshed.",
        States = {
            Cooldown = {
                Min = 900,
                Base = 1800,
                Scale = -18,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 8,
                Base = 4,
                Scale = 0.15
            }
        }
    },
    ["GIANT Torpor"] = {
        Description = "Night type plants within <Range> studs have <Multiplier>x increased growth speed!",
        States = {
            Multiplier = {
                Max = 3.5,
                Base = 1.6,
                Scale = 0.1
            },
            Range = {
                Max = 70,
                Base = 40,
                Scale = 0.25
            }
        }
    },
    ["GIANT Bearcat"] = {
        Description = "Every <Cooldown>m, eats a Berry type fruit to feed a pet for <Amount>% of its hunger!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 400,
                Scale = -5,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 0.12,
                Base = 0.06,
                Scale = 0.002,
                Formatter = "Percentage"
            }
        }
    },
    ["Rainbow Heavy Sleeper"] = {
        Description = "Every <Cooldown>m, sleeps and removes a fruit (Ignores favorited) with at least 3 mutations to have a <Chance>% chance to apply the Dream mutation!",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1200,
                Scale = -14,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.05
            }
        }
    },
    ["Rainbow Super Supial"] = {
        Description = "Every <Cooldown>m all pets within <Range> studs gain <XPAmount>XP for every fruit with Dream mutation (Max 50) in your garden! Each Dream mutation has a <Chance>% chance to be removed!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1000,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Range = {
                Max = 50,
                Base = 25,
                Scale = 0.2
            },
            XPAmount = {
                Max = 700,
                Base = 400,
                Scale = 3
            },
            Chance = {
                Min = 3.5,
                Base = 7,
                Scale = -0.16
            }
        }
    },
    ["Rainbow Bad Dream"] = {
        Description = "Every <Cooldown>m, reduces level of another pet in the garden by 3 to apply the Nightmare mutation!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1000,
                Scale = -12,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Nightmare Eater"] = {
        Description = "Every <Cooldown>m, devours all fruits (Ingores favorited) with Nightmare mutation. For every fruit devoured: A random pet\'s level has a <Chance>% chance to increase by 1. If a level is increased their cooldown is also refreshed.",
        States = {
            Cooldown = {
                Min = 750,
                Base = 1500,
                Scale = -18,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.15
            }
        }
    },
    Scarfdigger = {
        Description = "Every <Cooldown>s, has a <Chance>% chance to dig up a random seed! Can dig up Leaf Blowers as well.",
        States = {
            Cooldown = {
                Min = 150,
                Base = 300,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Stink Spray"] = {
        Description = "Every <Cooldown>m, goes to a random player or plant and sprays stink! Players move faster by <MovespeedBonus>% for <Duration>s. Plants grow an additional <GrowthBonus>s every second for <Duration>s!",
        States = {
            Cooldown = {
                Min = 250,
                Base = 500,
                Scale = -5,
                Formatter = "ColonTime"
            },
            MovespeedBonus = {
                Max = 70,
                Base = 35,
                Scale = 0.35
            },
            Duration = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            },
            GrowthBonus = {
                Max = 2,
                Base = 1,
                Scale = 0.01,
                Formatter = "ColonTime"
            }
        }
    },
    ["Llama Drama"] = {
        Description = "Every 20m on the clock, all Llamas run back and forth from the Seed Shop to Gear Shop or vice-versa, and grants you a random Fall-related reward! Has a <Chance>% chance to trigger again on each stampede!",
        States = {
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Everlasting Fall"] = {
        Description = "Every <Cooldown>m, all pets in your garden except Enfields are blessed and have a <Chance>% chance to age up by 1, otherwise lose 3 levels instead. Level 250 pets have a <MutationChance>% chance to get the Everfallen pet mutation and reset level back to 1, otherwise lose 100 levels instead.",
        States = {
            Cooldown = {
                Min = 900,
                Base = 1800,
                Scale = -18,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            },
            MutationChance = {
                Max = 8,
                Base = 4,
                Scale = 0.04
            }
        }
    },
    ["Rainbow Scarfdigger"] = {
        Description = "Every <Cooldown>s, has a <Chance>% chance to dig up a random seed! Can dig up Leaf Blowers as well.",
        States = {
            Cooldown = {
                Min = 100,
                Base = 200,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 45,
                Base = 25,
                Scale = 0.2
            }
        }
    },
    ["Rainbow Stink Spray"] = {
        Description = "Every <Cooldown>m, goes to a random player or plant and sprays stink! Players move faster by <MovespeedBonus>% for <Duration>s. Plants grow an additional <GrowthBonus>s every second for <Duration>s!",
        States = {
            Cooldown = {
                Min = 200,
                Base = 400,
                Scale = -5,
                Formatter = "ColonTime"
            },
            MovespeedBonus = {
                Max = 80,
                Base = 40,
                Scale = 0.35
            },
            Duration = {
                Max = 50,
                Base = 25,
                Scale = 0.2
            },
            GrowthBonus = {
                Max = 3,
                Base = 1.5,
                Scale = 0.01,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rainbow Llama Drama"] = {
        Description = "Every 20m on the clock, all Llamas run back and forth from the Seed Shop to Gear Shop or vice-versa, and grants you a random Fall-related reward! Has a <Chance>% chance to trigger again on each stampede!",
        States = {
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Rainbow Everlasting Fall"] = {
        Description = "Every <Cooldown>m, all pets in your garden except Enfields are blessed and have a <Chance>% chance to age up by 1, otherwise lose 3 levels instead. Level 250 pets have a <MutationChance>% chance to get the Everfallen pet mutation and reset level back to 1, otherwise lose 100 levels instead.",
        States = {
            Cooldown = {
                Min = 800,
                Base = 1500,
                Scale = -18,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 35,
                Base = 20,
                Scale = 0.15
            },
            MutationChance = {
                Max = 10,
                Base = 6,
                Scale = 0.04
            }
        }
    },
    ["Fall Pickings"] = {
        Description = "Every <Cooldown>m, eats a random fully-grown single harvest plant in your garden (Ignores favorited) to apply the Fall mutation or apply a small XP boost to a pet in your garden!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 606,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Farewell Crows"] = {
        Description = "Every <Cooldown>m, makes a Crow pet from your garden fly away (does not come back) to age up a random pet by 1!",
        States = {
            Cooldown = {
                Min = 550,
                Base = 1111,
                Scale = -11,
                Formatter = "ColonTime"
            }
        }
    },
    ["Golden Rascal"] = {
        Description = "Every <Cooldown>m, goes to another player\'s plot and steals (duplicates) a random crop, turns it Gold and gives it to you!",
        States = {
            Cooldown = {
                Min = 60,
                Base = 904.5,
                Scale = -4,
                Formatter = "ColonTime"
            }
        }
    },
    ["Forest Friend"] = {
        Description = "Every <Cooldown>m, advances the growth of a random plant by <AdvancementAmount>s for every Magical plant in your garden +1!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -6,
                Formatter = "ColonTime"
            },
            AdvancementAmount = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Redcap\'s Curse"] = {
        Description = "Every <Cooldown>m, either reduces the level of a pet by 1 to decrease the hatch time of a random egg by <Amount>m or vice-versa! Redcap will gain <XPPercentage>%XP of its current level every time.",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1200,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 2400,
                Base = 1200,
                Scale = 60,
                Formatter = "ColonTime"
            },
            XPPercentage = {
                Max = 24,
                Base = 12,
                Scale = 0.12
            }
        }
    },
    ["Beast of Omen"] = {
        Description = "Every <Cooldown>m, consumes a fruit with 8+ mutations, then has a <Chance>% chance to apply Toxic mutation to a random fruit. Each successful effect triggers another <Chance>% chance to apply the next effect in sequence: Large XP Boost, Large Passive Boost, <XPAmount> XP, then refresh a pet ability. The chain ends when a roll fails.",
        States = {
            Cooldown = {
                Min = 900,
                Base = 1800,
                Scale = -18,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            },
            XPAmount = {
                Max = 24000,
                Base = 12000,
                Scale = 12
            }
        }
    },
    ["Rainbow Forest Friend"] = {
        Description = "Every <Cooldown>m, advances the growth of a random plant by <AdvancementAmount>s for every Magical plant in your garden +1!",
        States = {
            Cooldown = {
                Min = 250,
                Base = 500,
                Scale = -6,
                Formatter = "ColonTime"
            },
            AdvancementAmount = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Rainbow Redcap\'s Curse"] = {
        Description = "Every <Cooldown>m, either reduces the level of a pet by 1 to decrease the hatch time of a random egg by <Amount>m or vice-versa! Redcap will gain <XPPercentage>%XP of its current level every time.",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1000,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 2600,
                Base = 1400,
                Scale = 60,
                Formatter = "ColonTime"
            },
            XPPercentage = {
                Max = 28,
                Base = 14,
                Scale = 0.12
            }
        }
    },
    ["Rainbow Beast of Omen"] = {
        Description = "Every <Cooldown>m, consumes a fruit with 8+ mutations, then has a <Chance>% chance to apply Toxic mutation to a random fruit. Each successful effect triggers another <Chance>% chance to apply the next effect in sequence: Large XP Boost, Large Passive Boost, <XPAmount> XP, then refresh a pet ability. The chain ends when a roll fails.",
        States = {
            Cooldown = {
                Min = 750,
                Base = 1500,
                Scale = -18,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 45,
                Base = 25,
                Scale = 0.2
            },
            XPAmount = {
                Max = 30000,
                Base = 15000,
                Scale = 12
            }
        }
    },
    ["Radioactive Lizard"] = {
        Description = "<Chance>% chance fruit gets Plasma mutation after collecting!",
        States = {
            Chance = {
                Base = 10,
                Scale = 0.2
            }
        }
    },
    ["Scorched Soil"] = {
        Description = "Every <Cooldown>s, <Chance>% chance nearby fruit becomes Burnt!",
        States = {
            Cooldown = {
                Min = 5,
                Base = 80,
                Scale = -1
            },
            Chance = {
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Golden Harvest"] = {
        Description = "<Chance>% chance harvested fruit becomes Gold on harvest! Rarer crops have less chance to turn gold!",
        States = {}
    },
    ["Egg Laying"] = {
        Description = "Every <Cooldown>m, lays a random pet egg from the pet egg shop. Will not lay eggs if you have no free egg equip slot",
        States = {
            Chance = {
                Max = 35,
                Base = 1,
                Scale = 0.1
            },
            Cooldown = {
                Min = 15,
                Base = 15,
                Scale = -18,
                Formatter = "ColonTime"
            }
        }
    },
    ["Helpy Herbivore"] = {
        Description = "Each time you feed a pet, <Chance>% of the hunger points restored are also awarded as experience for that pet! (Only the hunger that is successfully restored counts toward XP).",
        States = {
            Chance = {
                Max = 50,
                Base = 14.65,
                Scale = 0.35
            }
        }
    },
    ["Horsetail Herbivore"] = {
        Description = "Every <Cooldown>m, eats a random fruit in your garden, and has a <Chance>% chance to spit out a Horsetail seed! Ignores favorited fruit.",
        States = {
            Cooldown = {
                Min = 10,
                Base = 82,
                Scale = -1.8
            },
            Chance = {
                Base = 40,
                Scale = 0.8
            }
        }
    },
    ["RAINBOW CHA-CHING"] = {
        Description = "Every <Cooldown>m, has <Chance>% chance to apply the Jackpot mutation!",
        States = {
            Cooldown = {
                Min = 30,
                Base = 220,
                Scale = -1.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 60,
                Base = 30,
                Scale = 0.3
            }
        }
    },
    ["Shocked Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 255, 100)\">SHOCKED: During a Thunderstorm: Every <Cooldown>s, has a <Chance>% chance to attract lightning, shocking nearby fruits!</font>",
        States = {
            Cooldown = {
                Min = 45,
                Base = 60,
                Scale = -0.6
            },
            Chance = {
                Max = 30,
                Base = 25,
                Scale = 0.02
            }
        }
    },
    ["Frozen Pet Mutation"] = {
        Description = "<font color=\"rgb(108, 184, 255)\">FROZEN: Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Frozen!</font>",
        States = {
            Cooldown = {
                Min = 30,
                Base = 300,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 20,
                Scale = 0.03
            }
        }
    },
    ["Windy Pet Mutation"] = {
        Description = "<font color=\"rgb(162, 185, 209)\">WINDY: Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Windstruck!</font>",
        States = {
            Cooldown = {
                Min = 30,
                Base = 300,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 20,
                Scale = 0.03
            }
        }
    },
    ["IronSkin Pet Mutation"] = {
        Description = "<font color=\"rgb(206, 206, 206)\">IRONSKIN: When another player steals fruit from you, grants a <Chance>% chance you get the stolen fruit as well!</font>",
        States = {
            Chance = {
                Max = 45,
                Base = 35,
                Scale = 0.2
            }
        }
    },
    ["Radiant Pet Mutation"] = {
        Description = "<font color=\"rgb(248, 108, 38)\">RADIANT: Every <Cooldown>m, emits sunshine at a random nearby plant and advances their growth by 24 hours!</font>",
        States = {
            Cooldown = {
                Min = 1200,
                Base = 1800,
                Scale = -9,
                Formatter = "ColonTime"
            }
        }
    },
    ["Ascended Pet Mutation"] = {
        Description = "<font color=\"rgb(247, 245, 184)\">ASCENDED: Every <Cooldown>m, a nearby fruit ascends to a higher realm, with a <Chance>% chance to apply the Dawnbound mutation!</font>",
        States = {
            Cooldown = {
                Min = 18000,
                Base = 21621,
                Scale = -21,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 90,
                Base = 75,
                Scale = 0.03
            }
        }
    },
    ["Tiny Pet Mutation"] = {
        Description = "<font color=\"rgb(173, 216, 230)\">TINY: Pet is very tiny! Has 20% slower hunger rate.</font>",
        States = {
            Amount = {
                Base = -0.2,
                Scale = 0
            }
        }
    },
    ["Tiny Pet Mutation Bonus"] = {
        Description = "<font color=\"rgb(173, 216, 230)\">TINY: Gains an additional <Amount> xp per second!</font>",
        States = {
            Amount = {
                Max = 30,
                Base = 5,
                Scale = 0.15
            }
        }
    },
    ["Mega Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 90, 90)\">MEGA: Pet is gigantic! Has 20% faster hunger rate.</font>",
        States = {
            Amount = {
                Base = 0.2,
                Scale = 0
            }
        }
    },
    ["Mega Pet Mutation Bonus"] = {
        Description = "<font color=\"rgb(255, 90, 90)\">MEGA: Gains an additional <Amount> xp per second!</font>",
        States = {
            Amount = {
                Max = 40,
                Base = 10,
                Scale = 0.15
            }
        }
    },
    ["Golden Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 225, 0)\">GOLDEN: Provides a big increase to the pet\'s passive!</font>",
        States = {}
    },
    ["Silver Pet Mutation"] = {
        Description = "<font color=\"rgb(222, 222, 222)\">SILVER: Provides a small increase to the pet\'s passive!</font>",
        States = {},
        ""
    },
    ["Rainbow Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 0, 0)\">R</font><font color=\"rgb(255, 127, 0)\">A</font><font color=\"rgb(255, 255, 0)\">I</font><font color=\"rgb(0, 255, 0)\">N</font><font color=\"rgb(0, 0, 255)\">B</font><font color=\"rgb(75, 0, 130)\">O</font><font color=\"rgb(148, 0, 211)\">W</font><font color=\"rgb(4, 175, 236)\">: Provides a bigger increase to the pet\'s passive!</font>",
        States = {}
    },
    ["Shiny Pet Mutation"] = {
        Description = "<font color=\"rgb(145, 207, 221)\">SHINY: Provides an additional 15% boost to the pet\'s xp per second!</font>",
        States = {}
    },
    ["Inverted Pet Mutation"] = {
        Description = "<font color=\"rgb(128, 128, 128)\">INVERTED: Provides an additional 30% boost to the pet\'s xp per second!</font>",
        States = {}
    },
    ["Tranquil Pet Mutation"] = {
        Description = "<font color=\"rgb(247, 245, 184)\">TRANQUIL: Every <Cooldown>m, a nearby fruit finds inner peace, with a <Chance>% chance to apply the Tranquil mutation!</font>",
        States = {
            Cooldown = {
                Min = 1000,
                Base = 1500,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 20,
                Scale = 0.03
            }
        }
    },
    ["Alienated Pet Mutation"] = {
        Description = "<font color=\"rgb(49, 255, 63)\">ALIENATED: SMALL boost to passive but drains <Amount>% xp per second!</font>",
        States = {
            Amount = {
                Max = 0.07,
                Base = 0.07,
                Min = 0.07,
                Scale = 0,
                Formatter = "Percentage"
            }
        }
    },
    ["UFO Pet Mutation"] = {
        Description = "<font color=\"rgb(11, 163, 0)\">UFO: MEDIUM boost to passive but drains <Amount>% xp per second!</font>",
        States = {
            Amount = {
                Max = 0.04,
                Base = 0.04,
                Min = 0.04,
                Scale = 0,
                Formatter = "Percentage"
            }
        }
    },
    ["Corrupted Pet Mutation"] = {
        Description = "<font color=\"rgb(176, 23, 26)\">Corrupted: Every <Cooldown>m, a nearby fruit embraces the corruption, with a <Chance>% chance to apply the Corrupted mutation!</font>",
        States = {
            Cooldown = {
                Min = 1000,
                Base = 1500,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 20,
                Scale = 0.03
            }
        }
    },
    ["Fried Pet Mutation"] = {
        Description = "<font color=\"rgb(209, 139, 0)\">Fried: Every <Cooldown>m, a nearby fruit is sizzled up, with a <Chance>% chance to apply the Fried mutation!</font>",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1000,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 60,
                Base = 40,
                Scale = 0.1
            }
        }
    },
    ["Aromatic Pet Mutation"] = {
        Description = "<font color=\"rgb(162, 145, 57)\">AROMATIC: Every <Cooldown>m, a nearby fruit is infused with a pungent aroma, with a <Chance>% chance to apply the Aromatic mutation!</font>",
        States = {
            Cooldown = {
                Min = 1000,
                Base = 1500,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 20,
                Scale = 0.03
            }
        }
    },
    ["GiantBean Pet Mutation"] = {
        Description = "<font color=\"rgb(102, 153, 51)\">GIANT BEAN: Pet is a GIANT BEAN! Has 15% faster hunger rate.</font>",
        States = {
            Amount = {
                Base = 0.15,
                Scale = 0
            }
        }
    },
    ["GiantBean Pet Mutation Bonus"] = {
        Description = "<font color=\"rgb(102, 153, 51)\">Gains an additional <Amount>xp/s for each Beanstalk planted in your garden!</font>",
        States = {
            Amount = {
                Max = 0.5,
                Base = 0.1,
                Scale = 0.005
            }
        }
    },
    ["Glimmering Pet Mutation"] = {
        Description = "<font color=\"rgb(246, 142, 255)\">Glimmering: Every <Cooldown>m, a nearby fruit is sprinkled with fairy dust, with a <Chance>% chance to apply the Glimmering mutation!</font>",
        States = {
            Cooldown = {
                Min = 800,
                Base = 1500,
                Scale = -3,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 20,
                Scale = 0.03
            }
        }
    },
    ["Luminous Pet Mutation"] = {
        Description = "<font color=\"rgb(85, 170, 255)\">Luminous: Every <Cooldown>m, a nearby fruit is imbued with fairy power, with a <Chance>% chance to apply the Luminous mutation!</font>",
        States = {
            Cooldown = {
                Min = 1000,
                Base = 2000,
                Scale = -4,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 20,
                Scale = 0.03
            }
        }
    },
    ["Nutty Pet Mutation"] = {
        Description = "<font color=\"rgb(161, 117, 29)\">Nutty: Every <Cooldown> minutes, the pet’s next ability use has a <Chance>% chance to activate twice. Otherwise, this pet loses a level.</font>",
        States = {
            Cooldown = {
                Min = 120,
                Base = 1200,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.1
            }
        }
    },
    ["Dreadbound Pet Mutation"] = {
        Description = "<font color=\"rgb(140, 45, 175)\">DREADBOUND: Gains an additional <Amount> xp per second!</font>",
        States = {
            Amount = {
                Max = 30,
                Base = 6.5,
                Scale = 0.15
            }
        }
    },
    ["Soulflame Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 85, 40)\">SOULFLAME: Provides an additional 60% boost to the pet\'s xp per second. Every <Cooldown>m, a nearby fruit has a <Chance>% chance to get mutated with Burnt - lower chance for Flaming!</font>",
        States = {
            Cooldown = {
                Min = 300,
                Base = 912,
                Scale = -4.5,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 30,
                Base = 20,
                Scale = 0.03
            }
        }
    },
    ["Spectral Pet Mutation"] = {
        Description = "<font color=\"rgb(90, 200, 255)\">SPECTRAL: Provides a small increase to the pet\'s passive!</font>",
        States = {}
    },
    ["Nightmare Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 0, 128)\">N</font><font color=\"rgb(170, 0, 85)\">I</font><font color=\"rgb(255, 0, 128)\">G</font><font color=\"rgb(170, 0, 85)\">H</font><font color=\"rgb(255, 0, 128)\">T</font><font color=\"rgb(170, 0, 85)\">M</font><font color=\"rgb(255, 0, 128)\">A</font><font color=\"rgb(170, 0, 85)\">R</font><font color=\"rgb(255, 0, 128)\">E</font><font color=\"rgb(255, 0, 128)\">: Provides a bigger increase to the pet\'s passive and is slightly bigger!</font>",
        States = {}
    },
    ["Tethered Pet Mutation"] = {
        Description = "<font color=\"rgb(210, 171, 136)\">TETHERED: Constantly wanders around the player!</font>",
        States = {}
    },
    ["Aurora Pet Mutation"] = {
        Description = "<font color=\"rgb(165, 105, 255)\">AURORA: Every <Cooldown>m, <Chance>% chance a nearby fruit becomes Aurora!</font>",
        States = {
            Cooldown = {
                Min = 1000,
                Base = 2525,
                Scale = -25,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 50,
                Base = 30,
                Scale = 0.3
            }
        }
    },
    ["JUMBO Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 170, 0)\">JUMBO:</font> Pet is Jumbo and gains <font color=\"rgb(255, 255, 0)\">+50% XP BOOST!</font>",
        States = {}
    },
    ["JUMBO Pet Mutation Bonus"] = {
        Description = "<font color=\"rgb(255, 170, 0)\">JUMBO:</font> All nearby plants within <font color=\"rgb(170, 255, 255)\"><Range></font> studs will have an increased <font color=\"rgb(170, 255, 255)\"><Multiplier>x</font> size bonus for every Safari-type plant planted in your garden! <font color=\"rgb(255, 255, 255)\">(Max 300)</font>",
        States = {
            Range = {
                Max = 35,
                Base = 14.75,
                Scale = 0.25
            },
            Multiplier = {
                Max = 0.01,
                Base = 0.004,
                Scale = 0.001,
                Formatter = "NoPrecision"
            }
        }
    },
    ["Oxpecker Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 170, 0)\">OXPECKER:</font> When Safari type pets finish their abilities, they start their cooldown with <Chance> seconds less! Gains <font color=\"rgb(255, 170, 0)\">tiny</font> increase to passives!",
        States = {
            Chance = {
                Max = 7.5,
                Base = 3.5,
                Scale = 0.1
            }
        }
    },
    ["Giraffe Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 215, 0)\">GIRAFFE:</font> Every <Cooldown>m, eats fruit that are at least 10 studs high for <Multiplier>x sell value. The plant the fruit came from advances growth by <Amount>m! Also applies Arid mutation to all other fruits on that plant. Gains <font color=\"rgb(255, 215, 0)\">small</font> increase to passives!",
        States = {
            Cooldown = {
                Min = 583,
                Base = 1554,
                Scale = -1.1,
                Formatter = "ColonTime"
            },
            Multiplier = {
                Max = 0.75,
                Base = 0.36,
                Scale = 0.01
            },
            Amount = {
                Max = 1800,
                Base = 997,
                Scale = 7.5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Rhino Pet Mutation"] = {
        Description = "<font color=\"rgb(211, 211, 211)\">RHINO:</font> Every <Cooldown>m, charges into a random egg or random fruit in your garden: Rammed eggs have hatch time halved, rammed fruits get Mirage mutation! Cannot be mimicked or refreshed. Gains <font color=\"rgb(211, 211, 211)\">medium</font> increase to passives!",
        States = {
            Cooldown = {
                Min = 777,
                Base = 1554,
                Scale = -2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Crocodile Pet Mutation"] = {
        Description = "<font color=\"rgb(0, 200, 120)\">CROCODILE:</font> Every <Cooldown>m, bites on to a random Plant or Pet for <Duration>s and performs a roll. Plants grow an additional <AmountPlant>s/s and Pets get additional <AmountXP> XP/s. Gains <font color=\"rgb(0, 200, 120)\">sizable</font> increase to passives!",
        States = {
            Cooldown = {
                Min = 1050,
                Base = 2100,
                Scale = -1.65,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 12.5,
                Base = 7.5,
                Scale = 0.025
            },
            AmountPlant = {
                Max = 22.5,
                Base = 11.25,
                Scale = 0.025
            },
            AmountXP = {
                Max = 16.25,
                Base = 8.75,
                Scale = 0.025
            }
        }
    },
    ["Lion Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 255, 102)\">LION:</font> Every <Cooldown>m, roars and calls all pets in your garden to move toward it. <Amount> total cooldown advancement is shared across each pet (max <MaxAmount> seconds per pet). Gains <font color=\"rgb(255, 255, 102)\">big</font> increase to passives!",
        States = {
            Cooldown = {
                Min = 350,
                Base = 1400,
                Scale = -1.25,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 200,
                Base = 100,
                Scale = 1
            },
            MaxAmount = {
                Max = 30,
                Base = 15,
                Scale = 0.15
            }
        }
    },
    ["Forger Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 215, 0)\">FORGER:</font> Every <Cooldown>m goes to an active crafting table and advances its crafting time by <Amount>s!",
        States = {
            Cooldown = {
                Min = 400,
                Base = 800,
                Scale = -4,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 80,
                Base = 40,
                Scale = 0.4
            }
        }
    },
    ["HyperHunger Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 255, 0)\">HYPER HUNGER:</font> BIG boost to passive but hunger drains SUPER DUPER FAST! Boost is disabled when hunger is less than 25%",
        States = {}
    },
    ["Nocturnal Pet Mutation"] = {
        Description = "<font color=\"rgb(85, 85, 255)\">NOCTURNAL:</font> Every <Cooldown>m, a random fruit gets advanced by 12h! Cooldown ticks down twice as fast during the night!",
        States = {
            Cooldown = {
                Min = 700,
                Base = 1414,
                Scale = -14,
                Formatter = "ColonTime"
            }
        }
    },
    ["Peppermint Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 0, 0)\">P</font><font color=\"rgb(255, 255, 255)\">E</font><font color=\"rgb(255, 0, 0)\">P</font><font color=\"rgb(255, 255, 255)\">P</font><font color=\"rgb(255, 0, 0)\">E</font><font color=\"rgb(255, 255, 255)\">R</font><font color=\"rgb(255, 0, 0)\">M</font><font color=\"rgb(255, 255, 255)\">I</font><font color=\"rgb(255, 0, 0)\">N</font><font color=\"rgb(255, 255, 255)\">T</font><font color=\"rgb(255, 0, 0)\">:</font> Every <Cooldown>m, sacrifices 12 random Christmas-type fruit in your garden to instantly activate this pet\'s ability!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 966,
                Scale = -6,
                Formatter = "ColonTime"
            }
        }
    },
    ["Christmas Rally Pet Mutation"] = {
        Description = "<font color=\"rgb(0, 200, 0)\">CHRISTMAS RALLY:</font> All Christmas-themed pets gain an additional <font color=\"rgb(255,215,0)\"><Chance></font>XP per second!",
        States = {
            Chance = {
                Max = 7.5,
                Base = 3.5,
                Scale = 0.1
            }
        }
    },
    ["Jolly Decorator Pet Mutation"] = {
        Description = "<font color=\"rgb(255,0,0)\">J</font><font color=\"rgb(0,200,0)\">O</font><font color=\"rgb(255,0,0)\">L</font><font color=\"rgb(0,200,0)\">L</font><font color=\"rgb(255,0,0)\">Y</font> <font color=\"rgb(0,200,0)\">D</font><font color=\"rgb(255,0,0)\">E</font><font color=\"rgb(0,200,0)\">C</font><font color=\"rgb(255,0,0)\">O</font><font color=\"rgb(0,200,0)\">R</font><font color=\"rgb(255,0,0)\">A</font><font color=\"rgb(0,200,0)\">T</font><font color=\"rgb(255,0,0)\">O</font><font color=\"rgb(0,200,0)\">R</font><font color=\"rgb(255,0,0)\">:</font> Every <font color=\"rgb(255,215,0)\"><Cooldown></font>m, applies Ornamented mutation to a random fruit!",
        States = {
            Cooldown = {
                Min = 250,
                Base = 505,
                Scale = -5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Merry Nursery Pet Mutation"] = {
        Description = "<font color=\"rgb(255,215,0)\">MERRY NURSERY:</font> Every <font color=\"rgb(255,215,0)\"><Cooldown></font>s, goes to the unhatched egg with the highest hatch time and reduces it by <font color=\"rgb(255,215,0)\"><Amount></font>s with a bonus <font color=\"rgb(255,215,0)\"><AmountBonus></font>s for every Christmas-type plant in your garden!",
        States = {
            Cooldown = {
                Min = 20,
                Base = 80,
                Scale = -0.8
            },
            Amount = {
                Max = 60,
                Base = 25,
                Scale = 0.25
            },
            AmountBonus = {
                Max = 0.2,
                Base = 0.1,
                Scale = 0.01,
                Formatter = "NoPrecision"
            }
        }
    },
    ["Giant Golem Pet Mutation"] = {
        Description = "<font color=\"rgb(50,120,255)\">GIANT</font> <font color=\"rgb(120,180,255)\">GOLEM:</font> Pet is a giant golem! Has a big increase to passive, slightly bigger & gains bonus <font color=\"rgb(255,215,0)\"><Amount></font>XP/s for every Christmas-type plant in your garden!",
        States = {
            Amount = {
                Max = 0.15,
                Base = 0.15,
                Scale = 0,
                Formatter = "NoPrecision"
            }
        }
    },
    ["Spirit Sparkle Pet Mutation"] = {
        Description = "<font color=\"rgb(217, 244, 255)\">SPIRIT SPARKLE:</font> Every <Cooldown>m, your pet either ages up once, or ages down once.",
        States = {
            Cooldown = {
                Min = 1200,
                Base = 1500,
                Scale = -8,
                Formatter = "ColonTime"
            }
        }
    },
    ["Fiery Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 128, 0)\">FIERY:</font> Every <Cooldown>m, consumes a random fruit to mutate fruits around it with the Fiery mutation!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 600,
                Scale = -2,
                Formatter = "ColonTime"
            }
        }
    },
    ["Venom Pet Mutation"] = {
        Description = "<font color=\"rgb(149, 0, 255)\">VENOM: BIG boost to passive but drains <Amount>% XP/s!</font>",
        States = {
            Amount = {
                Max = 0.02,
                Base = 0.02,
                Min = 0.02,
                Scale = 0,
                Formatter = "Percentage"
            }
        }
    },
    ["Blossoming Pet Mutation"] = {
        Description = "<font color=\"rgb(105, 158, 255)\">B</font><font color=\"rgb(236, 128, 255)\">L</font><font color=\"rgb(255, 129, 211)\">O</font><font color=\"rgb(105, 158, 255)\">S</font><font color=\"rgb(236, 128, 255)\">S</font><font color=\"rgb(255, 129, 211)\">O</font><font color=\"rgb(105, 158, 255)\">M</font><font color=\"rgb(236, 128, 255)\">I</font><font color=\"rgb(255, 129, 211)\">N</font><font color=\"rgb(105, 158, 255)\">G</font><font color=\"rgb(255, 129, 211)\">: Provides a bigger increase to the pet\'s passive and gains an additional <Amount> XP per second!</font>",
        States = {
            Amount = {
                Max = 25,
                Base = 7,
                Scale = 0.15
            }
        }
    },
    ["Everchanted Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 215, 0)\">E</font><font color=\"rgb(0, 255, 127)\">V</font><font color=\"rgb(255, 215, 0)\">E</font><font color=\"rgb(0, 255, 127)\">R</font><font color=\"rgb(255, 215, 0)\">C</font><font color=\"rgb(0, 255, 127)\">H</font><font color=\"rgb(255, 215, 0)\">A</font><font color=\"rgb(0, 255, 127)\">N</font><font color=\"rgb(255, 215, 0)\">T</font><font color=\"rgb(0, 255, 127)\">E</font><font color=\"rgb(255, 215, 0)\">D</font><font color=\"rgb(0, 255, 127)\">:</font> BIG boost to passive!",
        States = {}
    },
    ["Everchanted Pet Mutation Bonus"] = {
        Description = "<font color=\"rgb(255, 215, 0)\">E</font><font color=\"rgb(0, 255, 127)\">V</font><font color=\"rgb(255, 215, 0)\">E</font><font color=\"rgb(0, 255, 127)\">R</font><font color=\"rgb(255, 215, 0)\">C</font><font color=\"rgb(0, 255, 127)\">H</font><font color=\"rgb(255, 215, 0)\">A</font><font color=\"rgb(0, 255, 127)\">N</font><font color=\"rgb(255, 215, 0)\">T</font><font color=\"rgb(0, 255, 127)\">E</font><font color=\"rgb(255, 215, 0)\">D</font><font color=\"rgb(0, 255, 127)\">:</font> Every <Cooldown>m, consumes a fruit (ignores favorited) with 7+ mutations and applies Medium Passive Boost to a random pet in your garden!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1000,
                Scale = -5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Royal Jelly Pet Mutation"] = {
        Description = "<font color=\"#035BFF\">R</font><font color=\"#1A5AFD\">O</font><font color=\"#3159FB\">Y</font><font color=\"#4858F9\">A</font><font color=\"#5F57F7\">L</font><font color=\"#7656F5\"> </font><font color=\"#8D55F3\">J</font><font color=\"#A454F1\">E</font><font color=\"#BB53EF\">L</font><font color=\"#BE50FF\">L</font><font color=\"#BE50FF\">Y</font>: <font color=\"#FFB347\">Bigger boost</font> to passive. Gains an additional <font color=\"#FFD84D\"><AmountXP></font>XP/s per Royal Jelly plant (Max 50) in your garden!",
        States = {
            AmountXP = {
                Min = 7,
                Max = 7,
                Base = 7,
                Scale = 0
            }
        }
    },
    ["Ember Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 80, 0)\">E</font><font color=\"rgb(255, 140, 0)\">M</font><font color=\"rgb(255, 215, 0)\">B</font><font color=\"rgb(255, 45, 0)\">E</font><font color=\"rgb(255, 120, 20)\">R</font><font color=\"rgb(255, 170, 0)\">: </font><font color=\"rgb(255, 215, 0)\">HUGE</font><font color=\"rgb(255, 120, 20)\"> boost to </font><font color=\"rgb(255, 80, 0)\">passive</font><font color=\"rgb(255, 120, 20)\">, </font><font color=\"rgb(255, 170, 0)\">XP</font><font color=\"rgb(255, 120, 20)\"> and </font><font color=\"rgb(255, 45, 0)\">size</font><font color=\"rgb(255, 120, 20)\">!</font>",
        States = {
            Amount = {
                Max = 0.02,
                Base = 0.02,
                Min = 0.02,
                Scale = 0,
                Formatter = "Percentage"
            }
        }
    },
    ["Exalted Pet Mutation"] = {
        Description = "<font color=\"#FFD700\">E</font><font color=\"#FFDF3A\">X</font><font color=\"#FFE75C\">A</font><font color=\"#FFEF7A\">L</font><font color=\"#FFF58F\">T</font><font color=\"#FFF9A6\">E</font><font color=\"#FFFCC0\">D</font>: <font color=\"#FFB347\">Bigger boost</font> to passive. All pets gains an additional <font color=\"#FFD84D\"><Chance></font>XP/s!",
        States = {
            Chance = {
                Max = 30,
                Base = 20,
                Scale = 0.02
            }
        }
    },
    ["Iridescent Pet Mutation"] = {
        Description = "<font color=\"#5A00FF\">I</font><font color=\"#6E1FFF\">R</font><font color=\"#823DFF\">I</font><font color=\"#965CFF\">D</font><font color=\"#AA7AFF\">E</font><font color=\"#BE99FF\">S</font><font color=\"#D2B8FF\">C</font><font color=\"#DEC8FF\">E</font><font color=\"#EAD8FF\">N</font><font color=\"#F6E8FF\">T</font>: <font color=\"#FFB347\">BIG</font> boost to size. Every <Cooldown>m, turns a random fruit rainbow!",
        States = {
            Cooldown = {
                Min = 780,
                Base = 1515,
                Scale = -15,
                Formatter = "ColonTime"
            }
        }
    },
    ["Gigantic Pet Mutation"] = {
        Description = "<font color=\"#4D0000\">G</font><font color=\"#660000\">I</font><font color=\"#800000\">G</font><font color=\"#990000\">A</font><font color=\"#B22222\">N</font><font color=\"#DC143C\">T</font><font color=\"#F04A4A\">I</font><font color=\"#FF7A7A\">C</font>: <font color=\"#FFB347\">HUGE</font> boost to size. Every <Cooldown>m, picks <Amount> random pets and grants them Small, Medium, Large Passive Boosts!",
        States = {
            Cooldown = {
                Min = 1200,
                Base = 1818,
                Scale = -18,
                Formatter = "ColonTime"
            },
            Amount = {
                Base = 3,
                Scale = 0
            }
        }
    },
    ["Transcendent Pet Mutation"] = {
        Description = "<font color=\"#FF0000\">T</font><font color=\"#FF7F00\">R</font><font color=\"#FFFF00\">A</font><font color=\"#00FF00\">N</font><font color=\"#00FFFF\">S</font><font color=\"#0080FF\">C</font><font color=\"#4B00FF\">E</font><font color=\"#7F00FF\">N</font><font color=\"#FF00FF\">D</font><font color=\"#FF1493\">E</font><font color=\"#FF4500\">N</font><font color=\"#FFD700\">T</font>: <font color=\"#FFB347\">HUGE</font> boost to passive. Every <Cooldown>m, increases a random pet\'s age by 1!",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1200,
                Scale = -12,
                Formatter = "ColonTime"
            }
        }
    },
    ["Inferno Pet Mutation"] = {
        Description = "<font color=\"#C0392B\">I</font><font color=\"#B24A26\">N</font><font color=\"#9E7A2A\">F</font><font color=\"#8DAA3D\">E</font><font color=\"#8ECC48\">R</font><font color=\"#99E653\">N</font><font color=\"#65FF5B\">O</font>: <font color=\"#8ECC48\">BIGGER</font> boost to passive and size. Every <Cooldown>m, increases a random pet\'s age by \'<font color=\"#8ECC48\">2</font>\' for every pet in your garden that has <font color=\"#C0392B\">Inferno</font> pet mutation!",
        States = {
            Cooldown = {
                Min = 900,
                Base = 1818,
                Scale = -18,
                Formatter = "ColonTime"
            }
        }
    },
    ["Bountiful Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 215, 0)\">B</font><font color=\"rgb(255, 170, 0)\">O</font><font color=\"rgb(255, 215, 0)\">U</font><font color=\"rgb(255, 170, 0)\">N</font><font color=\"rgb(255, 215, 0)\">T</font><font color=\"rgb(255, 170, 0)\">I</font><font color=\"rgb(255, 215, 0)\">F</font><font color=\"rgb(255, 170, 0)\">U</font><font color=\"rgb(255, 215, 0)\">L</font>: <font color=\"rgb(255, 215, 0)\">Medium</font> increase to XP. Grants <Chance>% for Night type fruits to duplicate when collected!",
        States = {
            Chance = {
                Max = 10,
                Base = 5,
                Scale = 0.05
            }
        }
    },
    ["Threshing Pet Mutation"] = {
        Description = "<font color=\"rgb(220, 220, 220)\">T</font><font color=\"rgb(255, 215, 0)\">H</font><font color=\"rgb(220, 220, 220)\">R</font><font color=\"rgb(255, 215, 0)\">E</font><font color=\"rgb(220, 220, 220)\">S</font><font color=\"rgb(255, 215, 0)\">H</font><font color=\"rgb(220, 220, 220)\">I</font><font color=\"rgb(255, 215, 0)\">N</font><font color=\"rgb(220, 220, 220)\">G</font>: <font color=\"rgb(255, 215, 0)\">Medium</font> increase to passive. Grants <Chance>% chance not to consume Reclaimer or Harvest Tool!",
        States = {
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.06
            }
        }
    },
    ["Threshing Pet Mutation Harvest Tool"] = {
        Description = "",
        States = {
            Chance = {
                Max = 12,
                Base = 6,
                Scale = 0.06
            }
        }
    },
    ["Lunarbound Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 255, 190)\">L</font><font color=\"rgb(232, 250, 205)\">U</font><font color=\"rgb(210, 245, 220)\">N</font><font color=\"rgb(188, 240, 235)\">A</font><font color=\"rgb(166, 235, 255)\">R</font><font color=\"rgb(188, 240, 235)\">B</font><font color=\"rgb(210, 245, 220)\">O</font><font color=\"rgb(232, 250, 205)\">U</font><font color=\"rgb(255, 255, 190)\">N</font><font color=\"rgb(166, 235, 255)\">D</font>: <font color=\"rgb(166, 235, 255)\">Big</font> increase to XP and size! Fruits collected have a <Chance>% chance to get the Moonbeam mutation when collected!",
        States = {
            Chance = {
                Max = 5,
                Base = 2.5,
                Scale = 0.025
            }
        }
    },
    ["Starry Pet Mutation"] = {
        Description = "<font color=\"rgb(35, 20, 80)\">S</font><font color=\"rgb(190, 150, 255)\">T</font><font color=\"rgb(35, 20, 80)\">A</font><font color=\"rgb(190, 150, 255)\">R</font><font color=\"rgb(35, 20, 80)\">R</font><font color=\"rgb(190, 150, 255)\">Y</font>: <font color=\"rgb(190, 150, 255)\">BIGGER</font> boost to passive and XP. Every <Cooldown>m, advances cooldown for a random pet ability by <Amount>s for every pet in your garden that has Starry Pet Mutation!",
        States = {
            Cooldown = {
                Min = 120,
                Base = 240,
                Scale = -2.4,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Everfallen Pet Mutation"] = {
        Description = "<font color=\"rgb(255, 140, 0)\">E</font><font color=\"rgb(178, 34, 34)\">V</font><font color=\"rgb(255, 140, 0)\">E</font><font color=\"rgb(178, 34, 34)\">R</font><font color=\"rgb(255, 140, 0)\">F</font><font color=\"rgb(178, 34, 34)\">A</font><font color=\"rgb(255, 140, 0)\">L</font><font color=\"rgb(178, 34, 34)\">L</font><font color=\"rgb(255, 140, 0)\">E</font><font color=\"rgb(178, 34, 34)\">N</font><font color=\"rgb(255, 140, 0)\">:</font> BIG boost to passive!",
        States = {}
    },
    ["Everfallen Pet Mutation Bonus"] = {
        Description = "<font color=\"rgb(255, 140, 0)\">E</font><font color=\"rgb(178, 34, 34)\">V</font><font color=\"rgb(255, 140, 0)\">E</font><font color=\"rgb(178, 34, 34)\">R</font><font color=\"rgb(255, 140, 0)\">F</font><font color=\"rgb(178, 34, 34)\">A</font><font color=\"rgb(255, 140, 0)\">L</font><font color=\"rgb(178, 34, 34)\">L</font><font color=\"rgb(255, 140, 0)\">E</font><font color=\"rgb(178, 34, 34)\">N</font><font color=\"rgb(255, 140, 0)\">:</font> Every <Cooldown>m, consumes a fruit (ignores favorited) with 7+ mutations and applies Medium XP Boost to a random pet in your garden!",
        States = {
            Cooldown = {
                Min = 500,
                Base = 1000,
                Scale = -5,
                Formatter = "ColonTime"
            }
        }
    },
    ["Skull and Bones"] = {
        Description = "<Chance>% extra chance harvested plants drop seeds. Rarer plants have lower chance to drop seeds.",
        States = {
            Chance = {
                Max = 16,
                Base = 8,
                Scale = 0.05
            }
        }
    },
    ["Cranial Luck"] = {
        Description = "When triggering a Lucky Harvest: <Chance>% the plant you harvested from will advance growth by 2h!",
        States = {
            Chance = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            }
        }
    },
    ["Whim-of-the-Wisp"] = {
        Description = "As long as you have a Haunted Well cosmetic in your garden: The Lantern Wisp will go to it to grant all other pets an additional <Amount>XP/s per Halloween type cosmetic in your garden! (Max 50)",
        States = {
            Amount = {
                Max = 10,
                Base = 5,
                Scale = 0.05
            }
        }
    },
    ["Stone Form"] = {
        Description = "Every <Cooldown>m, lands and turns into stone for <Duration>s. All pets within <Range> studs advance cooldowns an additional 1 second every second or gain 3% XP every second.",
        States = {
            Cooldown = {
                Min = 450,
                Base = 900,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 20,
                Base = 10,
                Scale = 0.1
            },
            Range = {
                Max = 30,
                Base = 15,
                Scale = 0.2
            }
        }
    },
    ["Reins of Destruction"] = {
        Description = "Every <font color=\'#FFD700\'><Cooldown></font>m, haunts a random age <font color=\'#FFD700\'><Age></font> pet with the <font color=\'#FF0064\'>Nightmare</font> pet mutation, resetting it back to <font color=\'#FF5555\'>age 31</font> and bestowing the <font color=\'#9646E6\'>Haunted</font> pet mutation or a rare <font color=\'#B982FF\'><Chance>%</font> chance for <font color=\'#B982FF\'>Everhaunted</font>!",
        States = {
            Cooldown = {
                Min = 1222,
                Base = 2444,
                Scale = -24,
                Formatter = "ColonTime"
            },
            Age = {
                Min = 150,
                Base = 300,
                Scale = -0.3
            },
            Chance = {
                Max = 3,
                Base = 2,
                Scale = 0.03
            }
        }
    },
    ["Ghostly Skull and Bones"] = {
        Description = "<Chance>% extra chance harvested plants drop seeds. Rarer plants have lower chance to drop seeds.",
        States = {
            Chance = {
                Max = 18,
                Base = 10,
                Scale = 0.05
            }
        }
    },
    ["Ghostly Cranial Luck"] = {
        Description = "When triggering a Lucky Harvest: <Chance>% the plant you harvested from will advance growth by 2h!",
        States = {
            Chance = {
                Max = 25,
                Base = 15,
                Scale = 0.1
            }
        }
    },
    ["Ghostly Whim-of-the-Wisp"] = {
        Description = "As long as you have a Haunted Well cosmetic in your garden: The Lantern Wisp will go to it to grant all other pets an additional <Amount>XP/s per Halloween type cosmetic in your garden! (Max 50)",
        States = {
            Amount = {
                Max = 20,
                Base = 10,
                Scale = 0.05
            }
        }
    },
    ["Ghostly Stone Form"] = {
        Description = "Every <Cooldown>m, lands and turns into stone for <Duration>s. All pets within <Range> studs advance cooldowns an additional 1 second every second or gain 3% XP every second.",
        States = {
            Cooldown = {
                Min = 350,
                Base = 700,
                Scale = -6,
                Formatter = "ColonTime"
            },
            Duration = {
                Max = 24,
                Base = 12,
                Scale = 0.1
            },
            Range = {
                Max = 32,
                Base = 17,
                Scale = 0.2
            }
        }
    },
    ["Ghostly Reins of Destruction"] = {
        Description = "Every <font color=\'#FFD700\'><Cooldown></font>m, haunts a random age <font color=\'#FFD700\'><Age></font> pet with the <font color=\'#FF0064\'>Nightmare</font> pet mutation, resetting it back to <font color=\'#FF5555\'>age 31</font> and bestowing the <font color=\'#9646E6\'>Haunted</font> pet mutation or a rare <font color=\'#B982FF\'><Chance>%</font> chance for <font color=\'#B982FF\'>Everhaunted</font>!",
        States = {
            Cooldown = {
                Min = 1000,
                Base = 2000,
                Scale = -24,
                Formatter = "ColonTime"
            },
            Age = {
                Min = 140,
                Base = 260,
                Scale = -0.3
            },
            Chance = {
                Max = 6,
                Base = 3,
                Scale = 0.03
            }
        }
    },
    ["Grim Pinch"] = {
        Description = "Every <Cooldown>m goes to another random player and pinches them for their money and grants you <Amount> - <AmountHigh> sheckles with a <Chance>% to give you a Suspicious Soup. Pinched player does not lose sheckles.",
        States = {
            Cooldown = {
                Min = 150,
                Base = 350,
                Scale = -3.5,
                Formatter = "ColonTime"
            },
            Amount = {
                Base = 225,
                Scale = 25
            },
            AmountHigh = {
                Base = 425,
                Scale = 25
            },
            Chance = {
                Max = 6,
                Base = 3,
                Scale = 0.03
            }
        }
    },
    ["It\'s Alive!"] = {
        Description = "Every <Cooldown>m, applies Acidic mutation or has a 0.1% chance to age up a random pet in your garden by 1!",
        States = {
            Cooldown = {
                Min = 120,
                Base = 600,
                Scale = -5,
                Formatter = "ColonTime"
            }
        }
    },
    Gaze = {
        Description = "Every <Cooldown>m, flies to stare at <Amount> different pets, fruit or plants in your garden. Pets get <AdvancementAmount>m advanced cooldown, fruits have a <Chance>% to get Spooky mutation and plants advance growth by <AdvancementGrowth>m!",
        States = {
            Cooldown = {
                Min = 600,
                Base = 1200,
                Scale = -12,
                Formatter = "ColonTime"
            },
            Amount = {
                Max = 8,
                Base = 4,
                Scale = 0.04
            },
            AdvancementAmount = {
                Max = 480,
                Base = 240,
                Scale = 2.4,
                Formatter = "ColonTime"
            },
            AdvancementGrowth = {
                Max = 1800,
                Base = 600,
                Scale = 6,
                Formatter = "ColonTime"
            },
            Chance = {
                Max = 40,
                Base = 20,
                Scale = 0.2
            }
        }
    },
    ["Haunted Pet Mutation"] = {
        Description = "<font color=\"rgb(150, 70, 230)\">H</font><font color=\"rgb(205, 165, 255)\">A</font><font color=\"rgb(150, 70, 230)\">U</font><font color=\"rgb(205, 165, 255)\">N</font><font color=\"rgb(150, 70, 230)\">T</font><font color=\"rgb(205, 165, 255)\">E</font><font color=\"rgb(150, 70, 230)\">D</font><font color=\"rgb(205, 165, 255)\">: Provides a bigger increase to the pet\'s passive and is slightly bigger!</font>",
        States = {}
    },
    ["Haunted Pet Mutation Bonus"] = {
        Description = "<font color=\"rgb(150, 70, 230)\">H</font><font color=\"rgb(205, 165, 255)\">A</font><font color=\"rgb(150, 70, 230)\">U</font><font color=\"rgb(205, 165, 255)\">N</font><font color=\"rgb(150, 70, 230)\">T</font><font color=\"rgb(205, 165, 255)\">E</font><font color=\"rgb(150, 70, 230)\">D</font><font color=\"rgb(205, 165, 255)\">:</font> Every <Cooldown>m, gains <XPGainPercentage>% XP!",
        States = {
            Cooldown = {
                Min = 300,
                Base = 900,
                Scale = -6,
                Formatter = "ColonTime"
            },
            XPGainPercentage = {
                Max = 6,
                Base = 3,
                Scale = 0.03
            }
        }
    },
    ["Everhaunted Pet Mutation"] = {
        Description = "<font color=\"rgb(70, 20, 130)\">E</font><font color=\"rgb(85, 36, 143)\">V</font><font color=\"rgb(99, 51, 155)\">E</font><font color=\"rgb(114, 67, 167)\">R</font><font color=\"rgb(128, 82, 180)\">H</font><font color=\"rgb(143, 98, 193)\">A</font><font color=\"rgb(157, 113, 205)\">U</font><font color=\"rgb(171, 128, 217)\">N</font><font color=\"rgb(186, 144, 230)\">T</font><font color=\"rgb(201, 159, 243)\">E</font><font color=\"rgb(215, 175, 255)\">D</font><font color=\"rgb(215, 175, 255)\">:</font> BIG boost to passive and is much bigger!",
        States = {}
    },
    ["Everhaunted Pet Mutation Bonus"] = {
        Description = "<font color=\"rgb(70, 20, 130)\">E</font><font color=\"rgb(85, 36, 143)\">V</font><font color=\"rgb(99, 51, 155)\">E</font><font color=\"rgb(114, 67, 167)\">R</font><font color=\"rgb(128, 82, 180)\">H</font><font color=\"rgb(143, 98, 193)\">A</font><font color=\"rgb(157, 113, 205)\">U</font><font color=\"rgb(171, 128, 217)\">N</font><font color=\"rgb(186, 144, 230)\">T</font><font color=\"rgb(201, 159, 243)\">E</font><font color=\"rgb(215, 175, 255)\">D</font><font color=\"rgb(215, 175, 255)\">:</font> Every <Cooldown>m, either instantly hatches a random egg or refreshes its own ability cooldown!",
        States = {
            Cooldown = {
                Min = 1200,
                Base = 2400,
                Scale = -12,
                Formatter = "ColonTime"
            }
        }
    }
};