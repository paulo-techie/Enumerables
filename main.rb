
module Enumerable
    
    def my_each
    return self.size if !block_given?
    for item in self
        yield(item)
    end
    end
    
    def my_each_with_index
    return self.size if !block_given?
    for item_index in (0...self.size)
        yield(self[item_index], item_index)
    end
    end

    def my_select
    return self.size if !block_given?
    new_items = []
    my_each do |item|
        new_items.push(item) if yield(item)
    end
    new_items
    end

    def my_all?
    items_exist = true
      my_each do |item|
            friends_exist = false if !yield(item)
      end
    items_exist
    end

    def my_any?
        any_item = false
        my_each do |item|
            any_item = true if yield(item)
        end
        any_item
    end

    def my_none?
        item_none = false
        my_each do |item|
            item_none = true if !yield(item)
        end
        item_none
    end

    def my_count
        return self.size if !block_given?
        count = 0
        my_each do |item|
            count+=1 if yield(item)
        end
        count
    end


    def my_map(&proc)
        new_array = []

        for item_index in (0...self.size)
            if block_given?
                new_array.push(yield(self[item_index]))
            else
                new_array.push(proc.call(self[item_index]))
            end
        end
        new_array
    end

    def my_inject(start = 0)
       sum = start
       for item_index in (0...self.size)
            sum = yield(sum, self[item_index])
       end
       sum
    end

    def multiply_els
    array.my_inject(1) { |x, y| x * y }
    end

end
# testers


 ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun'].my_each { |friend| puts "Hello, " + friend }

  ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun'].my_each_with_index { |friend, index| puts "Hello, " + friend + " " + index.to_s}

   ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun'].my_select { |friend| puts "Hello, " + friend }

end
