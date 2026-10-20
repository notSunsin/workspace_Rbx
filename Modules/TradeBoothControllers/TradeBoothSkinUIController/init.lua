-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Data.EnumRegistry.ReversedItemTypeEnums);
require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
require(ReplicatedStorage.Modules.TradeBoothControllers.TradeBoothListingController);
require(ReplicatedStorage.Modules.TradeBoothControllers.TradeBoothBuyItemController);
require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
require(ReplicatedStorage.Modules.TeleportUIController);
require(ReplicatedStorage.Modules.ReplicationReciever);
require(ReplicatedStorage.Modules.ItemRarityFinder);
require(ReplicatedStorage.Modules.ItemImageFinder);
require(ReplicatedStorage.Modules.ItemNameFinder);
require(ReplicatedStorage.Data.TradeBoothsData);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.Observers);
require(ReplicatedStorage.Data.TradeData);
local Signal = require(ReplicatedStorage.Modules.Signal);
local Trove = require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.InventoryService);
require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
require(ReplicatedStorage.Modules.MutationHandler);
require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local DataService = require(ReplicatedStorage.Modules.DataService);
local TradeBoothSkinRegistry = require(ReplicatedStorage.Data.TradeBoothSkinRegistry);
local Item_Module = require(ReplicatedStorage.Item_Module);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local SkinUtils = require(ReplicatedStorage.Modules.SkinUtils);
local Field_Of_View_Module = require(ReplicatedStorage.Field_Of_View_Module);
local Blur_Module = require(ReplicatedStorage.Blur_Module);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local Spring = require(ReplicatedStorage.Modules.Spring);
require(ReplicatedStorage.Modules.Chalk);
local _ = PetRegistry.PetList;
local _ = Players.LocalPlayer;
local _ = ReplicatedStorage.GameEvents.TradeEvents;
local u1 = {};

local function GetFittingScale(p2: vector, p3: vector) -- Line: 63
    return math.min(p3.X / p2.X, p3.Y / p2.Y, p3.Z / p2.Z);
end;

local u4 = {
    HIDDEN = {}
};
Trove.new();
local TradeBoothSkinSelector = Players.LocalPlayer.PlayerGui:WaitForChild("TradeBoothSkinSelector");
local SkinSelector = TradeBoothSkinSelector.SkinSelector;
local Main = SkinSelector.Main;
local Content = Main.Skins.ScrollerHolder.Scroller.Content;
local script_ItemTemplate = script.ItemTemplate;
local u5 = Signal.new();

local function DoesOwnSkin(p6: string) -- Line: 84
    -- upvalues: SkinUtils (copy)
    return p6 == "Default" and true or (SkinUtils:GetOwnedSkin("TradeBooth", p6) and true or false);
end;

local function GetSkinCount(p7: string) -- Line: 105
    -- upvalues: DataService (copy)
    if p7 == "Default" then
        return 1;
    end;

    local Data = DataService:GetData();

    if not Data then
        return 0;
    end;

    local OwnedSkins = Data.TradeBoothSkinData.OwnedSkins;

    return not OwnedSkins[p7] and 0 or (typeof(OwnedSkins[p7]) == "boolean" and (OwnedSkins[p7] and 1 or 0) or OwnedSkins[p7]);
end;

function u4.Start(p8) -- Line: 124
    -- upvalues: TradeBoothSkinSelector (copy), SkinSelector (copy), GuiController (copy), Spring (copy), Field_Of_View_Module (copy), Blur_Module (copy), SetupButton (copy), DataService (copy), Content (copy), TradeBoothSkinRegistry (copy), SkinUtils (copy), Item_Module (copy), script_ItemTemplate (copy), ReplicatedStorage (copy), u5 (copy), u1 (copy), UpdateService (copy), u4 (copy), Main (copy)
    TradeBoothSkinSelector.Enabled = false;
    SkinSelector.Interactable = false;
    SkinSelector.Position = UDim2.fromScale(0.5, 0.45);
    SkinSelector.DropShadowHolder.DropShadowHolder.DropShadow.ImageTransparency = 1;
    SkinSelector.Main.GroupTransparency = 1;
    SkinSelector.Main.UIStroke.Transparency = 1;
    local StateForGui = GuiController:GetStateForGui(TradeBoothSkinSelector);
    StateForGui.ChangeEnabled:Set(true);
    StateForGui.Visible:Observe(function(p9) -- Line: 136
        -- upvalues: SkinSelector (ref), Spring (ref), Field_Of_View_Module (ref), Blur_Module (ref)
        SkinSelector.Interactable = p9;
        Spring.target(SkinSelector, 1, 3, {
            Position = UDim2.fromScale(0.5, p9 and 0.5 or 0.45)
        });
        Spring.target(SkinSelector.DropShadowHolder.DropShadowHolder.DropShadow, 1, 3, {
            ImageTransparency = p9 and 0.6 or 1
        });
        Spring.target(SkinSelector.Main, 1, 3, {
            GroupTransparency = p9 and 0 or 1
        });
        Spring.target(SkinSelector.Main.UIStroke, 1, 3, {
            Transparency = p9 and 0 or 1
        });
        Field_Of_View_Module.Change_FOV(p9 and 60 or 70);
        Blur_Module.Blur(p9 and 15 or 0, 0.1);
    end);
    SetupButton({
        offset = 0.1,
        legacy = true,
        instance = SkinSelector.Main.Skins.Header.Exit.SENSOR,

        onclick = function() -- Line: 150, Name: onclick
            -- upvalues: GuiController (ref), TradeBoothSkinSelector (ref)
            GuiController:Close(TradeBoothSkinSelector);
        end
    });
    DataService:GetPathSignal("TradeBoothSkinData/OwnedSkins"):Connect(function(p10, p11) -- Line: 155
        -- upvalues: Content (ref), Spring (ref), DataService (ref), TradeBoothSkinRegistry (ref), SkinUtils (ref)
        local v12 = Content:FindFirstChild(p10);

        if not v12 then
            return;
        end;

        Spring.target(v12.Cover, 1, 3, {
            BackgroundTransparency = p11 and 1 or 0.6
        });
        v12.LayoutOrder = p11 and 2 or 3;
        v12.LockIcon.Visible = not p11;
        local v13;

        if p10 == "Default" then
            v13 = 1;
        else
            local Data = DataService:GetData();

            if Data then
                local OwnedSkins = Data.TradeBoothSkinData.OwnedSkins;

                if OwnedSkins[p10] then
                    if typeof(OwnedSkins[p10]) == "boolean" then
                        v13 = OwnedSkins[p10] and 1 or 0;
                    else
                        v13 = OwnedSkins[p10];
                    end;
                else
                    v13 = 0;
                end;
            else
                v13 = 0;
            end;
        end;

        if v13 > 0 then
            v12.ITEM_QUANTITY.Visible = true;
            v12.ITEM_QUANTITY.Text = `x{v13}`;
        else
            v12.ITEM_QUANTITY.Visible = false;
        end;

        v12.Visible = SkinUtils:GetFrameVisibility(true, TradeBoothSkinRegistry[p10], p10, "TradeBooth");
    end);
    DataService:GetPathSignal("TradeBoothSkinData/CurrentSkin"):Connect(function(p14, p15, p16) -- Line: 176
    end);
    local Data = DataService:GetData();
    local OwnedSkins = Data.TradeBoothSkinData.OwnedSkins;

    local function addFenceFrame(u17) -- Line: 183
        -- upvalues: TradeBoothSkinRegistry (ref), Item_Module (ref), script_ItemTemplate (ref), DataService (ref), Data (copy), SkinUtils (ref), SetupButton (ref), OwnedSkins (copy), ReplicatedStorage (ref), u5 (ref), Content (ref)
        if not u17 then
            warn("FenceSkinUserInterfaceController/addFenceFrame: Got NIL skinID");

            return;
        end;

        local v18 = TradeBoothSkinRegistry[u17];

        if not v18 then
            warn((`FenceSkinUserInterfaceController: Failed to Fetch skinID ({u17})`));

            return;
        end;

        if not v18.Rarity then
            v18.Rarity = Item_Module.Return_All_Seed_Rarities()[1][1];
        end;

        local u19 = script_ItemTemplate:Clone();
        u19.Name = u17;
        u19.ITEM_NAME.Text = v18.DisplayName or u17;
        u19.ITEM_NAME.TextColor3 = Item_Module.Return_Rarity_Data(v18.Rarity)[2];
        u19.ITEM_NAME_SHADOW.Text = u19.ITEM_NAME.ContentText;
        local v20 = v18.Rarity or Item_Module.Return_All_Seed_Rarities()[1][1];
        u19:SetAttribute("SearchId", u17);
        u19:SetAttribute("SearchDisplay", string.lower(u19.ITEM_NAME.ContentText));
        u19:SetAttribute("SearchRarity", string.lower(v20));
        local v21;

        if u17 == "Default" then
            v21 = 1;
        else
            local Data2 = DataService:GetData();

            if Data2 then
                local OwnedSkins2 = Data2.TradeBoothSkinData.OwnedSkins;

                if OwnedSkins2[u17] then
                    if typeof(OwnedSkins2[u17]) == "boolean" then
                        v21 = OwnedSkins2[u17] and 1 or 0;
                    else
                        v21 = OwnedSkins2[u17];
                    end;
                else
                    v21 = 0;
                end;
            else
                v21 = 0;
            end;
        end;

        u19.Cover.BackgroundTransparency = v21 > 0 and 1 or 0.6;
        u19.ITEM_QUANTITY.Visible = v21 > 0;
        u19.ITEM_QUANTITY.Text = `x{v21}`;
        local v22;

        if Data.TradeBoothSkinData.CurrentSkin == u17 then
            v22 = "Equipped";
        else
            local Name = u19.Name;
            v22 = (Name == "Default" or SkinUtils:GetOwnedSkin("TradeBooth", Name)) and "Owned" or "Unowned";
        end;

        u19.EQUIPPED_IMAGE.Visible = false;
        u19.LockIcon.Visible = v22 == "Unowned";
        u19.LayoutOrder = u19.Name == "Default" and -1 or (v22 == "Equipped" and 1 or (v22 == "Owned" and 2 or (v22 == "Unowned" and 3 or 4)));
        u19.ITEM_IMAGE.Image = v18.Icon or "rbxassetid://6937742258";
        SetupButton({
            offset = 0.1,
            legacy = false,
            instance = u19.SENSOR,

            onclick = function() -- Line: 228, Name: onclick
                -- upvalues: OwnedSkins (ref), u19 (copy), ReplicatedStorage (ref), u17 (copy), u5 (ref)
                if not OwnedSkins[u19.Name] and u19.Name ~= "Default" then
                    return;
                end;

                ReplicatedStorage.GameEvents.TradeBoothSkinService.Equip:FireServer(u17);
                u5:Fire();
            end
        });
        u19.Visible = SkinUtils:GetFrameVisibility(true, v18, u17, "TradeBooth");
        u19.Parent = Content;
    end;

    for i in TradeBoothSkinRegistry do
        if not u1[i] then
            if UpdateService:IsHiddenFromUpdate((`TradeBoothSkins/{i}`)) then
                table.insert(u4.HIDDEN, i);
            else
                addFenceFrame(i);
            end;
        end;
    end;

    if not UpdateService:IsUpdateDone() then
        UpdateService.OnUpdated:Connect(function() -- Line: 254
            -- upvalues: u4 (ref), u1 (ref), addFenceFrame (copy)
            for i = 1, #u4.HIDDEN do
                local v23 = u4.HIDDEN[i];
                u4.HIDDEN[i] = nil;
                local v24;

                if u1[v23] then
                    v24 = i;
                else
                    addFenceFrame(v23);
                    v24 = i;
                end;
            end;
        end);
    end;

    Main.Skins.SearchBar.Main.TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 266
        -- upvalues: Main (ref), Content (ref), TradeBoothSkinRegistry (ref), SkinUtils (ref)
        local string_lower_ret = string.lower(Main.Skins.SearchBar.Main.TextBox.Text);
        local v25 = {};

        for i in string.gmatch(string_lower_ret, "%S+") do
            table.insert(v25, i);
        end;

        for _, child in Content:GetChildren() do
            if child:IsA("Frame") then
                local v26 = child:GetAttribute("SearchId") or "";
                local v27 = child:GetAttribute("SearchDisplay") or "";
                local v28 = child:GetAttribute("SearchRarity") or "";

                if #v25 == 0 then
                    child.Visible = SkinUtils:GetFrameVisibility(true, TradeBoothSkinRegistry[v26], v26, "TradeBooth");
                else
                    local v29 = true;

                    for _, v in v25 do
                        if not (string.find(v26, v, 1, true) or (string.find(v27, v, 1, true) or string.find(v28, v, 1, true))) then
                            v29 = false;
                            break;
                        end;
                    end;

                    child.Visible = SkinUtils:GetFrameVisibility(v29, TradeBoothSkinRegistry[v26], v26, "TradeBooth");
                end;
            end;
        end;
    end);
end;

function u4.Prompt(p30) -- Line: 304
    -- upvalues: Signal (copy), Trove (copy), GuiController (copy), TradeBoothSkinSelector (copy), u5 (copy)
    local u31 = Signal.new();
    local u32 = Trove.new();
    u32:Add(u31);
    GuiController:Open(TradeBoothSkinSelector);
    u32:Add(GuiController:GetStateForGui(TradeBoothSkinSelector).Visible:Listen(function(p33: boolean) -- Line: 311
        -- upvalues: u31 (copy), u32 (copy), GuiController (ref), TradeBoothSkinSelector (ref)
        if not p33 then
            u31:Fire(false);
            u32:Destroy();
            GuiController:Close(TradeBoothSkinSelector);
        end;
    end));
    u32:Add(u5:Connect(function() -- Line: 322
        -- upvalues: u31 (copy), u32 (copy), GuiController (ref), TradeBoothSkinSelector (ref)
        u31:Fire(true);
        u32:Destroy();
        GuiController:Close(TradeBoothSkinSelector);
    end));

    return u31;
end;

function u4.Close(p34) -- Line: 333
    -- upvalues: GuiController (copy), TradeBoothSkinSelector (copy)
    GuiController:Close(TradeBoothSkinSelector);
end;

function u4.Open(p35) -- Line: 337
    -- upvalues: GuiController (copy), TradeBoothSkinSelector (copy)
    GuiController:Open(TradeBoothSkinSelector);
end;

task.spawn(u4.Start, u4);

return u4;