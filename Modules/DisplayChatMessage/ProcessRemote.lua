-- Decompiled with Potassium's decompiler.

game:GetService("TextChatService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Chalk = require(ReplicatedStorage.Modules.Chalk);
local DisplayChatMessage = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("DisplayChatMessage");
local RankMap = require(game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("ChatMiddleware"):WaitForChild("RankMap"));
local script_Parent = require(script.Parent);
DisplayChatMessage.OnClientEvent:Connect(function(p1: table) -- Line: 23
    -- upvalues: script_Parent (copy), Chalk (copy), RankMap (copy)
    if type(p1) == "string" then
        script_Parent(p1);

        return;
    end;

    local Message = p1.Message;
    local Author = p1.Author;

    if Author and Author.Name then
        local v2 = Author.NameColor and Chalk.color(Author.NameColor)(Author.Name) or Author.Name;

        if Author.Rank then
            v2 = RankMap[Author.Rank]:format(v2) or v2;
        end;

        Message = `{v2}{Author.Verified and utf8.char(57344) or ""} {Message}`;
    end;

    script_Parent(Message);
end);

return nil;