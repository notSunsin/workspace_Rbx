-- Decompiled with Potassium's decompiler.

local DiggingTreasureModels = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("DiggingTreasureModels");
local u1 = {
    DEFAULT = {
        Square = {
            DimensionX = 2,
            DimensionY = 2,
            Model = DiggingTreasureModels.Default:FindFirstChild("Square"),
            RotationOffset = CFrame.Angles(0, 0, 0),
            RewardRotationOffset = CFrame.Angles(0, 0, 0)
        },
        Short = {
            DimensionX = 2,
            DimensionY = 1,
            Model = DiggingTreasureModels.Default:FindFirstChild("Short"),
            RotationOffset = CFrame.Angles(0, 0, -1.5707963267948966),
            RewardRotationOffset = CFrame.Angles(0, 0, -1.5707963267948966)
        },
        Long = {
            DimensionX = 4,
            DimensionY = 1,
            Model = DiggingTreasureModels.Default:FindFirstChild("Long"),
            RotationOffset = CFrame.Angles(0, 0, 0),
            RewardRotationOffset = CFrame.Angles(0, 1.5707963267948966, 0)
        },
        Rectangle = {
            DimensionX = 2,
            DimensionY = 3,
            Model = DiggingTreasureModels.Default:FindFirstChild("Rectangle"),
            RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
            RewardRotationOffset = CFrame.Angles(-1.5707963267948966, 3.141592653589793, 3.141592653589793)
        }
    },
    Christmas = {
        Square = {
            DimensionX = 2,
            DimensionY = 2,
            Model = DiggingTreasureModels.Christmas:FindFirstChild("SquareTreasure"),
            RotationOffset = CFrame.Angles(0, 0, 0),
            RewardRotationOffset = CFrame.Angles(0, 0, 0)
        },
        Short = {
            DimensionX = 2,
            DimensionY = 1,
            Model = DiggingTreasureModels.Christmas:FindFirstChild("SmallTreasure"),
            RotationOffset = CFrame.Angles(0, 0, -1.5707963267948966),
            RewardRotationOffset = CFrame.Angles(0, 0, -1.5707963267948966)
        },
        Long = {
            DimensionX = 4,
            DimensionY = 1,
            Model = DiggingTreasureModels.Christmas:FindFirstChild("LongTreasure"),
            RotationOffset = CFrame.Angles(0, 0, 0),
            RewardRotationOffset = CFrame.Angles(0, 1.5707963267948966, 0)
        },
        Rectangle = {
            DimensionX = 2,
            DimensionY = 3,
            Model = DiggingTreasureModels.Christmas:FindFirstChild("RectangleTreasure"),
            RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
            RewardRotationOffset = CFrame.Angles(-1.5707963267948966, 3.141592653589793, 3.141592653589793)
        }
    },
    HalloweenEvent = {
        Square = {
            DimensionX = 2,
            DimensionY = 2,
            Model = DiggingTreasureModels.Halloween:FindFirstChild("Square"),
            RotationOffset = CFrame.Angles(0, 0, 0),
            RewardRotationOffset = CFrame.Angles(0, 0, 0)
        },
        Short = {
            DimensionX = 2,
            DimensionY = 1,
            Model = DiggingTreasureModels.Halloween:FindFirstChild("Short"),
            RotationOffset = CFrame.Angles(0, 0, -1.5707963267948966),
            RewardRotationOffset = CFrame.Angles(0, 0, -1.5707963267948966)
        },
        Long = {
            DimensionX = 4,
            DimensionY = 1,
            Model = DiggingTreasureModels.Halloween:FindFirstChild("Long"),
            RotationOffset = CFrame.Angles(0, 0, 0),
            RewardRotationOffset = CFrame.Angles(0, 1.5707963267948966, 0)
        },
        Rectangle = {
            DimensionX = 2,
            DimensionY = 3,
            Model = DiggingTreasureModels.Halloween:FindFirstChild("Rectangle"),
            RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
            RewardRotationOffset = CFrame.Angles(-1.5707963267948966, 3.141592653589793, 3.141592653589793)
        }
    }
};

return {
    PickRandomTreasureKey = function(p2: string) -- Line: 153, Name: PickRandomTreasureKey
        -- upvalues: u1 (copy)
        local v3 = {};
        local v4 = u1[p2];

        if not v4 then
            v4 = u1.DEFAULT;
            warn("DiggingTreasureConfig | No theme found! Defaulting to [DEFAULT]");
        end;

        for i in v4 do
            table.insert(v3, i);
        end;

        return v3[Random.new():NextInteger(1, #v3)];
    end,

    TreasureConfigData = u1
};