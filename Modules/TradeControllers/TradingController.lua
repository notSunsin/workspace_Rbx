-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReversedItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ReversedItemTypeEnums);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local ReplicationReciever = require(ReplicatedStorage.Modules.ReplicationReciever);
local Notification = require(ReplicatedStorage.Modules.Notification);
local TradeData = require(ReplicatedStorage.Data.TradeData);
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = nil;
local LocalPlayer = Players.LocalPlayer;
local TradeEvents = ReplicatedStorage.GameEvents.TradeEvents;
local u19 = {
    CurrentTradeId = nil,
    CurrentTradeReplicator = nil,
    OnTradeCreated = Signal.new(),
    OnTradeDestroyed = Signal.new(),

    AddItem = function(p2: table, p3: any, p4: string) -- Line: 27, Name: AddItem
        -- upvalues: TradeEvents (copy)
        TradeEvents.AddItem:FireServer(p3, p4);
    end,

    RemoveItem = function(p5: table, p6: any, p7: string) -- Line: 31, Name: RemoveItem
        -- upvalues: TradeEvents (copy)
        TradeEvents.RemoveItem:FireServer(p6, p7);
    end,

    Accept = function(p8) -- Line: 35, Name: Accept
        -- upvalues: TradeEvents (copy)
        TradeEvents.Accept:FireServer();
    end,

    Confirm = function(p9) -- Line: 39, Name: Confirm
        -- upvalues: TradeEvents (copy)
        TradeEvents.Confirm:FireServer();
    end,

    Decline = function(p10) -- Line: 43, Name: Decline
        -- upvalues: TradeEvents (copy)
        TradeEvents.Decline:FireServer();
    end,

    SetSheckles = function(p11, p12) -- Line: 47, Name: SetSheckles
        -- upvalues: TradeEvents (copy)
        TradeEvents.SetSheckles:FireServer(p12);
    end,

    SetTokens = function(p13, p14) -- Line: 51, Name: SetTokens
        -- upvalues: TradeEvents (copy)
        TradeEvents.SetTokens:FireServer(p14);
    end,

    FetchBoothHistory = function(p15) -- Line: 55, Name: FetchBoothHistory
        -- upvalues: TradeEvents (copy)
        return TradeEvents.Booths.FetchHistory:InvokeServer();
    end,

    FetchTradeHistory = function(p16) -- Line: 59, Name: FetchTradeHistory
        -- upvalues: TradeEvents (copy)
        return TradeEvents.FetchHistory:InvokeServer();
    end,

    IsItemTypeValid = function(p17: table, p18: string) -- Line: 63, Name: IsItemTypeValid
        -- upvalues: TradeData (copy)
        return table.find(TradeData.ItemTypes, p18) ~= nil;
    end
};
local u20 = false;

function u19.RequestAddItem(p21) -- Line: 95
    -- upvalues: u19 (copy), u20 (ref), u1 (ref), LocalPlayer (copy)
    if not u19.CurrentTradeReplicator then
        return;
    end;

    if u20 and u1.IsOpened() then
        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if Character then
        Character:UnequipTools();
    end;

    u20 = true;
    u1.SetTrading(true);
    u1.OpenClose();
end;

local u22 = {};

function u19.IsItemInTrade(p23: table, p24: string, p25: string) -- Line: 116
    -- upvalues: u22 (ref)
    return u22[p24] and u22[p24][p25] ~= nil;
end;

function u19.IsItemInTradeFromTool(p26: table, p27: userdata) -- Line: 120
    -- upvalues: u19 (copy), InventoryServiceEnums (copy), ReversedItemTypeEnums (copy), u22 (ref)
    if not u19.CurrentTradeReplicator then
        return false;
    end;

    local Attribute = p27:GetAttribute(InventoryServiceEnums.ITEM_TYPE);

    if not Attribute then
        return false;
    end;

    local v28 = ReversedItemTypeEnums[Attribute];
    local Attribute2 = p27:GetAttribute(v28 == "Pet" and "PET_UUID" or InventoryServiceEnums.ITEM_UUID);

    if not (v28 and Attribute2) then
        return false;
    end;

    return u22[v28] and u22[v28][Attribute2] ~= nil;
end;

function u19.AddFromTool(p29: table, p30: userdata) -- Line: 143
    -- upvalues: u20 (ref), LocalPlayer (copy), InventoryServiceEnums (copy), Notification (copy), ReversedItemTypeEnums (copy), u19 (copy), u1 (ref)
    if not u20 then
        return false;
    end;

    if not p30:IsDescendantOf(LocalPlayer) then
        return false;
    end;

    local Attribute = p30:GetAttribute(InventoryServiceEnums.ITEM_TYPE);

    if not Attribute then
        Notification:CreateNotification("This item can\'t be added to the trade!");

        return false;
    end;

    local v31 = ReversedItemTypeEnums[Attribute];
    local Attribute2 = p30:GetAttribute(v31 == "Pet" and "PET_UUID" or InventoryServiceEnums.ITEM_UUID);

    if not (v31 and Attribute2) then
        Notification:CreateNotification("This item can\'t be added to the trade!");

        return false;
    end;

    if p30:GetAttribute(InventoryServiceEnums.Favorite) or p30:GetAttribute("Favorite") then
        Notification:CreateNotification("You can\'t add favorited items!");

        return true;
    end;

    if not u19:IsItemTypeValid(v31) then
        Notification:CreateNotification("This item can\'t be added to the trade!");

        return false;
    end;

    u19:AddItem(v31, Attribute2);

    if u1.IsOpened() then
        u20 = false;
        u1.OpenClose();
    end;

    return true;
end;

function u19.Start(p32) -- Line: 184
    -- upvalues: u1 (ref), ReplicatedStorage (copy), u20 (ref), u19 (copy), LocalPlayer (copy), u22 (ref), TradeEvents (copy), ReplicationReciever (copy)
    u1 = require(ReplicatedStorage.Modules.Backpack);
    u1.StateChanged.Event:Connect(function(p33) -- Line: 187
        -- upvalues: u20 (ref)
        if p33 == false then
            u20 = false;
        end;
    end);
    u19.OnTradeCreated:Connect(function() -- Line: 193
        -- upvalues: u19 (ref), LocalPlayer (ref), u22 (ref), u1 (ref)
        local CurrentTradeReplicator = u19.CurrentTradeReplicator;

        if not CurrentTradeReplicator then
            return;
        end;

        local DataAsync = CurrentTradeReplicator:GetDataAsync();

        if not DataAsync then
            return;
        end;

        local function updatePlayerItems() -- Line: 197
            -- upvalues: DataAsync (copy), LocalPlayer (ref), u22 (ref), u1 (ref)
            local v34 = {};
            local v35 = false;

            for _, v in DataAsync.offers[table.find(DataAsync.players, LocalPlayer)].items do
                if not v34[v.type] then
                    v34[v.type] = {};
                end;

                local v36 = u22[v.type] and u22[v.type][v.id] == true;
                v34[v.type][v.id] = true;

                if not v36 then
                    v35 = true;
                end;
            end;

            for i, v in u22 do
                if v34[i] then
                    local v37 = i;

                    for i2 in v do
                        if not v34[v37][i2] then
                            v35 = true;
                        end;
                    end;
                else
                    v35 = true;
                end;
            end;

            u22 = v34;

            if v35 and u1.UpdateFunction then
                task.spawn(u1.UpdateFunction);
            end;
        end;

        assert(CurrentTradeReplicator:GetPathSignal("offers/@")):Connect(updatePlayerItems);
        updatePlayerItems();
    end);
    u19.OnTradeDestroyed:Connect(function() -- Line: 243
        -- upvalues: u22 (ref), u1 (ref)
        u22 = {};
        u1.SetTrading(false);

        if u1.UpdateFunction then
            task.spawn(u1.UpdateFunction);
        end;
    end);
    TradeEvents.UpdateTradeState.OnClientEvent:Connect(function(p38: string?) -- Line: 252
        -- upvalues: u19 (ref), ReplicationReciever (ref)
        local CurrentTradeId = u19.CurrentTradeId;

        if CurrentTradeId == p38 then
            return;
        end;

        if CurrentTradeId then
            if u19.CurrentTradeReplicator then
                u19.CurrentTradeReplicator:Destroy();
                u19.CurrentTradeReplicator = nil;
            end;

            u19.OnTradeDestroyed:Fire(CurrentTradeId);
        end;

        u19.CurrentTradeId = p38;

        if p38 then
            u19.CurrentTradeReplicator = ReplicationReciever.new(p38);
            u19.OnTradeCreated:Fire(p38, u19.CurrentTradeReplicator);
        end;
    end);
end;

task.spawn(u19.Start, u19);

return u19;