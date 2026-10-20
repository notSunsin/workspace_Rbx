-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Modules.CreateTagHandler)({
    Tag = "PetTooltip",

    OnInstanceAdded = function(u1: userdata) -- Line: 14, Name: Setup
        -- upvalues: TweenService (copy)
        if not u1 then
            return;
        end;

        local Parent = u1.Parent;

        if not Parent then
            return;
        end;

        local Parent2 = Parent.Parent;

        if not Parent2 then
            return;
        end;

        local TooltipText = u1:FindFirstChild("TooltipText");
        TooltipText.TextTransparency = 1;
        u1.BackgroundTransparency = 1;
        local u2 = TweenService:Create(u1, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.4
        });
        local u3 = TweenService:Create(TooltipText, TweenInfo.new(0.2), {
            TextTransparency = 0
        });
        local u4 = TweenService:Create(u1, TweenInfo.new(0.2), {
            BackgroundTransparency = 1
        });
        local u5 = TweenService:Create(TooltipText, TweenInfo.new(0.2), {
            TextTransparency = 1
        });
        local Attribute = u1:GetAttribute("ForceTooltip");
        local u6 = false;
        local u7 = nil;

        local function updateTooltipVisible() -- Line: 43
            -- upvalues: Attribute (ref), u6 (ref), u7 (ref), u2 (copy), u3 (copy), u4 (copy), u5 (copy)
            if Attribute ~= false and u6 or Attribute then
                if not u7 then
                    u7 = true;
                    u2:Play();
                    u3:Play();
                end;
            elseif u7 then
                u7 = false;
                u4:Play();
                u5:Play();
            end;
        end;

        Parent2.MouseEnter:Connect(function() -- Line: 60
            -- upvalues: u6 (ref), Attribute (ref), u7 (ref), u2 (copy), u3 (copy), u4 (copy), u5 (copy)
            u6 = true;

            if Attribute ~= false and u6 or Attribute then
                if not u7 then
                    u7 = true;
                    u2:Play();
                    u3:Play();
                end;
            elseif u7 then
                u7 = false;
                u4:Play();
                u5:Play();
            end;
        end);
        Parent2.MouseLeave:Connect(function() -- Line: 65
            -- upvalues: u6 (ref), Attribute (ref), u7 (ref), u2 (copy), u3 (copy), u4 (copy), u5 (copy)
            u6 = false;

            if Attribute ~= false and u6 or Attribute then
                if not u7 then
                    u7 = true;
                    u2:Play();
                    u3:Play();
                end;
            elseif u7 then
                u7 = false;
                u4:Play();
                u5:Play();
            end;
        end);
        u1:GetAttributeChangedSignal("ForceTooltip"):Connect(function() -- Line: 70
            -- upvalues: Attribute (ref), u1 (copy), u6 (ref), u7 (ref), u2 (copy), u3 (copy), u4 (copy), u5 (copy)
            Attribute = u1:GetAttribute("ForceTooltip");

            if Attribute ~= false and u6 or Attribute then
                if not u7 then
                    u7 = true;
                    u2:Play();
                    u3:Play();
                end;
            elseif u7 then
                u7 = false;
                u4:Play();
                u5:Play();
            end;
        end);
    end
});

return {};