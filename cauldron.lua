local cauldron_form="size[9,8]"..
"background[9,8;1,1;fond.jpg;true]"..
"listcolors[#AA8539;#D4B26A;#553900]"..
"list[current_player;main;0,0;4,8;]"..
"button[6,5;1,1;btn;Brew]"..
"list[context;src1;5,2;1,1;]"..
"list[context;src2;6,2;1,1;]"..
"list[context;src3;7,2;1,1;]"..
"list[context;dst;6,3;1,1;]"..
"label[5,0;Put something to brew ...]"



minetest.register_node("macusa:cauldron", {
	description = "Potion brewing",
	tiles = {"desk_text.png"},
	paramtype = "light",
	drawtype = "mesh",
	mesh = "desk.obj",
	groups = {cracky=3, stone=1},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Brewing stand")
		minetest.get_meta(pos):set_string("formspec", cauldron_form)

		local inv = meta:get_inventory()
		inv:set_size("src1", 1)
		inv:set_size("src2", 1)
		inv:set_size("src3", 1)
		inv:set_size("dst", 1)
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		brew_potion(pos, formname, fields, sender)
	end,
})

minetest.register_craftitem("macusa:phoenix_feather", {
	description = "Feather of Phoenix",
	inventory_image = "feather.png",
	stack_max = 1,
})

minetest.register_craftitem("macusa:bottle", {
	description = "Bottle empty",
	inventory_image = "bottle.png",
	stack_max = 1,
	liquids_pointable = true,
	on_place = function(itemstack, placer, pointed_thing)
		local inv = placer:get_inventory():get_stack("main",placer:get_wield_index()):get_name()
		local node_name = minetest.get_node(pointed_thing.under).name
		if node_name=="default:water_source" then
			itemstack:take_item()
			itemstack:add_item("macusa:bottle_water")
			return itemstack
		end
	end,
})

function brew_potion(pos, formname, fields, player)
	if fields.quit then return end
	local inv = minetest.get_meta(pos):get_inventory()
	local src1 = inv:get_stack("src1", 1)
	local src2 = inv:get_stack("src2", 1)
	local src3 = inv:get_stack("src3", 1)
	local src1n = inv:get_stack("src1", 1):get_name()
	local src2n = inv:get_stack("src2", 1):get_name()
	local src3n = inv:get_stack("src3", 1):get_name()
	local dst = inv:get_stack("dst", 1)

	if dst:get_name()=="macusa:bottle_water" then
		if src1n=="default:junglegrass" and src2n=="default:cactus" and src3n=="default:apple" then
			dst:replace("macusa:potion1")
		end
		if src1n=="flowers:mushroom_brown" and src2n=="default:cactus" and src3n=="default:apple" then
			dst:replace("macusa:potion1")
		end
		src1:take_item()
		src2:take_item()
		src3:take_item()
		inv:set_stack("src1", 1, src1)
		inv:set_stack("src2", 1, src2)
		inv:set_stack("src3", 1, src3)
		inv:set_stack("dst", 1, dst)
	end
end
