-- Decompiled with Potassium's decompiler.

local v1 = {};
game:GetService("UserInputService");
v1.NORMAL_FACE_MAP = {
    [Vector3.new(1, 0, 0)] = "Right",
    [Vector3.new(-1, 0, 0)] = "Left",
    [Vector3.new(0, 1, 0)] = "Top",
    [Vector3.new(0, -1, 0)] = "Bottom",
    [Vector3.new(0, 0, 1)] = "Back",
    [Vector3.new(0, 0, -1)] = "Front"
};
v1.set = require(script.DataStructures.set);
v1.linkedlist = require(script.DataStructures.linkedlist);
v1.bimap = require(script.DataStructures.bimap);
v1.table = require(script.SubModules.table);
v1.timeConversion = require(script.SubModules.timeConversion);
v1.deepCopy = require(script.SubModules.deepCopy);
v1.normalRandom = require(script.MathHelpers.normalRandom);
v1.lerp = require(script.MathHelpers.lerp);
v1.quadraticBezier = require(script.MathHelpers.quadraticBezier);
v1.color3ToHex = require(script.MathHelpers.color3ToHex);
v1.uniformVectorSphere = require(script.MathHelpers.uniformVectorSphere);
v1.chooseWeighted = require(script.MathHelpers.chooseWeighted);
v1.getDirectedDistance = require(script.MathHelpers.getDirectedDistance);
v1.isMobile = require(script.Input.isMobile);
v1.isConsole = require(script.Input.isConsole);
v1.isPC = require(script.Input.isPC);
v1.hasProperty = require(script.Object.hasProperty);
v1.findFirstAncestorWithTag = require(script.Object.findFirstAncestorWithTag);
v1.findFirstChildOfClassAndName = require(script.Object.FindFirstChildOfClassAndName);
v1.partContainsPoint = require(script.Object.partContainsPoint);
v1.firePlayerSet = require(script.Player.firePlayerSet);
v1.validatePlayer = require(script.Player.validatePlayer);
v1.isPlayerHRP = require(script.Player.IsPlayerHRP);
v1.getCharacters = require(script.Player.getCharacters);
v1.setCharacterTransparency = require(script.Player.setCharacterTransparency);
v1.setModelCollisionGroup = require(script.Model.setModelCollisionGroup);
v1.setModelTransparency = require(script.Model.setModelTransparency);
v1.getModelCornerVectors = require(script.Model.getModelCornerVectors);
v1.isPointInTerrain = require(script.World.isPointInTerrain);
v1.isPrivateServer = require(script.Server.isPrivateServer);

return v1;