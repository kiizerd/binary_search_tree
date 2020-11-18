# Binary Search Tree
## Self-made Ruby Tree class and TreeNode class
---

### Tree class methods
---
**build_tree(ary)**
called from initialize, calls sorted_array_to_tree on ary

**sorted_array_to_tree(ary)**
called by build_tree, recursively builds a balanced tree starting with the middle value of a sorted array as root.

**insert(data, node=@root)**
recursively finds fitting leaf node and inserts given data

**delete(data, node=@root)**
recursively finds node deletes node containing data if node exists, else returns not found

**find(data, node=@root)**
finds node containing given data and returns it

**find_rec(data, node=@root)**
recursively finds node containing given data and returns it

**level_order**
returns an array of the trees nodes traversed in level order(breadth-first)

**preorder**
returns an array of the trees nodes traversed in preorder(depth-first, left-subtree, root, then right-subtree)

**inorder**
returns an array of the trees nodes traversed in inorder(depth-first, root, left-subtree, then right-subtree)

**postorder**
returns an array of the trees nodes traversed in postorder(depth-first, left-subtree, right-subtree, then root)

**height(node=@root)**
calculates height(aka maximum depth) of given node. Leaf nodes return 0

**depth(node=@root)**
calculates depth(number of nodes from root) of given node. Root returns 0

**balanced?**
calls check_balance and returns true if tree is balanced otherwise false

**check_balance**
recursively checks tree and subtrees for balance

**rebalance**
gets an array from a level_order traversal call, build_tree with new array, then sets root of self to root of new tree

