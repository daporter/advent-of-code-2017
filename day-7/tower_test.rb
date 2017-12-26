require 'minitest/autorun'
require_relative 'tower'

class TowerTest < Minitest::Test
  def setup
    @list = %(
      pbga (66)
      xhth (57)
      ebii (61)
      havc (66)
      ktlj (57)
      fwft (72) -> ktlj, cntj, xhth
      qoyq (66)
      padx (45) -> pbga, havc, qoyq
      tknk (41) -> ugml, padx, fwft
      jptl (61)
      ugml (68) -> gyxo, ebii, jptl
      gyxo (61)
      cntj (57)
    )
  end

  def test_single_program
    tower = Tower.from_list('pbga (66)')
    assert_equal 'pbga', tower.program_name
  end

  def test_two_programs
    list = %(
      pbga (66)
      xhth (57) -> pbga
    )
    tower = Tower.from_list(list)
    assert_equal 'xhth', tower.program_name
    assert_equal 'pbga', tower.subtowers[0].program_name
  end

  def test_bottom_program
    tower = Tower.from_list(@list)
    assert_equal 'tknk', tower.program_name
  end

  def test_bottom_supporting
    tower = Tower.from_list(@list)
    assert_equal ['ugml', 'padx', 'fwft'], tower.subtowers.map(&:program_name)
  end

  def test_ugml_supporting
    tower = Tower.from_list(@list)
    assert_equal ['gyxo', 'ebii', 'jptl'], tower.subtowers[0].subtowers.map(&:program_name)
  end

  def test_havc_top
    tower = Tower.from_list(@list)
    assert tower.subtowers[1].subtowers[1].top?
  end
end
