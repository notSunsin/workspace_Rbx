-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuestEventServices = ReplicatedStorage.GameEvents.GuestEventServices;
local GlobalChatService = GuestEventServices.GlobalChatService;
local _ = GlobalChatService.QueueChatMessage;
local Signal = require(ReplicatedStorage.Modules.Signal);
local SetupRemotes = require(ReplicatedStorage.Modules.SetupRemotes);
local u1 = {
    AuthorizerMessageCreated = Signal.new(),
    AuthorizerMessageRemoved = Signal.new()
};

function u1.CreateAuthorizerMessage(p2: table, p3: table) -- Line: 29
    -- upvalues: u1 (copy)
    u1[p3.MessageId] = p3;
    u1.AuthorizerMessageCreated:Fire(p3);
end;

function u1.RemoveAuthorizerMessage(p4: table, p5: table) -- Line: 34
    -- upvalues: u1 (copy)
    u1[p5.MessageId] = nil;
    u1.AuthorizerMessageRemoved:Fire(p5);
end;

function u1.GetMessageData(p6: table, p7: string) -- Line: 39
    -- upvalues: u1 (copy)
    return u1[p7];
end;

function u1.QueueChatMessage(p8: table, p9: string) -- Line: 44
    -- upvalues: GlobalChatService (copy)
    GlobalChatService.QueueChatMessage:FireServer(p9);
end;

function u1.DenyMessage(p10: table, p11: string) -- Line: 48
    -- upvalues: GlobalChatService (copy)
    GlobalChatService.DenyMessage:FireServer(p11);
end;

function u1.AuthorizeMessage(p12: table, p13: string) -- Line: 52
    -- upvalues: GlobalChatService (copy)
    GlobalChatService.AuthorizeMessage:FireServer(p13);
end;

function u1.Start(p14) -- Line: 57
    -- upvalues: SetupRemotes (copy), GuestEventServices (copy), u1 (copy)
    SetupRemotes(GuestEventServices.GlobalChatController, u1);
end;

task.spawn(function() -- Line: 61
    -- upvalues: u1 (copy)
    u1:Start();
end);

return u1;