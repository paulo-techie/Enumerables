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


  def my_inject (arg=0, *arg2)
      sum=arg
      sum=0 if arg.class==Symbol
      
      item_index = 0
      
      sum = self[0] if arg==0
      item_index =1 if arg==0
 
      for item_index in (item_index...self.size)
          
        if arg2[0].class==Symbol
              sum = sum.send(arg2[0], self.to_a[item_index]) if self.class==Range
              sum = sum.send(arg2[0], self[item_index]) if self.class==Array
            elsif arg.class==Symbol
              sum = sum.send(arg, self.to_a[item_index]) if self.class==Range
              sum = sum.send(arg, self[item_index]) if self.class==Array
            else
            sum = yield(sum, self.to_a[item_index]) if (self.class==Range && block_given?)
            sum = yield(sum, self[item_index]) if (self.class==Array && block_given?)
          end
      end

      sum   
  end



end
  
def multiply_els (array)
  array.my_inject { |sum, item| sum * item }
end

