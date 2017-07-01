local wand_chooser="size[8,5]"..
"background[8,5;1,1;harrypotterwands_background.png;true]"..
"label[0,0;Please select your wand :]"..
"image[0,1;2,2;HollyWand.png]"..
"image[2,1;2,2;ElderWand2.png]"..
"image[4,1;2,2;IvyWand.png]"..
"image[6,1;2,2;RowanWand.png]"..
"image_button_exit[6,3;2,2;gryffondor_logo.png;btn1;choose]"..
"image_button_exit[4,3;2,2;ravenclaw_logo.png;btn2;choose]"..
"image_button_exit[2,3;2,2;slitherin_logo.png;btn3;choose]"..
"image_button_exit[0,3;2,2;hufflepuff_logo.png;btn4;choose]"

 
minetest.register_on_newplayer(function(player)
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	minetest.show_formspec(name, "wand_selector", wand_chooser)
end)


minetest.register_on_player_receive_fields(function(player, formname, fields)
	local name = player:get_player_name()
  local choosen_wand
	if fields.btn4 then
    choosen_wand="harrypotterwands:hollywand"
	end
  if fields.btn3 then
    choosen_wand="harrypotterwands:elderwand"
  end
  if fields.btn2 then
    choosen_wand="harrypotterwands:ivywand"
  end
	if fields.btn1 then
		choosen_wand="harrypotterwands:rowanwand"
	end
	player:get_inventory():add_item('main', choosen_wand)
end)

minetest.register_craftitem("harrypotterwands:hollywand", {
	description = "Baguette de Harry Potter",
	inventory_image = "HollyWand.png",
	wield_scale = {x =1.5, y =1.5, z = 1},
	stack_max = 1,
  on_use = function(itemstack, player, pointed_thing)
		set_spells(player, pointed_thing, "left")
  end,
	on_place = function(itemstack, placer, pointed_thing)
		set_spells(placer, pointed_thing, "right")
	end,
})

minetest.register_craftitem("harrypotterwands:elderwand", {
	description = "Baguette de Sureau",
	inventory_image = "ElderWand2.png",
	wield_scale = {x =1.5, y =1.5, z = 1},
	stack_max = 1,
	on_use = function(itemstack, player, pointed_thing)
		set_spells(player, pointed_thing, "left")
  end,
	on_place = function(itemstack, placer, pointed_thing)
		set_spells(placer, pointed_thing, "right")
	end,
})

minetest.register_craftitem("harrypotterwands:ivywand", {
	description = "Ivy wand",
	inventory_image = "IvyWand.png",
	stack_max = 1,
	wield_scale = {x =1.5, y =1.5, z = 1},
	on_use = function(itemstack, player, pointed_thing)
		set_spells(player, pointed_thing, "left")
  end,
	on_place = function(itemstack, placer, pointed_thing)
		set_spells(placer, pointed_thing, "right")
	end,
})

minetest.register_craftitem("harrypotterwands:rowanwand", {
	description = "Rowan wand",
	inventory_image = "RowanWand.png",
	stack_max = 1,
	wield_scale = {x =1.5, y =1.5, z = 1},
	on_use = function(itemstack, player, pointed_thing)
		set_spells(player, pointed_thing, "left")
  end,
	on_place = function(itemstack, placer, pointed_thing)
		set_spells(placer, pointed_thing, "right")
	end,
})
