-- Decompiled with Potassium's decompiler.

local Pool = require(script.Parent.Parent.Pool);
local BoltGen = require(script.Parent.BoltGen);
local CFrame_new_ret = CFrame.new(1000000000, 1000000000, 1000000000);
local u1 = {
    MAX_BOLT_PARTS = 64,
    Rigs = setmetatable({}, {
        __mode = "k"
    })
};

local function buildSegment(p2) -- Line: 24
    -- upvalues: Pool (copy)
    local v3 = Pool.copyBare(p2);
    v3.Anchored = true;
    v3.CanCollide = false;
    v3.CanQuery = false;
    v3.CanTouch = false;
    v3.Massless = true;
    v3.Locked = true;
    v3.Archivable = false;
    v3.Transparency = 0;

    return v3, v3:FindFirstChildWhichIsA("Decal") or v3:FindFirstChildWhichIsA("Texture");
end;

function u1.layoutFor(p4) -- Line: 40
    -- upvalues: BoltGen (copy)
    return BoltGen.layout(p4.SegmentCount.Max, p4.ForkDepth.Max, p4.ForkChance.Max, 64);
end;

function u1.buildRig(p5) -- Line: 46
    -- upvalues: u1 (copy), Pool (copy), CFrame_new_ret (copy)
    local v6, v7, v8, v9 = u1.layoutFor(p5);
    local Model = Instance.new("Model");
    Model.Name = "LightningBolt";
    Model.Archivable = false;
    Model:SetAttribute("_lightningBolt", true);
    local v10 = {
        partCount = v6,
        mainSegs = v7,
        forkSegs = v8,
        forkSlots = v9,
        parts = table.create(v6),
        rollCFs = table.create(v6),
        writeCFs = table.create(v6),
        segLen = table.create(v6),
        revealDist = table.create(v6),
        revealOrder = table.create(v6),
        widthScale = table.create(v6),
        decals = table.create(v6),
        slotDepth = table.create((math.max(v9, 1))),
        ptBuf = table.create(v7 + 1),
        basePtBuf = table.create(v7 + 1),
        forkPtBuf = table.create(v8 + 1),
        forkAnchorPos = {},
        forkAnchorDir = {},
        forkAnchorReveal = {},
        forkAnchorSlot = {},
        forkAnchorPtIdx = {},
        forkOriginIdx = {},
        forkParentSlot = {},
        forkParentPtIdx = {},
        forkLen = {},
        forkU = {},
        forkV = {},
        forkSeedU = {},
        forkSeedV = {},
        forkLocalPts = {},
        forkWorldPts = {},
        prevLive = table.create(v6),
        lastWrittenLen = table.create(v6),
        sizeWriteIdx = table.create(v6),
        newlyLiveIdx = table.create(v6),
        gradColor = table.create(v6)
    };

    for i = 1, v9 do
        v10.forkLocalPts[i] = table.create(v8 + 1);
        v10.forkWorldPts[i] = table.create(v8 + 1);
        v10.forkOriginIdx[i] = 0;
        v10.forkParentSlot[i] = 0;
        local _ = i;
    end;

    local v11;

    if v9 > 0 then
        local math_ceil_ret = math.ceil(v9 / 2);
        v11 = math.max(1, math_ceil_ret) or 0;
    else
        v11 = 0;
    end;

    for i = 1, v9 do
        v10.slotDepth[i] = i <= v11 and 1 or 2;
        local _ = i;
    end;

    local math_max_ret = math.max(0.45, p5.ForkLengthScale and (p5.ForkLengthScale.Max or 0.4) or 0.4);

    for i = 1, v6 do
        local v12 = Pool.copyBare(p5.RenderTemplate);
        v12.Anchored = true;
        v12.CanCollide = false;
        v12.CanQuery = false;
        v12.CanTouch = false;
        v12.Massless = true;
        v12.Locked = true;
        v12.Archivable = false;
        v12.Transparency = 0;
        local v13 = v12:FindFirstChildWhichIsA("Decal") or v12:FindFirstChildWhichIsA("Texture");
        v12.Name = "Seg" .. i;
        v12.CFrame = CFrame_new_ret;
        v12.Parent = Model;
        v10.parts[i] = v12;
        v10.decals[i] = v13;
        v10.rollCFs[i] = CFrame_new_ret;
        v10.writeCFs[i] = CFrame_new_ret;
        v10.segLen[i] = 0.05;
        v10.revealDist[i] = (1 / 0);
        v10.revealOrder[i] = i;
        v10.prevLive[i] = false;
        v10.lastWrittenLen[i] = -1;
        local v14;

        if i <= v7 then
            v10.widthScale[i] = 1;
            v14 = i;
        else
            local v15 = math.floor((i - v7 - 1) / v8) + 1;
            v10.widthScale[i] = math_max_ret ^ (v10.slotDepth[v15] or 1);
            v14 = i;
        end;
    end;

    u1.Rigs[Model] = v10;

    return Model, v10;
end;

function u1.acquireBolt(p16) -- Line: 126
    -- upvalues: u1 (copy), Pool (copy)
    local v17 = u1.layoutFor(p16);
    local u18 = p16.Pool ~= false and Pool.acquire(p16.RenderTemplate, "Lightning");

    if u18 then
        local v19 = u1.Rigs[u18];

        if v19 and (v19.partCount == v17 and (v19.parts[1] and v19.parts[1].Parent == u18)) then
            u18:SetAttribute("_PartIcleEmit", true);

            return u18, v19;
        end;

        pcall(function() -- Line: 136
            -- upvalues: u18 (copy)
            u18:Destroy();
        end);
    end;

    local v20, v21 = u1.buildRig(p16);
    v20:SetAttribute("_PartIcleEmit", true);

    return v20, v21;
end;

return u1;