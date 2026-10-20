-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local CravingDisplayController = require(ReplicatedStorage.Modules.CravingControllers.CravingDisplayController);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local u2 = {};

local function WaitForCollection(p3: string) -- Line: 24
    -- upvalues: CollectionService (copy)
    local v4 = CollectionService:GetTagged(p3)[1];

    if not v4 then
        local v5 = 0;

        while not v4 and v5 <= 5 do
            v4 = CollectionService:GetTagged(p3)[1];
            v5 = v5 + task.wait(0.5);
        end;
    end;

    if not v4 then
        warn((`FallMarketBubbleController | Could not find {p3}`));
    end;

    return v4;
end;

function u2.Start(p6) -- Line: 39
    -- upvalues: WaitForCollection (copy), u1 (copy), GameConfigController (copy), CravingDisplayController (copy)
    local u7 = WaitForCollection("HarvestSpiritBillboard");

    if not u7 then
        return;
    end;

    local BG = u7:FindFirstChild("BG");

    if not BG then
        return;
    end;

    local TextLabel = BG:FindFirstChild("TextLabel");

    if not TextLabel then
        return;
    end;

    local u8 = 0;
    u1:Add(task.spawn(function() -- Line: 50
        -- upvalues: u7 (copy), BG (copy), GameConfigController (ref), CravingDisplayController (ref), TextLabel (copy), u8 (ref)
        while task.wait(1) do
            local v9 = (workspace:GetServerTimeNow() > 0 and u7.Enabled and true or false) and (BG.AbsoluteSize.Y > 0 and GameConfigController:GetConfig("FallMarketEventConfig"));

            if v9 then
                local BubbleDisplayData, v10, v11 = CravingDisplayController:GetBubbleDisplayData(v9);
                local v12 = `The Heartseed needs <b><font color="{BubbleDisplayData}">{v10}</font></b> plants!`;
                TextLabel.RichText = true;
                TextLabel.TextColor3 = v11;

                if TextLabel.Text == v12 then
                    if TextLabel.ContentText ~= "" and (TextLabel.TextBounds.Y <= 0 and u8 < 3) then
                        u8 = u8 + 1;
                        TextLabel.Text = "";
                        TextLabel.Text = v12;
                    end;
                else
                    TextLabel.Text = v12;
                    u8 = 0;
                end;
            end;
        end;
    end));
end;

EventRotationClientBinder:Bind({
    EventSet = "FallMarketEvent",
    Script = script,

    OnStart = function() -- Line: 91, Name: OnStart
        -- upvalues: u2 (copy)
        task.spawn(u2.Start, u2);
    end,

    OnStop = function() -- Line: 92, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u2;