#TBA, Text based adventure game 


#character 
class Player 
  attr_accessor :room
  attr_accessor :health
  attr_accessor :age
  attr_accessor :klass
  attr_accessor :race
  attr_accessor :armour
  attr_accessor :inventory
  attr_accessor :money
  attr_accessor :name
  
  attr_reader :inventory, :armour, :money, :name, :max_health, :room

  

  @@weapons = ["Half_Sword", "gamecubespiklubba", "lasersvärd", "great_axe", "staff_of_alchemy", "muddy_rock", "rusty_spear", "two_handed_sword"]
  
  @@potions = [["small_health_potion", "medium_health_potion", "large_health_potion", "max_health_potion"], ["small_damage_potion", "medium_damage_potion", "large_damage_potion", "one_hit_potion"]]
  @@healing_potions = ["small_health_potion", "medium_health_potion", "large_health_potion", "max_health_potion"]
  @@damage_potions = ["small_damage_potion", "medium_damage_potion", "large_damage_potion", "one_hit_potion"]
  @@misc = ["fur_hat", "mickey_mouse_hat", "santa_hat", "party_hat", "party_horn", "party_blowout"]

  @@races = ["human", "elf", "dwarf", "orc", "goblin"]
  @@klasser = ["knight", "Jakob Widebrant", "peasant", "alchemist", "ranger"]
  @@armours = [["no_armour", 0], ["rusty_armour", 2], ["chainmail_armour", 5], ["hardened_leather_armour", 3], ["full_plate_armour", 8], ["dragon_scale_armour", 15]]
  
  
  def initialize()
    @inventory = [[], [], [[],[]], []]
    @max_health = 100
    @armour = ["no_armour", 0] #fixa sennare
    @money = 0
   
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
      puts "Valid races are: #{@@races}"
      @race = gets.chomp.downcase.to_s
      while !@@races.include?(@race)
        puts "Please provide a valid race!"
        puts "The valid races are: #{@@races}"
        @race = gets.chomp.downcase.to_s
      end
      puts "Choose what class you want to be"
      puts "Valid classes are: #{@@klasser}"
      puts "Jakob Widebrant is a GOD"
      @klass = gets.chomp.downcase.to_s
      while !@@klasser.include?(@klass)
        puts "Please provide a valid class!"
        puts "The valid classes are: #{@@klasser}"
        @klass = gets.chomp.downcase.to_s
      end
      @health = 100

      if @klass == "knight"
        puts "You have chosen the knight class"
        puts "You have now been equipped with a Half-sword"
        @max_health = 200
        @health = 200
        @inventory[0] << "Half_Sword"
      
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
        @inventory[0] << "muddy_rock"
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
    money = 10
    
    save() #autosave
    puts "autosave"

    puts "You are a #{@age} year old #{@race} #{@klass} with #{@health} health."
    puts "You have the following items in your inventory:"
    puts "Weapons: #{@inventory[0]}"
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

  def melee_attack(enemy)
  puts "Choose your weapon from your inventory: #{@inventory[0]}"
  weapon = gets.chomp.downcase.to_s
  while !@inventory[0].include?(weapon)
    puts "Please choose a valid weapon!"
    puts "Valid weapons are: #{@inventory[0]}"
    weapon = gets.chomp.downcase.to_s
  end

  base_damage = rand(5..10)

  case @klass
  when "knight"
    base_damage *= 2
  when "Jakob Widebrant"
    base_damage *= 13.37
  when "peasant"
    base_damage *= 1.2
  when "alchemist"
    base_damage *= 0.2
  when "ranger"
    base_damage *= 0.4
  else
    raise "Error - Unknown class"
  end

  case weapon
  when "gamecubespiklubba"
    base_damage *= 3.5
  when "lasersvärd"
    base_damage *= 2.0
  when "great_axe"
    base_damage *= 2.5
  when "staff_of_alchemy"
    base_damage *= 0.5
  when "rusty_spear"
    base_damage *= 0.8
  when "muddy_rock"
    base_damage *= 0.5
  when "two_handed_sword"
    base_damage *= 2.0
  

  damage = base_damage - enemy[:armour]
  damage = [damage, 0].max
  puts "You attack the #{enemy[:name]} with your #{weapon}!"
  puts "You deal #{damage} damage."
  end 
end



# Fix drop method:
def drop(item)
  if @inventory[0].include?(item)
    @inventory[0].delete(item)
  elsif @inventory[2][0].include?(item) || @inventory[2][1].include?(item)
    @inventory[2][0].delete(item)
    @inventory[2][1].delete(item)
  elsif @inventory[3].include?(item)
    @inventory[3].delete(item)
  else
    puts "Item not found in inventory"
  end
end


  def use_potion()
    puts "Do you want to use a health potion or a damage potion?"
    potion_type = gets.chomp.downcase.to_s
    while potion_type != "health" && potion_type != "damage"
      puts "Please choose a valid potion type!"
      puts "Valid potion types are: health, damage"
      potion_type = gets.chomp.downcase.to_s
    end
    
    if potion_type == "damage"
      puts "You have the following damage potions in your inventory: #{@inventory[2][1]}"
      puts "Choose a damage potion to use: "
      potion = gets.chomp.downcase.to_s
      while !@inventory[2][1].include?(potion)
        puts "Please choose a valid damage potion!"
        puts "Valid damage potions are: #{@inventory[2][1]}"
        potion = gets.chomp.downcase.to_s
      end
      puts "You have used the #{potion} potion!"
      drop(potion)
      if potion == "small_damage_potion"
        puts "You deal 15 damage."
        return 15
      elsif potion == "medium_damage_potion"
        puts "You deal 30 damage."  
        return 30
      elsif potion == "large_damage_potion"
        puts "You deal 50 damage."
        return 50
      elsif potion == "one_hit_potion"
        puts "You deal infinite damage."
        return 99999999
      end
    elsif potion_type == "health"
      puts "You have the following health potions in your inventory: #{@inventory[2][0]}"
      puts "Choose a health potion to use: "
      potion = gets.chomp.downcase.to_s
      while !@inventory[2][0].include?(potion)
        puts "Please choose a valid health potion!"
        puts "Valid health potions are: #{@inventory[2][0]}"
        potion = gets.chomp.downcase.to_s
      end
      puts "You have used the #{potion} potion!"
      if potion == "small_health_potion"
        @health += 10
      elsif potion == "medium_health_potion"
        @health += 20
      elsif potion == "large_health_potion"
        @health += 40
      elsif potion == "max_health_potion"
        @health = @max_health
      end
      if @health > @max_health
        @health = @max_health
      end
      puts "You have now #{@health} health."
      drop(potion)
      return 0
    end
  end
  
  def save()
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
    fil.puts(@room)
    fil.puts(@money)
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
    @money = lines[12].chomp.to_i
  end
  
  def pick_up(item)
    if @@weapons.include?(item)
      @inventory[0] << (item)
    elsif @@potions.include?(item)
      if @healing_potions.include?(item)
        @inventory[2][0] << item
      else
        @inventory[2][1] << item
      end
    elsif @@misc.include?(item)
      @inventory[3] << item
    elsif @@armours.include?(item)
      @armour = item
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




    
end

#funktioner för alla rum i spelet //hade varit nice om de ligger i en separat fil sedan

#Rum 1
#I entrence fins the fyra olika dörrar i rummet som personen måste välja mellan.
def entrance()
  valid_room = ["the_northen_door", "the_southern_door", "the_eastern_door", "the_western_door"]
  puts "You have now entered the world of the unknown"
  puts "You are in a dark room, you can see a door to your east and a door to your west"
  puts "You can also see a door in the north and a door to the south"
  puts "You now need to choose which door to enter"
  puts "Valid doors are: #{valid_room}"
  room = gets.chomp.downcase.to_s
  while !valid_room.include?(room)
    puts "Please choose a valid door to enter"
    puts "Valid doors are: #{valid_room}"
    room = gets.chomp.downcase.to_s
  end

  # Map the player's choice to the corresponding room name
  case room
  when "the_northen_door"
    return "room_to_the_north"
  when "the_southern_door"
    return "room_to_the_south"
  when "the_eastern_door"
    return "room_to_the_east"
  when "the_western_door"
    return "room_to_the_west"
  end
end

# i detta rum så finns det ett mystiskt vapen för en vilken klass som spelaren kan har valt för att spelaren ska få vapnet så måste spelaren lösa en gåta.
def room_to_the_north()
  $player1.save()
  puts "autosave "
  valid_answer = ["fire", "ballon", "shadow", "water", "wind"]
  puts "You have entered the room to the north"
  puts "Infront of you is a chest with a mystic weapon inside it"
  puts "to open the chest you need to solve a riddle"
  puts "The riddle is: I am not alive, but I can grow. I don't have lungs, but I need air. What am I?"  
  puts "A Fire,A Ballon,A Shadow, water or The wind"
  answer = gets.chomp.downcase.to_s
  while !valid_answer.include?(answer)
    puts "Please provide a valid answer to the riddle"
    puts "valid answers are: fire, ballon, shadow, water or wind"
    answer = gets.chomp.downcase.to_s
  end
  if answer == "fire" # vi behöver fixa så att det går att plocka upp vapnet
    puts "You have solved the riddle and the chest is now open"
    puts "Inside the chest you find a mythic weapon that will grant you power"
    puts "You can now pick up the weapon and add it to your inventory"
    if $player1.klass == "knight"
      puts "You now have a great axe"
      $player1.pick_up("great_axe")
    elsif $player1.klass == "Jakob Widebrant"
      $player1.pick_up("gamecubespiklubba")
    elsif $player1.klass == "peasant"
      $player1.pick_up("rusty_spear")
    elsif $player1.klass == "alchemist"
      $player1.pick_up("max_health_potion")
    elsif $player1.klass == "ranger"
      $player1.pick_up("giant_hunting_bow")
    end
  else
    puts "You have failed to solve the riddle and the chest is still locked"
  end

  #puts "You see a huge door infront of you. You enter"
  #return minotaur 
  #efter rummet så behöver spelaren antingen välja ett annat rum elle skikas till ett nytt rum
  return room_to_the_west
end



# i detta rum fins det tre olika koppar som spelaren måste välja mellan
def room_to_the_west()
  $player1.save()
  puts "autosave "
  valid_cup = ["left","right","middle"]
  puts "You havle entered the room to the west"
  puts "Infront of you is a table with three difrent cups"
  puts "In one of the cups there is a potion that will grant your strength, in another cup there is a cup with poison that will kill you slowly and in the last cup their is water choose wisely "
  puts "now choose the cup to the left, the cup to the right or the cup in the middle"
  cup = gets.chomp.downcase.to_s
  while valid_cup.include?(cup)
    puts "Please choose a valid door to enter left, right, middle"
    cup = gets.chomp.downcase.to_s
  end
  if cup == "middle"
    puts "You drank from the cup and you start felin how your stomach is hurting and your eyes star poping out from your head willes your holding on to your life by the thread befor you die"
    puts "You have died and lost the game"
    puts "Game over"
    # break
  elsif cup == "left"
    puts "In the cup that you chose there was water and you can now continue playing"
  elsif cup == "right"
    puts "You have chossen wisely in the cup that you chose their was a strength potion that will grant strengt through out your jorney"
  end
  puts "You now see three choices i front of you, You can go back to old room, or go through either the eastern door, northern door or the south door"
  while !valid_room.include?(room)
    puts "Please choose a valid door to enter"
    puts "Valid doors are: #{valid_room}"
    room = gets.chomp.downcase.to_s
  end

  # Map the player's choice to the corresponding room name
  case room
  when "the_northen_door"
    return "room_to_the_north"
  when "the_southern_door"
    return "room_to_the_south"
  when "the_eastern_door"
    return "room_to_the_east"
  when "the_western_door"
    return "room_to_the_west"
  end
end


#i detta rum mötter du en lättare boss som hets gustaf
#gustaf måste läggas in i enemy klassen och han måste ha en health och damage system
def room_to_the_south()
  gustaf = {
    name: "Gustaf the Giant",
    health: 120,
    max_health: 120,
    attack: 25,
    armor: 8,
    alive: true,
    weapon: "Giant's Cleaver",
    description: "A massive brute with scars covering his face and arms"
  }
  
  # Reset Gustaf's health at start of battle
  gustaf[:health] = gustaf[:max_health]
  $player1.save()
  valid_attacks = ["melee", "potion"]
  
  puts "Autosave complete."
  puts "You have entered the room to the south"
  puts "A deep growl echoes through the chamber..."
  
  while gustaf[:health] > 0 && $player1.health > 0
    puts "#{gustaf[:description]}"
    puts "In front of you is #{gustaf[:name]} who has now spotted you!"
    puts "Gustaf's Health: #{gustaf[:health]}/#{gustaf[:max_health]}"
    puts "Your Health: #{$player1.health}/#{$player1.max_health}"
    puts "\nChoose attack: melee or potion"
    
    attack = gets.chomp.strip.downcase
    
    # Input validation
    until valid_attacks.include?(attack)
      puts "Please choose a valid attack: melee or potion"
      attack = gets.chomp.strip.downcase
    end
    
    case attack
    when "melee"
      # Player attacks
      damage_dealt = $player1.melee_attack(gustaf)
      damage_dealt = [damage_dealt - gustaf[:armor], 1].max # Armor reduces damage
      gustaf[:health] -= damage_dealt
      puts "#{gustaf[:name]} takes #{damage_dealt} damage! (#{gustaf[:health]}/#{gustaf[:max_health]} HP remaining)"
      
      # Check if Gustaf is defeated
      if gustaf[:health] <= 0
        gustaf[:alive] = false
        next # Skip enemy attack if dead
      end
      
    when "potion"
      potion_damage = $player1.use_potion()
      if potion_damage > 0 # Damage potion was used
        damage_dealt = [potion_damage - gustaf[:armor], 1].max
        gustaf[:health] -= damage_dealt
        puts "#{gustaf[:name]} takes #{damage_dealt} damage from your potion! (#{gustaf[:health]}/#{gustaf[:max_health]} HP remaining)"
        
        if gustaf[:health] <= 0
          gustaf[:alive] = false
          next
        end
      end
    end
    
    # Gustaf attacks back if still alive
    if gustaf[:alive]
      puts "#{gustaf[:name]} swings his #{gustaf[:weapon]} at you!"
      player_damage = [gustaf[:attack] - $player1.armour[1], 1].max
      $player1.health -= player_damage
      puts "You take #{player_damage} damage! (#{$player1.health}/#{$player1.max_health} HP remaining)"
      
      if $player1.health <= 0
        puts "You have been defeated by #{gustaf[:name]}!"
        return "game_over"
      end
    end
  end
  
  if gustaf[:health] <= 0
    puts "You have defeated #{gustaf[:name]}!"
    # Add reward or progression here
    return "room_to_the_east" # or whatever the next room should be
  end
  
  $player1.room # Return current room if battle was interrupted
end

#I detta rum så kommer du behöva klara ett pussel/spel det kommer vara ett sten sax påse spel med försten till tre
def room_to_the_east()
  $player1.save()
  puts "autosave "
  puts "You have entered the room to the east"
  puts "we are going to play a game of rock paper scissors"
  puts "You have three options to choose from rock, paper or scissors"
  puts "You will play against me first to three"
  player_score = 0
  computer_score = 0
  choices = ["rock", "paper", "scissors"]

  while player_score < 3 && computer_score < 3
    puts "Choose rock, paper, or scissors:"
    player_choice = gets.chomp.downcase

    while !choices.include?(player_choice)
      puts "Invalid choice. Please choose rock, paper, or scissors:"
      player_choice = gets.chomp.downcase
    end

    computer_choice = choices.sample
    puts "The computer chose #{computer_choice}"

    if player_choice == computer_choice
      puts "It's a tie!"
    elsif (player_choice == "rock" && computer_choice == "scissors") ||
          (player_choice == "paper" && computer_choice == "rock") ||
          (player_choice == "scissors" && computer_choice == "paper")
      puts "You win this round!"
      player_score += 1
    else
      puts "You lose this round!"
      computer_score += 1
    end

    puts "Score: You: #{player_score} - Computer: #{computer_score}"
  end

  if player_score == 3
    puts " You win the game! You get a reward!"
    #Give reward
  else
    puts " You lose the game! No reward this time."
  end
end

#rum 5 boss rom the boss's name is Minotaur, he has 200 health and he is a hard boss to beat
#minotaur måste läggas in i enemy klassen och han måste ha en health och damage system, vi måste fixa så att 
def minotaur() #boss rum
  valid_attacks = ["meele", "potion"]
  minotaur = {name: "Minotaur", health: 200, attack: 20, armour: 5}
  puts "you have entered the Minotaur layer. There is only one way out, either kill the minotaur or die trying"
  puts "The minotaur has 200 health and a giant axe that strikes heavy hits with devestating damage. He does not have any attacks"
  while minotaur[:health]>0 && $player1.health>0
    puts "in front of you is a giant named Minotaur that has now spotted you"
    puts "chosse what you want to do! meele, or potion"  
    attack = gets.chomp.strip.downcase.to_s
    while !valid_attacks.include?(attack)
      puts "chosse valid attack, meele or potion"
      attack = gets.chomp.strip.downcase.to_s
    end
    if attack == "meele"
      puts "You attack Minotaur with your meele attack"
  
      minotaur[:health] -= $player1.melee_attack(minotaur)
      puts "Minotaur now has #{minotaur[:health]} health left"
    elsif attack == "potion"
      minotaur[:health] -= $player1.use_potion()
      puts "Minotaur has now #{minotaur[:health]} health left" 
    end


    
    puts "The Minotaur attacks you with its giant axe"
    damage = minotaur[:attack] - $player1.armour[1]
    if damage < 0
      damage = 0
    end
    $player1.health -= damage
    puts "the minotaur deals #{damage} damage to you"
    puts "You now have #{$player1.health} health left"
  end
  if $player1.health <= 0
    puts "You have died and lost the game"
    puts "Game over"
    return "You lose"
    #break
  elsif minotaur[:health] <= 0
    puts "You have killed the Minotaur and won the battle"
    return "win"
  end
end

def kentaur()
  kentaur = [name: "kentaur", health: 100, attack: 20, armour: 5]
  puts "a Kentaur has appeared in front of you"
  puts "The kentaur has 100 health and is swinging a short sword."

  while kentaur[:health] > 0 && $player1.health > 0
    puts "What will you do?"
    puts "Use potion"
    puts "Meele attack"
    valid_attacks = ["meele", "potion"]
    attack = gets.chomp.strip.downcase.to_s
    while !valid_attacks.include?(attack)
      puts "chosse valid attack, meele or potion"
      attack = gets.chomp.strip.downcase.to_s
    end
    if attack == "meele"
      puts "You attack the kentaur with your meele attack"
      $player1.melee_attack(weapon)
      kentaur_health -= 20 #fixa med damged system
      puts "The kentaur now has #{kentaur_health} health left"
    elsif attack == "potion"
      kentaur[:health] -= $player1.use_potion()
    end

    puts "The kentaur attacks you with its shortsword"
    damage = kentaur[:attack] - $player1.armour[1]
    if damage < 0
      damage = 0
    end
    $player1.health -= damage
    puts "the kentaur deals #{damage} damage to you"
    puts "You now have #{$player1.health} health left"
  end
  if $player1.health <= 0
    puts "You have died and lost the game"
    puts "Game over"
    #break
  elsif minotaur[:health] <= 0
    puts "You have killed the Kentaur and won the battle"
    return "win"
  end
end

def dragon()
  valid_attacks = ["meele", "potion"]
  dragon = [name: "dragon", health: 420, attack: 20, armour: 5]
  puts "The great red dragon has appeared"
  puts "The door quickly closes behind you. You realize you cannot leave"
  
  while dragon[:health] > 0 && $player1.health>0
    puts "What do you do?"
    puts "you can use #{valid_attacks}"
    valid_attacks = ["meele", "potion"]
    attack = gets.chomp.strip.downcase.to_s
    while !valid_attacks.include?(attack)
      puts "chosse valid attack, meele or potion"
      attack = gets.chomp.strip.downcase.to_s
    end
    if attack == "meele"
      puts "You attack the dragon with your meele attack"
      $player1.melee_attack(weapon)
      kentaur_health -= 20 #fixa med damged system
      puts "The kentaur now has #{kentaur_health} health left"
    elsif attack == "potion"
      kentaur[:health] -= $player1.use_potion()
    end

    puts "The Dragon attacks you with its mighty claws"
      damage = dragon[:attack] - $player1.armour[1]
      if damage < 0
        damage = 0
      end
      $player1.health -= damage
      puts "the kentaur deals #{damage} damage to you"
      puts "You now have #{$player1.health} health left"
    if $player1.health <= 0
    puts "You have died and lost the game"
    puts "Game over"
    #break
    elsif dragon[:health] <= 0
      puts "You have killed the Kentaur and won the battle"
      return "win"
    end
  end
end

      

      

  
    
def shop()
  puts "You have entered the shop"
  puts "You can buy potions, armour and weapons"
  puts "You can also sell your items to the shopkeeper"
  puts "You can leave the shop by typing 'exit'"
  puts "You can also check your money by typing 'money'"
  puts "You can also check your inventory by typing 'inventory'"
  products = ["small_health_potion", "medium_health_potion", "large_health_potion", "small_damage_potion", "medium_damage_potion", "large_damage_potion", "fur_hat", "rusty_armour"]
  
  while true
    puts "What do you want to do?"
    action = gets.chomp.downcase.to_s
    case action
    when "exit"
      puts "You have left the shop"
      return 
    when "money"
      puts "You have #{$player1.money} money"
    when "inventory"
      puts "Your inventory is: #{$player1.inventory}"
    when "buy"
      puts "What do you want to buy?"
      puts "Valid products are: #{products}"
      product = gets.chomp.downcase.to_s
      while !products.include?(product)
        puts "Please choose a valid product to buy"
        puts "Valid products are: #{products}"
        product = gets.chomp.downcase.to_s
      end
      puts "You have chosen to buy #{product}"
      puts "You have #{$player1.money} money"
      case product
      when "small_health_potion"
        puts "this potion costs 10 money"
        if $player1.money >= 10
          $player1.money -= 10
          $player1.pick_up(product)
          puts "You have bought a #{product}"
        else
          puts "You do not have enough money to buy this potion"
        end
      when "medium_health_potion"
        puts "this potion costs 20 money"
        if $player1.money >= 20
          $player1.money -= 20
          $player1.pick_up(product)
          puts "You have bought a #{product}"
        else
          puts "You do not have enough money to buy this potion"
        end

      when "large_health_potion"
        puts "this potion costs 50 money"
        if $player1.money >= 50
          $player1.money -= 50
          $player1.pick_up(product)
          puts "You have bought a #{product}"
        else
          puts "You do not have enough money to buy this potion"
        end
      when "small_damage_potion"
        puts "this potion costs 10 money"
        if $player1.money >= 10
          $player1.money -= 10
          $player1.pick_up(product)
          puts "You have bought a #{product}"
        else
          puts "You do not have enough money to buy this potion"
        end
      when "medium_damage_potion"
        puts "this potion costs 20 money"
        if $player1.money >= 20
          $player1.money -= 20
          $player1.pick_up(product)
          puts "You have bought a #{product}"
        else
          puts "You do not have enough money to buy this potion"
        end
      when "large_damage_potion"
        puts "this potion costs 50 money"
        if $player1.money >= 50
          $player1.money -= 50
          $player1.pick_up(product)
          puts "You have bought a #{product}"
        end
      when "fur_hat"
        puts "this hat costs 100 money"
        if $player1.money >= 100
          $player1.money -= 100
          $player1.pick_up(product)
          puts "You have bought a #{product}"
        end
      when "chainmail_armour"
        puts "this armour costs 100 money"
        if $player1.armour[1] > 5
          puts "You already have better armour than this"
        else
          if $player1.money >= 100
            puts "You have bought a chainmail armour"
            puts "You now have 5 defence"
            $player1.money -= 100
            $player1.pick_up(["chainmail_armour", 5])
          else
            puts "You do not have enough money to buy this armour"
          end
        end
          
      else
        puts "You do not have enough money to buy this potion"
      end

    when "sell"
      puts "not implemented yet"
    else
      puts "Invalid action. Please try again."
    end

  end
end


def walk_ways()
  room_methods = {
    "entrance" => method(:entrance),
    "room_to_the_north" => method(:room_to_the_north),
    "room_to_the_south" => method(:room_to_the_south),
    "room_to_the_east" => method(:room_to_the_east),
    "room_to_the_west" => method(:room_to_the_west),
    "minotaur" => method(:minotaur)
  }

  while $player1.room != "win" && $player1.room != "game_over"
    puts "You are in the walkways."
    puts "you see a shop, do you want to enter the shop? (y/n)"
    input = gets.chomp.downcase.to_s
    while input != "y" && input != "n"
      puts "Please enter a valid input (y/n)"
      input = gets.chomp.downcase.to_s
    end
    if input == "y"
      shop()
    elsif input == "n"
      puts "You have chosen not to enter the shop"
    end
    if room_methods.key?($player1.room)
      $player1.room = room_methods[$player1.room].call
    else
      raise "Unknown room. Please check the room name."
    end
  end

  if $player1.room == "win"
    puts "Congratulations! You have won the game!"
  elsif $player1.room == "game_over"
    puts "Game over. Better luck next time!"
  end
end




#starta spelet
puts "Welcome to the game"
$player1 = Player.new()
walk_ways()