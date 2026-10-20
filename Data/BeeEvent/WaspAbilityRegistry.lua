-- Decompiled with Potassium's decompiler.

return {
    DreadhornCrush = {
        Name = "DreadhornCrush",
        Trigger = "OnHit",
        Cooldown = 5,
        StunDuration = 4,
        SlowDuration = 8,
        SpeedMultiplier = 0.25
    },
    AcidVenom = {
        Name = "AcidVenom",
        Trigger = "OnHit",
        Cooldown = 3,
        Duration = 7,
        TickInterval = 1,
        DamagePerTick = 1
    },
    WaspKingBoss = {
        Name = "WaspKingBoss",
        Trigger = "Routine",
        CastInterval = 5,
        Abilities = {
            StunShockwave = {
                Name = "StunShockwave",
                Cooldown = 18,
                Radius = 50,
                Damage = 15,
                StunDuration = 5
            },
            PoisonStrikes = {
                Name = "PoisonStrikes",
                Cooldown = 10,
                Radius = 50,
                ProjectileCount = 6,
                Duration = 10,
                TickInterval = 1,
                DamagePerTick = 2
            },
            SummonWasps = {
                Name = "SummonWasps",
                Cooldown = 25,
                MinCount = 3,
                MaxCount = 5,
                Duration = 15,
                WaspName = "Wasp"
            }
        }
    },
    HiveburnFlame = {
        Name = "HiveburnFlame",
        Trigger = "OnHit",
        Cooldown = 3,
        Duration = 6,
        TickInterval = 1,
        DamagePerTick = 1,
        FireballCooldown = 10,
        FireballRadius = 40,
        FireballDamage = 6,
        FireballDuration = 6,
        FireballTickInterval = 1,
        FireballDamagePerTick = 1,
        FireballProjectileDuration = 2
    },
    BloomveinHeal = {
        Name = "BloomveinHeal",
        Trigger = "Routine",
        Cooldown = 12,
        Radius = 55,
        HealPercent = 0.2
    },
    ThunderbuzzChain = {
        Name = "ThunderbuzzChain",
        Trigger = "OnHit",
        Cooldown = 8,
        Radius = 60,
        Bounces = 4,
        Damage = 3,
        SlowDuration = 4,
        SpeedMultiplier = 0.5,
        ProjectileDuration = 1
    },
    JuggerhornCrush = {
        Name = "JuggerhornCrush",
        Trigger = "OnHit",
        Cooldown = 4,
        Radius = 10,
        Damage = 15,
        StunDuration = 3,
        SlowDuration = 6,
        SpeedMultiplier = 0.2,
        KnockbackDistance = 15
    },
    WarsongCommand = {
        Name = "WarsongCommand",
        Trigger = "Routine",
        Cooldown = 8,
        Radius = 30,
        TargetCount = 3,
        DamageMultiplier = 1.1,
        SpeedMultiplier = 1.1
    }
};