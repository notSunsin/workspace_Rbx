-- Decompiled with Potassium's decompiler.

return {
    Simulation = {
        SimulationHertz = 30,
        StateHertz = 30,
        UnreliableHertz = 10,
        ClientHertz = 30
    },
    Spawning = {
        SpawnDuration = 2
    },
    Swarm = {
        SpreadBase = 6,
        SpreadPerBee = 0.05,
        HeightMin = 4,
        HeightMax = 8,
        SearchSize = Vector3.new(60, 30, 60),
        BobAmplitude = 0.8,
        BobFrequency = 3
    },
    Enemies = {
        GuardRadius = 10,
        AlertRadius = 15,
        AttackRadius = 4,
        AttackTriggerRadius = 4.3,
        AttackCooldownRadius = 7.5,
        AttackSpinMaxMagnitude = 0.1
    },
    Nesting = {
        EnterRange = 25,
        ExitRange = 40,
        HealRange = 1
    },
    Pollination = {
        ArriveDistance = 5,
        OrbitRadiusBase = 2,
        OrbitRadiusPerBee = 0.5,
        OrbitHeight = 3,
        OrbitSpeed = 1.5,
        MutationColor = "#ff9500",
        RarityThresholds = {
            Common = 10,
            Uncommon = 18,
            Rare = 30,
            Legendary = 45,
            Mythical = 65,
            Divine = 90,
            Prismatic = 120,
            Transcendent = 160
        },
        Tiers = { {
                Name = "Pollinated_Poor",
                BaseWeight = 50,
                QualityExponent = 0
            }, {
                Name = "Pollinated_Fair",
                BaseWeight = 35,
                QualityExponent = 0.5
            }, {
                Name = "Pollinated_Good",
                BaseWeight = 12,
                QualityExponent = 1.5
            }, {
                Name = "Pollinated_Godly",
                BaseWeight = 3,
                QualityExponent = 2
            } },
        PollenValueMulipliers = {
            Pollinated_Poor = 0.8,
            Pollinated_Fair = 1,
            Pollinated_Good = 1.5,
            Pollinated_Godly = 2
        }
    },
    Hatching = {
        TickInterval = 1
    },
    LOD = {
        Near = 60,
        Mid = 150,
        Far = 300
    },
    Test = {
        TotalBees = 20
    }
};