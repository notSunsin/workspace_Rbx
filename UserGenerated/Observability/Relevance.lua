-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Styles = require(ReplicatedStorage.UserGenerated.Observability.Styles);
local _, v1 = xpcall(function() -- Line: 27
    return workspace[nil];
end, function() -- Line: 29
    return debug.info(2, "f");
end);
local u4 = type(v1) ~= "function" and function(p2, p3) -- Line: 33
    return p2[p3];
end or v1;
local Get = Styles.Get;
local u5 = {
    ShownBy = table.freeze({
        Visible = true,
        Enabled = true,
        Adornee = true
    })
};
local table_freeze_ret = table.freeze({
    Position = true,
    AnchorPoint = true
});
local table_freeze_ret2 = table.freeze({
    Position = true,
    AnchorPoint = true,
    Size = true
});
local table_freeze_ret3 = table.freeze({
    LayoutOrder = true
});
local table_freeze_ret4 = table.freeze({
    BackgroundColor3 = true,
    BorderColor3 = true,
    BorderMode = true,
    BorderSizePixel = true
});
local table_freeze_ret5 = table.freeze({
    BorderColor3 = true,
    BorderMode = true
});
local table_freeze_ret6 = table.freeze({
    TextSize = true
});
local table_freeze_ret7 = table.freeze({
    TextColor3 = true,
    TextStrokeColor3 = true,
    TextStrokeTransparency = true
});
local table_freeze_ret8 = table.freeze({
    IsLoaded = true,
    ImageColor3 = true,
    ImageRectOffset = true,
    ImageRectSize = true,
    ScaleType = true,
    SliceCenter = true,
    SliceScale = true,
    TileSize = true,
    ResampleMode = true
});
local table_freeze_ret9 = table.freeze({
    Color = true,
    Offset = true,
    Rotation = true,
    Transparency = true
});
local table_freeze_ret10 = table.freeze({
    ApplyStrokeMode = true,
    BorderOffset = true,
    BorderStrokePosition = true,
    Color = true,
    LineJoinMode = true,
    StrokeSizingMode = true,
    Transparency = true,
    ZIndex = true
});
local u6 = {};

local function kindOf(p7: userdata) -- Line: 103
    -- upvalues: u4 (ref), u6 (copy), table_freeze_ret2 (copy), table_freeze_ret (copy)
    local v8 = u4(p7, "ClassName");
    local v9 = u6[v8];

    if v9 then
        return v9;
    end;

    local v10 = p7:IsA("ScreenGui") and 1 or ((p7:IsA("BillboardGui") or p7:IsA("SurfaceGui")) and 2 or (p7:IsA("LayerCollector") and 3 or 0));
    local v11 = false;

    if p7:IsA("UIGridLayout") or p7:IsA("UITableLayout") then
        v11 = table_freeze_ret2;
    elseif p7:IsA("UIListLayout") then
        v11 = table_freeze_ret;
    end;

    local table_freeze_ret11 = table.freeze({
        Collector = v10,
        Gui = p7:IsA("GuiObject"),
        Text = p7:IsA("TextBox") and 2 or ((p7:IsA("TextLabel") or p7:IsA("TextButton")) and 1 or 0),
        Image = p7:IsA("ImageLabel") or p7:IsA("ImageButton"),
        Gradient = p7:IsA("UIGradient"),
        Stroke = p7:IsA("UIStroke"),
        Layout = v11,
        IsLayout = p7:IsA("UIGridStyleLayout")
    });
    u6[v8] = table_freeze_ret11;

    return table_freeze_ret11;
end;

local function collectorHides(p12: userdata, p13: number) -- Line: 139
    -- upvalues: Get (copy), u4 (ref)
    if p13 == 1 then
        return not Get(p12, "Enabled");
    end;

    if p13 ~= 2 then
        return true;
    end;

    if not Get(p12, "Enabled") then
        return true;
    end;

    if u4(p12, "Adornee") ~= nil then
        return false;
    end;

    local v14 = u4(p12, "Parent");

    if v14 then
        v14 = v14:IsA("BasePart") or (v14:IsA("Attachment") or v14:IsA("Model"));
    end;

    return not v14;
end;

function u5.HidesSubtree(p15: userdata) -- Line: 157
    -- upvalues: kindOf (copy), collectorHides (copy), Get (copy)
    local v16 = kindOf(p15);

    if v16.Collector ~= 0 then
        return collectorHides(p15, v16.Collector);
    end;

    local v17 = v16.Gui and not Get(p15, "Visible");

    return v17;
end;

function u5.NewMemo() -- Line: 173
    return {
        Hidden = {},
        Layout = {}
    };
end;

local u18 = {};

function u5.IsHidden(p19: userdata, p20: userdata, p21: table?) -- Line: 182
    -- upvalues: kindOf (copy), collectorHides (copy), u18 (copy), Get (copy), u4 (ref)
    if p21 then
        p21 = p21.Hidden;
    end;

    local v22 = 0;
    local v23 = true;
    local v24;

    while true do
        if not p19 or p19 == p20 then
            v24 = v23;
            break;
        end;

        if p21 then
            v24 = p21[p19];

            if v24 ~= nil then
                break;
            end;
        end;

        local v25 = kindOf(p19);

        if v25.Collector ~= 0 then
            v24 = collectorHides(p19, v25.Collector);
            v22 = v22 + 1;
            u18[v22] = p19;
            break;
        end;

        if v25.Gui and not Get(p19, "Visible") then
            v22 = v22 + 1;
            u18[v22] = p19;
            v24 = true;
            break;
        end;

        if p21 then
            v22 = v22 + 1;
            u18[v22] = p19;
        end;

        p19 = u4(p19, "Parent");
    end;

    if p21 then
        for i = 1, v22 do
            p21[u18[i]] = v24;
            local _ = i;
        end;
    end;

    table.clear(u18);

    return v24;
end;

function u5.SubtreeHidden(p26: userdata, p27: userdata) -- Line: 226
    -- upvalues: kindOf (copy), collectorHides (copy), Get (copy), u4 (ref)
    while p26 and p26 ~= p27 do
        local v28 = kindOf(p26);

        if v28.Collector ~= 0 then
            return collectorHides(p26, v28.Collector);
        end;

        if v28.Gui and not Get(p26, "Visible") then
            return true;
        end;

        p26 = u4(p26, "Parent");
    end;

    return false;
end;

local table_freeze_ret11 = table.freeze({ "Visible" });
local table_freeze_ret12 = table.freeze({ "Enabled" });
local table_freeze_ret13 = table.freeze({ "Enabled", "Adornee", "Parent" });
local table_freeze_ret14 = table.freeze({});

function u5.ShownByOf(p29: userdata) -- Line: 247
    -- upvalues: kindOf (copy), table_freeze_ret13 (copy), table_freeze_ret12 (copy), table_freeze_ret11 (copy), table_freeze_ret14 (copy)
    local v30 = kindOf(p29);

    if v30.Collector == 2 then
        return table_freeze_ret13;
    end;

    if v30.Collector ~= 0 then
        return table_freeze_ret12;
    end;

    if v30.Gui then
        return table_freeze_ret11;
    end;

    return table_freeze_ret14;
end;

local function noImage(p31: userdata) -- Line: 260
    -- upvalues: Get (copy)
    return Get(p31, "Image") == "" and true or Get(p31, "ImageTransparency") >= 1;
end;

function u5.PolledUnseen(p32: userdata, p33: userdata, p34: table?) -- Line: 266
    -- upvalues: u5 (copy), kindOf (copy), Get (copy)
    if u5.IsHidden(p32, p33, p34) then
        return true;
    end;

    local v35 = kindOf(p32).Image and (Get(p32, "Image") == "" and true or Get(p32, "ImageTransparency") >= 1);

    return v35;
end;

local u36 = {};

local function union(p37: table?, p38: table) -- Line: 276
    -- upvalues: u36 (copy)
    if not p37 then
        return p38;
    end;

    local v39 = u36[p37];

    if not v39 then
        v39 = {};
        u36[p37] = v39;
    end;

    local v40 = v39[p38];

    if not v40 then
        local table_clone_ret = table.clone(p37);

        for i in p38 do
            table_clone_ret[i] = true;
        end;

        v40 = table.freeze(table_clone_ret);
        v39[p38] = v40;
    end;

    return v40;
end;

local function layoutSet(p41: userdata) -- Line: 298
    -- upvalues: table_freeze_ret3 (copy), kindOf (copy), Get (copy), union (copy)
    local v42 = p41:FindFirstChildWhichIsA("UIGridStyleLayout");

    if not v42 then
        return table_freeze_ret3;
    end;

    local v43 = kindOf(v42).Layout or nil;

    if Get(v42, "SortOrder") ~= Enum.SortOrder.LayoutOrder then
        v43 = union(v43, table_freeze_ret3);
    end;

    return v43 or false;
end;

function u5.Suppressed(p44: userdata, p45: table?) -- Line: 313
    -- upvalues: kindOf (copy), u4 (ref), layoutSet (copy), Get (copy), union (copy), table_freeze_ret4 (copy), table_freeze_ret5 (copy), table_freeze_ret6 (copy), table_freeze_ret7 (copy), table_freeze_ret8 (copy), table_freeze_ret9 (copy), table_freeze_ret10 (copy)
    local v46 = kindOf(p44);
    local v47 = nil;

    if v46.Gui then
        local v48 = u4(p44, "Parent");

        if v48 then
            if p45 then
                p45 = p45.Layout;
            end;

            local v49;

            if p45 then
                v49 = p45[v48];
            else
                v49 = p45;
            end;

            if v49 == nil then
                v49 = layoutSet(v48);

                if p45 then
                    p45[v48] = v49;
                end;
            end;

            v47 = v49 or nil;
        end;

        if Get(p44, "BackgroundTransparency") >= 1 then
            v47 = union(v47, table_freeze_ret4);
        elseif Get(p44, "BorderSizePixel") == 0 then
            v47 = union(v47, table_freeze_ret5);
        end;

        local Text = v46.Text;

        if Text == 0 then
            if v46.Image and (Get(p44, "Image") == "" or Get(p44, "ImageTransparency") >= 1) then
                return union(v47, table_freeze_ret8);
            end;
        else
            if Get(p44, "TextScaled") then
                v47 = union(v47, table_freeze_ret6);
            end;

            if Get(p44, "TextTransparency") >= 1 or Text == 1 and Get(p44, "Text") == "" then
                return union(v47, table_freeze_ret7);
            end;
        end;
    elseif v46.Gradient then
        if not Get(p44, "Enabled") then
            return table_freeze_ret9;
        end;
    elseif v46.Stroke and (not Get(p44, "Enabled") or Get(p44, "Thickness") <= 0) then
        v47 = table_freeze_ret10;
    end;

    return v47;
end;

function u5.IsLayout(p50: userdata) -- Line: 363
    -- upvalues: kindOf (copy)
    return kindOf(p50).IsLayout;
end;

return table.freeze(u5);