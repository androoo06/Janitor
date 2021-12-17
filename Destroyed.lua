--[[

This module acts as an optional extension to my janitor, or just a separate, stand-alone module.

This module monitors Instances for their destruction, since Instance.Destroyed is not yet
an event of Instances in roblox.

How it works (so you know what to avoid when using):
* checks if the instance is a descendant of the datamodel (game)
* if not, it's been destroyed (this means parenting an object to nil will trigger this module)

Basic usage:

local InstanceDestruction = require(this module)
local Destroyed = InstanceDescruction:GetDestroyedSignal(Instance) --> RBXScriptSignal
Destroyed:Connect(function(instanceName)
  print(instanceName,"was destroyed.")
end)

API (very basic extension module):

	* this is not a class, so no constructors
	* will clean itself up after instance gets destroyed

	Destroyed:GetDestroyedSignal(Instance)
		> returns the RBXScriptSignal that is fired when the given instance is determined to be destroyed
	
]]

local function check(Inst)
	local destroyed = not (Inst:IsDescendantOf(game))
	return destroyed
end

local Destroyed = {}

function Destroyed:GetDestroyedSignal(Inst)
	if (typeof(Inst) ~= "Instance") then
		error("[Destruction]: Instance must be passed, got",typeof(Inst))
	end
	local Event = Instance.new("BindableEvent")
	local Connection;
	Connection = Inst.AncestryChanged:Connect(function()
		if (check(Inst)) then
			-- the instance was destroyed
			Event:Fire(Inst.Name) -- fire event
			Event:Destroy() -- cleanup
			Connection:Disconnect() -- ^
		end
	end)
	return Event.Event -- returning the rbxscriptsignal
end

return Destroyed
