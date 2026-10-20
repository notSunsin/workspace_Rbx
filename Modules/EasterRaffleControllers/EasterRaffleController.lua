-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return {
    GetRaffleDataAsync = function(p1) -- Line: 17, Name: GetRaffleDataAsync
        -- upvalues: ReplicatedStorage (copy)
        return ReplicatedStorage.GameEvents.EasterRaffleService.GetRaffleDataAsync:InvokeServer();
    end,

    GetPlayerRaffleDataAsync = function(p2) -- Line: 21, Name: GetPlayerRaffleDataAsync
        -- upvalues: ReplicatedStorage (copy)
        return ReplicatedStorage.GameEvents.EasterRaffleService.GetPlayerRaffleDataAsync:InvokeServer();
    end,

    SubmitEgg = function(p3) -- Line: 25, Name: SubmitEgg
        -- upvalues: ReplicatedStorage (copy)
        ReplicatedStorage.GameEvents.EasterRaffleService.SubmitEgg:FireServer();
    end
};