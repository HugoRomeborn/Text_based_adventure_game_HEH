class enemy
  def initialize(name, klass,  hp, attack)
    @name = name
    @hp = hp
    @attack = attack
  end

  def attack(target)
    return @attack * rand(0.8..1.2)
  end

  def take_damage(damage)
    @hp -= damage
    puts "#{@name} took #{damage} damage!"
  end

  def alive?
    @hp > 0
  end
end

class player
  def initialize(name, hp, attack)
    @name = name
    @hp = hp
    @attack = attack
  end

  def attack(target)
    target.take_damage(@attack)
  end

  def take_damage(damage)
    @hp -= damage
    puts "#{@name} took #{damage} damage!"
  end

  def alive?
    @hp > 0
  end

  def to_s
    "#{@name} (HP: #{@hp})"
  end
end