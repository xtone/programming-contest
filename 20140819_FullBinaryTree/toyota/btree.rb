class BinaryTree
  attr_accessor :node_count

  def initialize(node_count)
    self.node_count = node_count
    @nodes = (1..node_count).map { |i|
      Node.new i
    }
  end

  def add_edge(node1, node2)
    @nodes[node1-1].add_edge @nodes[node2-1]
    @nodes[node2-1].add_edge @nodes[node1-1]
  end

  def solve(case_num)
    smallest = self.node_count
    smallest_root = nil
    @nodes.each { |root|
      if root.child_count(true) < 2 then
        next
      end
      count = root.cut_count
      if case_num == 10 then
        # puts "root: #{root.number}, cut_count: #{count}"
      end
      if count < smallest
        smallest = count
        smallest_node = root
      end
    }
    if self.node_count == 2 then
      smallest = 1
    end
    puts "Case ##{case_num}: #{smallest}"
  end
end

class Node
  attr :number
  def initialize(number)
    @number = number
    @neighbors = []
  end

  def add_edge(node)
    @neighbors << node
  end

  def child_count(is_root)
    @neighbors.length - (is_root ? 0 : 1)
  end

  def cut_count(from = nil)
    if self.child_count(from.nil?) == 0
      # puts "  cut_count(#{@number}): 0"
      return 0
    elsif self.child_count(from.nil?) == 1
      cut_count = 1
      @neighbors.reject {|n| n == from}.each { |node|
        cut_count += node.all_child_count(self)
      }
      # puts "  cut_count(#{@number}): #{cut_count}"
      cut_count
    elsif self.child_count(from.nil?) == 2
      cut_count = 0
      @neighbors.each {|node|
        if node != from then
          cut_count += node.cut_count(self)
        end
      }
      # puts "  cut_count(#{@number}): #{cut_count}"
      cut_count
    else
      smallest_node_count = 10000000
      # @neighbors.reject { |n| n == from }.combination(2).each { |left,right| puts "node #{self.number}: #{left.number},#{right.number}"}

      @neighbors.reject { |n| n == from}.combination(2).each { |left, right|
        cut_count = 0
        cut_count += left.cut_count(self)
        cut_count += right.cut_count(self)
        @neighbors.reject { |n| n == left || n == right || n == from }.each { |node|
          cut_count += 1 + node.all_child_count(self)
        }
        if cut_count < smallest_node_count
          smallest_node_count = cut_count
        end
        # puts "cut_count(#{self.number} (parent: #{from.number unless from.nil?}) (combination #{left.number}, #{right.number}): #{cut_count}"
      }
      # puts "  cut_count(#{@number}): #{smallest_node_count}"
      smallest_node_count
    end
  end

  def all_child_count(from = nil)
    if self.child_count(from.nil?) == 0
      return 0
    else
      child_count = self.child_count(from.nil?)
      @neighbors.reject { |n| n == from }.each { |node|
        child_count += node.all_child_count(self)
      }
      child_count
    end
  end
end

class SampleReader
  attr_accessor :binary_tree, :question_count, :case, :case_complete, :all_complete, :status

  def initialize
    @status = :q_count
  end

  def add_line (line)
    case @status
      when :q_count
        # 総問題数の取得
        @question_count = line.to_i
        @case = 0
        @all_complete = false
        @case_complete = false
        @status = :node_count
      when :node_count
        # ツリーのノード数取得
        @binary_tree = BinaryTree.new(line.to_i)
        @case += 1
        @status = :edges
        @rest_edge = self.binary_tree.node_count - 1
        @case_complete = false
      when :edges
        # ノード接続の取得
        nodes = line.split(' ')
        @binary_tree.add_edge(nodes[0].to_i, nodes[1].to_i)
        @rest_edge -= 1
        if @rest_edge <= 0 then
          @case_complete = true
          if self.question_count == self.case
            @status = :finished
            @all_complete = true
          else
            @status = :node_count
          end
        end
    end
  end
end

filename = ARGV[0]
reader = SampleReader.new
File::open(filename) { |file|
  file.each { |line|
    reader.add_line(line)
    if reader.case == 26
      #puts line
    end
    if reader.case_complete then
      reader.binary_tree.solve(reader.case)
    end
  }
}