-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("SoundService");
game:GetService("Players");
local Observers = require(ReplicatedStorage.Modules.Observers);
local v5 = {
    Start = function(p1) -- Line: 10, Name: Start
        -- upvalues: Observers (copy)
        Observers.observeTag("AutomaticScrollBarThickness", function(u2: userdata) -- Line: 11
            if not u2:IsA("ScrollingFrame") then
                return nil;
            end;

            local u3 = nil;

            local function update() -- Line: 17
                -- upvalues: u3 (ref), u2 (copy)
                if u3 and coroutine.status(u3) == "suspended" then
                    pcall(task.cancel, u3);
                end;

                u3 = task.delay(0.15, function() -- Line: 22
                    -- upvalues: u2 (ref), u3 (ref)
                    local Parent = u2.Parent;

                    if not (Parent and Parent:IsA("GuiObject")) then
                        return;
                    end;

                    u2.ScrollBarThickness = Parent.AbsoluteSize.X * 0.025;
                    u3 = nil;
                end);
            end;

            local u4 = u2:GetPropertyChangedSignal("AbsoluteSize"):Connect(update);
            task.spawn(update);

            return function() -- Line: 37
                -- upvalues: u4 (copy)
                u4:Disconnect();
            end;
        end);
    end
};
task.spawn(v5.Start, v5);

return v5;