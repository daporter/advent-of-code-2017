require 'minitest/autorun'
require_relative 'diagram'

class DiagramTest < Minitest::Test
  def setup
    @input = ['    |          ',
              '    |  +--+    ',
              '    A  |  C    ',
              'F---|----E|--+ ',
              '    |  |  |  D ',
              '    +B-+  +--+ '].join("\n")
  end

  def test_parse
    diagram = Diagram.parse(@input)
    assert_equal 6, diagram.height
  end

  def test_starting_position
    diagram = Diagram.parse(@input)
    assert_equal Diagram::Position.new(0, 4), diagram.starting_position
  end

  def test_next_step_along_path_down
    input = [' | ',
             ' | ',
             ' | '].join("\n")
    diagram = Diagram.parse(input)
    diagram.prev_posn = Diagram::Position.new(0, 1)
    diagram.packet_posn = Diagram::Position.new(1, 1)
    expected = Diagram::Position.new(2, 1)
    diagram.next_step_along_path
    assert_equal expected, diagram.packet_posn
  end

  def test_next_step_along_path_up
    input = [' | ',
             ' | ',
             ' | '].join("\n")
    diagram = Diagram.parse(input)
    diagram.prev_posn = Diagram::Position.new(2, 1)
    diagram.packet_posn = Diagram::Position.new(1, 1)
    expected = Diagram::Position.new(0, 1)
    diagram.next_step_along_path
    assert_equal expected, diagram.packet_posn
  end

  def test_next_step_along_path_left
    diagram = Diagram.parse('---')
    diagram.prev_posn = Diagram::Position.new(0, 2)
    diagram.packet_posn = Diagram::Position.new(0, 1)
    expected = Diagram::Position.new(0, 0)
    diagram.next_step_along_path
    assert_equal expected, diagram.packet_posn
  end

  def test_next_step_along_path_right
    diagram = Diagram.parse('---')
    diagram.prev_posn = Diagram::Position.new(0, 0)
    diagram.packet_posn = Diagram::Position.new(0, 1)
    expected = Diagram::Position.new(0, 2)
    diagram.next_step_along_path
    assert_equal expected, diagram.packet_posn
  end

  def test_next_step_along_path_corner_right
    input = ['| ',
             '+-'].join("\n")
    diagram = Diagram.parse(input)
    diagram.prev_posn = Diagram::Position.new(0, 0)
    diagram.packet_posn = Diagram::Position.new(1, 0)
    expected = Diagram::Position.new(1, 1)
    diagram.next_step_along_path
    assert_equal expected, diagram.packet_posn
  end

  def test_next_step_along_path_corner_left
    input = [' |',
             '-+'].join("\n")
    diagram = Diagram.parse(input)
    diagram.prev_posn = Diagram::Position.new(0, 1)
    diagram.packet_posn = Diagram::Position.new(1, 1)
    expected = Diagram::Position.new(1, 0)
    diagram.next_step_along_path
    assert_equal expected, diagram.packet_posn
  end

  def test_next_step_along_path_corner_down
    input = ['-+ ',
             ' |'].join("\n")
    diagram = Diagram.parse(input)
    diagram.prev_posn = Diagram::Position.new(0, 0)
    diagram.packet_posn = Diagram::Position.new(0, 1)
    expected = Diagram::Position.new(1, 1)
    diagram.next_step_along_path
    assert_equal expected, diagram.packet_posn
  end

  def test_next_step_along_path_corner_up
    input = [' |',
             '-+'].join("\n")
    diagram = Diagram.parse(input)
    diagram.prev_posn = Diagram::Position.new(1, 0)
    diagram.packet_posn = Diagram::Position.new(1, 1)
    expected = Diagram::Position.new(0, 1)
    diagram.next_step_along_path
    assert_equal expected, diagram.packet_posn
  end

  def test_next_step_along_path_intersection_vertical
    diagram = Diagram.parse('-|-')
    diagram.prev_posn = Diagram::Position.new(0, 0)
    diagram.packet_posn = Diagram::Position.new(0, 1)
    expected = Diagram::Position.new(0, 2)
    diagram.next_step_along_path
    assert_equal expected, diagram.packet_posn
  end

  def test_next_step_along_path_intersection_horizontal
    input = ['|',
             '-',
             '|'].join("\n")
    diagram = Diagram.parse(input)
    diagram.prev_posn = Diagram::Position.new(0, 0)
    diagram.packet_posn = Diagram::Position.new(1, 0)
    expected = Diagram::Position.new(2, 0)
    diagram.next_step_along_path
    assert_equal expected, diagram.packet_posn
  end

  def test_next_step_along_path_letter
    diagram = Diagram.parse('-A-')
    diagram.prev_posn = Diagram::Position.new(0, 0)
    diagram.packet_posn = Diagram::Position.new(0, 1)
    expected = Diagram::Position.new(0, 2)
    diagram.next_step_along_path
    assert_equal expected, diagram.packet_posn
  end

  def test_follow_path
    diagram = Diagram.parse(@input)
    diagram.move_packet_along_path
    assert_equal Diagram::Position.new(3, 0), diagram.packet_posn
  end

  def test_letters_seen
    diagram = Diagram.parse(@input)
    diagram.move_packet_along_path
    assert_equal 'ABCDEF', diagram.letters_seen
  end

  def test_step_count
    diagram = Diagram.parse(@input)
    diagram.move_packet_along_path
    assert_equal 38, diagram.step_count
  end
end
