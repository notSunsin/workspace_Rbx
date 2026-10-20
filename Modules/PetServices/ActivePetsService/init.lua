-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Models");
local PetsPhysical = workspace:WaitForChild("PetsPhysical");
local TwoPointCast = require(ReplicatedStorage.Modules.TwoPointCast);
require(ReplicatedStorage.Modules.ExponentialScaler);
local ReplicationClass = require(ReplicatedStorage.Modules.ReplicationClass);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local AnimationEvents = ReplicatedStorage.Modules.PetServices.AnimationEvents;
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local PetSoundHandler = require(ReplicatedStorage.Modules.PetServices.PetSoundHandler);
local IsBadDeviceHeuristic = require(ReplicatedStorage.Modules.OptimisationControllers.IsBadDeviceHeuristic);
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry);
require(ReplicatedStorage.Types.PetTypes);
local u1 = IsBadDeviceHeuristic();

local function IsKeepPetOnGround() -- Line: 30
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetAttribute("KeepPetOnGround") == true;
end;

local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Farm };
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
local RaycastParams_new_ret2 = RaycastParams.new();
RaycastParams_new_ret2.FilterDescendantsInstances = { workspace.Interaction, workspace.BasePlate };
RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Include;
local PetVFXHandler = require(ReplicatedStorage.Modules.PetServices.PetVFXHandler);
require(ReplicatedStorage.Modules.DumpTable);
require(ReplicatedStorage.Modules.PlatformService);
local u2 = UserInputService.TouchEnabled and "Mobile" or "PC";
local u3 = {};

for _, descendant in AnimationEvents:GetDescendants() do
    if descendant:IsA("ModuleScript") then
        u3[descendant.Name] = require(descendant);
    end;
end;

local PetList = PetRegistry.PetList;
local ActivePetService = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("ActivePetService");
require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local ActivePetsService_Replicator = ReplicationClass.new("ActivePetsService_Replicator");
ActivePetsService_Replicator.DontStager = true;
ActivePetsService_Replicator:YieldUntilData();
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);

local function GetReplicatedData() -- Line: 100
    -- upvalues: ActivePetsService_Replicator (copy)
    return ActivePetsService_Replicator:YieldUntilData().Table;
end;

local u4 = {};
local u5 = {};
u4.ClientPetState = u5;
local u6 = {};
u4.ClientServerPetState = u6;

local function GetClientServerPetState(p7) -- Line: 114
    -- upvalues: u6 (copy)
    return u6[p7];
end;

local function GetServerPetFromReplicated(p8) -- Line: 119
    -- upvalues: ActivePetsService_Replicator (copy)
    local ServerPetStates = ActivePetsService_Replicator:YieldUntilData().Table.ServerPetStates;

    if ServerPetStates then
        return ServerPetStates[p8];
    end;

    return nil;
end;

local function GetServerPetDataFromReplicated(p9) -- Line: 129
    -- upvalues: ActivePetsService_Replicator (copy)
    local ServerPetData = ActivePetsService_Replicator:YieldUntilData().Table.ServerPetData;

    if ServerPetData then
        return ServerPetData[p9];
    end;

    return nil;
end;

local function WeldInPlace(p10, p11) -- Line: 138
    if p10 and p11 then
        local Weld = Instance.new("Weld");
        Weld.Part0 = p10;
        Weld.Part1 = p11;
        Weld.Name = "Weld";
        Weld.Parent = p11;
        Weld.Name = `{p10.Name}_{p11.Name}_WELD`;

        return Weld;
    end;
end;

local function GetClientPetState(p12) -- Line: 155
    -- upvalues: u5 (copy)
    local v13 = u5[p12];

    if not v13 then
        v13 = {};
        u5[p12] = v13;
    end;

    return v13;
end;

local function GetChubbyChipmunkScale(p14: number) -- Line: 166
    return (math.clamp(p14, 1, 50) - 1) * 0.20408163265306123 + 1;
end;

local function GetClampedLevel(p15) -- Line: 173
    return math.min(p15.Level or 1, 100);
end;

local function RestartCurrentPetAnimation(p16, p17) -- Line: 178
    -- upvalues: u3 (copy)
    local CurrentAnimation = p16.CurrentAnimation;

    if CurrentAnimation then
        local v18 = u3[CurrentAnimation.Name];

        if v18 then
            v18 = v18.AnimationEnded;
        end;

        if v18 then
            v18(p17);
        end;
    end;

    local LoadedAnimations = p16.LoadedAnimations;

    if LoadedAnimations then
        for _, v in LoadedAnimations do
            v:Stop(0);
        end;
    end;

    p16.CurrentAnimation = nil;
    p16.LastAnimationState = nil;
    p16.LastAngles = nil;
end;

local function ApplyPetScale(p19: any, p20: userdata, p21: number, p22: string) -- Line: 202
    -- upvalues: RestartCurrentPetAnimation (copy)
    local math_max_ret = math.max(0.01, p21);

    if p19.LastScale == math_max_ret then
        return;
    end;

    p20:ScaleTo(math_max_ret);
    p19.LastScale = math_max_ret;
    p19.LastYHeight = nil;
    RestartCurrentPetAnimation(p19, p22);
end;

local function RemoveServerPet(p23) -- Line: 217
    -- upvalues: u6 (copy), u3 (copy)
    local v24 = u6[p23];

    if not v24 then
        return;
    end;

    if v24.PetSoundHandler then
        v24.PetSoundHandler:destroy();
    end;

    if v24.Asset then
        v24.Asset:Destroy();
    end;

    if v24.Model then
        v24.Model:Destroy();
    end;

    local CurrentAnimation = v24.CurrentAnimation;

    if CurrentAnimation then
        local v25 = u3[CurrentAnimation.Name];

        if v25 and v25.AnimationEnded then
            v25.AnimationEnded(p23);
        end;

        CurrentAnimation:Stop();
    end;

    u6[p23] = nil;
end;

local function CreateServerPet(u26) -- Line: 254
    -- upvalues: ActivePetsService_Replicator (copy), u6 (copy), PetsPhysical (copy), PetList (copy), LocalPlayer (copy), u2 (copy), PetSoundHandler (copy), PetVFXHandler (copy), RemoveServerPet (copy)
    local ServerPetStates = ActivePetsService_Replicator:YieldUntilData().Table.ServerPetStates;
    local v27;

    if ServerPetStates then
        v27 = ServerPetStates[u26];
    else
        v27 = nil;
    end;

    local ServerPetData = ActivePetsService_Replicator:YieldUntilData().Table.ServerPetData;
    local v28;

    if ServerPetData then
        v28 = ServerPetData[u26];
    else
        v28 = nil;
    end;

    if not (v27 and v28) then
        return nil;
    end;

    if u6[u26] then
        return u6[u26];
    end;

    local v29 = PetsPhysical:WaitForChild(u26, 2);

    if not v29 then
        return nil;
    end;

    local PetType = v28.PetType;
    local v30 = PetList[PetType];

    if not v30 then
        warn("Server pet type not found:", PetType);

        return nil;
    end;

    local Part = Instance.new("Part");
    Part.Size = Vector3.new(2, 2, 2);
    Part.Transparency = 1;
    Part.Material = Enum.Material.Neon;
    Part.Color = Color3.fromRGB(255, 14, 243);
    Part.Anchored = true;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part:AddTag("PetTargetable");
    Part:AddTag("ServerPet");
    Part:SetAttribute("UUID", u26);
    Part:SetAttribute("IsServerOwned", true);
    Part.Name = "ServerPetMover";
    Part.CanCollide = false;
    local PetData = v28.PetData;
    local v31 = (PetData.BaseWeight or 1) + v30.ModelScalePerLevel * (PetData.Level or 1);
    Part:PivotTo(v27.CurrentCFrame or CFrame.new(0, 5, 0));
    local v32 = {
        IsServerOwned = true,
        Asset = Part,
        LoadedAnimations = {},
        PetType = PetType
    };
    u6[u26] = v32;
    local _ = v30.Variant;

    if LocalPlayer:GetAttribute("PetScaling") == false then
        v29:ScaleTo(1);
    else
        v29:ScaleTo((math.max(0.1, v31)));
    end;

    v29:AddTag("PetModel");
    v29:AddTag("ServerPetModel");

    if not v29.PrimaryPart then
        warn(v29, "Server pet missing PrimaryPart");
        Part:Destroy();
        u6[u26] = nil;

        return nil;
    end;

    local PrimaryPart = v29.PrimaryPart;
    local v33;

    if PrimaryPart and Part then
        v33 = Instance.new("Weld");
        v33.Part0 = PrimaryPart;
        v33.Part1 = Part;
        v33.Name = "Weld";
        v33.Parent = Part;
        v33.Name = `{PrimaryPart.Name}_{Part.Name}_WELD`;
    else
        v33 = nil;
    end;

    v33.C1 = v33.C1 * v30.WeldOffset;
    v32.Model = v29;
    local AnimationController = v29:FindFirstChild("AnimationController");

    if AnimationController then
        AnimationController = AnimationController:FindFirstChild("Animator");
    end;

    if AnimationController then
        local u34 = {};
        v32.LoadedAnimations = u34;

        for i, v in v30.Animations do
            task.spawn(function() -- Line: 350
                -- upvalues: AnimationController (copy), v (copy), u34 (copy), i (copy)
                local v35 = AnimationController:LoadAnimation(v);
                v35.Looped = true;
                u34[i] = v35;

                if i == "Idle" then
                    v35:Play();
                end;
            end);
        end;
    end;

    if u2 == "PC" then
        v32.PetSoundHandler = PetSoundHandler.new(PetType, v29, u26);
    end;

    v32.PetVFXHandler = PetVFXHandler.new(PetType, v29, u26);
    v29.PrimaryPart.Anchored = false;
    v29.Parent = Part;
    Part.Parent = PetsPhysical;
    v29.Destroying:Once(function() -- Line: 372
        -- upvalues: RemoveServerPet (ref), u26 (copy)
        RemoveServerPet(u26);
    end);

    return v32;
end;

local function CreatePetWithScale(p36, p37, p38) -- Line: 379
    -- upvalues: u5 (copy), ActivePetsService_Replicator (copy), PetList (copy), PetsPhysical (copy), u4 (copy), Players (copy), PetUtilities (copy), LocalPlayer (copy), TwoPointCast (copy), RaycastParams_new_ret (copy), u2 (copy), PetSoundHandler (copy), PetVFXHandler (copy)
    local v39 = u5[p36];

    if not v39 then
        v39 = {};
        u5[p36] = v39;
    end;

    if not v39 then
        local v40 = tonumber(p36);
        v39 = u5[v40];

        if not v39 then
            v39 = {};
            u5[v40] = v39;
        end;
    end;

    local v41 = v39[p37];
    local PlayerPetData = ActivePetsService_Replicator:YieldUntilData().Table.PlayerPetData;
    local v42 = (PlayerPetData[p36] or PlayerPetData[tonumber(p36)]).PetInventory.Data[p37];
    local v43 = PetList[v42.PetType];

    if v43 then
        local _ = v43.Model;
    end;

    local Asset = v41.Asset;

    if not Asset then
        return;
    end;

    local Model = v41.Model;

    if Model then
        Model:Destroy();
    end;

    local v44 = PetsPhysical:WaitForChild(p37);

    if not v44 then
        return;
    end;

    local u45 = v44;
    local _ = v43.Variant;
    local v46 = u4:CalculateBoost(Players:FindFirstChild(p36), p37, "SIZE_MODIFICATION") or 1;
    local PetType = v42.PetType;
    local math_min_ret = math.min(v42.PetData.Level or 1, 100);
    local v47 = PetUtilities:CalculateWeight(v42.PetData.BaseWeight or 1, math_min_ret);

    if PetType == "Chubby Chipmunk" then
        p38 = (math.clamp(v47, 1, 50) - 1) * 0.20408163265306123 + 1;
    end;

    local v48 = Players.LocalPlayer:GetAttribute("PetScaling") == false and 1 or math.max(0.1, p38) * v46;
    u45:ScaleTo(v48);
    v41.LastScale = v48;
    local u49;

    if LocalPlayer:GetAttribute("KeepPetOnGround") == true then
        u49 = 0;
    else
        local v50 = TwoPointCast(Asset.Position + Vector3.new(0, 1, 0), Asset.Position - Vector3.new(0, 1, 0), RaycastParams_new_ret);
        u49 = v50 and v50.Position.Y or 0;
    end;

    local function SetPivotToBoundsOffset() -- Line: 449
        -- upvalues: u45 (ref), Asset (copy), u49 (ref)
        if not (u45 and Asset) then
            return;
        end;

        local Pivot = u45:GetPivot();
        local BoundingBox, v51 = u45:GetBoundingBox();
        u45:PivotTo(Asset.CFrame * CFrame.new(0, u49 + v51.Y / 2 + (BoundingBox.Position - Pivot.Position).Y, 0));
    end;

    SetPivotToBoundsOffset();
    u45:AddTag("PetModel");
    local v52;

    if u2 == "PC" then
        v52 = PetSoundHandler.new(PetType, u45, p37);
    else
        v52 = false;
    end;

    v41.PetSoundHandler = v52;
    PetVFXHandler.new(PetType, u45, p37);
    v41.PetVFXHandler = PetVFXHandler.new(PetType, u45, p37);

    if u45.PrimaryPart then
        local PrimaryPart = u45.PrimaryPart;
        local v53;

        if PrimaryPart and Asset then
            v53 = Instance.new("Weld");
            v53.Part0 = PrimaryPart;
            v53.Part1 = Asset;
            v53.Name = "Weld";
            v53.Parent = Asset;
            v53.Name = `{PrimaryPart.Name}_{Asset.Name}_WELD`;
        else
            v53 = nil;
        end;

        v53.C1 = v53.C1 * v43.WeldOffset;
        v41.Model = u45;
        local AnimationController = u45:FindFirstChild("AnimationController");

        if AnimationController then
            AnimationController = AnimationController:FindFirstChild("Animator");
        end;

        if AnimationController then
            local u54 = {};
            v41.LoadedAnimations = u54;

            for i, v in v43.Animations do
                task.spawn(function() -- Line: 487
                    -- upvalues: AnimationController (copy), v (copy), u54 (copy), i (copy), SetPivotToBoundsOffset (copy)
                    local v55 = AnimationController:LoadAnimation(v);
                    v55.Looped = true;
                    u54[i] = v55;

                    if i == "Idle" then
                        v55:Play();
                    end;

                    task.defer(SetPivotToBoundsOffset);
                end);
            end;
        end;

        return u45;
    end;

    warn(u45, "DOES NOT HAVE A PRIMARY_PART??");
end;

local function RemovePet(p56, p57) -- Line: 504
    -- upvalues: u5 (copy), u3 (copy)
    local v58 = u5[p56];

    if not v58 then
        v58 = {};
        u5[p56] = v58;
    end;

    local v59 = v58[p57];

    if v59 then
        if v59.PetSoundHandler then
            v59.PetSoundHandler:destroy();
        end;

        v59.Asset:Destroy();
        local Model = v59.Model;

        if Model then
            Model:Destroy();
        end;
    end;

    local CurrentAnimation = v59.CurrentAnimation;

    if CurrentAnimation then
        local v60 = u3[CurrentAnimation.Name];

        if v60 then
            v60 = v60.AnimationEnded;
        end;

        if v60 then
            v60(p57);
        end;

        CurrentAnimation:Stop();
    end;

    v58[p57] = nil;
end;

local function GetPet(p61, u62) -- Line: 538
    -- upvalues: u5 (copy), Players (copy), GetFarm (copy), PetsPhysical (copy), ActivePetsService_Replicator (copy), PetList (copy), PetUtilities (copy), LocalPlayer (copy), TwoPointCast (copy), RaycastParams_new_ret (copy), CreatePetWithScale (copy), RemovePet (copy)
    local u63 = tostring(p61);
    local v64 = u63;
    local v65 = u5[v64];

    if not v65 then
        v65 = {};
        u5[v64] = v65;
    end;

    if not v65 then
        local v66 = tonumber(u63);
        v65 = u5[v66];

        if not v65 then
            v65 = {};
            u5[v66] = v65;
        end;
    end;

    local v67 = v65[u62];
    local v68 = Players:FindFirstChild(u63);

    if not v68 then
        return;
    end;

    local v69 = GetFarm(v68);

    if v69 then
        if not v67 then
            local v70 = PetsPhysical:WaitForChild(u62, 2);

            if not v70 then
                return nil;
            end;

            local Part = Instance.new("Part");
            Part.Size = Vector3.new(2, 2, 2);
            Part.Transparency = 1;
            Part.Material = Enum.Material.Neon;
            Part.Color = Color3.fromRGB(15, 119, 255);
            Part.Anchored = true;
            Part.CanQuery = false;
            Part:AddTag("PetTargetable");
            Part:SetAttribute("UUID", u62);
            Part:SetAttribute("OWNER", (tostring(u63)));
            Part.Name = "PetMover";
            Part.CanCollide = false;
            local Table = ActivePetsService_Replicator:YieldUntilData().Table;
            local PlayerPetData = Table.PlayerPetData;
            local ActivePetStates = Table.ActivePetStates;
            local v71 = PlayerPetData[u63] or PlayerPetData[tonumber(u63)];

            if not v71 then
                return;
            end;

            local PetInventory = v71.PetInventory;

            if not PetInventory then
                return;
            end;

            local v72 = PetInventory.Data[u62];

            if not v72 then
                return;
            end;

            local PetType = v72.PetType;
            local v73 = PetList[PetType];

            if v73 then
                local _ = v73.Model;
            end;

            if PlayerPetData.PetType == "Chubby Chipmunk" then
                local v74 = PetUtilities:CalculateWeight(PlayerPetData.PetData.BaseWeight, PlayerPetData.PetData.Level, PlayerPetData.PetType);

                if v74 < 2 then
                    local _ = v73.Model;
                elseif v74 < 15 then
                    local _ = v73.Model2;
                elseif v74 < 30 then
                    local _ = v73.Model3;
                elseif v74 < 40 then
                    local _ = v73.Model4;
                else
                    local _ = v73.Model5;
                end;
            end;

            local BaseWeight = v72.PetData.BaseWeight;

            if not v73 then
                warn(PetType, "does not have foundpettypedata");

                return;
            end;

            local v75 = BaseWeight + v73.ModelScalePerLevel * v72.PetData.Level;
            local PetArea = v69:FindFirstChild("PetArea");
            local v76 = (ActivePetStates[u63] or ActivePetStates[tonumber(u63)])[u62];

            if not v76 then
                return;
            end;

            local v77 = LocalPlayer:GetAttribute("PetScaling") == false and 1 or v75;
            local v78;

            if LocalPlayer:GetAttribute("KeepPetOnGround") == true then
                v78 = 0;
            else
                v78 = TwoPointCast(Part.Position + Vector3.new(0, 2, 0), Part.Position - Vector3.new(0, 2, 0), RaycastParams_new_ret);

                if v78 then
                    v78 = v78.Position.Y;
                end;
            end;

            local v79 = (v78 or 0) + (v73.YHeightScaler or 0) * v77;
            Part:PivotTo(v73.MovementType == "Grounded" and CFrame.new(v76.CurrentCFrame.X, v79, v76.CurrentCFrame.Z) or (v76.CurrentCFrame or PetArea.CFrame));
            v65[u62] = {
                Asset = Part,
                LoadedAnimations = {}
            };
            local v80 = CreatePetWithScale(u63, u62, v75);

            if not v80 then
                Part:Destroy();
                v65[u62] = nil;

                return nil;
            end;

            v70:PivotTo(v80:GetPivot() * CFrame.new(0, v79 + v80:GetExtentsSize().Y, 0));
            v70.PrimaryPart.Anchored = false;
            v70.Parent = Part;
            Part.Parent = PetsPhysical;
            v70.Destroying:Once(function() -- Line: 682
                -- upvalues: RemovePet (ref), u63 (ref), u62 (copy)
                RemovePet(u63, u62);
            end);
        end;

        return v67;
    end;
end;

local function RemoveClientPetState(p81) -- Line: 690
    -- upvalues: u5 (copy), RemovePet (copy)
    local v82 = u5[p81];

    if not v82 then
        v82 = {};
        u5[p81] = v82;
    end;

    if v82 then
        for i in v82 do
            RemovePet(p81, i);
        end;
    end;

    u5[p81] = nil;
end;

local function UpdateServerPetsRegistry() -- Line: 702
    -- upvalues: ActivePetsService_Replicator (copy), u6 (copy), RemoveServerPet (copy), CreateServerPet (copy)
    local v83 = ActivePetsService_Replicator:YieldUntilData().Table.ServerPetStates or {};

    for i in u6 do
        if not v83[i] then
            RemoveServerPet(i);
        end;
    end;

    for i in v83 do
        if not u6[i] then
            CreateServerPet(i);
        end;
    end;
end;

local function UpdateRegistry() -- Line: 721
    -- upvalues: ActivePetsService_Replicator (copy), u5 (copy), RemovePet (copy), u1 (copy), LocalPlayer (copy), PetsPhysical (copy), GetPet (copy), UpdateServerPetsRegistry (copy)
    local ActivePetStates = ActivePetsService_Replicator:YieldUntilData().Table.ActivePetStates;

    for i, v in u5 do
        local v84 = tostring(i);
        local v85 = ActivePetStates[v84] or ActivePetStates[tonumber(v84)];

        if v85 then
            for i2 in v do
                if not v85[i2] then
                    RemovePet(v84, i2);
                end;
            end;
        else
            local v86 = u5[v84];

            if not v86 then
                v86 = {};
                u5[v84] = v86;
            end;

            if v86 then
                for i2 in v86 do
                    RemovePet(v84, i2);
                end;
            end;

            u5[v84] = nil;
        end;
    end;

    for i, v in ActivePetStates do
        local v87 = tostring(i);

        if u1 and v87 ~= LocalPlayer.Name then
            for i2 in v do
                task.spawn(function() -- Line: 746
                    -- upvalues: PetsPhysical (ref), i2 (copy)
                    local v88 = PetsPhysical:WaitForChild(i2, 0.5);

                    if v88 then
                        v88:Destroy();
                    end;
                end);
            end;
        else
            for i2 in v do
                GetPet(v87, i2);
            end;
        end;
    end;

    UpdateServerPetsRegistry();
end;

local _ = workspace:WaitForChild("BasePlate").Baseplate;

local function GetPredictedPosition(p89: vector, p90: vector, p91: number, p92: number) -- Line: 769
    local v93 = (p90 - p89).Magnitude / p92;
    local v94 = os.clock() - p91;

    if v93 <= v94 then
        return p90;
    end;

    return p89:Lerp(p90, v94 / v93);
end;

local u95 = {};
local u96 = {};
local u97 = 0;
local u98 = false;

local function UpdatePositioning(p99) -- Line: 785
    -- upvalues: u97 (ref), u96 (copy), u95 (copy), ActivePetsService_Replicator (copy), u5 (copy), u1 (copy), LocalPlayer (copy), PetList (copy), PetUtilities (copy), u4 (copy), Players (copy), RestartCurrentPetAnimation (copy), TwoPointCast (copy), RaycastParams_new_ret (copy), u2 (copy), u3 (copy), u6 (copy), RaycastParams_new_ret2 (copy)
    u97 = 0;
    table.clear(u96);
    table.clear(u95);
    local Table = ActivePetsService_Replicator:YieldUntilData().Table;
    local ActivePetStates = Table.ActivePetStates;
    local PlayerPetData = Table.PlayerPetData;
    local v100 = Table.ServerPetStates or {};
    local v101 = Table.ServerPetData or {};

    for i, v in u5 do
        if not u1 or i == LocalPlayer.Name then
            local v102 = tostring(i);
            local v103 = ActivePetStates[v102] or ActivePetStates[tonumber(v102)];

            if v103 then
                for i2, v2 in v do
                    local v104 = v103[i2];

                    if v104 then
                        local Asset = v2.Asset;
                        local CurrentCFrame = v104.CurrentCFrame;

                        if CurrentCFrame then
                            local Magnitude = (CurrentCFrame.Position - Asset.Position).Magnitude;

                            if ((u5.LastUpdatedPosition or CurrentCFrame.Position) - Asset.Position).Magnitude > 2 or v2.IsNotFirstTime then
                                v2.LastUpdatedPosition = Asset.Position;
                                v2.IsNotFirstTime = true;
                                local v105 = Asset:FindFirstChildWhichIsA("Model", true);
                                local v106 = PlayerPetData[v102] or PlayerPetData[tonumber(v102)];

                                if v106 then
                                    local v107 = v106.PetInventory.Data[i2];
                                    local v108;

                                    if v105 then
                                        v108 = v105.PrimaryPart;
                                    else
                                        v108 = v105;
                                    end;

                                    if v108 and v107 then
                                        local PetType = v107.PetType;
                                        local v109 = PetList[PetType];
                                        local MovementType = v109.MovementType;
                                        local BaseWeight = v107.PetData.BaseWeight;
                                        local math_clamp_ret = math.clamp(v104.MovementSpeed * p99 / Magnitude, 0, 1);
                                        local v110 = Asset.Position:Lerp(CurrentCFrame.Position, math_clamp_ret);
                                        local math_min_ret = math.min(v107.PetData.Level or 1, 100);
                                        local v111 = PetUtilities:CalculateWeight(v107.PetData.BaseWeight or 1, math_min_ret);
                                        local v112;

                                        if PetType == "Chubby Chipmunk" then
                                            v112 = (math.clamp(v111, 1, 50) - 1) * 0.20408163265306123 + 1;
                                        else
                                            v112 = BaseWeight + v109.ModelScalePerLevel * math_min_ret;
                                        end;

                                        local v113 = v112 * (u4:CalculateBoost(Players:FindFirstChild(v102), i2, "SIZE_MODIFICATION") or 1);
                                        local v114 = LocalPlayer:GetAttribute("PetScaling") == false and 1 or v113;
                                        local math_max_ret = math.max(0.01, v114);

                                        if v2.LastScale ~= math_max_ret then
                                            v105:ScaleTo(math_max_ret);
                                            v2.LastScale = math_max_ret;
                                            v2.LastYHeight = nil;
                                            RestartCurrentPetAnimation(v2, i2);
                                        end;

                                        local Size = v108.Size;
                                        local v115;

                                        if LocalPlayer:GetAttribute("KeepPetOnGround") == true then
                                            v115 = 0;
                                        else
                                            v115 = TwoPointCast(Asset.Position + Vector3.new(0, 2, 0), Asset.Position - Vector3.new(0, 2, 0), RaycastParams_new_ret);

                                            if v115 then
                                                v115 = v115.Position.Y;
                                            end;
                                        end;

                                        local v116 = v115 or 0;
                                        local math_lerp_ret = math.lerp(v2.LastYHeight or v116, v116, 5 * p99);
                                        v2.LastYHeight = math_lerp_ret;
                                        local v117 = (v109.YHeightScaler or 0) * v114;
                                        local v118;

                                        if MovementType == "Grounded" then
                                            v118 = CFrame.new(v110.X, (math_lerp_ret or 0) + v117 + Size.Y / 2, v110.Z);
                                        else
                                            v118 = CFrame.new(v110);
                                        end;

                                        local Position = v108.Position;
                                        local Position2 = CurrentCFrame.Position;
                                        local v119;

                                        if MovementType == "Grounded" then
                                            v119 = (Vector2.new(Position.X, Position.Z) - Vector2.new(Position2.X, Position2.Z)).Magnitude <= 2.5;
                                        else
                                            v119 = false;
                                        end;

                                        local v120;

                                        if MovementType == "Flight" then
                                            v120 = (Position - Position2).Magnitude <= 1;
                                        else
                                            v120 = false;
                                        end;

                                        local v121 = v104.CustomAnimationState or ((v120 or v119) and "Idle" or "Walk");

                                        if not v2.LastAnimationState or v2.LastAnimationState ~= v121 then
                                            if u2 == "PC" and v2.PetSoundHandler then
                                                v2.PetSoundHandler:playSound(v121);
                                            end;

                                            v2.PetVFXHandler:playVFX(v121);
                                            v2.LastAnimationState = v121;
                                        end;

                                        local LoadedAnimations = v2.LoadedAnimations;
                                        local v122 = LoadedAnimations[v121];
                                        local CurrentAnimation = v2.CurrentAnimation;
                                        local v123;

                                        if CurrentAnimation == v122 or not v122 then
                                            v123 = v2;
                                        else
                                            v105:FindFirstChild("AnimationController");
                                            v123 = v2;
                                            local v124 = i2;

                                            for _, v3 in LoadedAnimations do
                                                v3:Stop();
                                            end;

                                            if CurrentAnimation then
                                                local v125 = u3[CurrentAnimation.Name];

                                                if v125 then
                                                    v125 = v125.AnimationEnded;
                                                end;

                                                if v125 then
                                                    v125(v124);
                                                end;

                                                CurrentAnimation:Stop();
                                            end;

                                            v123.CurrentAnimation = v122;

                                            if v122 then
                                                local v126 = u3[v122.Name];

                                                if v126 then
                                                    v126 = v126.AnimationStarted;
                                                end;

                                                if v126 then
                                                    v126(v124);
                                                end;

                                                v122:Play();
                                            end;
                                        end;

                                        if v123.LastTargetCFrame == CurrentCFrame and v123.LastAngles then
                                            u97 = u97 + 1;
                                            u95[u97] = Asset;
                                            u96[u97] = v118 * v123.LastAngles;
                                        else
                                            local v127, v128, v129 = (MovementType == "Grounded" and PetUtilities:GetLookAt(Asset.Position, CurrentCFrame.Position) or CFrame.new(Asset.Position, CurrentCFrame.Position)):ToEulerAnglesXYZ();

                                            if v127 ~= v127 or (v128 ~= v128 or v129 ~= v129) then
                                                v127 = 0;
                                                v128 = 0;
                                                v129 = 0;
                                            end;

                                            local CFrame_Angles_ret = CFrame.Angles(v127, v128, v129);
                                            local v130 = (v123.LastAngles or CFrame_Angles_ret):Lerp(CFrame_Angles_ret, 6 * p99);
                                            u97 = u97 + 1;
                                            u95[u97] = Asset;
                                            u96[u97] = v118 * v130;
                                            v123.LastAngles = v130;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    for i, v in u6 do
        local v131 = v100[i];

        if v131 then
            local v132 = v101[i];

            if v132 then
                local Asset = v.Asset;

                if Asset then
                    local CurrentCFrame = v131.CurrentCFrame;

                    if CurrentCFrame then
                        local v133 = PetList[v132.PetType];

                        if v133 then
                            local Model = v.Model;

                            if Model then
                                Model = Model.PrimaryPart;
                            end;

                            if Model then
                                local v134 = v131.MovementSpeed or 10;
                                local MovementType = v133.MovementType;
                                local Magnitude = (CurrentCFrame.Position - Asset.Position).Magnitude;

                                if Magnitude < 0.1 then
                                    u97 = u97 + 1;
                                    u95[u97] = Asset;
                                    u96[u97] = Asset.CFrame;
                                else
                                    local math_clamp_ret = math.clamp(v134 * p99 / Magnitude, 0, 1);
                                    local v135 = Asset.Position:Lerp(CurrentCFrame.Position, math_clamp_ret);
                                    local Vector3_new_ret = Vector3.new(v135.X, 500, v135.Z);
                                    local v136 = workspace:Raycast(Vector3_new_ret, Vector3.new(0, -1000, 0), RaycastParams_new_ret2);
                                    local v137 = v.LastYHeight or Asset.Position.Y;

                                    if v136 then
                                        v137 = v136.Position.Y;
                                    end;

                                    local math_lerp_ret = math.lerp(v.LastYHeight or v137, v137, 5 * p99);
                                    v.LastYHeight = math_lerp_ret;
                                    local Size = Model.Size;
                                    local v138 = v133.YHeightScaler or 0;
                                    local v139;

                                    if MovementType == "Grounded" then
                                        v139 = CFrame.new(v135.X, math_lerp_ret + v138 + Size.Y / 2, v135.Z);
                                    else
                                        v139 = CFrame.new(v135);
                                    end;

                                    local v140 = Magnitude <= 2.5 and "Idle" or "Walk";

                                    if v.LastAnimationState ~= v140 then
                                        if u2 == "PC" and v.PetSoundHandler then
                                            v.PetSoundHandler:playSound(v140);
                                        end;

                                        if v.PetVFXHandler then
                                            v.PetVFXHandler:playVFX(v140);
                                        end;

                                        v.LastAnimationState = v140;
                                    end;

                                    local v141 = v.LoadedAnimations[v140];
                                    local CurrentAnimation = v.CurrentAnimation;

                                    if CurrentAnimation ~= v141 and v141 then
                                        if CurrentAnimation then
                                            CurrentAnimation:Stop();
                                        end;

                                        v.CurrentAnimation = v141;
                                        v141:Play();
                                    end;

                                    local v142, v143, v144 = (MovementType == "Grounded" and PetUtilities:GetLookAt(Asset.Position, CurrentCFrame.Position) or CFrame.new(Asset.Position, CurrentCFrame.Position)):ToEulerAnglesXYZ();
                                    local CFrame_Angles_ret = CFrame.Angles(v142 ~= v142 and 0 or v142, v143 ~= v143 and 0 or v143, v144 ~= v144 and 0 or v144);
                                    local v145 = (v.LastAngles or CFrame_Angles_ret):Lerp(CFrame_Angles_ret, 6 * p99);
                                    v.LastAngles = v145;
                                    u97 = u97 + 1;
                                    u95[u97] = Asset;
                                    u96[u97] = v139 * v145;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    workspace:BulkMoveTo(u95, u96, Enum.BulkMoveMode.FireCFrameChanged);
end;

task.spawn(function() -- Line: 1144
    -- upvalues: u2 (copy), u98 (ref), UpdatePositioning (copy)
    while true do
        local v146;

        repeat
            v146 = task.wait(u2 == "Mobile" and 0.04 or 0.03);
        until not u98;

        u98 = true;
        local success, result = pcall(UpdatePositioning, v146);
        u98 = false;

        if not success then
            warn(result);
        end;
    end;
end);

function u4.GetServerState(p147, p148, p149) -- Line: 1168
    -- upvalues: ActivePetsService_Replicator (copy)
    local ActivePetStates = ActivePetsService_Replicator:YieldUntilData().Table.ActivePetStates;
    local v150 = ActivePetStates[p148] or ActivePetStates[tonumber(p148)];

    if v150 then
        return v150[p149];
    end;
end;

function u4.GetPlayerDatastorePetData(p151, p152) -- Line: 1181
    -- upvalues: ActivePetsService_Replicator (copy)
    local PlayerPetData = ActivePetsService_Replicator:YieldUntilData().Table.PlayerPetData;
    local v153 = PlayerPetData[p152] or PlayerPetData[tonumber(p152)];

    if v153 then
        return v153;
    end;
end;

function u4.GetPetData(p154, p155, p156) -- Line: 1192
    -- upvalues: ActivePetsService_Replicator (copy)
    local PlayerPetData = ActivePetsService_Replicator:YieldUntilData().Table.PlayerPetData;
    local v157 = PlayerPetData[p155] or PlayerPetData[tonumber(p155)];

    if v157 then
        return v157.PetInventory.Data[p156];
    end;
end;

function u4.GetPetDataFromPetObject(p158, p159) -- Line: 1207
    -- upvalues: u4 (copy)
    if p159 then
        return u4:GetPetData(p159:GetAttribute("OWNER"), (p159:GetAttribute("UUID")));
    end;
end;

function u4.SetPetState(p160: table, p161: string, p162: string, p163: table) -- Line: 1216
    -- upvalues: ActivePetService (copy)
    ActivePetService:FireServer("SetPetState", p161, p162, p163);
end;

function u4.GetClientPetState(p164, p165) -- Line: 1220
    -- upvalues: u5 (copy)
    local v166 = u5[p165];

    if not v166 then
        v166 = {};
        u5[p165] = v166;
    end;

    return v166;
end;

function u4.CalculateBoost(p167: table, p168: userdata, p169: string, p170: any) -- Line: 1224
    -- upvalues: u4 (copy), PetMutationRegistry (copy)
    if not p168 then
        return 1;
    end;

    local PetData = u4:GetPetData(p168.Name, p169);

    if not PetData then
        return 1;
    end;

    local MutationType = PetData.PetData.MutationType;
    local v171 = 1;

    if MutationType then
        for _, v in PetMutationRegistry.PetMutationRegistry[PetMutationRegistry.EnumToPetMutation[MutationType]].Boosts do
            if v.BoostType == p170 then
                v171 = v171 + v.BoostAmount;
            end;
        end;
    end;

    local Boosts = PetData.PetData.Boosts;

    if not Boosts then
        return v171;
    end;

    for _, v in Boosts do
        if v.BoostType == p170 then
            v171 = v171 + v.BoostAmount;
        end;
    end;

    return v171;
end;

function u4.GetBoostsOfType(p172: table, p173: userdata, p174: string, p175: any) -- Line: 1265
    -- upvalues: u4 (copy), PetMutationRegistry (copy)
    local PetData = u4:GetPetData(p173.Name, p174);

    if not PetData then
        return;
    end;

    local Boosts = PetData.PetData.Boosts;

    if Boosts then
        local v176 = {};

        for _, v in Boosts do
            if v.BoostType == p175 then
                table.insert(v176, v);
            end;
        end;

        local MutationType = PetData.PetData.MutationType;

        if MutationType then
            for _, v in PetMutationRegistry.PetMutationRegistry[PetMutationRegistry.EnumToPetMutation[MutationType]].Boosts do
                if v.BoostType == p175 then
                    table.insert(v176, v);
                end;
            end;
        end;

        return v176;
    end;
end;

function u4.GetClientPetStateUUID(p177: table, p178: string, p179: string) -- Line: 1307
    -- upvalues: u4 (copy)
    local v180 = u4:GetClientPetState(p178) or u4:GetClientPetState((tonumber(p178)));

    if v180 then
        return v180[p179];
    end;
end;

Players.PlayerRemoving:Connect(function(p181) -- Line: 1316
    -- upvalues: u5 (copy), RemovePet (copy)
    local v182 = u5[p181];

    if not v182 then
        v182 = {};
        u5[p181] = v182;
    end;

    if v182 then
        for i in v182 do
            RemovePet(p181, i);
        end;
    end;

    u5[p181] = nil;
end);

function u4.Feed(p183: table, p184: string) -- Line: 1320
    -- upvalues: u6 (copy), ActivePetService (copy)
    local v185 = u6[p184];

    if v185 and v185.IsServerOwned then
        ActivePetService:FireServer("FeedServerPet", p184);

        return;
    end;

    ActivePetService:FireServer("Feed", p184);
end;

function u4.GetServerPetData(p186: table, p187: string) -- Line: 1334
    -- upvalues: ActivePetsService_Replicator (copy)
    local ServerPetData = ActivePetsService_Replicator:YieldUntilData().Table.ServerPetData;

    if ServerPetData then
        return ServerPetData[p187];
    end;

    return nil;
end;

task.delay(2, function() -- Line: 1348
    -- upvalues: UpdateRegistry (copy), ActivePetsService_Replicator (copy)
    UpdateRegistry();
    ActivePetsService_Replicator:GetPathSignal("ActivePetStates/@"):Connect(function(...) -- Line: 1350
        -- upvalues: UpdateRegistry (ref)
        UpdateRegistry();
    end);
end);
UpdateRegistry();
require(ReplicatedStorage.Modules.userprint);
task.spawn(function() -- Line: 1359
    -- upvalues: UpdateRegistry (copy)
    while true do
        task.wait(2);
        UpdateRegistry();
    end;
end);

return u4;