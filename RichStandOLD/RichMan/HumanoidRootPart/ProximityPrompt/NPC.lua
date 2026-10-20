-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.Chalk);
ReplicatedStorage:WaitForChild("GameEvents");
local script_Parent = script.Parent;
local Parent = script_Parent.Parent.Parent;
local LocalPlayer = game.Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
require(ReplicatedStorage.Modules.EventShopUIController);
require(ReplicatedStorage.Modules.MutationHandler);
require(ReplicatedStorage.Modules.InventoryService);
local Top_Text = require(game.ReplicatedStorage.Top_Text);
local NPC_MOD = require(game.ReplicatedStorage.NPC_MOD);
local u1 = false;
local u2 = false;
local u3 = nil;
local Head = Parent.Head;
local u4 = nil;
local GiveAlienatedPets = ReplicatedStorage.GameEvents.AlienEvent.GiveAlienatedPets;

local function waitForDuration(p5) -- Line: 40
    -- upvalues: u2 (ref)
    local v6 = time();

    while time() - v6 < p5 do
        task.wait();

        if u2 then
            return false;
        end;
    end;

    return true;
end;

local function GetAlienatedInfo() -- Line: 52
    -- upvalues: LocalPlayer (copy), DataService (copy)
    if not LocalPlayer.Character then
        return 0;
    end;

    local Data = DataService:GetData();
    local v7 = 0;

    local function HasPets() -- Line: 63
        -- upvalues: Data (copy)
        return next(Data.PetsData.PetInventory.Data) ~= nil;
    end;

    if next(Data.PetsData.PetInventory.Data) == nil then
        return 0;
    end;

    for i, v in pairs(Data.PetsData.PetInventory.Data) do
        if not table.find(Data.PetsData.EquippedPets, i) and (v and v.PetData) then
            local v8 = v.PetData.MutationType or nil;

            if v8 and v8 == "Z" then
                v7 = v7 + 1;
            end;
        end;
    end;

    return v7;
end;

local u9 = { "How can I help you?", "How do I get Alienated Pets?", "Submit All!", "Nevermind" };
local u11 = {
    [u9[1]] = function() -- Line: 112
        -- upvalues: Top_Text (copy), Parent (copy), waitForDuration (copy)
        task.wait(0.5);
        Top_Text.NpcText(Parent, "Give me any Alienated pets!", true);
        waitForDuration(2);
    end,

    [u9[2]] = function() -- Line: 120
        -- upvalues: Top_Text (copy), Parent (copy), waitForDuration (copy)
        task.wait(0.5);
        Top_Text.NpcText(Parent, "The alien\'s chaos weather happens every 60 minutes!", true);
        waitForDuration(2);
        Top_Text.NpcText(Parent, "Pets with no mutations will have a chance to get the alienated mutation!", true);
        waitForDuration(2);
        Top_Text.NpcText(Parent, "Collect them during the weather!", true);
        waitForDuration(1);
    end,

    [u9[3]] = function() -- Line: 136
        -- upvalues: GetAlienatedInfo (copy), Top_Text (copy), Parent (copy), waitForDuration (copy), GiveAlienatedPets (copy)
        task.wait(0.5);
        local v10 = GetAlienatedInfo();

        if v10 <= 0 then
            Top_Text.NpcText(Parent, "No alienated mutation pets found!", true);
            waitForDuration(2);

            return;
        end;

        if v10 < 10 then
            Top_Text.NpcText(Parent, `You need {10 - v10} more alienated mutated pets!`, true);
            waitForDuration(2);

            return;
        end;

        if GiveAlienatedPets:InvokeServer() then
            Top_Text.NpcText(Parent, "Here\'s a UFO Shard!", true);
            waitForDuration(2);

            return;
        end;

        Top_Text.NpcText(Parent, "Try again!", true);
        waitForDuration(2);
    end,

    [u9[4]] = function() -- Line: 173
        -- upvalues: u2 (ref)
        u2 = true;
    end
};

function EndConversation()
    -- upvalues: u1 (ref), u4 (ref), Top_Text (copy), Parent (copy), LocalPlayer (copy), NPC_MOD (copy), u2 (ref), u3 (ref), script_Parent (copy)
    if not u1 then
        return;
    end;

    if u4 then
        task.cancel(u4);
    end;

    Top_Text.TakeAwayResponses(Parent, LocalPlayer);
    Top_Text.RemovePlayerSideFrame(LocalPlayer);
    NPC_MOD.End_Speak(LocalPlayer);
    u2 = false;
    u1 = false;
    u3 = nil;
    task.wait(0.5);
    script_Parent.Enabled = true;
end;

local function StartConversation() -- Line: 198
    -- upvalues: u1 (ref), u3 (ref), LocalPlayer (copy), NPC_MOD (copy), u2 (ref), script_Parent (copy), Top_Text (copy), Parent (copy), u9 (copy), u11 (copy), u4 (ref)
    if u1 then
        return;
    end;

    u1 = true;
    u3 = LocalPlayer;
    NPC_MOD.Start_Speak(LocalPlayer);
    u2 = false;
    script_Parent.Enabled = false;
    Top_Text.NpcText(Parent, "ALIENS!", true);
    local u12 = {};
    local u13 = "";
    local u14 = "";

    for _, v in Top_Text.ShowChoices(LocalPlayer, u9) do
        local Frame = v:FindFirstChild("Frame");

        if Frame then
            local ImageButton = Frame:FindFirstChild("ImageButton");

            if ImageButton then
                table.insert(u12, ImageButton.MouseButton1Click:Connect(function() -- Line: 223
                    -- upvalues: u13 (ref), Frame (copy), u14 (ref)
                    u13 = Frame.Frame.Text_Element:GetAttribute("Text");
                    u14 = u13;
                end));
                u14 = u13;
            end;
        end;
    end;

    local function FlushConnections() -- Line: 232
        -- upvalues: u12 (copy)
        for _, v in u12 do
            v:Disconnect();
        end;

        table.clear(u12);
    end;

    while u14 == "" do
        task.wait();

        if u2 then
            for _, v in u12 do
                v:Disconnect();
            end;

            table.clear(u12);

            return EndConversation();
        end;
    end;

    for _, v in u12 do
        v:Disconnect();
    end;

    table.clear(u12);

    if u2 then
        return EndConversation();
    end;

    Top_Text.RemovePlayerSideFrame(LocalPlayer);

    if LocalPlayer.Character then
        Top_Text.PlayerResponse(LocalPlayer.Character, u13, true);
        local v15 = u11[u13];

        if not v15 then
            return EndConversation();
        end;

        u4 = task.spawn(v15);

        repeat
            task.wait();
        until coroutine.status(u4) == "dead";

        if not u1 then
            return;
        end;
    end;

    EndConversation();
end;

script_Parent.Triggered:Connect(function() -- Line: 267
    -- upvalues: StartConversation (copy)
    StartConversation();
end);
task.spawn(function() -- Line: 274
    -- upvalues: Head (copy), u3 (ref), u1 (ref)
    while true do
        repeat
            task.wait(0.1);
        until u3 and (u3.Character and (u3.Character.PrimaryPart and ((u3.Character.PrimaryPart.Position - Head.Position).Magnitude > 17 and u1)));

        EndConversation();
    end;
end);
script.Parent.PromptShown:Connect(function() -- Line: 289
    -- upvalues: Parent (copy), TweenService (copy), TweenInfo_new_ret (copy)
    HL = Instance.new("Highlight", Parent);
    HL.DepthMode = Enum.HighlightDepthMode.Occluded;
    HL.FillTransparency = 1;
    HL.OutlineTransparency = 1;
    HL.Adornee = Parent;
    TweenService:Create(HL, TweenInfo_new_ret, {
        OutlineTransparency = 0
    }):Play();
end);
script.Parent.PromptHidden:Connect(function() -- Line: 300
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), Debris (copy)
    if HL then
        TweenService:Create(HL, TweenInfo_new_ret, {
            OutlineTransparency = 1
        }):Play();
        Debris:AddItem(HL, TweenInfo_new_ret.Time);
    end;
end);