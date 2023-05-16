//Silicon Swoopies!
/mob/living/silicon/robot/swoopie
	icon = 'modular_chomp/icons/mob/swoopie/swoopie.dmi'
	icon_state = "swoopie"
	vis_height = 64
	modtype = "swoopie"
	lawupdate = 0
	pixel_x = -16
	old_x = -16
	default_pixel_x = -16

/mob/living/silicon/robot/swoopie/New()
	if(!cell)
		cell = new /obj/item/weapon/cell/hyper(src) // For storing all the power produced from churning all that junk!
		cell.charge = 10000 // But also starting at a low capacity
	..()

/mob/living/silicon/robot/swoopie/init()
	aiCamera = new/obj/item/device/camera/siliconcam/robot_camera(src)

	mmi = new /obj/item/device/mmi/digital/robot(src) //Simple dronebirbs
	module = new /obj/item/weapon/robot_module/robot/swoopie(src)
	cut_overlays()
	init_id()

	updatename("SWOOPIE XL")

/obj/item/weapon/robot_module/robot/swoopie
	name = "SWOOPIE XL Module"
	channels = "Service"
	sprites = list(
		"Swoopie" = "swoopie"
	)

	can_be_pushed = 0

/obj/item/weapon/robot_module/robot/swoopie/New(var/mob/living/silicon/robot/R)
	src.modules += new /obj/item/device/flash(src)
	src.modules += new /obj/item/device/vac_attachment/swoopie(src)
	src.modules += new /obj/item/weapon/storage/bag/trash(src)
	src.modules += new /obj/item/device/lightreplacer(src)

	R.icon = 'modular_chomp/icons/mob/swoopie/swoopie.dmi'
	R.wideborg_dept = 'modular_chomp/icons/mob/swoopie/swoopie.dmi'
	R.hands.icon = 'icons/mob/screen1_robot_vr.dmi'
	R.vis_height = 64
	R.icon_state = "swoopie"
	R.ui_style_vr = TRUE
	R.pixel_x = -16
	R.old_x = -16
	R.default_pixel_x = -16
	pto_type = PTO_CIVILIAN
	R.vore_capacity_ex = list("stomach" = 1, "neck1" = 1, "neck2" = 1, "neck3" = 1, "neck4" = 1)
	R.vore_fullness_ex = list("stomach" = 0, "neck1" = 0, "neck2" = 0, "neck3" = 0, "neck4" = 0)
	R.vore_icon_bellies = list("stomach", "neck1", "neck2", "neck3", "neck4")
	R.dogborg = TRUE
	R.wideborg = TRUE
	R.verbs |= /mob/living/silicon/robot/proc/ex_reserve_refill
	R.verbs |= /mob/living/silicon/robot/proc/robot_mount
	R.verbs |= /mob/living/proc/toggle_rider_reins
	R.verbs |= /mob/living/proc/shred_limb
	R.verbs |= /mob/living/silicon/robot/proc/rest_style
	R.adminbus_trash = TRUE // Incase the vaccum gets nerfed or something needs this

/mob/living/silicon/robot/swoopie/speech_bubble_appearance()
	return "synthetic_evil"

/mob/living/silicon/robot/swoopie/init_vore()
	/* Copied from simplemob swoopies. Apparently doesnt exist in not simplemobs
	if(!voremob_loaded)
		return
	*/
	verbs |= /mob/living/proc/eat_trash
	verbs |= /mob/living/proc/toggle_trash_catching
	verbs |= /mob/living/proc/restrict_trasheater
	var/obj/belly/B = new /obj/belly/(src)
	B.affects_vore_sprites = TRUE
	B.belly_sprite_to_affect = "stomach"
	B.name = "Churno-Vac"
	B.desc = "With an abrupt loud WHUMP after a very sucky trip through the hungry bot's vacuum tube, you finally spill out into its waste container, where everything the bot slurps off the floors ends up for swift processing among the caustic sludge, efficiently melting everything down into a thin slurry to fuel its form. More loose dirt and debris occasionally raining in from above as the bot carries on with its duties to keep the station nice and clean."
	B.digest_messages_prey = list("Under the heat and internal pressure of the greedy machine's gutworks, you can feel the tides of the hot caustic sludge claiming the last bits of space around your body, a few more squeezes of the synthetic muscles squelching and glurking as your body finally loses its form, completely blending down and merging into the tingly sludge to fuel the mean machine.")
	B.digest_mode = DM_DIGEST
	B.item_digest_mode = IM_DIGEST
	B.digest_burn = 3
	B.fancy_vore = 1
	B.vore_sound = "Stomach Move"
	B.belly_fullscreen = "VBO_trash"
	B.belly_fullscreen_color = "#555B34"
	B.sound_volume = 25
	B.count_items_for_sprite = TRUE

	B = new /obj/belly/longneck/(src)
	B.affects_vore_sprites = TRUE
	B.belly_sprite_to_affect = "neck4"
	B.name = "vacuum hose 4"
	B.autotransferlocation = "Churno-Vac"
	B.desc = "Thank you for your biofuel contribution~"
	B.fancy_vore = 1
	B.vore_sound = "Stomach Move"
	B.sound_volume = 20

	B = new /obj/belly/longneck/(src)
	B.affects_vore_sprites = TRUE
	B.belly_sprite_to_affect = "neck3"
	B.name = "vacuum hose 3"
	B.autotransferlocation = "vacuum hose 4"
	B.desc = "Looks like it's gonna be all downhill from here..."
	B.fancy_vore = 1
	B.vore_sound = "Stomach Move"
	B.sound_volume = 40

	B = new /obj/belly/longneck/(src)
	B.affects_vore_sprites = TRUE
	B.belly_sprite_to_affect = "neck2"
	B.name = "vacuum hose 2"
	B.autotransferlocation = "vacuum hose 3"
	B.desc = "It feels very tight in here..."
	B.fancy_vore = 1
	B.vore_sound = "Stomach Move"
	B.sound_volume = 80

	B = new /obj/belly/longneck/(src)
	B.affects_vore_sprites = TRUE
	B.belly_sprite_to_affect = "neck1"
	B.name = "vacuum hose"
	B.autotransferlocation = "vacuum hose 2"
	B.fancy_vore = 1
	B.vore_sound = "Stomach Move"
	B.sound_volume = 100

	B = new /obj/belly/longneck(src)
	B.affects_vore_sprites = FALSE
	B.name = "Vac-Beak"
	B.desc = "SNAP! You have been sucked up into the big synthbird's beak, the powerful vacuum within the bird roaring somewhere beyond the abyssal deep gullet hungrily gaping before you, eagerly sucking you deeper inside towards a long bulgy ride down the bird's vacuum hose of a neck!"
	B.autotransferlocation = "vacuum hose"
	B.autotransfer_max_amount = 0
	B.autotransferwait = 60

	vore_selected = B

/obj/belly/longneck
	affects_vore_sprites = TRUE
	belly_sprite_to_affect = "neck1"
	name = "vacuum hose"
	desc = "With a mighty WHUMP, the suction of the big bird's ravenous vacuum system has sucked you up out of the embrace of its voracious main beak and into a tight bulge squeezing along the long ribbed rubbery tube leading towards the roaring doom of the synthetic bird's efficient waste disposal system."
	digest_mode = DM_HOLD
	item_digest_mode = IM_HOLD
	autotransfer_enabled = TRUE
	mode_flags = DM_FLAG_TURBOMODE // Replacing speedy_mob_processing
	autotransferchance = 100
	autotransferwait = 70
	autotransferlocation = "Churno-Vac"
	vore_verb = "suck"
	belly_fullscreen_color = "#4d4d4d"
	belly_fullscreen = "a_tumby"
	contaminates = FALSE
	human_prey_swallow_time = 1
	nonhuman_prey_swallow_time = 1
	autotransfer_max_amount = 2
	count_items_for_sprite = TRUE
	item_multiplier = 10
	health_impacts_size = FALSE
	//speedy_mob_processing = TRUE // Replaced by turbo mode
