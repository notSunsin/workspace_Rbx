-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local Trove = require(ReplicatedStorage.Modules.Trove);
local TextOdds_UI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("TextOdds_UI");
local ScrollingFrame = TextOdds_UI.Frame.Main.Items.ScrollingFrame;
local UIListLayout = ScrollingFrame.UIListLayout;
local u1 = Trove.new();
local v2 = {};
local u3 = { "TemplateSmaller", "TemplateBigger", "TemplateRainbow" };

local function PickTemplate(p4: number) -- Line: 45
    -- upvalues: UIListLayout (copy)
    if p4 <= 5 then
        return UIListLayout:FindFirstChild("TemplateRainbow") or UIListLayout.TemplateSmaller;
    end;

    if p4 <= 15 then
        return UIListLayout:FindFirstChild("TemplateBigger") or UIListLayout.TemplateSmaller;
    end;

    return UIListLayout.TemplateSmaller;
end;

local function GetMutationItems() -- Line: 56
    -- upvalues: PetMutationRegistry (copy)
    local v5 = 0;
    local v6 = {};

    for i, v in PetMutationRegistry.PetMutationRegistry do
        local Chance = v.Chance;

        if Chance and (Chance ~= 0 and v.Level500Only ~= true) then
            v5 = v5 + Chance;
            table.insert(v6, {
                Name = i,
                Item = v,
                NormalizedOdd = Chance
            });
        end;
    end;

    if v5 > 0 then
        for _, v in v6 do
            v.NormalizedOdd = v.NormalizedOdd / v5 * 100;
        end;
    end;

    return v6;
end;

local function RenderOdds(p7: any, p8: table) -- Line: 74
    -- upvalues: ScrollingFrame (copy), u3 (copy), UIListLayout (copy)
    for _, child in ScrollingFrame:GetChildren() do
        if child:IsA("GuiObject") then
            child:Destroy();
        end;
    end;

    for _, v in u3 do
        local v9 = UIListLayout:FindFirstChild(v);

        if v9 then
            v9.Visible = false;
        end;
    end;

    local v10 = 0;

    for _, v in p8 do
        v10 = v10 + 1;
        local NormalizedOdd = v.NormalizedOdd;
        local v11;

        if NormalizedOdd <= 5 then
            v11 = UIListLayout:FindFirstChild("TemplateRainbow") or UIListLayout.TemplateSmaller;
        elseif NormalizedOdd <= 15 then
            v11 = UIListLayout:FindFirstChild("TemplateBigger") or UIListLayout.TemplateSmaller;
        else
            v11 = UIListLayout.TemplateSmaller;
        end;

        local v12 = p7:Clone(v11);
        v12.Name = v.Name;
        v12.LayoutOrder = v10;
        v12.Visible = true;
        local v13 = math.floor(v.NormalizedOdd * 100 + 0.5) / 100;
        local Title = v12:FindFirstChild("Title");

        if Title and Title:IsA("TextLabel") then
            Title.Text = v.Name;
            Title.TextColor3 = v.Item and v.Item.Color or Title.TextColor3;
        end;

        local Odds = v12:FindFirstChild("Odds");

        if Odds and Odds:IsA("TextLabel") then
            Odds.Text = `{v13}%`;
        end;

        local Pity = v12:FindFirstChild("Pity");

        if Pity and Pity:IsA("GuiObject") then
            Pity.Visible = false;
        end;

        v12.Parent = ScrollingFrame;
    end;

    task.defer(function() -- Line: 118
        -- upvalues: ScrollingFrame (ref), UIListLayout (ref)
        ScrollingFrame.CanvasPosition = Vector2.zero;
        ScrollingFrame.CanvasSize = UDim2.fromOffset(0, UIListLayout.AbsoluteContentSize.Y);
    end);
end;

function v2.Open(p14: table, p15: table?, u16: userdata?) -- Line: 124
    -- upvalues: GuiController (copy), TextOdds_UI (copy), u1 (ref), Trove (copy), GetMutationItems (copy), RenderOdds (copy)
    GuiController:Close(TextOdds_UI);
    u1:Clean();
    local u17 = Trove.new();
    u1 = u17;
    local v18 = p15 or GetMutationItems();
    table.sort(v18, function(p19, p20) -- Line: 132
        return p19.NormalizedOdd > p20.NormalizedOdd;
    end);
    RenderOdds(u17, v18);
    GuiController:Open(TextOdds_UI);
    local ExitButton = TextOdds_UI.Frame:FindFirstChild("ExitButton");

    if ExitButton and ExitButton:IsA("GuiButton") then
        u17:Add(ExitButton.Activated:Connect(function() -- Line: 141
            -- upvalues: GuiController (ref), TextOdds_UI (ref), u16 (copy), u17 (copy)
            GuiController:Close(TextOdds_UI);

            if u16 then
                GuiController:Open(u16);
            end;

            u17:Clean();
        end));
    end;
end;

function v2.Start(p21) -- Line: 151
    -- upvalues: GuiController (copy), TextOdds_UI (copy)
    GuiController:UsePopupAnims(TextOdds_UI);
end;

task.spawn(v2.Start, v2);

return v2;