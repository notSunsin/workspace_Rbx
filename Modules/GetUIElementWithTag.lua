-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local CollectionService = game:GetService("CollectionService");
local GuiService = game:GetService("GuiService");
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");

return function(p1) -- Line: 9, Name: GetUIElementWithTag
    -- upvalues: CollectionService (copy), UserInputService (copy), GuiService (copy), PlayerGui (copy)
    local Tagged = CollectionService:GetTagged(p1);
    local v2 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
    local GuiObjectsAtPosition = PlayerGui:GetGuiObjectsAtPosition(v2.X, v2.Y);

    for _, v in Tagged do
        if v:IsDescendantOf(PlayerGui) and table.find(GuiObjectsAtPosition, v) then
            return v;
        end;
    end;

    return nil;
end;