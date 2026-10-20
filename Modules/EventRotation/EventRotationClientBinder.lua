-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);

return {
    Bind = function(p1: table, u2: table) -- Line: 19, Name: Bind
        -- upvalues: EventRotationUtils (copy), EventRotationController (copy)
        local u3 = false;

        if typeof(u2.EventSet) == "string" then
            u2.EventSet = { u2.EventSet };
        end;

        local function MeetsPartRequirement(p4: string, p5: string) -- Line: 27
            -- upvalues: u2 (copy), EventRotationUtils (ref)
            if not u2.MinPartIndex then
                return true;
            end;

            local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(p4, p5);
            local v6;

            if EventInSetIndex == nil then
                v6 = false;
            else
                v6 = u2.MinPartIndex <= EventInSetIndex;
            end;

            return v6;
        end;

        local function OnEventUpdated(p7: string, p8: string) -- Line: 34
            -- upvalues: u2 (copy), EventRotationUtils (ref), u3 (ref)
            if table.find(u2.EventSet, p8) then
                local v9;

                if u2.MinPartIndex then
                    local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(p7, p8);

                    if EventInSetIndex == nil then
                        v9 = false;
                    else
                        v9 = u2.MinPartIndex <= EventInSetIndex;
                    end;
                else
                    v9 = true;
                end;

                if v9 then
                    if u3 then
                        return;
                    end;

                    u3 = true;
                    u2.OnStop();
                    task.spawn(u2.OnStart);

                    return;
                end;
            end;

            if u3 then
                u3 = false;
                u2.OnStop();
            end;
        end;

        EventRotationController.EventUpdated:Connect(OnEventUpdated);
        local LoadedEvent = EventRotationController:GetLoadedEvent();

        if LoadedEvent and table.find(u2.EventSet, LoadedEvent.EventSet) then
            OnEventUpdated(LoadedEvent.EventID, LoadedEvent.EventSet);
        end;
    end
};