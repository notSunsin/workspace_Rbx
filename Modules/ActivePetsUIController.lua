-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService);
local PetCardUserInterfaceService = require(ReplicatedStorage.Modules.PetServices.PetCardUserInterfaceService);
local PetsService = require(ReplicatedStorage.Modules.PetServices.PetsService);
local Notification = require(ReplicatedStorage.Modules.Notification);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PetList = PetRegistry.PetList;
local PetActionUserInterfaceService = require(ReplicatedStorage.Modules.PetServices.PetActionUserInterfaceService);
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local GardenGuideController = require(ReplicatedStorage.Modules.GardenGuideController);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local RefreshActivePetsUI = GameEvents:WaitForChild("RefreshActivePetsUI");
local PetsService2 = GameEvents:WaitForChild("PetsService");
local PetCooldownsUpdated = GameEvents:WaitForChild("PetCooldownsUpdated");
local PetBoostService = GameEvents:WaitForChild("PetBoostService");
local ActivePetUI = PlayerGui:WaitForChild("ActivePetUI");
local Main = ActivePetUI.Frame:WaitForChild("Main");
local Header = Main.Holder:WaitForChild("Header");
local SENSOR = Header.Exit.SENSOR;
local SENSOR2 = Header:WaitForChild("Rename").SENSOR;
local Title = Header:WaitForChild("Title");
local ScrollingFrame = Main.PetDisplay.ScrollingFrame;
local PetTemplate = ScrollingFrame:WaitForChild("PetTemplate");
local Opener = ActivePetUI.Frame:WaitForChild("Opener");
local SENSOR3 = Opener:WaitForChild("SENSOR");
local OPEN_BUTTON = Opener:WaitForChild("OPEN_BUTTON");
local PetLoadout = Main:WaitForChild("PetLoadout");
local u1 = {
    PetLoadout.Main.ButtonHolder:WaitForChild("PET_LOADOUT_1"),
    PetLoadout.Main.ButtonHolder:WaitForChild("PET_LOADOUT_2"),
    PetLoadout.Main.ButtonHolder:WaitForChild("PET_LOADOUT_3"),
    PetLoadout.Main.ButtonHolder:WaitForChild("PET_LOADOUT_4"),
    PetLoadout.Main.ButtonHolder:WaitForChild("PET_LOADOUT_5"),
    PetLoadout.Main.ButtonHolder:WaitForChild("PET_LOADOUT_6")
};
local PET_LOADOUT_ADD = PetLoadout.Main.ButtonHolder:WaitForChild("PET_LOADOUT_ADD");
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = false;
local os_clock_ret = os.clock();
local u7 = false;
local u8 = false;
local u9 = false;
local u10 = 0;
local u11 = 0;
local u12 = 0;
local u13 = 0;
local TouchEnabled = UserInputService.TouchEnabled;
local v14 = TouchEnabled and 0.475 or 0.5;
local UDim2_fromScale_ret = UDim2.fromScale(2, v14);
local UDim2_fromScale_ret2 = UDim2.fromScale(0.85, v14);
local UDim2_fromScale_ret3 = UDim2.fromScale(1, 0.5);
local UDim2_fromScale_ret4 = UDim2.fromScale(-0.25, 0.5);
local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In);

local function TrackInteraction() -- Line: 93
    -- upvalues: os_clock_ret (ref)
    os_clock_ret = os.clock();
end;

local function CreateTween(p15, p16, p17) -- Line: 97
    -- upvalues: TweenService (copy)
    return TweenService:Create(p15, p17, {
        Position = p16
    });
end;

local function ExtractLoadoutStyle(p18) -- Line: 105
    local v19 = {};

    for _, child in p18.Detail:GetChildren() do
        if child:IsA("Frame") then
            table.insert(v19, child.BackgroundColor3);
        end;
    end;

    return {
        BG = p18.BackgroundColor3,
        Stroke = p18.UIStroke.Color,
        TextStroke = p18.TextLabel.UIStroke.Color,
        Vignettes = v19
    };
end;

local u20 = ExtractLoadoutStyle(u1[1]);
local u21 = ExtractLoadoutStyle(u1[2]);

local function ApplyStyleToLoadout(p22, p23) -- Line: 123
    p22.BackgroundColor3 = p23.BG;
    p22.UIStroke.Color = p23.Stroke;
    p22.TextLabel.UIStroke.Color = p23.TextStroke;

    for i, child in p22.Detail:GetChildren() do
        if child:IsA("Frame") and p23.Vignettes[i] then
            child.BackgroundColor3 = p23.Vignettes[i];
        end;
    end;
end;

local function ApplyLoadoutVisuals(p24) -- Line: 135
    -- upvalues: u1 (copy), ApplyStyleToLoadout (copy), u20 (copy), u21 (copy)
    for i, v in u1 do
        ApplyStyleToLoadout(v, i == p24 and u20 or u21);
    end;
end;

local u25 = 1;

local function GetLoadoutName(p26: number) -- Line: 148
    -- upvalues: DataService (copy), PetUtilities (copy)
    local Data = DataService:GetData();
    local v27 = Data and Data.PetsData and Data.PetsData.PetLoadoutNames;

    if v27 then
        v27 = v27[p26];
    end;

    if type(v27) ~= "string" then
        return nil;
    end;

    local v28 = PetUtilities:SanitizeLoadoutName(v27);

    if v28 == "" or not v28 then
        v28 = nil;
    end;

    return v28;
end;

local function RefreshHeaderTitle() -- Line: 162
    -- upvalues: u8 (ref), u25 (ref), DataService (copy), PetUtilities (copy), Title (copy), u11 (ref), u12 (ref)
    if u8 then
        return;
    end;

    local v29 = u25;
    local Data = DataService:GetData();
    local v30 = Data and Data.PetsData and Data.PetsData.PetLoadoutNames;

    if v30 then
        v30 = v30[v29];
    end;

    local v31;

    if type(v30) == "string" then
        v31 = PetUtilities:SanitizeLoadoutName(v30);

        if v31 == "" or not v31 then
            v31 = nil;
        end;
    else
        v31 = nil;
    end;

    Title.Text = `{v31 or `Loadout {u25}`} ({u11}/{u12})`;
end;

local function RefreshLoadoutLabels() -- Line: 171
    -- upvalues: u1 (copy), DataService (copy), PetUtilities (copy)
    for i, v in u1 do
        local Data = DataService:GetData();
        local v32 = Data and Data.PetsData and Data.PetsData.PetLoadoutNames;

        if v32 then
            v32 = v32[i];
        end;

        local v33;

        if type(v32) == "string" then
            v33 = PetUtilities:SanitizeLoadoutName(v32);

            if v33 == "" or not v33 then
                v33 = nil;
            end;
        else
            v33 = nil;
        end;

        local TextLabel = v.TextLabel;
        TextLabel.Text = v33 or tostring(i);
        TextLabel.Size = UDim2.fromScale(1, v33 and 0.9 or 0.5);
    end;
end;

local function BeginRename() -- Line: 181
    -- upvalues: u8 (ref), Title (copy), u25 (ref), u9 (ref), DataService (copy), PetUtilities (copy)
    if u8 then
        return;
    end;

    u8 = true;
    Title.Interactable = true;
    Title.TextEditable = true;
    Title.PlaceholderText = `Loadout {u25}`;
    u9 = true;
    local v34 = u25;
    local Data = DataService:GetData();
    local v35 = Data and Data.PetsData and Data.PetsData.PetLoadoutNames;

    if v35 then
        v35 = v35[v34];
    end;

    local v36;

    if type(v35) == "string" then
        v36 = PetUtilities:SanitizeLoadoutName(v35);

        if v36 == "" or not v36 then
            v36 = nil;
        end;
    else
        v36 = nil;
    end;

    Title.Text = v36 or "";
    u9 = false;
    Title:CaptureFocus();
    Title.CursorPosition = #Title.Text + 1;
end;

local function CommitRename() -- Line: 202
    -- upvalues: u8 (ref), u10 (ref), Title (copy), PetUtilities (copy), u25 (ref), DataService (copy), PetsService2 (copy), u11 (ref), u12 (ref), RefreshLoadoutLabels (copy)
    if not u8 then
        return;
    end;

    u8 = false;
    u10 = os.clock();
    Title.Interactable = false;
    Title.TextEditable = false;
    Title.PlaceholderText = "";
    local v37 = PetUtilities:SanitizeLoadoutName(Title.Text);
    local v38 = u25;
    local Data = DataService:GetData();
    local v39 = Data and Data.PetsData and Data.PetsData.PetLoadoutNames;

    if v39 then
        v39 = v39[v38];
    end;

    local v40;

    if type(v39) == "string" then
        v40 = PetUtilities:SanitizeLoadoutName(v39);

        if v40 == "" or not v40 then
            v40 = nil;
        end;
    else
        v40 = nil;
    end;

    if v37 ~= (v40 or "") then
        PetsService2:FireServer("RenamePetLoadout", u25, v37);
    end;

    if not u8 then
        local v41 = u25;
        local Data2 = DataService:GetData();
        local v42 = Data2 and Data2.PetsData and Data2.PetsData.PetLoadoutNames;

        if v42 then
            v42 = v42[v41];
        end;

        local v43;

        if type(v42) == "string" then
            v43 = PetUtilities:SanitizeLoadoutName(v42);

            if v43 == "" or not v43 then
                v43 = nil;
            end;
        else
            v43 = nil;
        end;

        Title.Text = `{v43 or `Loadout {u25}`} ({u11}/{u12})`;
    end;

    RefreshLoadoutLabels();
end;

local function CreatePetFrame(p44) -- Line: 229
    -- upvalues: PetTemplate (copy), ScrollingFrame (copy), SetupButton (copy), os_clock_ret (ref), LocalPlayer (copy), u7 (ref), Notification (copy), PetBoostService (copy), PetUtilities (copy), ActivePetsService (copy), PetCardUserInterfaceService (copy), u2 (copy), PetActionUserInterfaceService (copy), u5 (copy), u3 (copy), PetsService (copy)
    local UUID = p44.UUID;
    local u45 = PetTemplate:Clone();
    u45.Name = UUID;
    u45.Visible = true;
    u45.Parent = ScrollingFrame;
    local Dropdown = u45:WaitForChild("Dropdown");
    local Holder = Dropdown.Main.Main.FEED_BUTTON.Holder;
    local Holder2 = Dropdown.Main.Main.VIEW_BUTTON.Holder;
    local Holder3 = Dropdown.Main.Main.PICKUP_BUTTON.Holder;
    SetupButton({
        offset = 0.1,
        instance = Holder.Main.SENSOR,
        scale = Holder.UIScale,

        onclick = function() -- Line: 245, Name: onclick
            -- upvalues: os_clock_ret (ref), LocalPlayer (ref), u7 (ref), Notification (ref), PetBoostService (ref), UUID (copy), PetUtilities (ref), ActivePetsService (ref)
            os_clock_ret = os.clock();
            local Character = LocalPlayer.Character;

            if not Character then
                return;
            end;

            local u46 = Character:FindFirstChildWhichIsA("Tool");
            local v47;

            if u46 then
                v47 = u46:HasTag("PetBoost");
            else
                v47 = u46;
            end;

            u7 = v47;

            if u7 then
                if not (u46 and u46:HasTag("PetBoost")) then
                    return Notification:CreateNotification("You are not holding a Pet Boost!");
                end;

                PetBoostService:FireServer("ApplyBoost", UUID);

                return;
            end;

            if u46 and u46:HasTag("ActiveUIUsableGear") then
                xpcall(function() -- Line: 258
                    -- upvalues: u46 (copy), PetUtilities (ref), UUID (ref)
                    game.ReplicatedStorage.GameEvents.TryUseGear:FireServer(require(game.ReplicatedStorage.Modules.InventoryService):GetToolData(u46).ItemType, PetUtilities:FindLocalPetModel(UUID));
                end, warn);

                return;
            end;

            if not (u46 and (u46:HasTag("FruitTool") or u46:HasTag("FoodTool"))) then
                return Notification:CreateNotification("You are not holding a fruit!");
            end;

            ActivePetsService:Feed(UUID);
        end
    });
    SetupButton({
        offset = 0.1,
        instance = Holder2.Main.SENSOR,
        scale = Holder2.UIScale,

        onclick = function() -- Line: 277, Name: onclick
            -- upvalues: PetCardUserInterfaceService (ref), UUID (copy), LocalPlayer (ref), u2 (ref)
            PetCardUserInterfaceService:SetTargetFromUUID(UUID);
            PetCardUserInterfaceService.TargetPlayer = LocalPlayer;
            PetCardUserInterfaceService:Toggle(true, function() -- Line: 280
                -- upvalues: u2 (ref)
                u2:Open();
            end);
            u2:Close();
        end
    });
    SetupButton({
        offset = 0.1,
        instance = Holder3.Main.SENSOR,
        scale = Holder3.UIScale,

        onclick = function() -- Line: 291, Name: onclick
            -- upvalues: os_clock_ret (ref), PetActionUserInterfaceService (ref), u5 (ref), UUID (copy), u45 (copy), u3 (ref), PetsService (ref), u2 (ref)
            os_clock_ret = os.clock();
            PetActionUserInterfaceService.Close();
            u5[UUID] = os.clock();
            u45:Destroy();
            u3[UUID] = nil;
            PetsService:UnequipPet(UUID);
            u2:RebuildPetList();
        end
    });
    u3[UUID] = u45;

    return u45;
end;

function u2.UpdatePetStatic(p48, p49, p50) -- Line: 307
    -- upvalues: PetList (copy), PetMutationRegistry (copy)
    local PetData = p49.PetData;
    local v51 = PetList[p49.PetType];
    local v52 = PetMutationRegistry.EnumToPetMutation[PetData.MutationType];
    local v53 = PetData.Name or "Unnamed";
    p50.Main.PET_NAME.Text = v53;
    p50.Main.PET_NAME_SHADOW.Text = v53;
    local v54 = v52 and v52 ~= "Normal" and v52 .. " " .. (p49.PetType or "Unknown") or (p49.PetType or "Unknown");
    p50.Main.PET_TYPE.Text = v54;
    p50.Main.PET_TYPE_SHADOW.Text = v54;
    local v55 = PetData.Level or "1";
    p50.Main.PET_AGE.Text = "Age: " .. v55;
    p50.Main.PET_AGE_SHADOW.Text = "Age: " .. v55;
    p50.Main.Item.PET_IMAGE.Image = v51 and (v51.Icon or "") or "";

    if not v51 then
        warn((`{p49.PetType} lacks RegistryData`));
    end;
end;

function u2.RebuildPetList(p56) -- Line: 332
    -- upvalues: DataService (copy), PetUtilities (copy), LocalPlayer (copy), u12 (ref), u11 (ref), u5 (copy), u3 (copy), CreatePetFrame (copy), u8 (ref), u25 (ref), Title (copy), RefreshLoadoutLabels (copy)
    local Data = DataService:GetData();
    local _ = Data.PetsData.EquippedPets;
    local PetsSortedByAge = PetUtilities:GetPetsSortedByAge(LocalPlayer, 0, false, true);
    local v57 = {};
    local os_clock_ret2 = os.clock();
    u12 = Data.PetsData.MutableStats.MaxEquippedPets;
    u11 = 0;

    for _, v in PetsSortedByAge do
        v57[v.UUID] = true;
    end;

    for i, v in u5 do
        if v57[i] then
            if os_clock_ret2 - v >= 5 then
                u5[i] = nil;
            end;
        else
            u5[i] = nil;
        end;
    end;

    for _, v in PetsSortedByAge do
        if not u5[v.UUID] then
            u11 = u11 + 1;

            if not u3[v.UUID] then
                CreatePetFrame(v);
            end;
        end;
    end;

    local v58 = {};

    for _, v in PetsSortedByAge do
        if not u5[v.UUID] then
            local v59 = u3[v.UUID];

            if v59 then
                v58[v.UUID] = true;
                p56:UpdatePetStatic(v, v59);
            end;
        end;
    end;

    for i, v in u3 do
        if not v58[i] then
            v:Destroy();
            u3[i] = nil;
        end;
    end;

    if not u8 then
        local v60 = u25;
        local Data2 = DataService:GetData();
        local v61 = Data2 and Data2.PetsData and Data2.PetsData.PetLoadoutNames;

        if v61 then
            v61 = v61[v60];
        end;

        local v62;

        if type(v61) == "string" then
            v62 = PetUtilities:SanitizeLoadoutName(v61);

            if v62 == "" or not v62 then
                v62 = nil;
            end;
        else
            v62 = nil;
        end;

        Title.Text = `{v62 or `Loadout {u25}`} ({u11}/{u12})`;
    end;

    RefreshLoadoutLabels();
end;

local function BoostEmoji(p63) -- Line: 396
    return p63 == "PET_XP_BOOST" and "🧠" or (p63 == "PASSIVE_BOOST" and "💪" or "❓");
end;

local u64 = { "Movement Variation", "Block Wandering", "Tethered Pet Mutation" };

function u2.UpdateDynamic(p65) -- Line: 409
    -- upvalues: u3 (copy), PetUtilities (copy), LocalPlayer (copy), PetList (copy), PetRegistry (copy), u4 (copy), u64 (copy)
    for i, v in u3 do
        local PetByUUID = PetUtilities:GetPetByUUID(LocalPlayer, i);

        if PetByUUID then
            local PetData = PetByUUID.PetData;
            local math_clamp_ret = math.clamp((PetData.Hunger or 0) / (PetList[PetByUUID.PetType].DefaultHunger or 1), 0, 1);
            v.Main.Bars.HungerBar.Bar_Actual.Size = UDim2.fromScale(math_clamp_ret, 1);
            local CurrentLevelXPCost = PetUtilities:GetCurrentLevelXPCost(PetData.Level);
            local v66 = PetData.Level >= PetRegistry.PetConfig.XP_CONFIG.MAX_LEVEL and 1 or math.clamp((PetData.LevelProgress or 0) / (CurrentLevelXPCost > 0 and CurrentLevelXPCost and CurrentLevelXPCost or 1), 0, 1);
            v.Main.Bars.ExpBar.Bar_Actual.Size = UDim2.fromScale(v66, 1);
            local v67 = u4[i];
            local COOLDOWN_1 = v.Main.Cooldowns:FindFirstChild("COOLDOWN_1");
            local COOLDOWN_2 = v.Main.Cooldowns:FindFirstChild("COOLDOWN_2");

            local function setSlot(p68, p69) -- Line: 432
                -- upvalues: u64 (ref)
                if not p68 then
                    return;
                end;

                if not p69 then
                    p68.Visible = false;

                    return;
                end;

                for _, v2 in u64 do
                    if p69.Passive == v2 then
                        p68.Visible = false;

                        return;
                    end;
                end;

                local Time = p69.Time;
                local v70 = Time <= 0 and "⏳ READY" or (Time >= 60 and "⏳ " .. math.floor(Time / 60) .. ":" .. string.format("%02d", Time % 60) .. "m" or "⏳ " .. Time .. "s");
                local COOLDOWN_NAME = p68:FindFirstChild("COOLDOWN_NAME");
                local COOLDOWN_NAME_SHADOW = p68:FindFirstChild("COOLDOWN_NAME_SHADOW");

                if COOLDOWN_NAME then
                    COOLDOWN_NAME.Text = v70;
                end;

                if COOLDOWN_NAME_SHADOW then
                    COOLDOWN_NAME_SHADOW.Text = v70;
                end;

                p68.Visible = true;
            end;

            if v67 and v67[1] then
                setSlot(COOLDOWN_1, v67[1]);
            elseif COOLDOWN_1 then
                COOLDOWN_1.Visible = false;
            end;

            if v67 and v67[2] then
                setSlot(COOLDOWN_2, v67[2]);
            elseif COOLDOWN_2 then
                COOLDOWN_2.Visible = false;
            end;

            local Boosts = v.Main:FindFirstChild("Boosts");

            if Boosts then
                local v71 = { Boosts:FindFirstChild("BOOST_1"), Boosts:FindFirstChild("BOOST_2"), Boosts:FindFirstChild("BOOST_3") };
                local v72 = {};

                for _, v2 in PetData.Boosts or {} do
                    if v2 and (not v2.HideInUI and (v2.Time or 0) > 0) then
                        table.insert(v72, v2);
                    end;
                end;

                table.sort(v72, function(p73, p74) -- Line: 478
                    return (p73.Time or 0) < (p74.Time or 0);
                end);

                for i2 = 1, #v71 do
                    local v75 = v71[i2];
                    local v76 = v72[i2];
                    local v77;

                    if v75 then
                        if v76 then
                            local math_floor_ret = math.floor((v76.Time or 0) / 60);
                            local BoostType = v76.BoostType;
                            local string_format_ret = string.format("%s %d:%02d", BoostType == "PET_XP_BOOST" and "🧠" or (BoostType == "PASSIVE_BOOST" and "💪" or "❓"), math_floor_ret, (v76.Time or 0) % 60);
                            local BOOST_NAME = v75:FindFirstChild("BOOST_NAME");
                            local BOOST_NAME_SHADOW = v75:FindFirstChild("BOOST_NAME_SHADOW");

                            if BOOST_NAME then
                                BOOST_NAME.Text = string_format_ret;
                            end;

                            if BOOST_NAME_SHADOW then
                                BOOST_NAME_SHADOW.Text = string_format_ret;
                            end;

                            v75.Visible = true;
                            v77 = i2;
                        else
                            v75.Visible = false;
                            v77 = i2;
                        end;
                    else
                        v77 = i2;
                    end;
                end;
            end;
        end;
    end;
end;

local function RefreshLoadoutButtons() -- Line: 502
    -- upvalues: DataService (copy), u1 (copy), PET_LOADOUT_ADD (copy), RefreshLoadoutLabels (copy)
    local v78 = DataService:GetData().PetsData.MaxLoadoutSlots or 3;

    for i, v in u1 do
        v.Visible = i <= v78;
        v.LayoutOrder = i;
    end;

    PET_LOADOUT_ADD.Visible = v78 < 6;
    RefreshLoadoutLabels();
end;

function u2.Toggle(p79) -- Line: 519
    -- upvalues: u13 (ref), u6 (ref), PlayerGui (copy), GardenGuideController (copy), u8 (ref), Title (copy), UDim2_fromScale_ret2 (copy), UDim2_fromScale_ret (copy), UDim2_fromScale_ret4 (copy), UDim2_fromScale_ret3 (copy), OPEN_BUTTON (copy), Opener (copy), Main (copy), ActivePetUI (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy), TweenService (copy)
    local os_clock_ret2 = os.clock();

    if os_clock_ret2 - u13 < 0.3 then
        return;
    end;

    u13 = os_clock_ret2;
    u6 = not u6;

    if u6 and PlayerGui.GardenGuide.Enabled then
        GardenGuideController:Close();
    end;

    if not u6 and u8 then
        Title:ReleaseFocus();
    end;

    OPEN_BUTTON.Text = u6 and ">>" or "<<";
    Opener.Parent = u6 and Main or ActivePetUI.Frame;
    TweenService:Create(Main, u6 and TweenInfo_new_ret or TweenInfo_new_ret2, {
        Position = u6 and UDim2_fromScale_ret2 or UDim2_fromScale_ret
    }):Play();
    Opener.Position = u6 and UDim2_fromScale_ret4 or UDim2_fromScale_ret3;
end;

function u2.Open(p80) -- Line: 551
    -- upvalues: u6 (ref)
    if not u6 then
        p80:Toggle();
    end;
end;

function u2.Close(p81) -- Line: 552
    -- upvalues: u6 (ref)
    if u6 then
        p81:Toggle();
    end;
end;

function u2.SetOpen(p82: table, p83: boolean) -- Line: 553
    -- upvalues: u6 (ref)
    if u6 ~= p83 then
        p82:Toggle();
    end;
end;

function u2.Start(u84) -- Line: 558
    -- upvalues: PetTemplate (copy), Main (copy), UDim2_fromScale_ret (copy), Opener (copy), UDim2_fromScale_ret3 (copy), OPEN_BUTTON (copy), ActivePetUI (copy), TouchEnabled (copy), PetLoadout (copy), DataService (copy), u25 (ref), u8 (ref), Title (copy), u1 (copy), ApplyStyleToLoadout (copy), u20 (copy), u21 (copy), PetUtilities (copy), u11 (ref), u12 (ref), RefreshLoadoutButtons (copy), PET_LOADOUT_ADD (copy), RefreshLoadoutLabels (copy), os_clock_ret (ref), Notification (copy), PetsService2 (copy), SetupButton (copy), ConfirmationPromptController (copy), SENSOR2 (copy), u10 (ref), u9 (ref), CommitRename (copy), SENSOR (copy), SENSOR3 (copy), u6 (ref), LocalPlayer (copy), u4 (copy), RefreshActivePetsUI (copy), PetCooldownsUpdated (copy)
    PetTemplate.Visible = false;
    Main.Position = UDim2_fromScale_ret;
    Opener.Position = UDim2_fromScale_ret3;
    OPEN_BUTTON.Text = "<<";
    ActivePetUI.IgnoreGuiInset = TouchEnabled;
    PetLoadout.AnchorPoint = Vector2.new(0, TouchEnabled and 1 or 0);
    PetLoadout.Position = UDim2.fromScale(-0.25, TouchEnabled and 1 or 0);
    local Data = DataService:GetData();

    local function UpdateLoadout() -- Line: 569
        -- upvalues: Data (copy), u25 (ref), u8 (ref), Title (ref), u1 (ref), ApplyStyleToLoadout (ref), u20 (ref), u21 (ref), DataService (ref), PetUtilities (ref), u11 (ref), u12 (ref)
        local v85 = Data and (Data.PetsData and Data.PetsData.SelectedPetLoadout) or 1;

        if u25 == v85 then
            return;
        end;

        if u8 then
            Title:ReleaseFocus();
        end;

        u25 = v85;
        local v86 = u25;

        for i, v in u1 do
            ApplyStyleToLoadout(v, i == v86 and u20 or u21);
        end;

        if u8 then
            return;
        end;

        local v87 = u25;
        local Data2 = DataService:GetData();
        local v88 = Data2 and Data2.PetsData and Data2.PetsData.PetLoadoutNames;

        if v88 then
            v88 = v88[v87];
        end;

        local v89;

        if type(v88) == "string" then
            v89 = PetUtilities:SanitizeLoadoutName(v88);

            if v89 == "" or not v89 then
                v89 = nil;
            end;
        else
            v89 = nil;
        end;

        Title.Text = `{v89 or `Loadout {u25}`} ({u11}/{u12})`;
    end;

    DataService:GetPathSignal("PetsData/SelectedPetLoadout"):Connect(UpdateLoadout);
    task.spawn(UpdateLoadout);
    DataService:GetPathSignal("PetsData/MaxLoadoutSlots"):Connect(RefreshLoadoutButtons);
    local v90 = DataService:GetData().PetsData.MaxLoadoutSlots or 3;

    for i, v in u1 do
        v.Visible = i <= v90;
        v.LayoutOrder = i;
    end;

    PET_LOADOUT_ADD.Visible = v90 < 6;
    RefreshLoadoutLabels();

    for i, v in u1 do
        v:WaitForChild("SENSOR").MouseButton1Click:Connect(function() -- Line: 593
            -- upvalues: os_clock_ret (ref), DataService (ref), i (copy), Notification (ref), u25 (ref), PetsService2 (ref)
            os_clock_ret = os.clock();

            if i > (DataService:GetData().PetsData.MaxLoadoutSlots or 3) then
                return Notification:CreateNotification("You have not unlocked this loadout yet!");
            end;

            if u25 == i then
                return;
            end;

            PetsService2:FireServer("SwapPetLoadout", i);
        end);
    end;

    local function GetNextLoadoutCostInfo() -- Line: 609
        -- upvalues: DataService (ref)
        local Data2 = DataService:GetData();

        if Data2 then
            Data2 = Data2.PetsData;
        end;

        local v91 = Data2 and Data2.MaxLoadoutSlots or 3;

        if v91 >= 6 then
            return nil, nil;
        end;

        local v92 = v91 + 1;

        if v92 == 4 then
            return v92, "10T";
        end;

        if v92 == 5 then
            return v92, "100T";
        end;

        return v92, "1Q";
    end;

    SetupButton({
        offset = 0.1,
        instance = PET_LOADOUT_ADD.SENSOR,

        onclick = function() -- Line: 635, Name: onclick
            -- upvalues: os_clock_ret (ref), DataService (ref), Notification (ref), PetsService2 (ref), ConfirmationPromptController (ref)
            os_clock_ret = os.clock();
            local Data2 = DataService:GetData();

            if Data2 then
                Data2 = Data2.PetsData;
            end;

            local v93 = Data2 and Data2.MaxLoadoutSlots or 3;
            local v94, v95;

            if v93 >= 6 then
                v94 = nil;
                v95 = nil;
            else
                v94 = v93 + 1;
                v95 = v94 == 4 and "10T" or (v94 == 5 and "100T" or "1Q");
            end;

            if not v94 then
                return Notification:CreateNotification("You already have all pet loadout slots.");
            end;

            ConfirmationPromptController:Open({
                Title = "Buy Pet Loadout Slot",
                Footer = "This will unlock an extra pet loadout slot.",
                Header = `Unlock Pet Loadout {v94}?`,
                Middle = `Cost: {v95} Sheckles`
            }, {
                ConfirmEvent = PetsService2,
                ConfirmEventData = { "BuyLoadoutSlot" }
            });
        end
    });
    Title.Interactable = false;
    Title.TextEditable = false;
    Title.PlaceholderText = "";
    SENSOR2.MouseButton1Click:Connect(function() -- Line: 664
        -- upvalues: os_clock_ret (ref), u8 (ref), u10 (ref), Title (ref), u25 (ref), u9 (ref), DataService (ref), PetUtilities (ref)
        os_clock_ret = os.clock();

        if u8 or os.clock() - u10 < 0.25 then
            return Title:ReleaseFocus();
        end;

        if u8 then
            return;
        end;

        u8 = true;
        Title.Interactable = true;
        Title.TextEditable = true;
        Title.PlaceholderText = `Loadout {u25}`;
        u9 = true;
        local v96 = u25;
        local Data2 = DataService:GetData();
        local v97 = Data2 and Data2.PetsData and Data2.PetsData.PetLoadoutNames;

        if v97 then
            v97 = v97[v96];
        end;

        local v98;

        if type(v97) == "string" then
            v98 = PetUtilities:SanitizeLoadoutName(v97);

            if v98 == "" or not v98 then
                v98 = nil;
            end;
        else
            v98 = nil;
        end;

        Title.Text = v98 or "";
        u9 = false;
        Title:CaptureFocus();
        Title.CursorPosition = #Title.Text + 1;
    end);
    Title.FocusLost:Connect(function() -- Line: 675
        -- upvalues: os_clock_ret (ref), CommitRename (ref)
        os_clock_ret = os.clock();
        CommitRename();
    end);
    Title:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 680
        -- upvalues: u8 (ref), u9 (ref), PetUtilities (ref), Title (ref)
        if not u8 or u9 then
            return;
        end;

        local v99 = PetUtilities:FilterLoadoutNameInput(Title.Text);

        if v99 == Title.Text then
            return;
        end;

        local CursorPosition = Title.CursorPosition;
        u9 = true;
        Title.Text = v99;
        Title.CursorPosition = math.min(CursorPosition, #v99 + 1);
        u9 = false;
    end);
    SENSOR.MouseButton1Click:Connect(function() -- Line: 699
        -- upvalues: os_clock_ret (ref), u84 (copy)
        os_clock_ret = os.clock();
        u84:Close();
    end);
    SENSOR3.MouseButton1Click:Connect(function() -- Line: 700
        -- upvalues: os_clock_ret (ref), u84 (copy)
        os_clock_ret = os.clock();
        u84:Toggle();
    end);
    Main.InputBegan:Connect(function() -- Line: 701
        -- upvalues: os_clock_ret (ref)
        os_clock_ret = os.clock();
    end);
    task.spawn(function() -- Line: 704
        -- upvalues: u6 (ref), u8 (ref), os_clock_ret (ref), LocalPlayer (ref), u84 (copy)
        while true do
            repeat
                task.wait(1);
            until u6 and not (u8 or (os.clock() - os_clock_ret <= 8 or LocalPlayer:GetAttribute("AutoCloseActivePetsUI") == false));

            u84:Close();
        end;
    end);
    task.spawn(function() -- Line: 716
        -- upvalues: u6 (ref), u4 (ref), u84 (copy)
        while true do
            repeat
                task.wait(1);
            until u6;

            for _, v in u4 do
                for _, v2 in v do
                    v2.Time = math.max(0, v2.Time - 1);
                end;
            end;

            u84:UpdateDynamic();
            u84:RebuildPetList();
        end;
    end);
    RefreshActivePetsUI.OnClientEvent:Connect(function() -- Line: 734
        -- upvalues: u84 (copy)
        u84:RebuildPetList();
    end);
    PetCooldownsUpdated.OnClientEvent:Connect(function(p100, p101) -- Line: 739
        -- upvalues: u4 (ref)
        u4[p100] = p101;
    end);
    u84:RebuildPetList();
end;

u2:Start();

local function ChangeFeedButtonText(u102: string) -- Line: 750
    -- upvalues: u3 (copy)
    for i, v in u3 do
        local success, result = pcall(function() -- Line: 752
            -- upvalues: v (copy), u102 (copy)
            v.Dropdown.Main.Main.FEED_BUTTON.Holder.Main.TextLabel.Text = u102;
        end);

        if game:GetService("RunService"):IsStudio() and not success then
            warn("ActivePetsUIController:HandleBoostEquipped() | Failed to update feed button for" .. v.Name .. ":" .. i);
            warn(result);
        end;
    end;
end;

local function HandleBoostEquipped() -- Line: 765
    -- upvalues: LocalPlayer (copy), u7 (ref), ChangeFeedButtonText (copy)
    local v103 = LocalPlayer.Character:FindFirstChildWhichIsA("Tool");

    if v103 then
        v103 = v103:HasTag("PetBoost");
    end;

    u7 = v103;

    if u7 then
        ChangeFeedButtonText("Boost");

        return;
    end;

    ChangeFeedButtonText("Feed");
end;

LocalPlayer.Character.ChildAdded:Connect(HandleBoostEquipped);
LocalPlayer.Character.ChildRemoved:Connect(HandleBoostEquipped);
local v104 = LocalPlayer.Character:FindFirstChildWhichIsA("Tool");

if v104 then
    v104 = v104:HasTag("PetBoost");
end;

u7 = v104;

if u7 then
    ChangeFeedButtonText("Boost");
else
    ChangeFeedButtonText("Feed");
end;

return u2;