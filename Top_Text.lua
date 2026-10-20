-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local v1 = {};
local Talk_UI = game.ReplicatedStorage.NPC_UIS.Talk_UI;
local Response_UI = game.ReplicatedStorage.NPC_UIS.Response_UI;
local Option_UI = game.ReplicatedStorage.NPC_UIS.Option_UI;
game:GetService("TweenService");
TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local Response_Text = game.SoundService.Response_Text;

local function stripRichTextTags(p2) -- Line: 21
    return p2:gsub("<.->", "");
end;

task.wait(1);

function effect(p3: userdata, p4: any, p5: any)
    -- upvalues: Response_Text (copy)
    local v6 = p3.Text:gsub("<.->", "");
    local string_len_ret = string.len(v6);
    string.len(v6);
    p3.MaxVisibleGraphemes = 0;
    local v7 = p5 and game.SoundService.NPC_SFX:FindFirstChild(p5) or game.SoundService.NPC_Text;

    if p4 == true then
        while string_len_ret >= 1 do
            task.wait();

            if v7.TimePosition > 0.07 or v7.Playing == false then
                v7.TimePosition = 0;
                v7.Playing = true;
                v7.PlaybackSpeed = 1 + math.random(-5, 5) / 100;
            end;

            string_len_ret = string_len_ret - 1;
            p3.MaxVisibleGraphemes = p3.MaxVisibleGraphemes + 1;
        end;
    else
        while string_len_ret >= 1 do
            task.wait();

            if Response_Text.Playing == false then
                Response_Text.Playing = true;
                Response_Text.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            end;

            string_len_ret = string_len_ret - 1;
            p3.MaxVisibleGraphemes = p3.MaxVisibleGraphemes + 1;
        end;
    end;
end;

function v1.NpcText(p8: any, p9: string, p10: any, p11: number?, p12: vector?) -- Line: 59
    -- upvalues: Talk_UI (copy)
    local v13 = p8.Head:FindFirstChild(Talk_UI.Name);

    if v13 ~= nil then
        if p10 == true then
            for _, descendant in pairs(v13:GetDescendants()) do
                if descendant:IsA("LocalScript") or descendant:IsA("Script") then
                    descendant:Destroy();
                end;
            end;
        end;

        v13.TextLabel.Text = p9;
        effect(v13.TextLabel, true, p8.Name);

        if p10 == true then
            for _, descendant in pairs(Talk_UI:GetDescendants()) do
                if descendant:IsA("LocalScript") or descendant:IsA("Script") then
                    local v14 = descendant;

                    for _, descendant2 in pairs(v13:GetDescendants()) do
                        if descendant2.Name == v14.Parent.Name then
                            local v15 = v14:Clone();
                            v15.Parent = descendant2;
                            v15.Enabled = true;
                        end;
                    end;
                end;
            end;
        end;

        return v13;
    end;

    local v16 = Talk_UI:Clone();
    v16.Parent = p8.Head;
    v16.TextLabel.Text = p9;

    if p11 then
        v16.Size = UDim2.fromScale(v16.Size.X.Scale * p11, v16.Size.Y.Scale * p11);
    end;

    if p12 then
        v16.StudsOffset = v16.StudsOffset + p12;
    end;

    effect(v16.TextLabel, true, p8.Name);

    if p10 == true then
        for _, descendant in pairs(v16:GetDescendants()) do
            if descendant:IsA("LocalScript") or descendant:IsA("Script") then
                descendant.Enabled = true;
            end;
        end;
    end;

    return v16;
end;

local u17 = {};

function v1.TakeAwayNPCText(p18) -- Line: 111
    -- upvalues: Talk_UI (copy)
    if p18 == nil then
        return;
    end;

    local v19 = p18.Head:FindFirstChild(Talk_UI.Name);

    if v19 then
        v19:Destroy();
    end;
end;

local TweenService = game:GetService("TweenService");

function v1.ShowChoices(p20, p21) -- Line: 121
    -- upvalues: u17 (copy), Option_UI (copy), UserInputService (copy), TweenService (copy)
    if u17[p20] then
        u17[p20].Cancelled = true;
    end;

    local v22 = {
        Cancelled = false
    };
    u17[p20] = v22;
    local v23 = 0;
    local v24 = {};

    for _, v in pairs(p21) do
        if v22.Cancelled then
            break;
        end;

        v23 = v23 + 1;
        local v25 = Option_UI:Clone();
        v25.Frame.Frame.Text_Element.Text = "[\"" .. v .. "\"]";
        v25.Frame.Frame.TextLabel.Text = "#" .. tostring(v23);

        if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
            local UIScale = Instance.new("UIScale");
            UIScale.Scale = 1.3;
            UIScale.Parent = v25;
        end;

        v25.Parent = p20.PlayerGui.Billboard_UI.Objects;
        local UIPadding = v25.Frame.Frame.Text_Element.UIPadding;
        local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        UIPadding.PaddingLeft = UDim.new(string.len(v) * 0.001 + 0.04, 0);
        local v26 = TweenService:Create(UIPadding, TweenInfo_new_ret, {
            PaddingLeft = UDim.new(0, 0)
        });
        v26:Play();
        game.Debris:AddItem(v26, TweenInfo_new_ret.Time);
        table.insert(v24, v25);
        v25.Frame.Frame.Text_Element:SetAttribute("Text", v);
        task.wait(0.075);
    end;

    if not v22.Cancelled and v24[1] then
        game:GetService("GamepadService"):EnableGamepadCursor(v24[1]);
    end;

    return v24;
end;

function v1.TakeAwayResponses(p27, p28) -- Line: 171
    -- upvalues: u17 (copy), TweenService (copy)
    if u17[p28] then
        u17[p28].Cancelled = true;
    end;

    for _, child in pairs(p28.PlayerGui.Billboard_UI.Objects:GetChildren()) do
        if child.Name ~= "UIListLayout" then
            child:Destroy();
        end;
    end;

    if p27 and p27:FindFirstChild("Head") then
        for _, child in pairs(p27.Head:GetChildren()) do
            if child:IsA("BillboardGui") and (child.Name == "Response_UI" or child.Name == "Talk_UI") then
                for _, child2 in pairs(child:GetChildren()) do
                    if child2:IsA("TextLabel") then
                        TweenService:Create(child2, TweenInfo.new(0.25), {
                            TextTransparency = 1
                        }):Play();
                    elseif child2:IsA("ImageLabel") then
                        TweenService:Create(child2, TweenInfo.new(0.25), {
                            ImageTransparency = 1
                        }):Play();
                    end;
                end;

                game.Debris:AddItem(child, 0.25);
            end;
        end;
    end;
end;

function v1.RemovePlayerSideFrame(p29) -- Line: 204
    -- upvalues: u17 (copy)
    if u17[p29] then
        u17[p29].Cancelled = true;
    end;

    for _, child in pairs(p29.PlayerGui.Billboard_UI.Objects:GetChildren()) do
        if child.Name ~= "UIListLayout" then
            child:Destroy();
        end;
    end;

    game:GetService("GamepadService"):DisableGamepadCursor();
end;

function v1.ShowResponse(p30, p31, p32) -- Line: 219
    -- upvalues: Talk_UI (copy)
    local v33 = p30.Head:FindFirstChild(Talk_UI.Name);

    if v33 ~= nil then
        if p32 == true then
            for _, descendant in pairs(v33:GetDescendants()) do
                if descendant:IsA("LocalScript") or descendant:IsA("Script") then
                    descendant:Destroy();
                end;
            end;
        end;

        v33.TextLabel.Text = p31;
        effect(v33.TextLabel, true);

        if p32 == true then
            for _, descendant in pairs(Talk_UI:GetDescendants()) do
                if descendant:IsA("LocalScript") or descendant:IsA("Script") then
                    local v34 = descendant;

                    for _, descendant2 in pairs(v33:GetDescendants()) do
                        if descendant2.Name == v34.Parent.Name then
                            v34.Enabled = false;
                            local v35 = v34:Clone();
                            v35.Parent = descendant2;
                            v35.Enabled = true;
                        end;
                    end;
                end;
            end;
        end;

        return v33;
    end;

    local v36 = Talk_UI:Clone();
    v36.Parent = p30.Head;
    v36.TextLabel.Text = p31;
    effect(v36.TextLabel, true);

    if p32 == true then
        for _, descendant in pairs(v36:GetDescendants()) do
            if descendant:IsA("LocalScript") or descendant:IsA("Script") then
                descendant.Enabled = true;
            end;
        end;
    end;

    return v36;
end;

function v1.PlayerResponse(p37, p38, p39) -- Line: 262
    -- upvalues: Talk_UI (copy), Response_UI (copy)
    if p38 ~= nil then
        local v40 = p37.Head:FindFirstChild(Talk_UI.Name);

        if v40 ~= nil then
            if p39 == true then
                for _, descendant in pairs(v40:GetDescendants()) do
                    if descendant:IsA("LocalScript") or descendant:IsA("Script") then
                        descendant:Destroy();
                    end;
                end;
            end;

            v40.TextLabel.Text = p38;
            effect(v40.TextLabel, false);

            if p39 == true then
                for _, descendant in pairs(Response_UI:GetDescendants()) do
                    if descendant:IsA("LocalScript") or descendant:IsA("Script") then
                        local v41 = descendant;

                        for _, descendant2 in pairs(v40:GetDescendants()) do
                            if descendant2.Name == v41.Parent.Name then
                                v41.Enabled = false;
                                local v42 = v41:Clone();
                                v42.Parent = descendant2;
                                v42.Enabled = true;
                            end;
                        end;
                    end;
                end;
            end;

            return v40;
        end;

        local v43 = Response_UI:Clone();
        v43.Parent = p37.Head;
        v43.TextLabel.Text = p38;
        effect(v43.TextLabel, false);

        if p39 == true then
            for _, descendant in pairs(v43:GetDescendants()) do
                if descendant:IsA("LocalScript") or descendant:IsA("Script") then
                    descendant.Enabled = true;
                end;
            end;
        end;

        return v43;
    end;
end;

return v1;