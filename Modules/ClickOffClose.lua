-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local PlayerGui = Players.LocalPlayer.PlayerGui;
local u1 = {};
local IsMouseOverUI = require(ReplicatedStorage.Modules.IsMouseOverUI);
local v2 = {};
local u3 = {
    CosmeticUI = true,
    Trading = true,
    TradingUI = true,
    TokensInfo = true,
    BuyTokens = true,
    TradingPin = true,
    TradeNotifs = true,
    BuyCarrotsUI = true
};
local u4 = {
    InsertionPoint = true,
    USER_IMAGE = true
};

local function u7(p5) -- Line: 30
    -- upvalues: IsMouseOverUI (copy), u3 (copy), u4 (copy)
    for _, v in IsMouseOverUI.GetGuiObjectsAtPosition(p5.X, p5.Y) do
        local v6 = v:FindFirstAncestorOfClass("ScreenGui");

        if (v.BackgroundTransparency ~= 1 and v.Visible or (u3[v.Name] or (u3[v.Parent.Name] or u3[v6]))) and not (u4[v.Name] and u4[v6]) then
            return true;
        end;
    end;

    return false;
end;

function v2.AddGui(p8: userdata) -- Line: 45
    -- upvalues: u1 (ref)
    if not table.find(u1, p8) then
        table.insert(u1, p8);
    end;
end;

function v2.RemoveGui(p9: userdata) -- Line: 51
    -- upvalues: u1 (ref)
    local table_find_ret = table.find(u1, p9);

    if not table_find_ret then
        return;
    end;

    if #u1 > 1 then
        if table.find(u1, p9) == 1 then
            u1 = {};
        end;

        return;
    end;

    table.remove(u1, table_find_ret);
end;

UserInputService.InputBegan:Connect(function(p10: userdata, p11: boolean) -- Line: 68
    -- upvalues: u1 (ref), ReplicatedStorage (copy), PlayerGui (copy), u7 (copy)
    if p11 then
        return;
    end;

    if p10.UserInputType == Enum.UserInputType.MouseButton1 or p10.UserInputType == Enum.UserInputType.Touch then
        if #u1 == 0 then
            return;
        end;

        local GuiController = require(ReplicatedStorage.Modules.GuiController);
        local BeeSkillTreeUI = PlayerGui:FindFirstChild("BeeSkillTreeUI");

        if BeeSkillTreeUI and GuiController:GetStateForGui(BeeSkillTreeUI).Visible:Get() then
            return;
        end;

        if not u7(p10.Position) then
            local v12 = #u1;
            local table_remove_ret = table.remove(u1, #u1);

            if not table_remove_ret then
                return;
            end;

            if v12 > 1 then
                local v13 = u1[#u1];
                GuiController:Close(table_remove_ret);
                GuiController:Open(v13);

                return;
            end;

            if v12 == 1 then
                GuiController:Close(table_remove_ret);
            end;
        end;
    end;
end);

return v2;