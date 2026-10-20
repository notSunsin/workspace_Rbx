-- Decompiled with Potassium's decompiler.

local ContentProvider = game:GetService("ContentProvider");
local v1 = {};
local u2 = false;

local function ensurePreloaded() -- Line: 8
    -- upvalues: u2 (ref), ContentProvider (copy)
    if u2 then
        return;
    end;

    u2 = true;
    task.spawn(function() -- Line: 11
        -- upvalues: ContentProvider (ref)
        pcall(function() -- Line: 12
            -- upvalues: ContentProvider (ref)
            ContentProvider:PreloadAsync(game.ReplicatedStorage.Arrow:GetDescendants());
        end);
    end);
end;

function v1.GenerateArrow(p3, p4, p5) -- Line: 18
    -- upvalues: u2 (ref), ContentProvider (copy)
    if not u2 then
        u2 = true;
        task.spawn(function() -- Line: 11
            -- upvalues: ContentProvider (ref)
            pcall(function() -- Line: 12
                -- upvalues: ContentProvider (ref)
                ContentProvider:PreloadAsync(game.ReplicatedStorage.Arrow:GetDescendants());
            end);
        end);
    end;

    local v6 = game.ReplicatedStorage.Arrow:Clone();
    v6.Random_Seed.Value = p5;
    v6.Target_Player.Value = p3.Name;
    v6.Anchored = true;
    v6.Position = p4;
    v6.CanCollide = false;
    v6.Parent = game.Workspace.Tutorial_Arrows;
    local Attachment = Instance.new("Attachment");
    Attachment.Name = p5;
    Attachment.Parent = p3.Character.HumanoidRootPart;
    Attachment.Name = tostring(p5) .. "_Arrow";
    Attachment.CFrame = CFrame.new(0, 0, 0);
    v6.Beam.Attachment1 = Attachment;
    v6.Beam.Attachment0 = v6.Attachment;
    v6.Attachment.WorldCFrame = CFrame.new(p4);

    return v6;
end;

function v1.Remove_Arrow(p7) -- Line: 39
    local v8 = p7 and (p7.Parent and game.Players:FindFirstChild(p7.Target_Player.Value));

    if v8 then
        local v9 = v8.Character.HumanoidRootPart:FindFirstChild((tostring(p7.Random_Seed.Value .. "_Arrow")));

        if v9 then
            v9:Destroy();
        end;

        p7:Destroy();
    end;
end;

return v1;