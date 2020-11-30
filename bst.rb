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


    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end


    def insert(value, root = @root) #in progress
        node = Node.new(value)

        if !root
            root = node

        elsif value < root.value
            if root > root.left
                node.left = root.left
                root.left = node
            else
                root.insert(value, root.left)
            end

        elsif value > root
            if root < root.right
                node.right = root.right
                root.right = node
            else
                root.insert(value, root.right)
            end
        end
        @root = root
        return node
        
    end
end
    

#     def delete(value, root = @root, parent = nil)

#         if root.value > value #traverse left
#             delete(value, root.left, root)
#         elsif root.value < value #traverse right
#             delete(value, root.right, root)
#         else

#             if !root.left && !root.right #node to be deleted is a leaf
#                 parent.left, parent.right = nil, nil

#             elsif root.left && !root.right #node to be deleted has one child (left)
#                 parent.left = root.left if parent.left == root
#                 parent.right = root.left if parent.right == root

#             elsif root.right && !root.left #node to be deleted has one child (right)
#                 parent.right = root.right if parent.right == root
#                 parent.left = root.right if parent.left == root

#             else #node to be deleted has two children
#                 min_right = root.right
#                 while min_right.left
#                     min_right_p = min_right
#                     min_right = min_right.left
#                 end

#                 root.value = min_right.value

#                 if !min_right.right
#                     min_right_p.left = nil
#                 else
#                     min_right_p.right = min_right.right
                    
#                 end
#             end

#         end
#     end
# end
