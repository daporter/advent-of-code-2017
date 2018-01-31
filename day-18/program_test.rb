require 'minitest/autorun'
require_relative 'program'

class ProgramTest < Minitest::Test
  def test_initialize_sets_p_register
    program = Program.new(1, [], [], [])
    assert_equal 1, program.registers[:p]
  end
end
