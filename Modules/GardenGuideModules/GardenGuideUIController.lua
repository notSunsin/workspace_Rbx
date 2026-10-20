-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local DataService = require(ReplicatedStorage.Modules.DataService);
local ActivePetsUIController = require(ReplicatedStorage.Modules.ActivePetsUIController);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local GardenGuideModules = ReplicatedStorage.Modules.GardenGuideModules;
local SortButtonsLogic = require(GardenGuideModules.SortButtonsLogic);
local DetailsViewHandler = require(GardenGuideModules.DetailsViewHandler);
local GridCellHandler = require(GardenGuideModules.GridCellHandler);
local GGUI = require(GardenGuideModules.GGUI);
local GGButtonEffects = require(GardenGuideModules.GGButtonEffects);
local GGSearchBarHandler = require(GardenGuideModules.GGSearchBarHandler);
local VirtualList = require(GardenGuideModules.VirtualList);
local GGStaticData = require(GardenGuideModules.DataModules.GGStaticData);
local GGData = require(GardenGuideModules.DataModules.GGData);
local GGUIReferences = require(GardenGuideModules.DataModules.GGUIReferences);
local GardenGuideData = require(ReplicatedStorage.Data.GardenGuideData);
local GardenGuideController = require(ReplicatedStorage.Modules.GardenGuideController);
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);
local u1 = ReplicatedStorage.GameEvents.GardenGuide.GetGGBlacklist:InvokeServer();
local v2 = {};
local Templates = GardenGuideModules.Templates;
local _ = Templates.MenuTemplate;
local u3 = {};
local LocalPlayer = Players.LocalPlayer;
assert(LocalPlayer, "No player");
local u4 = nil;
local u5 = 0;

local function UpdateProgressBar(p6) -- Line: 44
    -- upvalues: GGUIReferences (copy)
    if p6.Unlocked and p6.Total then
        local CompletionBar = GGUIReferences.CompletionBar;
        CompletionBar.Bar.Bar_Actual.Size = UDim2.fromScale(#p6.Unlocked / p6.Total, 1);
        local v7 = `{#p6.Unlocked} / {p6.Total} Discovered`;
        CompletionBar.Bar.PROGRESS.Text = v7;
        CompletionBar.Bar.PROGRESS_SHADOW.Text = v7;
    end;
end;

local function SetUpGrid(u8: string, u9: table, p10: number) -- Line: 55
    -- upvalues: GGUIReferences (copy), VirtualList (copy)
    task.spawn(function() -- Line: 56
        -- upvalues: GGUIReferences (ref), u8 (copy), VirtualList (ref), u9 (copy)
        local GridView = GGUIReferences.GridView;
        local v11 = GridView:FindFirstChild(u8);
        local GridSFrame = GridView.GridSFrame;
        v11.Parent = GridView;
        GridSFrame.CanvasPosition = Vector2.zero;
        VirtualList(v11, GridSFrame, u9);
    end);
end;

local function CreateDataArray(p12: table) -- Line: 68
    -- upvalues: SortButtonsLogic (copy)
    local v13 = {};

    for _, v in p12 do
        table.insert(v13, v);
    end;

    SortButtonsLogic.FilterAndSort(v13);

    return v13;
end;

local function EmptyGrid(p14: string) -- Line: 77
    -- upvalues: GGUIReferences (copy)
    local v15 = GGUIReferences.GridView:FindFirstChild(p14);

    if not v15 then
        return;
    end;

    for _, child in v15:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;
end;

local function SwitchGrid(p16: string, p17: string) -- Line: 86
    -- upvalues: u4 (ref), u5 (ref), EmptyGrid (copy), GGData (copy), SortButtonsLogic (copy), GGUIReferences (copy), VirtualList (copy)
    if u4 == p16 then
        return;
    end;

    u5 = u5 + 1;

    if u4 then
        EmptyGrid(u4);
    end;

    u4 = p16;
    local u18 = {};

    for _, v in GGData[u4].Data do
        table.insert(u18, v);
    end;

    SortButtonsLogic.FilterAndSort(u18);
    local u19 = `{u4}Menu`;
    task.spawn(function() -- Line: 56
        -- upvalues: GGUIReferences (ref), u19 (copy), VirtualList (ref), u18 (copy)
        local GridView = GGUIReferences.GridView;
        local v20 = GridView:FindFirstChild(u19);
        local GridSFrame = GridView.GridSFrame;
        v20.Parent = GridView;
        GridSFrame.CanvasPosition = Vector2.zero;
        VirtualList(v20, GridSFrame, u18);
    end);
end;

local function SetUpSideMenu() -- Line: 100
    -- upvalues: GGUIReferences (copy), u3 (copy), UpdateProgressBar (copy), GGData (copy), GGButtonEffects (copy), GGUI (copy), u4 (ref), EmptyGrid (copy), u5 (ref), SortButtonsLogic (copy), VirtualList (copy), LocalPlayer (copy)
    local GridView = GGUIReferences.GridView;
    local SideMenuButtons = GGUIReferences.SideMenuButtons;

    for _, child in GridView:GetChildren() do
        if child:IsA("Frame") then
            local Attribute = child:GetAttribute("MenuId");

            if Attribute then
                u3[Attribute] = child;
            end;
        end;
    end;

    for _, child in SideMenuButtons:GetChildren() do
        if child:GetAttribute("MenuType") == "DataGrid" and child:IsA("Frame") then
            local Name = child.Name;
            child:SetAttribute("MenuId", Name);
            UpdateProgressBar(GGData[Name]);
            local SENSOR = child:FindFirstChild("SENSOR");
            SENSOR.Activated:Connect(function() -- Line: 122
                -- upvalues: GGButtonEffects (ref), u3 (ref), Name (copy), GGUI (ref), GridView (copy), u4 (ref), EmptyGrid (ref), u5 (ref), GGData (ref), SortButtonsLogic (ref), GGUIReferences (ref), VirtualList (ref), UpdateProgressBar (ref)
                GGButtonEffects.Click();

                if not u3[Name] then
                    warn((`There is no menu with Id: {Name}`));

                    return;
                end;

                if GGUI.CurrentDetail then
                    GGUI.CurrentDetail:Destroy();
                end;

                GGUI.NewPageOrder(u3[Name], GGUI.CurrentPage);
                GridView.Visible = true;
                GGUI.ChangeTopBar(Name, true);
                u3[Name]:GetChildren();

                if u4 ~= Name then
                    task.spawn(function() -- Line: 138
                        -- upvalues: EmptyGrid (ref), u4 (ref)
                        EmptyGrid((`{u4}Menu`));
                    end);

                    if GridView:FindFirstChild((`{Name}Menu`)).Visible then
                        local v21 = Name;

                        if u4 ~= v21 then
                            u5 = u5 + 1;

                            if u4 then
                                EmptyGrid(u4);
                            end;

                            u4 = v21;
                            local u22 = {};

                            for _, v in GGData[u4].Data do
                                table.insert(u22, v);
                            end;

                            SortButtonsLogic.FilterAndSort(u22);
                            local u23 = `{u4}Menu`;
                            task.spawn(function() -- Line: 56
                                -- upvalues: GGUIReferences (ref), u23 (copy), VirtualList (ref), u22 (copy)
                                local GridView2 = GGUIReferences.GridView;
                                local v24 = GridView2:FindFirstChild(u23);
                                local GridSFrame = GridView2.GridSFrame;
                                v24.Parent = GridView2;
                                GridSFrame.CanvasPosition = Vector2.zero;
                                VirtualList(v24, GridSFrame, u22);
                            end);
                        end;
                    end;
                end;

                UpdateProgressBar(GGData[Name]);
            end);
            GGButtonEffects.AddHoverEffect(SENSOR);
        end;
    end;

    local function NonGridMenuLogic(p25: string, u26: userdata, u27: string) -- Line: 154
        -- upvalues: SideMenuButtons (copy), GGButtonEffects (ref), GGUI (ref), EmptyGrid (ref), u4 (ref), GridView (copy)
        local SENSOR = SideMenuButtons[p25].SENSOR;
        SENSOR.Activated:Connect(function() -- Line: 157
            -- upvalues: GGButtonEffects (ref), GGUI (ref), u26 (copy), EmptyGrid (ref), u4 (ref), u27 (copy), GridView (ref)
            GGButtonEffects.Click();

            if GGUI.CurrentDetail then
                GGUI.CurrentDetail:Destroy();
            end;

            GGUI.NewPageOrder(u26, GGUI.CurrentPage);
            EmptyGrid((`{u4}Menu`));
            u4 = "";

            if GGUI.CurrentDetail then
                GGUI.CurrentDetail.Visible = false;
            end;

            GGUI.ChangeTopBar(u27, false);
            GridView.Visible = false;
        end);
        GGButtonEffects.AddHoverEffect(SENSOR);
    end;

    local DailyQuestView = GGUIReferences.DailyQuestView;
    local SENSOR = SideMenuButtons.DailyQuests.SENSOR;
    local u28 = "Daily Quests";
    SENSOR.Activated:Connect(function() -- Line: 157
        -- upvalues: GGButtonEffects (ref), GGUI (ref), DailyQuestView (copy), EmptyGrid (ref), u4 (ref), u28 (copy), GridView (copy)
        GGButtonEffects.Click();

        if GGUI.CurrentDetail then
            GGUI.CurrentDetail:Destroy();
        end;

        GGUI.NewPageOrder(DailyQuestView, GGUI.CurrentPage);
        EmptyGrid((`{u4}Menu`));
        u4 = "";

        if GGUI.CurrentDetail then
            GGUI.CurrentDetail.Visible = false;
        end;

        GGUI.ChangeTopBar(u28, false);
        GridView.Visible = false;
    end);
    GGButtonEffects.AddHoverEffect(SENSOR);
    local PlayerStatsView = GGUIReferences.PlayerStatsView;
    local u29 = `{LocalPlayer.Name}'s Profile`;
    local SENSOR2 = SideMenuButtons.PlayerStats.SENSOR;
    SENSOR2.Activated:Connect(function() -- Line: 157
        -- upvalues: GGButtonEffects (ref), GGUI (ref), PlayerStatsView (copy), EmptyGrid (ref), u4 (ref), u29 (copy), GridView (copy)
        GGButtonEffects.Click();

        if GGUI.CurrentDetail then
            GGUI.CurrentDetail:Destroy();
        end;

        GGUI.NewPageOrder(PlayerStatsView, GGUI.CurrentPage);
        EmptyGrid((`{u4}Menu`));
        u4 = "";

        if GGUI.CurrentDetail then
            GGUI.CurrentDetail.Visible = false;
        end;

        GGUI.ChangeTopBar(u29, false);
        GridView.Visible = false;
    end);
    GGButtonEffects.AddHoverEffect(SENSOR2);
    local AchievementsView = GGUIReferences.AchievementsView;
    local SENSOR3 = SideMenuButtons.Achievements.SENSOR;
    local u30 = "Achievements";
    SENSOR3.Activated:Connect(function() -- Line: 157
        -- upvalues: GGButtonEffects (ref), GGUI (ref), AchievementsView (copy), EmptyGrid (ref), u4 (ref), u30 (copy), GridView (copy)
        GGButtonEffects.Click();

        if GGUI.CurrentDetail then
            GGUI.CurrentDetail:Destroy();
        end;

        GGUI.NewPageOrder(AchievementsView, GGUI.CurrentPage);
        EmptyGrid((`{u4}Menu`));
        u4 = "";

        if GGUI.CurrentDetail then
            GGUI.CurrentDetail.Visible = false;
        end;

        GGUI.ChangeTopBar(u30, false);
        GridView.Visible = false;
    end);
    GGButtonEffects.AddHoverEffect(SENSOR3);
end;

local function ResetViewToProfile() -- Line: 180
    -- upvalues: GGUI (copy), GGUIReferences (copy), EmptyGrid (copy), u4 (ref), LocalPlayer (copy)
    if GGUI.CurrentDetail then
        GGUI.CurrentDetail:Destroy();
    end;

    GGUI.NewPageOrder(GGUIReferences.PlayerStatsView, GGUI.CurrentPage);
    EmptyGrid((`{u4}Menu`));
    u4 = "";

    if GGUI.CurrentDetail then
        GGUI.CurrentDetail.Visible = false;
    end;

    GGUI.ChangeTopBar(`{LocalPlayer.Name}'s Profile`, false);
    GGUIReferences.GridView.Visible = false;
end;

local function SetUpSortFilterButtons(u31: userdata) -- Line: 195
    -- upvalues: SortButtonsLogic (copy), GGStaticData (copy), GGButtonEffects (copy), GGUI (copy), GGData (copy), u4 (ref), u5 (ref), GGUIReferences (copy), VirtualList (copy), PlantTraitsData (copy), u1 (copy)
    local ButtonHolder = u31:FindFirstChild("ButtonHolder");

    local function updateTraitFilter(u32) -- Line: 230
        -- upvalues: u31 (copy), ButtonHolder (copy), SortButtonsLogic (ref)
        if u31.Name ~= "Filter" then
            return;
        end;

        if ButtonHolder.Traits.Visible then
            SortButtonsLogic.SetFilterStep("Traits", function(p33) -- Line: 241
                -- upvalues: u32 (copy)
                for i = #p33, 1, -1 do
                    local string_lower_ret = string.lower(p33[i].Traits);
                    local v34 = i;
                    local v35 = false;

                    for i2, v in u32 do
                        if v and string.find(string_lower_ret, i2) then
                            v35 = true;
                            break;
                        end;
                    end;

                    if not v35 then
                        table.remove(p33, v34);
                    end;
                end;
            end);

            return;
        end;

        SortButtonsLogic.SetFilterStep("Traits", nil);
    end;

    local function u36() -- Line: 267
    end;

    local u37 = {};

    local function updateCanvasSize() -- Line: 198
        -- upvalues: u31 (copy), ButtonHolder (copy)
        if u31.Name ~= "Filter" then
            return;
        end;

        local v38 = ButtonHolder:FindFirstChildOfClass("UIListLayout");
        local v39 = 0;

        for _, child in ButtonHolder:GetChildren() do
            if child:IsA("Frame") and child.Visible then
                v39 = v39 + (child.Size.Y.Scale + (not v38 and 0 or v38.Padding.Scale));

                if child:GetAttribute("Dropdrown") and child.DropdownList.Visible then
                    local v40 = child;

                    for _, child2 in child.DropdownList:GetChildren() do
                        if child2:IsA("Frame") and child2.Name ~= "Spacer" then
                            v39 = v39 + child2.Size.Y.Scale * v40.DropdownList.Size.Y.Scale * v40.Size.Y.Scale;
                        end;
                    end;
                end;
            end;
        end;

        ButtonHolder.CanvasSize = UDim2.fromScale(0, v39);
    end;

    for _, child in ButtonHolder:GetChildren() do
        if child:IsA("Frame") then
            if GGStaticData.AnimatedColors[child.Name] then
                child:SetAttribute("Rarity", child.Name);
                GGStaticData.AnimatedColors[child.Name](child);
            end;

            local Attribute = child:GetAttribute("Dropdrown");
            local SENSOR = child:FindFirstChild("SENSOR");
            SENSOR.Activated:Connect(function() -- Line: 278
                -- upvalues: Attribute (copy), child (copy), updateCanvasSize (copy), GGButtonEffects (ref), GGUI (ref), u31 (copy), GGData (ref), u4 (ref), SortButtonsLogic (ref), u5 (ref), GGUIReferences (ref), VirtualList (ref), ButtonHolder (copy), PlantTraitsData (ref), u37 (copy), u36 (ref), updateTraitFilter (copy)
                if Attribute then
                    child.DropdownList.Visible = not child.DropdownList.Visible;
                    updateCanvasSize();

                    return;
                end;

                GGButtonEffects.Click();

                if not GGUI.CurrentPage then
                    warn("MenuControl | No grid view to search");

                    return;
                end;

                GGUI.CurrentPage:GetChildren();
                local Attribute2 = child:GetAttribute("Algorithm");

                if u31.Name == "Sort" then
                    GGUI.SortAlgo = Attribute2;
                elseif u31.Name == "Filter" then
                    GGUI.FilterAlgo = Attribute2;
                    GGUI.FilterType = child.Name;
                end;

                local u41 = {};

                for _, v in GGData[u4].Data do
                    table.insert(u41, v);
                end;

                SortButtonsLogic.FilterAndSort(u41);
                local u42 = `{u4}Menu`;
                task.spawn(function() -- Line: 56
                    -- upvalues: GGUIReferences (ref), u42 (copy), VirtualList (ref), u41 (copy)
                    local GridView = GGUIReferences.GridView;
                    local v43 = GridView:FindFirstChild(u42);
                    local GridSFrame = GridView.GridSFrame;
                    v43.Parent = GridView;
                    GridSFrame.CanvasPosition = Vector2.zero;
                    VirtualList(v43, GridSFrame, u41);
                end);
                GGUIReferences.MenuGrids.CanvasPosition = Vector2.zero;

                if GGUI.FilterAlgo == "Reset" then
                    local Traits = ButtonHolder:FindFirstChild("Traits");

                    if not Traits then
                        return;
                    end;

                    local DropdownList = Traits:FindFirstChild("DropdownList");

                    for _, v in PlantTraitsData.TraitNames do
                        u37[v] = true;
                        local v44 = DropdownList:FindFirstChild(v);

                        if v44 then
                            local CHECK_ON = v44:FindFirstChild("CHECK_ON");
                            local CHECK_OFF = v44:FindFirstChild("CHECK_OFF");
                            CHECK_ON.Visible = true;
                            CHECK_OFF.Visible = false;
                        end;
                    end;

                    u36();
                    local v45 = {};

                    for i, v in u37 do
                        v45[string.lower(i)] = v;
                    end;

                    updateTraitFilter(v45);
                    local u46 = {};

                    for _, v in GGData[u4].Data do
                        table.insert(u46, v);
                    end;

                    SortButtonsLogic.FilterAndSort(u46);
                    local u47 = `{u4}Menu`;
                    task.spawn(function() -- Line: 56
                        -- upvalues: GGUIReferences (ref), u47 (copy), VirtualList (ref), u46 (copy)
                        local GridView = GGUIReferences.GridView;
                        local v48 = GridView:FindFirstChild(u47);
                        local GridSFrame = GridView.GridSFrame;
                        v48.Parent = GridView;
                        GridSFrame.CanvasPosition = Vector2.zero;
                        VirtualList(v48, GridSFrame, u46);
                    end);
                end;
            end);
            GGButtonEffects.AddHoverEffect(SENSOR);

            if Attribute then
                local u49;

                if child.Name == "Traits" then
                    u49 = child;

                    for _, v in PlantTraitsData.TraitNames do
                        if not u1.PlantTraitsBlacklist[v] then
                            u37[v] = true;
                        end;
                    end;
                else
                    u49 = child;
                end;

                local v50 = {};

                for i in u37 do
                    table.insert(v50, i);
                end;

                table.sort(v50);

                for _, v in v50 do
                    local v51 = u37[v];
                    local u52 = u49.DropdownList.Segment:Clone();
                    u52.Name = v;
                    u52.BUTTON_NAME.Text = v;
                    u52.BUTTON_NAME_SHADOW.Text = v;
                    u52.CHECK_ON.Visible = v51;
                    u52.CHECK_OFF.Visible = not v51;
                    u52.Visible = true;
                    u52.Parent = u49.DropdownList;
                    u52.SENSOR.Activated:Connect(function() -- Line: 363
                        -- upvalues: GGButtonEffects (ref), u37 (copy), v (copy), u52 (copy), u49 (copy), updateTraitFilter (copy), GGData (ref), u4 (ref), SortButtonsLogic (ref), u5 (ref), GGUIReferences (ref), VirtualList (ref)
                        GGButtonEffects.Click();
                        u37[v] = not u37[v];
                        local v53 = u37[v];
                        u52.CHECK_ON.Visible = v53;
                        u52.CHECK_OFF.Visible = not v53;

                        if u49.Name == "Traits" then
                            local v54 = {};

                            for i, v3 in u37 do
                                v54[string.lower(i)] = v3;
                            end;

                            updateTraitFilter(v54);
                        end;

                        local u55 = {};

                        for _, v3 in GGData[u4].Data do
                            table.insert(u55, v3);
                        end;

                        SortButtonsLogic.FilterAndSort(u55);
                        local u56 = `{u4}Menu`;
                        task.spawn(function() -- Line: 56
                            -- upvalues: GGUIReferences (ref), u56 (copy), VirtualList (ref), u55 (copy)
                            local GridView = GGUIReferences.GridView;
                            local v57 = GridView:FindFirstChild(u56);
                            local GridSFrame = GridView.GridSFrame;
                            v57.Parent = GridView;
                            GridSFrame.CanvasPosition = Vector2.zero;
                            VirtualList(v57, GridSFrame, u55);
                        end);
                        GGUIReferences.MenuGrids.CanvasPosition = Vector2.zero;
                    end);
                end;

                if u49.Name == "Traits" then
                    local u58 = u49.DropdownList.Segment:Clone();
                    u58.Name = "ToggleAll";
                    u49.DropdownList.Spacer.LayoutOrder = -2;
                    u58.LayoutOrder = -1;
                    u58.CHECK_ON.Visible = false;
                    u58.CHECK_OFF.Visible = false;
                    u58.Visible = true;
                    u58.Parent = u49.DropdownList;

                    local function isAllSelected() -- Line: 402
                        -- upvalues: u37 (copy)
                        for _, v in u37 do
                            if not v then
                                return false;
                            end;
                        end;

                        return true;
                    end;

                    u36 = function() -- Line: 411, Name: refreshLabel
                        -- upvalues: u37 (copy), u58 (copy)
                        local v59 = true;

                        for _, v in u37 do
                            if not v then
                                v59 = false;
                                break;
                            end;
                        end;

                        local v60 = v59 and "Deselect All" or "Select All";
                        u58.BUTTON_NAME.Text = v60;
                        u58.BUTTON_NAME_SHADOW.Text = v60;
                    end;

                    local v61 = true;

                    for _, v in u37 do
                        if not v then
                            v61 = false;
                            break;
                        end;
                    end;

                    local v62 = v61 and "Deselect All" or "Select All";
                    u58.BUTTON_NAME.Text = v62;
                    u58.BUTTON_NAME_SHADOW.Text = v62;
                    u58.SENSOR.Activated:Connect(function() -- Line: 419
                        -- upvalues: GGButtonEffects (ref), u37 (copy), u49 (copy), u58 (copy), updateTraitFilter (copy), GGData (ref), u4 (ref), SortButtonsLogic (ref), u5 (ref), GGUIReferences (ref), VirtualList (ref)
                        GGButtonEffects.Click();
                        local v63 = true;

                        for _, v in u37 do
                            if not v then
                                v63 = false;
                                break;
                            end;
                        end;

                        local v64 = not v63;

                        for i in u37 do
                            u37[i] = v64;
                            local v65 = u49.DropdownList:FindFirstChild(i);

                            if v65 then
                                v65.CHECK_ON.Visible = v64;
                                v65.CHECK_OFF.Visible = not v64;
                            end;
                        end;

                        local v66 = true;

                        for _, v in u37 do
                            if not v then
                                v66 = false;
                                break;
                            end;
                        end;

                        local v67 = v66 and "Deselect All" or "Select All";
                        u58.BUTTON_NAME.Text = v67;
                        u58.BUTTON_NAME_SHADOW.Text = v67;
                        local v68 = {};

                        for i, v in u37 do
                            v68[string.lower(i)] = v;
                        end;

                        updateTraitFilter(v68);
                        local u69 = {};

                        for _, v in GGData[u4].Data do
                            table.insert(u69, v);
                        end;

                        SortButtonsLogic.FilterAndSort(u69);
                        local u70 = `{u4}Menu`;
                        task.spawn(function() -- Line: 56
                            -- upvalues: GGUIReferences (ref), u70 (copy), VirtualList (ref), u69 (copy)
                            local GridView = GGUIReferences.GridView;
                            local v71 = GridView:FindFirstChild(u70);
                            local GridSFrame = GridView.GridSFrame;
                            v71.Parent = GridView;
                            GridSFrame.CanvasPosition = Vector2.zero;
                            VirtualList(v71, GridSFrame, u69);
                        end);
                        GGUIReferences.MenuGrids.CanvasPosition = Vector2.zero;
                    end);
                    GGButtonEffects.AddHoverEffect(u58.SENSOR);
                    GGUI.OnPageOrderUpdate:Connect(function() -- Line: 446
                        -- upvalues: ButtonHolder (copy), GGUI (ref), u37 (copy), updateTraitFilter (copy), u58 (copy), updateCanvasSize (copy)
                        ButtonHolder.Traits.Visible = GGUI.CurrentPage and GGUI.CurrentPage.Name == "PlantMenu";
                        local v72 = {};

                        for i, v in u37 do
                            v72[string.lower(i)] = v;
                        end;

                        updateTraitFilter(v72);
                        local v73 = true;

                        for _, v in u37 do
                            if not v then
                                v73 = false;
                                break;
                            end;
                        end;

                        local v74 = v73 and "Deselect All" or "Select All";
                        u58.BUTTON_NAME.Text = v74;
                        u58.BUTTON_NAME_SHADOW.Text = v74;
                        updateCanvasSize();
                    end);
                end;
            end;
        end;
    end;

    GGUI.OnPageOrderUpdate:Connect(updateCanvasSize);
    updateCanvasSize();
end;

local function SetUpTopBar() -- Line: 466
    -- upvalues: GGUIReferences (copy), GGButtonEffects (copy), GardenGuideController (copy), GardenGuideData (copy), Players (copy), GGUI (copy), SetUpSortFilterButtons (copy), GGSearchBarHandler (copy)
    local SENSOR = GGUIReferences.ExitFrame:FindFirstChild("SENSOR");
    SENSOR.Activated:Connect(function() -- Line: 468
        -- upvalues: GGButtonEffects (ref), GardenGuideController (ref), GardenGuideData (ref), Players (ref)
        GGButtonEffects.Click();
        GardenGuideController:Close();
        local v75 = GardenGuideData.UseTool and Players.LocalPlayer.Character:FindFirstChild("Humanoid");

        if v75 then
            v75:UnequipTools();
        end;
    end);
    GGButtonEffects.AddHoverEffect(SENSOR);
    local SENSOR2 = GGUIReferences.BackFrame:FindFirstChild("SENSOR");
    SENSOR2.Activated:Connect(function() -- Line: 483
        -- upvalues: GGUI (ref)
        GGUI.GoBackPage();
    end);
    GGButtonEffects.AddHoverEffect(SENSOR2);

    local function ToggleFrame(p76: userdata, p77: userdata) -- Line: 488
        -- upvalues: GGUIReferences (ref)
        if not p77.Visible then
            p76.Visible = not p76.Visible;
            GGUIReferences.DropDownMenus.Visible = p76.Visible;

            return;
        end;

        p76.Visible = true;
        p77.Visible = false;
        GGUIReferences.DropDownMenus.Visible = p76.Visible;
    end;

    local SortDropDown = GGUIReferences.SortDropDown;
    local SortButton = GGUIReferences.SortButton;
    local FilterDropDown = GGUIReferences.FilterDropDown;
    local FilterButton = GGUIReferences.FilterButton;
    SetUpSortFilterButtons(SortDropDown);
    SortButton.Activated:Connect(function() -- Line: 504
        -- upvalues: GGButtonEffects (ref), SortDropDown (copy), FilterDropDown (copy), GGUIReferences (ref)
        GGButtonEffects.Click();
        local v78 = SortDropDown;
        local v79 = FilterDropDown;

        if not v79.Visible then
            v78.Visible = not v78.Visible;
            GGUIReferences.DropDownMenus.Visible = v78.Visible;

            return;
        end;

        v78.Visible = true;
        v79.Visible = false;
        GGUIReferences.DropDownMenus.Visible = v78.Visible;
    end);
    GGButtonEffects.AddHoverEffect(SortButton);
    SetUpSortFilterButtons(FilterDropDown);
    FilterButton.Activated:Connect(function() -- Line: 511
        -- upvalues: GGButtonEffects (ref), FilterDropDown (copy), SortDropDown (copy), GGUIReferences (ref)
        GGButtonEffects.Click();
        local v80 = FilterDropDown;
        local v81 = SortDropDown;

        if not v81.Visible then
            v80.Visible = not v80.Visible;
            GGUIReferences.DropDownMenus.Visible = v80.Visible;

            return;
        end;

        v80.Visible = true;
        v81.Visible = false;
        GGUIReferences.DropDownMenus.Visible = v80.Visible;
    end);
    GGButtonEffects.AddHoverEffect(FilterButton);
    GGSearchBarHandler.ConnectSearchBar();
end;

local function SetUpGridHolder(p82: string) -- Line: 522
    -- upvalues: Templates (copy), GGUIReferences (copy)
    local v83 = Templates.GridHolderTemplate:Clone();
    v83.Name = `{p82}Menu`;
    v83:SetAttribute("MenuId", p82);
    v83.Visible = false;
    v83.Parent = GGUIReferences.GridView;
end;

function v2.OpenGGOnPage(p84: table, p85: string) -- Line: 556
    -- upvalues: GardenGuideController (copy), GGUIReferences (copy), GGButtonEffects (copy), GGUI (copy), u3 (copy), EmptyGrid (copy), u4 (ref), u5 (ref), GGData (copy), SortButtonsLogic (copy), VirtualList (copy), UpdateProgressBar (copy)
    GardenGuideController:Open();
    local GridView = GGUIReferences.GridView;
    GGButtonEffects.Click();

    if GGUI.CurrentDetail then
        GGUI.CurrentDetail:Destroy();
    end;

    if u3[p85] then
        GGUI.NewPageOrder(u3[p85], GGUI.CurrentPage);
        GridView.Visible = true;
        GGUI.ChangeTopBar(p85, true);
        u3[p85]:GetChildren();

        if u4 ~= p85 then
            task.spawn(function() -- Line: 588
                -- upvalues: EmptyGrid (ref), u4 (ref)
                EmptyGrid((`{u4}Menu`));
            end);

            if GridView:FindFirstChild((`{p85}Menu`)).Visible and u4 ~= p85 then
                u5 = u5 + 1;

                if u4 then
                    EmptyGrid(u4);
                end;

                u4 = p85;
                local u86 = {};

                for _, v in GGData[u4].Data do
                    table.insert(u86, v);
                end;

                SortButtonsLogic.FilterAndSort(u86);
                local u87 = `{u4}Menu`;
                task.spawn(function() -- Line: 56
                    -- upvalues: GGUIReferences (ref), u87 (copy), VirtualList (ref), u86 (copy)
                    local GridView2 = GGUIReferences.GridView;
                    local v88 = GridView2:FindFirstChild(u87);
                    local GridSFrame = GridView2.GridSFrame;
                    v88.Parent = GridView2;
                    GridSFrame.CanvasPosition = Vector2.zero;
                    VirtualList(v88, GridSFrame, u86);
                end);
            end;
        end;

        UpdateProgressBar(GGData[p85]);

        return;
    end;

    GGUI.NewPageOrder(GGUIReferences.AchievementsView, GGUI.CurrentPage);
    EmptyGrid((`{u4}Menu`));
    u4 = "";

    if GGUI.CurrentDetail then
        GGUI.CurrentDetail.Visible = false;
    end;

    GGUI.ChangeTopBar("Achievements", false);
    GridView.Visible = false;
end;

(function() -- Line: 532, Name: SetUpAllMenus
    -- upvalues: GGUIReferences (copy), Templates (copy), SetUpTopBar (copy), SetUpSideMenu (copy), GGUI (copy), LocalPlayer (copy)
    local MenuGrids = GGUIReferences.MenuGrids;

    for _, v in { "Plant", "Pet", "Cosmetic", "Food", "Mutation" } do
        if not MenuGrids:FindFirstChild((`{v}Menu`)) then
            local v89 = Templates.GridHolderTemplate:Clone();
            v89.Name = `{v}Menu`;
            v89:SetAttribute("MenuId", v);
            v89.Visible = false;
            v89.Parent = GGUIReferences.GridView;
        end;
    end;

    SetUpTopBar();
    SetUpSideMenu();
    GGUI.ChangeTopBar(`{LocalPlayer.Name}'s Profile`, false);
    GGUI.CurrentPage = GGUIReferences.PlayerStatsView;
end)();
local PathSignal = DataService:GetPathSignal("GardenGuide/@");

if PathSignal then
    PathSignal:Connect(function(p90: string, p91: any, p92: string) -- Line: 605
        -- upvalues: GGData (copy), GGUI (copy), GridCellHandler (copy), GGUIReferences (copy), VirtualList (copy), SortButtonsLogic (copy), UpdateProgressBar (copy), DetailsViewHandler (copy)
        if not p91 then
            return;
        end;

        local string_split_ret = string.split(p92, "/");
        local v93;

        if #string_split_ret >= 3 then
            v93 = string_split_ret[3] or nil;
        else
            v93 = nil;
        end;

        if not v93 then
            warn(`No changes {v93}`, string_split_ret);

            return;
        end;

        local u94 = string_split_ret[2]:gsub("Data", "");
        local v95 = GGData[u94];

        if not v95 then
            warn((`MenuControl | No data module {u94}`));

            return;
        end;

        local v96 = string_split_ret[3];
        v95.UpdateData(v96);
        local u97 = GGData[u94].Data[v96];

        if not u97 then
            warn((`UpdateGridCells | No data in {u94} for {v96}`));

            return;
        end;

        if GGUI.CurrentPage.Name == `{u94}Menu` then
            GridCellHandler.UpdateGridCell(u94, u97, v96, GGUIReferences.MenuGrids);
            local CurrentPage = GGUI.CurrentPage;
            local GridSFrame = GGUI.GridSFrame;
            local v98 = {};

            for _, v in GGData[u94].Data do
                table.insert(v98, v);
            end;

            SortButtonsLogic.FilterAndSort(v98);
            VirtualList(CurrentPage, GridSFrame, v98);
            UpdateProgressBar(v95);
        end;

        local u99 = GGUIReferences.MainMenuFrame:FindFirstChild((`{v96}Details`));

        if not u99 then
            return;
        end;

        task.spawn(function() -- Line: 635
            -- upvalues: DetailsViewHandler (ref), u99 (copy), u97 (copy), u94 (copy)
            DetailsViewHandler.UpdateDetailsView(u99, u97, u94);
        end);
    end);
end;

GGUIReferences.GardenGuideScreen:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 641
    -- upvalues: Players (copy), GGUIReferences (copy), ActivePetsUIController (copy)
    Players.LocalPlayer.PlayerGui.Teleport_UI.Enabled = not GGUIReferences.GardenGuideScreen.Enabled;

    if GGUIReferences.GardenGuideScreen.Enabled then
        ActivePetsUIController:Close();
    end;
end);
task.spawn(function() -- Line: 646
    -- upvalues: UpdateService (copy), GGData (copy), ResetViewToProfile (copy)
    while not UpdateService:IsUpdateDone() do
        task.wait(1);
    end;

    task.spawn(GGData.Plant.RegatherData);
    task.spawn(GGData.Pet.RegatherData);
    task.spawn(GGData.Cosmetic.RegatherData);
    task.spawn(GGData.Food.RegatherData);
    task.spawn(GGData.Mutation.RegatherData);
    ResetViewToProfile();
end);

return v2;