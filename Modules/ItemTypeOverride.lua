-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = {};

for i, _ in require(ReplicatedStorage.Data.SeedPackData).Packs do
    if i:lower():find("present") then
        v1[i] = "Present";
    elseif i:lower():find("container") then
        v1[i] = "Container";
    elseif i:lower():find("chest") then
        v1[i] = "Chest";
    end;
end;

return v1;