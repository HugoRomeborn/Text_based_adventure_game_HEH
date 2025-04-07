@klasser = ["Jakob Widebrant""knight", "peseant","magician", "alchemist", "archer", "ranger"]


if klass == "knight"
    @inventory[] << "Half_Sword"
elsif klass == "archer"
    @inventory[1] << "Short_bow"
elsif klass == "Jakob Widebrant"
    @inventory[0] << "gamecubespiklubba"
    @inventory[0] << "lasersvärd"
elsif klass == "peasant"
    @inventory[0] << "muddy rock"
elsif klass == "alchemist"
    @inventory[3] << "setofpotions"
elsif klass == "ranger"
    @inventory[1] << "hunting_bow"
end

if klass == "knight"
    damage*=2
elsif klass == "archer"
    damage *=0.2
elsif klass == "Jakob Widebrant" 
    damage *=133.7
elsif klass == "peasant"
    damage*=1.5
elsif klass == "alchemist"
    damage *=rand(1..1.3)
elsif klass == "ranger"
    damage *= 0.4
end

