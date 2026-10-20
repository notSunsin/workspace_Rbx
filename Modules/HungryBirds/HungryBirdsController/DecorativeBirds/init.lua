-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local PetList = require(ReplicatedStorage.Data.PetRegistry).PetList;
local u1 = {};
u1.__index = u1;

function u1.new(p2: vector, p3: table?) -- Line: 34
    -- upvalues: u1 (copy)
    local v4 = setmetatable({}, u1);
    local v5 = p3 or {};
    v4.NestPosition = p2;
    v4.PetTypes = v5.PetTypes;
    v4.BirdCount = #v5.PetTypes or 1;
    v4.FlyRadius = v5.FlyRadius or 15;
    v4.FlyHeightMin = v5.FlyHeightMin or 8;
    v4.FlyHeightMax = v5.FlyHeightMax or 15;
    v4.FlySpeed = v5.FlySpeed or 2;
    v4.EatDuration = v5.EatDuration or 3;
    v4.DescentSpeed = v5.DescentSpeed or 2;
    v4.AscentSpeed = v5.AscentSpeed or 4;
    v4.Birds = {};
    v4.FoodItems = {};
    v4.Running = false;
    v4.Connection = nil;

    return v4;
end;

function u1.Start(u6) -- Line: 73
    -- upvalues: RunService (copy)
    if u6.Running then
        return;
    end;

    u6.Running = true;

    for i = 1, u6.BirdCount do
        u6:SpawnBird(i);
        local _ = i;
    end;

    u6.Connection = RunService.Heartbeat:Connect(function(p7) -- Line: 87
        -- upvalues: u6 (copy)
        u6:Update(p7);
    end);
end;

function u1.Stop(p8) -- Line: 93
    if not p8.Running then
        return;
    end;

    p8.Running = false;

    if p8.Connection then
        p8.Connection:Disconnect();
        p8.Connection = nil;
    end;

    for _, v in p8.Birds do
        if v.Model then
            v.Model:Destroy();
        end;
    end;

    table.clear(p8.Birds);
end;

function u1.SpawnBird(p9: table, p10: number) -- Line: 119
    -- upvalues: PetList (copy)
    local v11 = p9.PetTypes[p10];
    local v12 = PetList[v11];
    local v13 = script.PetModels:FindFirstChild(v11);

    if not (v12 and v13) then
        warn("Invalid pet type:", v11);

        return;
    end;

    local v14 = v13:Clone();
    v14.Name = "DecorativeBird_" .. p10;

    if v14.PrimaryPart then
        v14.PrimaryPart.Anchored = true;
        v14.PrimaryPart.CanCollide = false;
    end;

    local v15 = {
        State = "Flying",
        TargetFoodData = nil,
        Model = v14,
        Angle = p10 / p9.BirdCount * 3.141592653589793 * 2,
        Height = math.random(p9.FlyHeightMin, p9.FlyHeightMax),
        Speed = p9.FlySpeed + (math.random() - 0.5) * 0.5
    };
    local FlyPosition = p9:GetFlyPosition(v15.Angle, v15.Height);
    v14:PivotTo(CFrame.new(FlyPosition));
    v14.Parent = workspace;
    local AnimationController = v14:FindFirstChild("AnimationController");

    if AnimationController then
        AnimationController = AnimationController:FindFirstChild("Animator");
    end;

    if AnimationController and v12.Animations then
        v15.Animations = {};

        for i, v in v12.Animations do
            local v16 = AnimationController:LoadAnimation(v);
            v16.Looped = true;
            v15.Animations[i] = v16;
        end;

        if v15.Animations.Walk then
            v15.Animations.Walk:Play();
        elseif v15.Animations.Idle then
            v15.Animations.Idle:Play();
        end;
    end;

    table.insert(p9.Birds, v15);
end;

function u1.GetFlyPosition(p17: table, p18: number, p19: number) -- Line: 193
    local v20 = p17.NestPosition.X + math.cos(p18) * p17.FlyRadius;
    local v21 = p17.NestPosition.Z + math.sin(p18) * p17.FlyRadius;

    return Vector3.new(v20, p17.NestPosition.Y + p19, v21);
end;

function u1.Update(p22: table, p23: number) -- Line: 204
    for _, v in p22.Birds do
        if v.State == "Flying" then
            p22:UpdateFlying(v, p23);
        elseif v.State == "Descending" then
            p22:UpdateDescending(v, p23);
        elseif v.State == "Eating" then
            p22:UpdateEating(v, p23);
        elseif v.State == "Ascending" then
            p22:UpdateAscending(v, p23);
        end;
    end;

    p22:AssignBirdsToFood();
end;

function u1.GetUntargetedFood(p24) -- Line: 229
    for _, v in p24.FoodItems do
        local v25 = v;
        local v26 = false;

        for _, v2 in p24.Birds do
            if v2.TargetFoodData and v2.TargetFoodData.Food == v25 then
                v26 = true;
                break;
            end;
        end;

        if not v26 then
            return v25;
        end;
    end;

    return nil;
end;

function u1.AssignBirdsToFood(p27) -- Line: 258
    for _, v in p27.Birds do
        if v.State == "Flying" or v.State == "Ascending" then
            local UntargetedFood = p27:GetUntargetedFood();

            if UntargetedFood then
                v.State = "Descending";
                v.TargetFoodData = {
                    Callback = nil,
                    Food = UntargetedFood
                };
            end;
        end;
    end;
end;

function u1.UpdateFlying(p28: table, p29: table, p30: number) -- Line: 279
    p29.Angle = p29.Angle + p29.Speed * p30;
    local v31 = math.sin(p29.Angle * 2) * 0.5;
    local FlyPosition = p28:GetFlyPosition(p29.Angle, p29.Height + v31);
    local Pivot = p29.Model:GetPivot();
    local v32 = Pivot.Position:Lerp(FlyPosition, p30 * 5);
    local FlyPosition2 = p28:GetFlyPosition(p29.Angle + 0.1, p29.Height);
    local v33 = Pivot:Lerp(CFrame.lookAt(v32, FlyPosition2), p30 * 5);
    p29.Model:PivotTo(CFrame.new(v32) * (v33 - v33.Position));
end;

function u1.UpdateDescending(p34: table, p35: table, p36: number) -- Line: 302
    if not (p35.TargetFoodData or p35.TargetFoodData.Food) then
        p35.State = "Flying";

        return;
    end;

    local Pivot = p35.Model:GetPivot();
    local v37 = p35.TargetFoodData.Food.Position + Vector3.new(0, 0, 0);
    local v38 = Pivot.Position:Lerp(v37, p34.DescentSpeed * p36);
    local v39 = Pivot:Lerp(CFrame.lookAt(v38, v37), p36 * 8);
    p35.Model:PivotTo(CFrame.new(v38) * (v39 - v39.Position));

    if (v38 - v37).Magnitude < 0.5 then
        p35.State = "Eating";
        p35.EatStartTime = os.clock();

        if p35.Animations and p35.Animations.Idle then
            if p35.Animations.Walk then
                p35.Animations.Walk:Stop();
            end;

            p35.Animations.Idle:Play();
        end;
    end;
end;

function u1.UpdateEating(p40: table, p41: table, p42: number) -- Line: 348
    if os.clock() - p41.EatStartTime >= p40.EatDuration then
        p41.State = "Ascending";

        if p41.TargetFoodData and p41.TargetFoodData.Food then
            local table_find_ret = table.find(p40.FoodItems, p41.TargetFoodData.Food);

            if table_find_ret then
                table.remove(p40.FoodItems, table_find_ret);
            end;

            if p41.TargetFoodData.Food.Parent then
                p41.TargetFoodData.Food.Parent:Destroy();
            end;

            if p41.TargetFoodData.Callback then
                task.spawn(p41.TargetFoodData.Callback);
            end;
        end;

        p41.TargetFoodData = nil;

        if p41.Animations and p41.Animations.Walk then
            if p41.Animations.Idle then
                p41.Animations.Idle:Stop();
            end;

            p41.Animations.Walk:Play();
        end;
    end;
end;

function u1.UpdateAscending(p43: table, p44: table, p45: number) -- Line: 396
    local Pivot = p44.Model:GetPivot();
    local Position = Pivot.Position;
    local FlyPosition = p43:GetFlyPosition(p44.Angle, p44.Height);
    local v46 = Position:Lerp(FlyPosition, p43.AscentSpeed * p45);
    local FlyPosition2 = p43:GetFlyPosition(p44.Angle + 0.1, p44.Height);
    local v47 = Pivot:Lerp(CFrame.lookAt(v46, FlyPosition2), p45 * 5);
    p44.Model:PivotTo(CFrame.new(v46) * (v47 - v47.Position));

    if (v46 - FlyPosition).Magnitude < 1 then
        p44.State = "Flying";
    end;
end;

function u1.AddFood(p48: table, p49: userdata, p50: function?) -- Line: 421
    table.insert(p48.FoodItems, p49);
    local v51 = {};

    for _, v in p48.Birds do
        if v.State == "Flying" then
            table.insert(v51, v);
        end;
    end;

    if #v51 > 0 then
        local v52 = v51[math.random(1, #v51)];
        v52.State = "Descending";
        v52.TargetFoodData = {
            Food = p49,
            Callback = p50
        };
    end;
end;

function u1.RemoveFood(p53: table, p54: userdata) -- Line: 449
    local table_find_ret = table.find(p53.FoodItems, p54);

    if table_find_ret then
        table.remove(p53.FoodItems, table_find_ret);
    end;

    for _, v in p53.Birds do
        if v.TargetFoodData and v.TargetFoodData.Food == p54 then
            v.State = "Ascending";
            v.TargetFoodData = nil;
        end;
    end;
end;

return u1;