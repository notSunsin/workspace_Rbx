-- Decompiled with Potassium's decompiler.

return function(p1: thread, p2: number?) -- Line: 20, Name: ThreadJoin
    local os_clock_ret = os.clock();

    while coroutine.status(p1) ~= "dead" do
        if p2 ~= nil and p2 <= os.clock() - os_clock_ret then
            return false;
        end;

        task.wait();
    end;

    return true;
end;