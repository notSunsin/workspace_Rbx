-- Decompiled with Potassium's decompiler.

script.Bind.Event:Connect(function(p1, p2) -- Line: 2
    p1.Destroying:Once(p2);
end);

return function(p3, p4) -- Line: 6
    script.Bind:Fire(p3, p4);
end;