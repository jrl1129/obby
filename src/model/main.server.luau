--!strict

--[[
    This script is responsible for moving the contents of each folder of this script's ancestor to their respective location.
    Everything is stored in this Model so it can be updated and replicate in every place.
]]

local model = script.Parent
local children = model:GetChildren()

for _, child in children do
    -- ignore script
    if child == script then
        continue
    end

    -- retrieving service from folder name
    local service_name = child.Name
    local service = game:FindService(service_name)
    if not service then
        continue
    end

    -- set final parent for each object in folder
    for _, obj in child:GetChildren() do
        obj.Parent = service
    end
end