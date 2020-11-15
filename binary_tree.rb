require_relative 'tree_node'

class Tree
  attr_reader :root

  def initialize(ary)
    @root = build_tree(ary) if ary.class == Array
    @root = ary             if ary.class == TreeNode
  end

  def build_tree(ary)
    tree = sortedArraytoBST(ary.sort.uniq)
  end

  def sortedArraytoBST(ary)
    mid = (ary.length / 2)
    root = TreeNode.new(ary[mid])
    
    return root if ary.length < 2 

    root.left = sortedArraytoBST(ary[0...mid])
    root.right = sortedArraytoBST(ary[(mid + 1)..-1])

    return root
  end

  def insert(data, node=@root)
    if node.nil?
      return TreeNode.new(data)
    else
      if node.data == data
        return node
      elsif node.data < data
        node.right = insert(data, node.right)
      else
        node.left = insert(data, node.left)
      end
    end
    return node
  end
  
  def delete(data, node=@root)
    if node.nil?
      return "Node containing data not found"
    else
      if node.data == data
        array = preOrder
        array[array.index(data)] = nil
        @root = build_tree array.compact
      elsif node.data < data
        delete(data, node.right)
      else
        delete(data, node.left)
      end
    end
    return node
  end

  def find(data, node=@root)
    stack = [node]
    until stack.empty?
      node = stack.pop
      return node if node.data == data
      stack << node.left if node.left
      stack << node.right if node.right
    end
    false
  end

  def find_rec(data, node=@root)
    return false unless node
    return node if data == node.data

    find(data, node.left) || find(data, node.right)
  end

  def level_order
    return if @root.nil?
    
    queue = []
    queue << @root
    output = []

    while !queue.empty?
      current = queue.shift

      output << current.data unless current.data.nil?
      
      queue << current.left  unless current.left.nil?
      queue << current.right unless current.right.nil?
    end
    output
  end

  def level_order_rec

  end
  
  def inOrder
    # 1. Traverse left subtree
    # 2. Get Root data
    # 3. Traverse right subtree
  end

  def preOrder
    stack = []
    output = []
    current = @root
    while(current || !stack.empty?)
      while(current)
        stack.push(current)
        current = current.left
      end
      current = stack.pop
      output << current.data
      current = current.right
    end
    puts 'preorder traversal: '
    p output.join(' ')
    output.compact
  end

  def postOrder
    
  end

  def height
    
  end

  def depth
    
  end

  def balanced?
    
  end

  def rebalance
    
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if node.class != TreeNode
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
