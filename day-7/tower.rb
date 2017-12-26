require 'strscan'

class Tower
  attr_reader :program_name
  attr_reader :subtowers

  def initialize(program_name)
    @program_name = program_name
    @subtowers = []
  end

  def self.from_list(list)
    bottom_candidates = []

    list.strip.lines.each do |line|
      scanner = StringScanner.new(line)
      scanner.skip_until(/\w+/)
      name = scanner[0]

      tower = nil
      bottom_candidates.each do |c|
        tower = c.find(name)
        break if tower
      end

      unless tower
        tower = Tower.new(name)
        bottom_candidates << tower
      end

      if scanner.skip_until(/->/)
        while scanner.skip_until(/\w+/)
          subtower_name = scanner[0]
          found = bottom_candidates.find { |st| st.find(subtower_name) }
          if found
            tower.subtowers << found
            bottom_candidates.delete found
          else
            tower.subtowers << Tower.new(subtower_name)
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
      subtowers.each do |st|
        instance = st.find(target_name)
        return instance if instance
      end
      nil
    end
  end

  def top?
    subtowers.empty?
  end
end
