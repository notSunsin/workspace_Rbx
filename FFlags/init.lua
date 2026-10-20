-- Decompiled with Potassium's decompiler.

if game:GetService("RunService"):IsServer() then
    return require(script.Server);
end;

return require(script.Client);