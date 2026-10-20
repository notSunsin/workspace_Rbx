-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SessionTimeLuckData = require(ReplicatedStorage.Data.SessionTimeLuckData);
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
local LocalPlayer = Players.LocalPlayer;
local v10 = {
    GetCurrentLuck = function(p1) -- Line: 12, Name: GetCurrentLuck
        -- upvalues: LocalPlayer (copy), SessionTimeLuckData (copy)
        if not LocalPlayer:GetAttribute("SessionTimeLuckEnabled") then
            return 0;
        end;

        local v2 = LocalPlayer:GetAttribute("SessionTimeLuckIndex") or 1;
        local v3 = SessionTimeLuckData.Timer[v2 or 1];

        return not v3 and 0 or v3.Luck;
    end,

    Start = function(p4) -- Line: 26, Name: Start
        -- upvalues: GetFarm (copy), LocalPlayer (copy), ReplicatedStorage (copy), SessionTimeLuckData (copy)
        local v5 = nil;

        while true do
            v5 = v5 or GetFarm(LocalPlayer);

            if v5 then
                break;
            end;

            task.wait(1);
        end;

        local u6 = ReplicatedStorage.Assets.Models.Luckboard:Clone();
        local LuckboardSpawn = v5:WaitForChild("LuckboardSpawn", 999);

        if not LuckboardSpawn then
            u6:Destroy();

            return;
        end;

        u6:PivotTo(LuckboardSpawn:GetPivot());

        for i, v in SessionTimeLuckData.Timer do
            local v7 = u6.Main.SurfaceGui.Frame:FindFirstChild((tostring(i)));

            if v7 then
                v7.Seconds.Text = `{v.Time // 60} Minutes`;
                v7.TextLabel.Text = `+{v.Luck * 100}% Luck`;
            end;
        end;

        local TextLabel = u6.Main.SurfaceGui.Frame.ActiveBoost.TextLabel;

        local function update() -- Line: 59
            -- upvalues: LocalPlayer (ref), u6 (copy), ReplicatedStorage (ref), SessionTimeLuckData (ref), TextLabel (copy)
            if not LocalPlayer:GetAttribute("SessionTimeLuckEnabled") then
                u6.Parent = ReplicatedStorage;

                return;
            end;

            u6.Parent = workspace.MapDecorations;
            local v8 = LocalPlayer:GetAttribute("SessionTimeLuckIndex") or 1;
            local v9 = SessionTimeLuckData.Timer[v8 or 1];
            TextLabel.Text = not v9 and "1x Luck" or `+{v9.Luck * 100}% Luck`;
        end;

        LocalPlayer:GetAttributeChangedSignal("SessionTimeLuckIndex"):Connect(update);
        LocalPlayer:GetAttributeChangedSignal("SessionTimeLuckEnabled"):Connect(update);
        task.spawn(update);
    end
};
task.spawn(v10.Start, v10);

return v10;