--[[TODO
Abihu flame effects

viridian check sprite

unbidden familiars aura attack

active items wisp checks

check dice bombs/ sticky bombs (ExplosionEffect)

Pandora's Jar - purple jar
"Deceptive expectations"
2 charge.
66% chance to add random wisp. (100% after all curses was added)
33% chance to add special curse for level
--]]
--[[
<curses>
	<curse name="Curse of the Fool!" />
	<curse name="Curse of the Magician!" />
	<curse name="Curse of Carrion!" />
	<curse name="Curse of the Emperor!" />
	<curse name="Curse of the Ghost!" />
	<curse name="Curse of the Chariot!" />
	<curse name="Curse of the Envy!" />
	<curse name="Curse of Misfortune!" />
	<curse name="Curse of Champions!" />
	<curse name="Curse of the Keeper!" />
	<curse name="Curse of the Reaper!" />
	<curse name="Curse of the Jamming!" />
	<curse name="Curse of the Bell!" />
	<curse name="Curse of the Warden!" />
	<curse name="Curse of Secrets!" />
	<curse name="Curse of the Wisps!" />
	<curse name="Curse of the Void!" />
	<!--
	<curse name="Curse of the High Priestess!" />
	<curse name="Curse of the Lovers!" />
	<curse name="Curse of Justice!" />
	<curse name="Curse of Devil!" />
	<curse name="Curse of the Sun!" />
	-->
</curses>
--]]

do
	mod.Curses.Fool = Isaac.GetCurseIdByName("Curse of the Fool!") -- 16% chance to respawn enemies in cleared room, can't close doors (except boss)
	mod.Curses.Magician = Isaac.GetCurseIdByName("Curse of the Magician!") -- 100% homing enemy tears (except boss)
	mod.Curses.Carrion = Isaac.GetCurseIdByName("Curse of Carrion!") -- 100% turn all normal poops into red
	mod.Curses.Emperor = Isaac.GetCurseIdByName("Curse of the Emperor!") --100% no exit door from boss room
	mod.Curses.Ghost = Isaac.GetCurseIdByName("Curse of the Ghost!") --100% chance to turn you into soul after taking non-self damage
	mod.Curses.Chariot = Isaac.GetCurseIdByName("Curse of the Chariot!") --100% slippery ground
	mod.Curses.Envy = Isaac.GetCurseIdByName("Curse of the Envy!") --100% other shop items disappear when you buy one
	mod.Curses.Misfortune = Isaac.GetCurseIdByName("Curse of Misfortune!") --100% luck down, -5 luck
	mod.Curses.Strength = Isaac.GetCurseIdByName("Curse of Champions!") -- 100% turn enemies into champions (except boss)
	mod.Curses.Keeper = Isaac.GetCurseIdByName("Curse of the Keeper!") -- 100% turn shopkeepers into greed enemies
	mod.Curses.Reaper = Isaac.GetCurseIdByName("Curse of the Reaper!") --100% spawn death's scythe after 1 min on floor, it will follow you, kills you if touched, deal damage to enemies
	mod.Curses.Jamming = Isaac.GetCurseIdByName("Curse of the Jamming!") --16% chance to respawn enemies after clearing room (except boss)
	mod.Curses.Bell = Isaac.GetCurseIdByName("Curse of the Bell!") --100% turn troll bombs into golden troll bombs
	mod.Curses.Warden = Isaac.GetCurseIdByName("Curse of the Warden!") --100% all locked doors need 2 keys
	mod.Curses.Secrets = Isaac.GetCurseIdByName("Curse of Secrets!") --100% close secret doors after leaving secret room
	mod.Curses.Wisps = Isaac.GetCurseIdByName("Curse of the Wisps!") --16% chance to turn item into wisp item when you try to pick it up
	mod.Curses.Void = Isaac.GetCurseIdByName("Curse of the Void!") --16% chance to reroll enemies and grid. 100% on void stage
end


mod.Items.Eclipse = Isaac.GetItemIdByName("Eclipse") -- "Darkest Basement" grants aura dealing 2 damage. boost player damage if you have curse of darkness
mod.Items.PandoraJar = Isaac.GetItemIdByName("Pandora's Jar") -- "Deceptive expectations". 2 charge. 70% chance to add random wisp. 25% chance to add special curse for level. 5% chance to become unusable on current level

mod.PandoraJar = {}
mod.PandoraJar.ItemWispChance = 0.33
mod.PandoraJar.CurseChance = 0.2
mod.PandoraJar.Curses = {}



if EID then
	EID:addCollectible(mod.Items.PandoraJar,
		"Add random wisp. #33% chance to add curse when used.")
end


local function PandoraJarManager(currentCurses)
	local level = game:GetLevel()
	currentCurses = currentCurses or level:GetCurses()
	mod.PandoraJar.Curses = {}
	for _, curse in pairs(mod.Curses) do
		if currentCurses & curse == 0 then
			table.insert(mod.PandoraJar.Curses, curse)
		end
	end
end

function mod:onCurseEval(curseFlags)

	PandoraJarManager(curseFlags)
	return curseFlags
end
mod:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, mod.onCurseEval)

---Pandora's Jar
function mod:onPandoraJar(_, rng, player) --item, rng, player, useFlag, activeSlot, customVarData
	local data = player:GetData()
	local randNum = rng:RandomFloat()

	if randNum <= mod.PandoraJar.CurseChance and #mod.PandoraJar.Curses > 0 then
		local curseNum = #mod.PandoraJar.Curses
		local level = game:GetLevel()
		local currentCurses = level:GetCurses()
		local randIndex = rng:RandomInt(curseNum)+1
		local addCurse = mod.PandoraJar.Curses[randIndex]
		while currentCurses & addCurse > 0 do
			randIndex = rng:RandomInt(curseNum)+1
			addCurse = mod.PandoraJar.Curses[randIndex]
		end
		table.remove(mod.PandoraJar.Curses, randIndex)
		level:AddCurse(addCurse, true)
	end

	local allItems = Isaac.GetItemConfig():GetCollectibles().Size - 1
	local pos = player.Position
	local item = rng:RandomInt(allItems)+1
	if randNum > mod.PandoraJar.ItemWispChance then
		player:AddWisp(item, pos)
	else
		player:AddItemWisp(item, pos)
	end

end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onPandoraJar, mod.Items.PandoraJar)




local function modDataLoad()
	if mod:HasData() then
		local localtable = json.decode(mod:LoadData())
		savetable.FloppyDiskItems = localtable.FloppyDiskItems
		savetable.NadabCompletionMarks = localtable.NadabCompletionMarks
		savetable.AbihuCompletionMarks = localtable.AbihuCompletionMarks
		savetable.UnbiddenCompletionMarks = localtable.UnbiddenCompletionMarks
		savetable.ObliviousCompletionMarks = localtable.ObliviousCompletionMarks
		savetable.HasItemBirthright = localtable.HasItemBirthright
		savetable.VoidCurseBackdrop = localtable.VoidCurseBackdrop
	else
		savetable.FloppyDiskItems = savetable.FloppyDiskItems or {}
		savetable.NadabCompletionMarks = savetable.NadabCompletionMarks or {0,0,0,0,0,0,0,0,0,0,0,0,0}
		savetable.AbihuCompletionMarks = savetable.AbihuCompletionMarks or {0,0,0,0,0,0,0,0,0,0,0,0,0}
		savetable.UnbiddenCompletionMarks = savetable.UnbiddenCompletionMarks or {0,0,0,0,0,0,0,0,0,0,0,0,0}
		savetable.ObliviousCompletionMarks = savetable.ObliviousCompletionMarks or {0,0,0,0,0,0,0,0,0,0,0,0,0}
		savetable.HasItemBirthright = savetable.HasItemBirthright or {}
		savetable.VoidCurseBackdrop = {}
	end
end

function mod:onNewLevel()
	if savetable.VoidCurseBackdrop and #savetable.VoidCurseBackdrop > 0 then
		savetable.VoidCurseBackdrop = {}
		modDataSave()
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.onNewLevel)

function mod:onNewRoom()
	local room = game:GetRoom()
 	local level = game:GetLevel()

	--Void curse
	if level:GetCurses() & mod.Curses.Void > 0 then
		if not savetable.VoidCurseBackdrop then modDataLoad() end
		if room:IsClear() then
			if #savetable.VoidCurseBackdrop > 0 then
				for _, savedBackdrop in pairs(savetable.VoidCurseBackdrop) do
					if level:GetCurrentRoomIndex() == savedBackdrop[1] then
						game:ShowHallucination(0, savedBackdrop[2])
					end
				end
			end
		elseif modRNG:RandomFloat() < mod.VoidThreshold then
			mod.VoidCurseReroll = 0
			game:ShowHallucination(0, BackdropType.NUM_BACKDROPS)
			game:GetPlayer(0):UseActiveItem(CollectibleType.COLLECTIBLE_D12, myUseFlags)

			table.insert(savetable.VoidCurseBackdrop, {level:GetCurrentRoomIndex(), room:GetBackdropType()})
			modDataSave()
		end

	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.onNewRoom)



function mod:onFamInit()

end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.onFamInit, mod.Eyekey.FamVariant)

function mod:onFamUpdate()

end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.onFamUpdate, mod.Eyekey.FamVariant)

--[[

	<familiar id="51" quality="2" craftquality="3" description="Giga bomb generator" gfx="lilgagger.png" name="Lil Gagger" cache="familiars" />

	<active id="50" quality="1" craftquality="3" description="Chest friend" gfx="Eyekey.png" name="Eyekey" maxcharges="1" cache="familiars" tags="uniquefamiliar"/>

	<!-- FAMILIARS -->
	<entity
		anm2path="Chester.anm2"
		baseHP="0"
		boss="0"
		champion="0"
		collisionDamage="0"
		collisionMass="0"
		collisionRadius="13"
		friction="1"
		id="3"
		name="Chester"
		numGridCollisionPoints="12"
		shadowSize="11"
		stageHP="0"
		variant="91285">
       	 <gibs amount="0" blood="0" bone="0" eye="0" gut="0" large="0" />
	</entity>

	-- VARIANT
	<entity anm2path="SpaceTear.anm2" baseHP="0" boss="0" champion="0" collisionDamage="0" collisionMass="8" collisionRadius="7" friction="1" id="2" name="Unbidden Space Tear" numGridCollisionPoints="8" shadowSize="8" stageHP="0" >
        <gibs amount="0" blood="0" bone="0" eye="0" gut="0" large="0" />
    </entity>

	-- SUBTYPE
	<entity anm2path="WaxHeart.anm2" baseHP="0" boss="0" champion="0" collisionDamage="0" collisionMass="3" collisionRadius="12" friction="1" id="5" name="Wax Heart" numGridCollisionPoints="24" shadowSize="17" stageHP="0" variant="10">
	    <gibs amount="0" blood="0" bone="0" eye="0" gut="0" large="0" />
	</entity>
--]]

