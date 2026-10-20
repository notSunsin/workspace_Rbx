-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local SaveSlotController = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);
local SlotServiceTypes = require(ReplicatedStorage.Types.SlotServiceTypes);
local DataService = require(ReplicatedStorage.Modules.DataService);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local BeeHiveController = require(ReplicatedStorage.Modules.BeeEventV2Controllers.BeeHiveController);
local _ = ReplicatedStorage.GameEvents.EventRotation.RotateNewEvent;
local PermanentEventSlots = SlotServiceTypes.PermanentEventSlots;
local UpdateService2 = ReplicatedStorage.Modules.UpdateService;
local u1 = nil;
local u2 = {};
local u3 = {};

local function BizzyBee2026Activation() -- Line: 34
    -- upvalues: CollectionService (copy), BeeHiveController (copy)
    local v4 = CollectionService:GetTagged("BizzyBee2026")[1];
    local QueenBee = v4:FindFirstChild("QueenBee", true);
    local v5 = QueenBee and QueenBee:FindFirstChildOfClass("AnimationController");

    if v5 then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://114152343019979";
        local Animation2 = Instance.new("Animation");
        Animation2.AnimationId = "rbxassetid://98706475150631";
        local u6 = v5:LoadAnimation(Animation);
        local u7 = v5:LoadAnimation(Animation2);
        u6.Looped = true;
        u6:Play();
        task.spawn(function() -- Line: 50
            -- upvalues: QueenBee (copy), u6 (copy), u7 (copy)
            while QueenBee:IsDescendantOf(game.Workspace) do
                task.wait(math.random(5, 15));
                u6:Stop(0.5);
                u7:Play();
                task.wait(u7.Length);
                u7:Stop();
                u6:Play();
            end;
        end);
    end;

    local u8 = v4:FindFirstChild("Wasp King Part 4", true);

    if u8 then
        task.wait(0.1);
        local v9 = u8:FindFirstChildOfClass("AnimationController");

        if v9 then
            v9 = v9:FindFirstChildOfClass("Animator");
        end;

        if v9 then
            local Animation = Instance.new("Animation");
            Animation.AnimationId = "rbxassetid://95829829014179";
            local Animation2 = Instance.new("Animation");
            Animation2.AnimationId = "rbxassetid://130312642230377";
            local u10 = v9:LoadAnimation(Animation);
            local u11 = v9:LoadAnimation(Animation2);
            u11:Play();
            u11:Stop();
            task.wait(0.1);
            u10.Looped = true;
            u10:Play();
            task.spawn(function() -- Line: 84
                -- upvalues: u8 (copy), u10 (copy), u11 (copy)
                while u8:IsDescendantOf(game.Workspace) do
                    task.wait(math.random(5, 15));
                    u10:Stop(0.5);
                    task.wait(0.5);
                    u11:Play();
                    task.wait(u11.Length > 0 and u11.Length or 2);
                    u11:Stop();
                    u10:Play();
                end;
            end);
        end;
    end;

    BeeHiveController:SpawnBees();
end;

function u2.IsCurrentPermanentEventSlot(p12) -- Line: 101
    -- upvalues: DataService (copy), PermanentEventSlots (copy)
    local Data = DataService:GetData();

    if Data then
        return PermanentEventSlots[Data.SaveSlots.SelectedSlot] and true or false;
    end;

    warn("No playerData found");

    return false;
end;

function u2.ActivateEvent(p13) -- Line: 120
    -- upvalues: DataService (copy), PermanentEventSlots (copy), u1 (ref), UpdateService2 (copy), u3 (copy), BizzyBee2026Activation (copy)
    local Data = DataService:GetData();

    if not Data then
        warn("No playerData found");

        return;
    end;

    local v14 = PermanentEventSlots[Data.SaveSlots.SelectedSlot];

    if not v14 then
        return;
    end;

    local PostEventConfig = v14.PostEventConfig;

    if not PostEventConfig then
        return;
    end;

    u1 = PostEventConfig.EventName;
    local v15 = UpdateService2:QueryDescendants((`.{u1}`));

    for _, child in workspace.Interaction.UpdateItems:GetChildren() do
        if not child:HasTag(u1) then
            child.Parent = UpdateService2;
            u3[child] = workspace.Interaction.UpdateItems;
        end;
    end;

    for _, child in workspace.Interaction:GetChildren() do
        if child ~= workspace.Interaction.UpdateItems and not child:HasTag(u1) then
            child.Parent = UpdateService2;
            u3[child] = workspace.Interaction;
        end;
    end;

    local v16 = script:FindFirstChild(PostEventConfig.EventName);

    if v16 then
        for _, child in v16:GetChildren() do
            table.insert(v15, child);
        end;
    end;

    for _, v in v15 do
        v.Parent = workspace.Interaction;
    end;

    if v14.PostEventConfig and v14.PostEventConfig.EventName == "BizzyBee2026" then
        BizzyBee2026Activation();
    end;
end;

function u2.DeactivateEvent(p17) -- Line: 190
    -- upvalues: u1 (ref), PermanentEventSlots (copy), UpdateService2 (copy), UpdateService (copy), u3 (copy)
    local v18 = {};

    if u1 then
        v18[u1] = true;
    end;

    for _, v in PermanentEventSlots do
        local PostEventConfig = v.PostEventConfig;

        if PostEventConfig and PostEventConfig.EventName then
            v18[PostEventConfig.EventName] = true;
        end;
    end;

    for i in v18 do
        local v19 = script:FindFirstChild(i);

        if v19 then
            for _, v in workspace.Interaction:QueryDescendants((`.{i}`)) do
                v.Parent = v19;
            end;

            for _, v in UpdateService2:QueryDescendants((`.{i}`)) do
                v.Parent = v19;
            end;
        else
            warn((`No folder to place Instances: {i}`));
        end;
    end;

    u1 = nil;

    for _, child in UpdateService2:GetChildren() do
        local v20 = child;
        local v21 = false;

        for i in v18 do
            if v20:HasTag(i) then
                v21 = true;
                break;
            end;
        end;

        if (UpdateService:IsUpdateDone() or (not v20:HasTag("UpdateItem") or v20:HasTag("EventRotation")) and ((not u3[v20] or u3[v20] ~= workspace.Interaction.UpdateItems) and u3[v20])) and not (v20:HasTag("DestroyAfterUpdate") and not v21 or v21) then
            if u3[v20] then
                v20.Parent = u3[v20];
                u3[v20] = nil;
            else
                v20.Parent = workspace.Interaction.UpdateItems;
            end;
        end;
    end;
end;

local function SyncEventSlot() -- Line: 271
    -- upvalues: u2 (copy)
    if u2:IsCurrentPermanentEventSlot() then
        u2:ActivateEvent();

        return;
    end;

    u2:DeactivateEvent();
end;

SaveSlotController:GetSaveSlotChangeSignal():Connect(function() -- Line: 285
    -- upvalues: u2 (copy)
    if u2:IsCurrentPermanentEventSlot() then
        u2:ActivateEvent();

        return;
    end;

    u2:DeactivateEvent();
end);
UpdateService.OnUpdated:Connect(function() -- Line: 291
    -- upvalues: u2 (copy)
    if u2:IsCurrentPermanentEventSlot() then
        u2:ActivateEvent();

        return;
    end;

    u2:DeactivateEvent();
end);
task.spawn(function() -- Line: 295
    -- upvalues: u2 (copy)
    u2:ActivateEvent();
end);

return u2;