function set_spells(player, pointed_thing, sens)
  local hand
  if sens == "right" then
    hand=1
  end
  if sens=="left" then
    hand=-1
  end
  local inv = player:get_inventory():get_stack("main",player:get_wield_index()+hand):get_name()


  if pointed_thing.type == "node" then -- On node
    local pos = pointed_thing.above
    local pos1 = pointed_thing.under
    local node_name = minetest.get_node(pos1).name
    local player_pos=player:getpos()
    if inv=="harrypotterwands:door_book" and (node_name =="doors:door_steel_a" or node_name=="doors:door_steel_b") then
      minetest.set_node(pos1, {name="doors:door_wood_b"})
      set_particle(pos1)
    end

    if inv=="harrypotterwands:door_book" and node_name =="doors:trapdoor_steel" then
      minetest.set_node(pos1, {name="doors:trapdoor"})
      set_particle(pos1)
    end

    if inv=="harrypotterwands:water_book" then
      minetest.set_node(pos, {name="default:water_source"})
      set_particle(pos1)
    end

    if inv=="harrypotterwands:fire_book" then
      minetest.set_node(pos, {name="fire:basic_flame"})
      set_particle(pos1)
    end

    if inv=="harrypotterwands:levitation_book" then
      minetest.set_node({x=pos1.x,y=pos1.y+3,z=pos1.z}, {name=node_name})
      minetest.set_node(pos1, {name="air"})
      set_particle(pos1)
    end

    if inv=="harrypotterwands:apparition_book" then
      player:setpos(pos)
      set_particle(pos1)
      minetest.sound_play("apparition", {
        pos = pos,
        max_hear_distance = 32,
        gain = 1.0,
      })
    end

    if inv=="harrypotterwands:lumos_book" then
      minetest.set_node(pos, {name="harrypotterwands:light"})
      set_particle(pos1)
    end

    if inv=="harrypotterwands:protego_book" then
      local dir = player:get_look_dir()
      minetest.chat_send_all(dir.x)
      minetest.set_node(pos, {name="harrypotterwands:protego"})
      set_particle(pos1)
    end

  end

  if pointed_thing.type == "object" then -- On object
    local pos1 = pointed_thing.ref:getpos()
    local hp_ennemi = pointed_thing.ref:get_hp()

    if inv=="harrypotterwands:stupefix_book" then
      pointed_thing.ref:set_hp(hp_ennemi-4)
      set_particle(pos1)
      return pointed_thing
    end

    if inv=="harrypotterwands:avada_book" then
      pointed_thing.ref:set_hp(hp_ennemi-20)
      minetest.chat_send_all(player:get_player_name().." use avada kadavra on "..pointed_thing.ref:get_player_name())
      set_particle(pos1)
    end

    if inv=="harrypotterwands:petrificus_book" then
      pointed_thing.ref:set_physics_override({
       speed = 0,
       jump = 0,
       gravity = 1,
       sneak = true,
       sneak_glitch = true,
      })
      set_particle(pos1)
      minetest.chat_send_player(pointed_thing.ref:get_player_name(),"You are under the Petrificus Totalus spell.")
    end

    if inv=="harrypotterwands:episkey_book" then
      pointed_thing.ref:set_hp(hp_ennemi+4)
      pointed_thing.ref:set_physics_override({
       speed = 1,
       jump = 1,
       gravity = 1,
       sneak = true,
       sneak_glitch = true,
      })
      set_particle(pos1)
    end
  end

  if pointed_thing.type=="nothing" or pointed_thing.type=="node" then
    if inv=="harrypotterwands:episkey_book" then
      player:set_hp(player:get_hp()+6)
      player:set_physics_override({
       speed = 1,
       jump = 1,
       gravity = 1,
       sneak = true,
       sneak_glitch = true,
      })
      set_particle(player:getpos())
    end
  end
end

function set_particle(pos)
	for i=1,30 do
		minetest.add_particle({
			pos = {x=pos.x+math.random(-2,2)*math.random()/2,y=pos.y+0.8+math.random(-2,2)*math.random()/2,z=pos.z+math.random(-2,2)*math.random()/2},
			vel = {x=0, y=2, z=0},
			acc = {x=0, y=-3, z=0},
			expirationtime = math.random(),
			size = math.random()+1.6,
			collisiondetection = true,
			texture="star.png"
		})
	end
	minetest.sound_play("hiss", {
	pos = pos,
	max_hear_distance = 15,
	gain = 1.0,
})
end

function choose_book(player)
  local chance = math.random(1, 11)
  local choosen_book
  local book_name
  if chance == 1 then
      choosen_book="harrypotterwands:water_book"
      book_name="Aguamenti"
  end
  if chance == 2 then
      choosen_book="harrypotterwands:fire_book"
      book_name="Incendio"
  end
  if chance == 3 then
      choosen_book="harrypotterwands:apparition_book"
      book_name="Apparition"
  end
  if chance == 4 then
      choosen_book="harrypotterwands:door_book"
      book_name="Alohomora"
  end
  if chance == 5 then
      choosen_book="harrypotterwands:levitation_book"
      book_name="Wingardium Leviosa"
  end
  if chance == 6 then
      choosen_book="harrypotterwands:avada_book"
      book_name="Avada Kadavra"
  end
  if chance == 7 then
      choosen_book="harrypotterwands:episkey_book"
      book_name="Episkey"
  end
  if chance == 8 then
      choosen_book="harrypotterwands:lumos_book"
      book_name="Lumos"
  end
  if chance == 9 then
      choosen_book="harrypotterwands:stupefix_book"
      book_name="Stupefix"
  end
  if chance == 10 then
      choosen_book="harrypotterwands:protego_book"
      book_name="Protego"
  end
  if chance == 11 then
      choosen_book="harrypotterwands:petrificus_book"
      book_name="Petrificus Totalus"
  end
  minetest.chat_send_player(player:get_player_name(),"You discovered the "..book_name.." spell.")
  return choosen_book
end
