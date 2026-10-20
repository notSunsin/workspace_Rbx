-- Decompiled with Potassium's decompiler.

local script_Client = require(script.Client);
local script_Server = require(script.Server);
local Freeze = require(script.Parent.Freeze);

return table.freeze({
    Server = script_Server,
    Client = script_Client,
    None = Freeze.None
});