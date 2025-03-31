#TBA


#character 
class person 
  def initialize(name, age, race, klass )
    @weapons = []
    @tools = []
    @food = []
    @armor = []
    @potions = ["Milk_bucket"]
    @misc = []
    @klasser = ["knight", "peseant", "chinese boy","herbert"]
    @race = ["orc","warewolf","dwarf","elf","human"]

    if name.class != string
      raise "your name needs to be a string"
    end 
    if age.class != integer && age.class != float
      raise "please provide an integer (number)"
    end
    if race.class != string
      raise "please provide a string"
    end
    if klass.class != options
      raise "please select a class from the options"
    end

    

    @name = name
    @age = age
    @race = race
    @klass = klass
    @health = 100
    @inventory = [[], [], [], [], [], []]   #will fill up eventually
  end

  def save()
    #write to file
  end 

  def load()
    #load from file

  end
  
  def pick_up(item)
    if @weapons.contains?(item)
      @inventory[0] << (item)
    elsif @tools.contains?(item)
      @inventory[1] << (item)
    elsif @food.contains?(item)
      @inventory[2] << (item)
    elsif @armor.contains?(item)
      @inventory[3] << (item)
    elsif @potions.contains?(item)
      @inventory[4] << (item)
    else
      @inventory[5] << (item)
    end
  end

  def drop(item)
    if @weapons.contains?(item)
      @inventory[0].delete(item)
    elsif @tools.contains?(item)
      @inventory[1].delete(item)
    elsif @food.contains?(item)
      @inventory[2].delete(item)
    elsif @armor.contains?(item)
      @inventory[3].delete(item)
    elsif @potions.contains?(item)
      @inventory[4].delete(item)
    else
      @inventory[5].delete(item)
    end
  end

    
end


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
 ()end

def room_to_the_north()
  puts "You have entered the room to the north"
end

def room_to_the_west()
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

end

def room_to_the_south()
  puts "You have entered the room to the south"
  puts "you die"
end

def room_to_the_east()
  puts "You have entered the room to the east"
end