require 'strscan'

class Tower
  attr_reader :program_name
  attr_accessor :weight
  attr_reader :sub_towers

  def initialize(program_name)
    @program_name = program_name
    @sub_towers = []
  end

  def self.from_list(list)
    bottom_candidates = []

    list.strip.lines.each do |line|
      scanner = StringScanner.new(line)
      scanner.skip_until(/\w+/)
      name = scanner[0]
      scanner.skip_until(/(\d+)/)
      weight = scanner[0].to_i

      tower = nil
      bottom_candidates.each do |candidate|
        tower = candidate.find(name)
        break if tower
      end

      unless tower
        tower = Tower.new(name)
        bottom_candidates << tower
      end
      tower.weight = weight

      if scanner.skip_until(/->/)
        while scanner.skip_until(/\w+/)
          sub_tower_name = scanner[0]
          found = bottom_candidates.find { |st| st.find(sub_tower_name) }
          if found
            tower.sub_towers << found
            bottom_candidates.delete found
          else
            tower.sub_towers << Tower.new(sub_tower_name)
          end
        end
      end
    end

    # Should be only one left
    bottom_candidates[0]
  end

  def find(target_name)
    if @program_name == target_name
      self
    else
      sub_towers.each do |st|
        instance = st.find(target_name)
        return instance if instance
      end
      nil
    end
  end

  def top?
    sub_towers.empty?
  end

  def find_program_with_wrong_weight
    return self if sub_tower_weights_balanced?

    unbalanced_sub_tower.find_program_with_wrong_weight
  end

  def total_weight
    @weight + sub_tower_weights.reduce(0, :+)
  end

  def sub_tower_weights
    sub_towers.map(&:total_weight)
  end

  def corrected_weight
    corrected_weight_with_difference(0)
  end

  def corrected_weight_with_difference(difference)
    return @weight + difference if sub_tower_weights_balanced?

    weights = sub_tower_weights
    sorted_weights = weights.sort_by { |w| weights.grep(w).length }
    wrong = sorted_weights.first
    correct = sorted_weights.last

    unbalanced_sub_tower.corrected_weight_with_difference(correct - wrong)
  end

  def sub_tower_weights_balanced?
    sub_tower_weights.uniq.count <= 1
  end

  def unbalanced_sub_tower
    weights = sub_tower_weights
    i = weights.find_index { |weight| weights.count(weight) == 1 }
    sub_towers[i]
  end
end
