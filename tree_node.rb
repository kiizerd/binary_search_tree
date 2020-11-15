class TreeNode
  
  include Comparable
  
  attr_reader :data
  
  attr_accessor :left, :right

  def initialize(data, left=nil, right=nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    data <=> other.data
  end

  def to_s
    res = []
    res << "Data: #{data}, "
    res << "Left: #{left}, left-data: #{left.data}"     if self.left
    res << "Right: #{right}, right-data: #{right.data}" if self.right
    res
  end
end
