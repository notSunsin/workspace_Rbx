-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.UpdateService);
local v1 = 86400;
local UnixTimestamp = DateTime.fromUniversalTime(2025, 12, 6, 2).UnixTimestamp;
local UnixTimestamp2 = DateTime.fromUniversalTime(2025, 12, 25, 2).UnixTimestamp;
DAILY_QUEST_COUNT = 3;

return {
    DAY_LENGTH = v1,
    START_TIMESTAMP = UnixTimestamp,
    END_TIMESTAMP = UnixTimestamp2,
    DAY_COUNT = (UnixTimestamp2 - UnixTimestamp) // v1,
    DAILY_QUEST_COUNT = DAILY_QUEST_COUNT
};