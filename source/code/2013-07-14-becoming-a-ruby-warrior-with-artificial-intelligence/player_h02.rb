class Player

  def play_turn(warrior)
  	warrior.rest! if warrior.health < 15
  	warrior.feel.empty? == true ? warrior.walk! : warrior.attack!
  end

end