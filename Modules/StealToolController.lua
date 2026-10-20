-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
local PlantOutlineController = require(ReplicatedStorage.Modules.PlantOutlineController);
require(ReplicatedStorage.Modules.ProximityPromptController);
local LocalPlayer = Players.LocalPlayer;
local u1 = GetFarm(LocalPlayer);
local u2 = {
    Active = false,
    Conn = nil,
    DisabledPrompts = {}
};

local function updatePrompt(p3: boolean) -- Line: 19
    -- upvalues: u1 (ref), GetFarm (copy), LocalPlayer (copy), PlantOutlineController (copy)
    if not u1 then
        u1 = GetFarm(LocalPlayer);
    end;

    local ActivePrompt = PlantOutlineController:GetActivePrompt();

    if ActivePrompt and (u1 and not ActivePrompt:IsDescendantOf(u1)) then
        local v4 = p3 and "Steal" or "Collect";

        if ActivePrompt.ActionText ~= v4 then
            ActivePrompt.ActionText = v4;
        end;

        local v5 = p3 and 2 or 0;

        if ActivePrompt.HoldDuration ~= v5 then
            ActivePrompt.HoldDuration = v5;
        end;
    end;
end;

function u2.SetEnabled(p6: table, p7: boolean) -- Line: 38
    -- upvalues: u2 (copy), RunService (copy), u1 (ref), GetFarm (copy), LocalPlayer (copy), PlantOutlineController (copy)
    if p7 then
        if not u2.Active then
            u2.Active = true;
            u2.Conn = RunService.PreRender:Connect(function() -- Line: 42
                -- upvalues: u1 (ref), GetFarm (ref), LocalPlayer (ref), PlantOutlineController (ref)
                if not u1 then
                    u1 = GetFarm(LocalPlayer);
                end;

                local ActivePrompt = PlantOutlineController:GetActivePrompt();

                if ActivePrompt and (u1 and not ActivePrompt:IsDescendantOf(u1)) then
                    if ActivePrompt.ActionText ~= "Steal" then
                        ActivePrompt.ActionText = "Steal";
                    end;

                    if ActivePrompt.HoldDuration ~= 2 then
                        ActivePrompt.HoldDuration = 2;
                    end;
                end;
            end);
        end;
    elseif u2.Active then
        u2.Active = false;

        if u2.Conn then
            u2.Conn:Disconnect();
            u2.Conn = nil;
        end;

        if not u1 then
            u1 = GetFarm(LocalPlayer);
        end;

        local ActivePrompt = PlantOutlineController:GetActivePrompt();

        if ActivePrompt and (u1 and not ActivePrompt:IsDescendantOf(u1)) then
            if ActivePrompt.ActionText ~= "Collect" then
                ActivePrompt.ActionText = "Collect";
            end;

            if ActivePrompt.HoldDuration ~= 0 then
                ActivePrompt.HoldDuration = 0;
            end;
        end;
    end;
end;

return u2;