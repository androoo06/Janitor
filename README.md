# Janitor

This class is a very simply constructed janitor that has the purpose of delegating certain tasks or a certain set of tasks to a particular library. 
The use-case of this Janitor over others is mainly if there are multiple categories of [connections, instances] you'd like to store for a particular purpose.

Instead of making N separate janitors, 1 class with named libraries can accomplish the same as others.

# API:

## Constructor

Janitor.new() :Janitor
* constructs and returns a new janitor object, and creates 1 library called "Default."

## Methods
### **All methods are Void.**
Janitor:CreateLibrary(name)
* creates a new category of tasks with the given name.
  - will throw an error if library is already created.

Janitor:RemoveLibrary(name)
* cleans and removes the library with the given name.
  - will throw an error if library has not been created.

Janitor:Clean([optional] library)
* cleans the library with the provided name (but will not remove it)
  - if no library is provided, Janitor will clean and remove all libraries

## Destructor
Janitor:Destroy()
* calls Janitor:CleanAll() and renders the janitor unusable from that point forward

## Aliases
Janitor:CleanAll()
* behaves as Janitor:Clean() does, without providing an argument
