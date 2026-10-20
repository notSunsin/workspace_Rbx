-- Decompiled with Potassium's decompiler.

return {
    DefaultInfGrowPlant = function(p1: table?) -- Line: 11, Name: DefaultInfGrowPlant
        local v2, v3, v4, v5, v6;

        if p1 then
            v2 = p1.CurrentWeight;
            v3 = p1.SubmissionCount;
            v4 = p1.PlantedTime;
            v5 = p1.FinishedGrowthTime;
            v6 = p1.AddedTime;
        else
            v2 = 0;
            v3 = 0;
            v4 = 0;
            v5 = 0;
            v6 = 0;
        end;

        return {
            CurrentWeight = v2,
            SubmissionCount = v3,
            PlantedTime = v4,
            FinishedGrowthTime = v5,
            AddedTime = v6
        };
    end
};