-- Decompiled with Potassium's decompiler.

return {
    Name = "thru",
    Description = "Teleports you through whatever your mouse is hovering over, placing you equidistantly from the wall.",
    Group = "DefaultDebug",
    Aliases = { "t", "through" },
    Args = { {
            Type = "number",
            Name = "Extra distance",
            Description = "Go through the wall an additional X studs.",
            Default = 0
        } },

    ClientRun = function(p1, p2) -- Line: 15, Name: ClientRun
        local Mouse = p1.Executor:GetMouse();
        local Character = p1.Executor.Character;

        if not (Character and Character:FindFirstChild("HumanoidRootPart")) then
            return "You don\'t have a character.";
        end;

        local Position = Character.HumanoidRootPart.Position;
        local v3 = Mouse.Hit.p - Position;
        Character:MoveTo(v3 * 2 + v3.unit * p2 + Position);

        return "Blinked!";
    end
};