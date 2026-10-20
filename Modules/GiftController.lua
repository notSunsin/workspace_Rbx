-- Decompiled with Potassium's decompiler.

local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local GiftPlayerList = LocalPlayer.PlayerGui:WaitForChild("GiftPlayerList");
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local GiftData = require(ReplicatedStorage.Data.GiftData);
local GameEvents = ReplicatedStorage.GameEvents;
local GetPlayersWithSeasonPass = GameEvents.SeasonPass.GetPlayersWithSeasonPass;
local GetPlayersOwningBeachBundle = GameEvents.Gift.GetPlayersOwningBeachBundle;
local GetPlayersOwningGoldenShovelPack = GameEvents.Gift.GetPlayersOwningGoldenShovelPack;
local u1 = {
    CurrentProduct = nil
};

function u1.PromptGift(p2: table, p3: string) -- Line: 23
    -- upvalues: GiftData (copy), u1 (copy), GetPlayersWithSeasonPass (copy), GetPlayersOwningBeachBundle (copy), GetPlayersOwningGoldenShovelPack (copy), GiftPlayerList (copy), GuiController (copy)
    local v4 = GiftData[p3];

    if not v4 then
        warn((`Gift not found for "{p3}"`));

        return;
    end;

    u1.CurrentProduct = v4.NormalId;
    local v5 = GetPlayersWithSeasonPass:InvokeServer();
    local v6 = p3 ~= "Beach Bundle" and {} or GetPlayersOwningBeachBundle:InvokeServer();
    local v7 = p3 ~= "Golden Shovel Pack" and {} or GetPlayersOwningGoldenShovelPack:InvokeServer();
    local v8 = 0;
    local v9 = 0;

    for _, child in GiftPlayerList.Frame.ScrollingFrame:GetChildren() do
        if child:IsA("Frame") then
            child.Visible = true;

            if p3 == "Season Pass" and v5[child.Name] then
                child.Visible = false;
                v9 = v9 + 1;
            elseif p3 == "Beach Bundle" and v6[child.Name] then
                child.Visible = false;
            elseif p3 == "Golden Shovel Pack" and v7[child.Name] then
                child.Visible = false;
            else
                v8 = v8 + 1;
            end;
        end;
    end;

    GiftPlayerList.Frame.ScrollingFrame.NoPlayers.Visible = v8 == 0;
    GuiController:Open(GiftPlayerList);
end;

function u1.PromptGiftFromGiftId(p10: table, p11: number) -- Line: 77
    -- upvalues: GiftData (copy), u1 (copy)
    local v12 = nil;

    for i, v in GiftData do
        if p11 == v.GiftId then
            v12 = i;
            break;
        end;
    end;

    if v12 then
        u1:PromptGift(v12);

        return;
    end;

    warn((`Gift not found for "{p11}"`));
end;

function u1.PromptGiftFromNormalId(p13: table, p14: number) -- Line: 94
    -- upvalues: GiftData (copy), u1 (copy)
    local v15 = nil;

    for i, v in GiftData do
        if p14 == v.NormalId then
            v15 = i;
            break;
        end;
    end;

    if v15 then
        u1:PromptGift(v15);

        return;
    end;

    warn((`Gift not found for "{p14}"`));
end;

function u1.Start(p16) -- Line: 111
    -- upvalues: GuiController (copy), GiftPlayerList (copy), MarketController (copy), u1 (copy), MarketplaceService (copy), LocalPlayer (copy), ReplicatedStorage (copy), Players (copy)
    GuiController:UsePopupAnims(GiftPlayerList);
    local u17 = false;
    local u18 = nil;
    GiftPlayerList.Frame.Close.Activated:Connect(function() -- Line: 117
        -- upvalues: GuiController (ref), GiftPlayerList (ref)
        GuiController:Close(GiftPlayerList);
    end);
    MarketController.PromptProductPurchaseInitiated:Connect(function(p19: any, p20: number) -- Line: 121
        -- upvalues: u1 (ref), u18 (ref), GiftPlayerList (ref)
        if p20 == u1.CurrentProduct then
            u18 = true;
            GiftPlayerList.Black.ZIndex = 1000;
        end;
    end);
    MarketplaceService.PromptProductPurchaseFinished:Connect(function() -- Line: 129
        -- upvalues: u18 (ref), GiftPlayerList (ref), GuiController (ref)
        if not u18 then
            return;
        end;

        u18 = false;
        GiftPlayerList.Black.ZIndex = -1;
        GuiController:Close(GiftPlayerList);
    end);

    local function createPlayer(u21: userdata) -- Line: 140
        -- upvalues: LocalPlayer (ref), GiftPlayerList (ref), u1 (ref), u17 (ref), u18 (ref), GuiController (ref), ReplicatedStorage (ref), Players (ref)
        if u21 == LocalPlayer then
            return;
        end;

        local v22 = GiftPlayerList.Frame.ScrollingFrame.UIListLayout.Template:Clone();
        v22.Name = tostring(u21.UserId);
        v22.Button.Headshot.Image = `rbxthumb://type=AvatarHeadShot&id={u21.UserId}&w=180&h=180`;
        v22.Button.Username.Text = `@{u21.Name}`;
        v22.Parent = GiftPlayerList.Frame.ScrollingFrame;
        v22.Button.Activated:Connect(function() -- Line: 151
            -- upvalues: u1 (ref), u17 (ref), u18 (ref), GuiController (ref), GiftPlayerList (ref), ReplicatedStorage (ref), u21 (copy)
            if not u1.CurrentProduct then
                return;
            end;

            if u17 or u18 then
                return;
            end;

            GuiController:Close(GiftPlayerList);
            u17 = true;
            ReplicatedStorage.GameEvents.Gift.SendGiftTo:FireServer({
                productId = u1.CurrentProduct,
                targetUserId = u21.UserId
            });
            task.wait(3);
            u17 = false;
        end);
        GiftPlayerList.Frame.ScrollingFrame.NoPlayers.Visible = #Players:GetPlayers() <= 1;
    end;

    Players.PlayerAdded:Connect(createPlayer);

    for _, v in Players:GetPlayers() do
        task.spawn(createPlayer, v);
    end;

    GiftPlayerList.Frame.ScrollingFrame.NoPlayers.Visible = #Players:GetPlayers() <= 1;
    Players.PlayerRemoving:Connect(function(p23: userdata) -- Line: 184
        -- upvalues: GiftPlayerList (ref), Players (ref)
        local v24 = GiftPlayerList.Frame.ScrollingFrame:FindFirstChild((tostring(p23.UserId)));

        if v24 then
            v24:Destroy();
        end;

        GiftPlayerList.Frame.ScrollingFrame.NoPlayers.Visible = #Players:GetPlayers() <= 1;
    end);
end;

task.spawn(u1.Start, u1);

return u1;