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
    assert_equal 'pbga', tower.sub_towers[0].program_name
  end

  def test_bottom_program
    tower = Tower.from_list(@list)
    assert_equal 'tknk', tower.program_name
  end

  def test_bottom_supporting
    tower = Tower.from_list(@list)
    assert_equal %w[ugml padx fwft], tower.sub_towers.map(&:program_name)
  end

  def test_ugml_supporting
    tower = Tower.from_list(@list)
    assert_equal(%w[gyxo ebii jptl],
                 tower.sub_towers[0].sub_towers.map(&:program_name))
  end

  def test_havc_top
    tower = Tower.from_list(@list)
    assert tower.sub_towers[1].sub_towers[1].top?
  end

  def test_weight_single_program
    tower = Tower.from_list('pgba (66)')
    assert_equal 66, tower.weight
  end

  def test_weight_two_programs
    list = %(
      pbga (66)
      xhth (57) -> pbga
    )
    tower = Tower.from_list(list)
    assert_equal 57, tower.weight
  end

  def test_weight_all_programs
    tower = Tower.from_list(@list)
    assert_equal 41, tower.weight
  end

  def test_total_weight_single_program
    tower = Tower.from_list('pgba (66)')
    assert_equal 66, tower.total_weight
  end

  def test_total_weight_two_programs
    list = %(
      pbga (66)
      xhth (57) -> pbga
    )
    tower = Tower.from_list(list)
    assert_equal 123, tower.total_weight
  end

  def test_total_weight_all_programs
    tower = Tower.from_list(@list)
    assert_equal 778, tower.total_weight
  end

  def test_sub_tower_weights_single_program
    tower = Tower.from_list('pgba (66)')
    assert_equal [], tower.sub_tower_weights
  end

  def test_sub_tower_weights_two_programs
    list = %(
      pbga (66)
      xhth (57) -> pbga
    )
    tower = Tower.from_list(list)
    assert_equal [66], tower.sub_tower_weights
  end

  def test_sub_tower_weights_all_programs
    tower = Tower.from_list(@list)
    assert_equal [251, 243, 243], tower.sub_tower_weights
  end

  def test_find_program_with_wrong_weight_single_program
    tower = Tower.from_list('gpba (66)')
    assert_equal 'gpba', tower.find_program_with_wrong_weight.program_name
  end

  def test_find_program_with_wrong_weight_two_programs
    list = %(
      pbga (66)
      xhth (57) -> pbga
    )
    tower = Tower.from_list(list)
    assert_equal 'xhth', tower.find_program_with_wrong_weight.program_name
  end

  def test_find_program_with_wrong_weight_all_programs
    tower = Tower.from_list(@list)
    assert_equal 'ugml', tower.find_program_with_wrong_weight.program_name
  end

  def test_corrected_weight_single_program
    tower = Tower.from_list('gpba (66)')
    assert_equal 66, tower.corrected_weight
  end

  def test_corrected_weight_two_programs
    list = %(
      pbga (66)
      xhth (57) -> pbga
    )
    tower = Tower.from_list(list)
    assert_equal 57, tower.corrected_weight
  end

  def test_find_program_with_wrong_weight_all_programs
    tower = Tower.from_list(@list)
    assert_equal 60, tower.corrected_weight
  end
end
