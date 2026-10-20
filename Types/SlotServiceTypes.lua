-- Decompiled with Potassium's decompiler.

function SpecialSlotEntry(p1: table)
    return p1;
end;

local v2 = {
    EASTER_2026 = SpecialSlotEntry({
        DisplayName = "Easter 2026",
        DataFlag = "IsEasterSlot",
        Color = Color3.fromRGB(255, 152, 220),
        PostEventConfig = {
            EventName = "Easter2026",
            ReadOnly = true
        }
    }),
    BIZZYBEE_2026 = {
        DisplayName = "Honey",
        DataFlag = "IsBeeSlot",
        UpdateGate = "BeeSlot",
        Color = Color3.fromRGB(255, 149, 0),
        PostEventConfig = {
            EventName = "BizzyBee2026",
            Permanent = true,
            PurchasePrice = 1000000000
        }
    },
    HALLOWEEN_2026 = SpecialSlotEntry({
        DisplayName = "Ghoul Garden",
        DataFlag = "IsHalloweenSlot",
        ActiveEventSet = "Halloween2026Event",
        ActiveUntil = 1798761600,
        Color = Color3.fromRGB(255, 117, 24)
    })
};
local v3 = {};

for i, v in v2 do
    if v.PostEventConfig and v.PostEventConfig.Permanent then
        v3[i] = v;
    end;
end;

local v4 = {};

for i, v in v2 do
    if v.PostEventConfig and v.PostEventConfig.ReadOnly then
        v4[i] = v;
    end;
end;

local v5 = {};

for i, _ in v2 do
    v5[i] = i;
end;

return {
    SpecialSlotEntries = v2,
    SpecialSlotKeys = v5,
    PermanentEventSlots = v3,
    ReadOnlyEventSlots = v4
};