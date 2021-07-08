module Elements
  class ElementFactory
    def self.create(name)
      case name
      when 'fire'
        return Elements::Fire.new
      when 'water'
        return Elements::Water.new
      when 'air'
        return Elements::Air.new
      when 'earth'
        return Elements::Earth.new
      else
        raise "element #{name} not known"
      end
    end
  end
end
