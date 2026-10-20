-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);
local GardenGuideModules = ReplicatedStorage.Modules.GardenGuideModules;
local GGUI = require(GardenGuideModules.GGUI);
local GGData = require(GardenGuideModules.DataModules.GGData);
local SortButtonsLogic = require(GardenGuideModules.SortButtonsLogic);
local VirtualList = require(GardenGuideModules.VirtualList);
local u1 = ReplicatedStorage.GameEvents.GardenGuide.GetGGBlacklist:InvokeServer();
local SearchBar = GGUI.SearchBar;
local u2 = nil;

return {
    ConnectSearchBar = function() -- Line: 24, Name: ConnectSearchBar
        -- upvalues: u2 (ref), SearchBar (copy), GGUI (copy), GGData (copy), u1 (copy), PlantTraitsData (copy), SortButtonsLogic (copy), VirtualList (copy)
        if u2 then
            u2:Disconnect();
        end;

        local TextBox = SearchBar.Main.TextBox;
        u2 = TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 27
            -- upvalues: TextBox (copy), GGUI (ref), GGData (ref), u1 (ref), PlantTraitsData (ref), SortButtonsLogic (ref), VirtualList (ref)
            local Text = TextBox.Text;

            if not GGUI.CurrentPage then
                warn("GGSearchBarHandler | No current menu");

                return;
            end;

            local v3 = GGUI.CurrentPage.Name:gsub("Menu", "");

            if not GGData[v3] then
                return;
            end;

            local v4 = {};

            for _, v in GGData[v3].Data do
                table.insert(v4, v);
            end;

            GGUI.FilterAlgo = "Searchbar";
            GGUI.FilterType = Text;
            local v5 = `{string.upper((string.sub(Text, 1, 1)))}{string.lower((string.sub(Text, 2)))}`;

            if PlantTraitsData.TraitNames[v5] and not u1.PlantTraitsBlacklist[v5] then
                GGUI.FilterAlgo = "Trait";
            end;

            SortButtonsLogic.FilterAndSort(v4);
            VirtualList(GGUI.CurrentPage, GGUI.GridSFrame, v4);
        end);
    end
};