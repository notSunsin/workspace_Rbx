-- Decompiled with Potassium's decompiler.

local u1 = {
    Dinosaur = { "Raptor", "Triceratops", "Stegosaurus", "Pterodactyl", "Brontosaurus", "T-Rex", "Iguanodon", "Parasaurolophus", "Pachycephalosaurus", "Dilophosaurus", "Ankylosaurus", "Spinosaurus" },
    Food = { "Bagel Bunny", "Pancake Mole", "Sushi Bear", "Spaghetti Sloth", "French Fry Ferret", "Mochi Mouse", "Bacon Pig", "Hotdog Daschund", "Lobster Thermidor", "Sunny-Side Chicken", "Gorilla Chef" },
    Fall = { "Robin", "Badger", "Grizzly Bear", "Swan", "Barn Owl", "GIANT Robin", "GIANT Badger", "GIANT Grizzly Bear", "GIANT Swan", "GIANT Barn Owl", "Red Squirrel", "Chipmunk", "Marmot", "Sugar Glider", "Space Squirrel", "Salmon", "Woodpecker", "Mallard", "Red Panda" },
    Halloween = { "Bat", "Bone Dog", "Spider", "Black Cat", "Headless Horseman", "Ghostly Bat", "Ghostly Bone Dog", "Ghostly Spider", "Ghostly Black Cat", "Ghostly Headless Horseman", "Pumpkin Rat", "Wolf", "Ghost Bear", "Reaper", "Crow", "Goat", "Goblin", "Dark Spriggan", "Hex Serpent", "Ghostly Dark Spriggan", "Scarab", "Tomb Marmot", "Mummy", "Ghostly Scarab", "Ghostly Tomb Marmot", "Ghostly Mummy", "Specter", "Lich" },
    Beetle = { "Stag Beetle", "Rainbow Stag Beetle", "Amethyst Beetle" },
    Safari = { "Oxpecker", "Zebra", "Giraffe", "Rhino", "Elephant", "Rainbow Oxpecker", "Rainbow Zebra", "Rainbow Giraffe", "Rainbow Rhino", "Rainbow Elephant", "Gecko", "Hyena", "Cape Buffalo", "Hippo", "Crocodile", "Lion", "Cheetah" },
    Christmas = { "Snowman Soldier", "Snowman Builder", "Arctic Fox", "Frost Dragon", "GIANT Snowman Soldier", "GIANT Snowman Builder", "Rainbow Arctic Fox", "Rainbow Frost Dragon", "Gift Rat", "Penguin", "Snow Bunny", "French Hen", "Christmas Gorilla", "Mistletoad", "Krampus", "Rainbow Snow Bunny", "Rainbow French Hen", "Rainbow Christmas Gorilla", "Rainbow Mistletoad", "Rainbow Krampus", "Turtle Dove", "Reindeer", "Nutcracker", "Yeti", "Ice Golem", "Festive Turtle Dove", "Festive Reindeer", "Festive Nutcracker", "Festive Yeti", "Festive Ice Golem", "Pine Beetle", "Cocoa Cat", "Eggnog Chick", "Red-Nosed Reindeer", "Partridge", "Santa Bear", "Moose", "Frost Squirrel", "Wendigo", "Festive Partridge", "Festive Santa Bear", "Festive Moose", "FestiveFrost Squirrel", "Festive Wendigo", "Summer Kiwi", "Christmas Spirit" },
    Easter = { "Chocolate Bunny", "Easter Egg Chick", "Marshmallow Lamb", "Easter Bunny", "Gilded Choc Chocolate Bunny", "Gilded Choc Easter Egg Chick", "Gilded Choc Marshmallow Lamb", "Gilded Choc Easter Bunny", "Gummy Bear", "Hootsie Roll", "Beaver", "Stork", "Orchid Mantis" },
    Bee = { "Bee", "Honey Bee", "Petal Bee", "Bear Bee", "Queen Bee", "Wasp", "Moth", "Tarantula Hawk", "Butterfly", "Disco Bee", "Flame Bee", "Spring Bee", "Bumblebee", "Professor Bee", "Nurse Bee", "Gardener Bee", "Elemental Bee", "Empress Bee" },
    Summer = { "Starfish", "Crab", "Seagull", "Toucan", "Flamingo", "Sea Turtle", "Seal", "Orangutan", "Peacock", "Capybara", "Ostrich", "Scarlet Macaw", "Mimic Octopus", "Meerkat", "Snake", "Axolotl", "Hyacinth Macaw", "Fennec Fox", "Hamster", "Sea Anemone", "Seahorse", "Hermit Crab", "Orca", "Tsunami Sea Anemone", "Tsunami Seahorse", "Tsunami Hermit Crab", "Tsunami Orca", "Bison", "Sea Urchin", "Pelican", "Walrus", "Manta Ray", "Sandcastle Crab", "Jellyfish", "Hippocampus", "Dolphin", "Nautilus" },
    Night = { "Hedgehog", "Kiwi", "Mole", "Frog", "Echo Frog", "Owl", "Night Owl", "Raccoon", "Chicken Zombie", "Blood Kiwi", "Blood Owl", "Blood Hedgehog", "Moon Cat", "Vampire Squid", "Opossum", "Lunar Moth", "Night Horse", "Moon Dragon", "Starry Opossum", "Starry Lunar Moth", "Starry Night Horse", "Starry Moon Dragon" }
};
local u2 = {};

for i, v in u1 do
    local v3 = {};

    for _, v2 in v do
        v3[v2] = true;
    end;

    u2[i] = v3;
end;

function u2.AddToTrait(p4: string, p5: string) -- Line: 323
    -- upvalues: u2 (copy), u1 (copy)
    if not p4 or p4 == "" then
        warn("PetTraitsData.HasTrait | No pet name given!");

        return false;
    end;

    if not p5 or p5 == "" then
        warn("PetTraitsData.HasTrait | No trait name given!");

        return false;
    end;

    if typeof(u2[p5]) ~= "table" then
        return false;
    end;

    table.insert(u1[p5], p4);

    for i, v in u1 do
        if v == u1[p5] then
            u2[i][p4] = true;
        end;
    end;

    return true;
end;

function u2.HasTrait(p6: string, p7: string) -- Line: 353
    -- upvalues: u2 (copy)
    if not p6 or p6 == "" then
        warn("PetTraitsData.HasTrait | No pet name given!");

        return false;
    end;

    if not p7 or p7 == "" then
        warn("PetTraitsData.HasTrait | No trait name given!");

        return false;
    end;

    local v8 = u2[p7];

    if typeof(v8) == "table" then
        return v8[p6] == true;
    end;

    return false;
end;

function u2.GetTraitsAsString(p9: string) -- Line: 372
    -- upvalues: u1 (copy), u2 (copy)
    if not p9 or p9 == "" then
        warn("PetTraitsData.GetTraitsAsString | No pet name given!");

        return "";
    end;

    local v10 = {};

    for i, _ in u1 do
        if u2.HasTrait(p9, i) then
            table.insert(v10, i);
        end;
    end;

    return table.concat(v10, ", ");
end;

return u2;