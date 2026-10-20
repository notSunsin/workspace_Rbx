-- Decompiled with Potassium's decompiler.

return {
    Shop = {
        Products = { {
                ProductId = 3520248432,
                FallbackPrice = 129
            }, {
                ProductId = 3520249205,
                FallbackPrice = 325
            }, {
                ProductId = 3520249204,
                FallbackPrice = 599
            } }
    },

    GetCurrentDayString = function(p1: userdata) -- Line: 29, Name: GetCurrentDayString
        return `{p1:FormatUniversalTime("YYYY", "en-us")}{p1:FormatUniversalTime("MM", "en-us")}{p1:FormatUniversalTime("DD", "en-us")}`;
    end
};