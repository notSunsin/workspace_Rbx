-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local DataService = require(ReplicatedStorage.Modules.DataService);
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local script_GlowTexture = script.GlowTexture;
local u1 = {
    Ancestors = {},
    FancyTextures = {}
};
local u2 = { "Front", "Back", "Right", "Left", "Top", "Bottom" };
local u3 = { "R", "G", "B" };
local Setting = SettingsService:GetSetting("Textures");

local function GetTextureColor(p4) -- Line: 40
    -- upvalues: u3 (copy)
    local v5 = {
        R = 0,
        G = 0,
        B = 0
    };
    local v6 = 0;
    local v7 = 0;

    for i = 1, #u3 do
        local v8 = u3[i];
        local v9 = p4[v8];
        v5[v8] = v9;
        local v10;

        if v6 < v9 then
            v7 = v8;
            v6 = v9;
            v10 = i;
        else
            v10 = i;
        end;
    end;

    v5[v7] = 25555;

    return Color3.new(v5.R, v5.G, v5.B);
end;

local function SetFancyGlowStatus(p11: userdata, p12: boolean) -- Line: 67
    -- upvalues: GetTextureColor (copy), u1 (copy), u2 (copy), script_GlowTexture (copy), TweenService (copy)
    if not p12 then
        if u1.FancyTextures[p11] then
            for _, v in u1.FancyTextures[p11] do
                TweenService:Create(v, TweenInfo.new(0.75), {
                    Transparency = 1
                }):Play();
                game.Debris:AddItem(v, 0.75);
            end;
        end;

        return;
    end;

    local v13 = GetTextureColor(p11.Color);

    if not u1.FancyTextures[p11] then
        u1.FancyTextures[p11] = {};
    end;

    for i = 1, #u2 do
        local v14 = script_GlowTexture:Clone();
        v14.Parent = p11;
        v14.Face = u2[i];
        v14.Color3 = v13;
        v14.Transparency = 1;
        TweenService:Create(v14, TweenInfo.new(0.5), {
            Transparency = 0.4
        }):Play();
        table.insert(u1.FancyTextures[p11], v14);
        local _ = i;
    end;
end;

local function HandleGlow(u15: userdata) -- Line: 96
    -- upvalues: u1 (copy), TweenService (copy), Setting (ref), SetFancyGlowStatus (copy)
    local u16 = u15:FindFirstAncestorWhichIsA("Model");

    if not u16 then
        return;
    end;

    u15:SetAttribute("BaseMaterial", u15.Material.Name);

    if u1.Ancestors[u16] then
        table.insert(u1.Ancestors[u16], u15);
    else
        u1.Ancestors[u16] = { u15 };
    end;

    u15.Touched:Connect(function(p17: userdata) -- Line: 109
        -- upvalues: u16 (copy), u15 (copy), TweenService (ref), u1 (ref), Setting (ref), SetFancyGlowStatus (ref)
        local Parent = p17.Parent;

        if not Parent then
            return;
        end;

        if not game.Players:GetPlayerFromCharacter(Parent) then
            return;
        end;

        local Age = u16:FindFirstChild("Age", true);

        if not Age then
            return;
        end;

        if Age.Value < tonumber(u15.Name) then
            return;
        end;

        if u16:GetAttribute("GlowToggled") then
            return;
        end;

        u16:SetAttribute("GlowToggled", true);
        local GlowLight = u16:FindFirstChild("GlowLight", true);

        if GlowLight then
            GlowLight.Brightness = 0;
            TweenService:Create(GlowLight, TweenInfo.new(0.3), {
                Brightness = 1
            }):Play();
        end;

        for _, v in u1.Ancestors[u16] do
            if Setting then
                SetFancyGlowStatus(v, true);
            else
                v.Material = "Neon";
            end;

            task.delay(8, function() -- Line: 133
                -- upvalues: v (copy), SetFancyGlowStatus (ref)
                v.Material = v:GetAttribute("BaseMaterial");
                SetFancyGlowStatus(v, false);
            end);
        end;

        task.wait(8);

        if GlowLight then
            TweenService:Create(GlowLight, TweenInfo.new(0.3), {
                Brightness = 0
            }):Play();
        end;

        task.wait(1);
        u16:SetAttribute("GlowToggled", false);
    end);
end;

CollectionService:GetInstanceAddedSignal("GlowPart"):Connect(function(p18) -- Line: 152
    -- upvalues: HandleGlow (copy)
    HandleGlow(p18);
end);
DataService:GetPathSignal("Settings/Textures"):Connect(function() -- Line: 156
    -- upvalues: Setting (ref), SettingsService (copy), u1 (copy), SetFancyGlowStatus (copy)
    Setting = SettingsService:GetSetting("Textures");

    if not Setting then
        for i, _ in u1.FancyTextures do
            SetFancyGlowStatus(i, false);
        end;
    end;
end);

return u1;