def walk_ways()
  while player1.room != "win"
    if player1.room == "entrance"
      player1.room = entrance()
    elsif player1.room == "room_to_the_north"
      player1.room = room_to_the_north()
    elsif player1.room == "room_to_the_south"
      player1.room = room_to_the_south()
    elsif player1.room == "room_to_the_east"
      player1.room = room_to_the_east()
    elsif player1.room == "room_to_the_west"
      player1.room = room_to_the_west()
    end
  end
  puts "Congratulations!"
  puts "You have won the game!"
end