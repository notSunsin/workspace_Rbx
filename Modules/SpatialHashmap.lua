-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

local function RoundToNearestNumber(p2: number, p3: number) -- Line: 6
    return math.floor(p2 / p3 + 0.5) * p3;
end;

function u1.new(p4: table) -- Line: 12
    -- upvalues: u1 (copy)
    local v5 = setmetatable({}, u1);
    v5.Scale = p4.Scale;
    v5.Mode = p4.Mode or "Vector3";
    v5.Nodes = {};

    return v5;
end;

function u1.NormalizePosition(p6, p7) -- Line: 21
    local Mode = p6.Mode;

    if typeof(p7) ~= Mode then
        return error(`HashMap expected {Mode}, but got {p7}`, 2);
    end;

    local Scale = p6.Scale;
    local v8 = Mode == "Vector2" and Vector2.new(math.floor(p7.X / Scale + 0.5) * Scale, math.floor(p7.Y / Scale + 0.5) * Scale);

    if not v8 then
        local v9 = math.floor(p7.X / Scale + 0.5) * Scale;
        local v10 = math.floor(p7.Y / Scale + 0.5) * Scale;
        local v11 = math.floor(p7.Z / Scale + 0.5) * Scale;
        v8 = Vector3.new(v9, v10, v11);
    end;

    return v8;
end;

function u1.ClearNeighbors(p12: table, p13: table) -- Line: 40
    local Mode = p12.Mode;
    local Scale = p12.Scale;
    local Nodes = p12.Nodes;
    local v14 = math.floor(p13.Range / Scale + 0.5) * Scale * Scale;
    local v15 = p12:NormalizePosition(p13.Position);
    local X = v15.X;
    local Y = v15.Y;
    local v16;

    if Mode == "Vector3" then
        v16 = v15.Z;
    else
        v16 = false;
    end;

    local v17 = X - v14;
    local v18 = Y - v14;
    local v19;

    if Mode == "Vector3" then
        v19 = v16 - v14;
    else
        v19 = false;
    end;

    local v20 = X + v14;
    local v21 = Y + v14;
    local v22;

    if Mode == "Vector3" then
        v22 = v16 + v14;
    else
        v22 = false;
    end;

    if Mode == "Vector2" then
        for i = v17, v20, Scale do
            local v23 = Nodes[i];
            local v24;

            if v23 then
                v24 = i;

                for i2 = v18, v21, Scale do
                    local v25 = v23[i2];
                    local v26;

                    if v25 then
                        table.clear(v25);
                        v26 = i2;
                    else
                        v26 = i2;
                    end;
                end;
            else
                v24 = i;
            end;
        end;

        return;
    end;

    for i = v17, v20, Scale do
        local v27 = Nodes[i];
        local v28;

        if v27 then
            v28 = i;

            for i2 = v18, v21, Scale do
                local v29 = v27[i2];
                local v30;

                if v29 then
                    v30 = i2;

                    for i3 = v19, v22, Scale do
                        local v31 = v29[i3];
                        local v32;

                        if v31 then
                            table.clear(v31);
                            v32 = i3;
                        else
                            v32 = i3;
                        end;
                    end;
                else
                    v30 = i2;
                end;
            end;
        else
            v28 = i;
        end;
    end;
end;

function u1.GetTableFor(p33, p34) -- Line: 84
    local v35 = p33:NormalizePosition(p34);
    local Nodes = p33.Nodes;
    local Mode = p33.Mode;
    local X = v35.X;
    local Y = v35.Y;
    local v36;

    if Mode == "Vector3" then
        v36 = v35.Z;
    else
        v36 = false;
    end;

    if Mode == "Vector2" then
        if not Nodes[X] then
            Nodes[X] = {};
        end;

        if not Nodes[X][Y] then
            Nodes[X][Y] = {};
        end;

        return Nodes[X][Y];
    end;

    if Mode == "Vector3" then
        if not Nodes[X] then
            Nodes[X] = {};
        end;

        if not Nodes[X][Y] then
            Nodes[X][Y] = {};
        end;

        if not Nodes[X][Y][v36] then
            Nodes[X][Y][v36] = {};
        end;

        return Nodes[X][Y][v36];
    end;
end;

function u1.Insert(p37: table, p38: table) -- Line: 120
    local TableFor = p37:GetTableFor(p38.Position);
    table.insert(TableFor, p38.Hashed);
end;

function u1.Remove(p39: table, p40: table) -- Line: 125
    local TableFor = p39:GetTableFor(p40.Position);
    local table_find_ret = table.find(TableFor, p40.Hashed);

    if table_find_ret then
        table.remove(TableFor, table_find_ret);
    end;
end;

function u1.GetNeighbors(p41: table, p42: table) -- Line: 133
    local v43 = {};
    local Mode = p41.Mode;
    local Scale = p41.Scale;
    local Nodes = p41.Nodes;
    local v44 = math.floor(p42.Range / Scale + 0.5) * Scale * Scale;
    local v45 = p41:NormalizePosition(p42.Position);
    local X = v45.X;
    local Y = v45.Y;
    local v46;

    if Mode == "Vector3" then
        v46 = v45.Z;
    else
        v46 = false;
    end;

    local v47 = X - v44;
    local v48 = Y - v44;
    local v49;

    if Mode == "Vector3" then
        v49 = v46 - v44;
    else
        v49 = false;
    end;

    local v50 = X + v44;
    local v51 = Y + v44;
    local v52;

    if Mode == "Vector3" then
        v52 = v46 + v44;
    else
        v52 = false;
    end;

    if Mode == "Vector2" then
        for i = v47, v50, Scale do
            local v53 = Nodes[i];
            local v54;

            if v53 then
                v54 = i;

                for i2 = v48, v51, Scale do
                    local v55 = v53[i2];
                    local v56;

                    if v55 then
                        v56 = i2;

                        for _, v in v55 do
                            table.insert(v43, v);
                        end;
                    else
                        v56 = i2;
                    end;
                end;
            else
                v54 = i;
            end;
        end;

        return v43;
    end;

    for i = v47, v50, Scale do
        local v57 = Nodes[i];
        local v58;

        if v57 then
            v58 = i;

            for i2 = v48, v51, Scale do
                local v59 = v57[i2];
                local v60;

                if v59 then
                    v60 = i2;

                    for i3 = v49, v52, Scale do
                        local v61 = v59[i3];
                        local v62;

                        if v61 then
                            v62 = i3;

                            for _, v in v61 do
                                table.insert(v43, v);
                            end;
                        else
                            v62 = i3;
                        end;
                    end;
                else
                    v60 = i2;
                end;
            end;
        else
            v58 = i;
        end;
    end;

    return v43;
end;

function u1.GetOne(p63: table, p64: table) -- Line: 185
    local Mode = p63.Mode;
    local Scale = p63.Scale;
    local Nodes = p63.Nodes;
    local v65 = math.floor(p64.Range / Scale + 0.5) * Scale * Scale;
    local v66 = p63:NormalizePosition(p64.Position);
    local X = v66.X;
    local Y = v66.Y;
    local v67;

    if Mode == "Vector3" then
        v67 = v66.Z;
    else
        v67 = false;
    end;

    local v68 = X - v65;
    local v69 = Y - v65;
    local v70;

    if Mode == "Vector3" then
        v70 = v67 - v65;
    else
        v70 = false;
    end;

    local v71 = X + v65;
    local v72 = Y + v65;
    local v73;

    if Mode == "Vector3" then
        v73 = v67 + v65;
    else
        v73 = false;
    end;

    if Mode == "Vector2" then
        for i = v68, v71, Scale do
            local v74 = Nodes[i];
            local v75;

            if v74 then
                v75 = i;

                for i2 = v69, v72, Scale do
                    local v76 = v74[i2];

                    if v76 then
                        local _, v77 = next(v76);

                        return v77;
                    end;

                    local _ = i2;
                end;
            else
                v75 = i;
            end;
        end;

        return;
    end;

    for i = v68, v71, Scale do
        local v78 = Nodes[i];
        local v79;

        if v78 then
            v79 = i;

            for i2 = v69, v72, Scale do
                local v80 = v78[i2];
                local v81;

                if v80 then
                    v81 = i2;

                    for i3 = v70, v73, Scale do
                        local v82 = v80[i3];

                        if v82 then
                            local _, v83 = next(v82);

                            return v83;
                        end;

                        local _ = i3;
                    end;
                else
                    v81 = i2;
                end;
            end;
        else
            v79 = i;
        end;
    end;
end;

return u1;