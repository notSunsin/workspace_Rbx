-- Decompiled with Potassium's decompiler.

if script.Parent.Parent.Parent.On_Sale.Value ~= true then
    script.Parent.Sale_Value.Visible = false;
    script.Parent.Cost_Text.Visible = true;
    script.Parent.Cost_Text.Position = UDim2.new(0.7, 0, 0.54, 0);
    script.Parent.Cost_Text.Size = UDim2.new(0.5, 0, 0.5, 0);

    return;
end;

script.Parent.Sale_Value.Size = UDim2.new(0.5, 0, 0.175, 0);
script.Parent.Sale_Value.Position = UDim2.new(0.7, 0, 0.35, 0);
script.Parent.Sale_Value.Visible = true;
script.Parent.Cost_Text.Visible = true;
script.Parent.Cost_Text.Position = UDim2.new(0.7, 0, 0.575, 0);
script.Parent.Cost_Text.Size = UDim2.new(0.5, 0, 0.4, 0);
script.Parent.Sale_Value.Text = tostring(script.Parent.Parent.Parent.On_Sale.Sale_Percent.Value) .. "% SALE";