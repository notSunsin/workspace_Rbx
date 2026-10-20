-- Decompiled with Potassium's decompiler.

local Signal = require(game:GetService("ReplicatedStorage").Modules.Signal);
local u1 = {};

local function lockTab(p2: table, p3: string, p4: boolean?) -- Line: 55
    local v5 = p4 or false;
    local v6 = p2.TabLookup[p3];

    if v6 == nil then
        warn("UITabHelperModule: lockTab: Tab not registered.");

        return;
    end;

    if v6.IsLocked ~= nil and v6.IsLocked == true then
        v6.IsLocked = true;

        return;
    end;

    v6.IsLocked = true;

    if p2.CurrentCategory ~= p3 then
        if v5 then
            return;
        end;

        p2.RebuildCategoryList();

        return;
    end;

    if not v5 then
        p2.SetCurrentCategory(p2.DefaultCategory);

        return;
    end;

    p2.CurrentCategory = p2.DefaultCategory;

    if p2.OnCategoryChanged ~= nil then
        p2.OnCategoryChanged:Fire(p2.CurrentCategory);
    end;
end;

local function unlockTab(p7: table, p8: string, p9: boolean?) -- Line: 90
    local v10 = p7.TabLookup[p8];

    if v10 == nil then
        warn("UITabHelperModule: unlockTab: Tab not registered.");

        return;
    end;

    if v10.IsLocked == nil or v10.IsLocked == false then
        v10.IsLocked = false;

        return;
    end;

    v10.IsLocked = false;

    if p9 or false then
        return;
    end;

    p7.RebuildCategoryList();
end;

local function setCategories(p11: table, p12: table) -- Line: 114
    p11.TabCategories = p12;
    p11.TabLookup = {};

    for _, v in p12 do
        p11.TabLookup[v.Name] = v;
    end;

    p11.RebuildCategoryList();
end;

local function setCurrentCategory(p13: table, p14: string) -- Line: 126
    if p13.TabLookup[p14] == nil then
        warn("UITabHelperModule: setCurrentCategory: Category not registered.");

        return;
    end;

    if p13.TabLookup[p14].IsLocked ~= nil and p13.TabLookup[p14].IsLocked == true then
        warn("UITabHelperModule: setCurrentCategory: Can\'t set category to " .. p14 .. ". Reason: Category locked.");

        return;
    end;

    p13.CurrentCategory = p14;
    p13.RebuildCategoryList();

    if p13.OnCategoryChanged then
        p13.OnCategoryChanged:Fire(p13.CurrentCategory);
    end;
end;

local function clearAllTabs(p15: table) -- Line: 147
    for _, v in p15.TabButtonConnections do
        v:Disconnect();
    end;

    table.clear(p15.TabButtonConnections);

    for _, v in p15.ButtonWidgets do
        v:Destroy();
    end;

    table.clear(p15.ButtonWidgets);
end;

local function rebuildCategoryList(u16: table) -- Line: 160
    local v17;

    if u16.CurrentCategory == nil and u16.DefaultCategory ~= nil then
        u16.CurrentCategory = u16.DefaultCategory;
        v17 = true;
    else
        v17 = false;
    end;

    if u16.RootWidget == nil then
        error((`UITabHelper: {u16.ID} has a null root widget.`));
    end;

    u16.ClearAllTabs();
    local math_clamp_ret = math.clamp(0.85 / #u16.TabCategories, 0.01, 0.1);

    for _, v in u16.TabCategories do
        local u18 = u16.TabButtonTemplate:Clone();
        local ZIndex = u18.ZIndex;
        local CategoryLabel = u18:WaitForChild("CategoryLabel");
        local LockedLabel = u18:WaitForChild("LockedLabel");

        if CategoryLabel:IsA("TextLabel") and LockedLabel:IsA("TextLabel") then
            CategoryLabel.Text = v.Name;
            u18.Name = v.Name;
            table.insert(u16.ButtonWidgets, u18);
            u18.Parent = u16.RootWidget;
            u18.AutoButtonColor = true;
            u18.Interactable = true;
            u18.Size = UDim2.new(1, 0, math_clamp_ret, nil);

            if v.IsLocked == nil or v.IsLocked ~= true then
                LockedLabel.Visible = false;
                CategoryLabel.Visible = true;

                if v.Color then
                    u18.BackgroundColor3 = v.Color;
                end;

                if u16.CurrentCategory == u18.Name then
                    u18.Size = u18.Size + UDim2.new(0.05, 0, 0.025);
                    u18.BorderColor3 = Color3.new(1, 1, 1);
                    u18.BorderSizePixel = 4;
                    u18.ZIndex = ZIndex + 1;
                else
                    u18.BackgroundColor3 = Color3.new(u18.BackgroundColor3.R * 0.7, u18.BackgroundColor3.G * 0.7, u18.BackgroundColor3.B * 0.7);
                    u18.BorderColor3 = Color3.new(0.364706, 0.352941, 0.0784314);
                    u18.ZIndex = ZIndex;
                end;

                table.insert(u16.TabButtonConnections, u18.Activated:Connect(function() -- Line: 236
                    -- upvalues: u16 (copy), u18 (copy)
                    u16.SetCurrentCategory(u18.Name);
                end));
            else
                u18.ImageColor3 = Color3.new(0.3, 0.3, 0.3);
                u18.AutoButtonColor = false;
                u18.Interactable = false;
                CategoryLabel.TextTransparency = 0.6;
                u18.BackgroundColor3 = Color3.new(u18.BackgroundColor3.R * 0.5, u18.BackgroundColor3.G * 0.5, u18.BackgroundColor3.B * 0.5);
                u18.BorderColor3 = Color3.new(0.364706, 0.352941, 0.0784314);
                LockedLabel.Visible = true;
                CategoryLabel.Visible = false;
            end;
        end;
    end;

    if v17 and u16.OnCategoryChanged then
        u16.OnCategoryChanged:Fire(u16.CurrentCategory);
    end;
end;

return {
    CreateOrGetTabHandler = function(u19: string, p20: userdata, p21: userdata) -- Line: 252, Name: createOrGetTabHandler
        -- upvalues: u1 (ref), setCategories (copy), rebuildCategoryList (copy), setCurrentCategory (copy), clearAllTabs (copy), lockTab (copy), Signal (copy)
        if u1 == nil then
            u1 = {};
        end;

        if not u1[u19] then
            u1[u19] = {
                DefaultCategory = "All",

                SetCategories = function(p22: table) -- Line: 269, Name: SetCategories
                    -- upvalues: setCategories (ref), u1 (ref), u19 (copy)
                    setCategories(u1[u19], p22);
                end,

                RebuildCategoryList = function() -- Line: 275, Name: RebuildCategoryList
                    -- upvalues: rebuildCategoryList (ref), u1 (ref), u19 (copy)
                    rebuildCategoryList(u1[u19]);
                end,

                SetCurrentCategory = function(p23: string) -- Line: 281, Name: SetCurrentCategory
                    -- upvalues: setCurrentCategory (ref), u1 (ref), u19 (copy)
                    setCurrentCategory(u1[u19], p23);
                end,

                ClearAllTabs = function() -- Line: 287, Name: ClearAllTabs
                    -- upvalues: clearAllTabs (ref), u1 (ref), u19 (copy)
                    clearAllTabs(u1[u19]);
                end,

                UnlockTab = function(p24: string, p25: boolean?) -- Line: 293, Name: UnlockTab
                    -- upvalues: u1 (ref), u19 (copy)
                    local v26 = u1[u19];
                    local v27 = v26.TabLookup[p24];

                    if v27 == nil then
                        warn("UITabHelperModule: unlockTab: Tab not registered.");

                        return;
                    end;

                    if v27.IsLocked == nil or v27.IsLocked == false then
                        v27.IsLocked = false;

                        return;
                    end;

                    v27.IsLocked = false;

                    if p25 or false then
                        return;
                    end;

                    v26.RebuildCategoryList();
                end,

                LockTab = function(p28: string, p29: boolean?) -- Line: 299, Name: LockTab
                    -- upvalues: lockTab (ref), u1 (ref), u19 (copy)
                    lockTab(u1[u19], p28, p29);
                end,

                TabButtonConnections = {},
                TabCategories = {},
                TabLookup = {},
                ButtonWidgets = {},
                RootWidget = p20,
                TabButtonTemplate = p21,
                ID = u19,
                OnCategoryChanged = Signal.new()
            };

            return u1[u19];
        end;

        local v30 = u1[u19];
        v30.RootWidget = p20;
        v30.TabButtonTemplate = p21;

        return v30;
    end,

    DisposeTabHandler = function(p31: table) -- Line: 327, Name: disposeTabHandler
        -- upvalues: u1 (ref)
        local ID = p31.ID;

        if u1[ID] then
            u1[ID] = nil;
        end;
    end,

    DisposeTabHandlerID = function(p32: string) -- Line: 320, Name: disposeTabHandlerID
        -- upvalues: u1 (ref)
        if u1[p32] then
            u1[p32] = nil;
        end;
    end
};