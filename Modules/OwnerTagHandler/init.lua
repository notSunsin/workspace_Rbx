-- Decompiled with Potassium's decompiler.

local v1 = {};
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local GetFarm = require(Modules:WaitForChild("GetFarm"));
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local u2 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local _ = ReplicatedStorage.GameEvents.PlayerTeleportTriggered;
local TeleportPlayer = require(ReplicatedStorage.Modules.TeleportPlayer);
LocalPlayer.CharacterAdded:Connect(function(p3) -- Line: 21
    -- upvalues: u2 (ref)
    u2 = p3;
end);
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = true;
local OwnerTag = script:WaitForChild("OwnerTag");
local Hover = game.SoundService.Hover;
local Click = game.SoundService.Click;

local function ShouldShowTags() -- Line: 35
    -- upvalues: u7 (ref), LocalPlayer (copy)
    if not u7 then
        return false;
    end;

    if LocalPlayer:GetAttribute("DoingOfflineCutscene") == true then
        return false;
    end;

    if LocalPlayer:GetAttribute("Loading_Screen_Finished") ~= true then
        return false;
    end;

    if LocalPlayer:GetAttribute("Finished_Loading") == true then
        return LocalPlayer:GetAttribute("InWaspWaveSurvival") ~= true;
    end;

    return false;
end;

local function CreateOwnerTag(u8, u9) -- Line: 44
    -- upvalues: OwnerTag (copy), PlayerGui (copy), Players (copy), LocalPlayer (copy), ShouldShowTags (copy), TweenService (copy), Hover (copy), TeleportPlayer (copy), GetFarm (copy), Click (copy), u2 (ref)
    if not u8:GetAttribute("CommunityGarden") then
        local v10 = OwnerTag:Clone();
        local Owner_Tag = u8:WaitForChild("Owner_Tag");
        v10:PivotTo(Owner_Tag:GetPivot());
        v10.Parent = workspace;
        local BillboardGui = v10.Part.BillboardGui;
        BillboardGui.Parent = PlayerGui;
        local Headshot = BillboardGui:FindFirstChild("Headshot", true);
        local SENSOR = BillboardGui:WaitForChild("SENSOR");
        local Title = BillboardGui:FindFirstChild("Title", true);
        local bg = BillboardGui:WaitForChild("bg");

        if u9 then
            Headshot.Image = Players:GetUserThumbnailAsync(u9.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);

            if u9 == LocalPlayer then
                Title.Text = "Your Garden";
            else
                Title.Text = u9.DisplayName .. "\'s Garden";
            end;
        end;

        local u11 = false;

        local function ToggleTransparency(p12) -- Line: 77
            -- upvalues: ShouldShowTags (ref), BillboardGui (copy), u11 (ref), TweenService (ref), Headshot (copy), bg (copy), Title (copy)
            if not ShouldShowTags() then
                BillboardGui.Enabled = false;

                return;
            end;

            u11 = p12;

            if p12 then
                BillboardGui.Enabled = true;
            end;

            TweenService:Create(Headshot, TweenInfo.new(0.2), {
                ImageTransparency = p12 and 0 or 1
            }):Play();
            TweenService:Create(bg, TweenInfo.new(0.2), {
                ImageTransparency = p12 and 0 or 1
            }):Play();
            TweenService:Create(Title, TweenInfo.new(0.2), {
                TextTransparency = p12 and 0 or 1
            }):Play();

            if not p12 then
                task.delay(0.2, function() -- Line: 102
                    -- upvalues: u11 (ref), BillboardGui (ref)
                    if not u11 then
                        BillboardGui.Enabled = false;
                    end;
                end);
            end;

            bg.ImageColor3 = Color3.new(1, 1, 1);
            Headshot.ImageColor3 = Color3.new(1, 1, 1);
        end;

        SENSOR.MouseEnter:Connect(function() -- Line: 113
            -- upvalues: bg (copy), Headshot (copy), Hover (ref)
            bg.ImageColor3 = Color3.new(0.831373, 0.831373, 0.831373);
            Headshot.ImageColor3 = Color3.new(0.831373, 0.831373, 0.831373);
            Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            Hover.TimePosition = 0;
            Hover.Playing = true;
        end);
        SENSOR.MouseLeave:Connect(function() -- Line: 121
            -- upvalues: bg (copy), Headshot (copy)
            bg.ImageColor3 = Color3.new(1, 1, 1);
            Headshot.ImageColor3 = Color3.new(1, 1, 1);
        end);
        SENSOR.MouseButton1Down:Connect(function() -- Line: 126
            -- upvalues: bg (copy), Headshot (copy)
            bg.ImageColor3 = Color3.new(0.66666, 0.66666, 0.66666);
            Headshot.ImageColor3 = Color3.new(0.66666, 0.66666, 0.66666);
        end);
        SENSOR.MouseButton1Up:Connect(function() -- Line: 131
            -- upvalues: bg (copy), Headshot (copy)
            bg.ImageColor3 = Color3.new(1, 1, 1);
            Headshot.ImageColor3 = Color3.new(1, 1, 1);
        end);
        SENSOR.MouseButton1Click:Connect(function() -- Line: 136
            -- upvalues: u11 (ref), u9 (copy), LocalPlayer (ref), TeleportPlayer (ref), GetFarm (ref), u8 (copy), bg (copy), Headshot (copy), Click (ref)
            if not u11 then
                return;
            end;

            if u9 == LocalPlayer then
                TeleportPlayer(LocalPlayer, GetFarm(LocalPlayer).Spawn_Point.CFrame, "Farm");
            else
                TeleportPlayer(LocalPlayer, u8.Spawn_Point.CFrame, "Farm");
            end;

            bg.ImageColor3 = Color3.new(1, 1, 1);
            Headshot.ImageColor3 = Color3.new(1, 1, 1);
            Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            Click.TimePosition = 0;
            Click.Playing = true;
        end);
        local v13 = {
            LastState = false,
            OwnerTag = v10,
            BillBoardGui = BillboardGui,
            Owner_Tag = Owner_Tag,
            ToggleTransparency = ToggleTransparency,
            CurrentState = u11
        };

        if u2 and ShouldShowTags() then
            local Position = u2:GetPivot().Position;
            local Vector3_new_ret = Vector3.new(Position.X, 0, Position.Z);
            local Position2 = Owner_Tag.Position;
            local v14 = (Vector3.new(Position2.X, 0, Position2.Z) - Vector3_new_ret).Magnitude >= 80;
            ToggleTransparency(v14);
            v13.LastState = v14;
        else
            ToggleTransparency(false);
        end;

        return v13;
    end;
end;

local function CleanupFarmTag(p15) -- Line: 176
    -- upvalues: u4 (copy)
    if u4[p15] then
        if u4[p15].OwnerTag then
            u4[p15].OwnerTag:Destroy();
        end;

        if u4[p15].BillBoardGui then
            u4[p15].BillBoardGui:Destroy();
        end;

        u4[p15] = nil;
    end;
end;

local function CleanupFarmConnection(p16) -- Line: 188
    -- upvalues: u5 (copy)
    if u5[p16] then
        u5[p16]:Disconnect();
        u5[p16] = nil;
    end;
end;

local function SetupFarmOwnerListener(u17) -- Line: 195
    -- upvalues: u4 (copy), Players (copy), CreateOwnerTag (copy), u5 (copy)
    local Data = u17.Important:FindFirstChild("Data");

    if not Data then
        return;
    end;

    local Owner = Data:FindFirstChild("Owner");

    if not Owner then
        return;
    end;

    if u4[u17] then
        if u4[u17].OwnerTag then
            u4[u17].OwnerTag:Destroy();
        end;

        if u4[u17].BillBoardGui then
            u4[u17].BillBoardGui:Destroy();
        end;

        u4[u17] = nil;
    end;

    local v18 = Owner.Value and Players:FindFirstChild(Owner.Value);

    if v18 then
        u4[u17] = CreateOwnerTag(u17, v18);
    end;

    u5[u17] = Owner.Changed:Connect(function() -- Line: 211
        -- upvalues: u17 (copy), u4 (ref), Owner (copy), Players (ref), CreateOwnerTag (ref)
        local v19 = u17;

        if u4[v19] then
            if u4[v19].OwnerTag then
                u4[v19].OwnerTag:Destroy();
            end;

            if u4[v19].BillBoardGui then
                u4[v19].BillBoardGui:Destroy();
            end;

            u4[v19] = nil;
        end;

        local Value = Owner.Value;
        local v20 = Value and Players:FindFirstChild(Value);

        if v20 then
            u4[u17] = CreateOwnerTag(u17, v20);
        end;
    end);
end;

local function UpdateFarmTags() -- Line: 224
    -- upvalues: u4 (copy), u5 (copy), SetupFarmOwnerListener (copy)
    local Farm = workspace:FindFirstChild("Farm");

    if not Farm then
        return;
    end;

    for _, child in pairs(Farm:GetChildren()) do
        if not (u4[child] or u5[child]) then
            SetupFarmOwnerListener(child);
        end;
    end;
end;

local function SetupFarmFolderListener() -- Line: 235
    -- upvalues: SetupFarmFolderListener (copy), u6 (copy), SetupFarmOwnerListener (copy), u4 (copy), u5 (copy), UpdateFarmTags (copy)
    local Farm = workspace:FindFirstChild("Farm");

    if not Farm then
        local u21 = nil;
        u21 = workspace.ChildAdded:Connect(function(p22) -- Line: 239
            -- upvalues: u21 (ref), SetupFarmFolderListener (ref)
            if p22.Name == "Farm" then
                u21:Disconnect();
                SetupFarmFolderListener();
            end;
        end);

        return;
    end;

    u6.ChildAdded = Farm.ChildAdded:Connect(function(p23) -- Line: 248
        -- upvalues: SetupFarmOwnerListener (ref)
        task.wait(0.1);
        SetupFarmOwnerListener(p23);
    end);
    u6.ChildRemoved = Farm.ChildRemoved:Connect(function(p24) -- Line: 253
        -- upvalues: u4 (ref), u5 (ref)
        if u4[p24] then
            if u4[p24].OwnerTag then
                u4[p24].OwnerTag:Destroy();
            end;

            if u4[p24].BillBoardGui then
                u4[p24].BillBoardGui:Destroy();
            end;

            u4[p24] = nil;
        end;

        if u5[p24] then
            u5[p24]:Disconnect();
            u5[p24] = nil;
        end;
    end);
    UpdateFarmTags();
end;

SetupFarmFolderListener();
u7 = SettingsService:GetSetting("YourFarmIcon");

local function UpdateTagVisibility() -- Line: 265
    -- upvalues: ShouldShowTags (copy), u4 (copy), u2 (ref)
    if ShouldShowTags() then
        if u2 then
            local Position = u2:GetPivot().Position;
            local Vector3_new_ret = Vector3.new(Position.X, 0, Position.Z);

            for _, v in pairs(u4) do
                local Position2 = v.Owner_Tag.Position;
                local v25 = (Vector3.new(Position2.X, 0, Position2.Z) - Vector3_new_ret).Magnitude >= 80;
                v.ToggleTransparency(v25);
                v.LastState = v25;
            end;
        end;

        return;
    end;

    for _, v in pairs(u4) do
        v.ToggleTransparency(false);
        v.LastState = false;
    end;
end;

LocalPlayer:GetAttributeChangedSignal("DoingOfflineCutscene"):Connect(UpdateTagVisibility);
LocalPlayer:GetAttributeChangedSignal("Loading_Screen_Finished"):Connect(UpdateTagVisibility);
LocalPlayer:GetAttributeChangedSignal("Finished_Loading"):Connect(UpdateTagVisibility);

function v1.SettingUpdated(p26: table, p27: boolean) -- Line: 293
    -- upvalues: SettingsService (copy), u7 (ref), ShouldShowTags (copy), u4 (copy), u2 (ref)
    local Setting = SettingsService:GetSetting("YourFarmIcon");

    if Setting ~= u7 then
        u7 = Setting;

        if not ShouldShowTags() then
            for _, v in pairs(u4) do
                v.BillBoardGui.Enabled = false;
                v.CurrentState = false;
                v.LastState = false;
            end;

            return;
        end;

        if u2 then
            local Position = u2:GetPivot().Position;
            local Vector3_new_ret = Vector3.new(Position.X, 0, Position.Z);

            for _, v in pairs(u4) do
                local Position2 = v.Owner_Tag.Position;
                local v28 = (Vector3.new(Position2.X, 0, Position2.Z) - Vector3_new_ret).Magnitude >= 80;
                v.ToggleTransparency(v28);
                v.LastState = v28;
            end;
        end;
    end;
end;

RunService.RenderStepped:Connect(function() -- Line: 324
    -- upvalues: u2 (ref), ShouldShowTags (copy), u4 (copy)
    if not (u2 and ShouldShowTags()) then
        for _, v in pairs(u4) do
            if v.CurrentState then
                v.ToggleTransparency(false);
            end;
        end;

        return;
    end;

    local Position = u2:GetPivot().Position;
    local Vector3_new_ret = Vector3.new(Position.X, 0, Position.Z);

    for _, v in pairs(u4) do
        if v.Owner_Tag then
            local Position2 = v.Owner_Tag.Position;
            local v29 = (Vector3.new(Position2.X, 0, Position2.Z) - Vector3_new_ret).Magnitude >= 80;

            if v.LastState ~= v29 then
                v.LastState = v29;
                v.ToggleTransparency(v29);
            end;
        end;
    end;
end);

function v1.Cleanup(p30) -- Line: 352
    -- upvalues: u4 (copy), u5 (copy), u6 (copy)
    for i, _ in pairs(u4) do
        if u4[i] then
            if u4[i].OwnerTag then
                u4[i].OwnerTag:Destroy();
            end;

            if u4[i].BillBoardGui then
                u4[i].BillBoardGui:Destroy();
            end;

            u4[i] = nil;
        end;
    end;

    for i, _ in pairs(u5) do
        if u5[i] then
            u5[i]:Disconnect();
            u5[i] = nil;
        end;
    end;

    for _, v in pairs(u6) do
        v:Disconnect();
    end;
end;

Players.PlayerRemoving:Connect(function(p31: userdata) -- Line: 366
    -- upvalues: u4 (copy)
    for _, child in workspace.Farm:GetChildren() do
        local Data = child:FindFirstChild("Important"):FindFirstChild("Data");

        if (Data.Owner.Value == "" or #Data.Owner.Value == 0) and u4[child] then
            if u4[child].OwnerTag then
                u4[child].OwnerTag:Destroy();
            end;

            if u4[child].BillBoardGui then
                u4[child].BillBoardGui:Destroy();
            end;

            u4[child] = nil;
        end;
    end;
end);

return v1;