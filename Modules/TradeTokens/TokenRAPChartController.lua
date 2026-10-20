-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalizationService = game:GetService("LocalizationService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.TradeTokens.TokenRAPUtil);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local TokenRAPController = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
local Notification = require(ReplicatedStorage.Modules.Notification);
local u1 = Players.LocalPlayer.PlayerGui:WaitForChild("TradePlazaIndex").Frame.Sections.RAPHistory.Dots.DotTemplate:Clone();
local v31 = {
    Show = function(p2: table, p3: string, p4: string, p5: any) -- Line: 30, Name: Show
        -- upvalues: LocalizationService (copy), ReplicatedStorage (copy), Notification (copy), TokenRAPController (copy), Comma_Module (copy), u1 (copy)
        if not p5 then
            return false;
        end;

        for _, child in p5.Dots:GetChildren() do
            if child:IsA("GuiObject") or child:IsA("Path2D") then
                child:Destroy();
            end;
        end;

        local RobloxLocaleId = LocalizationService.RobloxLocaleId;
        local DateTime_now_ret = DateTime.now();

        for i = 5, 1, -1 do
            local DateTime_fromUnixTimestamp_ret = DateTime.fromUnixTimestamp(DateTime_now_ret.UnixTimestamp - (i - 1) * 86400);
            local v6 = p5.Dates:FindFirstChild((`Option{5 - i + 1}`));
            local v7;

            if v6 then
                v6.Text = DateTime_fromUnixTimestamp_ret:FormatLocalTime("MMM D", RobloxLocaleId);
                v7 = i;
            else
                v7 = i;
            end;
        end;

        local v8, v9 = ReplicatedStorage.GameEvents.TradeEvents.TokenRAPs.GetItemRAPHistory:InvokeServer(p3, p4);

        if not (v8 and v9) then
            Notification:CreateNotification((`RAP History failed to load: {p4}`));

            return false;
        end;

        local v10 = {};
        local v11 = {};

        for _, v in v9 do
            local v12 = v.Date:ToUniversalTime();
            local UnixTimestampMillis = DateTime.fromUniversalTime(v12.Year, v12.Month, v12.Day).UnixTimestampMillis;

            if not v10[UnixTimestampMillis] then
                v10[UnixTimestampMillis] = {};
            end;

            table.insert(v10[UnixTimestampMillis], v);
        end;

        local v13 = 0;

        for i, v in v10 do
            local v14 = 0;
            local v15 = 0;

            for _, v2 in v do
                v14 = v14 + v2.DailyRAP;
                v15 = v15 + v2.DailySaleCount;
            end;

            local v16 = v14 / #v;

            if v13 < v16 then
                v13 = v16;
            end;

            local v17 = {
                Date = DateTime.fromUnixTimestampMillis(i),
                DailyRAP = v16,
                DailySaleCount = v15
            };
            table.insert(v11, v17);
        end;

        local v18 = TokenRAPController:GetRAPById(p3, p4) or 0;
        local math_max_ret = math.max(v13, v18);
        p5.Price.Amount.Text = v18;
        table.sort(v11, function(p19, p20) -- Line: 125
            return p19.Date.UnixTimestamp > p20.Date.UnixTimestamp;
        end);
        local v21 = DateTime_now_ret:ToUniversalTime();
        local DateTime_fromUnixTimestamp_ret = DateTime.fromUnixTimestamp(DateTime_now_ret.UnixTimestamp + 86400);
        local DateTime_fromUnixTimestamp_ret2 = DateTime.fromUnixTimestamp(DateTime_fromUnixTimestamp_ret.UnixTimestamp - 432000);
        local v22 = DateTime.fromUnixTimestamp(DateTime_fromUnixTimestamp_ret2.UnixTimestamp):ToUniversalTime();
        local DateTime_fromUniversalTime_ret = DateTime.fromUniversalTime(v21.Year, v21.Month, v21.Day);
        local UnixTimestamp = DateTime.fromUniversalTime(v22.Year, v22.Month, v22.Day).UnixTimestamp;
        local _ = DateTime_fromUniversalTime_ret.UnixTimestamp;
        local v23 = (math_max_ret <= 0 and 100 or math_max_ret) * 0.85;
        local math_log10_ret = math.log10(v23 / 5);
        local math_round_ret = math.round(math_log10_ret);
        local math_pow_ret = math.pow(10, math_round_ret);

        while math_pow_ret * 4 < v23 do
            math_pow_ret = math.ceil(math_pow_ret * 2);
        end;

        for i = 5, 1, -1 do
            local v24 = p5.Amounts:FindFirstChild((`Option{i}`));
            local v25;

            if v24 then
                v24.Text = Comma_Module.Comma((math.round((i - 1) * math_pow_ret)));
                v25 = i;
            else
                v25 = i;
            end;
        end;

        local v26 = {};

        for _, v in v11 do
            if v.Date.UnixTimestamp >= UnixTimestamp then
                local v27 = (v.Date.UnixTimestamp - UnixTimestamp) / (DateTime_fromUniversalTime_ret.UnixTimestamp - UnixTimestamp);
                local v28 = v.DailyRAP / (math_pow_ret * 4);
                local v29 = u1:Clone();
                local math_clamp_ret = math.clamp(v27 ~= v27 and 1 or v27, 0, 1);
                local math_clamp_ret2 = math.clamp(1 - v28, 0, 1);
                v29.Position = UDim2.fromScale(math_clamp_ret, math_clamp_ret2 - 0.025);
                v29.Label.Text = Comma_Module.Comma((math.round(v.DailyRAP)));
                v29.Parent = p5.Dots;
                local Path2DControlPoint_new_ret = Path2DControlPoint.new(v29.Position);
                table.insert(v26, Path2DControlPoint_new_ret);
            end;
        end;

        if #v26 > 1 then
            local Path2D = Instance.new("Path2D");
            Path2D.Color3 = Color3.fromRGB(38, 238, 38);
            Path2D.Thickness = 4;
            Path2D.Visible = true;
            Path2D:SetControlPoints(v26);
            Path2D.Parent = p5.Dots;
        end;

        return true;
    end,

    Start = function(p30) -- Line: 199, Name: Start
    end
};
task.spawn(v31.Start, v31);

return v31;