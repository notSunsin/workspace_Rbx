-- Decompiled with Potassium's decompiler.

return {
    ToggleAllTrails = function(p1: userdata, p2: boolean) -- Line: 4, Name: ToggleAllTrails
        for _, descendant in ipairs(p1:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = p2;
            end;
        end;
    end,

    GetMaxLifetime = function(p3: userdata) -- Line: 13, Name: GetMaxLifetime
        local v4 = 0;

        for _, descendant in ipairs(p3:GetDescendants()) do
            if descendant:IsA("Trail") then
                v4 = math.max(v4, descendant.Lifetime);
            elseif descendant:IsA("ParticleEmitter") then
                v4 = math.max(v4, descendant.Lifetime.Max);
            end;
        end;

        return v4;
    end
};