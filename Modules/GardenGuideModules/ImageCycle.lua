-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Data.AchievementsData.Types);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
require(ReplicatedStorage.Data.SeasonPass.SeasonPassData);
local PetList = require(ReplicatedStorage.Data.PetRegistry.PetList);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local u1 = {};
local v2 = {};

local function IsUIRendered(p3: userdata) -- Line: 17
    local v4 = p3:FindFirstAncestorOfClass("ScreenGui");

    if v4 and not v4.Enabled then
        return false;
    end;

    while p3 do
        if p3:IsA("GuiObject") and p3.Visible == false then
            return false;
        end;

        if not p3.Parent then
            break;
        end;

        p3 = p3.Parent;
    end;

    return true;
end;

local function Cycle(u5: userdata, u6: userdata, u7: any, u8: any) -- Line: 41
    -- upvalues: TweenService (copy), u1 (copy), IsUIRendered (copy)
    return task.spawn(function() -- Line: 42
        -- upvalues: TweenService (ref), u1 (ref), u7 (copy), IsUIRendered (ref), u8 (copy), u6 (ref), u5 (ref)
        local Linear = Enum.EasingStyle.Linear;
        TweenInfo.new(0.5, Linear);
        local u9 = {};

        local function createFadeTweens(p10: any, p11: any, p12: string) -- Line: 48
            -- upvalues: TweenService (ref), Linear (copy), u9 (ref)
            local v13 = TweenService:Create(p10, TweenInfo.new(0.5, Linear), {
                [p12] = 1
            });
            local v14 = TweenService:Create(p11, TweenInfo.new(0.5, Linear), {
                [p12] = 0
            });
            table.insert(u9, v13);
            table.insert(u9, v14);
        end;

        local v15 = 1;

        while u1[u7.Name] do
            task.wait(1);

            if u7.Visible and IsUIRendered(u7) then
                local v16 = u8[v15];

                if v16 then
                    u9 = {};

                    if u6:IsA("ImageLabel") then
                        u6.Image = v16;
                        u6.ImageTransparency = 1;
                        createFadeTweens(u5, u6, "ImageTransparency");
                    elseif u6:IsA("TextLabel") then
                        u6.Text = u8[v15];
                        u6.TextTransparency = 1;
                        createFadeTweens(u5, u6, "TextTransparency");
                        local UIStroke = u5:FindFirstChild("UIStroke");
                        local UIStroke2 = u6:FindFirstChild("UIStroke");

                        if UIStroke and UIStroke2 then
                            UIStroke2.Transparency = 1;
                            createFadeTweens(UIStroke, UIStroke2, "Transparency");
                        end;
                    end;

                    for _, v in u9 do
                        v:Play();
                    end;

                    task.wait(0.5);
                    local v17 = u5;
                    u5 = u6;
                    u6 = v17;
                    v15 = math.max((v15 + 1) % (#u8 + 1), 1);

                    if #u8 == 1 then
                        task.wait(1);
                        u5.Name = u6.Name;
                        u6:Destroy();
                        break;
                    end;
                end;
            else
                task.wait(1);
            end;
        end;
    end);
end;

local function SplitWordWithSpace(p18: string) -- Line: 112
    if #string.split(p18, " ") > 1 then
        return p18;
    end;

    return p18:gsub("(%u%l*)", function(p19) -- Line: 118
        return p19 .. " ";
    end):match("^%s*(.-)%s*$");
end;

local function GetRewardImages(p20: table, p21: boolean?) -- Line: 123
    -- upvalues: ItemNameFinder (copy), SplitWordWithSpace (copy), PetList (copy), SeedData (copy), ItemImageFinder (copy)
    local v22 = {};
    local v23 = {};

    for _, v in p20 do
        if v.Type ~= "XP" then
            local v24 = v.DisplayName or ItemNameFinder(v.Value, v.Type);
            local _ = v.Type;
            local v25 = v.Quantity <= 1 and "" or ` x{v.Quantity}`;
            local v26 = `{not v.Variant and "" or `{v.Variant} `}{SplitWordWithSpace(v24)}{v25}`;
            local v27 = nil;

            if p21 then
                if v.Type == "Pet" then
                    if PetList[v.Value] then
                        v27 = PetList[v.Value].SeasonPassIcon or PetList[v.Value].Icon;
                    end;
                elseif v.Type == "Seed" and SeedData[v.Value] then
                    v27 = SeedData[v.Value].FruitIcon;
                    table.insert(v23, SeedData[v.Value].Asset);
                    table.insert(v22, v26);
                end;
            end;

            local v28 = v27 or ItemImageFinder(v.Value, v.Type);
            table.insert(v23, v28);
            table.insert(v22, v26);
        end;
    end;

    return v23, v22;
end;

function v2.CycleRewardImages(p29: userdata, p30: userdata?, p31: userdata?, u32: userdata, p33: table, p34: boolean?) -- Line: 168
    -- upvalues: GetRewardImages (copy), u1 (copy), TweenService (copy), IsUIRendered (copy)
    local u35, u36 = GetRewardImages(p33, p34);

    local function createSecondLabel(p37: userdata) -- Line: 180
        -- upvalues: u32 (copy)
        local v38 = u32:FindFirstChild((`{p37.Name}B`));

        if not v38 then
            v38 = p37:Clone();
            v38.Name = `{p37.Name}B`;
            v38.Parent = p37.Parent;
        end;

        return p37, v38;
    end;

    if not u1[u32.Name] then
        u1[u32.Name] = true;
        local v39 = u32:FindFirstChild((`{p29.Name}B`));

        if not v39 then
            v39 = p29:Clone();
            v39.Name = `{p29.Name}B`;
            v39.Parent = p29.Parent;
        end;

        local u40 = p29;
        local u41 = v39;
        task.spawn(function() -- Line: 42
            -- upvalues: TweenService (ref), u1 (ref), u32 (copy), IsUIRendered (ref), u35 (copy), u41 (ref), u40 (ref)
            local Linear = Enum.EasingStyle.Linear;
            TweenInfo.new(0.5, Linear);
            local u42 = {};

            local function v48(p43: any, p44: any, p45: string) -- Line: 48
                -- upvalues: TweenService (ref), Linear (copy), u42 (ref)
                local v46 = TweenService:Create(p43, TweenInfo.new(0.5, Linear), {
                    [p45] = 1
                });
                local v47 = TweenService:Create(p44, TweenInfo.new(0.5, Linear), {
                    [p45] = 0
                });
                table.insert(u42, v46);
                table.insert(u42, v47);
            end;

            local v49 = 1;

            while u1[u32.Name] do
                task.wait(1);

                if u32.Visible and IsUIRendered(u32) then
                    local v50 = u35[v49];

                    if v50 then
                        u42 = {};

                        if u41:IsA("ImageLabel") then
                            u41.Image = v50;
                            u41.ImageTransparency = 1;
                            v48(u40, u41, "ImageTransparency");
                        elseif u41:IsA("TextLabel") then
                            u41.Text = u35[v49];
                            u41.TextTransparency = 1;
                            v48(u40, u41, "TextTransparency");
                            local UIStroke = u40:FindFirstChild("UIStroke");
                            local UIStroke2 = u41:FindFirstChild("UIStroke");

                            if UIStroke and UIStroke2 then
                                UIStroke2.Transparency = 1;
                                v48(UIStroke, UIStroke2, "Transparency");
                            end;
                        end;

                        for _, v in u42 do
                            v:Play();
                        end;

                        task.wait(0.5);
                        local v51 = u40;
                        u40 = u41;
                        u41 = v51;
                        v49 = math.max((v49 + 1) % (#u35 + 1), 1);

                        if #u35 == 1 then
                            task.wait(1);
                            u40.Name = u41.Name;
                            u41:Destroy();
                            break;
                        end;
                    end;
                else
                    task.wait(1);
                end;
            end;
        end);

        if #u36 > 0 then
            if p30 then
                local v52 = u32:FindFirstChild((`{p30.Name}B`));

                if not v52 then
                    v52 = p30:Clone();
                    v52.Name = `{p30.Name}B`;
                    v52.Parent = p30.Parent;
                end;

                local u53 = p30;
                local u54 = v52;
                task.spawn(function() -- Line: 42
                    -- upvalues: TweenService (ref), u1 (ref), u32 (copy), IsUIRendered (ref), u36 (copy), u54 (ref), u53 (ref)
                    local Linear = Enum.EasingStyle.Linear;
                    TweenInfo.new(0.5, Linear);
                    local u55 = {};

                    local function v61(p56: any, p57: any, p58: string) -- Line: 48
                        -- upvalues: TweenService (ref), Linear (copy), u55 (ref)
                        local v59 = TweenService:Create(p56, TweenInfo.new(0.5, Linear), {
                            [p58] = 1
                        });
                        local v60 = TweenService:Create(p57, TweenInfo.new(0.5, Linear), {
                            [p58] = 0
                        });
                        table.insert(u55, v59);
                        table.insert(u55, v60);
                    end;

                    local v62 = 1;

                    while u1[u32.Name] do
                        task.wait(1);

                        if u32.Visible and IsUIRendered(u32) then
                            local v63 = u36[v62];

                            if v63 then
                                u55 = {};

                                if u54:IsA("ImageLabel") then
                                    u54.Image = v63;
                                    u54.ImageTransparency = 1;
                                    v61(u53, u54, "ImageTransparency");
                                elseif u54:IsA("TextLabel") then
                                    u54.Text = u36[v62];
                                    u54.TextTransparency = 1;
                                    v61(u53, u54, "TextTransparency");
                                    local UIStroke = u53:FindFirstChild("UIStroke");
                                    local UIStroke2 = u54:FindFirstChild("UIStroke");

                                    if UIStroke and UIStroke2 then
                                        UIStroke2.Transparency = 1;
                                        v61(UIStroke, UIStroke2, "Transparency");
                                    end;
                                end;

                                for _, v in u55 do
                                    v:Play();
                                end;

                                task.wait(0.5);
                                local v64 = u53;
                                u53 = u54;
                                u54 = v64;
                                v62 = math.max((v62 + 1) % (#u36 + 1), 1);

                                if #u36 == 1 then
                                    task.wait(1);
                                    u53.Name = u54.Name;
                                    u54:Destroy();
                                    break;
                                end;
                            end;
                        else
                            task.wait(1);
                        end;
                    end;
                end);
            end;

            if p31 then
                local v65 = u32:FindFirstChild((`{p31.Name}B`));

                if not v65 then
                    v65 = p31:Clone();
                    v65.Name = `{p31.Name}B`;
                    v65.Parent = p31.Parent;
                end;

                local u66 = p31;
                local u67 = v65;
                task.spawn(function() -- Line: 42
                    -- upvalues: TweenService (ref), u1 (ref), u32 (copy), IsUIRendered (ref), u36 (copy), u67 (ref), u66 (ref)
                    local Linear = Enum.EasingStyle.Linear;
                    TweenInfo.new(0.5, Linear);
                    local u68 = {};

                    local function v74(p69: any, p70: any, p71: string) -- Line: 48
                        -- upvalues: TweenService (ref), Linear (copy), u68 (ref)
                        local v72 = TweenService:Create(p69, TweenInfo.new(0.5, Linear), {
                            [p71] = 1
                        });
                        local v73 = TweenService:Create(p70, TweenInfo.new(0.5, Linear), {
                            [p71] = 0
                        });
                        table.insert(u68, v72);
                        table.insert(u68, v73);
                    end;

                    local v75 = 1;

                    while u1[u32.Name] do
                        task.wait(1);

                        if u32.Visible and IsUIRendered(u32) then
                            local v76 = u36[v75];

                            if v76 then
                                u68 = {};

                                if u67:IsA("ImageLabel") then
                                    u67.Image = v76;
                                    u67.ImageTransparency = 1;
                                    v74(u66, u67, "ImageTransparency");
                                elseif u67:IsA("TextLabel") then
                                    u67.Text = u36[v75];
                                    u67.TextTransparency = 1;
                                    v74(u66, u67, "TextTransparency");
                                    local UIStroke = u66:FindFirstChild("UIStroke");
                                    local UIStroke2 = u67:FindFirstChild("UIStroke");

                                    if UIStroke and UIStroke2 then
                                        UIStroke2.Transparency = 1;
                                        v74(UIStroke, UIStroke2, "Transparency");
                                    end;
                                end;

                                for _, v in u68 do
                                    v:Play();
                                end;

                                task.wait(0.5);
                                local v77 = u66;
                                u66 = u67;
                                u67 = v77;
                                v75 = math.max((v75 + 1) % (#u36 + 1), 1);

                                if #u36 == 1 then
                                    task.wait(1);
                                    u66.Name = u67.Name;
                                    u67:Destroy();
                                    break;
                                end;
                            end;
                        else
                            task.wait(1);
                        end;
                    end;
                end);
            end;
        end;
    end;

    u32.Destroying:Once(function() -- Line: 213
        -- upvalues: u1 (ref), u32 (copy)
        u1[u32.Name] = nil;
    end);
end;

return v2;