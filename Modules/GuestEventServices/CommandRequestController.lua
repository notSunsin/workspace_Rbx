-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GuestEventServices = ReplicatedStorage.GameEvents.GuestEventServices;
local CommandRequestService = GuestEventServices.CommandRequestService;
local Signal = require(ReplicatedStorage.Modules.Signal);
local SetupRemotes = require(ReplicatedStorage.Modules.SetupRemotes);
local u1 = {
    CommandRequestMessageCreated = Signal.new(),
    CommandRequestMessageRemoved = Signal.new()
};
local u2 = {};

function u1.CreateCommandRequest(p3: table, p4: table) -- Line: 27
    -- upvalues: u2 (copy), u1 (copy)
    u2[p4.MessageId] = p4;
    u1.CommandRequestMessageCreated:Fire(p4);
end;

function u1.RemoveCommandRequest(p5: table, p6: table) -- Line: 32
    -- upvalues: u2 (copy), u1 (copy)
    u2[p6.MessageId] = nil;
    u1.CommandRequestMessageRemoved:Fire(p6);
end;

function u1.GetCommandData(p7: table, p8: string) -- Line: 37
    -- upvalues: u2 (copy)
    return u2[p8];
end;

function u1.RequestCommand(p9: table, p10: table) -- Line: 42
    -- upvalues: CommandRequestService (copy)
    CommandRequestService.RequestCommand:FireServer(p10);
end;

function u1.DenyCommand(p11: table, p12: string) -- Line: 46
    -- upvalues: CommandRequestService (copy)
    CommandRequestService.DenyCommand:FireServer(p12);
end;

function u1.AuthorizeCommand(p13: table, p14: string) -- Line: 50
    -- upvalues: CommandRequestService (copy)
    CommandRequestService.AuthorizeCommand:FireServer(p14);
end;

function u1.Start(p15) -- Line: 54
    -- upvalues: SetupRemotes (copy), GuestEventServices (copy), u1 (copy)
    SetupRemotes(GuestEventServices.CommandRequestController, u1);
end;

task.spawn(function() -- Line: 58
    -- upvalues: u1 (copy)
    u1:Start();
end);

return u1;