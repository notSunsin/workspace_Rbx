-- Decompiled with Potassium's decompiler.

local u1 = {};
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local SharedCycleHandlerData = require(ReplicatedStorage.Data.SharedCycleHandlerData);
local AdminMachineConfigData = require(ReplicatedStorage.Data.AdminMachineConfigData);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local WeatherData = require(ReplicatedStorage.Data.WeatherData);
local GameEvents = ReplicatedStorage.GameEvents;
local AdminMachineUpdateBoost = GameEvents.AdminMachineUpdateBoost;
local AdminMachineUpdateUI = GameEvents.AdminMachineUpdateUI;
local AdminMachine = SharedCycleHandlerData.AdminMachine;
local u2 = script.AdminBoard or game.CollectionService:GetTagged("AdminBoard")[1];
local LocalPlayer = Players.LocalPlayer;
local MIN_BOOST_AMOUNT = AdminMachineConfigData.MIN_BOOST_AMOUNT;
local u3 = 0;
local Main = game.CollectionService:GetTagged("AdminBoardGui")[1]:WaitForChild("Container", 30):WaitForChild("Main", 30);
local Content = Main:WaitForChild("Content", 30);
local Header = Main:WaitForChild("Header", 30);
local EventFrame = Content:WaitForChild("EventFrame", 30);
local Icon = EventFrame:WaitForChild("Icon", 30):WaitForChild("Icon", 30);
local Name = EventFrame:WaitForChild("Name", 30):WaitForChild("Name", 30);
local Shadow = EventFrame:WaitForChild("Icon", 30):WaitForChild("Shadow", 30);
local Shadow2 = EventFrame:WaitForChild("Name", 30):WaitForChild("Shadow", 30);
local ItemFrame = Content:WaitForChild("ItemFrame", 30);
local Icon2 = ItemFrame:WaitForChild("Icon", 30):WaitForChild("Icon", 30);
local Name2 = ItemFrame:WaitForChild("Name", 30):WaitForChild("Name", 30);
local Shadow3 = ItemFrame:WaitForChild("Icon", 30):WaitForChild("Shadow", 30);
local Shadow4 = ItemFrame:WaitForChild("Name", 30):WaitForChild("Shadow", 30);
local LuckBoost = Header:WaitForChild("LuckBoost", 30);
local Shadow5 = LuckBoost:WaitForChild("Shadow", 30);
local Label = LuckBoost:WaitForChild("Label", 30);

local function GetWeatherIconFromBottomUI(p4: string) -- Line: 61
    local v5 = game.StarterGui.Bottom_UI.BottomFrame.Holder.List:FindFirstChild(p4);

    if not v5 then
        return "rbxassetid://6937742258", Color3.fromRGB(255, 255, 255);
    end;

    local Icon3 = v5:FindFirstChild("Icon");

    if Icon3 then
        return Icon3.Image, Icon3.ImageColor3;
    end;

    return "rbxassetid://6937742258", Color3.fromRGB(255, 255, 255);
end;

function u1.HasBeenAssignedABTest(p6: table, p7: userdata) -- Line: 73
    return p7:GetAttribute("AB_AdminMachine") == true;
end;

function u1.UpdateUI(p8: table, p9: any, p10: string, p11: string) -- Line: 77
    -- upvalues: WeatherData (copy), GetWeatherIconFromBottomUI (copy), Icon (copy), Shadow (copy), Name (copy), Shadow2 (copy), Icon2 (copy), ItemImageFinder (copy), Shadow3 (copy), Name2 (copy), Shadow4 (copy)
    local v12 = WeatherData[p9];

    if not v12 then
        v12 = WeatherData.Placeholder or {
            Icon = "rbxassetid://6937742258",
            IconColor = Color3.fromRGB(255, 255, 255)
        };
        local v13, v14 = GetWeatherIconFromBottomUI(p9);

        if v12 then
            v12.Icon = v13;
            v12.IconColor = v14;
        end;
    end;

    Icon.Image = v12.Icon;
    Icon.ImageColor3 = v12.IconColor or Color3.fromRGB(255, 255, 255);
    Shadow.Image = v12.Icon;
    Shadow.ImageColor3 = v12.IconColor or Color3.fromRGB(255, 255, 255);
    Name.Text = p9;
    Shadow2.Text = p9;
    Icon2.Image = ItemImageFinder(p10, p11) or "";
    Shadow3.Image = ItemImageFinder(p10, p11) or "";
    local v15;

    if p11 == "Holdable" or not p10 then
        v15 = `{p10} Seed`;
    else
        v15 = p10;
    end;

    Name2.Text = v15;

    if p11 == "Holdable" or not p10 then
        p10 = `{p10} Seed`;
    end;

    Shadow4.Text = p10;
end;

function u1.IsBoostAtMax(p16) -- Line: 110
    -- upvalues: MIN_BOOST_AMOUNT (ref), AdminMachineConfigData (copy)
    return MIN_BOOST_AMOUNT >= AdminMachineConfigData.MAX_BOOST_AMOUNT;
end;

function u1.GetMaxBoostAmount(p17) -- Line: 114
    -- upvalues: AdminMachineConfigData (copy)
    return AdminMachineConfigData.MAX_BOOST_AMOUNT;
end;

function u1.GetNextBoostCost(p18) -- Line: 118
    -- upvalues: AdminMachineConfigData (copy), u3 (ref)
    local math_pow_ret = math.pow(AdminMachineConfigData.COST_RATE_OF_INCREASE, u3);

    return math.ceil(math_pow_ret);
end;

function u1.GetNextBoostAmount(p19) -- Line: 122
    -- upvalues: NumberUtil (copy), MIN_BOOST_AMOUNT (ref), AdminMachineConfigData (copy)
    return NumberUtil.RoundToDP(MIN_BOOST_AMOUNT + AdminMachineConfigData.BOOST_RATE_OF_INCREASE, 2);
end;

local function ShouldBeDisabled() -- Line: 126
    return false;
end;

function u1.Initialise(p20) -- Line: 130
    -- upvalues: AdminMachine (copy), u2 (copy), Name (copy), u1 (copy)
    if false then
        return;
    end;

    if not AdminMachine:IsRunning() then
        AdminMachine:Start();
    end;

    u2.Parent = workspace;

    if Name.Text == "Item Name" then
        u1:UpdateUI("Placeholder", "Placeholder", "Placeholder");
    end;
end;

function u1.Remove(p21) -- Line: 144
    -- upvalues: u2 (copy)
    u2.Parent = script;
end;

local function Refresh() -- Line: 149
    -- upvalues: u1 (copy), LocalPlayer (copy)
    if u1:HasBeenAssignedABTest(LocalPlayer) then
        u1:Initialise();

        return;
    end;

    u1:Remove();
end;

if RunService:IsClient() then
    task.spawn(Refresh);
    LocalPlayer:GetAttributeChangedSignal("AB_AdminMachine"):Connect(function() -- Line: 163
        -- upvalues: Refresh (copy)
        task.spawn(Refresh);
    end);
end;

AdminMachineUpdateUI.OnClientEvent:Connect(function(u22: any, u23: string, p24: string) -- Line: 168
    -- upvalues: u1 (copy)
    local u25 = p24 == "Seed" and "Holdable" or p24;
    task.defer(function() -- Line: 174
        -- upvalues: u1 (ref), u22 (copy), u23 (copy), u25 (ref)
        u1:UpdateUI(u22, u23, u25);
    end);
end);
AdminMachineUpdateBoost.OnClientEvent:Connect(function(p26: number, p27: number, p28: number) -- Line: 179
    -- upvalues: MIN_BOOST_AMOUNT (ref), u3 (ref), Label (copy), Shadow5 (copy), ConfirmationPromptController (copy), NumberUtil (copy), u1 (copy)
    MIN_BOOST_AMOUNT = p26;
    u3 = p28;
    Label.Text = `🍀 Luck Boost: {MIN_BOOST_AMOUNT}x 🍀`;
    Shadow5.Text = `🍀 Luck Boost: {MIN_BOOST_AMOUNT}x 🍀`;
    ConfirmationPromptController:UpdateText({
        Title = "Admin Board Booster",
        Header = "Are you sure you want to boost the Admin Board?",
        Middle = `This will cost {NumberUtil.FormatCompactPrice(u1:GetNextBoostCost())}¢!`,
        Footer = `This will increase the Luck Boost to {u1:GetNextBoostAmount()}x! (Chance & Cost resets every event)`
    }, "Admin Board Booster");
end);

return u1;