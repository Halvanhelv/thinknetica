# # frozen_string_literal: true
#
# # block = proc { |x| puts x }
# # block = proc { |x| puts x }
# # block = lambda { |x| puts x }
# # block = ->(x) {  puts x }
# # PROC accepts any number of arguments (if there are more than needed) but lambda does not
# # block = proc { puts 'x' }
# # def m(block)
# #   x = 'good'
# #   puts "X from method #{block}"
# #   yield block
# #
# # end
# # m('str') { |x| puts x }




# # frozen_string_literal: true

# # block1 = proc { |str| puts str + 'dwd' }
# # def m1(str, block)
# #   x = 'good'
# #   puts "X from method #{block}"
# #   block.call(str)
# #
# # end
# #
# # m1('Abc', block1)



# # def m1(str, &block)
# #   x = 'good'
# #   puts "X from method #{block}"
# #   block.call(str)
# #
# # end
# #
# # m1('Abc') { |str| puts str + 'dwd' }


# # def m1(str, &block)
# #   x = 'good'
# #   puts "X from method #{block}"
# #   block.call(str)
# #   yield str
# #
# # end
# #
# # m1('Abc') { |str| puts str + 'dwd' }
# #
# #
# #
# #
# # def m1(str, &block)
# #   x = 'good'
# #   if  block_given? # If block is passed
# #     yield str # or block.call(str)
# #   else
# #     puts 'Block not passed'
# #     end
# #   end
# #
# #
# # m1('Abc') { |str| puts str + 'dwd' }


# # In Ruby there is another way to write blocks using lambda, this is the -> operator:
# #
# #     Writing
# # ->(x) { puts x }
# # is the same as
# # lambda { |x| puts x }
# # just shorter.
# #     If you see such notation, don't be scared, it's just lambda.


# # def m1(&block)
# #   if block_given? # If block is passed
# #     block.call(1, 2, 3,4) # or block.call(str)
# #   else
# #     puts 'Block not passed'
# #   end
# # end
# #
# #
# # m1() { |f, y, b, a| puts f * y * b;  puts a}



# def trains_block
#   @trains.each {|train| yield(train)}
# end
#


class Main
  class << self; attr_accessor :sides
    def check
      @sides
    end
  end
  @sides = {}


  def initialize

  end


  def check
    self.class.sides
  end
end

class Suck < Main
  class << self; attr_accessor :sides
  def check
    @sides
  end
  end
  @sides = {}

  def initialize(name)
    self.class.sides[name] = self
  end


end
