-- Decompiled with Potassium's decompiler.

local function GetLuckModifiers(p1: userdata, p2: userdata?, p3: string?) -- Line: 9
    local v4 = { {
            Name = "Default",
            Modifier = 1
        } };

    if p3 == "Plant" or (p3 == "Grow" or p3 == "BottomDisplay") then
        local v5;

        if p2 then
            v5 = p2:GetAttribute("FruitVariantLuck");
        else
            v5 = nil;
        end;

        if type(v5) == "number" and v5 ~= 1 then
            table.insert(v4, {
                Name = "FruitVariantLuck",
                Modifier = v5 - 1
            });
        end;
    end;

    if (p3 == "Plant" or p3 == "Grow") and p1:GetAttribute("AB_FTUELuckBoost_Active") then
        table.insert(v4, {
            Name = "LuckBoostFTUE",
            Modifier = 2
        });
    end;

    if p3 == "BottomDisplay" then
        local Attribute = p1:GetAttribute("SessionTimeLuck");

        if Attribute and Attribute ~= 0 then
            table.insert(v4, {
                Name = "SessionTimeLuck",
                Modifier = Attribute
            });
        end;
    end;

    return v4;
end;

return {
    GetModifiers = GetLuckModifiers,

    GetLuck = function(p6: userdata, p7: any, p8: string?, p9: table?) -- Line: 50, Name: PlayerLuck
        -- upvalues: GetLuckModifiers (copy)
        local v10 = 0;

        for _, v in GetLuckModifiers(p6, p7, p8) do
            if not (p9 and table.find(p9, v.Name)) then
                v10 = v10 + v.Modifier;
            end;
        end;

        return v10 == 0 and 1 or v10;
    end,

    Listen = function(p11: userdata, p12: any) -- Line: 62, Name: Listen
        local u13 = {};
        local AttributeChangedSignal = p11:GetAttributeChangedSignal("SessionTimeLuck");
        table.insert(u13, AttributeChangedSignal:Connect(p12));
        local task_spawn_ret = task.spawn(p12);

        return function() -- Line: 69
            -- upvalues: task_spawn_ret (copy), u13 (copy)
            if coroutine.status(task_spawn_ret) == "suspended" then
                pcall(task.cancel, task_spawn_ret);
            end;

            for _, v in u13 do
                if v.Connected then
                    v:Disconnect();
                end;
            end;

            table.clear(u13);
        end;
    end
};