-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ContentProvider = game:GetService("ContentProvider");
game:GetService("RunService");
local Players = game:GetService("Players");
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local IsDev = require(ReplicatedStorage.Modules.IsDev);
local u1 = {
    [script.SeedObby] = "Instance",
    [script.MeteorImpact] = "Instance",
    [script.GlassObby] = "Instance",
    [script.DiscoFestival] = "Instance",
    [script.jandel] = "Instance",
    [script.jandelFloat] = "Instance",
    ["74100090243310"] = "Sound",
    [script.jandelStorm] = "Instance",
    ["142376088"] = "Sound",
    [script.underTheSea] = "Instance",
    ["84171656137056"] = "Sound",
    ["99445078556609"] = "Sound",
    ["1846552051"] = "Sound",
    ["9125402735"] = "Sound",
    ["1542459939"] = "Sound",
    ["122907949849153"] = "Sound",
    [script.jandelHammer] = "Instance",
    ["80584356758887"] = "Sound",
    ["9117985663"] = "Sound",
    ["75213214992269"] = "Sound",
    ["1079408535"] = "Sound",
    [script.jandelKatana] = "Instance",
    [script.volcano] = "Instance",
    ["121762378458854"] = "Sound",
    ["89910008498080"] = "Sound",
    ["93514478924854"] = "Sound",
    ["138129472843424"] = "Sound",
    ["81271421661459"] = "Sound",
    ["84265920549272"] = "Sound",
    ["1848052307"] = "Sound",
    ["3981355300"] = "Sound",
    ["8292289200"] = "Sound",
    [script.stoplight] = "Instance",
    ["131438286776408"] = "Sound",
    ["103750154394322"] = "Sound",
    ["97711263230645"] = "Sound",
    ["96736432929535"] = "Sound",
    ["105215331534171"] = "Sound",
    ["80820991520058"] = "Sound",
    ["125718385982992"] = "Sound",
    ["117093826727273"] = "Sound",
    ["116689943122507"] = "Sound",
    ["12222253"] = "Sound",
    ["115766119628419"] = "Sound",
    [script.BoomboxParty] = "Instance",
    ["6883650972"] = "Sound",
    ["1846368080"] = "Sound",
    ["6586979979"] = "Sound",
    ["9064263922"] = "Sound",
    ["3165700530"] = "Sound",
    [script.Tsunami] = "Instance",
    ["687874741"] = "Sound",
    ["126520360641941"] = "Sound",
    ["129550333091181"] = "Sound",
    ["120203977334120"] = "Sound",
    ["8493073620"] = "Sound",
    ["132933848310796"] = "Sound",
    ["127162522205233"] = "Sound",
    ["88681038076429"] = "Sound",
    [script.GiantSwordPull] = "Instance",
    ["9128724164"] = "Sound",
    ["1847184317"] = "Sound",
    ["6270529350"] = "Sound",
    ["6680960510"] = "Sound",
    ["9114428742"] = "Sound",
    ["9116638811"] = "Sound",
    ["9119482201"] = "Sound",
    ["9116673944"] = "Sound",
    ["238895410"] = "Sound",
    ["6860710840"] = "Sound",
    ["112797079504478"] = "Sound",
    ["107467482558699"] = "Sound",
    ["9047876673"] = "Sound",
    [script.RestockFever] = "Instance",
    ["1842150599"] = "Sound",
    ["1848059186"] = "Sound",
    ["1846627640"] = "Sound",
    ["1846627694"] = "Sound",
    ["93808705439016"] = "Sound",
    ["6670092634"] = "Sound",
    ["71284123166666"] = "Sound",
    ["78351662589992"] = "Sound",
    ["9126201834"] = "Sound",
    ["5189782994"] = "Sound",
    ["9118772469"] = "Sound",
    ["8927189937"] = "Sound",
    ["9085909202"] = "Sound",
    ["9116406610"] = "Sound"
};
local u7 = {
    Instances = {},

    CreateInstance = function(p2: table, p3: any, p4: string) -- Line: 314, Name: CreateInstance
        if p4 ~= "Sound" then
            if p4 ~= "Instance" then
                warn((`Unsupported asset type in Preload list: {p4} ({p3})`));

                return nil;
            end;

            local v5 = typeof(p3) == "Instance";
            assert(v5);

            return p3:GetChildren();
        end;

        local v6 = type(p3) == "string";
        assert(v6);
        local Sound = Instance.new("Sound");
        Sound.Volume = 0;

        if not string.find(p3, "rbxassetid") then
            p3 = `rbxassetid://{p3}`;
        end;

        Sound.SoundId = p3;

        return Sound;
    end
};

function u7.Start(p8) -- Line: 332
    -- upvalues: Players (copy), IsDev (copy), UpdateService (copy), u1 (copy), u7 (copy), ContentProvider (copy)
    local v9 = Random.new(Players.LocalPlayer.UserId):NextInteger(50, 130);
    local v10 = Random.new(Players.LocalPlayer.UserId):NextInteger(2, 3);

    if IsDev() then
        table.clear(u1);

        return;
    end;

    if UpdateService:IsUpdateDone() then
        table.clear(u1);

        for _, child in script:GetChildren() do
            xpcall(function() -- Line: 344
                -- upvalues: child (copy)
                child:Destroy();
            end, warn);
        end;

        return;
    end;

    while UpdateService:GetRemainingTimeUntilUpdate() > 60 * v9 do
        task.wait(1);
    end;

    local v11 = 0;

    for i, v in u1 do
        local v12 = u7:CreateInstance(i, v);

        if type(v12) == "table" then
            for _, v2 in v12 do
                xpcall(function() -- Line: 365
                    -- upvalues: ContentProvider (ref), v2 (copy)
                    ContentProvider:PreloadAsync({ v2 });
                end, warn);
                v2:Destroy();
                v11 = v11 + 1;
                task.wait(v10);
            end;
        elseif v12 ~= nil then
            xpcall(function() -- Line: 376
                -- upvalues: ContentProvider (ref), i (copy)
                ContentProvider:PreloadAsync({ i });
            end, warn);
            v12:Destroy();
            v11 = v11 + 1;
            task.wait(v10);
        end;
    end;

    table.clear(u1);
end;

task.spawn(u7.Start, u7);

return nil;