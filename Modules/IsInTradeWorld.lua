-- Decompiled with Potassium's decompiler.

local TradeWorldData = require(game.ReplicatedStorage.Data.TradeWorldData);

return game.PlaceId == TradeWorldData.PlaceId and true or TradeWorldData.ForceInWorld == true;