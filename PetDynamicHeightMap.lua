-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = {};
local SpatialHashmap = require(ReplicatedStorage.Modules.SpatialHashmap);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
local TwoPointCast = require(ReplicatedStorage.Modules.TwoPointCast);
local HEIGHT_MAP_CONFIG = require(ReplicatedStorage.Data.PetRegistry).PetConfig.HEIGHT_MAP_CONFIG;
local TOP_OFFSET = HEIGHT_MAP_CONFIG.TOP_OFFSET;
local BOTTOM_OFFSET = HEIGHT_MAP_CONFIG.BOTTOM_OFFSET;
local CHANGE_QUEUE_TIME = HEIGHT_MAP_CONFIG.CHANGE_QUEUE_TIME;
local RESET_AMOUNT_PER_QUEUE = HEIGHT_MAP_CONFIG.RESET_AMOUNT_PER_QUEUE;
local u2 = SpatialHashmap.new({
    Mode = "Vector2",
    Scale = HEIGHT_MAP_CONFIG.MAP_QUALITY
});
local Farm = workspace:WaitForChild("Farm");
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
CreateTagHandler({
    Tag = "PetTargetable",

    OnInstanceAdded = function(p3) -- Line: 31, Name: OnInstanceAdded
        -- upvalues: RaycastParams_new_ret (copy)
        RaycastParams_new_ret:AddToFilter(p3);
    end
});
CreateTagHandler({
    Tag = "PlayerCharacters",

    OnInstanceAdded = function(p4) -- Line: 38, Name: OnInstanceAdded
        -- upvalues: RaycastParams_new_ret (copy)
        RaycastParams_new_ret:AddToFilter(p4);
    end
});
CreateTagHandler({
    Tag = "PetModel",

    OnInstanceAdded = function(p5) -- Line: 45, Name: OnInstanceAdded
        -- upvalues: RaycastParams_new_ret (copy)
        RaycastParams_new_ret:AddToFilter(p5);
    end
});
CreateTagHandler({
    Tag = "TooBigPlantModel",

    OnInstanceAdded = function(p6) -- Line: 52, Name: OnInstanceAdded
        -- upvalues: RaycastParams_new_ret (copy)
        RaycastParams_new_ret:AddToFilter(p6);
    end
});

function v1.GetYForPosition(p7: table, p8) -- Line: 57
    -- upvalues: u2 (copy), TOP_OFFSET (copy), BOTTOM_OFFSET (copy), TwoPointCast (copy), RaycastParams_new_ret (copy)
    local One = u2:GetOne({
        Range = 1,
        Position = p8
    });
    local Vector3_new_ret = Vector3.new(p8.X, 0, p8.Y);

    if not One then
        local v9 = TwoPointCast(Vector3_new_ret + TOP_OFFSET, Vector3_new_ret + BOTTOM_OFFSET, RaycastParams_new_ret);

        if v9 then
            v9 = v9.Position.Y;
        end;

        if v9 then
            u2:Insert({
                Hashed = v9,
                Position = p8
            });
        end;
    end;

    return One;
end;

local function GetMaxModelSize(p10: userdata) -- Line: 83
    local ExtentsSize = p10:GetExtentsSize();

    return math.max(ExtentsSize.X, ExtentsSize.Z);
end;

local function GetVector2FromModel(p11: userdata) -- Line: 88
    local Position = p11:GetPivot().Position;

    return Vector2.new(Position.X, Position.Z);
end;

local u12 = {};

local function SetupPlant(u13: userdata) -- Line: 108
    -- upvalues: u12 (copy)
    if not u13:IsA("Model") then
        return warn("a non valid model cant be setup", u13);
    end;

    local ExtentsSize = u13:GetExtentsSize();

    if math.max(ExtentsSize.X, ExtentsSize.Z) > 20 then
        u13:AddTag("TooBigPlantModel");

        return;
    end;

    u13:WaitForChild("Grow"):WaitForChild("Age"):GetPropertyChangedSignal("Value"):Connect(function() -- Line: 120
        -- upvalues: u12 (ref), u13 (copy)
        u12[u13] = true;
    end);
end;

local function SetupFarm(p14: userdata) -- Line: 125
    -- upvalues: SetupPlant (copy), u12 (copy)
    local Important = p14:WaitForChild("Important");

    if not Important then
        return;
    end;

    local Plants_Physical = Important:WaitForChild("Plants_Physical");
    local Objects_Physical = Important:WaitForChild("Objects_Physical");

    for _, child in Plants_Physical:GetChildren() do
        task.spawn(function() -- Line: 131
            -- upvalues: SetupPlant (ref), child (copy)
            SetupPlant(child);
        end);
    end;

    Plants_Physical.ChildAdded:Connect(SetupPlant);
    Plants_Physical.ChildRemoved:Connect(function(p15) -- Line: 137
        -- upvalues: u12 (ref)
        if p15:HasTag("TooBigPlantModel") then
            return;
        end;

        u12[p15] = true;
    end);
    Objects_Physical.ChildRemoved:Connect(function(p16) -- Line: 142
        -- upvalues: u12 (ref)
        if p16:HasTag("TooBigPlantModel") then
            return;
        end;

        u12[p16] = true;
    end);
end;

local function ResetRange(p17: userdata) -- Line: 96
    -- upvalues: u2 (copy)
    if p17:HasTag("TooBigPlantModel") then
        return;
    end;

    if not p17:IsA("Model") then
        return warn("a non valid model that just cleaned up", p17);
    end;

    local Position = p17:GetPivot().Position;
    Vector2.new(Position.X, Position.Z);
    local v18 = {};
    local Position2 = p17:GetPivot().Position;
    v18.Position = Vector2.new(Position2.X, Position2.Z);
    local ExtentsSize = p17:GetExtentsSize();
    v18.Range = math.max(ExtentsSize.X, ExtentsSize.Z) * 1.5;
    u2:ClearNeighbors(v18);
end;

for _, child in Farm:GetChildren() do
    task.spawn(function() -- Line: 149
        -- upvalues: SetupFarm (copy), child (copy)
        SetupFarm(child);
    end);
end;

task.spawn(function() -- Line: 154
    -- upvalues: u12 (copy), ResetRange (copy), RESET_AMOUNT_PER_QUEUE (copy), CHANGE_QUEUE_TIME (copy)
    while true do
        local v19, v20, v21;
        v19, v20, v21 = u12, nil, nil;
        local v22 = 0;

        while true do
            local v23 = v19(v20, v21);

            if v23 == nil then
                break;
            end;

            v21 = v23;
            v22 = v22 + 1;
            ResetRange(v23);
            u12[v23] = nil;

            if RESET_AMOUNT_PER_QUEUE > v22 then
                continue;
            end;

            break;
        end;

        task.wait(CHANGE_QUEUE_TIME);
    end;
end);

return v1;