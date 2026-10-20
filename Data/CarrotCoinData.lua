-- Decompiled with Potassium's decompiler.

return {
    Shop = {
        Products = { {
                ProductId = 3498799492,
                FallbackPrice = 99
            }, {
                ProductId = 3498801169,
                FallbackPrice = 275
            }, {
                ProductId = 3498802125,
                FallbackPrice = 499
            } }
    },

    GetCurrentDayString = function(p1: userdata) -- Line: 29, Name: GetCurrentDayString
        return `{p1:FormatUniversalTime("YYYY", "en-us")}{p1:FormatUniversalTime("MM", "en-us")}{p1:FormatUniversalTime("DD", "en-us")}`;
    end
};