# Define Gustaf as a hash
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

def room_to_the_south()
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
      puts "You attack #{gustaf[:name]} with your melee weapon!"
      damage_dealt = $player1.melee_attack(weapon, gustaf)
      damage_dealt = [damage_dealt - gustaf[:armor], 1].max # Armor reduces damage
      gustaf[:health] -= damage_dealt
      puts "#{gustaf[:name]} takes #{damage_dealt} damage! (#{gustaf[:health]}/#{gustaf[:max_health]} HP remaining)"
      
      # Check if Gustaf is defeated
      if gustaf[:health] <= 0
        gustaf[:alive] = false
        next # Skip enemy attack if dead
      end
      
    when "potion"
      use_potion
    end
    
    # Gustaf attacks back if still alive
    if gustaf[:alive]
      puts "#{gustaf[:name]} swings his #{gustaf[:weapon]} at you!"
      player_damage = [gustaf[:attack] - $player1.armor, 1].max
      $player1.health -= player_damage
      puts "You take #{player_damage} damage! (#{$player1.health}/#{$player1.max_health} HP remaining)"
    end
  end
  
  # Battle conclusion
  if $player1.health <= 0
    puts "\nYou have been slain by #{gustaf[:name]}!"
    puts "Game Over"
  else
    puts "\nYou have defeated #{gustaf[:name]}!"
    puts "You pick up his #{gustaf[:weapon]} and add it to your inventory"
    $player1.add_to_inventory(gustaf[:weapon])
  end
end