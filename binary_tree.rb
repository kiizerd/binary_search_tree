require_relative 'tree_node'

class Tree
  attr_reader :root

  def initialize(ary)
    @root = build_tree(ary)   if ary.class == Array
    @root = ary               if ary.class == TreeNode
  end

  def build_tree(ary)
    return sorted_array_to_tree(ary.sort.uniq) if ary.class == Array
  end

  def sorted_array_to_tree(ary)
    mid = (ary.length / 2)

    if ary[mid].class == TreeNode
      root = ary[mid]
    elsif ary[mid].class == NilClass
      root = ary[mid]
    else
      root = TreeNode.new(ary[mid])
    end
    
    return root if ary.length < 2 

    root.left = sorted_array_to_tree(ary[0...mid])
    root.right = sorted_array_to_tree(ary[(mid + 1)..-1])

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
        array = inorder
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

  def level_order_rec(node=@root)
    h = height
    results = []
    depth = 1
    while depth <= h
      results << level_order_rec_helper(node, depth)
      depth += 1
    end
    return results.flatten.compact
  end
  
  def level_order_rec_helper(node, d, level=[])
    return level if node.nil?
    
    if d == 1
      level << node.data
    elsif d > 1
      level_order_rec_helper(node.left, d - 1, level)
      level_order_rec_helper(node.right, d - 1, level)
    end
    return level
  end
  
  def preorder
    stack = []
    output = []

    stack << @root
    current = @root

    until stack.empty?
      current = stack.pop
      output << current.data unless current.nil?

      stack << current.right unless current.nil?
      stack << current.left  unless current.nil?
    end
    output.compact
  end
    
  def inorder
    stack = []
    output = []

    current = @root
    
    until current.nil? and stack.empty?
      until current.nil?
        stack << current
        current = current.left
      end

      current = stack.pop

      output << current.data
      current = current.right
    end
    output.compact
  end

  def postorder
    stack = []
    output = []

    current = @root

    until current.nil? and stack.empty?
      
      until current.nil?
        stack << current
        current = current.left
      end
      
      if stack[-1].right.nil?     # leaf node reached, no children
        hold = stack.pop          # visit leaf 
        output << hold.data
      else                        # parent has right node
        current = stack[-1].right
      end
      
      unless stack[-1].right.nil? or hold.nil?
        if hold == stack[-1].right  # leaf is parents right child
          hold = stack.pop
          output << hold.data
        else                        # leaf is parents left child
          current = stack[-1].right unless stack[-1].right.nil?
          output << hold.data
        end
      end
      output = output.uniq.compact
      if output.length == inorder.length - 1 and stack[-1] == @root
        stack.pop
        output << @root.data
      end

    end
    output
  end
  
  def height(node=@root)
    node = find(node) if node.class == Integer
    
    height = 0

    if node.left.nil? and node.right.nil?
      return height
    else

      unless node.left.nil?
        left = height(node.left)   
        height = left if left > height
      end

      unless node.right.nil?
        right = height(node.right) 
        height = right if right > height
      end
      return height + 1
    end
  end

  def depth(node=@root)
    node = find(node) if node.class == Integer
    return false  unless node.class == TreeNode
    current = @root
    depth = 0

    while current != node
      if current < node
        current = current.right
      else
        current = current.left
      end
      depth += 1
    end
    return depth
  end

  def balanced?(node=@root)
    return check_balance(@root) != -1
  end

  def check_balance(node)
    return 0 if node.nil?
    left = check_balance(node.left)

    return -1 if left == -1

    right = check_balance(node.right)

    return -1 if right == -1

    if (left - right).abs > 1
      return -1
    else
      return 1 + [left, right].max
    end
    
  end

  def rebalance
    ary = self.level_order
    @root = nil
    @root = build_tree(ary)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if node.class != TreeNode
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left

  end

end
