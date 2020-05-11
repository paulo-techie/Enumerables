module Enumerable

  def my_each
  unless !block_given?
    for item in self
      yield(item)
    end
  end
    self
  end

  def my_each_with_index
  unless !block_given?
    for item_index in (0...self.size)
      yield(self[item_index], item_index)
    end
  end
    self
  end

  def my_select
  unless !block_given?
    new_items = []
    my_each do |item|
      new_items.push(item) if yield(item)
    end
    new_items
  end
    self
  end

  def my_all?
    return false if !block_given?
    my_each do |item|
      return false if item == nil 
      return false unless yield(item)
    end

    true
  end


  def my_count
    return self.size if !block_given?
    count = 0
    my_select do |item|
        count+=1 if yield(item)
    end
    count
  end

  def my_any?
    result = false
    my_each do |item|
        result = true if yield(item)
    end
    result
  end

  def my_none?
    result = true
    unless !block_given?
      my_each do |item|
          result = false if yield(item)
      end
    end
    return result
  end

  def my_map(&proc)
    return self.size if !block_given?
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
