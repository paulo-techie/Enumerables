friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']



module Enumerable
    def my_each
        for friend in friends
            yield(friend)
        end
    end

    def my_each_with_index
        for friend_index in (0...friends.size)
            yield(friends[friend_index], friend_index)
        end
    end

    def my_select
        new_friends = []
        for friend in my_each
          new_friends.push(friend) if yield(friend)
        end
        puts new_friends
    end

    def my_all?
        friends_exist = true
        for friend in my_each
            friends_exist = false if !yield(friend)
        end
        result
    end

    def my_any?
        any_friend = false
        for friend in my_each
            any_friend = true if yield(friend)
        end
        result
    end

    def my_none?
        friend_none = false
        for friend in my_each
            friend_none = true if !yield(friend)
        end
        friend_none
    end

    def my_count
        if block_given?
        count = 0
        for friend in my_each
            count+=1 if yield(friend)
        end
        count
    end
  end
end