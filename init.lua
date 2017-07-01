dofile(minetest.get_modpath("harrypotterwands").."/stuff.lua")
dofile(minetest.get_modpath("harrypotterwands").."/spells.lua")
dofile(minetest.get_modpath("harrypotterwands").."/books.lua")
dofile(minetest.get_modpath("harrypotterwands").."/table.lua")

minetest.register_node("harrypotterwands:protego", {
	description = "Protego",
	drawtype = "mesh",
	mesh = "protego.obj",
	inventory_image = "default_glass.png",
	tiles = {"default_glass.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {dig_immediate = 3, not_in_creative_inventory = 1},
	pointable=false,
	on_place = function(itemstack, placer, pointed_thing)

	end,
})


minetest.register_node("harrypotterwands:light", {
	drawtype = "plantlike",
	description = "light",
	tiles = {"star.png"},
	paramtype = "light",
	light_source = 20,
	groups = {dig_immediate = 3, not_in_creative_inventory = 1},
	walkable=false,
	pointable=false,
})

minetest.register_craft({
	output = "harrypotterwands:table",
	recipe = {
		{"default:bookshelf", "default:diamond", "default:bookshelf"},
		{"default:wood", "default:wood", "default:wood"},
		{"", "default:wood", ""}
	}
})

minetest.register_craftitem("harrypotterwands:basic_book", {
	description = "Blank Spell Book",
	inventory_image = "default_book_written.png^[colorize:#3A1355:120",
})

minetest.register_craft({
	output = "harrypotterwands:phoenix_feather",
	recipe = {
		{"default:obsidian", "default:mese_crystal", "default:obsidian"},
		{"default:mese_crystal", "default:aspen_leaves", "default:mese_crystal"},
		{"default:obsidian", "default:mese_crystal", "default:obsidian"}
	}
})

minetest.register_craft({
	output = "harrypotterwands:basic_book",
	recipe = {
		{"default:diamond", "default:paper", "harrypotterwands:phoenix_feather"},
		{"default:diamond", "default:paper", ""},
		{"default:diamond", "default:paper", ""}
	}
})

minetest.register_craftitem("harrypotterwands:phoenix_feather", {
	description = "Feather of Phoenix",
	inventory_image = "feather.png",
	stack_max = 1,
})

minetest.register_abm{
	nodenames = {"harrypotterwands:light"},
	neighbors = {"air"},
	interval = 5,
	chance = 10,
	action = function(pos)
		set_particle(pos)
		minetest.set_node(pos, {name = "air"})
	end,
}

minetest.register_abm{
	nodenames = {"harrypotterwands:protego"},
	neighbors = {"air"},
	interval = 2,
	chance = 1,
	action = function(pos)
		set_particle(pos)
		minetest.set_node(pos, {name = "air"})
	end,
}
