-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local u1 = RunService:IsServer();
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
local u2 = nil;
local u3 = nil;

if u1 then
    u2 = require(game:GetService("ServerScriptService").Modules.SoundPlayerServer);
else
    u3 = require(ReplicatedStorage.Modules.SoundPlayer);
end;

local SoundData = require(ReplicatedStorage.Data.SoundData);
local Silver_Reference = ReplicatedStorage:WaitForChild("Silver_Reference");
local Gold_Reference = ReplicatedStorage:WaitForChild("Gold_Reference");
local Rainbow_Reference = ReplicatedStorage:WaitForChild("Rainbow_Reference");
local Diamond_Reference = ReplicatedStorage:WaitForChild("Diamond_Reference");
local Jelly_Reference = ReplicatedStorage:WaitForChild("Jelly_Reference");
local Ember_Reference = ReplicatedStorage:WaitForChild("Ember_Reference");
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = {};
local u10 = {};

local function InsertEffects(p11: userdata, p12: userdata, p13: string?) -- Line: 34
    local function RandParticles(p14: userdata) -- Line: 35
        if p14:IsA("ParticleEmitter") then
            p14.Rate = p14.Rate * (math.random() * 0.2 + 0.9);
        end;
    end;

    for _, child in p12:GetChildren() do
        local v15 = child:Clone();
        v15.Parent = p11;
        v15:AddTag(p13 or "Cleanup_Variant");

        if v15:IsA("Texture") then
            v15.Transparency = 1;
        end;

        if v15:IsA("ParticleEmitter") then
            v15.Rate = v15.Rate * (math.random() * 0.2 + 0.9);
        end;

        for _, descendant in v15:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Rate = descendant.Rate * (math.random() * 0.2 + 0.9);
            end;
        end;
    end;
end;

local function RevertPart(p16: userdata) -- Line: 60
    -- upvalues: u10 (copy), u8 (copy), u5 (copy), u6 (copy), u7 (copy), u9 (copy)
    if p16:HasTag("RainbowPart") then
        p16:RemoveTag("RainbowPart");
    end;

    if p16:HasTag("JellyPart") then
        p16:RemoveTag("JellyPart");
    end;

    if p16:HasTag("EmberPart") then
        p16:RemoveTag("EmberPart");
    end;

    if u10[p16] then
        u10[p16]:Disconnect();
        u10[p16] = nil;
    end;

    if u8[p16] ~= nil then
        p16.Reflectance = u8[p16];
        u8[p16] = nil;
    end;

    if u5[p16] then
        p16.Color = Color3.new(1, 1, 1);
        p16.Color = u5[p16];
        u5[p16] = nil;
    end;

    if u6[p16] then
        p16.Material = u6[p16];
        u6[p16] = nil;
    end;

    if u7[p16] ~= nil then
        p16.MaterialVariant = u7[p16];
        u7[p16] = nil;
    end;

    if p16:IsA("UnionOperation") and u9[p16] ~= nil then
        p16.UsePartColor = u9[p16];
        u9[p16] = nil;
    end;

    if p16:HasTag("VariantVisual") then
        p16:RemoveTag("VariantVisual");
    end;
end;

local function ApplyVariant(p17: userdata, u18: userdata, p19: string, u20: string?) -- Line: 111
    -- upvalues: u5 (copy), u6 (copy), u7 (copy), u8 (copy), u9 (copy), InsertEffects (copy), u10 (copy), SoundData (copy), u1 (copy), u2 (ref), u3 (ref)
    local function LoopThroughObject(p21: userdata) -- Line: 112
        -- upvalues: LoopThroughObject (copy), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u18 (copy), InsertEffects (ref), u10 (ref), u20 (copy)
        for _, child in p21:GetChildren() do
            if child:IsA("Model") then
                LoopThroughObject(child);
            end;

            if child:IsA("BasePart") or child:IsA("UnionOperation") then
                u5[child] = u5[child] or child.Color;
                u6[child] = u6[child] or child.Material;
                u7[child] = u7[child] ~= nil and u7[child] or child.MaterialVariant;
                u8[child] = u8[child] ~= nil and u8[child] or child.Reflectance;

                if child:IsA("UnionOperation") and u9[child] == nil then
                    u9[child] = child.UsePartColor;
                end;

                if child:IsA("UnionOperation") then
                    child.UsePartColor = true;
                end;

                if not u18:HasTag("IgnoreColor") then
                    child.Color = u18.Color;
                end;

                child.Material = u18.Material;
                child.MaterialVariant = u18.MaterialVariant;
                child:AddTag("VariantVisual");

                if child.Transparency == 1 then
                    if u10[child] then
                        u10[child]:Disconnect();
                    end;

                    u10[child] = child.Changed:Connect(function(p22) -- Line: 143
                        -- upvalues: child (copy), u10 (ref), InsertEffects (ref), u18 (ref)
                        if p22 ~= "Transparency" then
                            return;
                        end;

                        if child.Transparency ~= 0 then
                            return;
                        end;

                        if u10[child] then
                            u10[child]:Disconnect();
                        end;

                        u10[child] = nil;
                        InsertEffects(child, u18);
                    end);
                else
                    InsertEffects(child, u18);
                end;

                if u20 then
                    child:AddTag(u20);
                end;
            end;
        end;
    end;

    LoopThroughObject(p17);
    local v23 = p17:FindFirstChild("Handle") or (p17:FindFirstChild("1") or p17:FindFirstChild("Base"));

    if not v23 then
        warn((`{p17.Name} doesn't have a parent for SFX!`));
    end;

    local v24 = SoundData.General.VariantVisuals[p19];
    local v25 = v24.PlaybackSpeed or 1;

    if u1 then
        u2:PlaySound(v24.Id, nil, {
            Looped = true,
            PlaybackSpeed = v25 + math.random(-5, 5) / 100,
            Volume = v24.Volume
        }, nil, v23 or p17, { "Cleanup_Variant", "VariantSFX" });

        return;
    end;

    u3:PlaySound(v24.Id, {
        Looped = true,
        PlaybackSpeed = v25 + math.random(-5, 5) / 100,
        Volume = v24.Volume
    }, nil, v23 or p17, { "Cleanup_Variant", "VariantSFX" });
end;

local function Rainbow(p26: userdata) -- Line: 183
    -- upvalues: u5 (copy), u8 (copy), u9 (copy), SoundData (copy), u1 (copy), u2 (ref), u3 (ref)
    if not p26 then
        warn("VariantVisuals:Rainbow | no plant provided!");

        return;
    end;

    for _, descendant in p26:GetDescendants() do
        if descendant:IsA("BasePart") then
            local v27 = descendant:FindFirstAncestorWhichIsA("Model");

            if not (v27 and (v27:HasTag("Harvestable") and v27 ~= p26)) then
                u5[descendant] = u5[descendant] or descendant.Color;
                u8[descendant] = u8[descendant] ~= nil and u8[descendant] or descendant.Reflectance;

                if descendant:IsA("UnionOperation") and u9[descendant] == nil then
                    u9[descendant] = descendant.UsePartColor;
                end;

                if descendant:IsA("UnionOperation") then
                    descendant.UsePartColor = true;
                end;

                descendant.Reflectance = 0.25;
                descendant:AddTag("RainbowPart");
                descendant:AddTag("VariantVisual");
            end;
        end;
    end;

    local v28 = p26:FindFirstChild("Handle") or (p26:FindFirstChild("1") or p26);

    if not v28 then
        warn((`VariantVisuals:Rainbow | {p26.Name} doesn't have a parent for SFX!`));
    end;

    local Rainbow_SFX = SoundData.General.VariantVisuals.Rainbow_SFX;

    if u1 then
        u2:PlaySound(Rainbow_SFX.Id, nil, {
            Looped = true,
            PlaybackSpeed = 1 + math.random(-5, 5) / 100,
            Volume = Rainbow_SFX.Volume
        }, nil, v28 or p26, { "Cleanup_Variant", "VariantSFX" });

        return;
    end;

    u3:PlaySound(Rainbow_SFX.Id, {
        Looped = true,
        PlaybackSpeed = 1 + math.random(-5, 5) / 100,
        Volume = Rainbow_SFX.Volume
    }, nil, v28 or p26, { "Cleanup_Variant", "VariantSFX" });
end;

local u36 = {
    Normal = function(p29: userdata) -- Line: 238
        -- upvalues: u4 (copy)
        return u4:ClearVisuals(p29);
    end,

    Silver = function(p30: userdata) -- Line: 239
        -- upvalues: ApplyVariant (copy), Silver_Reference (copy)
        return ApplyVariant(p30, Silver_Reference, "Silver_SFX");
    end,

    Gold = function(p31: userdata) -- Line: 240
        -- upvalues: ApplyVariant (copy), Gold_Reference (copy)
        return ApplyVariant(p31, Gold_Reference, "Gold_SFX");
    end,

    Diamond = function(p32: userdata) -- Line: 241
        -- upvalues: ApplyVariant (copy), Diamond_Reference (copy)
        return ApplyVariant(p32, Diamond_Reference, "Diamond_SFX");
    end,

    Jelly = function(p33: userdata) -- Line: 242
        -- upvalues: ApplyVariant (copy), Jelly_Reference (copy)
        return ApplyVariant(p33, Jelly_Reference, "Jelly_SFX", "JellyPart");
    end,

    Ember = function(p34: userdata) -- Line: 243
        -- upvalues: ApplyVariant (copy), Ember_Reference (copy)
        return ApplyVariant(p34, Ember_Reference, "Ember_SFX", "EmberPart");
    end,

    Rainbow = function(p35: userdata) -- Line: 244
        -- upvalues: Rainbow (copy)
        return Rainbow(p35);
    end
};

function u4.SetVisualsForInstance(p37, p38, p39) -- Line: 248
    -- upvalues: u4 (copy), u36 (copy)
    u4:ClearVisuals(p38);
    local v40 = u36[p39];

    if v40 and (p39 ~= "" and p39 ~= "Normal") then
        v40(p38);
    end;
end;

function u4.SetVisuals(p41: table, u42: userdata) -- Line: 258
    -- upvalues: u4 (copy), u36 (copy)
    if u42 then
        task.spawn(function() -- Line: 264
            -- upvalues: u4 (ref), u42 (copy), u36 (ref)
            u4:ClearVisuals(u42);
            local Variant = u42:FindFirstChild("Variant");
            local v43 = Variant and Variant.Value or "";

            if u36[v43] and (v43 ~= "" and v43 ~= "Normal") then
                while not u42:HasTag("PlantGenerated") do
                    task.wait(0.1);
                end;

                u4:SetVisualsForInstance(u42, v43);
            end;
        end);

        return;
    end;

    warn("VariantVisuals:SetVisuals | plant is nil!");
end;

function u4.ClearVisuals(p44: table, p45: userdata) -- Line: 285
    -- upvalues: RevertPart (copy)
    if not p45 then
        warn("VariantVisuals:ClearVisuals | plant is nil!");

        return;
    end;

    for _, descendant in p45:GetDescendants() do
        if descendant:HasTag("Cleanup_Variant") or descendant:HasTag("VariantSFX") then
            descendant:Destroy();
        end;
    end;

    for _, descendant in p45:GetDescendants() do
        if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (descendant:HasTag("VariantVisual") or descendant:HasTag("RainbowPart")) then
            RevertPart(descendant);
        end;
    end;
end;

if RunService:IsServer() then
    CreateTagHandler({
        Tag = "PlantGenerated",

        OnInstanceAdded = function(p46: userdata) -- Line: 310, Name: OnInstanceAdded
            -- upvalues: u4 (copy)
            if p46:HasTag("Generating") then
                return;
            end;

            u4:SetVisuals(p46);
        end,

        OnInstanceRemoved = function(p47: userdata) -- Line: 314, Name: OnInstanceRemoved
            -- upvalues: u4 (copy)
            u4:ClearVisuals(p47);
        end
    });
end;

function u4.InsertRainbowFX(p48: userdata) -- Line: 323
    -- upvalues: u4 (copy), InsertEffects (copy), Rainbow_Reference (copy)
    if not (p48 and (p48:IsA("BasePart") or p48:IsA("UnionOperation"))) then
        return;
    end;

    u4.RemoveRainbowFX(p48);
    InsertEffects(p48, Rainbow_Reference, "Cleanup_RainbowClient");
end;

function u4.RemoveRainbowFX(p49: userdata) -- Line: 329
    if not p49 then
        return;
    end;

    for _, child in p49:GetChildren() do
        if child:HasTag("Cleanup_RainbowClient") then
            child:Destroy();
        end;
    end;
end;

return u4;