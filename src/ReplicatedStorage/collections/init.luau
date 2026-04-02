--!strict

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local IS_INITIALIZED = "Initialized"

local module = {}

function module:RegisterAll()
	local isClient = RunService:IsClient()

	local children = script:GetChildren()
	for _, child in children do
		local module = require(child) :: { isClient: boolean, init: (Instance) -> () }
		local canRun = isClient and module.isClient or not isClient and not module.isClient

		-- skip iteration if incorrect run context
		if not canRun then
			continue
		end

		-- ensures previous initialized instances aren't re-initialized because of streaming
		local function init(instance: Instance)
			if instance:GetAttribute(IS_INITIALIZED) then
				return
			end

			instance:SetAttribute(IS_INITIALIZED, true)
			module.init(instance)
		end

		local tag = child.Name
		local tagged = CollectionService:GetTagged(tag)
		local signal = CollectionService:GetInstanceAddedSignal(tag)

		-- initialize ModuleScript for each instance of tag that exists or is added
		signal:Connect(init)
		for _, instance in tagged do
			module.init(instance)
		end
	end
end

return module
