class Player

	#########################
	# Player Initialization #
	#########################

	# Initialize instance variables.
	def initialize
		@prv_health			= 20			# What was my previous health?
		@cur_health			=	20			# What is my current health?
	end

	# List of possible warrior actions.
	Actions = [:check_health,
						 :attack_monster,
						 :move_warrior]

	###########################
	# Pre and Post Processing #
	###########################

	# Understand environment prior to taking action.
	def pre_sense
  	# Reset warrior action from previous turn.
		@action_taken		= false

		# Determine health and surroundings.
		@space_empty		= @warrior.feel.empty?
		@cur_health			= @warrior.health

		# Determine combat state.
		@in_combat 			= in_combat?
	end

	# Perform state analysis for net turn.
	def post_sense
		@prv_health			= @warrior.health
	end

	##################
	# Action Methods #
	##################

	def check_health
		if (@cur_health < 15) && (@in_combat == :no)
			@warrior.rest!
			@action_taken = true
		end
	end

	def attack_monster
		case @in_combat
		when :near							# Enemy is adjacent.
			@warrior.attack!
			@action_taken = true
		when :far								# Walk to enemy.
			@warrior.walk!
			@action_taken = true
		end
	end

	def move_warrior
		@warrior.walk!
	end

	##################
	# Helper Methods #
	##################

	# Did I lose health from last turn to this one?
	def lost_health?
		(@cur_health - @prv_health) < 0 ? true : false
	end

	# Am I in combat? If so, what "kind" of combat?
	def in_combat?
		combat_state = :no

		combat_state = :near if (@space_empty == false)
		combat_state = :far	 if (@space_empty == true) && (lost_health? == true)
		
		combat_state
	end

	#####################
	# Logic for Actions #
	#####################

	def perform_action
		Actions.each do |action|
			send action
			break if @action_taken == true
		end
	end

	####################
	# Play Turn Method #
	####################

	def take_turn
		pre_sense				# Gather information on environment.
		perform_action	# Perform action based on known items.
		post_sense			# Store state of warrior for next turn.
	end

  def play_turn(warrior)
  	# Allow warrior to be accessed in all sections.
  	@warrior = warrior

  	# Take turn for the warrior.
  	take_turn
  end

end