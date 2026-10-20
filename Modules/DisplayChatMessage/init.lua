-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TextChatService = game:GetService("TextChatService");
local RankMap = require(game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("ChatMiddleware"):WaitForChild("RankMap"));
local Chalk = require(ReplicatedStorage.Modules.Chalk);

local function DisplayChatMessage(p1) -- Line: 17
    -- upvalues: TextChatService (copy)
    TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(p1);
end;

return function(p2: table) -- Line: 21
    -- upvalues: TextChatService (copy), Chalk (copy), RankMap (copy)
    if type(p2) == "string" then
        TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(p2);

        return;
    end;

    local Message = p2.Message;
    local Author = p2.Author;

    if Author and Author.Name then
        local v3 = Author.NameColor and Chalk.color(Author.NameColor)(Author.Name) or Author.Name;

        if Author.Rank then
            v3 = RankMap[Author.Rank]:format(v3) or v3;
        end;

        Message = `{v3}{Author.Verified and utf8.char(57344) or ""} {Message}`;
    end;

    TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(Message);
end;