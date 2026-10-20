-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local v1 = {};

local function DisconnectHB(p2: userdata) -- Line: 5
    p2:Disconnect();
end;

function v1.AnimateTranscendentColor(u3: userdata) -- Line: 10
    -- upvalues: RunService (copy)
    local u4 = 0.75;
    local u5 = nil;
    u5 = RunService.Heartbeat:Connect(function(p6: number) -- Line: 13
        -- upvalues: u3 (copy), u5 (ref), u4 (ref)
        if u3:GetAttribute("Rarity") ~= "Transcendent" then
            u5:Disconnect();

            return;
        end;

        u4 = (u4 + p6 * 0.05) % 1;
        local v7 = tick() * 1.5;
        local v8 = math.sin(v7) * 0.03 + 0.72;
        local Color3_fromHSV_ret = Color3.fromHSV(v8, 1, 1);

        if u3:IsA("Frame") then
            u3.BackgroundColor3 = Color3_fromHSV_ret;
        end;

        if u3:IsA("TextLabel") then
            u3.TextColor3 = Color3_fromHSV_ret;
        end;

        if u3:IsA("ImageLabel") then
            u3.ImageColor3 = Color3_fromHSV_ret;
        end;
    end);
    u3.Destroying:Once(function() -- Line: 27
        -- upvalues: u5 (ref)
        u5:Disconnect();
    end);
end;

function v1.AnimatePrismaticColor(u9: userdata) -- Line: 32
    -- upvalues: RunService (copy)
    local u10 = nil;
    u10 = RunService.Heartbeat:Connect(function(p11: number) -- Line: 34
        -- upvalues: u9 (copy), u10 (ref)
        if u9:GetAttribute("Rarity") ~= "Prismatic" then
            u10:Disconnect();

            return;
        end;

        local v12 = os.clock() * 0.1 % 1;
        local Color3_fromHSV_ret = Color3.fromHSV(v12, 1, 1);

        if u9:IsA("Frame") then
            u9.BackgroundColor3 = Color3_fromHSV_ret;
        end;

        if u9:IsA("TextLabel") then
            u9.TextColor3 = Color3_fromHSV_ret;
        end;

        if u9:IsA("ImageLabel") then
            u9.ImageColor3 = Color3_fromHSV_ret;
        end;
    end);
    u9.Destroying:Once(function() -- Line: 47
        -- upvalues: u10 (ref)
        u10:Disconnect();
    end);
end;

return v1;