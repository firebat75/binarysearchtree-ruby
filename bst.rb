class Node
    include Comparable
    attr_accessor :value, :left, :right
    def initialize(value = nil, left = nil, right = nil)
        @value = value
        @left = left
        @right = right
    end

    def <=>(other)
        @value <=> other.value
    end

    def to_s
        print " " * @left.value.to_s.length if @left
        print " " if !@left
        print " " + "(#{value})\n"
        print " " * @left.value.to_s.length if @left
        print " " if !@left
        print " /"
        
        print " " * @value.to_s.length
        print "\\\n"
        if @left
            print "(#{@left.value})"
        else
            print "nil"
        end
        print " " * @value.to_s.length
        if @right
            print "(#{@right.value})\n"
        else
            print "nil\n"
        end
    end

end



class Tree
    attr_accessor :root
    def initialize(array = [])
        @root = build_tree(array)
    end


    def build_tree(array)
        return nil if array.length < 1

        array = array.uniq.sort

        if array.length == 1
            return Node.new(array[0])
        else
            mid = array.length / 2
        end

        root = Node.new(array[mid])

        root.left = build_tree(array[0..mid-1])
        root.right = build_tree(array[mid+1..-1])

        return root
    end


    def pp(node = @root, prefix = '', is_left = true)
        pp(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pp(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end


    def insert(value, root = @root)
        if !root
            root = Node.new(value)
            return root

        else
            if value < root.value
                root.left = insert(value, root.left)
            
            elsif value > root.value
                root.right = insert(value, root.right)
            end
        
        return root

        end
        
    end

end