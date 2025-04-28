#TBA, Text based adventure game 


#character 
class Player 
  def initialize()
    @inventory = [[], [], [[],[]], []]
    @weapons = []
    @ranged = []
    @armour = ["no_armour", 0] #fixa sennare 
    @potions = ["small_health_potion", "medium_health_potion", "large_health_potion", "max_health_potion", "small_damage_potion", "medium_damage_potion", "large_damage_potion", "one_hit_potion"]
    @misc = ["fur_hat", "mickey_mouse_hat", "santa_hat", "party_hat", "party_horn", "party_blowout"]
    @klasser = ["jakob_widebrant", "knight", "peseant", "alchemist", "archer", "ranger"]
    @races = ["orc","warewolf", "dwarf", "elf", "human"]
    @max_health = 100
   
   
    # Kollar om spelaren har spelat tidigare 
    # om spelaren har spelat tidigare så laddar vi in deras karaktär
    # om spelaren inte har spelat tidigare så skapar vi en ny karaktär
    # och sparar den i en personlig fil
    
    puts "Please provide your name"
    @name = gets.chomp.downcase.to_s
    directory = Dir.pwd #get current directory
    Dir.chdir("#{directory}/players") #change directory to players
    if File.exist?("#{@name}.txt")
      load()
      puts "Welcome back #{@name}!"
    else
      puts "Welcome #{@name}!"
      puts "Please provide your age"
      puts "The valid ages are: 0-100"
      @age = gets.chomp.to_i
      while @age < 0 || @age > 100
        puts "Please provide a valid age!"
        puts "The valid ages are: 0-100"
        @age = gets.chomp.to_i
      end
      puts "Choose what race you want to be"
      puts "Valid races are: #{@races}"
      @race = gets.chomp.downcase.to_s
      while !@races.include?(@race)
        puts "Please provide a valid race!"
        puts "The valid races are: #{@races}"
        @race = gets.chomp.downcase.to_s
      end
      puts "Choose what class you want to be"
      puts "Valid classes are: #{@klasser}"
      puts "Jakob Widebrant is a GOD"
      @klass = gets.chomp.downcase.to_s
      while !@klasser.include?(@klass)
        puts "Please provide a valid class!"
        puts "The valid classes are: #{@klasser}"
        @klass = gets.chomp.downcase.to_s
      end
      @health = 100

      if @klass == "knight"
        puts "You have chosen the knight class"
        puts "You have now been equipped with a Half-sword"
        @max_health = 200
        @health = 200
        @inventory[0] << "Half_Sword"
      elsif @klass == "archer"
        puts "You have chosen the archer class"
        puts "You have now been equipped with a Short_bow"
        @max_health = 90
        @health = 90
        @inventory[1] << "Short_bow"
      elsif @klass == "Jakob Widebrant"
        puts "You are now Jakob Widebrant"
        puts "You have now been equipped with a gamecubespiklubba and a lasersvärd"
        puts "You are a GOD"
        @max_health = 500
        @health = 400
        @inventory[0] << "gamecubespiklubba"
        @inventory[0] << "lasersvärd"
      elsif @klass == "peasant"
        puts "You have chosen the peasant class"
        puts "You have now been equipped with a muddy rock"
        puts "You are a dirty little peasant with no chance in life"
        @max_health = 80
        @health = 50
        @inventory[0] << "muddy rock"
      elsif @klass == "alchemist"
        puts "You have chosen the alchemist class"
        puts "You have now been equipped with a set of potions"
        @max_health = 110
        @inventory[0] << "staff_of_alchemy"
        i = 0
        while i < 10
          @inventory[2][0] << "small_health_potion"
          @inventory[2][1] << "small_damage_potion"
          i +=1
        end
        i = 0
        while i < 5
          @inventory[2][0] << "medium_health_potion"
          @inventory[2][1] << "medium_damage_potion"
          i +=1
        end
        i = 0
        while i < 2
          @inventory[2][0] << "large_health_potion"
          @inventory[2][1] << "large_damage_potion"
          i +=1
        end


      elsif @klass == "ranger"
        puts "You have chosen the ranger class"
        puts "You have now been equipped with a hunting bow"
        @max_health = 110
        @inventory[1] << "hunting_bow"
      end
      
      @room = "entrance"
    end
    
    save("entrance") #autosave
    puts "autosave"

    puts "You are a #{@age} year old #{@race} #{@klass} with #{@health} health."
    puts "You have the following items in your inventory:"
    puts "Weapons: #{@inventory[0]}"
    puts "Ranged: #{@inventory[1]}"
    puts "Potions: #{@inventory[2]}"
    puts "Misc: #{@inventory[3]}"
    puts "You are in the #{@room}."
    puts "You can now continue your adventure"
    puts "Write continue to continue your adventure"
    input = gets.chomp.downcase.to_s
    while input != "continue"
      puts "Invalid input! Please write continue to continue your adventure"
      input = gets.chomp.downcase.to_s
    end
  end
  def meele_attack(weapon, enemy)
    base_damage = rand(5..10).to_fu # base damage is random between 1 and 10
    p "choose your weapon from your inventory #{weapon}"
    input = gets.chomp.downcase.to_s
    if klass == "knight"
      base_damage*=2
    elsif klass == "archer"
      base_damage *=0.2
    elsif klass == "Jakob Widebrant" 
      base_damage *=13.37
    elsif klass == "peasant"
      base_damage*=1.2
    elsif klass == "alchemist"
      base_damage *=(rand(10..20)/10)
    elsif klass == "ranger"
      base_damage *= 0.4
    else 
      puts "unknown class. No damage modifier"  
    end

    damage = base_damage * weapon #- enemy_armour?

    # Nedan kommer inte att funka, det får ske på något annat sätt, ska inte heller vara i denna metod

    #
    # enemy_health = enemy.health - damage #enemy health
    # if enemy_health <= 0  #enemy dead
    #   puts "You have killed the #{enemy}"
    # end
    # puts "You attack the #{enemy} with your #{weapon}!"
    # puts "You deal #{damage} damage."
  end
  
  def save(room)
    directory = Dir.pwd #get current directory
    fil = File.open("#{@name}.txt", "w") #open file with name of the character
    #write to file
    fil.puts(@name)
    fil.puts(@age.to_s)
    fil.puts(@race)
    fil.puts(@klass)
    fil.puts(@health.to_s)
    i=0
    helpstr = " "
    while i < @inventory[0].length
      helpstr << "#{@inventory[0][i]} "
      i += 1
    end
    fil.puts(helpstr)
    i = 0
    helpstr = " "
    while i < @inventory[1].length
      helpstr << "#{@inventory[1][i]} "
      i += 1
    end
    fil.puts(helpstr)
    i = 0
    while i < @inventory[2].length
      j=0
      helpstr = " "
      while j < @inventory[2][i].length
        helpstr << "#{@inventory[2][i][j]} "
        j += 1
      end
      fil.puts(helpstr)
      i += 1
    end
    i = 0
    helpstr = " "
    while i < @inventory[3].length
      helpstr << "#{@inventory[2][i]} "
      i += 1
    end
    fil.puts(helpstr)
    i = 0
    helpstr = " "
    while i < @armour.length
      helpstr << "#{@armour[i]} " 
      i += 1
    end
    fil.puts(helpstr)
    fil.puts(room)
    fil.close
  end 
  

  def load()
    if !File.exist?("#{@name}.txt")
      raise "This file does not exist, fix code"
    end
    lines = File.readlines("#{@name}.txt")

    @name = lines[0].chomp
    @age = lines[1].chomp.to_i
    @race = lines[2].chomp
    @klass = lines[3].chomp
    @health = lines[4].chomp.to_i

    @inventory[0] = lines[5].chomp.split.dup
    @inventory[1] = lines[6].chomp.split.dup
    @inventory[2][0] = lines[7].chomp.split.dup
    @inventory[2][1] = lines[8].chomp.split.dup
    @inventory[3] = lines[9].chomp.split.dup
    @armour = lines[10].split.dup
    @room = lines[11].chomp
  end
  
  def pick_up(item)
    if @weapons.contains?(item)
      @inventory[0] << (item)
    elsif @ranged.contains?(item)
      @inventory[1] << (item)
    elsif @potions.contains?(item)
      @inventory[3] << (item)
    elsif @misc.contains?(item)
      @inventory[4] << (item)
    elsif @armour.contains?(item)
      @armour[2] << (item)
    else 
      raise "This item does not exist"
    end
  end

  def drop(item)
    if @weapons.contains?(item)
      place = contains_item(@inventory[0], item)
      if place != false
        @inventory[0].delete_at(place)
      end
    elsif @ranged.contains?(item)
      place = contains_item(@inventory[1], item)
      if place != false
        @inventory[1].delete_at(place)
      end
    elsif @potions.contains?(item)
      place = contains_item(@inventory[2], item)
      if place != false
        @inventory[2].delete_at(place)
      end
    else
      place = contains_item(@inventory[3], item)
      if place != false
        @inventory[3].delete_at(place)
      end
    end
  end

  # Denna funktion kollar om inventory innehåller ett item
  def inventory_contains_item(inventory_category, item)
    i=0
    while (i < inventory_category.length)
      if (inventory_category[i] == item)
        return i
      end
      i+=1
    end
    return false
  end


  # hjälp metoder för att få ut olika värden för Player
  def name()
    return @name
  end
  def age()
    return @age
  end
  def inventory()
    return @inventory
  end
  def health()
    return @health
  end
  def max_health()
    return @max_health
  end
  def room()
    return @room
  end
  def klass()
    return @klass
  end
  def race()
    return @race
  end
  def melee_weapons()
    return @inventory[0]
  end
  def ranged_weapons()
    return @inventory[1]
  end
  def potions()
    return @inventory[2]
  end
  def misc()
    return @inventory[3]
  end
  def armour_set()
    return @armour[0]
  end
  def armour_value()
    return @armour[1]
  end



    
end




person = Player.new()

person.race = "elf"