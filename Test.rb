class Person 
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
      
      @age = gets.chomp.to_i
      while @age < 0 || @age > 100
        puts "Please provide a valid age!"
        puts "The valid ages are: 0-100"
        @age = gets.chomp.to_i
      end
      @race = gets.chomp.downcase.to_s
      while !@races.include?(@race)
        puts "Please provide a valid race!"
        puts "The valid races are: #{@races}"
        @race = gets.chomp.downcase.to_s
      end
      @klass = gets.chomp.downcase.to_s
      while !@klasser.include?(@klass)
        puts "Please provide a valid class!"
        puts "The valid classes are: #{@klasser}"
        @klass = gets.chomp.downcase.to_s
      end
      @health = 100
      @inventory = [["sword"], ["bow"], ["milk_bucket"], ["gold"]]   #will fill up eventually
    end
    
    save("entrance") #autosave
    puts "autosave"
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
end





puts "Welcome to the game"
hugo = Person.new()