-- Decompiled with Potassium's decompiler.

return {
    CalculateSurfaceInfo = function(p1, p2) -- Line: 5, Name: CalculateSurfaceInfo
        local v3 = -Vector3.FromNormalId(Enum.NormalId.Top);
        local v4 = math.abs(v3.y) == 1 and (Vector3.new(v3.y, 0, 0) or Vector3.new(0, 1, 0)) or Vector3.new(0, 1, 0);
        local v5 = CFrame.fromAxisAngle(v4, 1.5707963267948966) * v3;
        local Unit = v3:Cross(v5).Unit;

        return p1 * CFrame.fromMatrix(-v3 * p2 / 2, v5, Unit, v3), Vector2.new((p2 * v5).Magnitude, (p2 * Unit).Magnitude);
    end,

    CalculateCameraProperties = function(p6, p7, p8, p9) -- Line: 17, Name: CalculateCameraProperties
        local v10 = p7:PointToObjectSpace(p6.p);
        local v11 = v10.x / p8.x;
        local v12 = v10.y / p8.y;
        local v13 = math.abs(v11) * 2 + 1;
        local v14 = math.abs(v12) * 2 + 1;
        local math_sqrt_ret = math.sqrt(v13 * v13 + v14 * v14);
        local v15 = (p6.p - p7.p):Dot(p7.LookVector);
        local v16 = math.atan2(p8.y / 2, v15) * 2;
        local math_deg_ret = math.deg(v16);
        local math_clamp_ret = math.clamp(math_deg_ret, 1, 120);
        local v17 = p8.y / 2;
        local v18 = math.rad(math_clamp_ret) / 2;
        local v19 = v15 / (v17 / math.tan(v18));
        local v20 = (v16 > 2.0943951023931953 and v19 and v19 or 1) / math_sqrt_ret;

        return v11, v12, math_sqrt_ret, CFrame.new(0, 0, 0, v20, 0, 0, 0, v20, 0, 0, 0, 1), math_clamp_ret;
    end
};