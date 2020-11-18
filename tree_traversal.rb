## Breadth-first ie QUEUE

# start with root           Rt-1
# then consecutive levels   /  \
#                          L2  R2

## Depth-first ie STACK

### Preorder Traversal
# start with root           Rt-1
# then left                 /  \
# then right              L-2|R-3
#                         /      \
#                       2-1      3-1
#                       / \
#                   2-1-1|2-1-2

##  indentify root
##  recurse until callers left sub tree is empty
##  recurse until callers right sub tree is empty
##  up one level


### Inorder Traversal (Binary Search Tree) -- Returns SORTED List
# start with left           Rt-2
# then root                 /  \
# then right               L-1|R-3

## search left of root
## search left of caller until no left found
## identify caller
## search right of caller (recurse)

### Postorder Traversal
# start with left            Rt-3
# then right                 /  \
# then root               L-1  R-2


