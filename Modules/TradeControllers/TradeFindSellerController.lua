-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local FindSellerPrompt = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("FindSellerPrompt");
local TokenRAPUtil = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPUtil);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local Notification = require(ReplicatedStorage.Modules.Notification);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local u2 = false;
local v12 = {
    Prompt = function(p3: table, u4: string, p5: string) -- Line: 19, Name: Prompt
        -- upvalues: u2 (ref), u1 (copy), TokenRAPUtil (copy), ReplicatedStorage (copy), Notification (copy), GuiController (copy), FindSellerPrompt (copy)
        if u2 then
            return;
        end;

        u1:Clean();
        local DefaultItemData = TokenRAPUtil.GetDefaultItemData(u4, p5);
        local v6 = `Data for {u4}/{p5} not found`;
        assert(DefaultItemData, v6);
        u2 = true;
        local v7, v8, u9 = pcall(function() -- Line: 30
            -- upvalues: ReplicatedStorage (ref), u4 (copy), DefaultItemData (copy)
            return ReplicatedStorage.GameEvents.TradeEvents.TokenRAPs.FindSellers:InvokeServer(u4, DefaultItemData);
        end);
        u2 = false;

        if not v7 then
            return;
        end;

        if not (v8 and u9) then
            Notification:CreateNotification("There are no online sellers for this item!");

            return;
        end;

        GuiController:Open(FindSellerPrompt);

        local function response(p10) -- Line: 46
            -- upvalues: ReplicatedStorage (ref), u9 (copy), u1 (ref), GuiController (ref), FindSellerPrompt (ref)
            if p10 == true then
                ReplicatedStorage.GameEvents.TradeEvents.TokenRAPs.TeleportToListing:InvokeServer(u9, true);
            end;

            u1:Clean();
            GuiController:Close(FindSellerPrompt);
        end;

        u1:Add(FindSellerPrompt.Frame.Close.Activated:Connect(function() -- Line: 56
            -- upvalues: u1 (ref), GuiController (ref), FindSellerPrompt (ref)
            u1:Clean();
            GuiController:Close(FindSellerPrompt);
        end));
        u1:Add(FindSellerPrompt.Frame.Options.Yes.Activated:Connect(function() -- Line: 60
            -- upvalues: ReplicatedStorage (ref), u9 (copy), u1 (ref), GuiController (ref), FindSellerPrompt (ref)
            ReplicatedStorage.GameEvents.TradeEvents.TokenRAPs.TeleportToListing:InvokeServer(u9, true);
            u1:Clean();
            GuiController:Close(FindSellerPrompt);
        end));
        u1:Add(FindSellerPrompt.Frame.Options.No.Activated:Connect(function() -- Line: 64
            -- upvalues: u1 (ref), GuiController (ref), FindSellerPrompt (ref)
            u1:Clean();
            GuiController:Close(FindSellerPrompt);
        end));
    end,

    Start = function(p11) -- Line: 69, Name: Start
        -- upvalues: GuiController (copy), FindSellerPrompt (copy)
        GuiController:UsePopupAnims(FindSellerPrompt);
    end
};
task.spawn(v12.Start, v12);

return v12;