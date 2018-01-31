require 'minitest/autorun'
require_relative 'tablet'

class TabletTest < Minitest::Test
  def test_first_rcv
    code = %(
      snd 1
      snd 2
      snd p
      rcv a
    )
    tablet = Tablet.new(code)
    tablet.run_programs
    assert_equal 1, tablet.program(0).registers[:a]
    assert_equal 1, tablet.program(1).registers[:a]
  end

  def test_second_rcv
    code = %(
      snd 1
      snd 2
      snd p
      rcv a
      rcv b
    )
    tablet = Tablet.new(code)
    tablet.run_programs
    assert_equal 2, tablet.program(0).registers[:b]
    assert_equal 2, tablet.program(1).registers[:b]
  end

  def test_third_rcv
    code = %(
      snd 1
      snd 2
      snd p
      rcv a
      rcv b
      rcv c
    )
    tablet = Tablet.new(code)
    tablet.run_programs
    assert_equal 1, tablet.program(0).registers[:c]
    assert_equal 0, tablet.program(1).registers[:c]
  end

  def test_fourth_rcv_results_in_deadlock
    code = %(
      snd 1
      snd 2
      snd p
      rcv a
      rcv b
      rcv c
      rcv d
    )
    tablet = Tablet.new(code)
    tablet.run_programs
    assert_equal 0, tablet.program(0).registers[:d]
    assert_equal 0, tablet.program(1).registers[:d]
  end

  def test_send_count
    code = %(
      snd 1
      snd 2
      snd p
      rcv a
      rcv b
      rcv c
      rcv d
    )
    tablet = Tablet.new(code)
    tablet.run_programs
    assert_equal 3, tablet.program(1).send_count
  end

  def test_longer_code
    code = %(
      set a 1
      add a 2
      mul a a
      mod a 5
      snd a
      set a 0
      rcv a
      jgz a -1
      set a 1
      jgz a -2
    )
    tablet = Tablet.new(code)
    tablet.run_programs
    assert_equal 4, tablet.program(1).registers[:a]
  end
end
