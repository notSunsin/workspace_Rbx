-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UpdateLogData = require(ReplicatedStorage.Data.UpdateLog.UpdateLogData);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local DataService = require(ReplicatedStorage.Modules.DataService);
local SaveSlotController = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);
local UpdateLog = ReplicatedStorage.GameEvents.UpdateLog;
local ViewUpdateLog = UpdateLog.ViewUpdateLog;
local ForceOpen = UpdateLog.ForceOpen;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local UpdateLog2 = PlayerGui:WaitForChild("UpdateLog");
local UpdateList = UpdateLog2.UpdateLogFrame.Main.UpdateList;
local UpdatePage = UpdateLog2.UpdateLogFrame.Main.UpdatePageHolder.UpdatePage;
local Content = UpdatePage.Content;
local EmptyPage = UpdateLog2.UpdateLogFrame.Main.UpdatePageHolder.EmptyPage;
local SlotSwitch = Content.SlotSwitch;
local SwitchSlotButton = SlotSwitch.SwitchSlotButton;
local SENSOR = PlayerGui.SettingsUI.SettingsFrame.Main.Holder.SETTING_INSERTION_POINT.UpdateLogBtnHolder.Display.TOGGLE_BUTTON_HOLDER.TOGGLE_BUTTON.SENSOR;
local UpdateListTemplate = script.Templates.UpdateListTemplate;
local ItemTemplate = script.Templates.ItemTemplate;
local TextBlockTemplate = script.Templates.TextBlockTemplate;
local v1 = {};
local u2 = {
    UpdateListStyle = {
        UpdateListTemplate = Color3.fromRGB(34, 15, 0),
        PageTexture = Color3.fromRGB(255, 149, 57),
        BackgroundImage = Color3.fromRGB(255, 243, 230),
        UpdateNameUIStroke = Color3.fromRGB(55, 18, 2),
        UpdateNameUIGradient = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.413, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 160, 26)) })
    },
    UpdatePageStyle = {
        UpdatePage = Color3.fromRGB(141, 71, 24),
        ItemsFrame = Color3.fromRGB(255, 181, 32),
        DecorVignette = Color3.fromRGB(68, 19, 0),
        UpdateName = Color3.fromRGB(75, 30, 0),
        UpdateNameInletTexture = Color3.fromRGB(255, 169, 64),
        TitleUIGradient = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.413, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 160, 26)) }),
        TitleUIStroke = Color3.fromRGB(55, 18, 2),
        PageTexture = Color3.fromRGB(255, 149, 57),
        SwitchSlotButton = Color3.fromRGB(255, 181, 32)
    },
    ItemTemplate = {
        Sunrays = Color3.fromRGB(255, 218, 194)
    }
};
table.freeze(u2);
local u3 = {};
local u4 = {};

local function ShiftHue(p5, p6: number) -- Line: 79
    local _, v7, v8 = p5:ToHSV();

    return Color3.fromHSV(p6 / 360, v7, v8);
end;

local function ShiftGradientHue(p9: userdata, p10: number) -- Line: 84
    local v11 = {};

    for _, v in p9.Keypoints do
        local _, v12, v13 = v.Value:ToHSV();
        local Color3_fromHSV_ret = Color3.fromHSV(p10 / 360, v12, v13);
        table.insert(v11, ColorSequenceKeypoint.new(v.Time, Color3_fromHSV_ret));
    end;

    return ColorSequence.new(v11);
end;

local function ClearUpdateList() -- Line: 93
    -- upvalues: UpdateList (copy), u3 (copy)
    for _, child in UpdateList:GetChildren() do
        if child:IsA("ImageButton") then
            child:Destroy();
        end;
    end;

    for _, v in u3 do
        v:Disconnect();
    end;
end;

local function ToggleEmptyUpdatePage(p14: boolean) -- Line: 104
    -- upvalues: EmptyPage (copy), UpdatePage (copy)
    EmptyPage.Visible = p14;
    UpdatePage.Visible = not p14;
end;

local function GetLatestUpdateKey() -- Line: 109
    -- upvalues: UpdateLogData (copy)
    local v15 = nil;

    for i, v in UpdateLogData do
        if workspace:GetServerTimeNow() >= v.Date then
            if v15 then
                if v.Date > UpdateLogData[v15].Date then
                    v15 = i;
                end;
            else
                v15 = i;
            end;
        end;
    end;

    return v15;
end;

local function RenderUpdatePage(p16: string) -- Line: 130
    -- upvalues: UpdateLogData (copy), EmptyPage (copy), UpdatePage (copy), Content (copy), ItemInfoHover (copy), u4 (copy), ItemImageFinder (copy), ItemTemplate (copy), u2 (copy), TextBlockTemplate (copy), ShiftGradientHue (copy), SwitchSlotButton (copy), SlotSwitch (copy)
    local v17 = UpdateLogData[p16];

    if not v17 then
        EmptyPage.Visible = true;
        UpdatePage.Visible = false;

        return;
    end;

    if workspace:GetServerTimeNow() < v17.Date then
        EmptyPage.Visible = true;
        UpdatePage.Visible = false;

        return;
    end;

    EmptyPage.Visible = false;
    UpdatePage.Visible = true;
    Content.UpdateName.Title.Text = `{v17.DisplayName}`;
    local StylingImages = Content.UpdateName.StylingImages;

    if v17.StylingImages and v17.Hue then
        StylingImages.Left.Image = `{v17.StylingImages.LeftImage}`;
        local Left = StylingImages.Left;
        local LeftColor = v17.StylingImages.LeftColor;

        if not LeftColor then
            local Hue = v17.Hue;
            local _, v18, v19 = StylingImages.Left.ImageColor3:ToHSV();
            LeftColor = Color3.fromHSV(Hue / 360, v18, v19);
        end;

        Left.ImageColor3 = LeftColor;
        StylingImages.Right.Image = `{v17.StylingImages.RightImage}`;
        local Right = StylingImages.Right;
        local Hue = v17.Hue;
        local _, v20, v21 = StylingImages.Right.ImageColor3:ToHSV();
        Right.ImageColor3 = Color3.fromHSV(Hue / 360, v20, v21);
        local Right2 = StylingImages.Right;
        local RightColor = v17.StylingImages.RightColor;

        if not RightColor then
            local Hue2 = v17.Hue;
            local _, v22, v23 = StylingImages.Right.ImageColor3:ToHSV();
            RightColor = Color3.fromHSV(Hue2 / 360, v22, v23);
        end;

        Right2.ImageColor3 = RightColor;
        StylingImages.Visible = true;
    else
        StylingImages.Visible = false;
    end;

    Content.UpdateImage.Image = `{v17.Image}`;
    ItemInfoHover:RemoveRewardTable("UpdateLog");
    local Main = Content.ItemsFrame.Main;

    for _, child in Main:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    table.clear(u4);
    local Items = v17.Items;
    ItemInfoHover:AddRewardTable("UpdateLog", Items);

    for i = 1, #Items do
        local Type = Items[i].Type;
        local Value = Items[i].Value;
        local v24 = ItemImageFinder(Value, Type);
        local v25;

        if v24 then
            local v26 = ItemTemplate:Clone();
            v26.ItemImage.Image = `{v24}`;
            v26.Parent = Main;

            if v17.Hue then
                local Sunrays = v26.Sunrays;
                local Hue = v17.Hue;
                local _, v27, v28 = u2.ItemTemplate.Sunrays:ToHSV();
                Sunrays.ImageColor3 = Color3.fromHSV(Hue / 360, v27, v28);
            end;

            table.insert(u4, v26.Sunrays);
            v26:AddTag("ItemInfoHoverTag");
            v26:SetAttribute("UUID", (`UpdateLog_{Type}_{Value}`));
            v25 = i;
        else
            v25 = i;
        end;
    end;

    for _, v in Content:QueryDescendants(".UpdateLogTextBlock") do
        if v:IsA("Frame") then
            v:Destroy();
        end;
    end;

    local v29 = 4;

    for i, v in v17.TextBlocks do
        local v30 = TextBlockTemplate:Clone();
        v30.Title.Text = `{v.Title}`;
        v30.Info.Text = `{v.Body}`;
        v30.LayoutOrder = v29 + (i - 1);
        v30.Parent = Content;
        v30:AddTag("UpdateLogTextBlock");
        v29 = v29 + 1;
    end;

    if v17.Hue then
        local UpdatePageStyle = u2.UpdatePageStyle;
        local Hue = v17.Hue;
        local _, v31, v32 = UpdatePageStyle.UpdatePage:ToHSV();
        UpdatePage.BackgroundColor3 = Color3.fromHSV(Hue / 360, v31, v32);

        for i, v in UpdatePageStyle do
            local v33 = UpdatePage:FindFirstChild(`{i}`, true);

            if v33 then
                if v33:IsA("ImageLabel") then
                    local Hue2 = v17.Hue;
                    local _, v34, v35 = v:ToHSV();
                    v33.ImageColor3 = Color3.fromHSV(Hue2 / 360, v34, v35);
                elseif v33:IsA("UIGradient") then
                    v33.Color = ShiftGradientHue(v, v17.Hue);
                elseif v33:IsA("UIStroke") then
                    local Hue2 = v17.Hue;
                    local _, v36, v37 = v:ToHSV();
                    v33.Color = Color3.fromHSV(Hue2 / 360, v36, v37);
                elseif v33:IsA("Frame") or v33:IsA("TextButton") then
                    local Hue2 = v17.Hue;
                    local _, v38, v39 = v:ToHSV();
                    v33.BackgroundColor3 = Color3.fromHSV(Hue2 / 360, v38, v39);
                end;
            end;
        end;
    end;

    if v17.PageTextureConfig then
        UpdatePage.PageTexture.Image = `{v17.PageTextureConfig.TextureImage}`;
        UpdatePage.PageTexture.TileSize = v17.PageTextureConfig.PageTileSize or UDim2.fromScale(0.2, 0.21);
        UpdatePage.PageTexture.ImageTransparency = v17.PageTextureConfig.ImageTransparency or 0;
    else
        UpdatePage.PageTexture.Image = "rbxassetid://15910695828";
        UpdatePage.PageTexture.TileSize = UDim2.fromScale(0.2, 0.21);
        UpdatePage.PageTexture.ImageTransparency = 0.75;
    end;

    SwitchSlotButton:SetAttribute("SlotKey", v17.SwitchToSlot);
    SlotSwitch.Visible = v17.SwitchToSlot and true or false;
    SlotSwitch.LayoutOrder = 4;

    if v17.SlotStyling then
        SlotSwitch.Decor.LeftSlotImage.Image = v17.SlotStyling.SlotIconLeft;
        SlotSwitch.Decor.LeftSlotImage.ImageColor3 = v17.SlotStyling.LeftColor or Color3.fromRGB(255, 255, 255);
        SlotSwitch.Decor.RightSlotImage.Image = v17.SlotStyling.SlotIconRight;
        SlotSwitch.Decor.RightSlotImage.ImageColor3 = v17.SlotStyling.RightColor or Color3.fromRGB(255, 255, 255);
    end;
end;

local function RenderUpdateList() -- Line: 263
    -- upvalues: ClearUpdateList (copy), UpdateLogData (copy), UpdateListTemplate (copy), u2 (copy), ShiftGradientHue (copy), UpdateList (copy), RenderUpdatePage (copy), u3 (copy)
    ClearUpdateList();
    local v40 = {};

    for i, v in UpdateLogData do
        local ServerTimeNow = workspace:GetServerTimeNow();

        if ServerTimeNow >= v.Date then
            local math_round_ret = math.round(ServerTimeNow - v.Date);
            local math_round_ret2 = math.round(math_round_ret / 60 / 60 / 24);
            local v41 = UpdateListTemplate:Clone();
            v41.Name = `{i}`;
            v41.ContentHolder.UpdateName.Text = `{v.DisplayName}`;
            v41.ContentHolder.TimeAgo.Text = `{math_round_ret2} days ago`;
            v41.BackgroundImage.Image = `{v.Image}`;
            v41:SetAttribute("TimeAgo", math_round_ret);
            local u42;

            if v.Hue then
                local UpdateListStyle = u2.UpdateListStyle;
                local Hue = v.Hue;
                local _, v43, v44 = UpdateListStyle.UpdateListTemplate:ToHSV();
                v41.BackgroundColor3 = Color3.fromHSV(Hue / 360, v43, v44);
                u42 = i;
                local v45 = v;

                for i2, v2 in UpdateListStyle do
                    local v46 = v41:FindFirstChild(`{i2}`, true);

                    if v46 then
                        if v46:IsA("ImageLabel") then
                            local Hue2 = v45.Hue;
                            local _, v47, v48 = v2:ToHSV();
                            v46.ImageColor3 = Color3.fromHSV(Hue2 / 360, v47, v48);
                        elseif v46:IsA("UIGradient") then
                            v46.Color = ShiftGradientHue(v2, v45.Hue);
                        elseif v46:IsA("UIStroke") then
                            local Hue2 = v45.Hue;
                            local _, v49, v50 = v2:ToHSV();
                            v46.Color = Color3.fromHSV(Hue2 / 360, v49, v50);
                        elseif v46:IsA("Frame") then
                            local Hue2 = v45.Hue;
                            local _, v51, v52 = v2:ToHSV();
                            v46.BackgroundColor3 = Color3.fromHSV(Hue2 / 360, v51, v52);
                        end;
                    end;
                end;

                local StylingImages = v41.StylingImages;

                if v45.StylingImages and v45.Hue then
                    StylingImages.Left.Size = UDim2.fromScale(v45.StylingImages.LeftSize or 1, v45.StylingImages.LeftSize or 1);
                    StylingImages.Left.Image = `{v45.StylingImages.LeftImage}`;
                    local Left = StylingImages.Left;
                    local LeftColor = v45.StylingImages.LeftColor;

                    if not LeftColor then
                        local Hue2 = v45.Hue;
                        local _, v53, v54 = StylingImages.Left.ImageColor3:ToHSV();
                        LeftColor = Color3.fromHSV(Hue2 / 360, v53, v54);
                    end;

                    Left.ImageColor3 = LeftColor;
                    StylingImages.Right.Size = UDim2.fromScale(v45.StylingImages.RightSize or 1, v45.StylingImages.RightSize or 1);
                    StylingImages.Right.Image = `{v45.StylingImages.RightImage}`;
                    local Right = StylingImages.Right;
                    local RightColor = v45.StylingImages.RightColor;

                    if not RightColor then
                        local Hue2 = v45.Hue;
                        local _, v55, v56 = StylingImages.Right.ImageColor3:ToHSV();
                        RightColor = Color3.fromHSV(Hue2 / 360, v55, v56);
                    end;

                    Right.ImageColor3 = RightColor;
                    StylingImages.Visible = true;
                else
                    StylingImages.Visible = false;
                end;

                if v45.PageTextureConfig then
                    v41.PageTexture.Image = `{v45.PageTextureConfig.TextureImage}`;
                    v41.PageTexture.TileSize = v45.PageTextureConfig.ListItemTileSize or UDim2.fromScale(0.2, 0.79);
                    v41.PageTexture.ImageTransparency = v45.PageTextureConfig.ImageTransparency or 0;
                else
                    v41.PageTexture.Image = "rbxassetid://15910695828";
                    v41.PageTexture.TileSize = UDim2.fromScale(0.2, 0.79);
                    v41.PageTexture.ImageTransparency = 0;
                end;
            else
                u42 = i;
            end;

            v41.Parent = UpdateList;
            table.insert(v40, v41);
            local v57 = v41.Activated:Connect(function() -- Line: 334
                -- upvalues: RenderUpdatePage (ref), u42 (copy)
                RenderUpdatePage(u42);
            end);
            table.insert(u3, v57);
        end;
    end;

    table.sort(v40, function(p58, p59) -- Line: 340
        local v60 = p58:GetAttribute("TimeAgo") or (1 / 0);
        local v61 = p59:GetAttribute("TimeAgo") or (1 / 0);

        if v60 == v61 then
            return p58.ContentHolder.UpdateName.Text < p59.ContentHolder.UpdateName.Text;
        end;

        return v60 < v61;
    end);

    for i, v in v40 do
        v.LayoutOrder = i;
    end;
end;

local function OpenUpdateLog(p62: boolean?, p63: boolean?) -- Line: 354
    -- upvalues: RenderUpdateList (copy), GetLatestUpdateKey (copy), RenderUpdatePage (copy), DataService (copy), LocalPlayer (copy), GuiController (copy), UpdateLog2 (copy), ViewUpdateLog (copy)
    RenderUpdateList();
    local v64 = GetLatestUpdateKey();

    if v64 then
        RenderUpdatePage(v64);
    end;

    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    if not p63 and Data.LastSeenUpdateLog == v64 then
        return;
    end;

    if not (p62 or (not Data.FirstTimeUser or Data.FirstTimeUser ~= true)) then
        return;
    end;

    if not (p62 or (not LocalPlayer:GetAttribute("FirstTimePlayer") or LocalPlayer:GetAttribute("FirstTimePlayer") ~= true)) then
        return;
    end;

    GuiController:Open(UpdateLog2);
    ViewUpdateLog:FireServer(v64);
end;

function v1.Start(p65) -- Line: 376
    -- upvalues: UpdateLog2 (copy), GuiController (copy), SENSOR (copy), SwitchSlotButton (copy), SaveSlotController (copy), RunService (copy), u4 (copy), OpenUpdateLog (copy)
    UpdateLog2.UpdateLogFrame.Header.Close.Activated:Connect(function() -- Line: 379
        -- upvalues: GuiController (ref), UpdateLog2 (ref)
        GuiController:Close(UpdateLog2);
    end);
    SENSOR.Activated:Connect(function() -- Line: 383
        -- upvalues: GuiController (ref), UpdateLog2 (ref)
        GuiController:Open(UpdateLog2);
    end);
    SwitchSlotButton.Activated:Connect(function() -- Line: 388
        -- upvalues: SwitchSlotButton (ref), SaveSlotController (ref), GuiController (ref), UpdateLog2 (ref)
        local Attribute = SwitchSlotButton:GetAttribute("SlotKey");

        if not Attribute then
            warn("Missing Slot Key Attribute!");

            return;
        end;

        SaveSlotController:ChangeSlots(Attribute);
        GuiController:Close(UpdateLog2);
    end);
    RunService.RenderStepped:Connect(function(p66) -- Line: 397
        -- upvalues: u4 (ref)
        if #u4 == 0 then
            return;
        end;

        local v67 = 30 * p66;

        for _, v in u4 do
            v.Rotation = (v.Rotation + v67) % 360;
        end;
    end);
    OpenUpdateLog();
end;

task.spawn(v1.Start, v1);
UpdateService.OnUpdated:Connect(function() -- Line: 410
    -- upvalues: OpenUpdateLog (copy)
    OpenUpdateLog();
end);
ForceOpen.OnClientEvent:Connect(function(p68: boolean?, p69: boolean?) -- Line: 414
    -- upvalues: OpenUpdateLog (copy)
    OpenUpdateLog(p68, p69);
end);

return v1;