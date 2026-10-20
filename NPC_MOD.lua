-- Decompiled with Potassium's decompiler.

local v1 = {};
local Field_Of_View_Module = require(game.ReplicatedStorage.Field_Of_View_Module);
local Frame_Popup_Module = require(game.ReplicatedStorage.Frame_Popup_Module);

function v1.Can_Speak(p2) -- Line: 4
    -- upvalues: Field_Of_View_Module (copy)
    return Field_Of_View_Module.Return_Core_FOV() == 70;
end;

function v1.Start_Speak(p3) -- Line: 13
    -- upvalues: Field_Of_View_Module (copy)
    Field_Of_View_Module.Change_FOV_CORE(65);
    Field_Of_View_Module.Change_FOV(65, 2);
end;

function v1.End_Speak(p4) -- Line: 17
    -- upvalues: Frame_Popup_Module (copy), Field_Of_View_Module (copy)
    if Frame_Popup_Module.Can() == true then
        Field_Of_View_Module.Change_FOV_CORE(70);
        Field_Of_View_Module.Change_FOV(70, 1);
    end;
end;

return v1;