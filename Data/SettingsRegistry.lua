-- Decompiled with Potassium's decompiler.

local v1 = {
    Audio = {
        Title = "Master Audio",
        Description = "Toggle all of your audio",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 0,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    Music = {
        Title = "Music",
        Description = "Toggle your Music",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 1,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    Sounds = {
        Title = "Sound Effects",
        Description = "Toggle your Sounds",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 2,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    FavoriteIcons = {
        Title = "Favorite Icons",
        Description = "Toggle favorite icons display on fruit",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 4,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    UIScale = {
        Title = "UI Size",
        Description = "Change the size of UI",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 5,
        Disabled = true,
        SettingsData = {
            Type = "Multiple",
            DefaultValue = "Auto",
            Options = { "Auto", "Normal", "Bigger", "Biggest" }
        }
    },
    GearShopButton = {
        Title = "Gear Shop Button",
        Description = "Teleport to the gear shop faster!",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 6,
        Disabled = true,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = false
        }
    },
    PetShopButton = {
        Title = "Pet Shop Button",
        Description = "Teleport to the pet shop faster!",
        BackgroundTexture = "http://www.roblox.com/asset/?id=109511942140479",
        LayoutOrder = 7,
        Disabled = true,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = false
        }
    },
    YourFarmIcon = {
        Title = "Your Farm Icon",
        Description = "Show the yellow indicator above your garden!",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 8,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    AutoCloseActivePetsUI = {
        Title = "Auto-Close Active Pets UI",
        Description = "Automatically close active pet ui.",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 9,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    KeepPetOnGround = {
        Title = "Keep Pet on Ground",
        Description = "Have your pets visually stay on the ground (May improve performance)",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 10,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = false
        }
    },
    PetUpdateRate = {
        Title = "Pet Update Rate",
        Description = "Change the speed which pets update!",
        BackgroundTexture = "http://www.roblox.com/asset/?id=85951736855597",
        LayoutOrder = 11,
        Disabled = true,
        SettingsData = {
            Type = "Slider",
            DefaultValue = 0.035,
            Scale = NumberRange.new(0.035, 1)
        }
    },
    PetScaling = {
        Title = "Garden Pet Scaling",
        Description = "Show pets in gardens at their real size (affects size only)",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 12,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    HeldPetScaling = {
        Title = "Held Pet Scaling",
        Description = "Show held pets at their real size (affects size only)",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 13,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    PetMutationVFX = {
        Title = "Pet Mutation VFX",
        Description = "Toggles all visual effects from pet mutations!",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 14,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    PlantableCollisions = {
        Title = "Plant Collisions",
        Description = "Toggle collisions with plants!",
        BackgroundTexture = "http://www.roblox.com/asset/?id=76649946815634",
        LayoutOrder = 15,
        Disabled = true,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    HeldFruitScaling = {
        Title = "Held Fruit Scaling",
        Description = "Toggle visual scaling of fruits you are holding (affects size only)",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 16,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    CropMutationVFX = {
        Title = "Crop Mutation VFX",
        Description = "Toggles all visual effects from crop mutations!",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 17,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    LowerPlantFXQuality = {
        Title = "Lower Plant FX Quality",
        Description = "Plants with FX like Octobloom will be affected (May improve performance)",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 18,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = false
        }
    },
    OtherPlayerBeeColonyVisibility = {
        Title = "Other Player\'s Bee Colony Visibility",
        Description = "Show or hide other players\' bee colonies.",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 19,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    BeeColonyFollowPlayer = {
        Title = "Bees Follow You",
        Description = "Bees stay at your farm instead of following you.",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 20,
        Disabled = true,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    RecieveGifts = {
        Title = "Receive Gifts",
        Description = "Players can send you gift requests!",
        BackgroundTexture = "http://www.roblox.com/asset/?id=96138528769349",
        LayoutOrder = 21,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    TradeRequests = {
        Title = "Trade Requests",
        Description = "Players can send you trade requests!",
        BackgroundTexture = "http://www.roblox.com/asset/?id=96138528769349",
        LayoutOrder = 22,
        Disabled = true,
        ServerManaged = true,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    Textures = {
        Title = "Textures",
        Description = "Might help with performance!",
        BackgroundTexture = "http://www.roblox.com/asset/?id=106644443200974",
        LayoutOrder = 23,
        Disabled = true,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    VisualEffects = {
        Title = "Visual Effects",
        Description = "Might help with performance!",
        BackgroundTexture = "http://www.roblox.com/asset/?id=107407961055661",
        LayoutOrder = 24,
        Disabled = true,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    PerformanceMode = {
        Title = "Performance Mode",
        Description = "(EXPERIMENTAL) Reduce lag at the cost of visual quality.",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 25,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = false
        }
    },
    Tips = {
        Title = "Tips",
        Description = "Show game tips in chat.",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 30,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    ToggleNotifications = {
        Title = "Toggle Notifications",
        Description = "Toggle those pesky notifications!",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 31,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    PetNotifications = {
        Title = "Pet Notifications",
        Description = "Show notifications about what your pets are doing.",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 32,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    },
    PlantPassiveNotifications = {
        Title = "Plant Passive Notifications",
        Description = "Show notifications when your plants\' passives activate.",
        BackgroundTexture = "http://www.roblox.com/asset/?id=139632749336322",
        LayoutOrder = 33,
        SettingsData = {
            Type = "Boolean",
            DefaultValue = true
        }
    }
};

for i, v in v1 do
    v.Name = i;
end;

return v1;