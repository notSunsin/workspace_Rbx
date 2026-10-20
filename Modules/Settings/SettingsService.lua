-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DataService = require(ReplicatedStorage.Modules.DataService);
local SettingsRegistry = require(ReplicatedStorage.Data.SettingsRegistry);
local SettingsService = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("SettingsService");

return {
    SetSetting = function(p1: table, p2: string, p3: any) -- Line: 11, Name: SetSetting
        -- upvalues: SettingsService (copy)
        SettingsService:FireServer("SetSetting", p2, p3);
    end,

    GetSetting = function(p4: table, p5: string) -- Line: 15, Name: GetSetting
        -- upvalues: DataService (copy), SettingsRegistry (copy)
        local Data = DataService:GetData();

        if Data then
            Data = Data.Settings;
        end;

        if Data then
            Data = Data[p5];
        end;

        if Data ~= nil then
            return Data;
        end;

        local v6 = SettingsRegistry[p5];

        return v6 and v6.SettingsData and v6.SettingsData.DefaultValue;
    end
};