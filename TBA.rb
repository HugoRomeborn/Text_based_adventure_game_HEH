#TBA, Text based adventure game 


#character 
class person 
  def initialize()
    @inventory = [[], [], [], []]
    @weapons = []
    @ranged = []
    @armor = [] #fixa sennare 
    @potions = ["milk_bucket"]
    @misc = ["gold", "silver", "bronze"]
    @klasser = ["Jakob Widebrant", "knight", "peseant", "magician", "alchemist", "archer", "ranger"]
    @races = ["orc","warewolf", "dwarf", "elf", "human"]
   
   
   
    # Kollar om spelaren har spelat tidigare 
    # om spelaren har spelat tidigare så laddar vi in deras karaktär
    # om spelaren inte har spelat tidigare så skapar vi en ny karaktär
    # och sparar den i en fil
    
    puts "Please provide your name"
    @name = gets.chomp.downcase.to_s
    directory = Dir.pwd #get current directory
    Dir.chdir("#{directory}/players") #change directory to players
    if File.exist?("#{@name}.txt")
      load()
      puts "Welcome back #{@name}!"
      puts "You are a #{@age} year old #{@race} #{@klass} with #{@health} health."
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
    end
    
    save("entrance") #autosave
    puts "autosave"
  end
  def meele_attack(weapon, enemy)
    base_damage = rand(5..10) # base damage is random between 1 and 10
    p "choose your weapon from your inventory #{weapon}"
    input = gets.chomp.downcase.to_s
    if klass == "knight"
      base_damage*=2
    elsif klass == "archer"
      base_damage *=0.2
      elsif klass == "Jakob Widebrant" 
        base_damage *=133.7
      elsif klass == "peasant"
        base_damage*=1.5
      elsif klass == "alchemist"
        base_damage *=rand(1..1.3)
      elsif klass == "ranger"
        base_damage *= 0.4
      end
    else 
      puts "unknown class. No damage modifier"  
    
    damage = base_damage * weapon - #enemy_armor?
    enemy_health = enemy.health - damage #enemy health
    if enemy_health <= 0  #enemy dead
      puts "You have killed the #{enemy}"
    end
    puts "You attack the #{enemy} with your #{weapon}!"
    puts "You deal #{damage} damage."
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
    helpstr = ""
    while i < @inventory[0].length
      helpstr << "#{@inventory[0][i]} "
      i += 1
    end
    fil.puts(helpstr)
    i = 0
    helpstr = ""
    while i < @inventory[1].length
      helpstr << "#{@inventory[1][i]} "
      i += 1
    end
    fil.puts(helpstr)
    i = 0
    helpstr = ""
    while i < @inventory[2].length
      helpstr << "#{@inventory[2][i]} "
      i += 1
    end
    fil.puts(helpstr)
    i = 0
    helpstr = ""
    while i < @inventory[3].length
      helpstr << "#{@inventory[3][i]} " 
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

    arr = lines[5].chomp.split
    @inventory[0] = arr.dup
    arr = lines[6].chomp.split
    @inventory[1] = arr.dup
    arr = lines[7].chomp.split
    @inventory[2] = arr.dup
    arr = lines[8].chomp.split
    @inventory[3] = arr.dup
  end
  
  def pick_up(item)
    if @weapons.contains?(item)
      @inventory[0] << (item)
    elsif @tools.contains?(item)
      @inventory[1] << (item)
    elsif @armor.contains?(item)
      @inventory[2] << (item)
    elsif @potions.contains?(item)
      @inventory[3] << (item)
    elsif @misc.contains?(item)
      @inventory[4] << (item)
    else 
      raise "This item does not exist"
    end
  end

  def drop(item)
    if @weapons.contains?(item)
      @inventory[0].delete(item)
    elsif @tools.contains?(item)
      @inventory[1].delete(item)
    elsif @armor.contains?(item)
      @inventory[3].delete(item)
    elsif @potions.contains?(item)
      @inventory[4].delete(item)
    else
      @inventory[5].delete(item)
    end
  end

    
end


#funktioner för alla rum i spelet //hade varit nice om de ligger i en separat fil sedan

#Rum 1
#I entrence fins the fyra olika dörrar i rummet som personen måste välja mellan.
def enterence()
  valid_room = ["the_northen_door", "the_southern_door", "the_eastern_door", "the_western_door"]
  puts "You have now entered the world of the unknown"
  puts "You are in a dark room, you can see a door to your east and a door to your west"
  puts "You can also see a door in the north and a door to the south"
  puts "You now need to chosse witch door to ennter"
  room = gets.chomp.downcase.to_s
  while valid_room.include?(room) == false
    puts "Please choose a valid door to enter"
    room = gets.chomp.downcase.to_s
    if room == "the_norhern_door"
      room_to_the_north()
    elsif
      room == "the_southern_door"
      room_to_the_south()
    elsif room == "the_eastern_door"
      room_to_the_east()
    elsif room == "the_western_door"
      room_to_the_west()
    end
  end
end

# i detta rum så finns det ett mystiskt vapen för en vilken klass som spelaren kan har valt för att spelaren ska få vapnet så måste spelaren lösa en gåta.
def room_to_the_north()
  person.save(room_to_the_north())
  puts "autosave "
  valid_answer = ["fire", "ballon", "shadow", "water", "wind"]
  puts "You have entered the room to the north"
  puts "Infront of you is a chest with a mystic weapon inside it"
  puts "to open the chest you need to solve a riddle"
  puts "The riddle is: I am not alive, but I can grow. I don't have lungs, but I need air. What am I?"  
  puts "A Fire,A Ballon,A Shadow, water or The wind"
  answer = gets.chomp.downcase.to_s
  while answer != ["fire", "ballon", "shadow", "water", "wind"]
    puts "Please provide a valid answer to the riddle"
    answer = gets.chomp.downcase.to_s
  end
  if answer == "fire" # vi behöver fixa så att det går att plocka upp vapnet
    puts "You have solved the riddle and the chest is now open"
    puts "Inside the chest you find a mystic weapon that will grant you power"
    puts "You can now pick up the weapon and add it to your inventory"
  else
    puts "You have failed to solve the riddle and the chest is now locked again"
    puts "You can try again later"
  end
  #efter rummet så behöver spelaren antingen välja ett annat rum elle skikas till ett nytt rum
end


# i detta rum fins det tre olika koppar som spelaren måste välja mellan
def room_to_the_west()
  person.save(room_to_the_west())
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
    break
  elsif cup == "left"
    puts "In the cup that you chose their was water and you can now continue playing"
  elsif cup == "right"
    puts "You have chossen wisely in the cup that you chose their was strengt potion that will grant strengt through out your jorney"
  end
end

#i detta rum mötter du en lättare boss som hets gustaf
#gustaf måste läggas in i enemy klassen och han måste ha en health och damage system
def room_to_the_south()
  gustaf.health = 120
  person.save(room_to_the_south())
  valid_attacks = ["meele","ranged"]
  puts "autosave "
  puts "You have entered the room to the south"
  while gustaf.health>0 && person.health>0
    puts "in front of you is a giant named Gustaf that has know spotted you"
    puts "chosse attack meele or ranged"
    attack = gets.chomp.strip.downcase.to_s
    while valid_attacks.include?(attack)
      puts "chosse valid attack, meele or ranged"
      attack = gets.chomp.strip.downcase.to_s
    end
    if attack == "meele"
      puts "You attack Gustaf with your meele attack"
      person.melee_attack(weapon, gustaf)
      gustaf.health -= 10 #fixa med damged system
      puts "Gustaf has now #{gustaf.health} health left"
    elsif attack == "ranged"
      puts "You attack Gustaf with your ranged attack"
      person.ranged_attack(weapon, gustaf)
      gustaf.health -= 10 #fixa med damged system
      puts "Gustaf has now #{gustaf.health} health left"
    end
  end
  if player.health <= 0
    puts "You have died and lost the game"
    puts "Game over"
    break
  elsif gustaf.health <= 0
    puts "You have killed Gustaf and won the battle"
    puts "You can now pick up his weapon and add it to your inventory"
  end
end

#I detta rum så kommer du behöva klara ett pussel/spel det kommer vara ett sten sax påse spel med försten till tre
def room_to_the_east()
  person.save(room_to_the_east())
  puts "autosave "
  puts "You have entered the room to the east"
  puts "we are going to play a game of rock paper scissors"
  puts "You have three options to choose from rock, paper or scissors"
  puts "You will play against me first to three"
  player = 0
  computer = 0
  while player < 3 && computer < 3
    rock_paper_scissors = ["rock", "paper", "scissors"]
    puts "Please choose rock, paper or scissors"
    player_choice = gets.chomp.downcase.to_s
    while rock_paper_scissors.include?(player_choice) == false
      puts "Please choose a valid option"
      player_choice = gets.chomp.downcase.to_s
    end
    computer_choice = rock_paper_scissors.sample  #random choice for computer
    puts "The computer chose #{computer_choice}"
    if player_choice == computer_choice
      puts "It's a tie!"
    elsif (player_choice == "rock" && computer_choice == "scissors") || (player_choice == "paper" && computer_choice == "rock") || (player_choice == "scissors" && computer_choice == "paper")
      puts "You win this round!"
      player += 1
    else
      puts "You lose this round!"
      computer += 1
    end
    puts "Score: You #{player} - Computer 
    #{computer}"
  end
  if player == 3
    puts "You win the game!"
    puts "You can now move on to the next room"
  elsif computer == 3
    puts "You lose the game!"
    puts "Game over"
    break
  end
end

#rum 5 boss rom the boses name is Minator he has 200 health and he is a hard boss to beat
#minator måste läggas in i enemy klassen och han måste ha en health och damage system
def Minator()
  person.save(Minator())
  puts "autosave "
  puts "you have entered the Minator layer their is onley one way out either kill the minator or die trying"
  puts "The minator has 200 health and a giant axe that deals hevy hits with devestating damaged if he hits you he does not have anny ranged attacks"
  minator.health = 200
  while minator.health>0 && person.health>0
    puts "in front of you is a giant named Minator that has know spotted you"
    puts "chosse attack meele or ranged"  
    attack = gets.chomp.strip.downcase.to_s
    while valid_attacks.include?(attack) == false
      puts "chosse valid attack, meele or ranged"
      attack = gets.chomp.strip.downcase.to_s
    end
    if attack == "meele"
      puts "You attack Minator with your meele attack"
      person.melee_attack(weapon, minator)
      minator.health -= 20 #fixa med damged system
      puts "Minator has now #{minator.health} health left"
    elsif attack == "ranged"
      puts "You attack Minator with your ranged attack"
      person.ranged_attack(weapon, minator)
      minator.health -= 20 #fixa med damged system
      puts "Minator has now #{minator.health} health left"
    end
  end
end




#starta spelet
puts "Welcome to the game"
hugo = person.new()