-- Decompiled with Potassium's decompiler.

local BeeItems = game:GetService("ReplicatedStorage").Assets:FindFirstChild("BeeItems");

return function(p1) -- Line: 19, Name: ApplyBeeItem
    -- upvalues: BeeItems (copy)
    local v2 = p1.Client and p1.Client.Model;

    if not v2 then
        return;
    end;

    local BeeItemAttachment = v2:FindFirstChild("BeeItemAttachment");

    if BeeItemAttachment then
        BeeItemAttachment:Destroy();
    end;

    p1.Client.ItemModel = nil;
    local v3 = p1.Server and p1.Server.Enchantment;

    if not (v3 and BeeItems) then
        return;
    end;

    local v4 = BeeItems:FindFirstChild(v3);

    if not v4 then
        return;
    end;

    local Torso = v2:FindFirstChild("Torso", true);

    if not (Torso and Torso:IsA("BasePart")) then
        warn((`BeeItemLoader | bee model "{v2.Name}" has no "Torso" part; skipping item "{v3}"`));

        return;
    end;

    local v5 = v4:Clone();
    v5.Name = "BeeItemAttachment";
    local v6;

    if v5:IsA("BasePart") then
        v6 = v5;
    elseif v5:IsA("Model") then
        v6 = v5.PrimaryPart or v5:FindFirstChildWhichIsA("BasePart", true);
    else
        v6 = v5:FindFirstChildWhichIsA("BasePart", true);
    end;

    if not v6 then
        v5:Destroy();

        return;
    end;

    local Descendants = v5:GetDescendants();

    if v5:IsA("BasePart") then
        table.insert(Descendants, v5);
    end;

    for _, v in Descendants do
        if v:IsA("BasePart") then
            v.CanCollide = false;
            v.CanQuery = false;
            v.Anchored = false;
            v.Massless = true;
        end;
    end;

    if v5:IsA("PVInstance") then
        v5:PivotTo(Torso.CFrame * CFrame.Angles(3.141592653589793, 3.141592653589793, 0));

        if v6:IsA("BasePart") then
            v6.Transparency = 1;
        end;
    else
        v6.CFrame = Torso.CFrame * CFrame.Angles(3.141592653589793, 3.141592653589793, 0);
        v6.Transparency = 1;
    end;

    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = Torso;
    WeldConstraint.Part1 = v6;
    WeldConstraint.Parent = v6;
    v5.Parent = v2;
    p1.Client.ItemModel = v5;
end;