-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local v1 = {
    Type = "HarvestAllMutations",
    RequireAll = true
};

local function DisplayNames(p2) -- Line: 11
    local v3 = "";

    for i, v in ipairs(p2) do
        if i == #p2 then
            v3 = v3 .. v;
        else
            v3 = v3 .. v .. ", ";
        end;
    end;

    return "[" .. v3 .. "]";
end;

function v1.Display(p4, p5, p6, p7) -- Line: 25
    -- upvalues: DisplayNames (copy)
    assert(p7, "Quest HarvestAllMutations doesn\'t have an argument.");

    return {
        Description = "The plant must have every mutation specified.",
        Title = `Harvest {p6} containing {DisplayNames(p7)} {#p7 > 1 and "Mutations" or "Mutation"}`,
        Bar = `{p5}/{p6}`
    };
end;

function v1.Use(p8, p9) -- Line: 35
    assert(p9.Arguments, "Plant quests needs arguments.");
    local table_clone_ret = table.clone(p9);
    table_clone_ret.Type = p8.Type;
    table_clone_ret.RequireAll = p8.RequireAll;

    return table_clone_ret;
end;

return v1;