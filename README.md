# Janitor

This class is a very simply constructed janitor that has the purpose of delegating certain tasks or a certain set of tasks to a particular library. 
The use-case of this Janitor over others is mainly if there are multiple categories of [connections, instances] you'd like to store for a particular purpose.

Instead of making N separate janitors, 1 class with named libraries can accomplish the same as others.

### Destroyed Module
This basic module can be used in unison with the janitor or on its own; its purpose is to provide an rbxscriptsignal (event) to monitor an Instance's destruction, whether
it be through use of Instance:Destroy() or "natural cause destructions." Further documentation can be found in the module itself (Destroyed.lua)

# API:

## Constructor

Janitor.new(...) :Janitor
* constructs and returns a new janitor object
* each argument in the tuple this constructor takes will be converted into a string and created into a new library for the janitor.
* there will also be 1 library created regardless of the arguments passed in the constructor, named "Default".

## Methods
### **All methods are Void.**
Janitor:CreateLibrary(name)
* creates a new category of tasks with the given name.
  - will produce a warning and return true if library is already created.

Janitor:RemoveLibrary(name)
* cleans and removes the library with the given name.
  - will produce a warning and return true if library has not been created.

Janitor:Add(object, [optional] library)
* will add the object (given it is not nil) to the given library.
  - will produce a warning and return true if the object is nil.
  - will use the "Default" library if the library argument is nil.
  - supported object types are:
    > any primitive types
    
    > tables
    
    > instances

Janitor:Clean([optional] library)
* cleans the library with the provided name (but will not remove it).
  - if no library is provided, janitor will clean and remove all libraries (so treat this with caution!).
  - will produce a warning and return true if a non-nil library is provided that does not exist in the janitor.


Janitor:CleanAll()
* Cleans, but does not destroy, all libraries in the janitor.

## Destructor
Janitor:Destroy()
* calls Janitor:Clean() [no arguments] and renders the janitor unusable from that point forward.
