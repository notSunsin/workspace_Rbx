-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GameEvents = ReplicatedStorage.GameEvents;
local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local Debris = game:GetService("Debris");
local CalculatePetValue = require(ReplicatedStorage.Modules.CalculatePetValue);
local PetEquipSlotsUIController = require(ReplicatedStorage.Modules.PetEquipSlotsUIController);
require(ReplicatedStorage.Modules.DataService);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local SellPet_RE = GameEvents.SellPet_RE;
local Parent = script.Parent.Parent.Parent;
local LocalPlayer = game.Players.LocalPlayer;
local Top_Text = require(game.ReplicatedStorage.Top_Text);
local NPC_MOD = require(game.ReplicatedStorage.NPC_MOD);
require(game.ReplicatedStorage.Item_Module);
require(game.ReplicatedStorage.Comma_Module);
local PetShop_UI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PetShop_UI");
local _ = require(game.ReplicatedStorage.Data.CurrencyData).Sheckles;
GameEvents:WaitForChild("ShecklesClient");
local u1 = nil;
local u2 = false;
local u3 = true;
local u4 = false;
local u5 = nil;
local u6 = {
    ActualTotal = 0,
    NewTotal = 0,
    PetTools = nil
};

local function waitForDuration(p7) -- Line: 57
    -- upvalues: u4 (ref)
    local v8 = time();

    while time() - v8 < p7 do
        task.wait();

        if u4 then
            return false;
        end;
    end;

    return true;
end;

local function cancelYes() -- Line: 69
    -- upvalues: u4 (ref), u3 (ref), Top_Text (copy), Parent (copy), LocalPlayer (copy), u1 (ref), TweenService (copy), TweenInfo_new_ret (copy), Debris (copy), NPC_MOD (copy), u5 (ref)
    u4 = true;
    u3 = true;
    Top_Text.TakeAwayResponses(Parent, LocalPlayer);

    if u1 then
        TweenService:Create(u1, TweenInfo_new_ret, {
            OutlineTransparency = 1
        }):Play();
        Debris:AddItem(u1, TweenInfo_new_ret.Time);
    end;

    NPC_MOD.End_Speak(LocalPlayer);
    u5 = nil;
    task.wait(0.7);
    script.Parent.Enabled = true;
end;

local function AttemptSellPet(p9: number, p10: number, p11: any) -- Line: 92
    -- upvalues: InventoryServiceEnums (copy), ItemTypeEnums (copy), Top_Text (copy), Parent (copy), waitForDuration (copy), NumberUtil (copy), SellPet_RE (copy)
    if not p11 or p11:GetAttribute(InventoryServiceEnums.ITEM_TYPE) ~= ItemTypeEnums.Pet then
        Top_Text.NpcText(Parent, "I don\'t see anything...", true);

        return false;
    end;

    if p11:GetAttribute(InventoryServiceEnums.Favorite) then
        Top_Text.NpcText(Parent, "I won\'t buy favorited pets.", true);
        waitForDuration(math.random(0.7, 0.8));

        return false;
    end;

    local v12 = "Here is <font color=\'#FFFF00\'>" .. NumberUtil.DisplaySheckles(p10) .. "</font>";
    Top_Text.NpcText(Parent, v12, true);
    SellPet_RE:FireServer(p11);
    waitForDuration(math.random(1, 2));

    return true;
end;

local function SetCurrentSellData(p13: number, p14: number, p15: any) -- Line: 116
    -- upvalues: u6 (ref)
    u6 = {
        ActualTotal = p13,
        NewTotal = p14,
        PetTools = p15
    };
end;

local function ClearCurrentSellData() -- Line: 127
    -- upvalues: u6 (ref)
    u6 = {
        ActualTotal = 0,
        NewTotal = 0,
        PetTools = nil
    };
end;

local function EndOfInteractionCleanUp() -- Line: 138
    -- upvalues: u2 (ref), waitForDuration (copy), cancelYes (copy), Top_Text (copy), Parent (copy), LocalPlayer (copy), u3 (ref), NPC_MOD (copy)
    u2 = false;

    if not waitForDuration(math.random(0.4, 0.5)) then
        return cancelYes();
    end;

    task.wait(0.5);
    Top_Text.TakeAwayResponses(Parent, LocalPlayer);
    waitForDuration(0.5);
    u3 = true;
    script.Parent.Enabled = true;
    NPC_MOD.End_Speak(LocalPlayer);
end;

local function yes() -- Line: 153
    -- upvalues: u3 (ref), u2 (ref), u5 (ref), LocalPlayer (copy), NPC_MOD (copy), u1 (ref), TweenService (copy), TweenInfo_new_ret (copy), Debris (copy), u4 (ref), Top_Text (copy), Parent (copy), waitForDuration (copy), cancelYes (copy), CalculatePetValue (copy), AttemptSellPet (copy), GuiController (copy), PetShop_UI (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy), NumberUtil (copy), PetEquipSlotsUIController (copy), EndOfInteractionCleanUp (copy)
    if not u3 then
        return;
    end;

    u3 = false;
    u2 = true;
    u5 = LocalPlayer;
    NPC_MOD.Start_Speak(LocalPlayer);

    if u1 then
        TweenService:Create(u1, TweenInfo_new_ret, {
            OutlineTransparency = 1
        }):Play();
        Debris:AddItem(u1, TweenInfo_new_ret.Time);
    end;

    u4 = false;
    script.Parent.Enabled = false;
    Top_Text.NpcText(Parent, "I am the pets salesman!", false);

    if not waitForDuration(math.random(1, 1.5)) then
        return cancelYes();
    end;

    local v16 = Top_Text.ShowChoices(LocalPlayer, { "Show me the Egg Shop", "I want to sell my pet", "Show me pet info", "Nevermind" });

    if u4 then
        return cancelYes();
    end;

    local u17 = "";
    local u18 = "";
    local v19 = {};

    for _, v in pairs(v16) do
        local Frame = v:FindFirstChild("Frame");

        if Frame then
            local ImageButton = Frame:FindFirstChild("ImageButton");

            if ImageButton then
                local v20 = ImageButton.MouseButton1Click:Connect(function() -- Line: 198
                    -- upvalues: u17 (ref), Frame (copy), u18 (ref)
                    u17 = Frame.Frame.Text_Element:GetAttribute("Text");

                    if u17 == "Show me the Egg Shop" then
                        u18 = "Shop";

                        return;
                    end;

                    if u17 == "I want to sell my pet" then
                        u18 = "SellShop";

                        return;
                    end;

                    if u17 == "Show me pet info" then
                        u18 = "Show";

                        return;
                    end;

                    u18 = "Nevermind";
                end);
                table.insert(v19, v20);
            end;
        end;
    end;

    while u18 == "" do
        task.wait();

        if u4 then
            for _, v in pairs(v19) do
                v:Disconnect();
            end;

            return cancelYes();
        end;
    end;

    for _, v in pairs(v19) do
        v:Disconnect();
    end;

    if u4 then
        return cancelYes();
    end;

    Top_Text.RemovePlayerSideFrame(LocalPlayer);

    if not LocalPlayer.Character then
        return cancelYes();
    end;

    Top_Text.PlayerResponse(LocalPlayer.Character, u17, true);
    local v21 = string.len(u17) * 0.07;

    if not waitForDuration((math.sqrt(v21))) then
        return cancelYes();
    end;

    if u18 == "Sell This" then
        local v22 = LocalPlayer.Character:FindFirstChildWhichIsA("Tool");
        local v23 = CalculatePetValue(v22);
        AttemptSellPet(v23, v23, v22);
    elseif u18 == "Shop" then
        GuiController:Open(PetShop_UI);
    elseif u18 == "How" then
        local v24 = LocalPlayer.Character:FindFirstChildWhichIsA("Tool");

        if v24 and v24:GetAttribute(InventoryServiceEnums.ITEM_TYPE) == ItemTypeEnums.Pet then
            local v25 = CalculatePetValue(v24);
            local v26 = "I\'d value it at <font color=\'#FFFF00\'>" .. NumberUtil.DisplaySheckles(v25) .. "</font>";
            Top_Text.NpcText(Parent, v26, true);
            waitForDuration(math.random(1, 2));
        else
            Top_Text.NpcText(Parent, "I don\'t see anything...", true);
        end;
    elseif u18 == "Tell me" then
        Top_Text.NpcText(Parent, "Pets age as long as their hunger bar stays full.", true);
        waitForDuration(math.random(3, 5));
        Top_Text.NpcText(Parent, "A full pet\'s hunger bar drops over 12 hours.", true);
        waitForDuration(math.random(5, 6));
        Top_Text.NpcText(Parent, "Pets age offline and gain size as they grow.", true);
        waitForDuration(math.random(5, 6));
    elseif u18 == "Show" then
        PetEquipSlotsUIController:SetMode("EggInfo");
        GuiController:Open(LocalPlayer.PlayerGui.PetEquipSlots_UI);
    elseif u18 == "SellShop" then
        PetEquipSlotsUIController:SetMode("PetSell");
        GuiController:Open(LocalPlayer.PlayerGui.PetEquipSlots_UI);
    else
        Top_Text.NpcText(Parent, "Goodbye!", true);
    end;

    EndOfInteractionCleanUp();
end;

script.Parent.Triggered:Connect(function() -- Line: 301
    -- upvalues: NPC_MOD (copy), LocalPlayer (copy), yes (copy)
    if NPC_MOD.Can_Speak(LocalPlayer) then
        yes();
    end;
end);
local Click = game.SoundService.Click;
script.Parent.PromptButtonHoldBegan:Connect(function() -- Line: 309
    -- upvalues: Click (copy)
    Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    Click.Playing = true;
    Click.TimePosition = 0;
end);
local Position = script.Parent.Parent.Position;
task.spawn(function() -- Line: 317
    -- upvalues: u5 (ref), Position (copy), u3 (ref), u2 (ref), Top_Text (copy), LocalPlayer (copy), Parent (copy), NPC_MOD (copy), cancelYes (copy)
    while true do
        repeat
            task.wait(0.1);
        until u5 and (u5.Character and (u5.Character.PrimaryPart and ((u5.Character.PrimaryPart.Position - Position).Magnitude > 17 and (not u3 and u2))));

        Top_Text.RemovePlayerSideFrame(LocalPlayer);
        Top_Text.NpcText(Parent, "Goodbye!", true);
        NPC_MOD.End_Speak(LocalPlayer);
        cancelYes();
    end;
end);
script.Parent.PromptShown:Connect(function() -- Line: 334
    -- upvalues: u1 (ref), Parent (copy), TweenService (copy), TweenInfo_new_ret (copy)
    u1 = Instance.new("Highlight", Parent);
    u1.DepthMode = Enum.HighlightDepthMode.Occluded;
    u1.FillTransparency = 1;
    u1.OutlineTransparency = 1;
    u1.Adornee = Parent;
    TweenService:Create(u1, TweenInfo_new_ret, {
        OutlineTransparency = 0
    }):Play();
end);
script.Parent.PromptHidden:Connect(function() -- Line: 345
    -- upvalues: u1 (ref), TweenService (copy), TweenInfo_new_ret (copy), Debris (copy)
    if u1 then
        TweenService:Create(u1, TweenInfo_new_ret, {
            OutlineTransparency = 1
        }):Play();
        Debris:AddItem(u1, TweenInfo_new_ret.Time);
    end;
end);
task.spawn(function() -- Line: 406
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy)
    local RebirthUnlocksSharedService = require(ReplicatedStorage.Modules.RebirthUnlocksSharedService);

    if RebirthUnlocksSharedService:HasUnlockedFeature(LocalPlayer, "PET_STAND") then
        return;
    end;

    script.Parent.Enabled = false;
    local u27 = nil;
    u27 = RebirthUnlocksSharedService.OnRebirthUnlock:Connect(function(p28: userdata, p29: string) -- Line: 413
        -- upvalues: LocalPlayer (ref), u27 (ref)
        if p28 ~= LocalPlayer then
            return;
        end;

        if p29 ~= "PET_STAND" then
            return;
        end;

        if u27 then
            u27:Disconnect();
            u27 = nil;
        end;

        script.Parent.Enabled = true;
    end);
end);