require 'minitest/autorun'
require_relative 'instruction'

class InstructionTest < Minitest::Test

  # Instructions have the form:
  #   <operation> if <predicate>
  # where
  #   <operation>  := <register> <mutation> <argument>
  #   <predicate>  := <register> <comparison> <argument>
  #   <register>   := \w+
  #   <mutation>   := dec | inc
  #   <argument>   := -?\d+
  #   <comparison> := < | <= | == | != | >= | >

  def test_parse_register_short_name
    register_name = Instruction.parse_register_name('a')
    assert_equal 'a', register_name
  end

  def test_parse_register_long_name
    register_name = Instruction.parse_register_name('foobar')
    assert_equal 'foobar', register_name
  end

  def test_parse_mutation_dec
    mutation = Instruction.parse_mutation('dec')
    assert_equal Mutation::DEC, mutation
  end

  def test_parse_mutation_inc
    mutation = Instruction.parse_mutation('inc')
    assert_equal Mutation::INC, mutation
  end

  def test_parse_argument_positive
    argument = Instruction.parse_argument('15')
    assert_equal 15, argument.value
  end

  def test_parse_argument_negative
    argument = Instruction.parse_argument('-25')
    assert_equal -25, argument.value
  end

  def test_parse_comparison_lt
    comparison = Instruction.parse_comparison('<')
    assert_equal Comparison::LT, comparison
  end

  def test_parse_comparison_le
    comparison = Instruction.parse_comparison('<=')
    assert_equal Comparison::LE, comparison
  end

  def test_parse_comparison_eq
    comparison = Instruction.parse_comparison('==')
    assert_equal Comparison::EQ, comparison
  end

  def test_parse_comparison_ne
    comparison = Instruction.parse_comparison('!=')
    assert_equal Comparison::NE, comparison
  end

  def test_parse_comparison_ge
    comparison = Instruction.parse_comparison('>=')
    assert_equal Comparison::GE, comparison
  end

  def test_parse_comparison_gt
    comparison = Instruction.parse_comparison('>')
    assert_equal Comparison::GT, comparison
  end

  def test_parse_operation
    operation = Instruction.parse_operation('c dec -10')
    assert_equal 'c', operation.register_name
    assert_equal Mutation::DEC, operation.mutation
    assert_equal -10, operation.argument.value
  end

  def test_parse_predicate
    predicate = Instruction.parse_predicate('c == 10')
    assert_equal 'c', predicate.register_name
    assert_equal Comparison::EQ, predicate.comparison
    assert_equal 10, predicate.argument.value
  end

  def test_parse_instruction
    instruction= Instruction.parse('c inc -20 if c == 10')
    assert_equal Mutation::INC, instruction.operation.mutation
    assert_equal Comparison::EQ, instruction.predicate.comparison
  end
end
