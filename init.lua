dofile(minetest.get_modpath("macusa").."/stuff.lua")
dofile(minetest.get_modpath("macusa").."/spells.lua")
dofile(minetest.get_modpath("macusa").."/books.lua")
dofile(minetest.get_modpath("macusa").."/cauldron.lua")
dofile(minetest.get_modpath("macusa").."/table.lua")
dofile(minetest.get_modpath("macusa").."/potion.lua")

minetest.register_node("macusa:protego", {
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


minetest.register_node("macusa:light", {
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
	output = "macusa:table",
	recipe = {
		{"default:bookshelf", "default:book", "default:bookshelf"},
		{"default:diamond", "stairs:slab_wood", "default:diamond"},
		{"default:wood", "", "default:wood"}
	}
})

minetest.register_craftitem("macusa:basic_book", {
	description = "Blank Spell Book",
	inventory_image = "default_book_written.png^[colorize:#3A1355:120",
})

minetest.register_craft({
	output = "macusa:phoenix_feather",
	recipe = {
		{"default:obsidian", "default:mese_crystal", "default:obsidian"},
		{"default:mese_crystal", "default:aspen_leaves", "default:mese_crystal"},
		{"default:obsidian", "default:mese_crystal", "default:obsidian"}
	}
})

minetest.register_craft({
	output = "macusa:basic_book",
	recipe = {
		{"default:diamond", "default:paper", "macusa:phoenix_feather"},
		{"default:diamond", "default:paper", ""},
		{"default:diamond", "default:paper", ""}
	}
})

minetest.register_abm{
	nodenames = {"macusa:light"},
	neighbors = {"air"},
	interval = 5,
	chance = 10,
	action = function(pos)
		set_particle(pos)
		minetest.set_node(pos, {name = "air"})
	end,
}

minetest.register_abm{
	nodenames = {"macusa:protego"},
	neighbors = {"air"},
	interval = 2,
	chance = 1,
	action = function(pos)
		set_particle(pos)
		minetest.set_node(pos, {name = "air"})
	end,
}
