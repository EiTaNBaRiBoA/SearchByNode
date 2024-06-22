extends Control


func _ready() -> void:
	print("----------Find one ClassB Visible Node-------------------")
	var objB_one : ClassB = SearchByNode.findNodeByType(ClassB,true)
	if objB_one:
		print(objB_one.nameObj)
	
	print("----------Find all ClassA Visible only Nodes-------------------")
	var classA_array : Array[ClassA]
	classA_array.assign(SearchByNode.findNodesByType(ClassA,true))
	for objA_all : ClassA in classA_array:
		print(objA_all.nameObj)
	
	print("----------Find all ClassA Visible and not Visible Nodes-------------------")
	var classA_array_all_visiibility : Array[ClassA]
	classA_array_all_visiibility.assign(SearchByNode.findNodesByType(ClassA,false))
	for objA_all : ClassA in classA_array_all_visiibility:
		print(objA_all.nameObj)
	
	
	
	print("----------Find one InnerNode Visible Node-------------------")
	var objA_innerOne : ClassA = SearchByNode.findInnerNodeInNode(ClassA,self)
	if objA_innerOne:
		print(objA_innerOne.nameObj)
	print("----------Find all inner nodes of type ClassA Visible-------------------")
	var innerClassA_array : Array[ClassA]
	innerClassA_array.assign(SearchByNode.findInnerNodesInNode(ClassA,self))
	for objA_inner_all : ClassA in innerClassA_array:
		print(objA_inner_all.nameObj)
	
	
	
	#SearchByNode.findNodeByType(ClassA.new(),true) # Do not use it like this as it will produce Error
	#SearchByObject.findNodeByType(null,true) # Do not use it like this as it will produce Error
