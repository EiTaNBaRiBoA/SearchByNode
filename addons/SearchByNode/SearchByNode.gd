extends Node



"""
Finds node by a given type and returns it. (can search for an Object like Control,Node or even a Class)
_active_only = true default, if sets to true than will return only visible object
mainSubViewPort = null default, if you want to get objects only inside a subviewport (acting like current scene)
"""
## Finds node by a given type and returns it.
func findNodeByType(_type : Object,_active_only : bool = true,mainSubViewPort : SubViewport = null) -> Object:
	if not _check_cast_class(_type):
		push_error("Don't send an instantiated or null object ")
		return null
	else:
		var main_scene_node : Object = get_tree().current_scene
		if mainSubViewPort:
			main_scene_node = mainSubViewPort
		if main_scene_node:
			listOfAllNodesInParent.clear()
			_findByType(main_scene_node,_type)
			for child in listOfAllNodesInParent:
				if _active_only:
					if (child as CanvasItem).is_visible_in_tree() == _active_only :
						return child
				else:
					return child
	return null




"""
Finds all nodes by a given type and returns it. (can search for an Object like Control,Node or even a Class)
_active_only = true default, if sets to true than will return only visible objects
mainSubViewPort = null default, if you want to get objects only inside a subviewport (acting like current scene)
"""
## Finds all nodes by a given type and returns it.
func findNodesByType(_type : RefCounted , _active_only : bool = true,mainSubViewPort : SubViewport = null) -> Array[Object]:
	var listOfAllNodes: Array[Object] = []
	if not _check_cast_class(_type):
		push_error("Don't send an instantiated or null object ")
		return listOfAllNodes
	else:
		var main_scene_node : Object = get_tree().current_scene
		if mainSubViewPort:
			main_scene_node = mainSubViewPort
		if main_scene_node:
			listOfAllNodesInParent.clear()
			_findByType(main_scene_node,_type)
			for child in listOfAllNodesInParent:
				if _active_only:
					if (child as CanvasItem).is_visible_in_tree() == _active_only:
						listOfAllNodes.append(child)
				else:
					listOfAllNodes.append(child)
	return listOfAllNodes

## Get Node inside a node like if a character has a rigidbody, it will get it.
func findInnerNodeInNode(_type : Object, parentObject : Object, _active_only : bool = true) -> Object:
	if not _check_cast_class(_type):
		push_error("Don't send an instantiated or null object ")
		return null
	elif not parentObject:
		print("Parent Object is null")
	else:
		listOfAllNodesInParent.clear()
		_findByType(parentObject,_type)
		for child in listOfAllNodesInParent:
			if _active_only:
				if (child as CanvasItem).is_visible_in_tree() == _active_only:
					return child
			else:
				return child
	return null


## Get Nodes inside a node If there are multinodes that needs to be controlled inside a parent
func findInnerNodesInNode(_type : Object, parentObject : Object , _active_only : bool = true) -> Array[Object]:
	var listOfAllNodes: Array[Object] = []
	if not _check_cast_class(_type):
		push_error("Don't send an instantiated or null object in Type ")
		return listOfAllNodes
	elif not parentObject:
		print("Parent Object is null")
	else:
		listOfAllNodesInParent.clear()
		_findByType(parentObject,_type)
		for child in listOfAllNodesInParent:
			if _active_only:
				if (child as CanvasItem).is_visible_in_tree() == _active_only :
					listOfAllNodes.append(child)
			else:
				listOfAllNodes.append(child)
	return listOfAllNodes


var listOfAllNodesInParent : Array[Node] = []
func _findByType(parent : Node, type) -> void:
	for child : Node in parent.get_children():
		if is_instance_of(child, type):
			listOfAllNodesInParent.append(child)
		if child.get_children().size()>0:
			_findByType(child,type)
	return

'''
When working with several scenes you don't always want to get all objects of all scenes
but you want to get Object for a specific scene.
'''
##Gets the Main of the current scene instead of going to Tree (Usefull if you use SubViewPorts)
func get_main_scene_of_viewport(obj : Object):
	if not obj:
		return null
	if is_instance_of(obj.get_parent(),Viewport): ## we found the parent that is a viewport so we return the obj
		return obj
	else:
		return get_main_scene_of_viewport(obj.get_parent())



## Checks cast class
func _check_cast_class(castClass : Object) -> bool:
	if typeof(castClass) == Variant.Type.TYPE_NIL:
		return false
	var properties: Array = castClass.get_property_list()
	for property in properties:
		## Making sure this is a ref object and not an real object
		if(property.name == "RefCounted"):
			return true
	return false
