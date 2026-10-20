-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local HttpService = game:GetService("HttpService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Hud_UI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Hud_UI");
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local UpdateTimeUserInterface = Hud_UI.SideBtns.UpdateTimeUserInterface;
local Template = UpdateTimeUserInterface.Template;
local u1 = {
    State = {
        ActiveTimers = {}
    }
};
local u2 = nil;
local u3 = {};

local function GetUpdateTimerData() -- Line: 32
    -- upvalues: u2 (ref), u3 (ref), HttpService (copy)
    local Attribute = workspace:GetAttribute("UpdateTimerData");

    if not Attribute then
        return {};
    end;

    if Attribute == u2 then
        return u3;
    end;

    local success, result = pcall(function() -- Line: 43
        -- upvalues: HttpService (ref), Attribute (copy)
        return HttpService:JSONDecode(Attribute);
    end);

    if not success then
        warn("[UpdateTimeUserInterfaceController]: Failed to parse UpdateTimerData!", result);

        return {};
    end;

    u2 = Attribute;
    u3 = result;

    return result;
end;

function u1.Render(p4) -- Line: 57
    -- upvalues: GetUpdateTimerData (copy), u1 (copy), Template (copy), UpdateTimeUserInterface (copy), TimeHelper (copy)
    local v5 = workspace:GetServerTimeNow() // 1;
    local v6 = GetUpdateTimerData();
    local ActiveTimers = u1.State.ActiveTimers;
    local v7 = {};

    for i, v in v6 do
        local UpdateTime = v.UpdateTime;
        local UpdateText = v.UpdateText;
        local v8 = `{i}-{UpdateText}`;
        v7[v8] = true;

        if not ActiveTimers[v8] then
            local v9 = Template:Clone();
            ActiveTimers[v8] = {
                TimerLabel = v9,
                UpdateTime = UpdateTime,
                UpdateText = UpdateText
            };
            v9.Parent = UpdateTimeUserInterface;
            v9.LayoutOrder = i;
            v9.Visible = true;
        end;
    end;

    for i, v in ActiveTimers do
        if not v7[i] then
            v.TimerLabel:Destroy();
            ActiveTimers[i] = nil;
        end;
    end;

    for i, v in v6 do
        local UpdateTime = v.UpdateTime;
        local UpdateText = v.UpdateText;
        local v10 = ActiveTimers[`{i}-{UpdateText}`];

        if v10 then
            local TimerLabel = v10.TimerLabel;
            local v11 = UpdateTime - v5;
            local v12 = UpdateText:gsub(":UpdateTime:", (TimeHelper:GenerateTextFromTime(v11, true)));

            if v10.LastText ~= v12 then
                v10.LastText = v12;
                TimerLabel.Text = v12;
            end;

            local v13 = v11 > 0;

            if TimerLabel.Visible ~= v13 then
                TimerLabel.Visible = v13;
            end;
        end;
    end;
end;

function u1.Start(p14) -- Line: 127
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 128
        -- upvalues: u1 (ref)
        task.wait(math.random() * 0.9);

        while true do
            task.wait(1);
            u1:Render();
        end;
    end);
end;

task.spawn(function() -- Line: 137
    -- upvalues: u1 (copy)
    u1:Start();
end);

return u1;