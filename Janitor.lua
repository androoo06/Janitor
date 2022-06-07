local Janitor = {}
Janitor.__index = Janitor

function Janitor.__Clean(tab)
	for k, item in pairs (tab) do
		if (typeof(item) == "Instance") and not (item:IsA("Player")) then
			item:Destroy()
		elseif (typeof(item) == "RBXScriptConnection") then
			item:Disconnect()
		elseif (type(item) == "table") and (item.Destroy) then
			item:Destroy()
		elseif (type(item) == "table") then
			Janitor.__Clean(item) -- deep search
		end

		tab[k] = nil
		item   = nil
	end
end

function Janitor.new(...)
	local self = setmetatable({}, Janitor)

	self.libraries 		   = {}
	self.libraries.Default = {}

	for _,lib in pairs {...} do
		self:CreateLibrary(tostring(lib))
	end

	return self
end

function Janitor:CreateLibrary(name)
	if (self.libraries[name]) then
		warn("Passed Library ["..name.."] already exists."); return true
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

function Janitor:Add(object, library)
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
	if (self.libraries[library]) then
		Janitor.__Clean(self.libraries[library])
		self.libraries[library] = {}
	elseif (library == nil) then
		for name,lib in pairs(self.libraries) do
			Janitor.__Clean(lib)
			self.libraries[name] = nil
		end
	else
		warn("No library ["..tostring(library).."] was found to clean.")
		return true
	end
end

function Janitor:CleanAll()
	for libName, _ in pairs (self.libraries) do
		self:Clean(libName)
	end
end

function Janitor:Destroy()
	self:Clean()
	self = nil
end

return Janitor
