-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SlotServiceTypes = require(ReplicatedStorage.Types.SlotServiceTypes);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);

return {
    HasWindow = function(p1: string) -- Line: 11, Name: HasWindow
        -- upvalues: SlotServiceTypes (copy)
        local v2 = SlotServiceTypes.SpecialSlotEntries[p1];
        local v3;

        if v2 == nil then
            v3 = false;
        else
            v3 = v2.ActiveEventSet ~= nil;
        end;

        return v3;
    end,

    IsOpen = function(p4: string) -- Line: 16, Name: IsOpen
        -- upvalues: SlotServiceTypes (copy), EventRotationUtils (copy)
        local v5 = SlotServiceTypes.SpecialSlotEntries[p4];

        if not (v5 and v5.ActiveEventSet) then
            return true;
        end;

        if v5.ActiveUntil and workspace:GetServerTimeNow() >= v5.ActiveUntil then
            return false;
        end;

        local CurrentEvent = EventRotationUtils:GetCurrentEvent();
        local v6;

        if CurrentEvent == nil then
            v6 = false;
        else
            v6 = CurrentEvent.EventSet == v5.ActiveEventSet;
        end;

        return v6;
    end,

    GetEventDisplayName = function(p7: string) -- Line: 31, Name: GetEventDisplayName
        -- upvalues: SlotServiceTypes (copy), EventRotationUtils (copy)
        local v8 = SlotServiceTypes.SpecialSlotEntries[p7];

        if not (v8 and v8.ActiveEventSet) then
            return nil;
        end;

        local v9 = EventRotationUtils:GetEventSetConfigs(v8.ActiveEventSet)[1];

        if v9 then
            v9 = v9.EventDisplayName;
        end;

        if v9 then
            return v9:gsub(" %- Part %d+$", "");
        end;

        return nil;
    end
};