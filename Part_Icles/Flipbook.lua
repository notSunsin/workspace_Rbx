-- Decompiled with Potassium's decompiler.

local ContentProvider = game:GetService("ContentProvider");
local Range = require(script.Parent.Range);
local v11 = {
    GetSortedTextures = function(p1: userdata) -- Line: 9, Name: GetSortedTextures
        -- upvalues: ContentProvider (copy)
        local v2 = {};

        for _, child in pairs(p1:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                table.insert(v2, child);
            end;
        end;

        if #v2 == 0 then
            return {};
        end;

        table.sort(v2, function(p3, p4) -- Line: 18
            return (tonumber(p3.Name) or 0) < (tonumber(p4.Name) or 0);
        end);
        local u5 = {};

        for _, v in ipairs(v2) do
            table.insert(u5, v.Texture);
        end;

        if #u5 > 0 then
            task.spawn(function() -- Line: 29
                -- upvalues: ContentProvider (ref), u5 (copy)
                ContentProvider:PreloadAsync(u5);
            end);
        end;

        return u5;
    end,

    GetSortedBeamTextures = function(p6: userdata) -- Line: 38, Name: GetSortedBeamTextures
        -- upvalues: ContentProvider (copy)
        local v7 = {};

        for _, child in pairs(p6:GetChildren()) do
            if child:IsA("Decal") then
                table.insert(v7, child);
            end;
        end;

        if #v7 == 0 then
            return {};
        end;

        table.sort(v7, function(p8, p9) -- Line: 47
            return (tonumber(p8.Name) or 0) < (tonumber(p9.Name) or 0);
        end);
        local u10 = {};

        for _, v in ipairs(v7) do
            table.insert(u10, v.Texture);
        end;

        if #u10 > 0 then
            task.spawn(function() -- Line: 57
                -- upvalues: ContentProvider (ref), u10 (copy)
                ContentProvider:PreloadAsync(u10);
            end);
        end;

        return u10;
    end
};
local u12 = false;

local function _writeFrame(u13, u14, u15) -- Line: 67
    -- upvalues: u12 (ref)
    local success, result = pcall(function() -- Line: 68
        -- upvalues: u13 (copy), u14 (copy), u15 (copy)
        u13[u14] = u15;
    end);

    if not (success or (u14 ~= "ColorMap" or u12)) then
        u12 = true;
        warn(("[Part-Icles] SurfaceAppearance flipbook ColorMap write failed (%s). ColorMap is PluginSecurity  -  SurfaceAppearance flipbooks only animate in plugin context. For runtime games, use Decal / Texture flipbooks instead."):format((tostring(result))));
    end;
end;

local function _texProp(p16) -- Line: 79
    return p16 and p16:IsA("SurfaceAppearance") and "ColorMap" or (p16 and p16:IsA("MeshPart") and "TextureID" or "Texture");
end;

local function _loop(u17, p18, u19, u20, u21) -- Line: 88
    -- upvalues: Range (copy), _writeFrame (copy)
    if #u19 == 0 then
        return;
    end;

    local v22 = Range.RandomValueFromRange(p18.FlipbookFramerate);
    local u23 = 1 / ((not v22 or v22 < 0.1) and 0.1 or v22);
    local u24 = #u19;
    local FlipbookReverse = p18.FlipbookReverse;
    local u25 = p18.FlipbookStartRandom and (math.random(0, u24 - 1) or 0) or 0;
    local os_clock_ret = os.clock();
    local u26 = u20 and u20:IsA("SurfaceAppearance") and "ColorMap" or (u20 and u20:IsA("MeshPart") and "TextureID" or "Texture");
    task.spawn(function() -- Line: 101
        -- upvalues: os_clock_ret (copy), u21 (copy), u20 (copy), u17 (copy), u23 (copy), u25 (copy), u24 (copy), FlipbookReverse (copy), _writeFrame (ref), u26 (copy), u19 (copy)
        local v27 = -1;

        while os.clock() - os_clock_ret < u21 * 4 do
            if not (u20 and u20.Parent) then
                return;
            end;

            if u17 and not (u17.VisualPart and u17.VisualPart.Parent) then
                return;
            end;

            local v28 = u17 and u17._effectiveElapsed or os.clock() - os_clock_ret;
            local v29 = (math.floor(v28 / u23) + u25) % u24 + 1;

            if FlipbookReverse then
                v29 = u24 - v29 + 1;
            end;

            if v29 == v27 then
                v29 = v27;
            else
                _writeFrame(u20, u26, u19[v29]);
            end;

            task.wait();
            v27 = v29;
        end;
    end);
end;

local function _oneShot(u30, p31, u32, u33, u34) -- Line: 120
    -- upvalues: _writeFrame (copy)
    if #u32 == 0 then
        return;
    end;

    local u35 = #u32;
    local FlipbookReverse = p31.FlipbookReverse;
    local u36 = p31.FlipbookStartRandom and (math.random(0, u35 - 1) or 0) or 0;
    local os_clock_ret = os.clock();
    local u37 = u33 and u33:IsA("SurfaceAppearance") and "ColorMap" or (u33 and u33:IsA("MeshPart") and "TextureID" or "Texture");
    task.spawn(function() -- Line: 129
        -- upvalues: os_clock_ret (copy), u34 (copy), u33 (copy), u30 (copy), u35 (copy), u36 (copy), FlipbookReverse (copy), _writeFrame (ref), u37 (copy), u32 (copy)
        local v38 = -1;

        while os.clock() - os_clock_ret < u34 * 4 do
            if not (u33 and u33.Parent) then
                return;
            end;

            if u30 and not (u30.VisualPart and u30.VisualPart.Parent) then
                break;
            end;

            local v39 = u30 and u30._effectiveElapsed or os.clock() - os_clock_ret;
            local v40 = math.floor(v39 / u34 * u35) + 1;
            local v41 = (math.min(v40, u35) - 1 + u36) % u35 + 1;

            if FlipbookReverse then
                v41 = u35 - v41 + 1;
            end;

            if v41 == v38 then
                v41 = v38;
            else
                _writeFrame(u33, u37, u32[v41]);
            end;

            task.wait();
            v38 = v41;
        end;

        if u33 and u33.Parent then
            local v42 = (u35 - 1 + u36) % u35 + 1;

            if FlipbookReverse then
                v42 = u35 - v42 + 1;
            end;

            _writeFrame(u33, u37, u32[v42]);
        end;
    end);
end;

function v11.Flip(p43: any, p44: any, p45: table, p46: any, p47: any) -- Line: 155
    -- upvalues: _loop (copy), _oneShot (copy)
    if not (p44 and p44.FlipbookMode) then
        return;
    end;

    if p44.FlipbookMode == Enum.ParticleFlipbookMode.Loop then
        _loop(p43, p44, p45, p46, p47);

        return;
    end;

    if p44.FlipbookMode == Enum.ParticleFlipbookMode.OneShot then
        _oneShot(p43, p44, p45, p46, p47);
    end;
end;

function v11.FlipBeam(p48: any, p49: any, p50: table, p51: any, p52: any) -- Line: 165
    -- upvalues: _loop (copy), _oneShot (copy)
    if not (p49 and (p50 and p49.FlipbookMode)) then
        return;
    end;

    local FlipbookMode = p49.FlipbookMode;

    if FlipbookMode == Enum.ParticleFlipbookMode.Loop then
        _loop(p48, p49, p50, p51, p52);

        return;
    end;

    if FlipbookMode == Enum.ParticleFlipbookMode.OneShot then
        _oneShot(p48, p49, p50, p51, p52);
    end;
end;

return v11;