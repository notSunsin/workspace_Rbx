-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = {};

for i, v in require(ReplicatedStorage.Data.EnumRegistry.VariantsEnums) do
    v1[v] = i;
end;

return v1;