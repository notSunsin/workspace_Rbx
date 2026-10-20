-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local IsMouseOverUI = require(ReplicatedStorage.Modules.IsMouseOverUI);
local PityHover_UI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PityHover_UI");
local u1 = {};
local u2 = {};

function u2.AddGuiObject(p3: table, u4: userdata, p5: number, p6: string) -- Line: 19
    -- upvalues: u1 (copy), u2 (copy), PityHover_UI (copy)
    local u7 = {
        pity = p5,
        display = p6,
        layerCollectorAncestor = u4:FindFirstAncestorWhichIsA("LayerCollector")
    };
    u1[u4] = u7;

    if not u7.layerCollectorAncestor then
        u4.AncestryChanged:Once(function() -- Line: 29
            -- upvalues: u7 (copy), u4 (copy), u2 (ref)
            u7.layerCollectorAncestor = u4:FindFirstAncestorWhichIsA("LayerCollector");

            if not u7.layerCollectorAncestor then
                u2:RemoveGuiObject(u4);
            end;
        end);
    end;

    PityHover_UI.Enabled = next(u1) ~= nil;
end;

function u2.RemoveGuiObject(p8: table, p9: userdata) -- Line: 40
    -- upvalues: u1 (copy), PityHover_UI (copy)
    u1[p9] = nil;
    PityHover_UI.Enabled = next(u1) ~= nil;
end;

function u2.Start(p10) -- Line: 45
    -- upvalues: PityHover_UI (copy), RunService (copy), u1 (copy), UserInputService (copy), GuiService (copy), IsMouseOverUI (copy)
    local u11 = script.Hover:Clone();
    u11.Visible = false;
    u11.Parent = PityHover_UI;
    RunService.PreRender:Connect(function(p12: number) -- Line: 50
        -- upvalues: PityHover_UI (ref), u1 (ref), UserInputService (ref), GuiService (ref), u11 (copy), IsMouseOverUI (ref)
        if not PityHover_UI.Enabled then
            return;
        end;

        local v13 = false;

        for _, v in u1 do
            if v.layerCollectorAncestor and v.layerCollectorAncestor.Enabled then
                v13 = true;
                break;
            end;
        end;

        if not v13 then
            return;
        end;

        local v14 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
        u11.Position = UDim2.fromOffset(v14.X + 16, v14.Y + 16);
        u11.Visible = false;

        for _, v in IsMouseOverUI.GetGuiObjectsAtPosition(v14.X, v14.Y) do
            local v15 = u1[v];

            if v15 then
                u11.Visible = true;
                u11.Pity.Text = `Guaranteed in {v15.pity} {v15.display}`;

                return;
            end;
        end;
    end);
end;

task.spawn(u2.Start, u2);

return u2;