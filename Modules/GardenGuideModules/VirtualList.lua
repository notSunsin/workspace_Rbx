-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GridCellHandler = require(ReplicatedStorage.Modules.GardenGuideModules.GridCellHandler);
require(ReplicatedStorage.Modules.GardenGuideModules.SortButtonsLogic);
require(ReplicatedStorage.Modules.GardenGuideModules.VirtualListGridCellCreator);
local TradePlazaIndexUICreator = require(ReplicatedStorage.Modules.TradePlaza.TradePlazaIndexUICreator);
local u1 = nil;
local u2 = {};
local u3 = {};
local u10 = {
    GardenGuide = function(p4, p5, p6) -- Line: 22
        -- upvalues: GridCellHandler (copy)
        return GridCellHandler.CreateGridCell(p4, p5, p6.DataType);
    end,

    TradePlazaIndex = function(p7, p8, p9) -- Line: 25
        -- upvalues: TradePlazaIndexUICreator (copy)
        return TradePlazaIndexUICreator.CreateGridCell(p7, p8, p9.GridType, p9);
    end
};
local u19 = {
    GardenGuide = function(p11, p12, p13, p14) -- Line: 31
        -- upvalues: GridCellHandler (copy)
        return GridCellHandler.RemakeGridCell(p11, p12, p13, p14.DataType);
    end,

    TradePlazaIndex = function(p15, p16, p17, p18) -- Line: 34
        -- upvalues: TradePlazaIndexUICreator (copy)
        return TradePlazaIndexUICreator.RemakeGridCell(p15, p16, p17, p18);
    end
};

local function CalculateCellSize(p20: number, p21: number, p22: number) -- Line: 39
    return (p21 - p22 * (p20 * 2)) / p20;
end;

return function(u23: userdata, u24: userdata, p25: any, p26: table?) -- Line: 44, Name: VirtualList
    -- upvalues: u2 (ref), u10 (copy), u3 (ref), u19 (copy), u1 (ref)
    for _, child in u23:GetChildren() do
        if child:IsA("Frame") or child:IsA("ImageButton") then
            child:Destroy();
        end;
    end;

    u2 = {};
    local u27 = not p26 and 7 or p26.ColumnCount;
    local v28 = math.ceil(#p25 / u27) + 1;
    local v29 = not p26 and 3 or p26.RowCount;
    local u30 = not p26 and 21 or p26.PoolSize;
    local u31 = u23.Name:gsub("Menu", "");
    local u32;

    if p26 then
        u32 = p26.GridType;
    else
        u32 = nil;
    end;

    local X = u23.AbsoluteSize.X;
    local Y = u23.AbsoluteSize.Y;
    local v33 = not p26 and 5 or p26.GapSize;
    local v34 = (X - v33 * (u27 * 2)) / u27;
    local v35 = v34 / X;
    local u36 = (Y - v33 * (v29 * 2)) / v29;
    local _ = u36 / Y;
    local v37 = 2 * v33 + v34;
    local v38 = 2 * v33 + u36;
    local v39 = 0;
    local v40 = 0;
    local v41 = 1;

    for i = 1, math.min(u30, #p25) do
        local v42 = {
            DataType = u31,
            GridType = u32
        };
        local v43 = u10[u32 or "GardenGuide"];
        local v44;

        if v43 then
            local v45 = v43(u23, p25[i], v42);
            v45.Size = UDim2.fromScale(v35, v35);
            local v46 = v37 / 2 + v39;
            local v47 = v38 / 2 + v40;
            v45.Position = UDim2.fromScale(v46 / X, v47 / Y);
            v39 = v46 + v37 / 2;
            v45.Parent = u23;
            table.insert(u2, v45);
            v41 = v41 + 1;

            if u27 < v41 then
                v40 = v47 + v38 / 2;
                v44 = i;
                v39 = 0;
                v41 = 1;
            else
                v44 = i;
            end;
        else
            v44 = i;
        end;
    end;

    u3 = p25;
    u24.CanvasSize = UDim2.new(0, 0, 0, v28 * u36);

    local function UpdateGrid() -- Line: 124
        -- upvalues: u24 (copy), u36 (copy), u27 (copy), u30 (copy), u3 (ref), u2 (ref), u31 (copy), u19 (ref), u32 (copy), u23 (copy)
        local v48 = (math.floor(u24.CanvasPosition.Y / u36) + 1 - 1) * u27 + 1;

        for i = 1, math.min(u30, #u3) do
            local v49 = u2[i];
            local v50 = v48 + (i - 1);
            local v51;

            if v50 <= #u3 then
                local v52 = {
                    DataType = u31,
                    ExistingCell = v49
                };
                local v53 = u19[u32 or "GardenGuide"];

                if v53 then
                    v53(v49, u23, u3[v50], v52);
                    v49.Visible = true;
                    v51 = i;
                else
                    v51 = i;
                end;
            else
                v49.Visible = false;
                v51 = i;
            end;
        end;
    end;

    if u1 then
        u1:Disconnect();
    end;

    u1 = u24:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 153
        -- upvalues: u24 (copy), UpdateGrid (copy)
        if not u24:FindFirstAncestorOfClass("ScreenGui").Enabled then
            return;
        end;

        UpdateGrid();
    end);
end;