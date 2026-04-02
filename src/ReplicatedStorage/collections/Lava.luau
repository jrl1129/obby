--!strict

local DEBOUNCE_DURATION = 0.25

local module = {}

function module.init(instance: Instance)
    local part = instance :: Part

    -- default appearance for lava
    part.BrickColor = BrickColor.Red()
    part.Material = Enum.Material.Neon

    local debounce = {}
    local function onPartTouched(hit: Instance)
        
    end

    part.Touched:Connect(onPartTouched)
end

return module