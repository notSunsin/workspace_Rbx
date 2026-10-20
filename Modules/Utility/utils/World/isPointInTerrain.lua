-- Decompiled with Potassium's decompiler.

return function(p1: vector) -- Line: 1, Name: isPointInTerrain
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Terrain };
    local v2 = p1 + Vector3.new(0, 10000, 0);
    local v3 = workspace:Raycast(p1, v2 - p1, RaycastParams_new_ret);

    if v3 then
        v2 = v3.Position or v2;
    end;

    return workspace:Raycast(v2, p1 - v2, RaycastParams_new_ret) ~= nil;
end;