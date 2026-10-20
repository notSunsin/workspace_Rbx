-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenModel = require(game.ReplicatedStorage.Modules.TweenModel);
require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local SoundPlayer = require(ReplicatedStorage.Modules.SoundPlayer);
local SoundData = require(ReplicatedStorage.Data.SoundData);
local _ = require(game.ReplicatedStorage.Data.PetRegistry).PetList;
local Assets = game.ReplicatedStorage:WaitForChild("Assets");
Assets:WaitForChild("Models"):WaitForChild("EggModels");
local VFX = Assets.VFX;

return function(u1) -- Line: 18
    -- upvalues: SoundPlayer (copy), SoundData (copy), TweenModel (copy), VFX (copy)
    task.spawn(function() -- Line: 19
        -- upvalues: u1 (copy), SoundPlayer (ref), SoundData (ref), TweenModel (ref), VFX (ref)
        local v2 = u1:GetPivot() * CFrame.new(0, 3, 0);
        local v3 = u1:GetScale() * 2;
        SoundPlayer:PlaySound(SoundData.General.PetEggRenderer.RisingAccent);
        TweenModel(u1, TweenInfo.new(1), {
            CFrame = v2
        }):Play();
        task.wait(0.1);
        local v4 = TweenModel(u1, TweenInfo.new(2), {
            Scale = v3
        });
        v4:Play();
        v4.Completed:Connect(function() -- Line: 44
            -- upvalues: SoundPlayer (ref), SoundData (ref), u1 (ref), VFX (ref)
            os.clock();
            SoundPlayer:PlaySound(SoundData.General.PetEggRenderer.Pop);
            local Part = Instance.new("Part");
            Part.Size = u1:GetExtentsSize();
            Part.CFrame = u1:GetPivot();
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.Transparency = 1;
            Part.Parent = workspace.Visuals;
            local v5 = VFX.EggPop.PopParticles:Clone();
            v5.Color = ColorSequence.new(u1.PrimaryPart.Color);
            v5.Parent = Part;
            v5:Emit(20);
            warn((`TryDoHatchAnim | Couldnt get PetType from {u1:GetFullName()} in time!`));
            u1:Destroy();
            task.wait(2);
            Part:Destroy();
        end);
    end);
end;