/datum/modifier/eletricalsurge //grub
	name = "Eletrical Surge"
	desc = "You are filled with an overwhelming energy."

	on_created_text = "<span class='critical'>You feel an overwhelimg energy surge through your body!</span>"
	on_expired_text = "<span class='notice'>The surge subsides.</span>"
	stacks = MODIFIER_STACK_EXTEND
	evasion = 20
	accuracy = -30
	attack_speed_percent = 0.75
	siemens_coefficient = 3

/datum/modifier/healingtide //carp
	name = "Healing Tide"
	desc = "You are filled with an overwhelming energy."

	on_created_text = "<span class='critical'>Your body begins to focus on recovering!</span>"
	on_expired_text = "<span class='notice'>The healing subsides.</span>"
	stacks = MODIFIER_STACK_EXTEND

	metabolism_percent = 0.5
	incoming_healing_percent = 1.25

/datum/modifier/radiationhide //deathclaw
	name = "Radiation Hide"
	desc = "Your body defensivly warps."

	on_created_text = "<span class='critical'>Your body strangly mutates!</span>"
	on_expired_text = "<span class='notice'>Your body returns to normal.</span>"
	stacks = MODIFIER_STACK_EXTEND

	icon_scale_x_percent = 1.2
	icon_scale_y_percent = 1.2
	incoming_clone_damage_percent = 0
	incoming_healing_percent = 0.5
	max_health_percent = 1.5
	incoming_damage_percent = 0.9

/datum/modifier/nervoushigh //meteroid
	name = "Nervous High"
	desc = "Your senses feel everything."

	client_color = "#808080" //Za worldo

	on_created_text = "<span class='critical'>The world arounds you slows down!</span>"
	on_expired_text = "<span class='notice'>The world returns to normal.</span>"
	stacks = MODIFIER_STACK_EXTEND

	slowdown = -3
	attack_speed_percent = 0.25
	bleeding_rate_percent = 3.0
	metabolism_percent = 3.0
	max_health_percent = 0.25
	disable_duration_percent = 0.1

/datum/modifier/protectivenumbing //spider
	name = "Protective Numbing"
	desc = "Your senses feel everything."

	on_created_text = "<span class='critical'>Your body becomes numb!</span>"
	on_expired_text = "<span class='notice'>Sensation returns to your body.</span>"
	stacks = MODIFIER_STACK_EXTEND

	heat_protection = 1
	cold_protection = 1
	attack_speed_percent = 1.25