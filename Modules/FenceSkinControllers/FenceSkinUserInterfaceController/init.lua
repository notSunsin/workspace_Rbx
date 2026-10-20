-- Decompiled with Potassium's decompiler.

game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Lighting");
local Players = game:GetService("Players");
local FenceSkinController = require(ReplicatedStorage.Modules.FenceSkinControllers.FenceSkinController);
require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);
local FenceSkinRegistry = require(ReplicatedStorage.Data.FenceSkinRegistry);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Item_Module = require(ReplicatedStorage.Item_Module);
local GetFarmAsync = require(ReplicatedStorage.Modules.GetFarmAsync);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local Field_Of_View_Module = require(ReplicatedStorage.Field_Of_View_Module);
local Blur_Module = require(ReplicatedStorage.Blur_Module);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local SkinUtils = require(ReplicatedStorage.Modules.SkinUtils);
local FenceSkinSelector = Players.LocalPlayer.PlayerGui:WaitForChild("FenceSkinSelector");
local SkinSelector = FenceSkinSelector.SkinSelector;
local Main = SkinSelector.Main;
local Content = Main.Skins.ScrollerHolder.Scroller.Content;
local script_ItemTemplate = script.ItemTemplate;
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local Spring = require(ReplicatedStorage.Modules.Spring);
require(ReplicatedStorage.Modules.Chalk);
local u1 = {
    HIDDEN = {}
};

local function UpdateEquippedFence(p2: string) -- Line: 31
    -- upvalues: FenceSkinController (copy), Content (copy)
    local OwnedFences = FenceSkinController:GetOwnedFences();

    for _, child in Content:GetChildren() do
        if child:IsA("Frame") then
            local v3 = p2 == child.Name and "Equipped" or (OwnedFences[child.Name] and "Owned" or "Unowned");
            child.EQUIPPED_IMAGE.Visible = v3 == "Equipped";
            child.LayoutOrder = v3 == "Equipped" and 1 or (v3 == "Owned" and 2 or (v3 == "Unowned" and 3 or 4));
        end;
    end;
end;

function u1.Start(p4) -- Line: 41
    -- upvalues: GetFarmAsync (copy), Players (copy), GuiController (copy), FenceSkinSelector (copy), SkinSelector (copy), Spring (copy), Field_Of_View_Module (copy), Blur_Module (copy), SetupButton (copy), DataService (copy), Content (copy), UpdateEquippedFence (copy), FenceSkinController (copy), FenceSkinRegistry (copy), Item_Module (copy), script_ItemTemplate (copy), SkinUtils (copy), UpdateService (copy), u1 (copy), Main (copy)
    local v5 = GetFarmAsync(Players.LocalPlayer);

    if not v5 then
        return;
    end;

    local Sign = v5:WaitForChild("Sign");
    local v6 = script.ProximityPrompt:Clone();
    v6.Parent = Sign.PrimaryPart;
    v6.Triggered:Connect(function() -- Line: 50
        -- upvalues: GuiController (ref), FenceSkinSelector (ref)
        GuiController:Toggle(FenceSkinSelector);
    end);
    FenceSkinSelector.Enabled = false;
    SkinSelector.Interactable = false;
    SkinSelector.Position = UDim2.fromScale(0.5, 0.45);
    SkinSelector.DropShadowHolder.DropShadowHolder.DropShadow.ImageTransparency = 1;
    SkinSelector.Main.GroupTransparency = 1;
    SkinSelector.Main.UIStroke.Transparency = 1;
    local StateForGui = GuiController:GetStateForGui(FenceSkinSelector);
    StateForGui.ChangeEnabled:Set(true);
    StateForGui.Visible:Observe(function(p7) -- Line: 65
        -- upvalues: SkinSelector (ref), Spring (ref), Field_Of_View_Module (ref), Blur_Module (ref)
        SkinSelector.Interactable = p7;
        Spring.target(SkinSelector, 1, 3, {
            Position = UDim2.fromScale(0.5, p7 and 0.5 or 0.45)
        });
        Spring.target(SkinSelector.DropShadowHolder.DropShadowHolder.DropShadow, 1, 3, {
            ImageTransparency = p7 and 0.6 or 1
        });
        Spring.target(SkinSelector.Main, 1, 3, {
            GroupTransparency = p7 and 0 or 1
        });
        Spring.target(SkinSelector.Main.UIStroke, 1, 3, {
            Transparency = p7 and 0 or 1
        });
        Field_Of_View_Module.Change_FOV(p7 and 60 or 70);
        Blur_Module.Blur(p7 and 15 or 0, 0.1);
    end);
    SetupButton({
        offset = 0.1,
        legacy = true,
        instance = SkinSelector.Main.Skins.Header.Exit.SENSOR,

        onclick = function() -- Line: 79, Name: onclick
            -- upvalues: GuiController (ref), FenceSkinSelector (ref)
            GuiController:Close(FenceSkinSelector);
        end
    });
    DataService:GetPathSignal("FenceSkinData/OwnedFences"):Connect(function(p8, p9) -- Line: 84
        -- upvalues: Content (ref), Spring (ref)
        local v10 = Content:FindFirstChild(p8);

        if not v10 then
            return;
        end;

        Spring.target(v10.Cover, 1, 3, {
            BackgroundTransparency = p9 and 1 or 0.6
        });
        v10.LayoutOrder = p9 and 2 or 3;
        v10.LockIcon.Visible = not p9;
    end);
    DataService:GetPathSignal("SaveSlots/SelectedSlot/@"):Connect(function(p11, p12, p13) -- Line: 93
        -- upvalues: DataService (ref), UpdateEquippedFence (ref)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        local SelectedFenceSkin = Data.SaveSlots.AllSlots[p12].SelectedFenceSkin;

        if not SelectedFenceSkin then
            return;
        end;

        UpdateEquippedFence(SelectedFenceSkin);
    end);
    DataService:GetPathSignal("SaveSlots/@"):Connect(function(p14, p15, p16) -- Line: 104
        -- upvalues: UpdateEquippedFence (ref)
        if not p16:find("SelectedFenceSkin") then
            return;
        end;

        UpdateEquippedFence(p15);
    end);
    local OwnedFences = FenceSkinController:GetOwnedFences();

    local function addFenceFrame(u17) -- Line: 111
        -- upvalues: FenceSkinRegistry (ref), Item_Module (ref), script_ItemTemplate (ref), OwnedFences (copy), FenceSkinController (ref), SetupButton (ref), SkinUtils (ref), Content (ref)
        if not u17 then
            warn("FenceSkinUserInterfaceController/addFenceFrame: Got NIL skinID");

            return;
        end;

        local v18 = FenceSkinRegistry[u17];

        if not v18 then
            warn((`FenceSkinUserInterfaceController: Failed to Fetch skinID ({u17})`));

            return;
        end;

        if not v18.Rarity then
            v18.Rarity = Item_Module.Return_All_Seed_Rarities()[1][1];
        end;

        local v19 = script_ItemTemplate:Clone();
        v19.Name = u17;
        v19.ITEM_NAME.Text = v18.DisplayName or u17;
        v19.ITEM_NAME.TextColor3 = Item_Module.Return_Rarity_Data(v18.Rarity)[2];
        v19.ITEM_NAME_SHADOW.Text = v19.ITEM_NAME.ContentText;
        local v20 = v18.Rarity or Item_Module.Return_All_Seed_Rarities()[1][1];
        v19:SetAttribute("SearchId", string.lower(u17));
        v19:SetAttribute("SearchDisplay", string.lower(v19.ITEM_NAME.ContentText));
        v19:SetAttribute("SearchRarity", string.lower(v20));
        v19.Cover.BackgroundTransparency = OwnedFences[u17] and 1 or 0.6;
        local v21 = FenceSkinController:GetFenceSkin() == u17 and "Equipped" or (OwnedFences[v19.Name] and "Owned" or "Unowned");
        v19.EQUIPPED_IMAGE.Visible = v21 == "Equipped";
        v19.LockIcon.Visible = v21 == "Unowned";
        v19.LayoutOrder = v21 == "Equipped" and 1 or (v21 == "Owned" and 2 or (v21 == "Unowned" and 3 or 4));
        v19.ITEM_IMAGE.Image = `rbxassetid://{v18.Icon or 6937742258}`;
        SetupButton({
            offset = 0.1,
            legacy = true,
            instance = v19.SENSOR,

            onclick = function() -- Line: 151, Name: onclick
                -- upvalues: FenceSkinController (ref), u17 (copy)
                FenceSkinController:Equip(u17);
            end
        });
        v19.Visible = SkinUtils:GetFrameVisibility(true, v18, u17, "Fence");
        v19.Parent = Content;
    end;

    for i in FenceSkinRegistry do
        if UpdateService:IsHiddenFromUpdate(i) then
            table.insert(u1.HIDDEN, i);
        else
            addFenceFrame(i);
        end;
    end;

    if not UpdateService:IsUpdateDone() then
        task.spawn(function() -- Line: 176
            -- upvalues: UpdateService (ref), u1 (ref), addFenceFrame (copy)
            repeat
                task.wait(1);
            until UpdateService:IsUpdateDone();

            for i = 1, #u1.HIDDEN do
                local v22 = u1.HIDDEN[i];
                u1.HIDDEN[i] = nil;
                addFenceFrame(v22);
                local _ = i;
            end;
        end);
    end;

    Main.Skins.SearchBar.Main.TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 186
        -- upvalues: Main (ref), Content (ref), FenceSkinRegistry (ref), SkinUtils (ref)
        local string_lower_ret = string.lower(Main.Skins.SearchBar.Main.TextBox.Text);
        local v23 = {};

        for i in string.gmatch(string_lower_ret, "%S+") do
            table.insert(v23, i);
        end;

        for _, child in Content:GetChildren() do
            if child:IsA("Frame") then
                local v24 = child:GetAttribute("SearchId") or "";
                local v25 = child:GetAttribute("SearchDisplay") or "";
                local v26 = child:GetAttribute("SearchRarity") or "";

                if #v23 == 0 then
                    child.Visible = SkinUtils:GetFrameVisibility(true, FenceSkinRegistry[string.upper(v24)], string.upper(v24), "Fence");
                else
                    local v27 = true;

                    for _, v in v23 do
                        if not (string.find(v24, v, 1, true) or (string.find(v25, v, 1, true) or string.find(v26, v, 1, true))) then
                            v27 = false;
                            break;
                        end;
                    end;

                    child.Visible = SkinUtils:GetFrameVisibility(v27, FenceSkinRegistry[string.upper(v24)], string.upper(v24), "Fence");
                end;
            end;
        end;
    end);
end;

task.spawn(function() -- Line: 224
    -- upvalues: UpdateService (copy), u1 (copy)
    while UpdateService:IsHiddenFromUpdate("Fence Skins") do
        task.wait(1);
    end;

    task.spawn(u1.Start, u1);
end);

return u1;