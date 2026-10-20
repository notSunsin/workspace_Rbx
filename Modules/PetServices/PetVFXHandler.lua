-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
workspace:WaitForChild("PetsPhysical");
local u2 = {
    Dog = {
        Dig = {
            effect = "DigEffect",
            duration = 1.5
        }
    },
    Hydra = {},
    Armadillo = {},
    ["Mantis Shrimp"] = {},
    ["Golden Lab"] = {
        Dig = {
            effect = "DigEffect",
            duration = 1.5
        }
    },
    Cat = {
        Nap = {
            effect = "ZzzEffect",
            duration = 10
        }
    },
    ["Orange Tabby"] = {
        Nap = {
            effect = "ZzzEffect",
            duration = 10
        }
    },
    ["Moon Cat"] = {
        Nap = {
            effect = "ZzzEffect",
            duration = 10
        }
    },
    Bunny = {
        Chomp = {
            effect = "CarrotParticles",
            duration = 1.5
        }
    },
    ["Black Bunny"] = {
        Chomp = {
            effect = "CarrotParticles",
            duration = 1.5
        }
    },
    Panda = {
        Chomp = {
            effect = "BambooParticles",
            duration = 1.5
        }
    },
    Pig = {
        Frenzy = {
            effect = "MudSplashEffect",
            duration = 15
        }
    },
    ["Polar Bear"] = {
        Roar = {
            effect = "FrostBreath",
            duration = 3
        }
    },
    ["Praying Mantis"] = {
        Pray = {
            effect = "ShinyEffect",
            duration = 10
        }
    },
    Kiwi = {
        Nurse = {
            effect = "MusicNotes",
            duration = 3
        }
    },
    Mole = {
        DigDown = {
            effect = "DigAroundEffect",
            duration = 2
        },
        DigUp = {
            effect = "DigAroundEffect",
            duration = 2
        }
    },
    Frog = {
        Croak = {
            effect = "Shockwave",
            duration = 2
        }
    },
    ["Echo Frog"] = {
        Croak = {
            effect = "ShockwaveCool",
            duration = 2
        }
    },
    ["Chicken Zombie"] = {
        Zombify = {
            effect = "ZombieBeam",
            duration = 2
        }
    },
    ["Blood Kiwi"] = {
        Nurse = {
            effect = "RedMusicNotes",
            duration = 3
        }
    },
    Bee = {
        Pollinate = {
            effect = "PollenDrops",
            duration = 5
        }
    },
    ["Petal Bee"] = {
        Pollinate = {
            effect = "PollenDrops",
            duration = 5
        }
    },
    ["Golden Bee"] = {
        Pollinate = {
            effect = "PollenDrops",
            duration = 5
        }
    },
    ["Bear Bee"] = {
        Sit = {
            effect = "PollenMessy",
            duration = 5
        }
    },
    ["Queen Bee"] = {
        Spin = {
            effect = "MagicPollenTornado",
            duration = 5
        }
    },
    Wasp = {
        Pollinate = {
            effect = "PollenDrops",
            duration = 5
        }
    },
    ["Tarantula Hawk"] = {
        Pollinate = {
            effect = "PollenDrops",
            duration = 5
        }
    },
    Moth = {
        Sing = {
            effect = "MusicNotes",
            duration = 5
        }
    },
    Butterfly = {
        Flutter = {
            effect = "RainbowPollenTornado",
            duration = 5
        }
    },
    ["Disco Bee"] = {
        Pollinate = {
            effect = "RainbowMusicNotes",
            duration = 10
        }
    },
    ["Cooked Owl"] = {
        Cook = {
            effect = "CookBreath",
            duration = 3
        }
    },
    Flamingo = {
        Stand = {
            effect = "ZzzEffect",
            duration = 10
        }
    },
    ["Sea Turtle"] = {
        Flip = {
            effect = "SandScatter",
            duration = 2
        },
        Splash = {
            effect = "WaterSplash",
            duration = 2
        }
    },
    Peacock = {
        Fan = {
            effect = "Shimmer",
            duration = 2
        }
    },
    ["Scarlet Macaw"] = {
        Spin = {
            effect = "MacawLights",
            duration = 3
        }
    },
    ["Mimic Octopus"] = {
        Mimicry = {
            effect = "Transform",
            duration = 3
        }
    },
    ["Hyacinth Macaw"] = {
        Spin = {
            effect = "MacawLights",
            duration = 3
        }
    },
    ["Dilophosaurus "] = {
        Frill = {
            effect = "FrillPoison",
            duration = 2
        }
    },
    ["Bagel Bunny"] = {
        Chomp = {
            effect = "CarrotParticles",
            duration = 1.5
        }
    },
    ["Pancake Mole"] = {
        DigDown = {
            effect = "DigAroundEffect",
            duration = 2
        },
        DigUp = {
            effect = "DigAroundEffect",
            duration = 2
        }
    },
    ["Sushi Bear"] = {
        Roar = {
            effect = "FrostBreath",
            duration = 3
        }
    },
    ["Bacon Pig"] = {
        Frenzy = {
            effect = "MudSplashEffect",
            duration = 15
        }
    },
    ["Hotdog Daschund"] = {
        Pee = {
            effect = "MustardSplashEffect",
            duration = 5
        }
    },
    ["Lobster Thermidor"] = {
        Boil = {
            effect = "Bubbles",
            duration = 5
        }
    },
    Junkbot = {
        Oil = {
            effect = "OilSplashEffect",
            duration = 3
        }
    },
    ["Rainbow Bacon Pig"] = {
        Frenzy = {
            effect = "MudSplashEffect",
            duration = 15
        }
    },
    ["Rainbow Hotdog Daschund"] = {
        Pee = {
            effect = "MustardSplashEffect",
            duration = 5
        }
    },
    ["Rainbow Lobster Thermidor"] = {
        Boil = {
            effect = "Bubbles",
            duration = 5
        }
    },
    Jackalope = {
        Thump = {
            effect = "SandScatter",
            duration = 3
        }
    },
    Seedling = {
        Bless = {
            effect = "GreenPollenTornado",
            duration = 5
        }
    },
    Golem = {
        Tinker = {
            effect = "MachineParticles",
            duration = 3
        }
    },
    Griffin = {
        Flaunt = {
            effect = "CycloneScatter",
            duration = 7
        }
    },
    ["Rainbow Griffin"] = {
        Flaunt = {
            effect = "CycloneScatter",
            duration = 7
        }
    },
    Gnome = {
        Gnoming = {
            effect = "Gnomes",
            duration = 7
        }
    },
    Pixie = {
        Dust = {
            effect = "PixieDust",
            duration = 15
        }
    },
    Phoenix = {
        Dive = {
            effect = "",
            duration = 15
        },
        Rebirth = {
            effect = "",
            duration = 15
        }
    },
    Drake = {
        Fire = {
            effect = "",
            duration = 15
        }
    },
    ["Rainbow Phoenix"] = {
        Dive = {
            effect = "",
            duration = 15
        },
        Rebirth = {
            effect = "",
            duration = 15
        }
    },
    ["Tree Frog"] = {
        Croak = {
            effect = "Shockwave",
            duration = 2
        }
    },
    Tiger = {
        Roar = {
            effect = "",
            duration = 0
        }
    },
    ["Idol Chipmunk"] = {
        Perform = {
            effect = "MusicNotes",
            duration = 15
        }
    },
    Chinchilla = {
        Dust = {
            effect = "Dust",
            duration = 5
        }
    },
    ["Rainbow Idol Chipmunk"] = {
        Perform = {
            effect = "MusicNotes",
            duration = 15
        }
    },
    ["Rainbow Chinchilla"] = {
        Dust = {
            effect = "Dust",
            duration = 5
        }
    },
    ["Fortune Squirrel"] = {
        Fortune = {
            effect = "CashFlow",
            duration = 3
        }
    },
    ["Bone Dog"] = {
        Dig = {
            effect = "DigEffect",
            duration = 2
        }
    },
    ["Ghostly Bone Dog"] = {
        Dig = {
            effect = "DigEffect",
            duration = 2
        }
    },
    ["Black Cat"] = {
        Nap = {
            effect = "ZzzEffect",
            duration = 10
        }
    },
    ["Ghostly Black Cat"] = {
        Nap = {
            effect = "ZzzEffect",
            duration = 10
        }
    },
    ["Ghost Bear"] = {
        Roar = {
            effect = "GhostBreath",
            duration = 3
        }
    },
    ["Hex Serpent"] = {
        Hex = {
            effect = "HexParticle",
            duration = 10
        }
    },
    ["Glass Dog"] = {
        Dig = {
            effect = "DigEffect",
            duration = 1.5
        }
    },
    ["Glass Cat"] = {
        Nap = {
            effect = "ZzzEffect",
            duration = 10
        }
    },
    Termite = {
        Eat = {
            effect = "Woodchips",
            duration = 3
        }
    }
};

function u1.new(p3, p4, p5) -- Line: 567
    -- upvalues: u1 (copy)
    local v6 = setmetatable({}, u1);
    v6.PetType = p3;
    v6.PetModel = p4;
    v6.UUID = p5;
    v6.ActiveEmitters = {};
    v6.CurrentAnimation = nil;

    return v6;
end;

function u1.cleanupVFX(p7, p8) -- Line: 579
    if p7.ActiveEmitters[p8] then
        for _, v in pairs(p7.ActiveEmitters[p8]) do
            v:Destroy();
        end;

        p7.ActiveEmitters[p8] = nil;
    end;
end;

function u1.playVFX(u9, u10) -- Line: 589
    -- upvalues: u2 (copy), ReplicatedStorage (copy)
    if u9.CurrentAnimation == u10 then
        return;
    end;

    if u9.CurrentAnimation then
        u9:cleanupVFX(u9.CurrentAnimation);
    end;

    u9.CurrentAnimation = u10;
    local v11 = u2[u9.PetType];

    if not v11 then
        return;
    end;

    local v12 = v11[u10];

    if not v12 then
        return;
    end;

    local effect = v12.effect;

    if not effect then
        return;
    end;

    local v13 = ReplicatedStorage:FindFirstChild("Assets"):FindFirstChild("PetVFX"):FindFirstChild(effect);

    if not v13 then
        return;
    end;

    local u14 = v13:Clone();
    u14.Parent = u9.PetModel.PrimaryPart or u9.PetModel;
    u14.Name = effect;

    if not u9.ActiveEmitters[u10] then
        u9.ActiveEmitters[u10] = {};
    end;

    table.insert(u9.ActiveEmitters[u10], u14);

    if v12.duration then
        task.delay(v12.duration, function() -- Line: 633
            -- upvalues: u14 (copy), u9 (copy), u10 (copy)
            if u14 and u14.Parent then
                u14.Enabled = false;
                local v15 = 0;

                for _, child in ipairs(u14:GetChildren()) do
                    if child:IsA("ParticleEmitter") then
                        for _, v in ipairs(child.Lifetime:GetKeypoints()) do
                            v15 = math.max(v15, v.Value);
                        end;
                    end;
                end;

                task.delay(v15, function() -- Line: 647
                    -- upvalues: u14 (ref), u9 (ref), u10 (ref)
                    if u14 and u14.Parent then
                        u14:Destroy();

                        for i, v in pairs(u9.ActiveEmitters[u10] or {}) do
                            if v == u14 then
                                table.remove(u9.ActiveEmitters[u10], i);

                                return;
                            end;
                        end;
                    end;
                end);
            end;
        end);
    end;
end;

function u1.destroy(p16) -- Line: 663
    for _, v in pairs(p16.ActiveEmitters) do
        for _, v2 in pairs(v) do
            v2:Destroy();
        end;
    end;

    p16.ActiveEmitters = {};
end;

return u1;