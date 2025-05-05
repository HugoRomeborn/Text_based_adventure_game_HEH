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
  
  attr_reader :inventory, :armour, :money, :name, :max_health, :room

  

  @@weapons = ["half_sword", "gamecubespiklubba", "light_sable", "great_axe", "staff_of_alchemy", "muddy_rock", "rusty_spear", "two_handed_sword", "pitchfork"]
  
  @@potions = ["small_health_potion", "medium_health_potion", "large_health_potion", "max_health_potion", "small_damage_potion", "medium_damage_potion", "large_damage_potion", "one_hit_potion"]
  @@healing_potions = ["small_health_potion", "medium_health_potion", "large_health_potion", "max_health_potion"]
  @@damage_potions = ["small_damage_potion", "medium_damage_potion", "large_damage_potion", "one_hit_potion"]
  @@misc = ["fur_hat", "mickey_mouse_hat", "santa_hat", "party_hat", "party_horn", "party_blowout"]

  @@races = ["human", "elf", "dwarf", "orc", "goblin"]
  @@klasser = ["knight", "jakob widebrant", "peasant", "alchemist", "ranger"]
  @@armours = [["no_armour", 0], ["rusty_armour", 2], ["chainmail_armour", 5], ["hardened_leather_armour", 3], ["full_plate_armour", 8], ["dragon_scale_armour", 15]]
  
  #Namn: Hugo Romeborn, Edwin Pegalow och Hugo Karlsson
  def initialize()
    @inventory = [[], [], [[],[]], []]
    @max_health = 100
    @armour = ["no_armour", 0] #fixa sennare
    @money = 10
   
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
        @inventory[0] << "half_sword"
      
      elsif @klass == "jakob widebrant"
        puts "You are now Jakob Widebrant"
        puts "You have now been equipped with a gamecubespiklubba"
        puts "You are a GOD"
        @max_health = 500
        @health = 400
        @inventory[0] << "gamecubespiklubba"
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

  #Namn: Edwin Pegalow och Hugo Karlsson
  def meele_attack(enemy)
    base_damage = rand(5..10) # base damage is random between 5 and 10

    case klass
    when "knight"
      base_damage *= 2
    when "jakob widebrant"
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

    puts "choose your weapon from your inventory: #{@inventory[0]}"
    weapon = gets.chomp.downcase.to_s
    while !@inventory[0].include?(weapon)
      puts "Please choose a valid weapon!"
      puts "Valid weapons are: #{@inventory[0]}"
      weapon = gets.chomp.downcase.to_s
    end
    puts "You have chosen the #{weapon}"

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
    when "half_Sword"
      base_damage *= 1.2
    when "pitchfork"
      base_damage *= 1.1
    end


    damage = base_damage - enemy[:armour] # subtract enemy's armour from damage
    if damage < 0
      damage = 0
    end
    puts "You attack the #{enemy[:name]} with your #{weapon}!"
    puts "You deal #{damage} damage."
    return damage
  end

  #Namn: Hugo Romeborn
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
        return 999
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
  



  # Beskrivning: funktionen sparar all information om en spelare inuti en fil
  # Argument 1: nil
  # Return: nil
  # Exempel:
  #... ... ... ...
  #... ... ... ...
  #... ... ... ...
  #... ... ... ...
  # Datum: ...
  # Namn: Hugo Romeborn och Edwin Pegalow
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
  
  #Namn: Edwin Pegalow, Hugo Romeborn och Hugo Karlsson
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
    @armour = lines[10].chomp.split.dup
    @room = lines[11].chomp
    @money = lines[12].chomp.to_i
    @armour[1] = @armour[1].to_i
  end

  #Namn: Edwin Pegalow
  def pick_up(item)
    if @@weapons.include?(item)
      @inventory[0] << (item)
    elsif @@potions.include?(item)
      if @@healing_potions.include?(item)
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

  #Namn: Edwin Pegelow och Hugo Romeborn
  def drop(item)
    if @@weapons.include?(item)
      place = include?(@inventory[0], item)
      if place != false
        @inventory[0].delete_at(place)
      end
    elsif @@potions.include?(item)
      if @@healing_potions.include?(item)
        place = contains_item(@inventory[2], item)
        if place != false
          @inventory[2].delete_at(place)
        end
      else
        place = contains_item(@inventory[2], item)
        if place != false
          @inventory[2].delete_at(place)
        end
      end
    else
      place = contains_item(@inventory[3], item)
      if place != false
        @inventory[3].delete_at(place)
      end
    end
  end

  # Denna funktion kollar om inventory innehåller ett item
  #Namn: Hugo Romeborn och Edwin Pegalow
  def contains_item(inventory_category, item)
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
#Namn: Hugo Karlsson
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

# i detta rum så finns det ett mystiskt vapen för en vilken klass som spelaren kan har valt, för att spelaren ska få vapnet så måste spelaren lösa en gåta.
#Namn: Hugo Karlsson
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
  if answer == "fire" 
    puts "You have solved the riddle and the chest is now open"
    puts "Inside the chest you find a mythic weapon that will grant you power"
    puts "You can now pick up the weapon and add it to your inventory"
    if $player1.klass == "knight"
      puts "You now have a great axe"
      $player1.pick_up("great_axe")
    elsif $player1.klass == "jakob widebrant"
      puts "You now have a gamecubespiklubba"
      $player1.pick_up("gamecubespiklubba")
    elsif $player1.klass == "peasant"
      puts "You now have a rusty_spear"
      $player1.pick_up("rusty_spear")
    elsif $player1.klass == "alchemist"
      puts "You now have a max_health_potion"
      $player1.pick_up("max_health_potion")
    elsif $player1.klass == "ranger"
      puts "You now have a giant_hunting_bow"
      $player1.pick_up("giant_hunting_bow")
    end
  else
    puts "You have failed to solve the riddle and the chest is still locked"
  end

  return room_to_the_south()
end



# i detta rum fins det tre olika koppar som spelaren måste välja mellan
#Namn: Hugo Karlsson
def room_to_the_west()
  $player1.save()
  puts "autosave "
  valid_cup = ["left","right","middle"]
  puts "You havle entered the room to the west"
  puts "Infront of you is a table with three difrent cups"
  puts "In one of the cups there is a potion that will grant your strength, in another  and in and in the other cup theirs a cup that will with poison that will kill you slowly and in the last cup their is water  chose wisely beacuse it will "
  puts "know choose the cup to the left, the cup to the right or the cup in the middle"
  cup = gets.chomp.downcase.to_s
  while valid_cup.include?(cup)
    puts "Please choose a valid door to enter left, right, middle"
    cup = gets.chomp.downcase.to_s
  end
  if cup == "middle"
    puts "You drank from the cup and you start felin how your stomach is hurting and your eyes star poping out from your head willes your holding on to your life by the thread befor you die"
    puts "You have died and lost the game"
    puts "Game over"
  
  elsif cup == "left"
    puts "In the cup that you chose there was water and you can now continue playing"
  elsif cup == "right"
    puts "You have chossen wisely in the cup that you chose their was a strength potion that will grant strengt through out your jorney"
  end
  
  puts "You see two doors infront of you, one to the left and one to the right"
  puts "Which door do you want to go through?"
  puts "1. Left door"
  puts "2. Right door"
  choice = gets.chomp.to_i
  while choice != 1 && choice != 2
    puts "Please choose a valid door!"
    puts "1. Left door"
    puts "2. Right door"
    choice = gets.chomp.to_i
  end
  if choice == 1
    return "room_6"
  elsif choice == 2
    return "room_7"
  end
end

#i detta rum mötter du en lättare boss som hets gustaf
#gustaf måste läggas in i enemy klassen och han måste ha en health och damage system
#Namn: Hugo Karlsson
def room_to_the_south()
  $player1.save()
  puts "autosave "
  puts "You have entered the room to the south"
  puts "Infront of you is a giant named Gustaf that has now spotted you"
  fight_results = enemy({name: "Gustaf", health: 200, attack: 2, armour: 5, attack_type: "axe"})
  if fight_results == "win"
    puts "You have killed Gustaf and won the battle"
    puts "You can now pick up the loot that Gustaf dropped"
    puts "You have now picked up a medium_health_potion that will grant you strength for the rest of your jorney"
    puts "You have also picked up a potion that will heal you for 50 health"
    puts "You can now continue your adventure"
    $player1.pick_up("medium_health_potion")
  elsif fight_results == "lose"
    return "game_over"
  else
    raise "Error - Unknown fight result"
  end

  puts "You see three doors infront of you, one to the left, one in the mmiddle and one to the right"
  puts "Which door do you want to go through?"
  puts "1. Left door"
  puts "2. Right door"
  puts "3. middle door"
  choice = gets.chomp.to_i
  while choice != 1 && choice != 2 && choice != 3
    puts "Please choose a valid door!"
    puts "1. Left door"
    puts "2. Right door"
    puts "3. middle door"
    choice = gets.chomp.to_i
  end
  if choice == 1
    return "room_6"
  elsif choice == 2
    return "room_7"
  elsif choice == 3
    return "room_9"
  else
    raise "Error - Unknown choice"
  end
  
end

#I detta rum så kommer du behöva klara ett pussel/spel det kommer vara ett sten sax påse spel med försten till tre
#Namn: Hugo Karlsson (sten sax påse puzzel: Edwin pegelow)
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
    puts "You win the game! You get a reward!"
    puts "you pick up a medium health potion and 20 money"
    $player1.pick_up("medium_health_potion")
    $player1.money += 20
  else
    puts "You lose the game! No reward this time."
  end
  puts "You see two doors infront of you, one to the left and one to the right"
  puts "Which door do you want to go through?"
  puts "1. Left door"
  puts "2. Right door"
  choice = gets.chomp.to_i
  while choice != 1 && choice != 2
    puts "Please choose a valid door!"
    puts "1. Left door"
    puts "2. Right door"
    choice = gets.chomp.to_i
  end
  if choice == 1
    return "room_7"
  elsif choice == 2
    return "room_6"
  end
end

# Beskrivning: Funktionen är ett rum där du splear mot en minotaur som har rätt låga stats vilket bestäms i funktionen, den använder sig av enemy funktionen för attdu vinner eller dör.
# Argument 1: inga
# Return: string (game over)
# Exempel:
  # "game over" betyder du dog
# Datum: 04-05-2025
# Namn: Hugo Romeborn, Hugo Karlsson och Edwin Pegelow
def room_5()
  $player1.save()
  puts "autosave "
  puts "You have entered the room to the south"
  puts "Infront of you is a giant named Gustaf that has now spotted you"
  fight_results = enemy([name: "kentaur", health: 50, attack: 10, armour: 1, attack_type: "short_sword"])
  if fight_results == "win"
    puts "You have killed Gustaf and won the battle"
    puts "You can now pick up the loot that Gustaf dropped"
    puts "You have now picked up a small_health_potion that will grant you strength for the rest of your jorney"
    puts "You have also picked up a potion that will heal you for 50 health"
    puts "You can now continue your adventure"
  elsif fight_results == "lose"
    return "game_over"
  else
    raise "Error - Unknown fight result"
  end

  puts "You see two doors infront of you, one to the left and one to the right"
  puts "Which door do you want to go through?"
  puts "1. Left door"
  puts "2. Right door"
  choice = gets.chomp.to_i
  while choice != 1 && choice != 2
    puts "Please choose a valid door!"
    puts "1. Left door"
    puts "2. Right door"
    choice = gets.chomp.to_i
  end
  if choice == 1
    return "room_6"
  elsif choice == 2
    return "room_7"
  end
  
end

# Gåtrum där spelaren måste lösa en gåta för att få en belöning
def room_6()
  $player1.save()
  
  puts "in this room you will have to solve riddles to get a rewards"
  puts "wrong answers will result in a loss of health"
  puts "for each correct answer, you will get 2 health"
  puts "for each wrong answer, you will lose 5 health"
  puts "if you answer correctly to five riddles, you will get a reward"

  correct = 0

  #riddles
  while correct < 5 && $player1.health > 0
    riddle = $riddles.keys.sample
    case $riddles[riddle].call
    when true
      correct += 1
      $player1.health += 2
    when false 
      $player1.health -=5
    end
    $riddles.delete(riddle)
    puts "yor health is now #{$player1.health}"
  end
  if $player1.health < 0 
    return "game over"
  end
  if correct == 5
    case $player1.klass
    when "knight"
      $player1.pick_up("two_handed_sword")
      puts "you have gotten a two handed sword"
    when "jakob widebrant"
      $player1.pick_up("light_sable")
    when "peasant"
      $player1.pick_up("pitchfork")
    when "alchemist"
      $player1.pick_up("one_hit_potion")
      $player1.pick_up("small_damage_potion")
    when "ranger"
      $player1.pick_up("small_health_potion")
      $player1.pick_up("dagger")
    end
  end
  puts "You see two doors infront of you, one to the left and one to the right"
  puts "Which door do you want to go through?"
  puts "1. Left door"
  puts "2. Right door"
  choice = gets.chomp.to_i
  while choice != 1 && choice != 2
    puts "Please choose a valid door!"
    puts "1. Left door"
    puts "2. Right door"
    choice = gets.chomp.to_i
  end
  if choice == 1
    return "room_9"
  elsif choice == 2
    return "room_9"
  end
end

#strid
def room_7()
  $player1.save()
  puts "You have encountered a drunken old Adventurer who is trying to fight you"
  puts "He is not very strong, but he is very drunk and will attack you with a bottle of beer"
  
  fight_results = enemy([name: "Drunk Adventerur", health: 25, attack: 10, armour: 0, attack_type: "beer_bottle"])
  if fight_results == "win"
    puts "congratulations great adventerur you have defeted the drunken old adventerur"
    puts "to reward you great adventerur, here is a small health potion and 20 money"
    $player1.pick_up("small_health_potion")
    $player1.money += 20
    puts "You can now continue your adventure"
  elsif fight_results == "lose"
    return "game_over"
  else
    raise "Error - Unknown fight result"
  end

  puts "You see two doors infront of you, one to the left and one to the right"
  puts "Which door do you want to go through?"
  puts "1. Left door"
  puts "2. Right door"
  choice = gets.chomp.to_i
  while choice != 1 && choice != 2
    puts "Please choose a valid door!"
    puts "1. Left door"
    puts "2. Right door"
    choice = gets.chomp.to_i
  end
  if choice == 1
    return "room_9"
  elsif choice == 2
    return "room_11"
  end
  
end

#ej strid
def room_8()
  $player1.save()

  fight_results = enemy([name: "minotaur", health: 100, attack: 10, armour: 5, attack_type: "bow"])
end

#strid
def room_9()
  $player1.save()
  puts "autosave "
  puts "You have enterd the dragons layer and in the middle of the roms is a baby dragon but dont let its size fool you"
  puts "The baby dragon has emens power"
  fight_results = enemy({name: "baby dragon", health: 35.0, attack: 19.0, armour: 0, attack_type: "fire breath"})
  if fight_results == "win"
    puts "You have killed baby_dragon and won the battle"
    puts "To reward you great adventerur, here is a medium health potion and 20 money"
    $player1.pick_up("medium_health_potion")
    $player1.money += 20
    
    puts "You can now continue your adventure"
  elsif fight_results == "lose"
    return "game_over"
  else
    raise "Error - Unknown fight result"
  end

  puts "You see two doors infront of you, one to the left and one to the right"
  puts "Which door do you want to go through?"
  puts "1. Left door"
  puts "2. Right door"
  choice = gets.chomp.to_i
  while choice != 1 && choice != 2
    puts "Please choose a valid door!"
    puts "1. Left door"
    puts "2. Right door"
    choice = gets.chomp.to_i
  end
  if choice == 1
    return "room_11"
  elsif choice == 2
    return "room_12"
  end
end

#ej strid
def room_10()

end

#strid
def room_11()
  $player1.save()
  puts "autosave "
  puts "poor adventerur you have now enterd the catacombs and in this rum you will have to fight the great corpse of Edvin Pegelow"
  puts "This poor being has sufferd from science"
  fight_results = enemy([name: "Edvin Pegelows dead body", health: 42.0, attack: 9.0, armour: 0, attack_type: "kemistry bock"])
  if fight_results == "win"
    puts "You have defeted heels demon"
    puts "to reward you great adventerur, here is a medium health potion and 20 money"
    $player1.pick_up("medium_health_potion")
    $player1.money += 20
    puts "You can now continue your adventure"
  elsif fight_results == "lose"
    return "game_over"
  else
    raise "Error - Unknown fight result"
  end

  puts "You see two doors infront of you, one to the left and one to the right"
  puts "Which door do you want to go through?"
  puts "1. Left door"
  puts "2. Right door"
  choice = gets.chomp.to_i
  while choice != 1 && choice != 2
    puts "Please choose a valid door!"
    puts "1. Left door"
    puts "2. Right door"
    choice = gets.chomp.to_i
  end
  if choice == 1
    return "room_14"
  elsif choice == 2
    return "room_12"
  end
end

#strid
def room_12()
  $player1.save()
  puts "autosave"
  puts "in front of you great adventerur there is a tree with a sloth"
  puts "be careful hiss body is very strong and will deal alot of damage but he has like no health"
  fight_results = enemy({name: "sloth", health: 3.0, attack: 77.0, armour: 0, attack_type: "body slam from a tree"})
  if fight_results == "win"
    puts "congratulations great adventerur you have defetead the sloth that had a whole of 3 hp"
    puts "to congratulate you i want to reward you with a small healt potion so that you may recover"
    $player1.pick_up("small_health_potion")
    $player1.money += 20
    puts "you received a small health potion and 20 money"
    puts "You can now continue your adventure"
  elsif fight_results == "lose"
    return "game_over"
  else
    raise "Error - Unknown fight result"
  end

  puts "You see two doors infront of you, one to the left and one to the right"
  puts "Which door do you want to go through?"
  puts "1. Left door"
  puts "2. Right door"
  choice = gets.chomp.to_i
  while choice != 1 && choice != 2
    puts "Please choose a valid door!"
    puts "1. Left door"
    puts "2. Right door"
    choice = gets.chomp.to_i
  end
  if choice == 1
    return "room_14"
  elsif choice == 2
    return "room_14"
  end
end

#ej strid
def room_13()

end

#strid
def room_14()
  $player1.save()
  puts "autosave"
  $player1.save
  puts "Autosave complete..."
  puts ""
  sleep(1)
  puts "You step beyond a woven archway of roots and vines, entering a glade unlike any you've seen before."
  sleep(2)
  puts "The forest breathes here — you can feel it. The trees sway without wind, and soft blue mist hangs low over the mossy ground."
  sleep(2)
  puts "You hear no birds, no insects — only a low hum that vibrates in your bones."
  puts ""
  sleep(1.5)
  puts "Ancient stones form a circle in the clearings center, and in its heart rests a pool of silver water."
  sleep(2)
  puts "The surface ripples as a form emerges — smooth, powerful, and impossibly graceful."
  sleep(2)
  puts "A **Great Panther**, nearly twice your size, with fur like liquid night and eyes of glowing emerald, watches you in absolute silence."
  sleep(2)
  puts ""
  puts "It speaks — not with its mouth, but in your mind:"
  sleep(1)
  puts ""
  puts "\"You have wandered far, but power alone does not grant passage.\""
  sleep(2)
  puts "\"I am one of the Sacred — bound to the old blood, called only when one nears the Threshold of Bonding.\""
  sleep(2)
  puts "\"If your spirit is true... face me.\""
  sleep(2)
  puts ""
  puts "You feel your own spirit surge in response. The challenge is not for glory — it is a test of heart, of soul."
  fight_results = enemy(name: "Great Panther Spirit", health: 100.0, attack: 17.0, armour: 0, attack_type: "spirit fangs")
  if fight_results == "win"
    puts ""
    puts "The panther leaps forward, vanishing into silver mist mid-air. A warm glow surrounds your body."
    sleep(2)
    puts "You hear its voice once more: \"You are not alone anymore. I walk with you now.\""
    sleep(2)
    puts ""
    puts "A ghostly image of the panther appears briefly at your side, then fades."
    $player1.pick_up("small_health_potion")
    $player1.money += 20
    puts "you received a small health potion and 20 money"
    puts "You discover a glowing vial nestled in the grass. Drinking it restores your strength."
    sleep(2)
    puts ""
    puts "The pool begins to shimmer more brightly, and behind it, two forest paths form — paths born of magic."
    puts "A voice in the wind whispers: \"Choose your path, spirit-bound.\""
  elsif fight_results == "lose"
    puts ""
    puts "The panther's eyes flash one final time before everything goes still."
    sleep(2)
    puts "You feel the forest withdraw from you — as if your presence no longer belongs."
    sleep(2)
    puts "The ground falls away beneath your feet. Darkness swallows all."
    return "game_over"
  else
    raise "Error - Unknown fight result"
  end

  puts "You see two doors infront of you, one to the left and one to the right"
  puts "Which door do you want to go through?"
  puts "1. Left door"
  puts "2. Right door"
  choice = gets.chomp.to_i
  while choice != 1 && choice != 2
    puts "Please choose a valid door!"
    puts "1. Left door"
    puts "2. Right door"
    choice = gets.chomp.to_i
  end
  if choice == 1
    return "room_15"
  elsif choice == 2
    return "room_15"
  end
end

#strid
def room_15()
  $player1.save()
  puts "autosave"
  puts ""
  puts "You step into a circular stone chamber. The air shifts, carrying the scent of sea salt and burnt ozone."
  sleep(2)
  puts "Carved into the walls are glowing runes — ancient Greek, flickering with golden light."
  sleep(2)
  puts "A voice echoes from nowhere, yet everywhere..."
  sleep(1)
  puts ""
  puts "\"You stand in the Trial of the Olympians. Only the worthy may proceed.\""
  sleep(2)
  puts "\"Face the guardian of Poseidon’s vault — prove your courage, demigod.\""
  puts ""
  puts "From a ripple in the air, a massive serpent made of water and lightning bursts forth. It hisses — a sound like crashing waves."
  fight_results = enemy(name: "Storm Serpent", health: 70.0, attack: 20.0, armour: 0, attack_type: "electric")
  if fight_results == "win"
    puts "The Storm Serpent screeches, dissipating into mist and sparks. The runes pulse in approval."
    $player1.pick_up("small_health_potion")
    $player1.money += 20
    puts "you received a small health potion and 20 money"
    puts "You can now continue your adventure"
  elsif fight_results == "lose"
    return "game_over"
  else
    raise "Error - Unknown fight result"
  end

  puts "You see two doors infront of you, one to the left and one to the right"
  puts "Which door do you want to go through?"
  puts "1. Left door"
  puts "2. Right door"
  choice = gets.chomp.to_i
  while choice != 1 && choice != 2
    puts "Please choose a valid door!"
    puts "1. Left door"
    puts "2. Right door"
    choice = gets.chomp.to_i
  end
  if choice == 1
    return "room_16"
  elsif choice == 2
    return "room_16"
  end

end

#strid boss fight
def room_16()
  $player1.save
  puts "Autosave complete..."
  sleep(1)
  puts ""
  puts "You step into a vast, dark cavern. The air is thick with ash and silence."
  sleep(2)
  puts ""

  # NARRATION
  puts "Narrator:"
  sleep(1)
  puts "\"Long before kingdoms rose and fell... before men etched their names into stone and steel... there was fire.\""
  sleep(3)
  puts "\"From the smoking ruins of Valyria came a creature born not of flesh alone, but of shadow and wrath. His name would come to echo through history like a curse: Balerion — the Black Dread.\""
  sleep(4)
  puts "\"His wings blotted out the sun. His breath could melt castles. His roar silenced armies. He did not obey kings — kings obeyed him.\""
  sleep(4)
  puts "\"He bore Aegon the Conqueror across the narrow sea, burning Harrenhal to ash, bending the knee of six kingdoms with fire and fury. No walls could hold him. No swords could pierce him. He was death made winged.\""
  sleep(4)
  puts "\"But even gods grow old. Even dragons fade. Balerion vanished from the skies... his name becoming legend, his bones buried beneath the Red Keep — or so the world believed.\""
  sleep(4)
  puts "\"You now stand in the forgotten heart of the mountain, where fire never died. The stone here is scorched black. The air tastes of smoke and ruin. And from the abyss before you... something stirs.\""
  sleep(4)
  puts ""
  puts "*A rumble shakes the earth beneath your feet. The darkness moves.*"
  sleep(2)
  puts "*Two eyes open — vast, golden, ancient. A low growl rolls across the cavern, deeper than thunder.*"
  sleep(2)
  puts ""
  puts "\"Balerion lives.\""
  sleep(2)
  puts "And he is not pleased to see you."
  sleep(2)
  puts ""
  puts "  Prepare for battle. "
  puts ""

  # BATTLE
  fight_results = enemy(name: "Balerion", health: 400.0, attack: 20.0, armour: 10, attack_type: "fire")

  if fight_results == "win"
    puts ""
    puts "The dragon lets out a final, shattering roar before collapsing into the dust. The cavern trembles one last time, then falls silent."
    sleep(2)
    puts "You stand victorious — scorched, but alive."
    $player1.pick_up("small_health_potion")
    $player1.money += 500
    puts "You drink a potion and feel strength return to your limbs."
    sleep(2)
    puts "The path forward splits into two."
  elsif fight_results == "lose"
    puts ""
    puts "You fall to your knees as the searing heat overwhelms you. Balerion roars in triumph, and everything fades to black..."
    return "game_over"
  else
    raise "Error - Unknown fight result"
  end

  # CHOICE
  puts ""
  puts "You see two doors ahead, half-buried in rubble and shadow."
  puts "Which door do you want to go through?"
  puts "1. Left door glowing faintly with blue light"
  puts "2. Right door silent and cold"

  choice = gets.chomp.to_i
  while choice != 1 && choice != 2
    puts "Please choose a valid door:"
    puts "1. Left door"
    puts "2. Right door"
    choice = gets.chomp.to_i
  end

  
  return "win"
  
end

# Beskrivning: Olika typer av fiender som kan mötas i spelet funkktion för en fiende strid som kan sättas in i ett rum fienden kommer att ha en health och damage system som kommer att vara olika för varje fiende Fiendens stats bestäms av en hash som skickas in i funktionen     
# Argument 1: enemy (Hash) – Innehåller fiendens attribut som namn, hälsa, attack osv.
# Return: (String) "win" eller "lose" beroende på stridsresultat.
# Exempel:
  #result = enemy({ name: "Gustaf", health: 200, attack: 8, armour: 5, attack_type: "axe" })
# Datum: 28-04-2025
# Namn: Hugo Romeborn, Hugo Karlsson och Edwin Pegelow
def enemy(enemy)
  valid_attacks = ["inventory", "health", "meele", "potion"]
  p enemy[:name]
  puts "You have encountered #{enemy[:name]}"
  puts "You can now fight the #{enemy[:name]}"
  puts "You can also check your health by typing 'health'"
  puts "You can also check your inventory by typing 'inventory'"
  while enemy[:health] > 0 && $player1.health>0
    puts "What do you do?"
    puts "you can use #{valid_attacks}"
    attack = gets.chomp.strip.downcase.to_s
    while !valid_attacks.include?(attack)
      puts "chosse valid command, inventory, health, meele or potion"
      attack = gets.chomp.strip.downcase.to_s
    end
    if attack == "meele"
      puts "You attack the #{enemy[:name]} with your meele attack"
      enemy[:health] -= $player1.meele_attack(enemy) 
      puts "The #{enemy[:name]} now has #{enemy[:health]} health left"
      puts "The #{enemy[:name]} attacks you with its mighty #{enemy[:attack_type]}"
      damage = enemy[:attack] - $player1.armour[1]
      if damage < 0
        damage = 0
      end
      $player1.health -= damage
      puts "the #{enemy[:name]} deals #{damage} damage to you"
      puts "You now have #{$player1.health} health left"
    
    elsif attack == "potion"
      enemy[:health] -= $player1.use_potion()
      puts "The #{enemy[:name]} attacks you with its mighty #{enemy[:attack_type]}"
      damage = enemy[:attack] - $player1.armour[1]
      if damage < 0
        damage = 0
      end
      $player1.health -= damage
      puts "the #{enemy[:name]} deals #{damage} damage to you"
      puts "You now have #{$player1.health} health left"
      
    elsif attack == "health"
      puts "You have #{$player1.health} health left"
    elsif attack == "inventory"
      puts "Your inventory is: #{$player1.inventory}"
    else
      puts "Invalid action. Please try again."
    end
    
    
    if $player1.health <= 0
      puts "You have been killed by the #{enemy[:name]}"
      return "lose"
    elsif enemy[:health] <= 0
      puts "You have killed the Kentaur and won the battle"
      return "win"
    end
  end
end  

  
# Beskrivning: Det är en funktion som gör det möjligt för spelaren att köpa in game saker för "money" som sparars i spelar filen, Sälj funktionen finns inte det var en av avgränsningarna vi gjorde för att vi skulle bli klara.
# Argument: nil
# Return: nil
# Exempel:
 
# Datum: 28-04-2025
# Namn: Hugo Romeborn, Hugo Karlsson och Edwin Pegelow
   
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
      puts "The buyer is broke(not implemented yet)"
    else
      puts "Invalid action. Please try again."
    end

  end
end

# Beskrivning: Walkways är en funktion som skickar en mellan de olika rummen i spelet, funktioner ovan. Mellan rummen så kan spelaren välja att gå in i en shop och köpa saker för pengar som spelaren har fått i de olika rummen. Man förflyttas genom att använda sig av en hash som innehåller alla rum och deras metoder. Denna hash har olika namn som är kopplade till olika rum i spelet. Sedan kallas metoden för det rum som spelaren är på väg till och en ny rumsnyckel returneras från varje rum. Aktuellt rum sparas som en instansvariabel i objektet $player1.
# Argument: nil
# Return: nil
# Datum: 2025-04-14
# Namn: Hugo Romeborn och Hugo Karlsson
def walk_ways()
  room_methods = {
    "entrance" => method(:entrance),
    "room_to_the_north" => method(:room_to_the_north),
    "room_to_the_south" => method(:room_to_the_south),
    "room_to_the_east" => method(:room_to_the_east),
    "room_to_the_west" => method(:room_to_the_west),
    "room_5" => method(:room_5),
    "room_6" => method(:room_6),
    "room_7" => method(:room_7),
    "room_8" => method(:room_8),
    "room_9" => method(:room_9),
    "room_10" => method(:room_10),
    "room_11" => method(:room_11),
    "room_12" => method(:room_12),
    "room_13" => method(:room_13),
    "room_14" => method(:room_14),
    "room_15" => method(:room_15),
    "room_16" => method(:room_16)
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


# RIDDLES
def riddle_1()
  puts "Jag kan vara lång eller kort"
  puts "Jag kan rinna men inte gå"
  puts "Jag kan mätas men inte vägas"
  puts "Vad är jag?"
  puts "1. En skugga"
  puts "2. Tiden"
  puts "3. Vatten"
  answer = gets.chomp.to_i
  while answer !=1 && answer !=2 && answer !=3
    puts "Please choose a valid answer"
    puts "1. En skugga"
    puts "2. Tiden"
    puts "3. Vatten"
    answer = gets.chomp.to_i
  end
  if answer == 2
    puts "correct"
    return true
  else
    puts "wrong answer"
    return false
  end
end

def riddle_2()
  puts "Jag har nycklar men inga lås"
  puts "Jag har utrymmen men inga rum"
  puts "Du kan gå in men inte komma ut"
  puts "Vad är jag?"
  puts "(tips tänk på engelska)"
  puts "1. Ett piano"
  puts "2. En labyrint"
  puts "3. Ett tangentbord"
  answer = gets.chomp.to_i
  while answer != 1 && answer != 2 && answer != 3
    puts "Please choose a valid answer"
    puts "1. Ett piano"
    puts "2. En labyrint"
    puts "3. Ett tangentbord"
    answer = gets.chomp.to_i
  end
  if answer == 3
    puts "correct"
    return true
  else
    puts "wrong answer"
    return false
  end
end

def riddle_3()
  puts "Jag är alltid framför dig men du kan aldrig se mig"
  puts "Vad är jag?"
  puts "1. Framtiden"
  puts "2. Din skugga"
  puts "3. Din näsa"
  answer = gets.chomp.to_i
  while answer != 1 && answer != 2 && answer != 3
    puts "Please choose a valid answer"
    puts "1. Framtiden"
    puts "2. Din skugga"
    puts "3. Luften"
    answer = gets.chomp.to_i
  end
  if answer == 1
    puts "correct"
    return true
  else
    puts "wrong answer"
    return false
  end
end

def riddle_4()
  puts "Ju mer du tar bort av mig, desto större blir jag"
  puts "Vad är jag?"
  puts "1. Ett hål"
  puts "2. En skugga"
  puts "3. En eld"
  answer = gets.chomp.to_i
  while answer != 1 && answer != 2 && answer != 3
    puts "Please choose a valid answer"
    puts "1. Ett hål"
    puts "2. En skugga"
    puts "3. En eld"
    answer = gets.chomp.to_i
  end
  if answer == 1
    puts "correct"
    return true
  else
    puts "wrong answer"
    return false
  end
end

def riddle_5()
  puts "Jag har ett huvud, en fot men inga ben"
  puts "Vad är jag?"
  puts "1. En säng"
  puts "2. Ett mynt"
  puts "3. En stol"
  answer = gets.chomp.to_i
  while answer != 1 && answer != 2 && answer != 3
    puts "Please choose a valid answer"
    puts "1. En säng"
    puts "2. Ett mynt"
    puts "3. En stol"
    answer = gets.chomp.to_i
  end
  if answer == 2
    puts "correct"
    return true
  else
    puts "wrong answer"
    return false
  end
end

def riddle_6()
  puts "Jag har inga vingar men kan flyga"
  puts "Jag har inga ögon men kan gråta"
  puts "Vad är jag?"
  puts "1. En fågel"
  puts "2. Ett moln"
  puts "3. En drake"
  answer = gets.chomp.to_i
  while answer != 1 && answer != 2 && answer != 3
    puts "Please choose a valid answer"
    puts "1. En fågel"
    puts "2. Ett moln"
    puts "3. En drake"
    answer = gets.chomp.to_i
  end
  if answer == 2
    puts "correct"
    return true
  else
    puts "wrong answer"
    return false
  end
end

def riddle_7()
  puts "Jag är inte tung men ingen kan hålla mig länge"
  puts "Vad är jag?"
  puts "1. Din andedräkt"
  puts "2. En fjäder"
  puts "3. En tanke"
  answer = gets.chomp.to_i
  while answer != 1 && answer != 2 && answer != 3
    puts "Please choose a valid answer"
    puts "1. Din andedräkt"
    puts "2. En fjäder"
    puts "3. En tanke"
    answer = gets.chomp.to_i
  end
  if answer == 1
    puts "correct"
    return true
  else
    puts "wrong answer"
    return false
  end
end

def riddle_8()
  puts "Jag är svart när jag är ren och vit när jag är smutsig"
  puts "Vad är jag?"
  puts "1. En griffeltavla"
  puts "2. En skugga"
  puts "3. En spegel"
  answer = gets.chomp.to_i
  while answer != 1 && answer != 2 && answer != 3
    puts "Please choose a valid answer"
    puts "1. En griffeltavla"
    puts "2. En skugga"
    puts "3. En spegel"
    answer = gets.chomp.to_i
  end
  if answer == 1
    puts "correct"
    return true
  else
    puts "wrong answer"
    return false
  end
end


def riddle_9()
  puts "Jag har ett huvud men inga armar, jag har en spets men inget hjärta"
  puts "Vad är jag?"
  puts "1. En nål"
  puts "2. En penna"
  puts "3. En pil"
  answer = gets.chomp.to_i
  while answer != 1 && answer != 2 && answer != 3
    puts "Please choose a valid answer"
    puts "1. En nål"
    puts "2. En penna"
    puts "3. En pil"
    answer = gets.chomp.to_i
  end
  if answer == 1
    puts "correct"
    return true
  else
    puts "wrong answer"
    return false
  end
end

def riddle_10()
  puts "Jag kan fyllas men aldrig tömmas"
  puts "Vad är jag?"
  puts "1. En kalender"
  puts "2. En flaska"
  puts "3. En hjärna"
  answer = gets.chomp.to_i
  while answer != 1 && answer != 2 && answer != 3
    puts "Please choose a valid answer"
    puts "1. En kalender"
    puts "2. En flaska"
    puts "3. En hjärna"
    answer = gets.chomp.to_i
  end
  if answer == 1
    puts "correct"
    return true
  else
    puts "wrong answer"
    return false
  end
end

def riddle_11()
  puts "Jag är alltid på väg men kommer aldrig fram"
  puts "Vad är jag?"
  puts "1. En flod"
  puts "2. Tiden"
  puts "3. En bil"
  answer = gets.chomp.to_i
  while answer != 1 && answer != 2 && answer != 3
    puts "Please choose a valid answer"
    puts "1. En flod"
    puts "2. Tiden"
    puts "3. En bil"
    answer = gets.chomp.to_i
  end
  if answer == 2
    puts "correct"
    return true
  else
    puts "wrong answer"
    return false
  end
end

def riddle_12()
  puts "Jag har ett ansikte men inga ögon, armar men inga händer"
  puts "Vad är jag?"
  puts "1. En klocka"
  puts "2. En docka"
  puts "3. En spegel"
  answer = gets.chomp.to_i
  while answer != 1 && answer != 2 && answer != 3
    puts "Please choose a valid answer"
    puts "1. En klocka"
    puts "2. En docka"
    puts "3. En spegel"
    answer = gets.chomp.to_i
  end
  if answer == 1
    puts "correct"
    return true
  else
    puts "wrong answer"
    return false
  end
end


$riddles = {
  "1" => method(:riddle_1),
  "2" => method(:riddle_2),
  "3" => method(:riddle_3),
  "4" => method(:riddle_4),
  "5" => method(:riddle_5),
  "6" => method(:riddle_6),
  "7" => method(:riddle_7),
  "8" => method(:riddle_8),
  "9" => method(:riddle_9),
  "10" => method(:riddle_10),
  "11" => method(:riddle_11),
  "12" => method(:riddle_12)
}


#starta spelet
puts "Welcome to the game"
$player1 = Player.new()
walk_ways()


