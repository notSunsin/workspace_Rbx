-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local ShopRankRegistry = require(ReplicatedStorage.Data.ShopRankRegistry);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local PetProducts = require(ReplicatedStorage.Modules.ShopController.PetProducts);
local ExoticPackData = require(ReplicatedStorage.Data.ExoticPackData);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local ShopRankingOpened = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("ShopRankingOpened");
local u1 = {};
local u2 = false;
local u3 = false;
local u4 = nil;
local u5 = {};
local u6 = {};
local u7 = 0;

local function getAuthored(p8: userdata) -- Line: 42
    -- upvalues: u5 (copy), u7 (ref), u6 (copy)
    local v9 = u5[p8];

    if v9 then
        return v9;
    end;

    local v10 = u7;
    u7 = u7 + 1;
    u5[p8] = v10;
    u6[p8] = p8.LayoutOrder;

    return v10;
end;

local function ruleFor(p11: string) -- Line: 55
    -- upvalues: ShopRankRegistry (copy)
    local v12 = ShopRankRegistry[p11];

    if v12 then
        return v12;
    end;

    if string.find(p11, "^ExoticPack") then
        return ShopRankRegistry.ExoticPack;
    end;

    if string.find(p11, "^Infinite") then
        return ShopRankRegistry.Infinite;
    end;

    return nil;
end;

local function resolveRep(p13) -- Line: 69
    -- upvalues: DevProductIds (copy), PetProducts (copy)
    if p13.ProductId then
        return p13.ProductId;
    end;

    if p13.Source == "DevProduct" then
        local v14 = p13.Key and DevProductIds[p13.Key];

        return v14 and v14.PurchaseID or nil;
    end;

    if p13.Source ~= "PetProducts" then
        return nil;
    end;

    local v15 = p13.Key and PetProducts[p13.Key];

    if v15 then
        v15 = v15[1];
    end;

    return v15 and v15.ProductId or nil;
end;

local u16 = {};
local u17 = {};

for _, v in ExoticPackData do
    if type(v) == "table" and (type(v.Title) == "string" and type(v.Products) == "table") then
        local v18 = v.Products[1];

        if v18 then
            u16[v.Title] = v18;
            table.insert(u17, v18);
        end;
    end;
end;

local function resolveExoticRep(p19: userdata) -- Line: 99
    -- upvalues: u16 (copy)
    local Title = p19:FindFirstChild("Title");

    if not (Title and Title:IsA("TextLabel")) then
        Title = p19:FindFirstChild("Title", true);
    end;

    if Title and Title:IsA("TextLabel") then
        return u16[Title.Text];
    end;

    return nil;
end;

local function computeRanking() -- Line: 110
    -- upvalues: ShopRankRegistry (copy), DevProductIds (copy), PetProducts (copy), u17 (copy), MarketplaceService (copy), RunService (copy), u1 (ref), u2 (ref)
    local u20 = {};
    local u21 = {};

    local function add(p22: number?) -- Line: 113
        -- upvalues: u20 (copy), u21 (copy)
        if p22 and not u20[p22] then
            u20[p22] = true;
            table.insert(u21, {
                InfoType = Enum.InfoType.Product,
                Id = p22
            });
        end;
    end;

    for _, v in ShopRankRegistry do
        if not v.Exclude then
            local v23;

            if v.ProductId then
                v23 = v.ProductId;
            elseif v.Source == "DevProduct" then
                local v24 = v.Key and DevProductIds[v.Key];
                v23 = v24 and v24.PurchaseID or nil;
            elseif v.Source == "PetProducts" then
                local v25 = v.Key and PetProducts[v.Key];

                if v25 then
                    v25 = v25[1];
                end;

                v23 = v25 and v25.ProductId or nil;
            else
                v23 = nil;
            end;

            if v23 and not u20[v23] then
                u20[v23] = true;
                table.insert(u21, {
                    InfoType = Enum.InfoType.Product,
                    Id = v23
                });
            end;
        end;
    end;

    for _, v in u17 do
        if v and not u20[v] then
            u20[v] = true;
            table.insert(u21, {
                InfoType = Enum.InfoType.Product,
                Id = v
            });
        end;
    end;

    if #u21 == 0 then
        return;
    end;

    local success, result = pcall(function() -- Line: 132
        -- upvalues: MarketplaceService (ref), u21 (copy)
        return MarketplaceService:RankProductsAsync(u21);
    end);

    if not success or typeof(result) ~= "table" then
        if RunService:IsStudio() then
            local v26 = {};

            for i, v in ipairs(u21) do
                v26[v.Id] = i;
            end;

            u1 = v26;
            u2 = true;
        end;

        return;
    end;

    local v27 = {};

    for i, v in ipairs(result) do
        local v28 = v.ProductIdentifier and v.ProductIdentifier.Id;

        if v28 then
            v27[v28] = i;
        end;
    end;

    u1 = v27;
    u2 = true;
end;

local function isVariant() -- Line: 160
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetAttribute("AB_ShopRankV2") == true;
end;

local function authoredLess(p29: userdata, p30: userdata) -- Line: 164
    -- upvalues: u6 (copy), u5 (copy)
    local v31 = u6[p29] or 0;
    local v32 = u6[p30] or 0;

    if v31 == v32 then
        return u5[p29] < u5[p30];
    end;

    return v31 < v32;
end;

local function applyOrder() -- Line: 172
    -- upvalues: u2 (ref), LocalPlayer (copy), u4 (ref), u5 (copy), u7 (ref), u6 (copy), ShopRankRegistry (copy), resolveExoticRep (copy), DevProductIds (copy), PetProducts (copy), u1 (ref), authoredLess (copy)
    if not (u2 and (LocalPlayer:GetAttribute("AB_ShopRankV2") == true and u4)) then
        return;
    end;

    local v33 = {};
    local v34 = {};
    local u35 = {};

    for _, child in u4:GetChildren() do
        if child:IsA("GuiObject") and child.Visible then
            if not u5[child] then
                local v36 = u7;
                u7 = u7 + 1;
                u5[child] = v36;
                u6[child] = child.LayoutOrder;
            end;

            local Name = child.Name;
            local v37 = ShopRankRegistry[Name];

            if not v37 then
                if string.find(Name, "^ExoticPack") then
                    v37 = ShopRankRegistry.ExoticPack;
                elseif string.find(Name, "^Infinite") then
                    v37 = ShopRankRegistry.Infinite;
                else
                    v37 = nil;
                end;
            end;

            if v37 and v37.Pinned then
                table.insert(v33, child);
            else
                table.insert(v34, child);

                if v37 and not v37.Exclude then
                    local v38;

                    if v37.Source == "ExoticTitle" then
                        v38 = resolveExoticRep(child);
                    elseif v37.ProductId then
                        v38 = v37.ProductId;
                    elseif v37.Source == "DevProduct" then
                        local v39 = v37.Key and DevProductIds[v37.Key];
                        v38 = v39 and v39.PurchaseID or nil;
                    elseif v37.Source == "PetProducts" then
                        local v40 = v37.Key and PetProducts[v37.Key];

                        if v40 then
                            v40 = v40[1];
                        end;

                        v38 = v40 and v40.ProductId or nil;
                    else
                        v38 = nil;
                    end;

                    if v38 then
                        v38 = u1[v38];
                    end;

                    if v38 then
                        u35[child] = v38;
                    end;
                end;
            end;
        end;
    end;

    table.sort(v33, authoredLess);
    table.sort(v34, authoredLess);
    local v41 = {};

    for _, v in v34 do
        if u35[v] then
            table.insert(v41, v);
        end;
    end;

    table.sort(v41, function(p42, p43) -- Line: 222
        -- upvalues: u35 (copy), u6 (ref), u5 (ref)
        local v44 = u35[p42];
        local v45 = u35[p43];

        if v44 ~= v45 then
            return v44 < v45;
        end;

        local v46 = u6[p42] or 0;
        local v47 = u6[p43] or 0;

        if v46 == v47 then
            return u5[p42] < u5[p43];
        end;

        return v46 < v47;
    end);
    local v48 = 0;

    for _, v in v33 do
        v.LayoutOrder = v48;
        v48 = v48 + 1;
    end;

    local v49 = 1;

    for _, v in v34 do
        local v50;

        if u35[v] then
            v50 = v41[v49];
            v49 = v49 + 1;
        else
            v50 = v;
        end;

        v50.LayoutOrder = v48;
        v48 = v48 + 1;
    end;
end;

local v53 = {
    Start = function(p51) -- Line: 249, Name: Start
        -- upvalues: computeRanking (copy), u2 (ref), applyOrder (copy), PlayerGui (copy), u4 (ref), GuiController (copy), u3 (ref), ShopRankingOpened (copy), LocalPlayer (copy)
        task.spawn(function() -- Line: 250
            -- upvalues: computeRanking (ref), u2 (ref), applyOrder (ref)
            computeRanking();

            if not u2 then
                task.wait(5);
                computeRanking();

                if not u2 then
                    task.wait(5);
                end;
            end;

            applyOrder();
        end);
        local Shop_UI = PlayerGui:WaitForChild("Shop_UI");
        local ScrollingFrame = Shop_UI:WaitForChild("Frame"):WaitForChild("ScrollingFrame");
        u4 = ScrollingFrame;
        GuiController:GetStateForGui(Shop_UI).Visible:Observe(function(p52: boolean) -- Line: 266
            -- upvalues: u3 (ref), ShopRankingOpened (ref), applyOrder (ref)
            if not p52 then
                return;
            end;

            if not u3 then
                u3 = true;
                ShopRankingOpened:FireServer();
            end;

            applyOrder();
        end);
        LocalPlayer:GetAttributeChangedSignal("AB_ShopRankV2"):Connect(function() -- Line: 277
            -- upvalues: applyOrder (ref)
            applyOrder();
        end);
        ScrollingFrame.ChildAdded:Connect(function() -- Line: 281
            -- upvalues: applyOrder (ref)
            applyOrder();
        end);
    end
};
task.spawn(v53.Start, v53);

return v53;