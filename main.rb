module Enumerable

  def my_each
  unless !block_given?
    for item in self
      yield(item)
    end
  end
    to_enum(:self)
  end

  def my_each_with_index
  unless !block_given?
    for item_index in (0...self.size)
      yield(self[item_index], item_index)
    end
  end
    to_enum(:self)
  end

  def my_select
  unless !block_given?
    new_items = []
    my_each do |item|
      new_items.push(item) if yield(item)
    end
    return new_items
  end
    to_enum(:self)
  end

  def my_all?(arg=false)
    my_each do |item|
      return false if (item == nil || item == false)
      return false if (arg.class == String && !yield(item))
      return false if (arg.class == Regexp && !(item =~ arg))
      return false if ((arg.class == item.class) && (item != arg))
    end
    true
  end

  def my_any?(arg=nil)
    my_each do |item|
      next if ((arg==nil) && (item==false || item==nil))
      return true if (block_given? && yield(item))
      return true if (arg.class == Regexp && (item =~ arg))
      return true if ((arg.class == item.class) && (item == arg))
      return true if ((arg.class == Class) && (item.class == arg))  
      return true if ((arg==nil) && !item.nil?)
    end
    false
  end

  def my_none?(arg=false)
    my_each do |item|
      return false if ((arg==false) && !item.nil?)
      next if (item == nil || item == false)
      return false if (arg.class == String && yield(item))
      return false if (arg.class == Regexp && (item =~ arg))
      return false if ((arg.class == item.class) && (item == arg))
      return false if ((arg.class == Class) && (item.class == arg)) 
    end
    true
  end

  def my_count(*arg)
    count = 0
    my_select do |item|
        count+=1 if block_given? && yield(item)
        count+=1 if !block_given? && arg[0] == item
    end
    count
  end


  def my_map(&proc)
    return to_enum(:self) if !block_given?
    new_array = []
    my_select { |item| new_array << proc.call(item)}
    new_array
  end


  def my_inject initial=0
      sum = initial
      item_index = 0
       
      sum = self[0] if initial ==0
      item_index =1 if initial ==0
 
      for item_index in (item_index...self.size)
            sum = yield(sum, self[item_index])
      end
      sum
    
  end

end
  
def multiply_els (array)
  array.my_inject { |sum, item| sum * item }
end

