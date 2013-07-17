class Player

	#########################
	# Player Initialization #
	#########################

	def initialize
		@action_taken = false		# Did I take my action?
		@in_combat		= false		# Am I in combat?
	end

	##################
	# Helper Methods #
	##################

	def sense_environment(warrior)
		@action_taken	= false		# Reset environment.

		# No longer in combat.
		@in_combat = false if (warrior.feel.empty? == true)
	end

	def check_health(warrior)
		
		if (warrior.health < 15) && (@in_combat == false)
			warrior.rest!
			@action_taken = true
		end

	end

	def attack_monster(warrior)
		
		if (warrior.feel.empty? == false)
			warrior.attack!

			@action_taken = true
			@in_combat 		= true
		else
			@in_combat			= false
		end

	end

	def move_warrior(warrior)
		warrior.walk! if @action_taken == false
		@action_taken = true
	end

	####################
	# Play Turn Method #
	####################

  def play_turn(warrior)

  	# Sense environment for clues.
  	sense_environment(warrior)

  	# Check health of the warrior.
  	check_health(warrior)

  	# Attack monster if present.
  	attack_monster(warrior)

  	# Move warrior in a specific direction.
  	move_warrior(warrior)

  end

end