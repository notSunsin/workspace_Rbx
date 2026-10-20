-- Decompiled with Potassium's decompiler.

local LocalizationService = game:GetService("LocalizationService");
local PlayerGui = game.Players.LocalPlayer.PlayerGui;
PlayerGui:WaitForChild("BackpackGui");
local Players = game:GetService("Players");
local u1 = nil;

if Players.LocalPlayer == nil then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait();
end;

local u2 = nil;

local function getTranslator() -- Line: 18
    -- upvalues: u2 (ref), PlayerGui (copy), LocalizationService (copy)
    if u2 == nil then
        u2 = PlayerGui.CoreScriptLocalization:GetTranslator(LocalizationService.RobloxLocaleId);
    end;

    return u2;
end;

local u3 = {};

local function getTranslatorForLocale(p4) -- Line: 28
    -- upvalues: u3 (copy), PlayerGui (copy)
    local v5 = u3[p4];

    if v5 then
        return v5;
    end;

    local Translator = PlayerGui.CoreScriptLocalization:GetTranslator(p4);
    u3[p4] = Translator;

    return Translator;
end;

local function formatByKeyWithFallback(u6, u7, u8) -- Line: 40
    -- upvalues: u1 (ref)
    local success, result = pcall(function() -- Line: 41
        -- upvalues: u8 (copy), u6 (copy), u7 (copy)
        return u8:FormatByKey(u6, u7);
    end);

    if success then
        return result;
    end;

    return u1:FormatByKey(u6, u7);
end;

return {
    FormatByKey = function(p9, p10, p11) -- Line: 54, Name: FormatByKey
        -- upvalues: u2 (ref), PlayerGui (copy), LocalizationService (copy)
        if u2 == nil then
            u2 = PlayerGui.CoreScriptLocalization:GetTranslator(LocalizationService.RobloxLocaleId);
        end;

        return u2:FormatByKey(p10, p11);
    end,

    FormatByKeyForLocale = function(p12, p13, p14, p15) -- Line: 62, Name: FormatByKeyForLocale
        -- upvalues: u3 (copy), PlayerGui (copy)
        local v16 = u3[p14];

        if not v16 then
            v16 = PlayerGui.CoreScriptLocalization:GetTranslator(p14);
            u3[p14] = v16;
        end;

        return v16:FormatByKey(p13, p15);
    end
};