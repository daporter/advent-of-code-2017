class Instruction
  attr_reader :operation
  attr_reader :predicate

  def initialize(operation, predicate)
    @operation = operation
    @predicate = predicate
  end

  def self.parse_register_name(text)
    text.match(/(\w+)/)[0]
  end

  def self.parse_mutation(text)
    case text.match(/(dec|inc)/)[0]
    when 'dec' then Mutation::DEC
    when 'inc' then Mutation::INC
    end
  end

  def self.parse_argument(text)
    value = text.match(/(-?\d+)/)[0].to_i
    Argument.new(value)
  end

  def self.parse_comparison(text)
    comparison = text.match(/<=?|==|!=|>=?/)[0]
    case comparison
    when '<'  then Comparison::LT
    when '<=' then Comparison::LE
    when '==' then Comparison::EQ
    when '!=' then Comparison::NE
    when '>=' then Comparison::GE
    when '>'  then Comparison::GT
    end
  end

  def self.parse_operation(text)
    reg, mut, arg = text.split

    Operation.new(parse_register_name(reg),
                  parse_mutation(mut),
                  parse_argument(arg))
  end

  def self.parse_predicate(text)
    reg, comp, arg = text.split

    Predicate.new(parse_register_name(reg),
                  parse_comparison(comp),
                  parse_argument(arg))
  end

  def self.parse(text)
    op, pred = text.split(' if ')

    Instruction.new(parse_operation(op), parse_predicate(pred))
  end
end

class Operation
  attr_reader :register_name
  attr_reader :mutation
  attr_reader :argument

  def initialize(register_name, mutation, argument)
    @register_name = register_name
    @mutation = mutation
    @argument = argument
  end

  def execute(cpu)
    reg_value = cpu.get_register_value(@register_name)
    arg_value = @argument.value

    case @mutation
    when Mutation::DEC then delta = -1 * arg_value
    when Mutation::INC then delta = arg_value
    end

    cpu.set_register_value(@register_name, reg_value + delta)
  end
end

class Predicate
  attr_reader :register_name
  attr_reader :comparison
  attr_reader :argument

  def initialize(register_name, comparison, argument)
    @register_name = register_name
    @comparison = comparison
    @argument = argument
  end

  def evaluate(cpu)
    reg_value = cpu.get_register_value(@register_name)
    arg = @argument.value

    case @comparison
    when Comparison::LT then reg_value <  arg
    when Comparison::LE then reg_value <= arg
    when Comparison::EQ then reg_value == arg
    when Comparison::NE then reg_value != arg
    when Comparison::GE then reg_value >= arg
    when Comparison::GT then reg_value >  arg
    end
  end
end

Argument = Struct.new(:value)

module Mutation
  DEC = :dec
  INC = :inc
end

module Comparison
  LT = :lt
  LE = :le
  EQ = :eq
  NE = :ne
  GE = :ge
  GT = :gt
end
