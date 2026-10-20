-- Decompiled with Potassium's decompiler.

return function() -- Line: 3
    local os_clock_ret = os.clock();

    while workspace:GetAttribute("ExtendedServer") == nil do
        task.wait();

        if os.clock() - os_clock_ret > 15 then
            warn("GetFarmsAsync timed out");
            break;
        end;
    end;

    return workspace.Farm:GetChildren();
end;