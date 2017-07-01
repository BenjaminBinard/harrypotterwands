local table_form="size[8,7]"..
"background[8,7;1,1;fond.jpg;true]"..
"list[current_player;main;0,3;8,4;]"..
"list[context;src;1,1;1,1;starting_item_index]"..
"list[context;energy;2,1;1,1;]"..
"list[context;dst;6,1;1,1;]"..
"image_button[4,1;1,1;hogwarts.png;btn;Search]"..
"image[1,0;1,1;default_book_written.png^[colorize:#3A1355:120]".. --test
"image[2,0;1,1;default_mese_crystal.png]"..
"listcolors[#AA8539;#D4B26A;#553900]"..
"image[3,1;1,1;harrypotterwands_arrow.png]"..
"image[5,1;1,1;harrypotterwands_arrow.png]"
 

minetest.register_node("harrypotterwands:table", {
	description = "Desk for magic reaserch",
	drawtype = "mesh",
	mesh = "table1.obj",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2},
	--can_dig = function(pos, player)
		--harrypotterwands_dig(pos)
	--end,
	on_construct = function(pos)
		harrypotterwands_construct(pos)
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		harrypotterwands_fields(pos, _, fields, sender)
	end,
})

function harrypotterwands_construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("infotext", "Searching table for magic")
	minetest.get_meta(pos):set_string("formspec", table_form)

	local inv = meta:get_inventory()
	inv:set_size("src", 1)
	inv:set_size("energy", 1)
	inv:set_size("dst", 1)
end

function harrypotterwands_dig(pos)
	local inv = minetest.get_meta(pos):get_inventory()
	return inv:is_empty("src") and inv:is_empty("energy") and inv:is_empty("dst")
end

function harrypotterwands_fields(pos, _, fields, player)
	if fields.quit then return end
	local inv = minetest.get_meta(pos):get_inventory()
	local src = inv:get_stack("src", 1)
	local energy = inv:get_stack("energy", 1)
	local dst = inv:get_stack("dst", 1)
	local choosen_book

	if energy:get_name()=="default:mese_crystal" and src:get_name()=="harrypotterwands:basic_book" then
		choosen_book=choose_book(player)

		dst:add_item(choosen_book)
		inv:set_stack("dst", 1, dst)

		src:take_item()
		inv:set_stack("src", 1, src)

		energy:take_item()
		inv:set_stack("energy", 1, energy)

	end
end
