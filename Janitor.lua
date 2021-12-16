-- My personal janitor class, by androooo06

local Janitor = {}
Janitor.__index = Janitor

function Janitor.new(...)
	local self = setmetatable({},Janitor)
	self.libraries = {}
	self.libraries.Default = {}
	for _,lib in pairs({...})do
		self:CreateLibrary(tostring(lib))
	end
	return self
end

function Janitor:CreateLibrary(name)
	if (self.libraries[name]) then
		warn("Passed Library already exists."); return true
	end
	self.libraries[name] = {}
end

function Janitor:RemoveLibrary(name)
	if not (self.libraries[name]) then
		warn("Passed Library is nil."); return true
	end
	self:Clean(name)
	self.libraries[name] = {}
end

function Janitor:Add(object,library)
	if (object == nil) then
		warn("Argument 1 is missing or nil."); return true		
	end
	local lib = library or "Default"
	if (typeof(object) == "table")then
		for _,item in pairs(object) do
			table.insert(self.libraries[lib],item)
		end
	else
		table.insert(self.libraries[lib],object)
	end
end

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
	elseif (library == nil) then
		for name,lib in pairs(self.libraries) do
			clean(lib)
			self.libraries[name] = nil
		end
	else
		warn("No library ["..tostring(library).."] was found to clean.")
		return true
	end
end

function Janitor:CleanAll()
	for libName,_ in pairs(self.libraries)do
		if (self.libraries[libName]) then
			self:Clean(libName)
		end
	end
end

function Janitor:Destroy()
	self:Clean()
	self = nil
end

return Janitor
