## SearchByNode 🔍

This Godot tool provides a simple and efficient way to search and retrieve nodes within your scene tree (including within sub-viewports or specific parent nodes) based on their type and visibility. It's particularly useful for finding specific nodes without manually traversing the hierarchy.

### Features

- Find a single node by type (e.g., `Control`, `Node2D`, custom class).
- Find all nodes of a specific type.
- Option to search for active (visible) nodes only.
- Ability to limit the search to a specific sub-viewport.
- Find nodes within a specific parent node.

### Installation

1. **Download/Clone the GitHub repo:** Get the `SearchByNode.gd` script from the repository.
2. **Enable Autoload:** 
   - In your Godot project, go to **Project -> Project Settings -> AutoLoad**.
   - Click "Add" and select the `SearchByNode.gd` script.
   - Give it a name (e.g., "SearchByNode") in the AutoLoad settings. 
3. **Use `SearchByNode` in your scripts:** Now you can access the `SearchByNode` functions directly in any of your project's scripts.

### Usage

#### Finding Nodes

```gdscript
# Find the first active node of type ClassB
var objB_one : ClassB = SearchByNode.findNodeByType(ClassB)
if objB_one:
	print(objB_one.nameObj)

# Find all active nodes of type ClassA
var classA_array : Array[ClassA]
classA_array.assign(SearchByNode.findNodesByType(ClassA))
for objA_all : ClassA in classA_array:
	print(objA_all.nameObj)

# Find the first active ClassA node within 'self' node
var objA_innerOne : ClassA = SearchByNode.findInnerNodeInNode(ClassA,self)
if objA_innerOne:
	print(objA_innerOne.nameObj)

# Find all active ClassA nodes within 'self' node
var innerClassA_array : Array[ClassA]
innerClassA_array.assign(SearchByNode.findInnerNodesInNode(ClassA,self))
for objA_inner_all : ClassA in innerClassA_array:
	print(objA_inner_all.nameObj)
```

#### Finding the Main Scene of a Viewport

```gdscript
# Get the main scene of the viewport that 'self' belongs to
var main_scene = SearchByNode.get_main_scene_of_viewport(self) 
print(main_scene.name)
```

### Parameters

- **_type:** The type of node to search for (e.g., `ClassB`, `Control`, `Node`).
- **_active_only:** (Optional) If `true`, only visible nodes will be returned. Defaults to `true`.
- **mainSubViewPort:** (Optional) The `SubViewport` to limit the search within. Defaults to `null` (searches the entire scene).
- **parentObject:** The parent node to search within.

### Examples

**1. Finding a specific UI element:**

```gdscript
# Find the "StartButton" button
var start_button : Button = SearchByNode.findNodeByType(Button, true, null)
```

**2. Finding all enemies in a level:**

```gdscript
# Find all active "Enemy" nodes within the "Level" sub-viewport
for enemy : Enemy in SearchByNode.findNodesByType(Enemy,true,level):
	print(enemy.name)
```
###  Additional Examples

For more detailed examples and practical use cases, check out the **example scenes** included in this repository.
You can load and run these scenes in Godot to see `SearchByNode` in action. 
Feel free to experiment and adapt the examples to fit your specific needs.

### Notes

- The script assumes you are passing valid types and nodes as arguments.
- The `_active_only` parameter relies on the `is_visible_in_tree()` method, which might not be suitable for all scenarios (for example when looking for inactive objects also).
- The `get_main_scene_of_viewport()` function is useful when working with nested viewports.

### License

This asset is provided under the [MIT License](LICENSE).
