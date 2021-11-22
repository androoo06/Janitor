local Janitor = {}
Janitor.__index = Janitor

function Janitor.new()
	local self = setmetatable({},Janitor)
	self.libraries = {}
	self.libraries.Default = {}
	return self
end

function Janitor:CreateLibrary(name)
	assert(self.libraries[name]==nil,"Library already exists.")
	self.libraries[name] = {}
end

function Janitor:RemoveLibrary(name)
	assert(self.libraries[name]~=nil,"Passed Library is nil.")
	self:Clean(name)
	self.libraries[name] = {}
end

function Janitor:Add(object,library)
	assert(object~=nil,"Argument 1 is missing or nil.")
	assert(library~=nil,"Argument 2 is missing or nil.")
	assert(self.libraries[library]~=nil,"Passed Library is nil.")
	
	if (typeof(object)=="table")then
		for _,item in pairs(object) do
			table.insert(self.libraries[library],item)
		end
	else
		table.insert(self.libraries[library],object)
	end
end

-- @alias CleanAll
function Janitor:Clean(library)
	local function clean(tab)
		for _,item in pairs(tab) do
			if (typeof(item) == "Instance") then
				item:Destroy()
			elseif (typeof(item) == "RBXScriptConnection") then
				item:Disconnect()
			end
			item = nil
		end
	end
	if (self.libraries[library]) then
		clean(self.libraries[library])
		self.libraries[library] = {}
	else
		for name,lib in pairs(self.libraries) do
			clean(lib)
			self.libraries[name] = nil
		end
	end
end

function Janitor:Destroy()
	self:CleanAll()
	self = nil
end

-- Aliases / Wrappers --

-- @function Clean
function Janitor:CleanAll()
	self:Clean()
end

return Janitor
